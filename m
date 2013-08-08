From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools]
 Fix:LTTNG_ERR_NEED_ROOT_SESSIOND error message
Date: Thu, 8 Aug 2013 15:28:32 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD266613A8__17474.648069083$1375975765$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD26661377@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<20130808152135.GA26526@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V7S8g-0001rX-91
	for lttng-dev@lists.lttng.org; Thu, 08 Aug 2013 11:28:39 -0400
In-Reply-To: <20130808152135.GA26526@Krystal>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

Envoy=E9=A0: 8 ao=FBt 2013 11:22

* Thibault, Daniel (Daniel.Thibault@drdc-rddc.gc.ca) wrote:
>    Unless there's been a change in the code, that is just not true.  You =
can trace the kernel just fine without 'tracing' group membership, as long =
as you have sudo privileges (and can thus call 'sudo -H lttng').  The root =
daemon is necessary either way: the text should just read "Tracing the kern=
el requires a root lttng-sessiond daemon".

The actual right way to word it would be:

Tracing the kernel requires a root lttng-sessiond daemon, as well as \"trac=
ing\" group membership or root user ID for the lttng client.

Makes sense ?

Mathieu
-----Fin du message d'origine-----

   Yeah, that's a fairly good way of saying you need a root lttng-sessiond =
daemon and some means of giving it instructions.  Since it is theoretically=
 possible for a third-party application to send instructions directly to th=
e root lttng-sessiond daemon (using the API) without using the lttng client=
, maybe that could be phrased "... or root user ID for lttng clients."  (Or=
 am I mistaken in that belief?)

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
