From: "Sadon, Mirit" <Mirit.Sadon@emc.com>
Subject: Re: clarification on limiting the size of the trace file
Date: Thu, 8 May 2014 11:25:35 +0000
Message-ID: <25901CD29106E944B1047FED2EADF3450858437E__4885.10483778573$1399563415$gmane$org@MX107CL01.corp.emc.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD3599ED94@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <25901CD29106E944B1047FED2EADF345085836E8@MX107CL01.corp.emc.com>
 <48CF5AC71E61DB46B70D0F388054EFFD3599F218@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailuogwdur.emc.com ([128.221.224.79])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Mirit.Sadon@emc.com>) id 1WiMSc-00055Q-PS
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 07:25:59 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3599F218@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Eshel, Ayelet" <Ayelet.Eshel@emc.com>, "Mirsky,
 Ilya" <Ilya.Mirsky@emc.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

Thanks, I upgraded and this problem was fixed. =

But I noticed something new.

When I run the "lttng list command" I get the events in different order fro=
m two locations I installed the new version.
Did you encounter such an issue before?

Thanks
Mirit =


-----Original Message-----
From: Thibault, Daniel [mailto:Daniel.Thibault@drdc-rddc.gc.ca] =

Sent: Wednesday, May 07, 2014 4:03 PM
To: Sadon, Mirit; lttng-dev@lists.lttng.org
Cc: Eshel, Ayelet; Mirsky, Ilya
Subject: RE: [lttng-dev] clarification on limiting the size of the trace fi=
le

> > > We are working with lttng version 2.04.
> > This feature may not have been mature with version 2.0.4; I would recom=
mend upgrading to at least 2.3 if not 2.4.
> Envoy=E9=A0: 7 mai 2014 01:12
> This is what I understood should happen but in the actual run the lttng f=
ile fills all the free space in the partition 4GB.
> Mirit Sadon

   I just ran a test and in both kernel and user-space tracing modes LTTng =
2.3 behaved precisely as expected.  I can only suggest that your problem is=
 probably due to LTTng 2.0.4 not handling the instructions correctly.  Upgr=
ading is the solution.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC) Cyber s=E9curit=E9 pour les missions essentielles (CME) =
| Mission Critical Cyber Security (MCCS) R & D pour la d=E9fense Canada - V=
alcartier (RDDC Valcartier) | Defence R&D Canada - Valcartier (DRDC Valcart=
ier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
