From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace Tracing and Backtraces
Date: Wed, 11 Mar 2015 01:47:44 +0000 (UTC)
Message-ID: <353474327.273521.1426038464379.JavaMail.zimbra__37740.5009502128$1426038553$gmane$org@efficios.com>
References: <BY2SR01MB595A5A400E2211CC7567298C81F0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM6VLGQgjF4tS1dLg749rEZ8DKMMda=DsrihLCoQ9sHPdw@mail.gmail.com>
 <BY2SR01MB5952376CA9DE7B8211078C8C81C0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM4AXG5btHdaoHjuCwzCDvPn9AORyh8gvo-VOua7ndWF2w@mail.gmail.com>
 <CH1SR01MB5996051E5E9E51406F6502DC81B0@CH1SR01MB599.namsdf01.sdf.exchangelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643966255=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YVVkV-0000eZ-0v
 for lttng-dev@lists.lttng.org; Tue, 10 Mar 2015 21:47:59 -0400
In-Reply-To: <CH1SR01MB5996051E5E9E51406F6502DC81B0@CH1SR01MB599.namsdf01.sdf.exchangelabs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Brian Robbins <brianrob@microsoft.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1643966255==
Content-Type: multipart/alternative;
	boundary="----=_Part_273520_449527039.1426038464378"

------=_Part_273520_449527039.1426038464378
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Brian Robbins" <brianrob@microsoft.com>
> To: "Francis Giraldeau" <francis.giraldeau@gmail.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, March 9, 2015 7:17:51 PM
> Subject: Re: [lttng-dev] Userspace Tracing and Backtraces

> Thanks Francis.

> This is what I expected to have to do. I do agree though that adding this=
 to
> lttng-ust would be a good way to go.

> Should we end up on this path, it certainly seems like it might we worth =
our
> time to investigate what it would take to add it to lttng-ust. Do you kno=
w
> who is the right person to talk to about this? I=E2=80=99d want to make s=
ure that
> this would not be a non-starter.

Hi!=20

I'm the maintainer of LTTng-UST. I agree that adding a backtrace context=20
to lttng-ust would be a very useful feature.=20

Some comments inline below,=20

> Thanks.

> -Brian

> From: Francis Giraldeau [mailto:francis.giraldeau@gmail.com]
> Sent: Monday, March 9, 2015 12:39 PM
> To: Brian Robbins
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Userspace Tracing and Backtraces

> 2015-03-06 13:51 GMT-05:00 Brian Robbins < brianrob@microsoft.com >:
> > Thanks Francis.
>=20

> > Is it accurate to say then that the array of addresses would need to be
> > captured by app code by writing a stack walker by hand
>=20

> Yes, the callstack can be recorded in userspace. You would need a tracepo=
int
> with a varying length field:

> TRACEPOINT_EVENT(myprovider, callstack,

> TP_ARGS(unsigned long *, buf, size_t, depth),

> TP_FIELDS(

> ctf_sequence(unsigned long, addr, buf, size_t, depth)

> )

> )

> In the app code, use libunwind [1] to get the addresses, then call the
> tracepoint:

> do_unwind() // use libunwind here

> tracepoint(myprovider, buf, depth);

> However, the unwind will be done whether or not the tracepoint is active
> (~10us-100us in steady state, so it's may become expansive if called ofte=
n).
> I know there was discussion about tp_code() for such use case (some code =
to
> call before the tracepoint only if it is enabled). Or you can cheat:

Francis: Did you define UNW_LOCAL_ONLY before including=20
the libunwind header in your benchmarks ? (see=20
http://www.nongnu.org/libunwind/man/libunwind%283%29.html )=20

The seems to change performance dramatically according to the documentation=
.=20

> if (__builtin_expect(!!(__tracepoint_myprovider___callstack.state), 0)) {

> do_unwind(...)

> tracepoint(myprovider, buf, depth);

> }

> That said, instead of having a callstack tracepoint, IMHO the best soluti=
on
> would be instead extending lttng-ust to add callstack event context (itse=
lf
> linked to libunwind). Then, recording the callstack would be simple like
> that:

> $ lttng add-context -u -t callstack

Agreed on having the backtrace as a context. The main question left is=20
to figure out if we want to call libunwind from within the traced applicati=
on=20
execution context.=20

Unfortunately, libunwind is not reentrant wrt signals. This is already=20
a good argument for not calling it from within a tracepoint. I wonder=20
if the authors of libunwind would be open to make it signal-reentrant=20
in the future (not by disabling signals, but rather by keeping a TLS=20
nesting counter, and returning an error if nested, for performance=20
considerations).=20

> > or using the perf capture mechanism that you describe below?
>=20

> Perf is peeking at the userspace from kernel space, it's another story. I
> guess that libunwind was not ported to the kernel because it is a large
> chunk of complicated code that performs a lot of I/O and computation, whi=
le
> copying a portion of the stack is really about KISS and low runtime
> overhead.

If using libunwind does not work out, another alternative I would consider=
=20
would be to copy the stack like perf is doing from the kernel. However,=20
in the spirit of compacting trace data, I would be tempted to do the follow=
ing=20
if we go down that route: check each pointer-aligned address for its conten=
t.=20
If it looks like a pointer to an executable memory area (library, executabl=
e, or=20
JIT'd code), we keep it. Else, we zero this information (not needed). We ca=
n=20
then do a RLE-alike compression on the zeroes, so we can keep the layout=20
of the stack after uncompression.=20

Thoughts ?=20

Thanks,=20

Mathieu=20

> Cheers,

> Francis

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_273520_449527039.1426038464378
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Brian Robbins" &lt;bri=
anrob@microsoft.com&gt;<br><b>To: </b>"Francis Giraldeau" &lt;francis.giral=
deau@gmail.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>=
Monday, March 9, 2015 7:17:51 PM<br><b>Subject: </b>Re: [lttng-dev] Userspa=
ce Tracing and Backtraces<br><div><br></div><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-reply;
=09font-family:"Calibri",sans-serif;
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F49=
7D">Thanks Francis.</span></p><p class=3D"MsoNormal"><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;<=
/span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif;color:#1F497D">This is what I expected to =
have to do.&nbsp; I do agree though that adding this to lttng-ust would be =
a good way to go.</span></p><p class=3D"MsoNormal"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</s=
pan></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,sans-serif;color:#1F497D">Should we end up on this path=
, it certainly seems like it might we worth our time to investigate what it=
 would take to add it to lttng-ust.&nbsp; Do you know who is
 the right person to talk to about this?&nbsp; I=E2=80=99d want to make sur=
e that this would not be a non-starter.</span></p></div></blockquote><div>H=
i!<br></div><div><br></div><div>I'm the maintainer of LTTng-UST. I agree th=
at adding a backtrace context<br></div><div>to lttng-ust would be a very us=
eful feature.<br></div><div><br></div><div>Some comments inline below,<br><=
/div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=
=3D"WordSection1"><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</span></p><p=
 class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Cali=
bri&quot;,sans-serif;color:#1F497D">Thanks.</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:#1F497D">-Brian
</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-fami=
ly:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</span></p><p class=
=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri=
&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;font-fam=
ily:&quot;Calibri&quot;,sans-serif"> Francis Giraldeau [mailto:francis.gira=
ldeau@gmail.com]
<br>
<b>Sent:</b> Monday, March 9, 2015 12:39 PM<br>
<b>To:</b> Brian Robbins<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] Userspace Tracing and Backtraces</span></p>=
<div><div><div><p class=3D"MsoNormal">2015-03-06 13:51 GMT-05:00 Brian Robb=
ins &lt;<a href=3D"mailto:brianrob@microsoft.com" target=3D"_blank">brianro=
b@microsoft.com</a>&gt;:</p><blockquote style=3D"border:none;border-left:so=
lid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:=
0in"><div><div><p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-=
margin-bottom-alt:auto"><span style=3D"font-size:11.0pt;font-family:&quot;C=
alibri&quot;,sans-serif;color:#1F497D">Thanks Francis.</span></p><p class=
=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"=
><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif=
;color:#1F497D">&nbsp;</span></p><p class=3D"MsoNormal" style=3D"mso-margin=
-top-alt:auto;mso-margin-bottom-alt:auto"><span style=3D"font-size:11.0pt;f=
ont-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Is it accurate to =
say then that the array of addresses would need to be captured by app code =
by writing
 a stack walker by hand</span></p></div></div></blockquote><div><p class=3D=
"MsoNormal">Yes, the callstack can be recorded in userspace. You would need=
 a tracepoint with a varying length field:</p></div><div><p class=3D"MsoNor=
mal">TRACEPOINT_EVENT(myprovider, callstack,</p></div><div><div><p class=3D=
"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TP_ARGS(unsigned long *, buf, size_t, depth),</p></div><div><p class=3D=
"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TP_FIELDS(</p></div><div><p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_sequence(unsigned long, addr, =
buf, size_t, depth)</p></div><div><p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )</p></div><div><p class=
=3D"MsoNormal">)</p></div></div><div><p class=3D"MsoNormal">In the app code=
, use libunwind [1] to get the addresses, then call the tracepoint:&nbsp;</=
p></div><div><p class=3D"MsoNormal">&nbsp; do_unwind() // use libunwind her=
e</p></div><div><p class=3D"MsoNormal">&nbsp; tracepoint(myprovider, buf, d=
epth);</p></div><div><p class=3D"MsoNormal">However, the unwind will be don=
e whether or not the tracepoint is active (~10us-100us in steady state, so =
it's may become expansive if called often). I know there was discussion abo=
ut tp_code() for such use case (some code to call before
 the tracepoint only if it is enabled). Or you can cheat:&nbsp;</p></div></=
div></div></div></div></blockquote><div>Francis: Did you define UNW_LOCAL_O=
NLY before including</div><div>the libunwind header in your benchmarks ? (s=
ee</div><div><a href=3D"http://www.nongnu.org/libunwind/man/libunwind%283%2=
9.html">http://www.nongnu.org/libunwind/man/libunwind%283%29.html</a>)<br><=
/div><div><br></div><div>The seems to change performance dramatically accor=
ding to the documentation.<br></div><blockquote style=3D"border-left:2px so=
lid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;=
font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-ser=
if;font-size:12pt;"><div class=3D"WordSection1"><div><div><div><div><p clas=
s=3D"MsoNormal">if (__builtin_expect(!!(__tracepoint_myprovider___callstack=
.state), 0)) {</p></div><div><p class=3D"MsoNormal">&nbsp; &nbsp; do_unwind=
(...)</p></div><div><p class=3D"MsoNormal">&nbsp; &nbsp; tracepoint(myprovi=
der, buf, depth);</p></div><div><p class=3D"MsoNormal">}</p></div><div><p c=
lass=3D"MsoNormal">That said, instead of having a callstack tracepoint, IMH=
O the best solution would be instead extending lttng-ust to add callstack e=
vent context (itself linked to libunwind). Then, recording the callstack wo=
uld be simple like that:</p></div><div><p class=3D"MsoNormal">&nbsp; $ lttn=
g add-context -u -t callstack</p></div></div></div></div></div></blockquote=
><div>Agreed on having the backtrace as a context. The main question left i=
s<br></div><div>to figure out if we want to call libunwind from within the =
traced application<br></div><div>execution context.<br></div><div><br></div=
><div>Unfortunately, libunwind is not reentrant wrt signals. This is alread=
y<br></div><div>a good argument for not calling it from within a tracepoint=
. I wonder<br></div><div>if the authors of libunwind would be open to make =
it signal-reentrant<br></div><div>in the future (not by disabling signals, =
but rather by keeping a TLS<br></div><div>nesting counter, and returning an=
 error if nested, for performance</div><div>considerations).<br></div><div>=
<br></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5p=
x;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div c=
lass=3D"WordSection1"><div><div><div><blockquote style=3D"border:none;borde=
r-left:solid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;marg=
in-right:0in"><div><div><p class=3D"MsoNormal" style=3D"mso-margin-top-alt:=
auto;mso-margin-bottom-alt:auto"><span style=3D"font-size:11.0pt;font-famil=
y:&quot;Calibri&quot;,sans-serif;color:#1F497D">or using the perf capture m=
echanism that you describe below?</span></p></div></div></blockquote><div><=
p class=3D"MsoNormal">Perf is peeking at the userspace from kernel space, i=
t's another story. I guess that libunwind was not ported to the kernel beca=
use it is a large chunk of complicated code that performs a lot of I/O and =
computation, while copying a portion
 of the stack is really about KISS and low runtime overhead.</p></div></div=
></div></div></div></blockquote><div>If using libunwind does not work out, =
another alternative I would consider<br></div><div>would be to copy the sta=
ck like perf is doing from the kernel. However,<br></div><div>in the spirit=
 of compacting trace data, I would be tempted to do the following<br></div>=
<div>if we go down that route: check each pointer-aligned address for its c=
ontent.<br></div><div>If it looks like a pointer to an executable memory ar=
ea (library, executable, or<br></div><div>JIT'd code), we keep it. Else, we=
 zero this information (not needed). We can<br></div><div>then do a RLE-ali=
ke compression on the zeroes, so we can keep the layout<br></div><div>of th=
e stack after uncompression.<br></div><div><br></div><div>Thoughts ?<br></d=
iv><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></di=
v><div><br></div><div><br></div><div><br></div><blockquote style=3D"border-=
left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt;"><div class=3D"WordSection1"><div><div><div><=
div><p class=3D"MsoNormal">Cheers,</p></div><div><p class=3D"MsoNormal">Fra=
ncis</p></div></div></div></div></div><br>_________________________________=
______________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>ht=
tp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><di=
v><br><br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></sp=
an>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=
=3D"x"></span><br></div></div></body></html>
------=_Part_273520_449527039.1426038464378--


--===============1643966255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1643966255==--
