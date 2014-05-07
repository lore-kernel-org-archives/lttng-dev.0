From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: clarification on limiting the size of the trace file
Date: Wed, 7 May 2014 13:02:54 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599F218__15734.574935823$1399467833$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD3599ED94@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <25901CD29106E944B1047FED2EADF345085836E8@MX107CL01.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Wi1Uz-0005ao-JD
 for lttng-dev@lists.lttng.org; Wed, 07 May 2014 09:03:02 -0400
In-Reply-To: <25901CD29106E944B1047FED2EADF345085836E8@MX107CL01.corp.emc.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Sadon, Mirit" <Mirit.Sadon@emc.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Eshel, Ayelet" <Ayelet.Eshel@emc.com>, "Mirsky,
 Ilya" <Ilya.Mirsky@emc.com>
List-Id: lttng-dev@lists.lttng.org

> > > We are working with lttng version 2.04.
> > This feature may not have been mature with version 2.0.4; I would recom=
mend upgrading to at least 2.3 if not 2.4.
> Envoy=E9=A0: 7 mai 2014 01:12
> This is what I understood should happen but in the actual run the lttng f=
ile fills all the free space in the partition 4GB.
> Mirit Sadon =


   I just ran a test and in both kernel and user-space tracing modes LTTng =
2.3 behaved precisely as expected.  I can only suggest that your problem is=
 probably due to LTTng 2.0.4 not handling the instructions correctly.  Upgr=
ading is the solution.

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
