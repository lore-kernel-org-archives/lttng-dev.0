From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tool] Mi & save/load: add option to
 indent or not on config writer creation
Date: Thu, 7 Aug 2014 17:14:24 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3CCB4897__329.948488115583$1407431733$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XFRGo-0001cy-Bu
 for lttng-dev@lists.lttng.org; Thu, 07 Aug 2014 13:14:36 -0400
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
Date: Thu, 07 Aug 2014 11:47:59 -0400
From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Re: Message-ID: <53E39FAF.9060904@voxpopuli.im>

> I was expecting Jonathan to explain it further in his upcoming reply ;)
>
> But from the numbers I've seen from his benchmark, it was overall 50 =

> times faster when using the minified XML than using the "pretty-printed" =

> one.
> Mainly from:
> - Not having to concatenate all the outputted strings into one
> - Not having to iterate (MANY times) on empty XML nodes

> Alexandre
----------------------------------------------------------------------
   Fifty times faster!?  Impressive.

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
