From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: UST - Is it possible to merge my source file and
 the tracepoint file?
Date: Wed, 23 Oct 2013 09:58:13 +0300
Message-ID: <OFA6B46C1E.7B0717D8-ONC2257C0D.0020ECA2-C2257C0D.00264735__18305.2459302873$1382511561$gmane$org@il.ibm.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679F56D@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0345324114=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VYsOo-0001tB-Vr
	for lttng-dev@lists.lttng.org; Wed, 23 Oct 2013 02:58:36 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 23 Oct 2013 07:58:29 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
	(d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 78A4E2190066
	for <lttng-dev@lists.lttng.org>; Wed, 23 Oct 2013 07:58:26 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r9N6wDTQ36831296
	for <lttng-dev@lists.lttng.org>; Wed, 23 Oct 2013 06:58:13 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id r9N6wQYq012880
	for <lttng-dev@lists.lttng.org>; Wed, 23 Oct 2013 00:58:26 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id r9N6wQ24012874
	for <lttng-dev@lists.lttng.org>; Wed, 23 Oct 2013 00:58:26 -0600
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679F56D@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0345324114==
Content-Type: multipart/alternative; boundary="=_alternative 00264697C2257C0D_="

This is a multipart message in MIME format.
--=_alternative 00264697C2257C0D_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

> Presumably source.c contains at least the tracepoint() calls?

Not at first. This file begins as a simple C file, and my instrumentor is=20
parsing it, automatically generating source=5Ftp.h and source=5Ftp.c, and t=
hen=20
embeds the #include line and the tracepoint() calls into source.c itself.

> Do you wish the tracepoint provider (lttng=5Ftp=5Fhdr.h + lttng=5Ftp=5Fsr=
c.c) to=20
be statically included in each linked object (possibly through a shared=20
static library (.a))

I want to compile a single C file into a single object file, so that I do=20
not need to change anything in my project's existing build, except to tell =

it to use my automated instrumentation tool before compiling.

Here's what I mean -

In the standard work mode, I use 2 C files: (1) my source.c which=20
contains:

Headers + Declarations
Include of source=5Ftp.h (which gives declarations tracepoint functions=20
=5F=5Ftracepoint=5Fcb=5F<provider>=5F=5F=5F<tp-name>() among other things)
My own function definitions with calls to tracepoint()

And (2) is source=5Ftp.c which contains (by defining TRACEPOINT=5FDEFINE an=
d=20
including source=5Ftp.h):

Various declarations
Definitions, for example the functions named=20
=5F=5Ftracepoint=5Fcb=5F<provider>=5F=5F=5F<tp-name>(), etc.

This means that I need to add source=5Ftp.c as a dependency of my build and=
=20
explain how to create it, but also, to have manually added the=20
tracepoint() calls and the include of source=5Ftp.h.

What I would like, is to take a pre-processed version of source.c (after=20
cpp but before the addition of tracepoint calls), and to end up with a new =

file that contains:

Headers + Declarations
Declarations of tracepoint functions=20
=5F=5Ftracepoint=5Fcb=5F<provider>=5F=5F=5F<tp-name>() among other things)
My own function definitions with the macro calls to tracepoint() already=20
"unrolled".
Lttng function definitions, i.e. the functions named=20
=5F=5Ftracepoint=5Fcb=5F<provider>=5F=5F=5F<tp-name>(), etc.

This file can then be compiled directly to a single .o file which contains =

everything I need, and is a single unit containing my code and tracepoint=20
provider code.

Right now, I have a working instrumentor, which requires a rather complex=20
(read - slow...) procedure in order to end up with a unified .o file.

I am looking to streamline this process and make it faster.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
To:     "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Date:   10/22/2013 10:31 PM
Subject:        Re: [lttng-dev] UST - Is it possible to merge my source=20
file and the tracepoint file?



-----Message d'origine-----
Date: Mon, 21 Oct 2013 16:16:30 +0300
From: Amit Margalit <AMITM@il.ibm.com>

Consider the following situation:

I wrote a header (lttng=5Ftp=5Fhdr.h) containing several tracepoints, match=
ing=20
some locations I want to instrument in one of my source files (let's call=20
it source.c). I created a C file for this header (lttng=5Ftp=5Fsrc.c) and=20
compiled it into object. I then compiled source.c into source.o and I link =

the two objects together.

This is the standard work mode.

Now I want to automate this procedure, which will cause me to generate new =

C files, and new headers for many of my sources.

How can I rewrite my source.c so it contains everything I need?

Amit Margalit
------------------------------
   Presumably source.c contains at least the tracepoint() calls?  Do you=20
wish the tracepoint provider (lttng=5Ftp=5Fhdr.h + lttng=5Ftp=5Fsrc.c) to b=
e=20
statically included in each linked object (possibly through a shared=20
static library (.a)), or would you rather have your various objects all=20
share a tracepoint provider library (.so)?  In the latter case, would you=20
prefer the tracepoint provider library to be a dependency (static=20
awareness: the instrumented apps won't run at all unless they can find the =

.so) or not (meaning you'll need to LD=5FPRELOAD the .so to turn tracing=20
on)?  (There's also the case where the apps control their own traceability =

by using dlopen() and dlclose() with the tracepoint provider .so)

   Typically, you need add just the tracepoint() calls and an "#include=20
tracepointprovider.h" in the sources, and you control compilation with the =

-D TRACEPOINT=5FDEFINE and -D TRACEPOINT=5FPROBE=5FDYNAMIC=5FLINKAGE switch=
es.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &=20
Countermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =

Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
=20
Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
 LinkedIn: <http://ca.linkedin.com/in/daniel-u-thibault/>
 Research Gate: <https://www.researchgate.net/profile/Daniel=5FThibault/>

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=_alternative 00264697C2257C0D_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Hi,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&gt; </font><tt><font size=3D2>Presu=
mably
source.c contains at least the tracepoint() calls?</font></tt>
<br>
<br><font size=3D2 face=3D"sans-serif">Not at first. This file begins as a
simple C file, and my instrumentor is parsing it, automatically generating
source=5Ftp.h and source=5Ftp.c, and then embeds the #include line and the
tracepoint() calls into source.c itself.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">&gt; </font><tt><font size=3D2>Do you
wish the tracepoint provider (lttng=5Ftp=5Fhdr.h + lttng=5Ftp=5Fsrc.c) to b=
e statically
included in each linked object (possibly through a shared static library
(.a))</font></tt>
<br>
<br><font size=3D2 face=3D"sans-serif">I want to compile a single C file in=
to
a single object file, so that I do not need to change anything in my projec=
t's
existing build, except to tell it to use my automated instrumentation tool
before compiling.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Here's what I mean -</font>
<br>
<br><font size=3D2 face=3D"sans-serif">In the standard work mode, I use 2 C
files: (1) my source.c which contains:</font>
<br>
<ol>
<li value=3D1><font size=3D2 face=3D"sans-serif">Headers + Declarations</fo=
nt>
<li value=3D2><font size=3D2 face=3D"sans-serif">Include of source=5Ftp.h (=
which
gives declarations tracepoint functions =5F=5Ftracepoint=5Fcb=5F&lt;provide=
r&gt;=5F=5F=5F&lt;tp-name&gt;()
among other things)</font>
<li value=3D3><font size=3D2 face=3D"sans-serif">My own function definitions
with calls to tracepoint()</font></ol>
<br><font size=3D2 face=3D"sans-serif">And (2) is source=5Ftp.c which conta=
ins
(by defining </font><tt><font size=3D2>TRACEPOINT=5FDEFINE</font></tt><font=
 size=3D2 face=3D"sans-serif">
and including source=5Ftp.h):</font>
<br>
<ol>
<li value=3D1><font size=3D2 face=3D"sans-serif">Various declarations</font>
<li value=3D2><font size=3D2 face=3D"sans-serif">Definitions, for example t=
he
functions named =5F=5Ftracepoint=5Fcb=5F&lt;provider&gt;=5F=5F=5F&lt;tp-nam=
e&gt;(), etc.</font></ol>
<br><font size=3D2 face=3D"sans-serif">This means that I need to add source=
=5Ftp.c
as a dependency of my build and explain how to create it, but also, to
have manually added the tracepoint() calls and the include of source=5Ftp.h=
.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">What I would like, is to take a pre-=
processed
version of source.c (after cpp but before the addition of tracepoint calls),
and to end up with a new file that contains:</font>
<br>
<ol>
<li value=3D1><font size=3D2 face=3D"sans-serif">Headers + Declarations</fo=
nt>
<li value=3D2><font size=3D2 face=3D"sans-serif">Declarations of tracepoint=
 functions
=5F=5Ftracepoint=5Fcb=5F&lt;provider&gt;=5F=5F=5F&lt;tp-name&gt;() among ot=
her things)</font>
<li value=3D3><font size=3D2 face=3D"sans-serif">My own function definitions
with the macro calls to tracepoint() already &quot;unrolled&quot;.</font>
<li value=3D4><font size=3D2 face=3D"sans-serif">Lttng function definitions,
i.e. the functions named =5F=5Ftracepoint=5Fcb=5F&lt;provider&gt;=5F=5F=5F&=
lt;tp-name&gt;(),
etc.</font>
<li value=3D5></ol><font size=3D2 face=3D"sans-serif">This file can then be=
 compiled
directly to a single .o file which contains everything I need, and is a
single unit containing my code and tracepoint provider code.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Right now, I have a working instrume=
ntor,
which requires a rather complex (read - slow...) procedure in order to
end up with a unified .o file.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I am looking to streamline this proc=
ess
and make it faster.</font>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">&quot;Thibault, Daniel&quot;
&lt;Daniel.Thibault@drdc-rddc.gc.ca&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">&quot;lttng-dev@lists.lttng=
.org&quot;
&lt;lttng-dev@lists.lttng.org&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">10/22/2013 10:31 PM</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [lttng-dev]
UST - Is it possible to merge my source file and the tracepoint file?</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>-----Message d'origine-----<br>
Date: Mon, 21 Oct 2013 16:16:30 +0300<br>
From: Amit Margalit &lt;AMITM@il.ibm.com&gt;<br>
<br>
Consider the following situation:<br>
<br>
I wrote a header (lttng=5Ftp=5Fhdr.h) containing several tracepoints, match=
ing
some locations I want to instrument in one of my source files (let's call
it source.c). I created a C file for this header (lttng=5Ftp=5Fsrc.c) and c=
ompiled
it into object. I then compiled source.c into source.o and I link the two
objects together.<br>
<br>
This is the standard work mode.<br>
<br>
Now I want to automate this procedure, which will cause me to generate
new C files, and new headers for many of my sources.<br>
<br>
How can I rewrite my source.c so it contains everything I need?<br>
<br>
Amit Margalit<br>
------------------------------<br>
 &nbsp; Presumably source.c contains at least the tracepoint() calls? &nbsp=
;Do
you wish the tracepoint provider (lttng=5Ftp=5Fhdr.h + lttng=5Ftp=5Fsrc.c) =
to be
statically included in each linked object (possibly through a shared static
library (.a)), or would you rather have your various objects all share
a tracepoint provider library (.so)? &nbsp;In the latter case, would you
prefer the tracepoint provider library to be a dependency (static awareness:
the instrumented apps won't run at all unless they can find the .so) or
not (meaning you'll need to LD=5FPRELOAD the .so to turn tracing on)? &nbsp=
;(There's
also the case where the apps control their own traceability by using dlopen=
()
and dlclose() with the tracepoint provider .so)<br>
<br>
 &nbsp; Typically, you need add just the tracepoint() calls and an &quot;#i=
nclude
tracepointprovider.h&quot; in the sources, and you control compilation
with the -D TRACEPOINT=5FDEFINE and -D TRACEPOINT=5FPROBE=5FDYNAMIC=5FLINKA=
GE switches.<br>
<br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;
Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence
R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC &nbsp;G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;</font></tt><a href=3D"http://www.travelgis.com/map.asp=
?addr=3D918V%20QSDJ"><tt><font size=3D2>http://www.travelgis.com/map.asp?ad=
dr=3D918V%20QSDJ</font></tt></a><tt><font size=3D2>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;</font></tt><a href=3D"http://www.valcartier.drdc-rddc.gc.ca/"><tt><fon=
t size=3D2>http://www.valcartier.drdc-rddc.gc.ca/</font></tt></a><tt><font =
size=3D2>&gt;<br>
 LinkedIn: &lt;</font></tt><a href=3D"http://ca.linkedin.com/in/daniel-u-th=
ibault/"><tt><font size=3D2>http://ca.linkedin.com/in/daniel-u-thibault/</f=
ont></tt></a><tt><font size=3D2>&gt;<br>
 Research Gate: &lt;</font></tt><a href=3Dhttps://www.researchgate.net/prof=
ile/Daniel=5FThibault/><tt><font size=3D2>https://www.researchgate.net/prof=
ile/Daniel=5FThibault/</font></tt></a><tt><font size=3D2>&gt;<br>
<br>
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev"><tt><font size=3D2>http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev</font></tt></a><tt><font size=3D2><br>
<br>
</font></tt>
<br>
--=_alternative 00264697C2257C0D_=--



--===============0345324114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0345324114==--
