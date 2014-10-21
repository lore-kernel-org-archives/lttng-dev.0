From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Writing .tp files for lttng-gen-tp
Date: Tue, 21 Oct 2014 13:53:25 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD62070551__42150.1278099187$1413899665$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD5A244AEA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <E949C1E351B4914B87A26A5F96E06A9286AF60@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XgZsR-0003wi-9N
 for lttng-dev@lists.lttng.org; Tue, 21 Oct 2014 09:53:32 -0400
In-Reply-To: <E949C1E351B4914B87A26A5F96E06A9286AF60@PAYTON.anl.gov>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Boisvert, Sebastien" <boisvert@anl.gov>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Envoy=E9=A0: 20 octobre 2014 16:08

Question: why is it required to give the the arguments  to TRACEPOINT_EVENT=
_INSTANCE since all tracepoints from the same
class use the same arguments and same field layout ?
-----Fin du message d'origine-----

   Simply put, the arguments are part of the signature of the functions tha=
t implement the tracepoint.  You can simplify things like this:

[...]
#define thorium_event_args TP_ARGS( \
struct thorium_message *, message \
)

TRACEPOINT_EVENT_CLASS(
thorium_message,
thorium_event_template,
thorium_event_args,
TP_FIELDS(
ctf_integer(int, message_number, message->number) ctf_integer(int, message_=
action, message->action) ctf_integer(int, message_count, message->count) ct=
f_integer(int, message_source_actor, message->source_actor) ctf_integer(int=
, message_destination_actor, message->destination_actor) ctf_integer(int, m=
essage_source_node, message->source_node) ctf_integer(int, message_destinat=
ion_node, message->destination_node)
)
)

TRACEPOINT_EVENT_INSTANCE(
thorium_message,
thorium_event_template,
actor_send,
thorium_event_args
)

TRACEPOINT_EVENT_INSTANCE(
thorium_message,
thorium_event_template,
node_send,
thorium_event_args
)
[...]

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
