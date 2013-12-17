From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: efficient use of LTTng in legacy codebase
Date: Tue, 17 Dec 2013 09:35:31 +0200
Message-ID: <OF7A09BD18.DB100453-ONC2257C44.0025741C-C2257C44.0029B7A4__29590.141788549$1387265824$gmane$org@il.ibm.com>
References: <ECCC3645D4115E4293D3E8C0EB22F09C20D363@ESESSMB109.ericsson.se>	<38714154.84070.1386809251111.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D3F6@ESESSMB109.ericsson.se>	<1206710241.84238.1386851719338.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D572@ESESSMB109.ericsson.se>
	<OFA420391C.226AC243-ONC2257C42.00460223-C2257C42.00471974@il.ibm.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C22CC8E@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1604037369=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VspC4-0005Kw-Tk
	for lttng-dev@lists.lttng.org; Tue, 17 Dec 2013 02:36:01 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Tue, 17 Dec 2013 07:35:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C9A391B0805D
	for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2013 07:34:52 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
	[9.149.37.252])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rBH7ZWR61835454
	for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2013 07:35:32 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rBH7ZhvB023508
	for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2013 00:35:43 -0700
In-Reply-To: <ECCC3645D4115E4293D3E8C0EB22F09C22CC8E@ESESSMB109.ericsson.se>
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
--===============1604037369==
Content-Type: multipart/alternative; boundary="=_alternative 0029B77DC2257C44_="

This is a multipart message in MIME format.
--=_alternative 0029B77DC2257C44_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

You are absolutely right. However, looking at several existing code bases=20
that I am working with (our internal code, and a couple of open-source=20
projects I am adding LTTng support for), it is clear that the vast=20
majority of existing debug log statements have the following general form:

DEBUG=5FMACRO ( some=5Fargs, "lliteral format string", more args )

Amit

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   M=E1t=E9 Ferenczy <mate.ferenczy@ericsson.com>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu=20
Desnoyers <mathieu.desnoyers@efficios.com>
Date:   12/16/2013 03:11 AM
Subject:        RE: [lttng-dev] efficient use of LTTng in legacy codebase



I agree that in the long term it would be nice if the trace reader could=20
perform the formatting.
=20
However, I am not sure how #2 would work if the format strings and=20
argument lists are passed through a couple of function calls before=20
calling the tracepoint API (which is the case in our code).
=20
From: Amit Margalit [mailto:AMITM@il.ibm.com]=20
Sent: Sunday, December 15, 2013 4:56 AM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org; Mathieu Desnoyers
Subject: Re: [lttng-dev] efficient use of LTTng in legacy codebase
=20
The macro is elegant and solves the problem nicely.=20

I find that it does not make the biggest issue go away - the entire=20
formatted string gets stored in the trace file multiple times.=20

The best solution would be:=20
1.      To modify CTF and define a type that indicates a printf-style=20
format string.=20
2.      To have a LTTng macro that provides this string to the tracer, so=20
that it can record it only once in the metadata.=20
3.      To have the tracepoint store all the arguments in binary form,=20
possibly with the addition of some identifying value of the format string. =


4.      And to have babeltrace (the CTF trace reader) perform the=20
formatting off-line.

I mean - consider a trace message that includes a long format string, with =

say - 5 integer arguments. Something like:=20
"Buffer vacancy threshold warning: curr=5Flimit=3D%d, curr=5Fthreshold=3D%d=
,=20
channel=5Fnum=3D%d, high=5Fmark=3D%d, hit=5Fcount=3D%d"=20

This stores > 105 bytes with every trace line. But the real information=20
here is only 20 bytes (assuming the integers are 32-bits).=20

Storing the format string once in the metadata will effectively boost=20
performance for a system trying to trace like this.=20

Amit Margalit=20
IBM XIV - Storage Reinvented=20
XIV-NAS Development Team=20
Tel. 03-689-7774=20
Fax. 03-689-7230=20



From:        M=E1t=E9 Ferenczy <mate.ferenczy@ericsson.com>=20
To:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>=20
Cc:        "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>=20
Date:        12/12/2013 07:39 PM=20
Subject:        Re: [lttng-dev] efficient use of LTTng in legacy codebase=20




That?s even better, as far as I see we do not even have to touch the=20
liblttng code itself.=20
Will get back with comments if any after testing.=20
 =20
Thanks so much!=20
mate=20
 =20
 =20
From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]=20
Sent: Thursday, December 12, 2013 4:35 AM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org
Subject: Re: efficient use of LTTng in legacy codebase=20
 =20
Just to speed things up, please have a look at the proposed UST patch.=20
(it's not in mainline yet)=20
 =20
This is specifically for a demo program example so far.=20
 =20
Comments are welcome,=20
 =20
Thanks,=20
 =20
Mathieu=20
 =20
 =20


From: "M=E1t=E9 Ferenczy" <mate.ferenczy@ericsson.com>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Sent: Wednesday, December 11, 2013 8:52:30 PM
Subject: RE: efficient use of LTTng in legacy codebase=20
 =20
It sounds great, I like the idea. Just to make sure I understand your=20
suggestion, are we talking about converting the variable argument list to=20
string in include/lttng/ust-tracepoint-event-write.h?=20
 =20
For example:=20
#define ctf=5Fformat=5Fstring(=5Fitem, ?)                               \=20
        do {                                                      \=20
            char =5Fbuf[BUF=5FMAXLEN];                               \=20
            snprintf(buf, sizeof(=5Fbuf), =5F=5FVA=5FARGS=5F=5F);          =
  \=20
            =5Fctf=5Fstring(=5Fitem, =5Fbuf, 0);                         \ =

       } while(0)=20
       =20
Or do you have some better place to put this logic?=20
 =20
Thanks,=20
Mate=20
 =20
From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]=20
Sent: Wednesday, December 11, 2013 4:48 PM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org
Subject: Re: efficient use of LTTng in legacy codebase=20
 =20


From: "M=E1t=E9 Ferenczy" <mate.ferenczy@ericsson.com>
To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Sent: Wednesday, December 11, 2013 6:52:22 PM
Subject: RE: efficient use of LTTng in legacy codebase=20
 =20
I found this email thread:=20
https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02278.html=20
According to this I could just check=20
caa=5Funlikely(=5F=5Ftracepoint=5F##provider##=5F=5F=5F##name.state). Howev=
er, Dave=20
claims that this state will stay true even if the tracepoint is disabled.=20
Is there anything else I should check for?=20
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
than clobbering the tracepoint call site.=20
=20
Thoughts ?=20
=20
Thanks,=20
=20
Mathieu=20
 =20
Thanks,=20
Mate=20
 =20
From: M=E1t=E9 Ferenczy=20
Sent: Wednesday, December 11, 2013 12:17 PM
To: 'mathieu.desnoyers@efficios.com'
Cc: 'lttng-dev@lists.lttng.org'
Subject: efficient use of LTTng in legacy codebase=20
Hello Mathieu,=20
Our team was asked to support LTTng UST solution in a legacy codebase. The =

existing codebase is fairly large, and the requirement is that we provide=20
all the existing logs and debugs in the system as LTTng traces.=20
The planned solution so far was just to pass everything we have as text=20
(strings) to LTTng. For that we obviously have to convert the printf-like=20
format string and parameter list to a string by calling snprintf before=20
giving the string to the LTTng API. That would however mean, that these=20
snprintfs are getting called every time even if there is no=20
listener/active trace session for the given trace. In this case, all those =

unnecessary snprintf calls may end up significantly impacting the=20
performance of our applications.=20
In order to work around this, we were thinking that if there was a way to=20
query the LTTng library from our application code whether there is an=20
active tracing session for the given trace level, we could avoid calling=20
those snprintfs in case they are not needed. Do you think it would be=20
feasible to easily get this data from LTTng lib? If yes, can you provide=20
us some pointers where to look at in order to do those changes ourselves?=20
Any suggestions are welcome.=20
Thank you,=20
Mate Ferenczy=20
=20
=20
--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com=20
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

--=_alternative 0029B77DC2257C44_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">You are absolutely right. However, looki=
ng
at several existing code bases that I am working with (our internal code,
and a couple of open-source projects I am adding LTTng support for), it
is clear that the vast majority of existing debug log statements have the
following general form:</font>
<br>
<br><font size=3D2 face=3D"sans-serif">DEBUG=5FMACRO ( some=5Fargs, &quot;l=
literal
format string&quot;, more args )</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Amit</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">Amit Margalit/Israel/IBM@IB=
MIL</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">&quot;lttng-dev@lists.lttng=
.org&quot;
&lt;lttng-dev@lists.lttng.org&gt;, Mathieu Desnoyers &lt;mathieu.desnoyers@=
efficios.com&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">12/16/2013 03:11 AM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">RE: [lttng-dev]
efficient use of LTTng in legacy codebase</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">I agree that in the long
term it would be nice if the trace reader could perform the formatting.</fo=
nt>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">However, I am not sure =
how
#2 would work if the format strings and argument lists are passed through
a couple of function calls before calling the tracepoint API (which is
the case in our code).</font>
<br><font size=3D2 color=3D#004080 face=3D"Calibri">&nbsp;</font>
<br><font size=3D2 face=3D"Tahoma"><b>From:</b> Amit Margalit [</font><a hr=
ef=3Dmailto:AMITM@il.ibm.com><font size=3D2 face=3D"Tahoma">mailto:AMITM@il=
.ibm.com</font></a><font size=3D2 face=3D"Tahoma">]
<b><br>
Sent:</b> Sunday, December 15, 2013 4:56 AM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> lttng-dev@lists.lttng.org; Mathieu Desnoyers<b><br>
Subject:</b> Re: [lttng-dev] efficient use of LTTng in legacy codebase</fon=
t>
<br><font size=3D3>&nbsp;</font>
<br><font size=3D2 face=3D"Arial">The macro is elegant and solves the probl=
em
nicely.</font><font size=3D3> <br>
</font><font size=3D2 face=3D"Arial"><br>
I find that it does not make the biggest issue go away - the entire formatt=
ed
string gets stored in the trace file multiple times.</font><font size=3D3>
<br>
</font><font size=3D2 face=3D"Arial"><br>
The best solution would be:</font><font size=3D3> </font>
<br><font size=3D2 face=3D"sans-serif">1. &nbsp; &nbsp; &nbsp; &nbsp;</font=
><font size=3D2 face=3D"Arial">To
modify CTF and define a type that indicates a printf-style format string.</=
font><font size=3D3>
</font>
<br><font size=3D2 face=3D"sans-serif">2. &nbsp; &nbsp; &nbsp; &nbsp;</font=
><font size=3D2 face=3D"Arial">To
have a LTTng macro that provides this string to the tracer, so that it
can record it <u>only once</u> in the metadata.</font><font size=3D3> </fon=
t>
<br><font size=3D2 face=3D"sans-serif">3. &nbsp; &nbsp; &nbsp; &nbsp;</font=
><font size=3D2 face=3D"Arial">To
have the tracepoint store all the arguments in binary form, possibly with
the addition of some identifying value of the format string.</font><font si=
ze=3D3>
</font>
<br><font size=3D2 face=3D"sans-serif">4. &nbsp; &nbsp; &nbsp; &nbsp;</font=
><font size=3D2 face=3D"Arial">And
to have babeltrace (the CTF trace reader) perform the formatting off-line.<=
/font>
<br><font size=3D2 face=3D"Arial"><br>
I mean - consider a trace message that includes a long format string, with
say - 5 integer arguments. Something like:</font><font size=3D3> </font><fo=
nt size=3D2 face=3D"Arial"><br>
&quot;Buffer vacancy threshold warning: curr=5Flimit=3D%d, curr=5Fthreshold=
=3D%d,
channel=5Fnum=3D%d, high=5Fmark=3D%d, hit=5Fcount=3D%d&quot;</font><font si=
ze=3D3> <br>
</font><font size=3D2 face=3D"Arial"><br>
This stores &gt; 105 bytes with <u>every</u> trace line. But the real infor=
mation
here is only 20 bytes (assuming the integers are 32-bits).</font><font size=
=3D3>
<br>
</font><font size=3D2 face=3D"Arial"><br>
Storing the format string once in the metadata will effectively boost perfo=
rmance
for a system trying to trace like this.</font><font size=3D3> <br>
</font><font size=3D2 color=3D#000080 face=3D"Arial"><br>
Amit Margalit</font><font size=3D3> </font><font size=3D2 color=3D#808000 f=
ace=3D"Arial"><br>
IBM XIV </font><font size=3D2 face=3D"Arial">- <i>Storage Reinvented</i></f=
ont><font size=3D3>
</font><font size=3D2 face=3D"Arial"><br>
XIV-NAS Development Team</font><font size=3D3> </font><font size=3D2 face=
=3D"Arial"><br>
Tel. 03-689-7774</font><font size=3D3> </font><font size=3D2 face=3D"Arial"=
><br>
Fax. 03-689-7230</font><font size=3D3> <br>
<br>
<br>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
From: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"Arial">M=E1t=
=E9
Ferenczy &lt;</font><a href=3Dmailto:mate.ferenczy@ericsson.com><font size=
=3D1 color=3Dblue face=3D"Arial"><u>mate.ferenczy@ericsson.com</u></font></=
a><font size=3D1 face=3D"Arial">&gt;</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
To: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"Arial">Mathieu
Desnoyers &lt;</font><a href=3Dmailto:mathieu.desnoyers@efficios.com><font =
size=3D1 color=3Dblue face=3D"Arial"><u>mathieu.desnoyers@efficios.com</u><=
/font></a><font size=3D1 face=3D"Arial">&gt;</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
Cc: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"Arial">&quot;<=
/font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D1 color=3Db=
lue face=3D"Arial"><u>lttng-dev@lists.lttng.org</u></font></a><font size=3D=
1 face=3D"Arial">&quot;
&lt;</font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D1 colo=
r=3Dblue face=3D"Arial"><u>lttng-dev@lists.lttng.org</u></font></a><font si=
ze=3D1 face=3D"Arial">&gt;</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
Date: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"Arial">12/12=
/2013
07:39 PM</font><font size=3D3> </font><font size=3D1 color=3D#5f5f5f face=
=3D"Arial"><br>
Subject: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"Arial">Re:
[lttng-dev] efficient use of LTTng in legacy codebase</font><font size=3D3>
</font>
<div align=3Dcenter>
<hr noshade></div>
<br><font size=3D3><br>
<br>
</font><font size=3D2 color=3D#004080 face=3D"Calibri"><br>
That&#8217;s even better, as far as I see we do not even have to touch the =
liblttng
code itself.</font><font size=3D3> </font><font size=3D2 color=3D#004080 fa=
ce=3D"Calibri"><br>
Will get back with comments if any after testing.</font><font size=3D3> </f=
ont><font size=3D2 color=3D#004080 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 color=3D#004080 face=3D"=
Calibri"><br>
Thanks so much! <br>
mate</font><font size=3D3> </font><font size=3D2 color=3D#004080 face=3D"Ca=
libri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 color=3D#004080 face=3D"=
Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Tahoma"><b><br>
From:</b> Mathieu Desnoyers [</font><a href=3Dmailto:mathieu.desnoyers@effi=
cios.com><font size=3D2 color=3Dblue face=3D"Tahoma"><u>mailto:mathieu.desn=
oyers@efficios.com</u></font></a><font size=3D2 face=3D"Tahoma">]
<b><br>
Sent:</b> Thursday, December 12, 2013 4:35 AM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> </font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D2 =
color=3Dblue face=3D"Tahoma"><u>lttng-dev@lists.lttng.org</u></font></a><fo=
nt size=3D2 face=3D"Tahoma"><b><br>
Subject:</b> Re: efficient use of LTTng in legacy codebase</font><font size=
=3D3>
</font><font size=3D2 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
Just to speed things up, please have a look at the proposed UST patch.
(it's not in mainline yet)</font><font size=3D3> </font><font size=3D2 face=
=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
This is specifically for a demo program example so far.</font><font size=3D=
3>
</font><font size=3D2 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
Comments are welcome,</font><font size=3D3> </font><font size=3D2 face=3D"C=
alibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
Thanks,</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
Mathieu</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font>
<div align=3Dcenter>
<hr></div>
<br><font size=3D2 face=3D"Helvetica"><b><br>
From: </b>&quot;M=E1t=E9 Ferenczy&quot; &lt;</font><a href=3Dmailto:mate.fe=
renczy@ericsson.com><font size=3D2 color=3Dblue face=3D"Helvetica"><u>mate.=
ferenczy@ericsson.com</u></font></a><font size=3D2 face=3D"Helvetica">&gt;<=
b><br>
To: </b>&quot;Mathieu Desnoyers&quot; &lt;</font><a href=3Dmailto:mathieu.d=
esnoyers@efficios.com><font size=3D2 color=3Dblue face=3D"Helvetica"><u>mat=
hieu.desnoyers@efficios.com</u></font></a><font size=3D2 face=3D"Helvetica"=
>&gt;<b><br>
Cc: </b></font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D2 =
color=3Dblue face=3D"Helvetica"><u>lttng-dev@lists.lttng.org</u></font></a>=
<font size=3D2 face=3D"Helvetica"><b><br>
Sent: </b>Wednesday, December 11, 2013 8:52:30 PM<b><br>
Subject: </b>RE: efficient use of LTTng in legacy codebase</font><font size=
=3D3>
</font><font size=3D2 face=3D"Helvetica"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 color=3D#004080 face=3D"=
Calibri"><br>
It sounds great, I like the idea. Just to make sure I understand your sugge=
stion,
are we talking about converting the variable argument list to string in
include/lttng/ust-tracepoint-event-write.h?</font><font size=3D3> </font><f=
ont size=3D2 color=3D#004080 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 color=3D#004080 face=3D"=
Calibri"><br>
For example:</font><font size=3D3> </font><font size=3D2 color=3D#004080><b=
r>
#define ctf=5Fformat=5Fstring(=5Fitem, &#8230;) &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</fo=
nt><font size=3D3>
</font><font size=3D2 color=3D#004080><br>
 &nbsp; &nbsp; &nbsp; &nbsp;do { &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\</fon=
t><font size=3D3>
</font><font size=3D2 color=3D#004080><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;char =5Fbuf[BUF=5FMAXLEN]; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; \</font><font size=3D3> </font><font size=3D2 color=3D=
#004080><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;snprintf(buf, sizeof(=5Fbuf), =5F=
=5FVA=5FARGS=5F=5F);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\</font><font size=3D3> </font><fo=
nt size=3D2 color=3D#004080><br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=5Fctf=5Fstring(=5Fitem, =5Fbuf, =
0);
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; \</font><font size=3D3> </font><font size=3D2 color=3D#004080><br>
 &nbsp; &nbsp; &nbsp; } while(0)</font><font size=3D3> </font><font size=3D=
2 color=3D#004080><br>
 &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D2 color=3D#004080 face=3D"C=
alibri"><br>
Or do you have some better place to put this logic?</font><font size=3D3>
</font><font size=3D2 color=3D#004080 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 color=3D#004080 face=3D"=
Calibri"><br>
Thanks,</font><font size=3D3> </font><font size=3D2 color=3D#004080 face=3D=
"Calibri"><br>
Mate</font><font size=3D3> </font><font size=3D2 color=3D#004080 face=3D"Ca=
libri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Tahoma"><b><br>
From:</b> Mathieu Desnoyers [</font><a href=3Dmailto:mathieu.desnoyers@effi=
cios.com><font size=3D2 color=3Dblue face=3D"Tahoma"><u>mailto:mathieu.desn=
oyers@efficios.com</u></font></a><font size=3D2 face=3D"Tahoma">]
<b><br>
Sent:</b> Wednesday, December 11, 2013 4:48 PM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> </font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D2 =
color=3Dblue face=3D"Tahoma"><u>lttng-dev@lists.lttng.org</u></font></a><fo=
nt size=3D2 face=3D"Tahoma"><b><br>
Subject:</b> Re: efficient use of LTTng in legacy codebase</font><font size=
=3D3>
</font><font size=3D2 face=3D"Calibri"><br>
 </font><font size=3D3>&nbsp;</font>
<div align=3Dcenter>
<hr></div>
<br><font size=3D2 face=3D"Helvetica"><b><br>
From: </b>&quot;M=E1t=E9 Ferenczy&quot; &lt;</font><a href=3Dmailto:mate.fe=
renczy@ericsson.com target=3D=5Fblank><font size=3D2 color=3Dblue face=3D"H=
elvetica"><u>mate.ferenczy@ericsson.com</u></font></a><font size=3D2 face=
=3D"Helvetica">&gt;<b><br>
To: </b>&quot;mathieu desnoyers&quot; &lt;</font><a href=3Dmailto:mathieu.d=
esnoyers@efficios.com target=3D=5Fblank><font size=3D2 color=3Dblue face=3D=
"Helvetica"><u>mathieu.desnoyers@efficios.com</u></font></a><font size=3D2 =
face=3D"Helvetica">&gt;<b><br>
Cc: </b></font><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D=5Fbla=
nk><font size=3D2 color=3Dblue face=3D"Helvetica"><u>lttng-dev@lists.lttng.=
org</u></font></a><font size=3D2 face=3D"Helvetica"><b><br>
Sent: </b>Wednesday, December 11, 2013 6:52:22 PM<b><br>
Subject: </b>RE: efficient use of LTTng in legacy codebase</font><font size=
=3D3>
</font><font size=3D2 face=3D"Helvetica"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Calibri"><br>
I found this email thread: </font><a href=3D"https://www.mail-archive.com/l=
ttng-dev@lists.lttng.org/msg02278.html" target=3D=5Fblank><font size=3D2 co=
lor=3Dblue face=3D"Calibri"><u>https://www.mail-archive.com/lttng-dev@lists=
.lttng.org/msg02278.html</u></font></a><font size=3D3>
</font><font size=3D2 face=3D"Calibri"><br>
According to this I could just check caa=5Funlikely(=5F=5Ftracepoint=5F##pr=
ovider##=5F=5F=5F##name.state).
However, Dave claims that this state will stay true even if the tracepoint
is disabled. Is there anything else I should check for?</font><font size=3D=
3>
<br>
 &nbsp;<br>
I would recommend doing this in the UST probe provider instead. Within
the TRACEPOINT=5FEVENT &quot;TP=5FFIELD&quot; section, when you declare your
string field, you could parse the format string there in the last argument
of a ctf=5Fstring() (a statement expression). The format string would be
received as parameter by the tracepoint, along with a variable arg list
(...). In the probe, it would be turned into a va=5Flist (see stdarg(3)),
and the parameters could be decoded into a string there. This has the benef=
it
of moving the serialization call out-of-line into the probe provider rather
than clobbering the tracepoint call site. <br>
 &nbsp;<br>
Thoughts ? <br>
 &nbsp;<br>
Thanks, <br>
 &nbsp;<br>
Mathieu <br>
 &nbsp;</font><font size=3D2 face=3D"Calibri"><br>
Thanks,</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
Mate</font><font size=3D3> </font><font size=3D2 color=3D#004080 face=3D"Ca=
libri"><br>
 </font><font size=3D3>&nbsp;</font><font size=3D2 face=3D"Tahoma"><b><br>
From:</b> M=E1t=E9 Ferenczy <b><br>
Sent:</b> Wednesday, December 11, 2013 12:17 PM<b><br>
To:</b> 'mathieu.desnoyers@efficios.com'<b><br>
Cc:</b> 'lttng-dev@lists.lttng.org'<b><br>
Subject:</b> efficient use of LTTng in legacy codebase</font><font size=3D3>
</font><font size=3D2 face=3D"Calibri"><br>
Hello Mathieu,</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"=
><br>
Our team was asked to support LTTng UST solution in a legacy codebase.
The existing codebase is fairly large, and the requirement is that we provi=
de
all the existing logs and debugs in the system as LTTng traces.</font><font=
 size=3D3>
</font><font size=3D2 face=3D"Calibri"><br>
The planned solution so far was just to pass everything we have as text
(strings) to LTTng. For that we obviously have to convert the printf-like
format string and parameter list to a string by calling snprintf before
giving the string to the LTTng API. That would however mean, that these
snprintfs are getting called every time even if there is no listener/active
trace session for the given trace. In this case, all those unnecessary
snprintf calls may end up significantly impacting the performance of our
applications.</font><font size=3D3> </font><font size=3D2 face=3D"Calibri">=
<br>
In order to work around this, we were thinking that if there was a way
to query the LTTng library from our application code whether there is an
active tracing session for the given trace level, we could avoid calling
those snprintfs in case they are not needed. Do you think it would be feasi=
ble
to easily get this data from LTTng lib? If yes, can you provide us some
pointers where to look at in order to do those changes ourselves?</font><fo=
nt size=3D3>
</font><font size=3D2 face=3D"Calibri"><br>
Any suggestions are welcome.</font><font size=3D3> </font><font size=3D2 fa=
ce=3D"Calibri"><br>
Thank you,</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
Mate Ferenczy</font><font size=3D3> <br>
 &nbsp;<br>
 &nbsp;<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3Dhttp://www.efficios.com/ target=3D=5Fblank><font size=
=3D3 color=3Dblue><u>http://www.efficios.com</u></font></a><font size=3D3>
<br>
 &nbsp;<br>
 &nbsp;<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.</font><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3Dhttp://www.efficios.com/><font size=3D3 color=3Dblue><=
u>http://www.efficios.com</u></font></a><font size=3D2>=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
lttng-dev mailing list</font><font size=3D2 color=3Dblue><u><br>
</u></font><a href=3D"mailto:lttng-dev@lists.lttng.org"><font size=3D2 colo=
r=3Dblue><u>lttng-dev@lists.lttng.org</u></font></a><font size=3D3 color=3D=
blue><u><br>
</u></font><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev"><font size=3D2 color=3Dblue><u>http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</u></font></a>
<br>
--=_alternative 0029B77DC2257C44_=--



--===============1604037369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1604037369==--
