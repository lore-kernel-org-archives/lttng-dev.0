From: =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@sury.org>
Subject: Re: Debian specific userspace RCU configure override
Date: Sat, 24 May 2014 01:10:50 +0200
Message-ID: <97D83BC6-DF7B-4A23-A0DA-22EBEF7E7A62__25042.1145851307$1400910686$gmane$org@sury.org>
References: <30703453.22036.1400852842509.JavaMail.zimbra@efficios.com>
 <247206510.22055.1400853567137.JavaMail.zimbra@efficios.com>
 <20140523222124.GA25594@helmut>
Mime-Version: 1.0 (1.0)
Content-Type: multipart/mixed; boundary="===============0802722024=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ondrej@sury.org>) id 1WnycA-0005Ey-UM
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 19:11:05 -0400
In-Reply-To: <20140523222124.GA25594@helmut>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?utf-8?Q?Ond=C5=99ej_Sur=C3=BD?= <ondrej@debian.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org


--===============0802722024==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-D4CCEA6C-C96D-4970-AA5F-094D36AF16F1
Content-Transfer-Encoding: 7bit


--Apple-Mail-D4CCEA6C-C96D-4970-AA5F-094D36AF16F1
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

JFTR I did build the urcu and ltt-control on same machine and urcu build wen=
t ok, but ltt-control failed. So there might be something broken.

Although yes, more generally there could be a problem with difference betwee=
n build machines, so --disable flag might be helpful.

O.
--=20
Ond=C5=99ej Sur=C3=BD <ondrej@sury.org>
Knot DNS (https://www.knot-dns.cz/) =E2=80=93 a high-performance DNS server

> On 24. 5. 2014, at 0:21, Jon Bernard <jbernard@debian.org> wrote:
>=20
> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> Hi,
>>=20
>> I recently stumbled on this patch:
>>=20
>> http://sprunge.us/jYcJ
>>=20
>> It overrides the generated config.h to ensure the
>> "dmb" instruction is not used.
>>=20
>> However, the proper checks seems to be in place within
>> configure.ac to automatically detect whether to use dmb
>> or not:
>>=20
>> # ARM-specific checks
>> AS_IF([test "x$ARCHTYPE" =3D "xarm"],[
>>        AC_MSG_CHECKING([for dmb instruction])
>>        AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
>>                                int main()
>>                                {
>>                                        asm volatile("dmb":::"memory");
>>                                        return 0;
>>                                }
>>                ]])
>>        ],[
>>                AC_MSG_RESULT([yes])
>>                AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])
>>        ],[
>>                AC_MSG_RESULT([no])
>>        ])
>> ])
>>=20
>> My thinking here is that perhaps inappropriate compiler flags
>> are used when the compiler is invoked from within "configure",
>> which leads it to think that it targets an ARMv7+ with dmb.
>> The Debian "armel" architecture AFAIU needs to target older
>> ARM architectures.
>=20
> I also wonder if there are some differences between of the arm build
> machines.  I don't have shell access to the machine on which urcu was
> built so I cannot check, but perhaps that particular machine has dmb.
>=20
>> It would be much better to fix the compiler flags passed to
>> configure and let urcu autodetection do what it is intended
>> to do rather than override the generated file.
>=20
> I'll gather and post the compiler flags used for urcu and we'll see.
>=20
> --=20
> Jon

--Apple-Mail-D4CCEA6C-C96D-4970-AA5F-094D36AF16F1
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>JFTR I did build the urcu and ltt-cont=
rol on same machine and urcu build went ok, but ltt-control failed. So there=
 might be something broken.</div><div><br></div><div>Although yes, more gene=
rally there could be a problem with difference between build machines, so --=
disable flag might be helpful.</div><div><br></div><div>O.<br><div><span sty=
le=3D"background-color: rgba(255, 255, 255, 0); font-size: 13pt;">--&nbsp;</=
span></div><div><span style=3D"background-color: rgba(255, 255, 255, 0);">On=
d=C5=99ej Sur=C3=BD &lt;<a href=3D"mailto:ondrej@sury.org">ondrej@sury.org</=
a>&gt;</span></div><div><span style=3D"background-color: rgba(255, 255, 255,=
 0);">Knot DNS (<a href=3D"https://www.knot-dns.cz/">https://www.knot-dns.cz=
/</a>) =E2=80=93 a high-performance DNS server</span></div></div><div><br>On=
 24. 5. 2014, at 0:21, Jon Bernard &lt;<a href=3D"mailto:jbernard@debian.org=
">jbernard@debian.org</a>&gt; wrote:<br><br></div><blockquote type=3D"cite">=
<div><span>* Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@effic=
ios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:</span><br><blockquote=
 type=3D"cite"><span>Hi,</span><br></blockquote><blockquote type=3D"cite"><s=
pan></span><br></blockquote><blockquote type=3D"cite"><span>I recently stumb=
led on this patch:</span><br></blockquote><blockquote type=3D"cite"><span></=
span><br></blockquote><blockquote type=3D"cite"><span><a href=3D"http://spru=
nge.us/jYcJ">http://sprunge.us/jYcJ</a></span><br></blockquote><blockquote t=
ype=3D"cite"><span></span><br></blockquote><blockquote type=3D"cite"><span>I=
t overrides the generated config.h to ensure the</span><br></blockquote><blo=
ckquote type=3D"cite"><span>"dmb" instruction is not used.</span><br></block=
quote><blockquote type=3D"cite"><span></span><br></blockquote><blockquote ty=
pe=3D"cite"><span>However, the proper checks seems to be in place within</sp=
an><br></blockquote><blockquote type=3D"cite"><span>configure.ac to automati=
cally detect whether to use dmb</span><br></blockquote><blockquote type=3D"c=
ite"><span>or not:</span><br></blockquote><blockquote type=3D"cite"><span></=
span><br></blockquote><blockquote type=3D"cite"><span># ARM-specific checks<=
/span><br></blockquote><blockquote type=3D"cite"><span>AS_IF([test "x$ARCHTY=
PE" =3D "xarm"],[</span><br></blockquote><blockquote type=3D"cite"><span> &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC_MSG_CHECKING([for dmb instruction=
])</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;AC_COMPILE_IFELSE([AC_LANG_SOURCE([[</span><br></bl=
ockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
int main()</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;{</span><br></blockquote><blockquote type=3D"cite">=
<span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;asm volatile("dmb":::"memory");</span><br></blockquote><blockqu=
ote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><br></blockquote><blockquote t=
ype=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br></blockquo=
te><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;]])</span><br></blockquote=
><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
],[</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AC=
_MSG_RESULT([yes])</span><br></blockquote><blockquote type=3D"cite"><span> &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])</span><br></blockquot=
e><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;],[</span><br></blockquote><blockquote type=3D"cite"><span> &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A=
C_MSG_RESULT([no])</span><br></blockquote><blockquote type=3D"cite"><span> &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;])</span><br></blockquote><blockquo=
te type=3D"cite"><span>])</span><br></blockquote><blockquote type=3D"cite"><=
span></span><br></blockquote><blockquote type=3D"cite"><span>My thinking her=
e is that perhaps inappropriate compiler flags</span><br></blockquote><block=
quote type=3D"cite"><span>are used when the compiler is invoked from within "=
configure",</span><br></blockquote><blockquote type=3D"cite"><span>which lea=
ds it to think that it targets an ARMv7+ with dmb.</span><br></blockquote><b=
lockquote type=3D"cite"><span>The Debian "armel" architecture AFAIU needs to=
 target older</span><br></blockquote><blockquote type=3D"cite"><span>ARM arc=
hitectures.</span><br></blockquote><span></span><br><span>I also wonder if t=
here are some differences between of the arm build</span><br><span>machines.=
 &nbsp;I don't have shell access to the machine on which urcu was</span><br>=
<span>built so I cannot check, but perhaps that particular machine has dmb.<=
/span><br><span></span><br><blockquote type=3D"cite"><span>It would be much b=
etter to fix the compiler flags passed to</span><br></blockquote><blockquote=
 type=3D"cite"><span>configure and let urcu autodetection do what it is inte=
nded</span><br></blockquote><blockquote type=3D"cite"><span>to do rather tha=
n override the generated file.</span><br></blockquote><span></span><br><span=
>I'll gather and post the compiler flags used for urcu and we'll see.</span>=
<br><span></span><br><span>-- </span><br><span>Jon</span><br></div></blockqu=
ote></body></html>=

--Apple-Mail-D4CCEA6C-C96D-4970-AA5F-094D36AF16F1--


--===============0802722024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0802722024==--
