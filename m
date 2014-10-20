From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Writing .tp files for lttng-gen-tp
Date: Mon, 20 Oct 2014 13:29:17 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD5A244AEA__44897.0173289583$1413811825$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XgD1p-0003nc-BP
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 09:29:43 -0400
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
Date: Fri, 17 Oct 2014 21:39:21 +0000
From: "Boisvert, Sebastien" <boisvert@anl.gov>

> I wrote a big .tp file to define numerous tracepoints that only differ in=
 the event name.
> They all take the same arguments and they all dump the same fields.
>
> .tp file: https://github.com/sebhtml/biosal/blob/master/engine/thorium/tr=
acepoints/lttng/message.tp
>
> Is there a more compact way of doing that ?
>
>               S=E9bastien
----------------------------------------------------------------------
   In the kernel domain, one can declare a "tracepoint class" with DECLARE_=
EVENT_CLASS, and then use DEFINE_EVENT to instantiate the abstract event cl=
ass into individual trace events that share a single signature.  Surely the=
 same can be done in user-space?

   Looking at /usr/src/lttng-ust/include/lttng/tracepoint.h, we see there a=
re TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVENT_INSTANCE macros right beside=
 TRACEPOINT_EVENT, so I suspect you could replace your message.tp with some=
thing like:

[...]
TRACEPOINT_EVENT_CLASS(
thorium_message,
thorium_event_template,
TP_ARGS(
struct thorium_message *, message
),
TP_FIELDS(
ctf_integer(int, message_number, message->number)
ctf_integer(int, message_action, message->action)
ctf_integer(int, message_count, message->count)
ctf_integer(int, message_source_actor, message->source_actor)
ctf_integer(int, message_destination_actor, message->destination_actor)
ctf_integer(int, message_source_node, message->source_node)
ctf_integer(int, message_destination_node, message->destination_node)
)
)

TRACEPOINT_EVENT_INSTANCE(
thorium_message,
thorium_event_template, =

actor_send,
TP_ARGS(
struct thorium_message *, message
)
)

TRACEPOINT_EVENT_INSTANCE(
thorium_message,
thorium_event_template, =

node_send,
TP_ARGS(
struct thorium_message *, message
)
)
[...]

   Try it and let us know.  This should be added to the lttng-gen-tp man pa=
ges if it works.

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
