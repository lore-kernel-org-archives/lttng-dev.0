From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Getting SIGBUS in babeltrace - occasionally
Date: Mon, 29 Jul 2013 13:53:17 -0400
Message-ID: <51F6AC0D.9040306__35802.225492853$1375120470$gmane$org@efficios.com>
References: <OF7F44BB67.0C2115DF-ONC2257BB2.003205F9-C2257BB2.00323AF2@il.ibm.com>
	<20130724123411.GA15791@Krystal> <20130724132012.GA16296@Krystal>
	<OF18D93FED.6591AB75-ONC2257BB2.004CA90D-C2257BB2.005142BF@il.ibm.com>
	<20130724161409.GA20539@Krystal>
	<OF3C628D9E.9375394F-ONC2257BB2.005A6688-C2257BB2.005B1B0B@il.ibm.com>
	<51F152AA.70000@efficios.com>
	<OFFC4A684F.EFF77F87-ONC2257BB6.002295AF-C2257BB6.0022B2FA@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V3rdO-0002X4-6s
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 13:53:33 -0400
In-Reply-To: <OFFC4A684F.EFF77F87-ONC2257BB6.002295AF-C2257BB6.0022B2FA@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

We are working on generating the index file during tracing, so
Babeltrace does not need to create it when it opens the trace. It will
be ready in the next weeks in my branches and fixed/merged when Mathieu
and David come back from vacation.

If you want Babeltrace to write the index on disk and parse it on open,
you could have a look at my output-index branch in
git://git.dorsal.polymtl.ca/~jdesfossez/babeltrace
These are earlier prototypes for the live reading, but there are patches
that do exactly what you are looking for. They won't be merged as is,
the index structure might change and the index file will have the suffix
.idx instead of the prefix idx_, but it might help you for now while we
work on integrating all of that.

Regards,

Julien

On 13-07-28 02:19 AM, Amit Margalit wrote:
> Thanks.
> 
> While we're at it, can we somehow save the index to a separate file, and 
> allow a reload when re-opening the trace? That would speed up opening 
> considerably...
> 
> I am about to attempt this, and I'll submit a patch if it works for me.
> 
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From: Julien Desfossez <jdesfossez@efficios.com>
> To: Amit Margalit/Israel/IBM@IBMIL
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
> lttng-dev@lists.lttng.org
> Date: 07/25/2013 07:37 PM
> Subject: Re: [lttng-dev] Getting SIGBUS in babeltrace - occasionally
> ------------------------------------------------------------------------
> 
> 
> 
>  > Is there a way to determine the "latest timestamp that is safe to 
> access" ?
> I guess with the switch-timers enabled on all channels (including
> metadata) you can estimate what is the maximum timestamp you can read.
> 
> For example, if your switch-timer is set to 1 second, you can check the
> current time, wait a 1 second grace period and read the trace up to that
> point, but I wouldn't consider that a safe or clean method.
> Also, you need to reopen the trace every time since the index is done
> only when opening the trace and metadata might get appended during the
> trace.
> 
> I don't know exactly what your use-case is, but the live reading seems
> to be what you are looking for. We will post more details about it soon.
> 
> Thanks,
> 
> Julien
> 
> 
>  >
>  > Currently, I am using get_timestamp_end() on the trace handle and then I
>  > try to read the events at that point, and if I fail, I simply try
>  > earlier times until I succeed in reading an event.
>  >
>  > Thanks,
>  >
>  > Amit Margalit
>  > IBM XIV - /Storage Reinvented/
>  > XIV-NAS Development Team
>  > Tel. 03-689-7774
>  > Fax. 03-689-7230
>  >
>  >
>  >
>  > From:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  > To:        Amit Margalit/Israel/IBM@IBMIL
>  > Cc:        lttng-dev@lists.lttng.org
>  > Date:        07/24/2013 07:14 PM
>  > Subject:        Re: [lttng-dev] Getting SIGBUS in babeltrace - 
> occasionally
>  > ------------------------------------------------------------------------
>  >
>  >
>  >
>  > * Amit Margalit (AMITM@il.ibm.com) wrote:
>  >> Hi,
>  >>
>  >> Access beyond end of file seems to be the issue IIUC.
>  >>
>  >> Let me try to give as much context as I can and answer your 
> questions one
>  >> by one:
>  >>
>  >> Versions
>  >>
>  >> lttng-ust 2.2.0, lttng-tools 2.2.0, babeltrace - I used git hash
>  >> cc26a15ac355d886bb507955fdaec9b218024713 with a patch on 
> babeltrace.i.in.
>  >>
>  >> [I cannot supply the patch as this requires my employer's (IBM)
>  > approval -
>  >> I am in the process of obtaining a permanent contribution approval, but
>  >> until then...]
>  >>
>  >> However, I can tell you exactly what it does:
>  >> 1. Adds a typedef for 'ssize_t'
>  >> 2. Added a call to _bt_ctf_get_decl_from_def() around the argument
>  >> supplied to _bt_ctf_get_int_len()
>  >> 3. Changed all use of {} in string ".format()" calls to add numbers 
> (e.g.
>  >> {0} instead of {}) - as this doesn't work for Python 2.6.
>  >>
>  >> I am waiting for the contribution approval and then I'll submit a patch.
>  >>
>  >> To provide a trace sample, I'll need a special approval, which could 
> take
>  >> very long.
>  >>
>  >> System Setup
>  >>
>  >> Processor: Xeon-family 6-cores (12 if you count HT)
>  >> RAM: 24GB of RAM, page size is 4KB.
>  >> OS: Linux 2.6.32.12-211_11_4_0 based on an MCP (IBM's SuSE derivative)
>  >> build.
>  >>
>  >> Tracing Setup
>  >>
>  >> Same system used to generate, collect and read the traces.
>  >> 100% user-space.
>  >>
>  >> Triggering
>  >>
>  >> This is not readily reproducible. Some context:
>  >>
>  >> We have an in-house trace mechanism including a code instrumentor and a
>  >> curses-based viewer (actually urwid+python).
>  >> My current project is to embed LTTng logging and trace capabilites into
>  >> several open-source projects, because we couldn't use our in-house 
> tracer
>  >> without having GPL issues.
>  >> I have written a back-end that enables our in-house viewer to display
>  >> Lttng traces, by linking with libbabeltrace (allowed by its LGPL 
> license).
>  >>
>  >> As far as I can tell SIGBUS happens to me when I was doing a search. 
> This
>  >> literally reads the events in sequence and tries to compare some fields
>  >> against some criteria.
>  >>
>  >> And here's the main reason why I think this is happening - I was 
> adding a
>  >> trace (using add_traces_recursive(trace_dir,'ctf')) while the session is
>  >> active (i.e. not stopped).
>  >>
>  >> I can see 2 problematic scenarios here:
>  >>
>  >> Scenario 1
>  >>
>  >> When I add the trace to the context babeltrace performs mmap() according
>  >> to the size of the file(s) at that moment.
>  >> The files keep growing.
>  >> When I try to access new packets they may lie beyond the end of the
>  >> mmap'ed region. I think this should lead to SIGSEGV and not to SIGBUS.
>  >
>  > babeltrace only mmap packet by packet, never an entire file.
>  >
>  >>
>  >> Scenario 2
>  >>
>  >> Due to buffering issues, I could be having a race with the session
>  > daemon,
>  >> where my code reads the beginning of a packet that was already 
> written to
>  >> the file, and try to access the contents, which were not yet written.
>  >> Again - could happen around the end of the file, with the session still
>  >> active.
>  >
>  > I think the reason is close to this scenario: I think that babeltrace
>  > try to read a packet as it is being written to disk. So it gets the
>  > packet header (including the expected size of the packet), and attempts
>  > to read beyond the end of the partially-copied packet. Live streaming
>  > feature (we're working on this for the next release of lttng) will
>  > handle thi use-cases.
>  >
>  > Thanks,
>  >
>  > Mathieu
>  >
>  >
>  >>
>  >> Amit
>  >>
>  >> Amit Margalit
>  >> IBM XIV - Storage Reinvented
>  >> XIV-NAS Development Team
>  >> Tel. 03-689-7774
>  >> Fax. 03-689-7230
>  >>
>  >>
>  >>
>  >> From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  >> To:     Amit Margalit/Israel/IBM@IBMIL
>  >> Cc:     lttng-dev@lists.lttng.org
>  >> Date:   07/24/2013 04:20 PM
>  >> Subject:        Re: [lttng-dev] Getting SIGBUS in babeltrace -
>  >> occasionally
>  >>
>  >>
>  >>
>  >> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
>  >> > * Amit Margalit (AMITM@il.ibm.com) wrote:
>  >> > > Hi,
>  >> > >
>  >> > > I am getting occasional SIGBUS inside _aligned_integer_read() in
>  >> > > ./formats/ctf/types/integer.c
>  >> > >
>  >> > > Here is the backtrace, maybe someone could take a look and suggest
>  >> > > something:
>  >> >
>  >> > It looks like you're hitting the internal checks for overflow on the
>  >> > buffer boundaries.
>  >>
>  >> Please forget about my previous email, I'm utterly wrong. That should
>  >> teach me to reply before my first morning coffee ;)
>  >>
>  >> We indeed have internal checks for overflows in babeltrace, but those
>  >> are not triggering SIGBUS ever, they return failure gracefully.
>  >>
>  >> What seems to happen in your case is documented here:
>  >>
>  >> mmap(2) manpage:
>  >>
>  >>        SIGBUS Attempted access to a portion of the buffer that does not
>  >> corre‐
>  >>               spond  to  the  file  (for  example, beyond the end of the
>  >> file,
>  >>               including the case  where  another  process  has 
>   truncated
>  >> the
>  >>               file).
>  >>
>  >> I'm curious to learn which versions of babeltrace/ust/modules you are
>  >> using, if you modified them (and how), and if you can get us a sample
>  >> trace that triggers the issue.
>  >>
>  >> Also, a bit of context about your setup: is this 32-bit or 64-bit
>  >> user-space, which OS.
>  >>
>  >> Hrm.
>  >>
>  >> By any chance, is it possible that you record your trace on a platform
>  >> with 4kB pages, and run babeltrace on it on a platform having 64kB
>  >> pages? Everything points me to include/babeltrace/mmap-align.h
>  >> mmap_align_addr(). We might be mmaping beyond the end of file in this
>  >> case.
>  >>
>  >> Thanks!
>  >>
>  >> Mathieu
>  >>
>  >> >
>  >> > On which babeltrace version can you reproduce it ? Did you do any
>  >> > modification to babeltrace on your own on top ?
>  >> >
>  >> > Are you getting this with a lttng-ust or lttng-modules trace ? If yes,
>  >> > which version of the tool has generated the trace ?
>  >> >
>  >> > Can you provide a sample trace that triggers this issue ?
>  >> >
>  >> > Can you give us the detailed sequence of steps you use to reproduce ?
>  >> >
>  >> > Thanks,
>  >> >
>  >> > Mathieu
>  >> >
>  >> > > #0  _aligned_integer_read (definition=0x954320, ppos=0x106e028) at
>  >> > > integer.c:81
>  >> > > #1  ctf_integer_read (ppos=0x106e028, definition=0x954320) at
>  >> > > integer.c:224
>  >> > > #2  0x00007ffff070e36e in generic_rw (definition=<optimized out>,
>  >> > > pos=0x106e028) at ../include/babeltrace/types.h:133
>  >> > > #3  bt_struct_rw (ppos=0x106e028, definition=0x9542e0) at 
> struct.c:56
>  >> > > #4  0x00007ffff13f7fda in generic_rw (definition=<optimized out>,
>  >> > > pos=0x106e028) at ../../include/babeltrace/types.h:133
>  >> > > #5  ctf_packet_seek (stream_pos=0x106e028, index=<optimized out>,
>  >> > > whence=<optimized out>) at ctf.c:860
>  >> > > #6  0x00007ffff070a3f1 in seek_file_stream_by_timestamp
>  >> > > (cfs=cfs@entry=0x106cf90,
>  >> timestamp=timestamp@entry=1374636821498972926)
>  >> > > at iterator.c:141
>  >> > > #7  0x00007ffff070aa96 in seek_ctf_trace_by_timestamp
>  >> > > (stream_heap=0x176d310, timestamp=1374636821498972926, 
> tin=<optimized
>  >> > > out>) at iterator.c:188
>  >> > > #8  bt_iter_set_pos (iter=iter@entry=0xfdafa0, 
> iter_pos=0x2bf59f0) at
>  >> > > iterator.c:439
>  >> > > #9  0x00007ffff1624f01 in _wrap__bt_iter_set_pos (self=<optimized
>  >> out>,
>  >> > > args=<optimized out>) at babeltrace_wrap.c:3805
>  >> > > #10 0x00007ffff7b28c0c in call_function (oparg=<optimized out>,
>  >> > > pp_stack=<optimized out>) at Python/ceval.c:3679
>  >> > > #11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=<optimized out>) at
>  >> > > Python/ceval.c:2370
>  >> > > #12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx (co=0xa8e5d0,
>  >> > > globals=<optimized out>, locals=<optimized out>, args=0x2088cc8,
>  >> > > argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, closure=0x0)
>  >> > >     at Python/ceval.c:2942
>  >> > > .
>  >> > > .
>  >> > > .
>  >> > >
>  >> > > Any suggestions are welcome.
>  >> > >
>  >> > > Amit Margalit
>  >> > > IBM XIV - Storage Reinvented
>  >> > > XIV-NAS Development Team
>  >> > > Tel. 03-689-7774
>  >> > > Fax. 03-689-7230
>  >> > > _______________________________________________
>  >> > > lttng-dev mailing list
>  >> > > lttng-dev@lists.lttng.org
>  >> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>  >> >
>  >> >
>  >> > --
>  >> > Mathieu Desnoyers
>  >> > EfficiOS Inc.
>  >> > http://www.efficios.com 
> <http://www.efficios.com/><http://www.efficios.com/>
>  >>
>  >> --
>  >> Mathieu Desnoyers
>  >> EfficiOS Inc.
>  >> http://www.efficios.com 
> <http://www.efficios.com/><http://www.efficios.com/>
>  >>
>  >>
>  >
>  > --
>  > Mathieu Desnoyers
>  > EfficiOS Inc.
>  > http://www.efficios.com 
> <http://www.efficios.com/><http://www.efficios.com/>
>  >
>  >
>  >
>  >
>  > _______________________________________________
>  > lttng-dev mailing list
>  > lttng-dev@lists.lttng.org
>  > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>  >
> 
> 
