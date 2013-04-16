From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: linux 3.4.3 and LTTNG patch files
Date: Tue, 16 Apr 2013 20:59:36 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D0E691__35294.5749568336$1366146057$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1USCzT-0000Uf-U6
	for lttng-dev@lists.lttng.org; Tue, 16 Apr 2013 17:00:36 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> I have now looked at download page http://lttng.org/download
>
> Below section and links appears to be relevant for me.
> LTTng 2.1 "Basse Messe"<http://lttng.org/version-naming> - Tracer toolcha=
in
> LTTng-tools 2.1.1<http://lttng.org/files/lttng-tools/lttng-tools-2.1.1.ta=
r.bz2> (Changelog)
><http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob_plain;f=3DChangeLog;hb=
=3Drefs/heads/stable-2.1> the trace control client
> LTTng-modules 2.1.1<http://lttng.org/files/lttng-modules/lttng-modules-2.=
1.1.tar.bz2> (Changelog)<http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dbl=
ob_plain;f=3DChangeLog;hb=3Drefs/heads/stable-2.1> the kernel modules (requ=
ires at least Linux 2.6.38)
> LTTng-UST 2.1.2<http://lttng.org/files/lttng-ust/lttng-ust-2.1.2.tar.bz2>=
 (Changelog)<http://git.lttng.org/?p=3Dlttng-ust.git;a=3Dblob_plain;f=3DCha=
ngeLog;hb=3Drefs/heads/stable-2.1>
> the userspace tracing library
>
> Could you please let me know if these installation can be done without pa=
tching the kernel  (unlike lttng 0.x)
>
> Sorry again for taking your time. I am just getting started :(

   Absolutely: no patching required.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
