From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 16:33:32 +0200
Message-ID: <CAEiAFz0dO8r44buhHmKTy3Y_Jc_5P1aJL1KyGVZi6c2o+5PwvQ__41237.0686223314$1396881265$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35993695@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0230057235=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WXAcE-0008Qg-8m
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 10:33:42 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so793667qgf.6
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 07:33:32 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD35993695@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0230057235==
Content-Type: multipart/alternative; boundary=001a1134f2be7bd9b904f674c089

--001a1134f2be7bd9b904f674c089
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

you're right, the demo-tracef has in the Makefile:
CC =3D gcc
which should be fixed like J=E9r=E9mie said. With that change demo-tracef
compiles but I run into the python error.

--Jan


2014-04-07 16:15 GMT+02:00 Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.c=
a
>:

> ----------------------------------------------------------------------
> > Date: Mon, 7 Apr 2014 13:43:21 +0200
> > From: Jan Glauber <jan.glauber@gmail.com>
> >
> > I get a compile error with current git head of lttng-ust if I
> cross-compile (bitbake):
> >
> > | make[4]: Entering directory
> `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-n=
eon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/demo-tracef'
> > | arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwork
> -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15 \
> > |
>  --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroot=
s/omap5
> -L/home/jang/te \
> > |                -o demo-tracef demo-tracef.o -ldl -llttng-ust
> > | demo-tracef.o: file not recognized: File format not recognized
> > | collect2: error: ld returned 1 exit status
> > | make[4]: *** [demo-tracef] Error 1
> >
> > Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix
> this I get more
> > errors which I don't undertand. Am I the only one running into this?
> >
> > Harman Becker Automotive GmbH
> > System Profiling & Optimizing Team
>
>    The " demo-tracef.o: file not recognized: File format not recognized"
> is a dead giveaway that you are in a mixed-bitness context.  The linker i=
s
> in 64-bit mode while demo-tracef.o was compiled in 32-bit mode, or
> vice-versa.  Or it could be byte sex.  Clearly, the linker call is not
> using the same config that was used to create demo-tracef.o.  (My apologi=
es
> if this seems obvious to you; I'm not familiar with bitbake)
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a1134f2be7bd9b904f674c089
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Daniel,<br><br></div>you&#39;re right, t=
he demo-tracef has in the Makefile:<br>CC =3D gcc<br></div>which should be =
fixed like J=E9r=E9mie said. With that change demo-tracef compiles but I ru=
n into the python error.<br>
<br></div>--Jan<br></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">2014-04-07 16:15 GMT+02:00 Thibault, Daniel <span dir=3D"ltr">&=
lt;<a href=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Dan=
iel.Thibault@drdc-rddc.gc.ca</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">--------------------------------------------=
--------------------------<br>
&gt; Date: Mon, 7 Apr 2014 13:43:21 +0200<br>
&gt; From: Jan Glauber &lt;<a href=3D"mailto:jan.glauber@gmail.com">jan.gla=
uber@gmail.com</a>&gt;<br>
<div class=3D"">&gt;<br>
&gt; I get a compile error with current git head of lttng-ust if I cross-co=
mpile (bitbake):<br>
&gt;<br>
&gt; | make[4]: Entering directory `/home/jang/temp/p4/JGlauber_hal_share/p=
oky/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/g=
it/doc/examples/demo-tracef&#39;<br>
&gt; | arm-linux-gnueabihf-gcc =A0-march=3Darmv7-a =A0 =A0 -mthumb-interwor=
k -mfloat-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15 \<br>
&gt; | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0--sysroot=3D/home/jang/temp/p4/JGlaub=
er_hal_share/poky/build/tmp/sysroots/omap5 -L/home/jang/te \<br>
&gt; | =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-o demo-tracef demo-tracef.o -ldl -ll=
ttng-ust<br>
&gt; | demo-tracef.o: file not recognized: File format not recognized<br>
&gt; | collect2: error: ld returned 1 exit status<br>
&gt; | make[4]: *** [demo-tracef] Error 1<br>
&gt;<br>
&gt; Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix =
this I get more<br>
&gt; errors which I don&#39;t undertand. Am I the only one running into thi=
s?<br>
&gt;<br>
</div><div class=3D"">&gt; Harman Becker Automotive GmbH<br>
&gt; System Profiling &amp; Optimizing Team<br>
<br>
</div>=A0 =A0The &quot; demo-tracef.o: file not recognized: File format not=
 recognized&quot; is a dead giveaway that you are in a mixed-bitness contex=
t. =A0The linker is in 64-bit mode while demo-tracef.o was compiled in 32-b=
it mode, or vice-versa. =A0Or it could be byte sex. =A0Clearly, the linker =
call is not using the same config that was used to create demo-tracef.o. =
=A0(My apologies if this seems obvious to you; I&#39;m not familiar with bi=
tbake)<br>

<br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000">(=
418) 844-4000 x4245</a><br>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538">(418) 844=
-4538</a><br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br></div>

--001a1134f2be7bd9b904f674c089--


--===============0230057235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0230057235==--
