From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Debian specific userspace RCU configure override
Date: Sat, 24 May 2014 13:05:02 +0000 (UTC)
Message-ID: <400506412.22279.1400936702676.JavaMail.zimbra__9764.057750772$1400936768$gmane$org@efficios.com>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
 <247206510.22055.1400853567137.JavaMail.zimbra@efficios.com>
 <20140523222124.GA25594@helmut>
 <97D83BC6-DF7B-4A23-A0DA-22EBEF7E7A62@sury.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1929922166=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WoBdU-0001Xg-KM
 for lttng-dev@lists.lttng.org; Sat, 24 May 2014 09:05:20 -0400
In-Reply-To: <97D83BC6-DF7B-4A23-A0DA-22EBEF7E7A62@sury.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@sury.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@debian.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1929922166==
Content-Type: multipart/alternative;
	boundary="----=_Part_22278_231932131.1400936702674"

------=_Part_22278_231932131.1400936702674
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In order to understand what is happening here, can we have a copy=20
of config.log of both userspace RCU and ltt-control, as well as the output=
=20
of invocation of configure, and output of make V=3D1 ?=20

Thanks,=20

Mathieu=20

----- Original Message -----

> From: "Ond=C5=99ej Sur=C3=BD" <ondrej@sury.org>
> To: "Jon Bernard" <jbernard@debian.org>
> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Ond=C5=99ej Su=
r=C3=BD"
> <ondrej@debian.org>, "Michael Jeanson" <mjeanson@efficios.com>, "lttng-de=
v"
> <lttng-dev@lists.lttng.org>
> Sent: Friday, May 23, 2014 7:10:50 PM
> Subject: Re: Debian specific userspace RCU configure override

> JFTR I did build the urcu and ltt-control on same machine and urcu build =
went
> ok, but ltt-control failed. So there might be something broken.

> Although yes, more generally there could be a problem with difference bet=
ween
> build machines, so --disable flag might be helpful.

> O.
> --
> Ond=C5=99ej Sur=C3=BD < ondrej@sury.org >
> Knot DNS ( https://www.knot-dns.cz/ ) =E2=80=93 a high-performance DNS se=
rver

> On 24. 5. 2014, at 0:21, Jon Bernard < jbernard@debian.org > wrote:

> > * Mathieu Desnoyers < mathieu.desnoyers@efficios.com > wrote:
>=20

> > > Hi,
> >=20
>=20

> > > I recently stumbled on this patch:
> >=20
>=20

> > > http://sprunge.us/jYcJ
> >=20
>=20

> > > It overrides the generated config.h to ensure the
> >=20
>=20

> > > "dmb" instruction is not used.
> >=20
>=20

> > > However, the proper checks seems to be in place within
> >=20
>=20

> > > configure.ac to automatically detect whether to use dmb
> >=20
>=20

> > > or not:
> >=20
>=20

> > > # ARM-specific checks
> >=20
>=20

> > > AS_IF([test "x$ARCHTYPE" =3D "xarm"],[
> >=20
>=20

> > > AC_MSG_CHECKING([for dmb instruction])
> >=20
>=20

> > > AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
> >=20
>=20

> > > int main()
> >=20
>=20

> > > {
> >=20
>=20

> > > asm volatile("dmb":::"memory");
> >=20
>=20

> > > return 0;
> >=20
>=20

> > > }
> >=20
>=20

> > > ]])
> >=20
>=20

> > > ],[
> >=20
>=20

> > > AC_MSG_RESULT([yes])
> >=20
>=20

> > > AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])
> >=20
>=20

> > > ],[
> >=20
>=20

> > > AC_MSG_RESULT([no])
> >=20
>=20

> > > ])
> >=20
>=20

> > > ])
> >=20
>=20

> > > My thinking here is that perhaps inappropriate compiler flags
> >=20
>=20

> > > are used when the compiler is invoked from within "configure",
> >=20
>=20

> > > which leads it to think that it targets an ARMv7+ with dmb.
> >=20
>=20

> > > The Debian "armel" architecture AFAIU needs to target older
> >=20
>=20

> > > ARM architectures.
> >=20
>=20

> > I also wonder if there are some differences between of the arm build
>=20
> > machines. I don't have shell access to the machine on which urcu was
>=20
> > built so I cannot check, but perhaps that particular machine has dmb.
>=20

> > > It would be much better to fix the compiler flags passed to
> >=20
>=20

> > > configure and let urcu autodetection do what it is intended
> >=20
>=20

> > > to do rather than override the generated file.
> >=20
>=20

> > I'll gather and post the compiler flags used for urcu and we'll see.
>=20

> > --
>=20
> > Jon
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_22278_231932131.1400936702674
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>In order to understand what is h=
appening here, can we have a copy<br></div><div>of config.log of both users=
pace RCU and ltt-control, as well as the output<br></div><div>of invocation=
 of configure, and output of make V=3D1 ?<br></div><div><br></div><div>Than=
ks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><div><br><=
/div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF;ma=
rgin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:1=
2pt;"><b>From: </b>"Ond=C5=99ej Sur=C3=BD" &lt;ondrej@sury.org&gt;<br><b>To=
: </b>"Jon Bernard" &lt;jbernard@debian.org&gt;<br><b>Cc: </b>"Mathieu Desn=
oyers" &lt;mathieu.desnoyers@efficios.com&gt;, "Ond=C5=99ej Sur=C3=BD" &lt;=
ondrej@debian.org&gt;, "Michael Jeanson" &lt;mjeanson@efficios.com&gt;, "lt=
tng-dev" &lt;lttng-dev@lists.lttng.org&gt;<br><b>Sent: </b>Friday, May 23, =
2014 7:10:50 PM<br><b>Subject: </b>Re: Debian specific userspace RCU config=
ure override<br><div><br></div><div>JFTR I did build the urcu and ltt-contr=
ol on same machine and urcu build went ok, but ltt-control failed. So there=
 might be something broken.</div><div><br></div><div>Although yes, more gen=
erally there could be a problem with difference between build machines, so =
--disable flag might be helpful.</div><div><br></div><div>O.<br><div><span =
style=3D"background-color: ; font-size: 13pt;">--&nbsp;</span></div><div><s=
pan style=3D"background-color: ;">Ond=C5=99ej Sur=C3=BD &lt;<a href=3D"mail=
to:ondrej@sury.org" target=3D"_blank">ondrej@sury.org</a>&gt;</span></div><=
div><span style=3D"background-color: ;">Knot DNS (<a href=3D"https://www.kn=
ot-dns.cz/" target=3D"_blank">https://www.knot-dns.cz/</a>) =E2=80=93 a hig=
h-performance DNS server</span></div></div><div><br>On 24. 5. 2014, at 0:21=
, Jon Bernard &lt;<a href=3D"mailto:jbernard@debian.org" target=3D"_blank">=
jbernard@debian.org</a>&gt; wrote:<br><div><br></div></div><blockquote><div=
><span>* Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios=
.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:</span=
><br><blockquote><span>Hi,</span><br></blockquote><blockquote><span></span>=
<br></blockquote><blockquote><span>I recently stumbled on this patch:</span=
><br></blockquote><blockquote><span></span><br></blockquote><blockquote><sp=
an><a href=3D"http://sprunge.us/jYcJ" target=3D"_blank">http://sprunge.us/j=
YcJ</a></span><br></blockquote><blockquote><span></span><br></blockquote><b=
lockquote><span>It overrides the generated config.h to ensure the</span><br=
></blockquote><blockquote><span>"dmb" instruction is not used.</span><br></=
blockquote><blockquote><span></span><br></blockquote><blockquote><span>Howe=
ver, the proper checks seems to be in place within</span><br></blockquote><=
blockquote><span>configure.ac to automatically detect whether to use dmb</s=
pan><br></blockquote><blockquote><span>or not:</span><br></blockquote><bloc=
kquote><span></span><br></blockquote><blockquote><span># ARM-specific check=
s</span><br></blockquote><blockquote><span>AS_IF([test "x$ARCHTYPE" =3D "xa=
rm"],[</span><br></blockquote><blockquote><span> &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;AC_MSG_CHECKING([for dmb instruction])</span><br></blockquo=
te><blockquote><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_COMPILE_=
IFELSE([AC_LANG_SOURCE([[</span><br></blockquote><blockquote><span> &nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int main()</span><br></blockquote><blockquote>=
<span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{</span><br></blockquote><blockq=
uote><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;asm volatile("dmb":::"memory");</span><br></blockquote=
><blockquote><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><br></blockquote><blockquote><=
span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br></blockquote><blockqu=
ote><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;]])</span><br></blockquote><blockquote><span> &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;],[</span><br></blockquote><blockquo=
te><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;AC_MSG_RESULT([yes])</span><br></blockquote><block=
quote><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])</span=
><br></blockquote><blockquote><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;],[</span><br></blockquote><blockquote><span> &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_MSG_RES=
ULT([no])</span><br></blockquote><blockquote><span> &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;])</span><br></blockquote><blockquote><span>])</span><br=
></blockquote><blockquote><span></span><br></blockquote><blockquote><span>M=
y thinking here is that perhaps inappropriate compiler flags</span><br></bl=
ockquote><blockquote><span>are used when the compiler is invoked from withi=
n "configure",</span><br></blockquote><blockquote><span>which leads it to t=
hink that it targets an ARMv7+ with dmb.</span><br></blockquote><blockquote=
><span>The Debian "armel" architecture AFAIU needs to target older</span><b=
r></blockquote><blockquote><span>ARM architectures.</span><br></blockquote>=
<span></span><br><span>I also wonder if there are some differences between =
of the arm build</span><br><span>machines. &nbsp;I don't have shell access =
to the machine on which urcu was</span><br><span>built so I cannot check, b=
ut perhaps that particular machine has dmb.</span><br><span></span><br><blo=
ckquote><span>It would be much better to fix the compiler flags passed to</=
span><br></blockquote><blockquote><span>configure and let urcu autodetectio=
n do what it is intended</span><br></blockquote><blockquote><span>to do rat=
her than override the generated file.</span><br></blockquote><span></span><=
br><span>I'll gather and post the compiler flags used for urcu and we'll se=
e.</span><br><span></span><br><span>-- </span><br><span>Jon</span><br></div=
></blockquote></blockquote><div><br><br></div><div><br></div><div>-- <br></=
div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_22278_231932131.1400936702674--


--===============1929922166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1929922166==--
