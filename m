From: Salman Rafiq <salman.rafiq@esk.fraunhofer.de>
Subject: Re: Reading CTF trace using Babeltrace API
Date: Mon, 7 Oct 2013 17:54:05 +0200
Message-ID: <E537659DE2B2C54EBD9FC9180F059880395D860010__4541.63862527839$1381161322$gmane$org@zulu.esk.fraunhofer.de>
References: <E537659DE2B2C54EBD9FC9180F059880395D85FEA2@zulu.esk.fraunhofer.de>
	<CA+jJMxtmqSLA9wpyCMxCo5i7k2=ndL_GZNi8Dbw8YsSbQ15qeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx-relay04-dus.antispameurope.com ([94.100.134.204])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <salman.rafiq@esk.fraunhofer.de>) id 1VTD8U-0004ZL-Tv
	for lttng-dev@lists.lttng.org; Mon, 07 Oct 2013 11:54:25 -0400
In-Reply-To: <CA+jJMxtmqSLA9wpyCMxCo5i7k2=ndL_GZNi8Dbw8YsSbQ15qeQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "jdesfossez@efficios.com" <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi J=E9r=E9mie,

Thanks for your prompt reply.


Just to add a little to your answer:

In order to get the event "id" field, we need to call another function as w=
ell. =

Since the "id" field is declared as an enumerated data type (uint16_t for l=
arge header and uint5_t for compact). =

For example, to read the event id, it works only by calling bt_ctf_get_enum=
_int(id_field), otherwise it returns 0.

Slight modification to the code sample did the job:

while ((ctf_event =3D bt_ctf_iter_read_event(iter))) {

        const struct bt_definition *stream_event_header_scope =3D
                bt_ctf_get_top_level_scope(
                        ctf_event, BT_STREAM_EVENT_HEADER);
        const struct bt_definition *id_field =3D
                bt_ctf_get_field(
                        ctf_event, stream_event_header_scope, "id");

        printf("id =3D %" PRIu64 "\n", bt_ctf_get_uint64(bt_ctf_get_enum_in=
t(id_field)));  	// change here!!!
		=



But I am getting strange behavior only for the "sched_switch" event. =

Each time I read it, it returns 31 in case the header is compact (31 events=
 max) and 65535 when the header is large instead of the correct value.

For all other "id's" of the event, it returns correct value :-s

I am unable to figure out the reason. Please let me know, if you have any i=
nformation in this regard. =

Thanks a lot!

Regards,
Salman

--
Salman Rafiq
Gesch=E4ftsfeld Industrial Communication
Fraunhofer-Institut  f=FCr Eingebettete Systeme und Kommunikationstechnik E=
SK

Hansastra=DFe 32 | 80686 M=FCnchen
Telefon, Fax:=A0 +49 89 547088-356 | +49 89 547088-221
E-Mail:=A0=A0 salman.rafiq@esk.fraunhofer.de
=A0 =

Internet: =

http://www.esk.fraunhofer.de
http://www.twitter.com/FraunhoferESK


-----Original Message-----
From: jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com] On B=
ehalf Of J=E9r=E9mie Galarneau
Sent: Mittwoch, 2. Oktober 2013 20:25
To: Salman Rafiq
Cc: jdesfossez@efficios.com; lttng-dev@lists.lttng.org; Mathieu Desnoyers
Subject: Re: Reading CTF trace using Babeltrace API

On Wed, Oct 2, 2013 at 12:55 PM, Salman Rafiq <salman.rafiq@esk.fraunhofer.=
de> wrote:
> Dear LTTngers,
>
> I would like to ask few questions related to the API's for reading CTF tr=
aces.
>
> 1.  Is there any way to read CTF metadata independently, like we have cer=
tain API's to read the events.
>

Not from the public API, unfortunately.

> 2. There are certain scopes defined in ctf/events.h like:
>         BT_TRACE_PACKET_HEADER          =3D 0,
>         BT_STREAM_PACKET_CONTEXT        =3D 1,
>         BT_STREAM_EVENT_HEADER          =3D 2,
>         BT_STREAM_EVENT_CONTEXT         =3D 3,
>         BT_EVENT_CONTEXT                =3D 4,
>         BT_EVENT_FIELDS                 =3D 5,
>
> I could not figure out the way to ready the fields 'id' and 'stream_id', =
for a particular event while iterating through the trace.
> Though I can ready the event name using an API and fields using BT_EVENT_=
FIELDS as a scope.
> For e.g. consider the
>
> event {
>         name =3D sched_migrate_task;
>         id =3D 1;
>         stream_id =3D 0;
>         fields :=3D struct {
>                 integer { size =3D 8; align =3D 8; signed =3D 1; encoding=
 =3D UTF8; base =3D 10; } _comm[16];
>                 integer { size =3D 32; align =3D 8; signed =3D 1; encodin=
g =3D none; base =3D 10; } _tid;
>                 integer { size =3D 32; align =3D 8; signed =3D 1; encodin=
g =3D none; base =3D 10; } _prio;
>                 integer { size =3D 32; align =3D 8; signed =3D 1; encodin=
g =3D none; base =3D 10; } _orig_cpu;
>                 integer { size =3D 32; align =3D 8; signed =3D 1; encodin=
g =3D none; base =3D 10; } _dest_cpu;
>         };
> };
>

The "id" field is part of the BT_STREAM_EVENT_HEADER scope, while the "stre=
am_id" field is part of the BT_TRACE_PACKET_HEADER scope.

The code below is adapted from converter/babeltrace.c's
convert_trace() loop to print both values.

while ((ctf_event =3D bt_ctf_iter_read_event(iter))) {

        const struct bt_definition *stream_event_header_scope =3D
                bt_ctf_get_top_level_scope(
                        ctf_event, BT_STREAM_EVENT_HEADER);
        const struct bt_definition *id_field =3D
                bt_ctf_get_field(
                        ctf_event, stream_event_header_scope, "id");

        printf("id =3D %" PRIu64 "\n", bt_ctf_get_uint64(id_field));

        const struct bt_definition *packet_header_scope =3D
                bt_ctf_get_top_level_scope(
                        ctf_event, BT_TRACE_PACKET_HEADER);
        const struct bt_definition *stream_id_field =3D
                bt_ctf_get_field(
                        ctf_event, packet_header_scope, "stream_id");

        printf("stream_id =3D %" PRIu64 "\n", bt_ctf_get_uint64(
                       stream_id_field)); [...] }

Regards,
J=E9r=E9mie

>
> Any help or suggestion related to this issue will be really appreciated.
> Thanks!
>
> Regards,
> Salman
>
> --
> Salman Rafiq
> Gesch=E4ftsfeld Industrial Communication Fraunhofer-Institut  f=FCr =

> Eingebettete Systeme und Kommunikationstechnik ESK
>
> Hansastra=DFe 32 | 80686 M=FCnchen
> Telefon, Fax:  +49 89 547088-356 | +49 89 547088-221
> E-Mail:   salman.rafiq@esk.fraunhofer.de
>
> Internet:
> http://www.esk.fraunhofer.de
> http://www.twitter.com/FraunhoferESK
>



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
