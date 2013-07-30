From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Getting SIGBUS in babeltrace - occasionally
Date: Tue, 30 Jul 2013 09:32:43 +0300
Message-ID: <OFE0CB5F8B.F8C87F9C-ONC2257BB8.0023C233-C2257BB8.0023E3ED__36542.4637137496$1375166037$gmane$org@il.ibm.com>
References: <OF7F44BB67.0C2115DF-ONC2257BB2.003205F9-C2257BB2.00323AF2@il.ibm.com>
	<20130724123411.GA15791@Krystal> <20130724132012.GA16296@Krystal>
	<OF18D93FED.6591AB75-ONC2257BB2.004CA90D-C2257BB2.005142BF@il.ibm.com>
	<20130724161409.GA20539@Krystal>
	<OF3C628D9E.9375394F-ONC2257BB2.005A6688-C2257BB2.005B1B0B@il.ibm.com>
	<51F152AA.70000@efficios.com>
	<OFFC4A684F.EFF77F87-ONC2257BB6.002295AF-C2257BB6.0022B2FA@il.ibm.com>
	<51F6AC0D.9040306@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0166036715=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1V43UU-0006Rh-Ax
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 02:33:08 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 30 Jul 2013 07:26:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5A7141B08066
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 07:32:52 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6U6Wewr64618548
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 06:32:40 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6U6Wpr1026502
	for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2013 00:32:51 -0600
In-Reply-To: <51F6AC0D.9040306@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0166036715==
Content-Type: multipart/alternative; boundary="=_alternative 0023E34BC2257BB8_="

This is a multipart message in MIME format.
--=_alternative 0023E34BC2257BB8_=
Content-Type: text/plain; charset="ISO-2022-JP"

Well, if you're already working on this, I will simply wait.

From what you're describing, this will be perfect for us.

Thanks!

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Julien Desfossez <jdesfossez@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org, Mathieu Desnoyers 
<mathieu.desnoyers@efficios.com>
Date:   07/29/2013 08:53 PM
Subject:        Re: [lttng-dev] Getting SIGBUS in babeltrace - 
occasionally



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
>  > Currently, I am using get_timestamp_end() on the trace handle and 
then I
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
>  > 
------------------------------------------------------------------------
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
>  >> I am in the process of obtaining a permanent contribution approval, 
but
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
>  >> I am waiting for the contribution approval and then I'll submit a 
patch.
>  >>
>  >> To provide a trace sample, I'll need a special approval, which could 

> take
>  >> very long.
>  >>
>  >> System Setup
>  >>
>  >> Processor: Xeon-family 6-cores (12 if you count HT)
>  >> RAM: 24GB of RAM, page size is 4KB.
>  >> OS: Linux 2.6.32.12-211_11_4_0 based on an MCP (IBM's SuSE 
derivative)
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
>  >> We have an in-house trace mechanism including a code instrumentor 
and a
>  >> curses-based viewer (actually urwid+python).
>  >> My current project is to embed LTTng logging and trace capabilites 
into
>  >> several open-source projects, because we couldn't use our in-house 
> tracer
>  >> without having GPL issues.
>  >> I have written a back-end that enables our in-house viewer to 
display
>  >> Lttng traces, by linking with libbabeltrace (allowed by its LGPL 
> license).
>  >>
>  >> As far as I can tell SIGBUS happens to me when I was doing a search. 

> This
>  >> literally reads the events in sequence and tries to compare some 
fields
>  >> against some criteria.
>  >>
>  >> And here's the main reason why I think this is happening - I was 
> adding a
>  >> trace (using add_traces_recursive(trace_dir,'ctf')) while the 
session is
>  >> active (i.e. not stopped).
>  >>
>  >> I can see 2 problematic scenarios here:
>  >>
>  >> Scenario 1
>  >>
>  >> When I add the trace to the context babeltrace performs mmap() 
according
>  >> to the size of the file(s) at that moment.
>  >> The files keep growing.
>  >> When I try to access new packets they may lie beyond the end of the
>  >> mmap'ed region. I think this should lead to SIGSEGV and not to 
SIGBUS.
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
>  >> the file, and try to access the contents, which were not yet 
written.
>  >> Again - could happen around the end of the file, with the session 
still
>  >> active.
>  >
>  > I think the reason is close to this scenario: I think that babeltrace
>  > try to read a packet as it is being written to disk. So it gets the
>  > packet header (including the expected size of the packet), and 
attempts
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
>  >> > > Here is the backtrace, maybe someone could take a look and 
suggest
>  >> > > something:
>  >> >
>  >> > It looks like you're hitting the internal checks for overflow on 
the
>  >> > buffer boundaries.
>  >>
>  >> Please forget about my previous email, I'm utterly wrong. That 
should
>  >> teach me to reply before my first morning coffee ;)
>  >>
>  >> We indeed have internal checks for overflows in babeltrace, but 
those
>  >> are not triggering SIGBUS ever, they return failure gracefully.
>  >>
>  >> What seems to happen in your case is documented here:
>  >>
>  >> mmap(2) manpage:
>  >>
>  >>        SIGBUS Attempted access to a portion of the buffer that does 
not
>  >> corre‐
>  >>               spond  to  the  file  (for  example, beyond the end of 
the
>  >> file,
>  >>               including the case  where  another  process  has 
>   truncated
>  >> the
>  >>               file).
>  >>
>  >> I'm curious to learn which versions of babeltrace/ust/modules you 
are
>  >> using, if you modified them (and how), and if you can get us a 
sample
>  >> trace that triggers the issue.
>  >>
>  >> Also, a bit of context about your setup: is this 32-bit or 64-bit
>  >> user-space, which OS.
>  >>
>  >> Hrm.
>  >>
>  >> By any chance, is it possible that you record your trace on a 
platform
>  >> with 4kB pages, and run babeltrace on it on a platform having 64kB
>  >> pages? Everything points me to include/babeltrace/mmap-align.h
>  >> mmap_align_addr(). We might be mmaping beyond the end of file in 
this
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
>  >> > Are you getting this with a lttng-ust or lttng-modules trace ? If 
yes,
>  >> > which version of the tool has generated the trace ?
>  >> >
>  >> > Can you provide a sample trace that triggers this issue ?
>  >> >
>  >> > Can you give us the detailed sequence of steps you use to 
reproduce ?
>  >> >
>  >> > Thanks,
>  >> >
>  >> > Mathieu
>  >> >
>  >> > > #0  _aligned_integer_read (definition=0x954320, ppos=0x106e028) 
at
>  >> > > integer.c:81
>  >> > > #1  ctf_integer_read (ppos=0x106e028, definition=0x954320) at
>  >> > > integer.c:224
>  >> > > #2  0x00007ffff070e36e in generic_rw (definition=<optimized 
out>,
>  >> > > pos=0x106e028) at ../include/babeltrace/types.h:133
>  >> > > #3  bt_struct_rw (ppos=0x106e028, definition=0x9542e0) at 
> struct.c:56
>  >> > > #4  0x00007ffff13f7fda in generic_rw (definition=<optimized 
out>,
>  >> > > pos=0x106e028) at ../../include/babeltrace/types.h:133
>  >> > > #5  ctf_packet_seek (stream_pos=0x106e028, index=<optimized 
out>,
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
>  >> > > #9  0x00007ffff1624f01 in _wrap__bt_iter_set_pos 
(self=<optimized
>  >> out>,
>  >> > > args=<optimized out>) at babeltrace_wrap.c:3805
>  >> > > #10 0x00007ffff7b28c0c in call_function (oparg=<optimized out>,
>  >> > > pp_stack=<optimized out>) at Python/ceval.c:3679
>  >> > > #11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=<optimized out>) 
at
>  >> > > Python/ceval.c:2370
>  >> > > #12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx (co=0xa8e5d0,
>  >> > > globals=<optimized out>, locals=<optimized out>, args=0x2088cc8,
>  >> > > argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, 
closure=0x0)
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



--=_alternative 0023E34BC2257BB8_=
Content-Type: text/html; charset="ISO-2022-JP"

<font size=2 face="sans-serif">Well, if you're already working on this,
I will simply wait.</font>
<br>
<br><font size=2 face="sans-serif">From what you're describing, this will
be perfect for us.</font>
<br>
<br><font size=2 face="sans-serif">Thanks!</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Julien Desfossez &lt;jdesfossez@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org,
Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">07/29/2013 08:53 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Getting SIGBUS in babeltrace - occasionally</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi,<br>
<br>
We are working on generating the index file during tracing, so<br>
Babeltrace does not need to create it when it opens the trace. It will<br>
be ready in the next weeks in my branches and fixed/merged when Mathieu<br>
and David come back from vacation.<br>
<br>
If you want Babeltrace to write the index on disk and parse it on open,<br>
you could have a look at my output-index branch in<br>
git://git.dorsal.polymtl.ca/~jdesfossez/babeltrace<br>
These are earlier prototypes for the live reading, but there are patches<br>
that do exactly what you are looking for. They won't be merged as is,<br>
the index structure might change and the index file will have the suffix<br>
.idx instead of the prefix idx_, but it might help you for now while we<br>
work on integrating all of that.<br>
<br>
Regards,<br>
<br>
Julien<br>
<br>
On 13-07-28 02:19 AM, Amit Margalit wrote:<br>
&gt; Thanks.<br>
&gt; <br>
&gt; While we're at it, can we somehow save the index to a separate file,
and <br>
&gt; allow a reload when re-opening the trace? That would speed up opening
<br>
&gt; considerably...<br>
&gt; <br>
&gt; I am about to attempt this, and I'll submit a patch if it works for
me.<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - /Storage Reinvented/<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; From: Julien Desfossez &lt;jdesfossez@efficios.com&gt;<br>
&gt; To: Amit Margalit/Israel/IBM@IBMIL<br>
&gt; Cc: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;, <br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; Date: 07/25/2013 07:37 PM<br>
&gt; Subject: Re: [lttng-dev] Getting SIGBUS in babeltrace - occasionally<br>
&gt; ------------------------------------------------------------------------<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; &nbsp;&gt; Is there a way to determine the &quot;latest timestamp
that is safe to <br>
&gt; access&quot; ?<br>
&gt; I guess with the switch-timers enabled on all channels (including<br>
&gt; metadata) you can estimate what is the maximum timestamp you can read.<br>
&gt; <br>
&gt; For example, if your switch-timer is set to 1 second, you can check
the<br>
&gt; current time, wait a 1 second grace period and read the trace up to
that<br>
&gt; point, but I wouldn't consider that a safe or clean method.<br>
&gt; Also, you need to reopen the trace every time since the index is done<br>
&gt; only when opening the trace and metadata might get appended during
the<br>
&gt; trace.<br>
&gt; <br>
&gt; I don't know exactly what your use-case is, but the live reading seems<br>
&gt; to be what you are looking for. We will post more details about it
soon.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Julien<br>
&gt; <br>
&gt; <br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; Currently, I am using get_timestamp_end() on the trace
handle and then I<br>
&gt; &nbsp;&gt; try to read the events at that point, and if I fail, I
simply try<br>
&gt; &nbsp;&gt; earlier times until I succeed in reading an event.<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; Thanks,<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; Amit Margalit<br>
&gt; &nbsp;&gt; IBM XIV - /Storage Reinvented/<br>
&gt; &nbsp;&gt; XIV-NAS Development Team<br>
&gt; &nbsp;&gt; Tel. 03-689-7774<br>
&gt; &nbsp;&gt; Fax. 03-689-7230<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; From: &nbsp; &nbsp; &nbsp; &nbsp;Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
&gt; &nbsp;&gt; To: &nbsp; &nbsp; &nbsp; &nbsp;Amit Margalit/Israel/IBM@IBMIL<br>
&gt; &nbsp;&gt; Cc: &nbsp; &nbsp; &nbsp; &nbsp;lttng-dev@lists.lttng.org<br>
&gt; &nbsp;&gt; Date: &nbsp; &nbsp; &nbsp; &nbsp;07/24/2013 07:14 PM<br>
&gt; &nbsp;&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Getting
SIGBUS in babeltrace - <br>
&gt; occasionally<br>
&gt; &nbsp;&gt; ------------------------------------------------------------------------<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; * Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; &nbsp;&gt;&gt; Hi,<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Access beyond end of file seems to be the issue IIUC.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Let me try to give as much context as I can and answer
your <br>
&gt; questions one<br>
&gt; &nbsp;&gt;&gt; by one:<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Versions<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; lttng-ust 2.2.0, lttng-tools 2.2.0, babeltrace - I
used git hash<br>
&gt; &nbsp;&gt;&gt; cc26a15ac355d886bb507955fdaec9b218024713 with a patch
on <br>
&gt; babeltrace.i.in.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; [I cannot supply the patch as this requires my employer's
(IBM)<br>
&gt; &nbsp;&gt; approval -<br>
&gt; &nbsp;&gt;&gt; I am in the process of obtaining a permanent contribution
approval, but<br>
&gt; &nbsp;&gt;&gt; until then...]<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; However, I can tell you exactly what it does:<br>
&gt; &nbsp;&gt;&gt; 1. Adds a typedef for 'ssize_t'<br>
&gt; &nbsp;&gt;&gt; 2. Added a call to _bt_ctf_get_decl_from_def() around
the argument<br>
&gt; &nbsp;&gt;&gt; supplied to _bt_ctf_get_int_len()<br>
&gt; &nbsp;&gt;&gt; 3. Changed all use of {} in string &quot;.format()&quot;
calls to add numbers <br>
&gt; (e.g.<br>
&gt; &nbsp;&gt;&gt; {0} instead of {}) - as this doesn't work for Python
2.6.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; I am waiting for the contribution approval and then
I'll submit a patch.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; To provide a trace sample, I'll need a special approval,
which could <br>
&gt; take<br>
&gt; &nbsp;&gt;&gt; very long.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; System Setup<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Processor: Xeon-family 6-cores (12 if you count HT)<br>
&gt; &nbsp;&gt;&gt; RAM: 24GB of RAM, page size is 4KB.<br>
&gt; &nbsp;&gt;&gt; OS: Linux 2.6.32.12-211_11_4_0 based on an MCP (IBM's
SuSE derivative)<br>
&gt; &nbsp;&gt;&gt; build.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Tracing Setup<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Same system used to generate, collect and read the
traces.<br>
&gt; &nbsp;&gt;&gt; 100% user-space.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Triggering<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; This is not readily reproducible. Some context:<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; We have an in-house trace mechanism including a code
instrumentor and a<br>
&gt; &nbsp;&gt;&gt; curses-based viewer (actually urwid+python).<br>
&gt; &nbsp;&gt;&gt; My current project is to embed LTTng logging and trace
capabilites into<br>
&gt; &nbsp;&gt;&gt; several open-source projects, because we couldn't use
our in-house <br>
&gt; tracer<br>
&gt; &nbsp;&gt;&gt; without having GPL issues.<br>
&gt; &nbsp;&gt;&gt; I have written a back-end that enables our in-house
viewer to display<br>
&gt; &nbsp;&gt;&gt; Lttng traces, by linking with libbabeltrace (allowed
by its LGPL <br>
&gt; license).<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; As far as I can tell SIGBUS happens to me when I was
doing a search. <br>
&gt; This<br>
&gt; &nbsp;&gt;&gt; literally reads the events in sequence and tries to
compare some fields<br>
&gt; &nbsp;&gt;&gt; against some criteria.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; And here's the main reason why I think this is happening
- I was <br>
&gt; adding a<br>
&gt; &nbsp;&gt;&gt; trace (using add_traces_recursive(trace_dir,'ctf'))
while the session is<br>
&gt; &nbsp;&gt;&gt; active (i.e. not stopped).<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; I can see 2 problematic scenarios here:<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Scenario 1<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; When I add the trace to the context babeltrace performs
mmap() according<br>
&gt; &nbsp;&gt;&gt; to the size of the file(s) at that moment.<br>
&gt; &nbsp;&gt;&gt; The files keep growing.<br>
&gt; &nbsp;&gt;&gt; When I try to access new packets they may lie beyond
the end of the<br>
&gt; &nbsp;&gt;&gt; mmap'ed region. I think this should lead to SIGSEGV
and not to SIGBUS.<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; babeltrace only mmap packet by packet, never an entire
file.<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Scenario 2<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Due to buffering issues, I could be having a race with
the session<br>
&gt; &nbsp;&gt; daemon,<br>
&gt; &nbsp;&gt;&gt; where my code reads the beginning of a packet that
was already <br>
&gt; written to<br>
&gt; &nbsp;&gt;&gt; the file, and try to access the contents, which were
not yet written.<br>
&gt; &nbsp;&gt;&gt; Again - could happen around the end of the file, with
the session still<br>
&gt; &nbsp;&gt;&gt; active.<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; I think the reason is close to this scenario: I think that
babeltrace<br>
&gt; &nbsp;&gt; try to read a packet as it is being written to disk. So
it gets the<br>
&gt; &nbsp;&gt; packet header (including the expected size of the packet),
and attempts<br>
&gt; &nbsp;&gt; to read beyond the end of the partially-copied packet.
Live streaming<br>
&gt; &nbsp;&gt; feature (we're working on this for the next release of
lttng) will<br>
&gt; &nbsp;&gt; handle thi use-cases.<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; Thanks,<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; Mathieu<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Amit<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Amit Margalit<br>
&gt; &nbsp;&gt;&gt; IBM XIV - Storage Reinvented<br>
&gt; &nbsp;&gt;&gt; XIV-NAS Development Team<br>
&gt; &nbsp;&gt;&gt; Tel. 03-689-7774<br>
&gt; &nbsp;&gt;&gt; Fax. 03-689-7230<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; From: &nbsp; Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
&gt; &nbsp;&gt;&gt; To: &nbsp; &nbsp; Amit Margalit/Israel/IBM@IBMIL<br>
&gt; &nbsp;&gt;&gt; Cc: &nbsp; &nbsp; lttng-dev@lists.lttng.org<br>
&gt; &nbsp;&gt;&gt; Date: &nbsp; 07/24/2013 04:20 PM<br>
&gt; &nbsp;&gt;&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev]
Getting SIGBUS in babeltrace -<br>
&gt; &nbsp;&gt;&gt; occasionally<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; * Mathieu Desnoyers (mathieu.desnoyers@efficios.com)
wrote:<br>
&gt; &nbsp;&gt;&gt; &gt; * Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Hi,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; I am getting occasional SIGBUS inside _aligned_integer_read()
in<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; ./formats/ctf/types/integer.c<br>
&gt; &nbsp;&gt;&gt; &gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Here is the backtrace, maybe someone could
take a look and suggest<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; something:<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; It looks like you're hitting the internal checks
for overflow on the<br>
&gt; &nbsp;&gt;&gt; &gt; buffer boundaries.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Please forget about my previous email, I'm utterly
wrong. That should<br>
&gt; &nbsp;&gt;&gt; teach me to reply before my first morning coffee ;)<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; We indeed have internal checks for overflows in babeltrace,
but those<br>
&gt; &nbsp;&gt;&gt; are not triggering SIGBUS ever, they return failure
gracefully.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; What seems to happen in your case is documented here:<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; mmap(2) manpage:<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp;SIGBUS Attempted access
to a portion of the buffer that does not<br>
&gt; &nbsp;&gt;&gt; corre‐<br>
&gt; &nbsp;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spond
&nbsp;to &nbsp;the &nbsp;file &nbsp;(for &nbsp;example, beyond the end
of the<br>
&gt; &nbsp;&gt;&gt; file,<br>
&gt; &nbsp;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; including
the case &nbsp;where &nbsp;another &nbsp;process &nbsp;has <br>
&gt; &nbsp; truncated<br>
&gt; &nbsp;&gt;&gt; the<br>
&gt; &nbsp;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file).<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; I'm curious to learn which versions of babeltrace/ust/modules
you are<br>
&gt; &nbsp;&gt;&gt; using, if you modified them (and how), and if you can
get us a sample<br>
&gt; &nbsp;&gt;&gt; trace that triggers the issue.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Also, a bit of context about your setup: is this 32-bit
or 64-bit<br>
&gt; &nbsp;&gt;&gt; user-space, which OS.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Hrm.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; By any chance, is it possible that you record your
trace on a platform<br>
&gt; &nbsp;&gt;&gt; with 4kB pages, and run babeltrace on it on a platform
having 64kB<br>
&gt; &nbsp;&gt;&gt; pages? Everything points me to include/babeltrace/mmap-align.h<br>
&gt; &nbsp;&gt;&gt; mmap_align_addr(). We might be mmaping beyond the end
of file in this<br>
&gt; &nbsp;&gt;&gt; case.<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Thanks!<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; Mathieu<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; On which babeltrace version can you reproduce
it ? Did you do any<br>
&gt; &nbsp;&gt;&gt; &gt; modification to babeltrace on your own on top
?<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; Are you getting this with a lttng-ust or lttng-modules
trace ? If yes,<br>
&gt; &nbsp;&gt;&gt; &gt; which version of the tool has generated the trace
?<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; Can you provide a sample trace that triggers this
issue ?<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; Can you give us the detailed sequence of steps
you use to reproduce ?<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; Thanks,<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; Mathieu<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #0 &nbsp;_aligned_integer_read (definition=0x954320,
ppos=0x106e028) at<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; integer.c:81<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #1 &nbsp;ctf_integer_read (ppos=0x106e028,
definition=0x954320) at<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; integer.c:224<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #2 &nbsp;0x00007ffff070e36e in generic_rw
(definition=&lt;optimized out&gt;,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; pos=0x106e028) at ../include/babeltrace/types.h:133<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #3 &nbsp;bt_struct_rw (ppos=0x106e028, definition=0x9542e0)
at <br>
&gt; struct.c:56<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #4 &nbsp;0x00007ffff13f7fda in generic_rw
(definition=&lt;optimized out&gt;,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; pos=0x106e028) at ../../include/babeltrace/types.h:133<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #5 &nbsp;ctf_packet_seek (stream_pos=0x106e028,
index=&lt;optimized out&gt;,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; whence=&lt;optimized out&gt;) at ctf.c:860<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #6 &nbsp;0x00007ffff070a3f1 in seek_file_stream_by_timestamp<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; (cfs=cfs@entry=0x106cf90,<br>
&gt; &nbsp;&gt;&gt; timestamp=timestamp@entry=1374636821498972926)<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; at iterator.c:141<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #7 &nbsp;0x00007ffff070aa96 in seek_ctf_trace_by_timestamp<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; (stream_heap=0x176d310, timestamp=1374636821498972926,
<br>
&gt; tin=&lt;optimized<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; out&gt;) at iterator.c:188<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #8 &nbsp;bt_iter_set_pos (iter=iter@entry=0xfdafa0,
<br>
&gt; iter_pos=0x2bf59f0) at<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; iterator.c:439<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #9 &nbsp;0x00007ffff1624f01 in _wrap__bt_iter_set_pos
(self=&lt;optimized<br>
&gt; &nbsp;&gt;&gt; out&gt;,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; args=&lt;optimized out&gt;) at babeltrace_wrap.c:3805<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #10 0x00007ffff7b28c0c in call_function (oparg=&lt;optimized
out&gt;,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; pp_stack=&lt;optimized out&gt;) at Python/ceval.c:3679<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=&lt;optimized
out&gt;) at<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Python/ceval.c:2370<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; #12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx
(co=0xa8e5d0,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; globals=&lt;optimized out&gt;, locals=&lt;optimized
out&gt;, args=0x2088cc8,<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; argcount=0, kws=0x0, kwcount=0, defs=0x0,
defcount=0, closure=0x0)<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; &nbsp; &nbsp; at Python/ceval.c:2942<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; .<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; .<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; .<br>
&gt; &nbsp;&gt;&gt; &gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Any suggestions are welcome.<br>
&gt; &nbsp;&gt;&gt; &gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Amit Margalit<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; IBM XIV - Storage Reinvented<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; XIV-NAS Development Team<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Tel. 03-689-7774<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; Fax. 03-689-7230<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; _______________________________________________<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; lttng-dev mailing list<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; lttng-dev@lists.lttng.org<br>
&gt; &nbsp;&gt;&gt; &gt; &gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt;<br>
&gt; &nbsp;&gt;&gt; &gt; --<br>
&gt; &nbsp;&gt;&gt; &gt; Mathieu Desnoyers<br>
&gt; &nbsp;&gt;&gt; &gt; EfficiOS Inc.<br>
&gt; &nbsp;&gt;&gt; &gt; </font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2>
<br>
&gt; &lt;</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com/</font></tt></a><tt><font size=2>&gt;&lt;</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com/</font></tt></a><tt><font size=2>&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt; --<br>
&gt; &nbsp;&gt;&gt; Mathieu Desnoyers<br>
&gt; &nbsp;&gt;&gt; EfficiOS Inc.<br>
&gt; &nbsp;&gt;&gt; </font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2>
<br>
&gt; &lt;</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com/</font></tt></a><tt><font size=2>&gt;&lt;</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com/</font></tt></a><tt><font size=2>&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; --<br>
&gt; &nbsp;&gt; Mathieu Desnoyers<br>
&gt; &nbsp;&gt; EfficiOS Inc.<br>
&gt; &nbsp;&gt; </font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2>
<br>
&gt; &lt;</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com/</font></tt></a><tt><font size=2>&gt;&lt;</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com/</font></tt></a><tt><font size=2>&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt;<br>
&gt; &nbsp;&gt; _______________________________________________<br>
&gt; &nbsp;&gt; lttng-dev mailing list<br>
&gt; &nbsp;&gt; lttng-dev@lists.lttng.org<br>
&gt; &nbsp;&gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
&gt; &nbsp;&gt;<br>
&gt; <br>
&gt; <br>
<br>
</font></tt>
<br>
--=_alternative 0023E34BC2257BB8_=--



--===============0166036715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0166036715==--
