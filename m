From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 14:15:52 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35993695__49201.8715515316$1396880196$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WXAL7-0008Fc-Go
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 10:15:59 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
> Date: Mon, 7 Apr 2014 13:43:21 +0200
> From: Jan Glauber <jan.glauber@gmail.com>
>
> I get a compile error with current git head of lttng-ust if I cross-compi=
le (bitbake):
>
> | make[4]: Entering directory `/home/jang/temp/p4/JGlauber_hal_share/poky=
/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/=
doc/examples/demo-tracef'
> | arm-linux-gnueabihf-gcc  -march=3Darmv7-a     -mthumb-interwork -mfloat=
-abi=3Dhard -mfpu=3Dneon -mtune=3Dcortex-a15 \
> |                --sysroot=3D/home/jang/temp/p4/JGlauber_hal_share/poky/b=
uild/tmp/sysroots/omap5 -L/home/jang/te \
> |                -o demo-tracef demo-tracef.o -ldl -llttng-ust
> | demo-tracef.o: file not recognized: File format not recognized
> | collect2: error: ld returned 1 exit status
> | make[4]: *** [demo-tracef] Error 1
>
> Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix thi=
s I get more
> errors which I don't undertand. Am I the only one running into this?
>
> Harman Becker Automotive GmbH
> System Profiling & Optimizing Team

   The " demo-tracef.o: file not recognized: File format not recognized" is=
 a dead giveaway that you are in a mixed-bitness context.  The linker is in=
 64-bit mode while demo-tracef.o was compiled in 32-bit mode, or vice-versa=
.  Or it could be byte sex.  Clearly, the linker call is not using the same=
 config that was used to create demo-tracef.o.  (My apologies if this seems=
 obvious to you; I'm not familiar with bitbake)

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
