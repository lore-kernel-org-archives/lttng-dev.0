From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: LTTng not generating trace contents
Date: Mon, 7 Jul 2014 18:24:46 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C72E9__31729.0878775113$1404757552$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1X4Dau-000199-RT
 for lttng-dev@lists.lttng.org; Mon, 07 Jul 2014 14:24:58 -0400
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
Cc: Shariyar <syed.shariyar@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Mon, 7 Jul 2014 13:43:12 -0400
From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: [lttng-dev] LTTng not generating trace contents

> lttng --version,
>    lttng (LTTng Trace Control) 2.4.1 - ?poque Opaque
>
> lttng-sessiond --version
>    2.4.1
>
> I removed all LTTng packages from the system by manually searching in dpk=
g and reinstalled it as follows:
> sudo apt-get install lttng-tools lttng-modules-dkms babeltrace
>
> The ppa in the system is: http://ppa.launchpad.net/lttng/ppa/ubuntu

   What of the liburcu, python-lttng, liblttng-ctl0, liblttng-ctl-dev packa=
ges?  I also presume lttng-ust is not involved?  (liburcu is a prime suspec=
t because both kernel and user-space tracing depend on it)

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
