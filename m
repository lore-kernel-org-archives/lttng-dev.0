From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES RFC PATCH] Extract the bitmask of FDs set
 in select syscall
Date: Tue, 6 Oct 2015 15:59:16 +0000 (UTC)
Message-ID: <1105641809.21377.1444147156884.JavaMail.zimbra__26457.1196087219$1444147223$gmane$org@efficios.com>
References: <1443826866-24477-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZjUeG-0001K7-J2
 for lttng-dev@lists.lttng.org; Tue, 06 Oct 2015 11:59:30 -0400
In-Reply-To: <1443826866-24477-1-git-send-email-jdesfossez@efficios.com>
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

----- On Oct 2, 2015, at 7:01 PM, Julien Desfossez jdesfossez@efficios.com wrote:

> Instead of extracting the user-space pointers of the 3 fd_set, we now
> extract the bitmask of the FDs in the sets (in, out, ex) in the form of
> an array of unsigned long (1024 FDs is the limit in the kernel).
> 
> In this example, we select in input FDs 3, 5 and 10 (0x428), it returns
> that one FD is ready: FD 10 (0x400).
> 
> syscall_entry_select: { n = 11,
>	_fdset_in_length = 1, fdset_in = [ [0] = 0x428 ],
>	_fdset_out_length = 1, fdset_out = [ [0] = 0x0 ],
>	_fdset_ex_length = 0, fdset_ex = [ ],
>	tvp = 0
> }
> syscall_exit_select: { ret = 1,
>	_fdset_in_length = 1, fdset_in = [ [0] = 0x400 ],
>	_fdset_out_length = 1, fdset_out = [ [0] = 0x0 ],
>	_fdset_ex_length = 0, fdset_ex = [ ],
>	tvp = 0
> }
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
> .../x86-64-syscalls-3.10.0-rc7_pointers_override.h | 56 ++++++++++++++++++++++

Does it have to be a x86-64 specific override, or it could be used
as an override for all architectures ?

(more below)

> 1 file changed, 56 insertions(+)
> 
> diff --git
> a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> index 702cfb5..23ffbdd 100644
> ---
> a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> @@ -115,6 +115,62 @@ SC_LTTNG_TRACEPOINT_EVENT(pipe,
> 	)
> )
> 
> +#define OVERRIDE_64_select
> +SC_LTTNG_TRACEPOINT_EVENT_CODE(select,
> +	TP_PROTO(sc_exit(long ret,) int n, fd_set __user * inp, fd_set __user * outp,
> +		fd_set __user * exp, struct timeval * tvp),
> +	TP_ARGS(sc_exit(ret,) n, inp, outp, exp, tvp),
> +	TP_locvar(
> +		unsigned long fds_in[__FD_SETSIZE / (8 * sizeof(long))],
> +			fds_out[__FD_SETSIZE / (8 * sizeof(long))],
> +			fds_ex[__FD_SETSIZE / (8 * sizeof(long))];
> +		int nb_in, nb_out, nb_ex;
> +	),
> +	TP_code(
> +		sc_inout(
> +		{
> +			unsigned long nr;
> +			int ret;
> +
> +			nr = FDS_BYTES(n);
> +			tp_locvar->nb_in = 0;
> +			tp_locvar->nb_out = 0;
> +			tp_locvar->nb_ex = 0;

You could initialize them to 0 in TP_locvar (definition).

> +			if (inp) {
> +				ret = copy_from_user(tp_locvar->fds_in, inp, nr);

Why use copy_from_user() here rather than get_fd_set() ?

> +				if (ret < 0)
> +					goto skip_code;
> +				tp_locvar->nb_in = nr/sizeof(long);
> +			}
> +			if (outp) {
> +				ret = copy_from_user(tp_locvar->fds_out, outp, nr);

Ditto.

> +				if (ret < 0)
> +				goto skip_code;
> +				tp_locvar->nb_out = nr/sizeof(long);
> +			}
> +			if (exp) {
> +				ret = copy_from_user(tp_locvar->fds_ex, exp, nr);

Ditto.

> +				if (ret < 0)
> +					goto skip_code;
> +				tp_locvar->nb_ex = nr/sizeof(long);
> +			}
> +		}
> +		skip_code:
> +		)
> +	),
> +	TP_FIELDS(
> +		sc_exit(ctf_integer(long, ret, ret))
> +		sc_in(ctf_integer(int, n, n))
> +		sc_inout(ctf_sequence_hex(unsigned long, fdset_in,
> +				&tp_locvar->fds_in, unsigned long, tp_locvar->nb_in))

If we want to make this code portable, is it really an array of unsigned long in the
trace ? What is the layout on a 32-bit architecture ?

Thanks,

Mathieu

> +		sc_inout(ctf_sequence_hex(unsigned long, fdset_out,
> +				&tp_locvar->fds_out, unsigned long, tp_locvar->nb_out))
> +		sc_inout(ctf_sequence_hex(unsigned long, fdset_ex,
> +				&tp_locvar->fds_ex, unsigned long, tp_locvar->nb_ex))
> +		sc_inout(ctf_integer(struct timeval *, tvp, tvp))
> +	)
> +)
> +
> #else	/* CREATE_SYSCALL_TABLE */
> 
> #define OVERRIDE_TABLE_64_clone
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
