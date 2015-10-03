From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES RFC PATCH] Extract the bitmask of FDs set
 in select syscall
Date: Sat, 3 Oct 2015 00:04:45 +0000 (UTC)
Message-ID: <1309938044.14042.1443830685616.JavaMail.zimbra__4513.05584651909$1443830752$gmane$org@efficios.com>
References: <1443826866-24477-1-git-send-email-jdesfossez@efficios.com>
 <2061352727.14032.1443829744755.JavaMail.zimbra@efficios.com>
 <20151002235817.GD3571@sinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZiAJt-0000fc-En
 for lttng-dev@lists.lttng.org; Fri, 02 Oct 2015 20:05:01 -0400
In-Reply-To: <20151002235817.GD3571@sinkpad>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Oct 2, 2015, at 7:58 PM, Julien Desfossez jdesfossez@efficios.com wrote:

> On 02-Oct-2015 11:49:04 PM, Mathieu Desnoyers wrote:
>> ----- On Oct 2, 2015, at 7:01 PM, Julien Desfossez jdesfossez@efficios.com
>> wrote:
>> 
>> > Instead of extracting the user-space pointers of the 3 fd_set, we now
>> > extract the bitmask of the FDs in the sets (in, out, ex) in the form of
>> > an array of unsigned long (1024 FDs is the limit in the kernel).
>> > 
>> > In this example, we select in input FDs 3, 5 and 10 (0x428), it returns
>> > that one FD is ready: FD 10 (0x400).
>> > 
>> > syscall_entry_select: { n = 11,
>> >	_fdset_in_length = 1, fdset_in = [ [0] = 0x428 ],
>> >	_fdset_out_length = 1, fdset_out = [ [0] = 0x0 ],
>> >	_fdset_ex_length = 0, fdset_ex = [ ],
>> >	tvp = 0
>> > }
>> > syscall_exit_select: { ret = 1,
>> >	_fdset_in_length = 1, fdset_in = [ [0] = 0x400 ],
>> >	_fdset_out_length = 1, fdset_out = [ [0] = 0x0 ],
>> >	_fdset_ex_length = 0, fdset_ex = [ ],
>> >	tvp = 0
>> > }
>> > 
>> > Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
>> > ---
>> > .../x86-64-syscalls-3.10.0-rc7_pointers_override.h | 56 ++++++++++++++++++++++
>> > 1 file changed, 56 insertions(+)
>> > 
>> > diff --git
>> > a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
>> > b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
>> > index 702cfb5..23ffbdd 100644
>> > ---
>> > a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
>> > +++
>> > b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
>> > @@ -115,6 +115,62 @@ SC_LTTNG_TRACEPOINT_EVENT(pipe,
>> > 	)
>> > )
>> > 
>> > +#define OVERRIDE_64_select
>> > +SC_LTTNG_TRACEPOINT_EVENT_CODE(select,
>> > +	TP_PROTO(sc_exit(long ret,) int n, fd_set __user * inp, fd_set __user * outp,
>> > +		fd_set __user * exp, struct timeval * tvp),
>> > +	TP_ARGS(sc_exit(ret,) n, inp, outp, exp, tvp),
>> > +	TP_locvar(
>> > +		unsigned long fds_in[__FD_SETSIZE / (8 * sizeof(long))],
>> > +			fds_out[__FD_SETSIZE / (8 * sizeof(long))],
>> > +			fds_ex[__FD_SETSIZE / (8 * sizeof(long))];
>> 
>> I expect this to break apart on kernels with 4kB stack configuration.
>> 
>> How much stack does this use ? We might want to consider
>> temporarily allocating memory for this. This is OK since we know
>> we are in a syscall context.
> Indeed that's the main reason it is a RFC patch.
> __FD_SETSIZE == 1024, so it allocates 3 * 8 * (1024/(8*8)) = 384 bytes.
> Is it too much ?
> 
> If you prefer an alloc/free, I'll replace that.

The "free" is not necessarily easy to implement, because we could
need to add a new "TP_code_after()" which has code to be executed
after the data serialization.

384 bytes is not as bad as I initially anticipated, this could be
OK, especially since we are in a syscall context, and therefore
the kernel stack is nearly empty when we are called.

You might want to try it in a few loads on a kernel configured with
4k stacks, and with kernel hacking options to track stack overflow
and usage, just to be on the safe side.

Thanks,

Mathieu

> 
> Thanks,
> 
> Julien
> 
> 
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> > +		int nb_in, nb_out, nb_ex;
>> > +	),
>> > +	TP_code(
>> > +		sc_inout(
>> > +		{
>> > +			unsigned long nr;
>> > +			int ret;
>> > +
>> > +			nr = FDS_BYTES(n);
>> > +			tp_locvar->nb_in = 0;
>> > +			tp_locvar->nb_out = 0;
>> > +			tp_locvar->nb_ex = 0;
>> > +			if (inp) {
>> > +				ret = copy_from_user(tp_locvar->fds_in, inp, nr);
>> > +				if (ret < 0)
>> > +					goto skip_code;
>> > +				tp_locvar->nb_in = nr/sizeof(long);
>> > +			}
>> > +			if (outp) {
>> > +				ret = copy_from_user(tp_locvar->fds_out, outp, nr);
>> > +				if (ret < 0)
>> > +				goto skip_code;
>> > +				tp_locvar->nb_out = nr/sizeof(long);
>> > +			}
>> > +			if (exp) {
>> > +				ret = copy_from_user(tp_locvar->fds_ex, exp, nr);
>> > +				if (ret < 0)
>> > +					goto skip_code;
>> > +				tp_locvar->nb_ex = nr/sizeof(long);
>> > +			}
>> > +		}
>> > +		skip_code:
>> > +		)
>> > +	),
>> > +	TP_FIELDS(
>> > +		sc_exit(ctf_integer(long, ret, ret))
>> > +		sc_in(ctf_integer(int, n, n))
>> > +		sc_inout(ctf_sequence_hex(unsigned long, fdset_in,
>> > +				&tp_locvar->fds_in, unsigned long, tp_locvar->nb_in))
>> > +		sc_inout(ctf_sequence_hex(unsigned long, fdset_out,
>> > +				&tp_locvar->fds_out, unsigned long, tp_locvar->nb_out))
>> > +		sc_inout(ctf_sequence_hex(unsigned long, fdset_ex,
>> > +				&tp_locvar->fds_ex, unsigned long, tp_locvar->nb_ex))
>> > +		sc_inout(ctf_integer(struct timeval *, tvp, tvp))
>> > +	)
>> > +)
>> > +
>> > #else	/* CREATE_SYSCALL_TABLE */
>> > 
>> > #define OVERRIDE_TABLE_64_clone
>> > --
>> > 1.9.1
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>> 
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
