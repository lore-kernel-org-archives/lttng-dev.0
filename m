From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Re: Writing .tp files for lttng-gen-tp
Date: Mon, 20 Oct 2014 20:07:35 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286AF60__21207.9249824912$1413835733$gmane$org@PAYTON.anl.gov>
References: <48CF5AC71E61DB46B70D0F388054EFFD5A244AEA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XgJF6-0006CD-0w
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 16:07:53 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id 90FAC7CC1FC
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 15:07:40 -0500 (CDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD5A244AEA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

TRACEPOINT_EVENT_CLASS + TRACEPOINT_EVENT_INSTANCE work.

Thanks.

The documentation is in include/lttng/ust-tracepoint-event.h (lttng-ust) an=
d the last change was made
in 2011:

1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  63) /*
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  64)  * TRACEPOINT_EV=
ENT_CLASS declares a class of tracepoints receiving the
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  65)  * same argument=
s and having the same field layout.
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  66)  *
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  67)  * TRACEPOINT_EV=
ENT_INSTANCE declares an instance of a tracepoint, with
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  68)  * its own provi=
der and name. It refers to a class (template).
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  69)  *
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  70)  * TRACEPOINT_EV=
ENT declared both a class and an instance and does a
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  71)  * direct mappin=
g from the instance to the class.
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  72)  */
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  73) =

1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  74) #undef TRACEPOIN=
T_EVENT
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  75) #define TRACEPOI=
NT_EVENT(_provider, _name, _args, _fields)   \
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  76)      TRACEPOINT_=
EVENT_CLASS(_provider, _name,                \
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  77)                 =
      _TP_PARAMS(_args),                     \
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  78)                 =
      _TP_PARAMS(_fields))                   \
1c324e59 (Mathieu Desnoyers 2011-11-18 12:36:52 -0500  79)      TRACEPOINT_=
EVENT_INSTANCE(_provider, _name, _name,      \
68755429 (Mathieu Desnoyers 2012-03-01 14:39:02 -0500  80)                 =
      _TP_PARAMS(_args))


Question: why is it required to give the the arguments  to TRACEPOINT_EVENT=
_INSTANCE since all tracepoints from the same
class use the same arguments and same field layout ?

> ________________________________________
> From: Thibault, Daniel [Daniel.Thibault@drdc-rddc.gc.ca]
> Sent: Monday, October 20, 2014 8:29 AM
> To: lttng-dev@lists.lttng.org
> Cc: Boisvert, Sebastien
> Subject: RE: [lttng-dev] Writing .tp files for lttng-gen-tp
> ----------------------------------------------------------------------
> Date: Fri, 17 Oct 2014 21:39:21 +0000
> From: "Boisvert, Sebastien" <boisvert@anl.gov>
> > I wrote a big .tp file to define numerous tracepoints that only differ =
in the event name.
> > They all take the same arguments and they all dump the same fields.
> >
> > .tp file: https://github.com/sebhtml/biosal/blob/master/engine/thorium/=
tracepoints/lttng/message.tp
> >
> > Is there a more compact way of doing that ?
> >
> >               S=E9bastien
> ----------------------------------------------------------------------
>    In the kernel domain, one can declare a "tracepoint class" with DECLAR=
E_EVENT_CLASS, and then use DEFINE_EVENT to instantiate the abstract event =
class into individual trace events that share a single signature.  Surely t=
he same can be done in user-space?
>    Looking at /usr/src/lttng-ust/include/lttng/tracepoint.h, we see there=
 are TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVENT_INSTANCE macros right besi=
de TRACEPOINT_EVENT, so I suspect you could replace your message.tp with so=
mething like:
> [...]
> TRACEPOINT_EVENT_CLASS(
> thorium_message,
> thorium_event_template,
> TP_ARGS(
> struct thorium_message *, message
> ),
> TP_FIELDS(
> ctf_integer(int, message_number, message->number)
> ctf_integer(int, message_action, message->action)
> ctf_integer(int, message_count, message->count)
> ctf_integer(int, message_source_actor, message->source_actor)
> ctf_integer(int, message_destination_actor, message->destination_actor)
> ctf_integer(int, message_source_node, message->source_node)
> ctf_integer(int, message_destination_node, message->destination_node)
> )
> )
> TRACEPOINT_EVENT_INSTANCE(
> thorium_message,
> thorium_event_template,
> actor_send,
> TP_ARGS(
> struct thorium_message *, message
> )
> )
> TRACEPOINT_EVENT_INSTANCE(
> thorium_message,
> thorium_event_template,
> node_send,
> TP_ARGS(
> struct thorium_message *, message
> )
> )
> [...]
>    Try it and let us know.  This should be added to the lttng-gen-tp man =
pages if it works.
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
