From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: No trace files are generated for UST
Date: Fri, 6 Dec 2013 15:44:22 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267B2DF5__14611.8941870101$1386344722$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DCF@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0B6@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VoxZo-0003HX-3v
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 10:44:29 -0500
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43ACC0B6@SGSINEXC014.vestas.net>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> As I'm using the custom image on x86 machine, i've kept the lib in /tmp/l=
ttng-build-root/lib folder and this sample able to see the library as well.
>
> And the same way I able to create the trace files for kernel but not for =
ust. There were no dmesg as well.
>
> [...]
> root@/tmp # ldd sample
>         linux-vdso.so.1 (0x00007fff2a135000)
>         libdl.so.2 =3D> /lib64/libdl.so.2 (0x00007fe2cccb5000)
>         liblttng-ust.so.0 =3D> /tmp/lttng-build-root/lib/liblttng-ust.so.=
0 (0x00007fe2cca51000)
>         [...]

   Try running sample using:

LD_PRELOAD=3D/tmp/lttng-build-root/lib/liblttng-ust.so.0 ./sample

   If the LD_PRELOAD succeeds, we will know at least that liblttng-ust is r=
eachable by sample.

   The modules have nothing to do with UST: kernel and user-space tracing a=
re essentially independent features.

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
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
