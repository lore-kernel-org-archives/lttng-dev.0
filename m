From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Can tracepoint be listed before app registered?
Date: Wed, 12 Mar 2014 13:30:37 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2FFA0EF5__38457.4000527666$1394631105$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WNjF4-0007oP-Uf
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 09:30:48 -0400
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

----------------------------------------------------------------------
Date: Wed, 12 Mar 2014 09:56:00 +0800

> The use case is as such a scenario:
> The target app has defined many events and  the user don't want to go ove=
r the source code to recall them. Instead, after creating a new session,
> user issue a hypothetical subcommand 'load_probe' which gather the inform=
ation from the probe library.And since then, user is able to list all
> available events yet before any app is launched.
>
> Mathieu 's idea  implementing a ELF parser to provide early event-listing=
 feature is a  good proposal. However, do you think the quantity of work
> is plenty enough to be a GSoC proposal?  I asked that because I saw some =
idea was turned down due to 'not complex enough' in some IRC channel.
>
> Lingyu

   I would see this as a natural extension of the list command.  Something =
like 'lttng list -u --application=3D/path/app'.

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
