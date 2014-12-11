From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Errors compiling converted tp file
Date: Thu, 11 Dec 2014 14:31:18 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBE2996__13790.335370186$1418308330$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD6FBE18D6@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <9F3E07F7-AA26-49A3-BE48-E117868890E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Xz4m5-0001SH-8U
 for lttng-dev@lists.lttng.org; Thu, 11 Dec 2014 09:31:27 -0500
In-Reply-To: <9F3E07F7-AA26-49A3-BE48-E117868890E2@gmail.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yan Grange <ygrange@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

>>   In order to trace user-space, you must install, in sequence, the follo=
wing packages: userspace-rcu, lttng-ust, lttng-tools.  Was this done?
>>
>   I tried to install the right packages but there don't seem to be packag=
es named like that in either the ubuntu repository or the ppa provided by y=
ou.
>
> I have the following packages installed:
> lttng-tools
> liblttng-ust0
> liblttng-ust-dev
> liblttng-ust-ctl2
> liblttng-ctl0
> liburcu-dev
> liburcu2
>
> With all this installed, I still don't get it to work.
>
> Yan Grange

   The equivalencies are as follows:
* userspace-rcu (git.lttng.org) =3D liburcu (LTTng PPA) =3D liburcu1, libur=
cu-dev (Ubuntu)
* lttng-ust (git.lttng.org) =3D lttng-ust (LTTng PPA) =3D liblttng-ust0, li=
blttng-ust-dev (Ubuntu)
* lttng-tools (git.lttng.org) =3D lttng- tools (LTTng PPA) =3D lttng-tools,=
 liblttng-ctl0, liblttng-ctl-dev (Ubuntu)

   You should not install from the Ubuntu repositories, as they are obsolet=
e (and have been obsolete for a long time now).

   For kernel tracing, lttng-modules can be fetched from git.lttng.org or t=
he LTTng PPA; the Ubuntu repository equivalent is lttng-modules-dkms (obsol=
ete).

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
