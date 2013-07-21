From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Question about filtering bytecode
Date: Sun, 21 Jul 2013 08:51:55 +0300
Message-ID: <OFD3697F49.CCBA3299-ONC2257BAF.001EE8B3-C2257BAF.00202779__32150.0507336625$1374385994$gmane$org@il.ibm.com>
References: <OFA394F5DC.943733C6-ONC2257BAC.00273BA0-C2257BAC.00277FA2@il.ibm.com>
	<CA+jJMxtsA04qYmOiLeHEy2X03VK_Q0g3jf3Duj7Ax5ySBycC-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1997536748=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1V0mZ6-0008Jv-Jh
	for lttng-dev@lists.lttng.org; Sun, 21 Jul 2013 01:52:20 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 21 Jul 2013 06:46:17 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id EF42B1B0805F
	for <lttng-dev@lists.lttng.org>; Sun, 21 Jul 2013 06:52:05 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6L5psKH37748798
	for <lttng-dev@lists.lttng.org>; Sun, 21 Jul 2013 05:51:54 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6L5q5PY013127
	for <lttng-dev@lists.lttng.org>; Sat, 20 Jul 2013 23:52:05 -0600
In-Reply-To: <CA+jJMxtsA04qYmOiLeHEy2X03VK_Q0g3jf3Duj7Ax5ySBycC-Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, jeremie.galarneau@gmail.com
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1997536748==
Content-Type: multipart/alternative; boundary="=_alternative 00202708C2257BAF_="

This is a multipart message in MIME format.
--=_alternative 00202708C2257BAF_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I was thinking more about a programmer's guide to using this mechanism.

What I'd like to do is to have Babeltrace filter events it is showing me=20
from an existing trace.

Consider the following example:
There are 3 types of tracepoints being captured (without filtering):
A debug log message (occasionally) which includes a "debug=5Flevel" value=20
(1..10 with 1 being highest importance).
Function entry (via gcc -finstrument-functions or other instrumentation).
Function exit (similarly).
During a 1-hour period, I have 2-3 GB of trace data captured.
The trace includes events from 4 different processes.

If I use Babeltrace to read the trace I will get an enormously big result=20
in text (~30-40GB at least).

I would like to be able to do something like this:

$ babeltrace --filter '$ctx.procname =3D=3D "smbd" || debug=5Flevel < 3'=20
/local/lttng-traces/ust/uid/2140/64-bit

This would then let me see any events from the "smbd" process (since i=20
added procname to the context using lttng add-context) or debug messages=20
from all processes where the debug level is 1 or 2.

Regarding linking - I am referring to the function=20
lttng=5Fenabler=5Fevent=5Flink=5Fbytecode(), called from=20
lttng-ust/liblttng-ust/lttng-events.c around line 628.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   07/18/2013 07:10 PM
Subject:        Re: [lttng-dev] Question about filtering bytecode
Sent by:        jeremie.galarneau@gmail.com



Hi Amit,

You may find information on the Babeltrace API in babeltrace/doc/API.txt
The filtering mechanism used by the user space tracer is unrelated to
Babeltrace.

As for the sequence of events, this is how I understand it.

When invoking the "lttng" binary with --enable-event and a filter
option, a byte code is generated from the filtering rules
(lttng-tools/src/lib/lttng-ctl/lttng-ctl.c:704). This byte code is
then handed off to the session-daemon.

Then, when an instrumented application is launched and connects to the
session-daemon, it receives the byte code while its events are being
enabled. To answer your question directly, that byte code will be
executed by the tracee when the event is "triggered"
(lttng-ust/liblttng-ust/lttng-filter-interpreter.c:175).

I'm not sure I understand your question about filter/event linking. A
filter has to be linked to an event since its rules (expressions) are
applied on that event's values. Could you clarify if that's not what
you meant?

Regards,
J=E9r=E9mie

On Thu, Jul 18, 2013 at 3:12 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hi,
>
> I'm considering whether I can write a wrapper for the libbabeltrace ctf
> iterator which provides a filtered "next()" method.
>
> I've started reading the code in the hopes of understanding how to do=20
this,
> and yet, I'd really appreciate a link to some ordered documentation, or=20
-
> any other kind of explanation.
>
> For example, one thing I still don't understand is the exact sequence,=20
and
> where the bytecode is actually executed? What is the meaning and purpose =

of
> "linking" the filter to an event.
>
> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com



--=_alternative 00202708C2257BAF_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I was thinking more about a programm=
er's
guide to using this mechanism.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">What I'd like to do is to have Babel=
trace
filter events it is showing me from an existing trace.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Consider the following example:</fon=
t>
<ol>
<li value=3D1><font size=3D2 face=3D"sans-serif">There are 3 types of trace=
points
being captured (without filtering):</font>
<ol>
<li value=3D1><font size=3D2 face=3D"sans-serif">A debug log message (occas=
ionally)
which includes a &quot;debug=5Flevel&quot; value (1..10 with 1 being highest
importance).</font>
<li value=3D2><font size=3D2 face=3D"sans-serif">Function entry (via gcc -f=
instrument-functions
or other instrumentation).</font>
<li value=3D3><font size=3D2 face=3D"sans-serif">Function exit (similarly).=
</font></ol>
<li value=3D2><font size=3D2 face=3D"sans-serif">During a 1-hour period, I =
have
2-3 GB of trace data captured.</font>
<li value=3D3><font size=3D2 face=3D"sans-serif">The trace includes events =
from
4 different processes.</font></ol>
<br><font size=3D2 face=3D"sans-serif">If I use Babeltrace to read the trace
I will get an enormously big result in text (~30-40GB at least).</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I would like to be able to do someth=
ing
like this:</font>
<br>
<br><tt><font size=3D2>$ babeltrace --filter '$ctx.procname =3D=3D &quot;sm=
bd&quot;
|| debug=5Flevel &lt; 3' /local/lttng-traces/ust/uid/2140/64-bit</font></tt>
<br>
<br><font size=3D2 face=3D"sans-serif">This would then let me see any events
from the &quot;smbd&quot; process (since i added procname to the context
using lttng add-context) or debug messages from all processes where the
debug level is 1 or 2.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Regarding linking - I am referring to
the function </font><tt><font size=3D2>lttng=5Fenabler=5Fevent=5Flink=5Fbyt=
ecode()</font></tt><font size=3D2 face=3D"sans-serif">,
called from </font><tt><font size=3D2>lttng-ust/liblttng-ust/lttng-events.c=
</font></tt><font size=3D2 face=3D"sans-serif">
around line 628.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Thanks,</font>
<br>
<br><font size=3D2 color=3D#000080 face=3D"sans-serif">Amit Margalit</font>
<br><font size=3D2 color=3D#808000 face=3D"sans-serif">IBM XIV </font><font=
 size=3D2 face=3D"sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=3D2 face=3D"sans-serif">XIV-NAS Development Team</font>
<br><font size=3D2 face=3D"sans-serif">Tel. 03</font><font size=3D2 face=3D=
"Arial">-689-7774</font>
<br><font size=3D2 face=3D"Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">J=E9r=E9mie Galarneau &lt;j=
eremie.galarneau@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Amit Margalit/Israel/IBM@IB=
MIL</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">lttng-dev@lists.lttng.org</=
font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">07/18/2013 07:10 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
Question about filtering bytecode</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Sent by: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">jeremie.galarneau@gm=
ail.com</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>Hi Amit,<br>
<br>
You may find information on the Babeltrace API in babeltrace/doc/API.txt<br>
The filtering mechanism used by the user space tracer is unrelated to<br>
Babeltrace.<br>
<br>
As for the sequence of events, this is how I understand it.<br>
<br>
When invoking the &quot;lttng&quot; binary with --enable-event and a filter=
<br>
option, a byte code is generated from the filtering rules<br>
(lttng-tools/src/lib/lttng-ctl/lttng-ctl.c:704). This byte code is<br>
then handed off to the session-daemon.<br>
<br>
Then, when an instrumented application is launched and connects to the<br>
session-daemon, it receives the byte code while its events are being<br>
enabled. To answer your question directly, that byte code will be<br>
executed by the tracee when the event is &quot;triggered&quot;<br>
(lttng-ust/liblttng-ust/lttng-filter-interpreter.c:175).<br>
<br>
I'm not sure I understand your question about filter/event linking. A<br>
filter has to be linked to an event since its rules (expressions) are<br>
applied on that event's values. Could you clarify if that's not what<br>
you meant?<br>
<br>
Regards,<br>
J=E9r=E9mie<br>
<br>
On Thu, Jul 18, 2013 at 3:12 AM, Amit Margalit &lt;AMITM@il.ibm.com&gt;
wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I'm considering whether I can write a wrapper for the libbabeltrace
ctf<br>
&gt; iterator which provides a filtered &quot;next()&quot; method.<br>
&gt;<br>
&gt; I've started reading the code in the hopes of understanding how to
do this,<br>
&gt; and yet, I'd really appreciate a link to some ordered documentation,
or -<br>
&gt; any other kind of explanation.<br>
&gt;<br>
&gt; For example, one thing I still don't understand is the exact sequence,
and<br>
&gt; where the bytecode is actually executed? What is the meaning and purpo=
se
of<br>
&gt; &quot;linking&quot; the filter to an event.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; </font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</font></tt></a><tt><font size=3D2><br>
&gt;<br>
<br>
<br>
<br>
-- <br>
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
</font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http://ww=
w.efficios.com</font></tt></a><tt><font size=3D2><br>
<br>
</font></tt>
<br>
--=_alternative 00202708C2257BAF_=--



--===============1997536748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1997536748==--
