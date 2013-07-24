From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Getting SIGBUS in babeltrace - occasionally
Date: Wed, 24 Jul 2013 19:35:49 +0300
Message-ID: <OF3C628D9E.9375394F-ONC2257BB2.005A6688-C2257BB2.005B1B0B__30534.0942381465$1374683832$gmane$org@il.ibm.com>
References: <OF7F44BB67.0C2115DF-ONC2257BB2.003205F9-C2257BB2.00323AF2@il.ibm.com>
	<20130724123411.GA15791@Krystal> <20130724132012.GA16296@Krystal>
	<OF18D93FED.6591AB75-ONC2257BB2.004CA90D-C2257BB2.005142BF@il.ibm.com>
	<20130724161409.GA20539@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1447435264=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1V222q-0006K5-2V
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 12:36:14 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 24 Jul 2013 17:31:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8A75C219005A
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 17:40:08 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6OGZmmk61669470
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 16:35:48 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6OGZxHX016642
	for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2013 10:35:59 -0600
In-Reply-To: <20130724161409.GA20539@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1447435264==
Content-Type: multipart/alternative; boundary="=_alternative 005B1ADFC2257BB2_="

This is a multipart message in MIME format.
--=_alternative 005B1ADFC2257BB2_=
Content-Type: text/plain; charset="ISO-2022-JP"

Well, the live-streaming feature is more than we need.

We don't require the ability to sit and watch events as they appear in the 
trace file.

Is there a way to determine the "latest timestamp that is safe to access" 
?

Currently, I am using get_timestamp_end() on the trace handle and then I 
try to read the events at that point, and if I fail, I simply try earlier 
times until I succeed in reading an event.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   07/24/2013 07:14 PM
Subject:        Re: [lttng-dev] Getting SIGBUS in babeltrace - 
occasionally



* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hi,
> 
> Access beyond end of file seems to be the issue IIUC.
> 
> Let me try to give as much context as I can and answer your questions 
one 
> by one:
> 
> Versions
> 
> lttng-ust 2.2.0, lttng-tools 2.2.0, babeltrace - I used git hash 
> cc26a15ac355d886bb507955fdaec9b218024713 with a patch on 
babeltrace.i.in.
> 
> [I cannot supply the patch as this requires my employer's (IBM) approval 
- 
> I am in the process of obtaining a permanent contribution approval, but 
> until then...]
> 
> However, I can tell you exactly what it does:
> 1. Adds a typedef for 'ssize_t'
> 2. Added a call to _bt_ctf_get_decl_from_def() around the argument 
> supplied to _bt_ctf_get_int_len()
> 3. Changed all use of {} in string ".format()" calls to add numbers 
(e.g. 
> {0} instead of {}) - as this doesn't work for Python 2.6.
> 
> I am waiting for the contribution approval and then I'll submit a patch.
> 
> To provide a trace sample, I'll need a special approval, which could 
take 
> very long.
> 
> System Setup
> 
> Processor: Xeon-family 6-cores (12 if you count HT)
> RAM: 24GB of RAM, page size is 4KB.
> OS: Linux 2.6.32.12-211_11_4_0 based on an MCP (IBM's SuSE derivative) 
> build.
> 
> Tracing Setup
> 
> Same system used to generate, collect and read the traces.
> 100% user-space.
> 
> Triggering
> 
> This is not readily reproducible. Some context:
> 
> We have an in-house trace mechanism including a code instrumentor and a 
> curses-based viewer (actually urwid+python).
> My current project is to embed LTTng logging and trace capabilites into 
> several open-source projects, because we couldn't use our in-house 
tracer 
> without having GPL issues.
> I have written a back-end that enables our in-house viewer to display 
> Lttng traces, by linking with libbabeltrace (allowed by its LGPL 
license).
> 
> As far as I can tell SIGBUS happens to me when I was doing a search. 
This 
> literally reads the events in sequence and tries to compare some fields 
> against some criteria.
> 
> And here's the main reason why I think this is happening - I was adding 
a 
> trace (using add_traces_recursive(trace_dir,'ctf')) while the session is 

> active (i.e. not stopped).
> 
> I can see 2 problematic scenarios here:
> 
> Scenario 1
> 
> When I add the trace to the context babeltrace performs mmap() according 

> to the size of the file(s) at that moment.
> The files keep growing.
> When I try to access new packets they may lie beyond the end of the 
> mmap'ed region. I think this should lead to SIGSEGV and not to SIGBUS.

babeltrace only mmap packet by packet, never an entire file.

> 
> Scenario 2
> 
> Due to buffering issues, I could be having a race with the session 
daemon, 
> where my code reads the beginning of a packet that was already written 
to 
> the file, and try to access the contents, which were not yet written. 
> Again - could happen around the end of the file, with the session still 
> active.

I think the reason is close to this scenario: I think that babeltrace
try to read a packet as it is being written to disk. So it gets the
packet header (including the expected size of the packet), and attempts
to read beyond the end of the partially-copied packet. Live streaming
feature (we're working on this for the next release of lttng) will
handle thi use-cases.

Thanks,

Mathieu


> 
> Amit
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To:     Amit Margalit/Israel/IBM@IBMIL
> Cc:     lttng-dev@lists.lttng.org
> Date:   07/24/2013 04:20 PM
> Subject:        Re: [lttng-dev] Getting SIGBUS in babeltrace - 
> occasionally
> 
> 
> 
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > * Amit Margalit (AMITM@il.ibm.com) wrote:
> > > Hi,
> > > 
> > > I am getting occasional SIGBUS inside _aligned_integer_read() in 
> > > ./formats/ctf/types/integer.c
> > > 
> > > Here is the backtrace, maybe someone could take a look and suggest 
> > > something:
> > 
> > It looks like you're hitting the internal checks for overflow on the
> > buffer boundaries.
> 
> Please forget about my previous email, I'm utterly wrong. That should
> teach me to reply before my first morning coffee ;)
> 
> We indeed have internal checks for overflows in babeltrace, but those
> are not triggering SIGBUS ever, they return failure gracefully.
> 
> What seems to happen in your case is documented here:
> 
> mmap(2) manpage:
> 
>        SIGBUS Attempted access to a portion of the buffer that does not 
> corre‐
>               spond  to  the  file  (for  example, beyond the end of the 

> file,
>               including the case  where  another  process  has truncated 

> the
>               file).
> 
> I'm curious to learn which versions of babeltrace/ust/modules you are
> using, if you modified them (and how), and if you can get us a sample
> trace that triggers the issue.
> 
> Also, a bit of context about your setup: is this 32-bit or 64-bit
> user-space, which OS.
> 
> Hrm.
> 
> By any chance, is it possible that you record your trace on a platform
> with 4kB pages, and run babeltrace on it on a platform having 64kB
> pages? Everything points me to include/babeltrace/mmap-align.h
> mmap_align_addr(). We might be mmaping beyond the end of file in this
> case.
> 
> Thanks!
> 
> Mathieu
> 
> > 
> > On which babeltrace version can you reproduce it ? Did you do any
> > modification to babeltrace on your own on top ?
> > 
> > Are you getting this with a lttng-ust or lttng-modules trace ? If yes,
> > which version of the tool has generated the trace ?
> > 
> > Can you provide a sample trace that triggers this issue ?
> > 
> > Can you give us the detailed sequence of steps you use to reproduce ?
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > > #0  _aligned_integer_read (definition=0x954320, ppos=0x106e028) at 
> > > integer.c:81
> > > #1  ctf_integer_read (ppos=0x106e028, definition=0x954320) at 
> > > integer.c:224
> > > #2  0x00007ffff070e36e in generic_rw (definition=<optimized out>, 
> > > pos=0x106e028) at ../include/babeltrace/types.h:133
> > > #3  bt_struct_rw (ppos=0x106e028, definition=0x9542e0) at 
struct.c:56
> > > #4  0x00007ffff13f7fda in generic_rw (definition=<optimized out>, 
> > > pos=0x106e028) at ../../include/babeltrace/types.h:133
> > > #5  ctf_packet_seek (stream_pos=0x106e028, index=<optimized out>, 
> > > whence=<optimized out>) at ctf.c:860
> > > #6  0x00007ffff070a3f1 in seek_file_stream_by_timestamp 
> > > (cfs=cfs@entry=0x106cf90, 
> timestamp=timestamp@entry=1374636821498972926) 
> > > at iterator.c:141
> > > #7  0x00007ffff070aa96 in seek_ctf_trace_by_timestamp 
> > > (stream_heap=0x176d310, timestamp=1374636821498972926, 
tin=<optimized 
> > > out>) at iterator.c:188
> > > #8  bt_iter_set_pos (iter=iter@entry=0xfdafa0, iter_pos=0x2bf59f0) 
at 
> > > iterator.c:439
> > > #9  0x00007ffff1624f01 in _wrap__bt_iter_set_pos (self=<optimized 
> out>, 
> > > args=<optimized out>) at babeltrace_wrap.c:3805
> > > #10 0x00007ffff7b28c0c in call_function (oparg=<optimized out>, 
> > > pp_stack=<optimized out>) at Python/ceval.c:3679
> > > #11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=<optimized out>) at 
> > > Python/ceval.c:2370
> > > #12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx (co=0xa8e5d0, 
> > > globals=<optimized out>, locals=<optimized out>, args=0x2088cc8, 
> > > argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, closure=0x0)
> > >     at Python/ceval.c:2942
> > > .
> > > .
> > > .
> > > 
> > > Any suggestions are welcome.
> > > 
> > > Amit Margalit
> > > IBM XIV - Storage Reinvented
> > > XIV-NAS Development Team
> > > Tel. 03-689-7774
> > > Fax. 03-689-7230
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> > 
> > -- 
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com



--=_alternative 005B1ADFC2257BB2_=
Content-Type: text/html; charset="ISO-2022-JP"

<font size=2 face="sans-serif">Well, the live-streaming feature is more
than we need.</font>
<br>
<br><font size=2 face="sans-serif">We don't require the ability to sit
and watch events as they appear in the trace file.</font>
<br>
<br><font size=2 face="sans-serif">Is there a way to determine the &quot;latest
timestamp that is safe to access&quot; ?</font>
<br>
<br><font size=2 face="sans-serif">Currently, I am using get_timestamp_end()
on the trace handle and then I try to read the events at that point, and
if I fail, I simply try earlier times until I succeed in reading an event.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
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
&nbsp;</font><font size=1 face="sans-serif">Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">07/24/2013 07:14 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Getting SIGBUS in babeltrace - occasionally</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>* Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; Access beyond end of file seems to be the issue IIUC.<br>
&gt; <br>
&gt; Let me try to give as much context as I can and answer your questions
one <br>
&gt; by one:<br>
&gt; <br>
&gt; Versions<br>
&gt; <br>
&gt; lttng-ust 2.2.0, lttng-tools 2.2.0, babeltrace - I used git hash <br>
&gt; cc26a15ac355d886bb507955fdaec9b218024713 with a patch on babeltrace.i.in.<br>
&gt; <br>
&gt; [I cannot supply the patch as this requires my employer's (IBM) approval
- <br>
&gt; I am in the process of obtaining a permanent contribution approval,
but <br>
&gt; until then...]<br>
&gt; <br>
&gt; However, I can tell you exactly what it does:<br>
&gt; 1. Adds a typedef for 'ssize_t'<br>
&gt; 2. Added a call to _bt_ctf_get_decl_from_def() around the argument
<br>
&gt; supplied to _bt_ctf_get_int_len()<br>
&gt; 3. Changed all use of {} in string &quot;.format()&quot; calls to
add numbers (e.g. <br>
&gt; {0} instead of {}) - as this doesn't work for Python 2.6.<br>
&gt; <br>
&gt; I am waiting for the contribution approval and then I'll submit a
patch.<br>
&gt; <br>
&gt; To provide a trace sample, I'll need a special approval, which could
take <br>
&gt; very long.<br>
&gt; <br>
&gt; System Setup<br>
&gt; <br>
&gt; Processor: Xeon-family 6-cores (12 if you count HT)<br>
&gt; RAM: 24GB of RAM, page size is 4KB.<br>
&gt; OS: Linux 2.6.32.12-211_11_4_0 based on an MCP (IBM's SuSE derivative)
<br>
&gt; build.<br>
&gt; <br>
&gt; Tracing Setup<br>
&gt; <br>
&gt; Same system used to generate, collect and read the traces.<br>
&gt; 100% user-space.<br>
&gt; <br>
&gt; Triggering<br>
&gt; <br>
&gt; This is not readily reproducible. Some context:<br>
&gt; <br>
&gt; We have an in-house trace mechanism including a code instrumentor
and a <br>
&gt; curses-based viewer (actually urwid+python).<br>
&gt; My current project is to embed LTTng logging and trace capabilites
into <br>
&gt; several open-source projects, because we couldn't use our in-house
tracer <br>
&gt; without having GPL issues.<br>
&gt; I have written a back-end that enables our in-house viewer to display
<br>
&gt; Lttng traces, by linking with libbabeltrace (allowed by its LGPL license).<br>
&gt; <br>
&gt; As far as I can tell SIGBUS happens to me when I was doing a search.
This <br>
&gt; literally reads the events in sequence and tries to compare some fields
<br>
&gt; against some criteria.<br>
&gt; <br>
&gt; And here's the main reason why I think this is happening - I was adding
a <br>
&gt; trace (using add_traces_recursive(trace_dir,'ctf')) while the session
is <br>
&gt; active (i.e. not stopped).<br>
&gt; <br>
&gt; I can see 2 problematic scenarios here:<br>
&gt; <br>
&gt; Scenario 1<br>
&gt; <br>
&gt; When I add the trace to the context babeltrace performs mmap() according
<br>
&gt; to the size of the file(s) at that moment.<br>
&gt; The files keep growing.<br>
&gt; When I try to access new packets they may lie beyond the end of the
<br>
&gt; mmap'ed region. I think this should lead to SIGSEGV and not to SIGBUS.<br>
<br>
babeltrace only mmap packet by packet, never an entire file.<br>
<br>
&gt; <br>
&gt; Scenario 2<br>
&gt; <br>
&gt; Due to buffering issues, I could be having a race with the session
daemon, <br>
&gt; where my code reads the beginning of a packet that was already written
to <br>
&gt; the file, and try to access the contents, which were not yet written.
<br>
&gt; Again - could happen around the end of the file, with the session
still <br>
&gt; active.<br>
<br>
I think the reason is close to this scenario: I think that babeltrace<br>
try to read a packet as it is being written to disk. So it gets the<br>
packet header (including the expected size of the packet), and attempts<br>
to read beyond the end of the partially-copied packet. Live streaming<br>
feature (we're working on this for the next release of lttng) will<br>
handle thi use-cases.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
<br>
&gt; <br>
&gt; Amit<br>
&gt; <br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; From: &nbsp; Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
&gt; To: &nbsp; &nbsp; Amit Margalit/Israel/IBM@IBMIL<br>
&gt; Cc: &nbsp; &nbsp; lttng-dev@lists.lttng.org<br>
&gt; Date: &nbsp; 07/24/2013 04:20 PM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Getting SIGBUS
in babeltrace - <br>
&gt; occasionally<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:<br>
&gt; &gt; * Amit Margalit (AMITM@il.ibm.com) wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I am getting occasional SIGBUS inside _aligned_integer_read()
in <br>
&gt; &gt; &gt; ./formats/ctf/types/integer.c<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Here is the backtrace, maybe someone could take a look and
suggest <br>
&gt; &gt; &gt; something:<br>
&gt; &gt; <br>
&gt; &gt; It looks like you're hitting the internal checks for overflow
on the<br>
&gt; &gt; buffer boundaries.<br>
&gt; <br>
&gt; Please forget about my previous email, I'm utterly wrong. That should<br>
&gt; teach me to reply before my first morning coffee ;)<br>
&gt; <br>
&gt; We indeed have internal checks for overflows in babeltrace, but those<br>
&gt; are not triggering SIGBUS ever, they return failure gracefully.<br>
&gt; <br>
&gt; What seems to happen in your case is documented here:<br>
&gt; <br>
&gt; mmap(2) manpage:<br>
&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;SIGBUS Attempted access to a portion of
the buffer that does not <br>
&gt; corre‐<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spond &nbsp;to &nbsp;the
&nbsp;file &nbsp;(for &nbsp;example, beyond the end of the <br>
&gt; file,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; including the case
&nbsp;where &nbsp;another &nbsp;process &nbsp;has &nbsp;truncated <br>
&gt; the<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; file).<br>
&gt; <br>
&gt; I'm curious to learn which versions of babeltrace/ust/modules you
are<br>
&gt; using, if you modified them (and how), and if you can get us a sample<br>
&gt; trace that triggers the issue.<br>
&gt; <br>
&gt; Also, a bit of context about your setup: is this 32-bit or 64-bit<br>
&gt; user-space, which OS.<br>
&gt; <br>
&gt; Hrm.<br>
&gt; <br>
&gt; By any chance, is it possible that you record your trace on a platform<br>
&gt; with 4kB pages, and run babeltrace on it on a platform having 64kB<br>
&gt; pages? Everything points me to include/babeltrace/mmap-align.h<br>
&gt; mmap_align_addr(). We might be mmaping beyond the end of file in this<br>
&gt; case.<br>
&gt; <br>
&gt; Thanks!<br>
&gt; <br>
&gt; Mathieu<br>
&gt; <br>
&gt; &gt; <br>
&gt; &gt; On which babeltrace version can you reproduce it ? Did you do
any<br>
&gt; &gt; modification to babeltrace on your own on top ?<br>
&gt; &gt; <br>
&gt; &gt; Are you getting this with a lttng-ust or lttng-modules trace
? If yes,<br>
&gt; &gt; which version of the tool has generated the trace ?<br>
&gt; &gt; <br>
&gt; &gt; Can you provide a sample trace that triggers this issue ?<br>
&gt; &gt; <br>
&gt; &gt; Can you give us the detailed sequence of steps you use to reproduce
?<br>
&gt; &gt; <br>
&gt; &gt; Thanks,<br>
&gt; &gt; <br>
&gt; &gt; Mathieu<br>
&gt; &gt; <br>
&gt; &gt; &gt; #0 &nbsp;_aligned_integer_read (definition=0x954320, ppos=0x106e028)
at <br>
&gt; &gt; &gt; integer.c:81<br>
&gt; &gt; &gt; #1 &nbsp;ctf_integer_read (ppos=0x106e028, definition=0x954320)
at <br>
&gt; &gt; &gt; integer.c:224<br>
&gt; &gt; &gt; #2 &nbsp;0x00007ffff070e36e in generic_rw (definition=&lt;optimized
out&gt;, <br>
&gt; &gt; &gt; pos=0x106e028) at ../include/babeltrace/types.h:133<br>
&gt; &gt; &gt; #3 &nbsp;bt_struct_rw (ppos=0x106e028, definition=0x9542e0)
at struct.c:56<br>
&gt; &gt; &gt; #4 &nbsp;0x00007ffff13f7fda in generic_rw (definition=&lt;optimized
out&gt;, <br>
&gt; &gt; &gt; pos=0x106e028) at ../../include/babeltrace/types.h:133<br>
&gt; &gt; &gt; #5 &nbsp;ctf_packet_seek (stream_pos=0x106e028, index=&lt;optimized
out&gt;, <br>
&gt; &gt; &gt; whence=&lt;optimized out&gt;) at ctf.c:860<br>
&gt; &gt; &gt; #6 &nbsp;0x00007ffff070a3f1 in seek_file_stream_by_timestamp
<br>
&gt; &gt; &gt; (cfs=cfs@entry=0x106cf90, <br>
&gt; timestamp=timestamp@entry=1374636821498972926) <br>
&gt; &gt; &gt; at iterator.c:141<br>
&gt; &gt; &gt; #7 &nbsp;0x00007ffff070aa96 in seek_ctf_trace_by_timestamp
<br>
&gt; &gt; &gt; (stream_heap=0x176d310, timestamp=1374636821498972926, tin=&lt;optimized
<br>
&gt; &gt; &gt; out&gt;) at iterator.c:188<br>
&gt; &gt; &gt; #8 &nbsp;bt_iter_set_pos (iter=iter@entry=0xfdafa0, iter_pos=0x2bf59f0)
at <br>
&gt; &gt; &gt; iterator.c:439<br>
&gt; &gt; &gt; #9 &nbsp;0x00007ffff1624f01 in _wrap__bt_iter_set_pos (self=&lt;optimized
<br>
&gt; out&gt;, <br>
&gt; &gt; &gt; args=&lt;optimized out&gt;) at babeltrace_wrap.c:3805<br>
&gt; &gt; &gt; #10 0x00007ffff7b28c0c in call_function (oparg=&lt;optimized
out&gt;, <br>
&gt; &gt; &gt; pp_stack=&lt;optimized out&gt;) at Python/ceval.c:3679<br>
&gt; &gt; &gt; #11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=&lt;optimized
out&gt;) at <br>
&gt; &gt; &gt; Python/ceval.c:2370<br>
&gt; &gt; &gt; #12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx (co=0xa8e5d0,
<br>
&gt; &gt; &gt; globals=&lt;optimized out&gt;, locals=&lt;optimized out&gt;,
args=0x2088cc8, <br>
&gt; &gt; &gt; argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, closure=0x0)<br>
&gt; &gt; &gt; &nbsp; &nbsp; at Python/ceval.c:2942<br>
&gt; &gt; &gt; .<br>
&gt; &gt; &gt; .<br>
&gt; &gt; &gt; .<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Any suggestions are welcome.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Amit Margalit<br>
&gt; &gt; &gt; IBM XIV - Storage Reinvented<br>
&gt; &gt; &gt; XIV-NAS Development Team<br>
&gt; &gt; &gt; Tel. 03-689-7774<br>
&gt; &gt; &gt; Fax. 03-689-7230<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; lttng-dev mailing list<br>
&gt; &gt; &gt; lttng-dev@lists.lttng.org<br>
&gt; &gt; &gt; </font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; -- <br>
&gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; </font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
&gt; <br>
&gt; -- <br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; </font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
&gt; <br>
&gt; <br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
</font></tt><a href=http://www.efficios.com/><tt><font size=2>http://www.efficios.com</font></tt></a><tt><font size=2><br>
<br>
</font></tt>
<br>
--=_alternative 005B1ADFC2257BB2_=--



--===============1447435264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1447435264==--
