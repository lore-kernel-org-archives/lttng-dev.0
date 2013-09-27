From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Exclusion event support patches
Date: Fri, 27 Sep 2013 13:13:50 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD26793BF7__18637.1470139877$1380289611$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VPXrj-0007EO-KQ
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 09:13:57 -0400
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

-----Message d'origine-----
Date: Fri, 27 Sep 2013 07:14:24 +0000
From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>

> The exclusions are embedded into the event name so that internally, the e=
vent name will be
>
> 'a*ac*,ad*'

   This takes advantage of the current wildcard restriction: the asterisk c=
an only appear once in the name, at the end of the string -an asterisk is t=
hus a string terminator.  This means that the exclusions in the name actual=
ly don't need a comma either!  The internal event name for 'a*' --exclude '=
ac*,ad*' could thus be:

'a*ac*ad*'

> This new scheme of the event name string is parsed and handled wherever n=
ecessary. This implementation poses new restrictions to event names:
> 1) An event name must not contain the character '*'.
> 2) An event name can contain a ',' character, but you cannot use it in th=
e exclusion specification.

   If we used this format, this restriction on comma use would be dropped.

> 3) If you use exclusions, the lengths of their names count against the to=
tal maximum allowed length of the event name.

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
