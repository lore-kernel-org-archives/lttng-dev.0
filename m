From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: clarification on limiting the size of the trace file
Date: Thu, 8 May 2014 13:40:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599F451__48118.8837359243$1399556490$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD3599ED94@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <25901CD29106E944B1047FED2EADF345085836E8@MX107CL01.corp.emc.com>
 <48CF5AC71E61DB46B70D0F388054EFFD3599F218@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <25901CD29106E944B1047FED2EADF3450858437E@MX107CL01.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WiOYm-0005uY-IK
 for lttng-dev@lists.lttng.org; Thu, 08 May 2014 09:40:33 -0400
In-Reply-To: <25901CD29106E944B1047FED2EADF3450858437E@MX107CL01.corp.emc.com>
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

-----Message d'origine-----
Envoy=E9=A0: 8 mai 2014 07:26

> Thanks, I upgraded and this problem was fixed. =

> But I noticed something new.
>
> When I run the "lttng list command" I get the events in different order f=
rom two locations I installed the new version.
> Did you encounter such an issue before?
>
> Mirit =


   I'm not sure I understand your question or your concern.  Do you mean th=
at the output of 'lttng list -k' is different each time it is run, or diffe=
rent between otherwise-identical machines?  Or are you talking about 'lttng=
 list -u'?  Or 'lttng list <session_name>'?

   LTTng makes no guarantees that the list of events is sorted in any parti=
cular way.  Kernel events normally appear in last-module-loaded-first order=
, with the events within a module appearing in seemingly arbitrary order (p=
robably last-declared-first within each module).  The ordering of user-spac=
e events is truly unpredictable, as it depends on the order in which tracep=
oint providers register with the session daemon.

   If you need strict ordering of the event listing, you must do it yoursel=
f (in a programmatic context) or pipe it through the 'sort' applet (in a sh=
ell script context).

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
