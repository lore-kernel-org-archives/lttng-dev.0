From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Question about filtering bytecode
Date: Mon, 22 Jul 2013 09:14:47 +0300
Message-ID: <OF3B7B9B59.C4105F2D-ONC2257BB0.00220963-C2257BB0.00223F6C__20061.2906403423$1374473769$gmane$org@il.ibm.com>
References: <OFA394F5DC.943733C6-ONC2257BAC.00273BA0-C2257BAC.00277FA2@il.ibm.com>	<CA+jJMxtsA04qYmOiLeHEy2X03VK_Q0g3jf3Duj7Ax5ySBycC-Q@mail.gmail.com>
	<OFD3697F49.CCBA3299-ONC2257BAF.001EE8B3-C2257BAF.00202779@il.ibm.com>
	<CA+jJMxtnmCvaz9K_7VqOuuiKx=cYcYaYeg11xn5Ko8LY20609g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0216331006=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1V19Om-0003Xr-Hm
	for lttng-dev@lists.lttng.org; Mon, 22 Jul 2013 02:15:14 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 22 Jul 2013 07:10:23 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A56D917D8059
	for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2013 07:16:38 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r6M6Elqf27132108
	for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2013 06:14:47 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r6M6EwKw005866
	for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2013 00:14:58 -0600
In-Reply-To: <CA+jJMxtnmCvaz9K_7VqOuuiKx=cYcYaYeg11xn5Ko8LY20609g@mail.gmail.com>
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
--===============0216331006==
Content-Type: multipart/alternative; boundary="=_alternative 00223F3BC2257BB0_="

This is a multipart message in MIME format.
--=_alternative 00223F3BC2257BB0_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanations.

I currently feel that the effort to get such a thing working is not going=20
to materialize in the timeframe required for my current work, and=20
therefore, regrettably, I will have to work around this somehow. I am=20
currently thinking of using a combination of Python and Cython to generate =

a wrapper for the babeltrace iterator. We'll see.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   07/21/2013 10:07 PM
Subject:        Re: [lttng-dev] Question about filtering bytecode
Sent by:        jeremie.galarneau@gmail.com



On Sun, Jul 21, 2013 at 1:51 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
> Hi,
>
> I was thinking more about a programmer's guide to using this mechanism.
>

Unfortunately there is no programmer's guide on filters, but feel free
to ask about specifics.

> What I'd like to do is to have Babeltrace filter events it is showing me
> from an existing trace.
>
> Consider the following example:
>
> There are 3 types of tracepoints being captured (without filtering):
>
> A debug log message (occasionally) which includes a "debug=5Flevel" value
> (1..10 with 1 being highest importance).
> Function entry (via gcc -finstrument-functions or other=20
instrumentation).
> Function exit (similarly).
>
> During a 1-hour period, I have 2-3 GB of trace data captured.
> The trace includes events from 4 different processes.
>
>
> If I use Babeltrace to read the trace I will get an enormously big=20
result in
> text (~30-40GB at least).
>
> I would like to be able to do something like this:
>
> $ babeltrace --filter '$ctx.procname =3D=3D "smbd" || debug=5Flevel < 3'
> /local/lttng-traces/ust/uid/2140/64-bit
>
> This would then let me see any events from the "smbd" process (since i=20
added
> procname to the context using lttng add-context) or debug messages from=20
all
> processes where the debug level is 1 or 2.
>

That would be a neat feature! There are currently no plans to support
filtering in Babeltrace, but that contribution would be welcome.
lttng-ust's filtering code is licensed under LGPL v2.1 so it could be
library-fied and used by the ctf-text plug-in. In the meantime, I
guess you could work around this limitation with a combination of AWK
and shell scripting...

> Regarding linking - I am referring to the function
> lttng=5Fenabler=5Fevent=5Flink=5Fbytecode(), called from
> lttng-ust/liblttng-ust/lttng-events.c around line 628.
>

Thanks for clarifying!

Keep in mind that the filter's byte code is generated by the lttng
binary without knowing the events' declarations. Thus, the byte code
must go through a linking stage not completely unlike what is done by
a regular linker. One of the objectives of the linking stage is
setting the appropriate offsets to load an event's fields. The byte
code is also "specialized" by resolving each field's type and making
sure the appropriate implementation of each operator is used. For
instance, the FILTER=5FOP=5FEQ (check for equality) op-code is not
implemented the same way for integers, doubles and strings (see
lttng=5Ffilter=5Fspecialize=5Fbytecode in lttng-filter-specialize.c).

You may want to have a look at =5Flttng=5Ffilter=5Fevent=5Flink=5Fbytecode
(lttng-ust/liblttng-ust/lttng-filter.c, line 318) to see how each step
of the linking process is implemented.

Regards,
J=E9r=E9mie

> Thanks,
>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
>
> From:        J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> To:        Amit Margalit/Israel/IBM@IBMIL
> Cc:        lttng-dev@lists.lttng.org
> Date:        07/18/2013 07:10 PM
> Subject:        Re: [lttng-dev] Question about filtering bytecode
> Sent by:        jeremie.galarneau@gmail.com
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F
>
>
>
> Hi Amit,
>
> You may find information on the Babeltrace API in babeltrace/doc/API.txt
> The filtering mechanism used by the user space tracer is unrelated to
> Babeltrace.
>
> As for the sequence of events, this is how I understand it.
>
> When invoking the "lttng" binary with --enable-event and a filter
> option, a byte code is generated from the filtering rules
> (lttng-tools/src/lib/lttng-ctl/lttng-ctl.c:704). This byte code is
> then handed off to the session-daemon.
>
> Then, when an instrumented application is launched and connects to the
> session-daemon, it receives the byte code while its events are being
> enabled. To answer your question directly, that byte code will be
> executed by the tracee when the event is "triggered"
> (lttng-ust/liblttng-ust/lttng-filter-interpreter.c:175).
>
> I'm not sure I understand your question about filter/event linking. A
> filter has to be linked to an event since its rules (expressions) are
> applied on that event's values. Could you clarify if that's not what
> you meant?
>
> Regards,
> J=E9r=E9mie
>
> On Thu, Jul 18, 2013 at 3:12 AM, Amit Margalit <AMITM@il.ibm.com> wrote:
>> Hi,
>>
>> I'm considering whether I can write a wrapper for the libbabeltrace ctf
>> iterator which provides a filtered "next()" method.
>>
>> I've started reading the code in the hopes of understanding how to do
>> this,
>> and yet, I'd really appreciate a link to some ordered documentation, or =

-
>> any other kind of explanation.
>>
>> For example, one thing I still don't understand is the exact sequence,=20
and
>> where the bytecode is actually executed? What is the meaning and=20
purpose
>> of
>> "linking" the filter to an event.
>>
>> Thanks,
>>
>> Amit Margalit
>> IBM XIV - Storage Reinvented
>> XIV-NAS Development Team
>> Tel. 03-689-7774
>> Fax. 03-689-7230
>> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
>



--=20
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com



--=_alternative 00223F3BC2257BB0_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Thanks for the explanations.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I currently feel that the effort to
get such a thing working is not going to materialize in the timeframe requi=
red
for my current work, and therefore, regrettably, I will have to work around
this somehow. I am currently thinking of using a combination of Python
and Cython to generate a wrapper for the babeltrace iterator. We'll see.</f=
ont>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">07/21/2013 10:07 PM</font>
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
<br><tt><font size=3D2>On Sun, Jul 21, 2013 at 1:51 AM, Amit Margalit &lt;A=
MITM@il.ibm.com&gt;
wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I was thinking more about a programmer's guide to using this mechanism=
.<br>
&gt;<br>
<br>
Unfortunately there is no programmer's guide on filters, but feel free<br>
to ask about specifics.<br>
<br>
&gt; What I'd like to do is to have Babeltrace filter events it is showing
me<br>
&gt; from an existing trace.<br>
&gt;<br>
&gt; Consider the following example:<br>
&gt;<br>
&gt; There are 3 types of tracepoints being captured (without filtering):<b=
r>
&gt;<br>
&gt; A debug log message (occasionally) which includes a &quot;debug=5Fleve=
l&quot;
value<br>
&gt; (1..10 with 1 being highest importance).<br>
&gt; Function entry (via gcc -finstrument-functions or other instrumentatio=
n).<br>
&gt; Function exit (similarly).<br>
&gt;<br>
&gt; During a 1-hour period, I have 2-3 GB of trace data captured.<br>
&gt; The trace includes events from 4 different processes.<br>
&gt;<br>
&gt;<br>
&gt; If I use Babeltrace to read the trace I will get an enormously big
result in<br>
&gt; text (~30-40GB at least).<br>
&gt;<br>
&gt; I would like to be able to do something like this:<br>
&gt;<br>
&gt; $ babeltrace --filter '$ctx.procname =3D=3D &quot;smbd&quot; || debug=
=5Flevel
&lt; 3'<br>
&gt; /local/lttng-traces/ust/uid/2140/64-bit<br>
&gt;<br>
&gt; This would then let me see any events from the &quot;smbd&quot; process
(since i added<br>
&gt; procname to the context using lttng add-context) or debug messages
from all<br>
&gt; processes where the debug level is 1 or 2.<br>
&gt;<br>
<br>
That would be a neat feature! There are currently no plans to support<br>
filtering in Babeltrace, but that contribution would be welcome.<br>
lttng-ust's filtering code is licensed under LGPL v2.1 so it could be<br>
library-fied and used by the ctf-text plug-in. In the meantime, I<br>
guess you could work around this limitation with a combination of AWK<br>
and shell scripting...<br>
<br>
&gt; Regarding linking - I am referring to the function<br>
&gt; lttng=5Fenabler=5Fevent=5Flink=5Fbytecode(), called from<br>
&gt; lttng-ust/liblttng-ust/lttng-events.c around line 628.<br>
&gt;<br>
<br>
Thanks for clarifying!<br>
<br>
Keep in mind that the filter's byte code is generated by the lttng<br>
binary without knowing the events' declarations. Thus, the byte code<br>
must go through a linking stage not completely unlike what is done by<br>
a regular linker. One of the objectives of the linking stage is<br>
setting the appropriate offsets to load an event's fields. The byte<br>
code is also &quot;specialized&quot; by resolving each field's type and
making<br>
sure the appropriate implementation of each operator is used. For<br>
instance, the FILTER=5FOP=5FEQ (check for equality) op-code is not<br>
implemented the same way for integers, doubles and strings (see<br>
lttng=5Ffilter=5Fspecialize=5Fbytecode in lttng-filter-specialize.c).<br>
<br>
You may want to have a look at =5Flttng=5Ffilter=5Fevent=5Flink=5Fbytecode<=
br>
(lttng-ust/liblttng-ust/lttng-filter.c, line 318) to see how each step<br>
of the linking process is implemented.<br>
<br>
Regards,<br>
J=E9r=E9mie<br>
<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Amit Margalit<br>
&gt; IBM XIV - Storage Reinvented<br>
&gt; XIV-NAS Development Team<br>
&gt; Tel. 03-689-7774<br>
&gt; Fax. 03-689-7230<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: &nbsp; &nbsp; &nbsp; &nbsp;J=E9r=E9mie Galarneau &lt;jeremie.gal=
arneau@efficios.com&gt;<br>
&gt; To: &nbsp; &nbsp; &nbsp; &nbsp;Amit Margalit/Israel/IBM@IBMIL<br>
&gt; Cc: &nbsp; &nbsp; &nbsp; &nbsp;lttng-dev@lists.lttng.org<br>
&gt; Date: &nbsp; &nbsp; &nbsp; &nbsp;07/18/2013 07:10 PM<br>
&gt; Subject: &nbsp; &nbsp; &nbsp; &nbsp;Re: [lttng-dev] Question about
filtering bytecode<br>
&gt; Sent by: &nbsp; &nbsp; &nbsp; &nbsp;jeremie.galarneau@gmail.com<br>
&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Amit,<br>
&gt;<br>
&gt; You may find information on the Babeltrace API in babeltrace/doc/API.t=
xt<br>
&gt; The filtering mechanism used by the user space tracer is unrelated
to<br>
&gt; Babeltrace.<br>
&gt;<br>
&gt; As for the sequence of events, this is how I understand it.<br>
&gt;<br>
&gt; When invoking the &quot;lttng&quot; binary with --enable-event and
a filter<br>
&gt; option, a byte code is generated from the filtering rules<br>
&gt; (lttng-tools/src/lib/lttng-ctl/lttng-ctl.c:704). This byte code is<br>
&gt; then handed off to the session-daemon.<br>
&gt;<br>
&gt; Then, when an instrumented application is launched and connects to
the<br>
&gt; session-daemon, it receives the byte code while its events are being<b=
r>
&gt; enabled. To answer your question directly, that byte code will be<br>
&gt; executed by the tracee when the event is &quot;triggered&quot;<br>
&gt; (lttng-ust/liblttng-ust/lttng-filter-interpreter.c:175).<br>
&gt;<br>
&gt; I'm not sure I understand your question about filter/event linking.
A<br>
&gt; filter has to be linked to an event since its rules (expressions)
are<br>
&gt; applied on that event's values. Could you clarify if that's not what<b=
r>
&gt; you meant?<br>
&gt;<br>
&gt; Regards,<br>
&gt; J=E9r=E9mie<br>
&gt;<br>
&gt; On Thu, Jul 18, 2013 at 3:12 AM, Amit Margalit &lt;AMITM@il.ibm.com&gt;
wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I'm considering whether I can write a wrapper for the libbabeltrace
ctf<br>
&gt;&gt; iterator which provides a filtered &quot;next()&quot; method.<br>
&gt;&gt;<br>
&gt;&gt; I've started reading the code in the hopes of understanding how
to do<br>
&gt;&gt; this,<br>
&gt;&gt; and yet, I'd really appreciate a link to some ordered documentatio=
n,
or -<br>
&gt;&gt; any other kind of explanation.<br>
&gt;&gt;<br>
&gt;&gt; For example, one thing I still don't understand is the exact seque=
nce,
and<br>
&gt;&gt; where the bytecode is actually executed? What is the meaning and
purpose<br>
&gt;&gt; of<br>
&gt;&gt; &quot;linking&quot; the filter to an event.<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;<br>
&gt;&gt; Amit Margalit<br>
&gt;&gt; IBM XIV - Storage Reinvented<br>
&gt;&gt; XIV-NAS Development Team<br>
&gt;&gt; Tel. 03-689-7774<br>
&gt;&gt; Fax. 03-689-7230<br>
&gt;&gt; =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; lttng-dev@lists.lttng.org<br>
&gt;&gt; </font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</font></tt></a><tt><font size=3D2><br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; J=E9r=E9mie Galarneau<br>
&gt; EfficiOS Inc.<br>
&gt; </font></tt><a href=3Dhttp://www.efficios.com/><tt><font size=3D2>http=
://www.efficios.com</font></tt></a><tt><font size=3D2><br>
&gt;<br>
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
--=_alternative 00223F3BC2257BB0_=--



--===============0216331006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0216331006==--
