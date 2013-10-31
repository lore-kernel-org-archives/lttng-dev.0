From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: What is the size overhead of UST tracepoints?
 (hint:	very large indeed)
Date: Thu, 31 Oct 2013 11:55:46 +0000 (UTC)
Message-ID: <1190897681.54146.1383220546042.JavaMail.zimbra__44115.8967711546$1383220604$gmane$org@efficios.com>
References: <OF98A3476E.B164A434-ONC2257C13.003269EB-C2257C13.00354EB7@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1779359256=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vbqqx-0005Sj-R2
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 07:55:57 -0400
In-Reply-To: <OF98A3476E.B164A434-ONC2257C13.003269EB-C2257C13.00354EB7@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1779359256==
Content-Type: multipart/alternative;
	boundary="----=_Part_54145_1618829132.1383220546040"

------=_Part_54145_1618829132.1383220546040
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Amit Margalit" <AMITM@il.ibm.com>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Tuesday, October 29, 2013 4:42:20 AM
> Subject: [lttng-dev] What is the size overhead of UST tracepoints? (hint:
> very large indeed)

> Hello all,

> Let me start with my bottom line conclusions, and then explain them:

> LTTng's size overhead and start-up time overhead is huge! An application
> cannot use (directly or through linking in shared libraries with TPs) more
> than about 1000-2000 tracepoints.
Hi Amit, 

We've pushed this to 16k in J9 instrumentation experiments. I had to make changes to UST to make sure we scale well to those large number of tracepoints. Which UST versions are you working on ? 

> I am working on incorporating LTTng as an alternative logging method for an
> existing project, which already has many thousands of places in the code
> that do logging of some data.

> By many thousands, I mean > 15K.

> I have basically written an automated instrumentor that generates custom
> tracepoints, for every log location plus 1 entry-tracepoints and 1
> exit-tracepoint for every function.
You might want to re-think the way you instrument function entry/exit. It sounds like this could be achieved either with a single trace point for entry, single trace point for exit. We're also working on dynamic instrumentation with dyninst. This could be another approach to look into. 

How many tracepoints to you get for every log locations ? (not including function entry/exit) 

> This totals about 100K tracepoints, with approximately 600K different fields,
> and has increased the size of the project's resulting executables from
> ~100MB to ~900MB (!!) - although this is with debug symbols.
Comparing binary size with debug symbols is meaningless. What are the numbers without debug symbols ? 

> Analysis of the reasons for this has revealed some interesting (but
> discouraging) facts:

> 1. Each tracepoint name is stored in a static buffer sized 256 bytes,
> regardless of how long the name actually is (contributing some 25MB to the
> size)
> 2. Each trace event field name is store also in a 256-byte buffer
> (contirbuting another 150MB)
> 3. Each event / tracepoint holds an event structure which holds the fields,
> etc. and is padded generously.

Be aware that whatever we do, we need to keep backward ABI compatibility. This has influenced some decisions (e.g. padding in event structures) so we can add features in the future without breaking compatibility between applications and UST. An old application binary should always be able to link with a newer liblttng-ust. As long as we guarantee that, and keep room for introduction of new features in the future without having to break the ABI, size optimizations are welcome. 

> Additionally, there is a ton of code to calculate the event size, its
> alignment, and to verify that the names are not longer than the 256 byte
> buffer, and more.
When you say "there is a ton of code", are you talking about actual instruction bytes, of about "lines of C code" ? The former the the proper way to analyze the size footprint. 

> Some of this is either used just once, or even never used, merely compiled to
> let the compiler complain if the sizes are wrong, etc.
Let me know which ones translate into actual instructions. Make sure you compile with "-O2". 

> Now this code won't be included if you compile a statically linked
> executable, but my project compiles almost everything into shared libs.
I don't understand how static exec vs shared lib changes the space overhead, can you clarify ? 

> Another big big problem is the time it takes to register all of these
> tracepoints. For one of my executables which includes ~10K tracepoints, it
> took over 5 seconds just to get to "main()" due to tracepoint constructor
> code registering the tracepoints...
We have seen this kind of issue when trying to instrument J9. I have pushed fixes for this. On which UST version are you seeing these figures ? 

Thanks for looking into this. Making sure that UST instrumentation scales well to large applications is indeed very important to us. 

Mathieu 

> I've started working on an alternative method of doing the same...

> Is anyone already aware of this? Is anyone already working on improving this?
> I'd be very happy to work together on this.

> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03 -689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_54145_1618829132.1383220546040
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Amit Margalit" &lt;AMI=
TM@il.ibm.com&gt;<br><b>To: </b>"lttng-dev" &lt;lttng-dev@lists.lttng.org&g=
t;<br><b>Sent: </b>Tuesday, October 29, 2013 4:42:20 AM<br><b>Subject: </b>=
[lttng-dev] What is the size overhead of UST tracepoints? (hint:&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;very large indeed)<br><div><br></div><=
span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D=
"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2"=
>Hello all,</span><br><br><span style=3D"font-family: sans-serif; font-size=
: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" fac=
e=3D"sans-serif" size=3D"2">Let me start with my bottom line conclusions,
and then explain them:</span><br><br><span style=3D"font-family: sans-serif=
; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: =
small;" face=3D"sans-serif" size=3D"2">LTTng's size overhead and start-up t=
ime
overhead is huge! An application cannot use (directly or through linking
in shared libraries with TPs) more than about 1000-2000 tracepoints.</span>=
</blockquote><div>Hi Amit,<br></div><div><br></div><div>We've pushed this t=
o 16k in J9 instrumentation experiments. I had to make changes to UST to ma=
ke sure we scale well to those large number of tracepoints. Which UST versi=
ons are you working on ?<br></div><div><br></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><br><span style=3D"font-family: sans-serif=
; font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: =
small;" face=3D"sans-serif" size=3D"2">I am working on incorporating LTTng
as an alternative logging method for an existing project, which already
has many thousands of places in the code that do logging of some data.</spa=
n><br><br><span style=3D"font-family: sans-serif; font-size: small;" data-m=
ce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif"=
 size=3D"2">By many thousands, I mean &gt; 15K.</span><br><br><span style=
=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-fami=
ly: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">I have ba=
sically written an automated
instrumentor that generates custom tracepoints, for every log location
plus 1 entry-tracepoints and 1 exit-tracepoint for every function.</span></=
blockquote><div><br></div><div>You might want to re-think the way you instr=
ument function entry/exit. It sounds like this could be achieved either wit=
h a single trace point for entry, single trace point for exit. We're also w=
orking on dynamic instrumentation with dyninst. This could be another appro=
ach to look into.<br></div><div><br></div><div>How many tracepoints to you =
get for every log locations ? (not including function entry/exit)<br></div>=
<div><br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-styl=
e=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">This totals about 100K tracepoints,
with approximately 600K different fields, and has increased the size of
the project's resulting executables from ~100MB to ~900MB (!!) - although
this is with debug symbols.</span></blockquote><div><br></div><div>Comparin=
g binary size with debug symbols is meaningless. What are the numbers witho=
ut debug symbols ?<br></div><div><br></div><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><br><span style=3D"font-family: sans-serif; font=
-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;=
" face=3D"sans-serif" size=3D"2">Analysis of the reasons for this has
revealed some interesting (but discouraging) facts:</span><ol><li value=3D"=
1"><span style=3D"font-family: sans-serif; font-size: small;" data-mce-styl=
e=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">Each tracepoint name is stored
in a static buffer sized 256 bytes, regardless of how long the name actuall=
y
is (contributing some 25MB to the size)</span></li><li value=3D"2"><span st=
yle=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-f=
amily: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">Each t=
race event field name
is store also in a 256-byte buffer (contirbuting another 150MB)</span></li>=
<li value=3D"3"><span style=3D"font-family: sans-serif; font-size: small;" =
data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-=
serif" size=3D"2">Each event / tracepoint holds
an event structure which holds the fields, etc. and is padded generously.</=
span></li></ol></blockquote><div><br></div><div>Be aware that whatever we d=
o, we need to keep backward ABI compatibility. This has influenced some dec=
isions (e.g. padding in event structures) so we can add features in the fut=
ure without breaking compatibility between applications and UST. An old app=
lication binary should always be able to link with a newer liblttng-ust. As=
 long as we guarantee that, and keep room for introduction of new features =
in the future without having to break the ABI, size optimizations are welco=
me.<br></div><div><br></div><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;"><br><span style=3D"font-family: sans-serif; font-size: small;" =
data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-=
serif" size=3D"2">Additionally, there is a ton of code
to calculate the event size, its alignment, and to verify that the names
are not longer than the 256 byte buffer, and more.</span></blockquote><div>=
<br></div><div>When you say "there is a ton of code", are you talking about=
 actual instruction bytes, of about "lines of C code" ? The former the the =
proper way to analyze the size footprint.<br></div><div><br></div><blockquo=
te style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;=
color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:Helvetica,Arial,sans-serif;font-size:12pt;"><br><span style=3D"font-f=
amily: sans-serif; font-size: small;" data-mce-style=3D"font-family: sans-s=
erif; font-size: small;" face=3D"sans-serif" size=3D"2">Some of this is eit=
her used just once,
or even never used, merely compiled to let the compiler complain if the
sizes are wrong, etc.</span></blockquote><div><br></div><div>Let me know wh=
ich ones translate into actual instructions. Make sure you compile with "-O=
2".<br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><br=
><span style=3D"font-family: sans-serif; font-size: small;" data-mce-style=
=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D=
"2">Now this code won't be included if you
compile a statically linked executable, but my project compiles almost
everything into shared libs.</span></blockquote><div><br></div><div>I don't=
 understand how static exec vs shared lib changes the space overhead, can y=
ou clarify ?<br></div><div><br></div><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;"><br><span style=3D"font-family: sans-serif; font-size:=
 small;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=
=3D"sans-serif" size=3D"2">Another big big problem is the time
it takes to register all of these tracepoints. For one of my executables
which includes ~10K tracepoints, it took over 5 seconds just to get to
"main()" due to tracepoint constructor code registering the tracepoints...<=
/span></blockquote><div><br></div><div>We have seen this kind of issue when=
 trying to instrument J9. I have pushed fixes for this. On which UST versio=
n are you seeing these figures ?<br></div><div><br></div><div>Thanks for lo=
oking into this. Making sure that UST instrumentation scales well to large =
applications is indeed very important to us.<br></div><div><br></div><div>M=
athieu<br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-l=
eft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;te=
xt-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">=
<br><span style=3D"font-family: sans-serif; font-size: small;" data-mce-sty=
le=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=
=3D"2">I've started working on an alternative
method of doing the same...<br>
</span><br><span style=3D"font-family: sans-serif; font-size: small;" data-=
mce-style=3D"font-family: sans-serif; font-size: small;" face=3D"sans-serif=
" size=3D"2">Is anyone already aware of this? Is
anyone already working on improving this? I'd be very happy to work togethe=
r
on this.</span><br><br><br><span style=3D"color: #000080; font-family: sans=
-serif; font-size: small;" data-mce-style=3D"color: #000080; font-family: s=
ans-serif; font-size: small;" color=3D"#000080" face=3D"sans-serif" size=3D=
"2">Amit Margalit</span><br><span style=3D"color: #808000; font-family: san=
s-serif; font-size: small;" data-mce-style=3D"color: #808000; font-family: =
sans-serif; font-size: small;" color=3D"#808000" face=3D"sans-serif" size=
=3D"2">IBM XIV </span><span style=3D"font-family: sans-serif; font-size: sm=
all;" data-mce-style=3D"font-family: sans-serif; font-size: small;" face=3D=
"sans-serif" size=3D"2">-
<i>Storage Reinvented</i></span><br><span style=3D"font-family: sans-serif;=
 font-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: s=
mall;" face=3D"sans-serif" size=3D"2">XIV-NAS Development Team</span><br><s=
pan style=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"=
font-family: sans-serif; font-size: small;" face=3D"sans-serif" size=3D"2">=
Tel. 03</span><span style=3D"font-family: Arial; font-size: small;" data-mc=
e-style=3D"font-family: Arial; font-size: small;" face=3D"Arial" size=3D"2"=
>-689-7774</span><br><span style=3D"font-family: Arial; font-size: small;" =
data-mce-style=3D"font-family: Arial; font-size: small;" face=3D"Arial" siz=
e=3D"2">Fax. 03-689-7230</span><br>________________________________________=
_______<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><=
br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Math=
ieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"><=
/span><br></div></div></body></html>
------=_Part_54145_1618829132.1383220546040--


--===============1779359256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1779359256==--
