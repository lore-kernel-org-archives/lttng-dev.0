From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: efficient use of LTTng in legacy codebase
Date: Sun, 15 Dec 2013 14:56:27 +0200
Message-ID: <OFA420391C.226AC243-ONC2257C42.00460223-C2257C42.00471974__3531.65775673023$1387112291$gmane$org@il.ibm.com>
References: <ECCC3645D4115E4293D3E8C0EB22F09C20D363@ESESSMB109.ericsson.se>	<38714154.84070.1386809251111.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D3F6@ESESSMB109.ericsson.se>	<1206710241.84238.1386851719338.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D572@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808307473=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VsBFb-0002Gw-AU
	for lttng-dev@lists.lttng.org; Sun, 15 Dec 2013 07:56:57 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Sun, 15 Dec 2013 12:56:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 030E82190059
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 12:56:41 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rBFCuTXp63832230
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 12:56:29 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rBFCueKl024895
	for <lttng-dev@lists.lttng.org>; Sun, 15 Dec 2013 05:56:41 -0700
In-Reply-To: <ECCC3645D4115E4293D3E8C0EB22F09C20D572@ESESSMB109.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?M=E1t=E9_Ferenczy?= <mate.ferenczy@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1808307473==
Content-Type: multipart/alternative; boundary="=_alternative 0047192BC2257C42_="

This is a multipart message in MIME format.
--=_alternative 0047192BC2257C42_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

The macro is elegant and solves the problem nicely.

I find that it does not make the biggest issue go away - the entire=20
formatted string gets stored in the trace file multiple times.

The best solution would be:
To modify CTF and define a type that indicates a printf-style format=20
string.
To have a LTTng macro that provides this string to the tracer, so that it=20
can record it only once in the metadata.
To have the tracepoint store all the arguments in binary form, possibly=20
with the addition of some identifying value of the format string.
And to have babeltrace (the CTF trace reader) perform the formatting=20
off-line.

I mean - consider a trace message that includes a long format string, with =

say - 5 integer arguments. Something like:
"Buffer vacancy threshold warning: curr=5Flimit=3D%d, curr=5Fthreshold=3D%d=
,=20
channel=5Fnum=3D%d, high=5Fmark=3D%d, hit=5Fcount=3D%d"

This stores > 105 bytes with every trace line. But the real information=20
here is only 20 bytes (assuming the integers are 32-bits).

Storing the format string once in the metadata will effectively boost=20
performance for a system trying to trace like this.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   M=E1t=E9 Ferenczy <mate.ferenczy@ericsson.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Date:   12/12/2013 07:39 PM
Subject:        Re: [lttng-dev] efficient use of LTTng in legacy codebase



That?s even better, as far as I see we do not even have to touch the=20
liblttng code itself.
Will get back with comments if any after testing.
=20
Thanks so much!=20
mate
=20
=20
From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]=20
Sent: Thursday, December 12, 2013 4:35 AM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org
Subject: Re: efficient use of LTTng in legacy codebase
=20
Just to speed things up, please have a look at the proposed UST patch.=20
(it's not in mainline yet)
=20
This is specifically for a demo program example so far.
=20
Comments are welcome,
=20
Thanks,
=20
Mathieu
=20
=20

From: "M=E1t=E9 Ferenczy" <mate.ferenczy@ericsson.com>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Sent: Wednesday, December 11, 2013 8:52:30 PM
Subject: RE: efficient use of LTTng in legacy codebase
=20
It sounds great, I like the idea. Just to make sure I understand your=20
suggestion, are we talking about converting the variable argument list to=20
string in include/lttng/ust-tracepoint-event-write.h?
=20
For example:
#define ctf=5Fformat=5Fstring(=5Fitem, ?)                               \
        do {                                                      \
            char =5Fbuf[BUF=5FMAXLEN];                               \
            snprintf(buf, sizeof(=5Fbuf), =5F=5FVA=5FARGS=5F=5F);          =
  \
            =5Fctf=5Fstring(=5Fitem, =5Fbuf, 0);                         \
       } while(0)
=20
Or do you have some better place to put this logic?
=20
Thanks,
Mate
=20
From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]=20
Sent: Wednesday, December 11, 2013 4:48 PM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org
Subject: Re: efficient use of LTTng in legacy codebase
=20

From: "M=E1t=E9 Ferenczy" <mate.ferenczy@ericsson.com>
To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Sent: Wednesday, December 11, 2013 6:52:22 PM
Subject: RE: efficient use of LTTng in legacy codebase
=20
I found this email thread:=20
https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html
According to this I could just check=20
caa=5Funlikely(=5F=5Ftracepoint=5F##provider##=5F=5F=5F##name.state). Howev=
er, Dave=20
claims that this state will stay true even if the tracepoint is disabled.=20
Is there anything else I should check for?
=20
I would recommend doing this in the UST probe provider instead. Within the =

TRACEPOINT=5FEVENT "TP=5FFIELD" section, when you declare your string field=
,=20
you could parse the format string there in the last argument of a=20
ctf=5Fstring() (a statement expression). The format string would be receive=
d=20
as parameter by the tracepoint, along with a variable arg list (...). In=20
the probe, it would be turned into a va=5Flist (see stdarg(3)), and the=20
parameters could be decoded into a string there. This has the benefit of=20
moving the serialization call out-of-line into the probe provider rather=20
than clobbering the tracepoint call site.
=20
Thoughts ?
=20
Thanks,
=20
Mathieu
=20
Thanks,
Mate
=20
From: M=E1t=E9 Ferenczy=20
Sent: Wednesday, December 11, 2013 12:17 PM
To: 'mathieu.desnoyers@efficios.com'
Cc: 'lttng-dev@lists.lttng.org'
Subject: efficient use of LTTng in legacy codebase
Hello Mathieu,
Our team was asked to support LTTng UST solution in a legacy codebase. The =

existing codebase is fairly large, and the requirement is that we provide=20
all the existing logs and debugs in the system as LTTng traces.
The planned solution so far was just to pass everything we have as text=20
(strings) to LTTng. For that we obviously have to convert the printf-like=20
format string and parameter list to a string by calling snprintf before=20
giving the string to the LTTng API. That would however mean, that these=20
snprintfs are getting called every time even if there is no=20
listener/active trace session for the given trace. In this case, all those =

unnecessary snprintf calls may end up significantly impacting the=20
performance of our applications.
In order to work around this, we were thinking that if there was a way to=20
query the LTTng library from our application code whether there is an=20
active tracing session for the given trace level, we could avoid calling=20
those snprintfs in case they are not needed. Do you think it would be=20
feasible to easily get this data from LTTng lib? If yes, can you provide=20
us some pointers where to look at in order to do those changes ourselves?
Any suggestions are welcome.
Thank you,
Mate Ferenczy
=20
=20
--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
=20
=20
--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 0047192BC2257C42_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">The macro is elegant and solves the prob=
lem
nicely.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I find that it does not make the big=
gest
issue go away - the entire formatted string gets stored in the trace file
multiple times.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">The best solution would be:</font>
<ol>
<li value=3D1><font size=3D2 face=3D"sans-serif">To modify CTF and define a=
 type
that indicates a printf-style format string.</font>
<li value=3D2><font size=3D2 face=3D"sans-serif">To have a LTTng macro that=
 provides
this string to the tracer, so that it can record it <u>only once</u> in
the metadata.</font>
<li value=3D3><font size=3D2 face=3D"sans-serif">To have the tracepoint sto=
re
all the arguments in binary form, possibly with the addition of some identi=
fying
value of the format string.</font>
<li value=3D4><font size=3D2 face=3D"sans-serif">And to have babeltrace (the
CTF trace reader) perform the formatting off-line.</font></ol>
<br><font size=3D2 face=3D"sans-serif">I mean - consider a trace message th=
at
includes a long format string, with say - 5 integer arguments. Something
like:</font>
<br><font size=3D2 face=3D"sans-serif">&quot;Buffer vacancy threshold warni=
ng:
curr=5Flimit=3D%d, curr=5Fthreshold=3D%d, channel=5Fnum=3D%d, high=5Fmark=
=3D%d, hit=5Fcount=3D%d&quot;</font>
<br>
<br><font size=3D2 face=3D"sans-serif">This stores &gt; 105 bytes with <u>e=
very</u>
trace line. But the real information here is only 20 bytes (assuming the
integers are 32-bits).</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Storing the format string once in the
metadata will effectively boost performance for a system trying to trace
like this.</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">M=E1t=E9 Ferenczy &lt;mate.=
ferenczy@ericsson.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Mathieu Desnoyers &lt;mathi=
eu.desnoyers@efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">&quot;lttng-dev@lists.lttng=
.org&quot;
&lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">12/12/2013 07:39 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
efficient use of LTTng in legacy codebase</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">That&#8217;s even bette=
r, as far
as I see we do not even have to touch the liblttng code itself.</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">Will get back with comm=
ents
if any after testing.</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">Thanks so much! </font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">mate</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Tahoma"><b>From:</b> Mathieu Desnoyers [</font><=
a href=3Dmailto:mathieu.desnoyers@efficios.com><font size=3D2 face=3D"Tahom=
a">mailto:mathieu.desnoyers@efficios.com</font></a><font size=3D2 face=3D"T=
ahoma">]
<b><br>
Sent:</b> Thursday, December 12, 2013 4:35 AM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> lttng-dev@lists.lttng.org<b><br>
Subject:</b> Re: efficient use of LTTng in legacy codebase</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">Just to speed things up, please have a
look at the proposed UST patch. (it's not in mainline yet)</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">This is specifically for a demo program
example so far.</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">Comments are welcome,</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">Thanks,</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">Mathieu</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<div align=3Dcenter>
<hr></div>
<br><font size=3D2 face=3D"Helvetica"><b>From: </b>&quot;M=E1t=E9 Ferenczy&=
quot;
&lt;</font><a href=3Dmailto:mate.ferenczy@ericsson.com><font size=3D2 color=
=3Dblue face=3D"Helvetica"><u>mate.ferenczy@ericsson.com</u></font></a><fon=
t size=3D2 face=3D"Helvetica">&gt;<b><br>
To: </b>&quot;Mathieu Desnoyers&quot; &lt;</font><a href=3Dmailto:mathieu.d=
esnoyers@efficios.com><font size=3D2 color=3Dblue face=3D"Helvetica"><u>mat=
hieu.desnoyers@efficios.com</u></font></a><font size=3D2 face=3D"Helvetica"=
>&gt;<b><br>
Cc: </b></font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D2 =
color=3Dblue face=3D"Helvetica"><u>lttng-dev@lists.lttng.org</u></font></a>=
<font size=3D2 face=3D"Helvetica"><b><br>
Sent: </b>Wednesday, December 11, 2013 8:52:30 PM<b><br>
Subject: </b>RE: efficient use of LTTng in legacy codebase</font>
<br><font size=3D2 face=3D"Helvetica">&nbsp;</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">It sounds great, I like=
 the
idea. Just to make sure I understand your suggestion, are we talking about
converting the variable argument list to string in include/lttng/ust-tracep=
oint-event-write.h?</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">For example:</font>
<br><font size=3D2 color=3D#004080>#define ctf=5Fformat=5Fstring(=5Fitem, &=
#8230;) &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; \</font>
<br><font size=3D2 color=3D#004080>&nbsp; &nbsp; &nbsp; &nbsp; do { &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;\</font>
<br><font size=3D2 color=3D#004080>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
char =5Fbuf[BUF=5FMAXLEN]; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</font>
<br><font size=3D2 color=3D#004080>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
snprintf(buf, sizeof(=5Fbuf), =5F=5FVA=5FARGS=5F=5F); &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;
&nbsp;\</font>
<br><font size=3D2 color=3D#004080>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
=5Fctf=5Fstring(=5Fitem, =5Fbuf, 0); &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</font>
<br><font size=3D2 color=3D#004080>&nbsp; &nbsp; &nbsp; &nbsp;} while(0)</f=
ont>
<br><font size=3D2 color=3D#004080>&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">Or do you have some bet=
ter
place to put this logic?</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">Thanks,</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">Mate</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Tahoma"><b>From:</b> Mathieu Desnoyers [</font><=
a href=3Dmailto:mathieu.desnoyers@efficios.com><font size=3D2 color=3Dblue =
face=3D"Tahoma"><u>mailto:mathieu.desnoyers@efficios.com</u></font></a><fon=
t size=3D2 face=3D"Tahoma">]
<b><br>
Sent:</b> Wednesday, December 11, 2013 4:48 PM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> </font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D2 =
color=3Dblue face=3D"Tahoma"><u>lttng-dev@lists.lttng.org</u></font></a><fo=
nt size=3D2 face=3D"Tahoma"><b><br>
Subject:</b> Re: efficient use of LTTng in legacy codebase</font>
<br><font size=3D2 face=3D"Calibri">&nbsp;</font>
<div align=3Dcenter>
<hr></div>
<br><font size=3D2 face=3D"Helvetica"><b>From: </b>&quot;M=E1t=E9 Ferenczy&=
quot;
&lt;</font><a href=3Dmailto:mate.ferenczy@ericsson.com target=3D=5Fblank><f=
ont size=3D2 color=3Dblue face=3D"Helvetica"><u>mate.ferenczy@ericsson.com<=
/u></font></a><font size=3D2 face=3D"Helvetica">&gt;<b><br>
To: </b>&quot;mathieu desnoyers&quot; &lt;</font><a href=3Dmailto:mathieu.d=
esnoyers@efficios.com target=3D=5Fblank><font size=3D2 color=3Dblue face=3D=
"Helvetica"><u>mathieu.desnoyers@efficios.com</u></font></a><font size=3D2 =
face=3D"Helvetica">&gt;<b><br>
Cc: </b></font><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D=5Fbla=
nk><font size=3D2 color=3Dblue face=3D"Helvetica"><u>lttng-dev@lists.lttng.=
org</u></font></a><font size=3D2 face=3D"Helvetica"><b><br>
Sent: </b>Wednesday, December 11, 2013 6:52:22 PM<b><br>
Subject: </b>RE: efficient use of LTTng in legacy codebase</font>
<br><font size=3D2 face=3D"Helvetica">&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">I found this email thread: </font><a hr=
ef=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html"=
 target=3D=5Fblank><font size=3D2 color=3Dblue face=3D"Calibri"><u>https://=
www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html</u></font></a>
<br><font size=3D2 face=3D"Calibri">According to this I could just check ca=
a=5Funlikely(=5F=5Ftracepoint=5F##provider##=5F=5F=5F##name.state).
However, Dave claims that this state will stay true even if the tracepoint
is disabled. Is there anything else I should check for?</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>I would recommend doing this in the UST probe provider
instead. Within the TRACEPOINT=5FEVENT &quot;TP=5FFIELD&quot; section, when
you declare your string field, you could parse the format string there
in the last argument of a ctf=5Fstring() (a statement expression). The form=
at
string would be received as parameter by the tracepoint, along with a varia=
ble
arg list (...). In the probe, it would be turned into a va=5Flist (see stda=
rg(3)),
and the parameters could be decoded into a string there. This has the benef=
it
of moving the serialization call out-of-line into the probe provider rather
than clobbering the tracepoint call site.</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>Thoughts ?</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>Thanks,</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>Mathieu</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D2 face=3D"Calibri">Thanks,</font>
<br><font size=3D2 face=3D"Calibri">Mate</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Tahoma"><b>From:</b> M=E1t=E9 Ferenczy <b><br>
Sent:</b> Wednesday, December 11, 2013 12:17 PM<b><br>
To:</b> 'mathieu.desnoyers@efficios.com'<b><br>
Cc:</b> 'lttng-dev@lists.lttng.org'<b><br>
Subject:</b> efficient use of LTTng in legacy codebase</font>
<br><font size=3D2 face=3D"Calibri">Hello Mathieu,</font>
<br><font size=3D2 face=3D"Calibri">Our team was asked to support LTTng UST
solution in a legacy codebase. The existing codebase is fairly large, and
the requirement is that we provide all the existing logs and debugs in
the system as LTTng traces.</font>
<br><font size=3D2 face=3D"Calibri">The planned solution so far was just to
pass everything we have as text (strings) to LTTng. For that we obviously
have to convert the printf-like format string and parameter list to a string
by calling snprintf before giving the string to the LTTng API. That would
however mean, that these snprintfs are getting called every time even if
there is no listener/active trace session for the given trace. In this
case, all those unnecessary snprintf calls may end up significantly impacti=
ng
the performance of our applications.</font>
<br><font size=3D2 face=3D"Calibri">In order to work around this, we were t=
hinking
that if there was a way to query the LTTng library from our application
code whether there is an active tracing session for the given trace level,
we could avoid calling those snprintfs in case they are not needed. Do
you think it would be feasible to easily get this data from LTTng lib?
If yes, can you provide us some pointers where to look at in order to do
those changes ourselves?</font>
<br><font size=3D2 face=3D"Calibri">Any suggestions are welcome.</font>
<br><font size=3D2 face=3D"Calibri">Thank you,</font>
<br><font size=3D2 face=3D"Calibri">Mate Ferenczy</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>-- </font>
<br><font size=3D3>Mathieu Desnoyers<br>
EfficiOS Inc.</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3Dhttp://www.efficios.com/ target=3D=5Fblank><font size=
=3D3 color=3Dblue><u>http://www.efficios.com</u></font></a>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D3>-- </font>
<br><font size=3D3>Mathieu Desnoyers<br>
EfficiOS Inc.</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3Dhttp://www.efficios.com/><font size=3D3 color=3Dblue><=
u>http://www.efficios.com</u></font></a><tt><font size=3D2>=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev</font></tt></a><tt><font size=3D2><br>
</font></tt>
<br>
--=_alternative 0047192BC2257C42_=--



--===============1808307473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1808307473==--
