From: Salman Rafiq <salman.rafiq@esk.fraunhofer.de>
Subject: Re: Reading CTF trace using Babeltrace API
Date: Sun, 3 Nov 2013 20:39:30 +0100
Message-ID: <E537659DE2B2C54EBD9FC9180F059880395D9265B1__36099.802729632$1383507944$gmane$org@zulu.esk.fraunhofer.de>
References: <E537659DE2B2C54EBD9FC9180F059880395D85FEA2@zulu.esk.fraunhofer.de>
	<CA+jJMxtmqSLA9wpyCMxCo5i7k2=ndL_GZNi8Dbw8YsSbQ15qeQ@mail.gmail.com>
	<E537659DE2B2C54EBD9FC9180F059880395D860010@zulu.esk.fraunhofer.de>
	<CA+jJMxsMU5u_4m3pUPJ6EBQVKTL_4+PNSj8iHvRcn6CJ=bt6Ag@mail.gmail.com>
	<439534666.36114.1381274066505.JavaMail.zimbra@efficios.com>
	<CA+jJMxtK8ZHvXKw3Ea6wxF_6f8_LwmkDahbxCg=rBu3SXjBMWg@mail.gmail.com>,
	<E537659DE2B2C54EBD9FC9180F059880395D955070@zulu.esk.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx-relay14-dus.antispameurope.com ([94.100.134.214])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <salman.rafiq@esk.fraunhofer.de>) id 1Vd3b5-00083P-CE
	for lttng-dev@lists.lttng.org; Sun, 03 Nov 2013 14:44:37 -0500
In-Reply-To: <E537659DE2B2C54EBD9FC9180F059880395D955070@zulu.esk.fraunhofer.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi J=E9r=E9mie,

Sorry for being a little impatient. =

Please do let me know if you can provide some information regarding my prev=
ious email.

Thanks!
Salman

--
Salman Rafiq
Gesch=E4ftsfeld Industrial Communication
Fraunhofer-Institut  f=FCr Eingebettete Systeme und Kommunikationstechnik E=
SK

Hansastra=DFe 32 | 80686 M=FCnchen
Telefon, Fax:  +49 89 547088-356 | +49 89 547088-221
E-Mail:   salman.rafiq@esk.fraunhofer.de

Internet:
http://www.esk.fraunhofer.de
http://www.twitter.com/FraunhoferESK

________________________________________
From: Salman Rafiq [salman.rafiq@esk.fraunhofer.de]
Sent: Wednesday, October 23, 2013 4:50 PM
To: J=E9r=E9mie Galarneau; Mathieu Desnoyers
Cc: lttng-dev@lists.lttng.org; Julien Desfossez
Subject: Re: [lttng-dev] Reading CTF trace using Babeltrace API

Hello again :)

While reading Kernel trace events (system calls), I came across an issue re=
lated to reading the field 'args' inside 'sys_unknown' system call event.

Below is the information I get using public babeltrace API's for the event =
field type.
Ctf_type_id =3D 8  (CTF_TYPE_ARRAY)


But when I try to read the value for the field using the following API
char * bt_ctf_get_char_array(const struct bt_definition *field);

I receive null value. Also it gives me warning that I am instead extracting=
 a String.
[warning] Extracting String

Also, I am unable to read the value using the following API.
char *bt_ctf_get_string(const struct bt_definition *field);


below is the sample event recorded:
[00002934900435406801] (+0.000009630) sys_unknown: { cpu_id =3D 3 }, { id =
=3D 277, args =3D [ [0] =3D 22, [1] =3D 0, [2] =3D 4096, [3] =3D 2, [4] =3D=
 4096, [5] =3D 5 ] }

AND the event definition:
event {
        name =3D sys_unknown;
        id =3D 2;
        stream_id =3D 0;
        fields :=3D struct {
                integer { size =3D 32; align =3D 8; signed =3D 0; encoding =
=3D none; base =3D 10; } _id
                integer { size =3D 64; align =3D 8; signed =3D 0; encoding =
=3D none; base =3D 10; } _args[6];
        };
};


Any suggestion related to that will be very helpful.
Thanks!

Best Regards,
Salman
--
Salman Rafiq
Gesch=E4ftsfeld Industrial Communication
Fraunhofer-Institut  f=FCr Eingebettete Systeme und Kommunikationstechnik E=
SK

Hansastra=DFe 32 | 80686 M=FCnchen
Telefon, Fax:  +49 89 547088-356 | +49 89 547088-221
E-Mail:   salman.rafiq@esk.fraunhofer.de

Internet:
http://www.esk.fraunhofer.de
http://www.twitter.com/FraunhoferESK


-----Original Message-----
From: jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com] On B=
ehalf Of J=E9r=E9mie Galarneau
Sent: Mittwoch, 9. Oktober 2013 01:50
To: Mathieu Desnoyers
Cc: Salman Rafiq; Julien Desfossez; lttng-dev@lists.lttng.org
Subject: Re: Reading CTF trace using Babeltrace API

On Tue, Oct 8, 2013 at 7:14 PM, Mathieu Desnoyers <mathieu.desnoyers@effici=
os.com> wrote:
> ----- Original Message -----
>> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
>> To: "Salman Rafiq" <salman.rafiq@esk.fraunhofer.de>
>> Cc: jdesfossez@efficios.com, lttng-dev@lists.lttng.org, "Mathieu
>> Desnoyers" <mathieu.desnoyers@efficios.com>
>> Sent: Tuesday, October 8, 2013 2:52:38 PM
>> Subject: Re: Reading CTF trace using Babeltrace API
> [...]
>>
>> The problem is that the "id" fields in both struct
>> event_header_compact and event_header_large acts as a variant's tag
>> enumeration.
>>
>> For instance, if we take a look at the event_header_compact
>> structure,
>>
>> struct event_header_compact {
>>         enum : uint5_t { compact =3D 0 ... 30, extended =3D 31 } id;
>>         variant <id> {
>>                 struct {
>>                         uint27_clock_monotonic_t timestamp;
>>                 } compact;
>>                 struct {
>>                         uint32_t id;
>>                         uint64_clock_monotonic_t timestamp;
>>                 } extended;
>>         } v;
>> } align(8);
>>
>> The "enum id" field will indicate the event's id if it has a value of
>> [0, 30]. It also indicates that the "compact" structure is selected
>> in the variant that follows. If id =3D=3D 31, the "extended" structure is
>> selected, which means that you should retrieve the "id" field's value
>> from that structure.
>>
>> Since code is worth a thousand words, here's a more complete code
>> sample to read the id fields.
>>
>> while ((ctf_event =3D bt_ctf_iter_read_event(iter))) {
>>         uint64_t event_id =3D 0;
>>         const struct bt_definition *stream_event_header_scope =3D
>>                 bt_ctf_get_top_level_scope(
>>                         ctf_event, BT_STREAM_EVENT_HEADER);
>>         const struct bt_definition *id_definition =3D
>>                 bt_ctf_get_field(ctf_event, stream_event_header_scope,
>>                                  "id");
>>         const struct bt_definition *v_definition =3D
>>                 bt_ctf_get_field(ctf_event, stream_event_header_scope,
>>                                  "v");
>>
>>         /* "id may be an enum, get the underlying integer if it's the ca=
se */
>>         if (id_definition &&
>> bt_ctf_field_type(bt_ctf_get_decl_from_def(id_definition)) =3D=3D
>> CTF_TYPE_ENUM) {
>>                 id_definition =3D bt_ctf_get_enum_int(id_definition);
>>         }
>>
>>         /* Check if there is a "v" field and if it contains an "id" fiel=
d */
>>         if (v_definition &&
>> bt_ctf_field_type(bt_ctf_get_decl_from_def(v_definition)) =3D=3D
>> CTF_TYPE_STRUCT) {
>>                 struct bt_definition const * const *list =3D NULL;
>>                 unsigned int count =3D 0;
>>                 unsigned int i;
>>
>>                 ret =3D bt_ctf_get_field_list(ctf_event, v_definition,
>> &list, &count);
>>                 if (ret) {
>>                         goto end;
>>                 }
>>
>>                 for (i =3D 0; i < count; i++) {
>>                         const char *name =3D
>> bt_ctf_field_name(list[i]);
>>
>>                         if (strcmp("id", name) =3D=3D 0) {
>>                                 id_definition =3D list[i];
>>                                 break;
>>                         }
>>                 }
>
> Instead of doing this bt_ctf_get_field_list() and iteration, can't we sim=
ply use bt_ctf_get_field() to try getting the struct bt_definition ?

Right. I was under the impression the bt_ctf_get_field() would only work on=
 scopes, but it's not the case.

Thanks!
J=E9r=E9mie

>
> Thanks,
>
> Mathieu
>
>>         }
>>
>>         if (id_definition &&
>> bt_ctf_field_type(bt_ctf_get_decl_from_def(id_definition)) =3D=3D
>> CTF_TYPE_INTEGER) {
>>                 event_id =3D bt_ctf_get_uint64(id_definition);
>>         }
>>
>>         printf("id =3D %" PRIu64 "\n", event_id); }
>>
>> Regards,
>> J=E9r=E9mie
>>
>> > Thanks a lot!
>> >
>> > Regards,
>> > Salman
>> >
>> > --
>> > Salman Rafiq
>> > Gesch=E4ftsfeld Industrial Communication Fraunhofer-Institut  f=FCr
>> > Eingebettete Systeme und Kommunikationstechnik ESK
>> >
>> > Hansastra=DFe 32 | 80686 M=FCnchen
>> > Telefon, Fax:  +49 89 547088-356 | +49 89 547088-221
>> > E-Mail:   salman.rafiq@esk.fraunhofer.de
>> >
>> > Internet:
>> > http://www.esk.fraunhofer.de
>> > http://www.twitter.com/FraunhoferESK
>> >
>> >
>> > -----Original Message-----
>> > From: jeremie.galarneau@gmail.com
>> > [mailto:jeremie.galarneau@gmail.com] On Behalf Of J=E9r=E9mie Galarneau
>> > Sent: Mittwoch, 2. Oktober 2013 20:25
>> > To: Salman Rafiq
>> > Cc: jdesfossez@efficios.com; lttng-dev@lists.lttng.org; Mathieu
>> > Desnoyers
>> > Subject: Re: Reading CTF trace using Babeltrace API
>> >
>> > On Wed, Oct 2, 2013 at 12:55 PM, Salman Rafiq
>> > <salman.rafiq@esk.fraunhofer.de> wrote:
>> >> Dear LTTngers,
>> >>
>> >> I would like to ask few questions related to the API's for reading
>> >> CTF traces.
>> >>
>> >> 1.  Is there any way to read CTF metadata independently, like we
>> >> have certain API's to read the events.
>> >>
>> >
>> > Not from the public API, unfortunately.
>> >
>> >> 2. There are certain scopes defined in ctf/events.h like:
>> >>         BT_TRACE_PACKET_HEADER          =3D 0,
>> >>         BT_STREAM_PACKET_CONTEXT        =3D 1,
>> >>         BT_STREAM_EVENT_HEADER          =3D 2,
>> >>         BT_STREAM_EVENT_CONTEXT         =3D 3,
>> >>         BT_EVENT_CONTEXT                =3D 4,
>> >>         BT_EVENT_FIELDS                 =3D 5,
>> >>
>> >> I could not figure out the way to ready the fields 'id' and
>> >> 'stream_id', for a particular event while iterating through the trace.
>> >> Though I can ready the event name using an API and fields using
>> >> BT_EVENT_FIELDS as a scope.
>> >> For e.g. consider the
>> >>
>> >> event {
>> >>         name =3D sched_migrate_task;
>> >>         id =3D 1;
>> >>         stream_id =3D 0;
>> >>         fields :=3D struct {
>> >>                 integer { size =3D 8; align =3D 8; signed =3D 1; enco=
ding =3D
>> >>                 UTF8; base =3D 10; } _comm[16];
>> >>                 integer { size =3D 32; align =3D 8; signed =3D 1; enc=
oding =3D
>> >>                 none; base =3D 10; } _tid;
>> >>                 integer { size =3D 32; align =3D 8; signed =3D 1; enc=
oding =3D
>> >>                 none; base =3D 10; } _prio;
>> >>                 integer { size =3D 32; align =3D 8; signed =3D 1; enc=
oding =3D
>> >>                 none; base =3D 10; } _orig_cpu;
>> >>                 integer { size =3D 32; align =3D 8; signed =3D 1; enc=
oding =3D
>> >>                 none; base =3D 10; } _dest_cpu;
>> >>         };
>> >> };
>> >>
>> >
>> > The "id" field is part of the BT_STREAM_EVENT_HEADER scope, while
>> > the "stream_id" field is part of the BT_TRACE_PACKET_HEADER scope.
>> >
>> > The code below is adapted from converter/babeltrace.c's
>> > convert_trace() loop to print both values.
>> >
>> > while ((ctf_event =3D bt_ctf_iter_read_event(iter))) {
>> >
>> >         const struct bt_definition *stream_event_header_scope =3D
>> >                 bt_ctf_get_top_level_scope(
>> >                         ctf_event, BT_STREAM_EVENT_HEADER);
>> >         const struct bt_definition *id_field =3D
>> >                 bt_ctf_get_field(
>> >                         ctf_event, stream_event_header_scope,
>> > "id");
>> >
>> >         printf("id =3D %" PRIu64 "\n", bt_ctf_get_uint64(id_field));
>> >
>> >         const struct bt_definition *packet_header_scope =3D
>> >                 bt_ctf_get_top_level_scope(
>> >                         ctf_event, BT_TRACE_PACKET_HEADER);
>> >         const struct bt_definition *stream_id_field =3D
>> >                 bt_ctf_get_field(
>> >                         ctf_event, packet_header_scope,
>> > "stream_id");
>> >
>> >         printf("stream_id =3D %" PRIu64 "\n", bt_ctf_get_uint64(
>> >                        stream_id_field)); [...] }
>> >
>> > Regards,
>> > J=E9r=E9mie
>> >
>> >>
>> >> Any help or suggestion related to this issue will be really appreciat=
ed.
>> >> Thanks!
>> >>
>> >> Regards,
>> >> Salman
>> >>
>> >> --
>> >> Salman Rafiq
>> >> Gesch=E4ftsfeld Industrial Communication Fraunhofer-Institut  f=FCr
>> >> Eingebettete Systeme und Kommunikationstechnik ESK
>> >>
>> >> Hansastra=DFe 32 | 80686 M=FCnchen
>> >> Telefon, Fax:  +49 89 547088-356 | +49 89 547088-221
>> >> E-Mail:   salman.rafiq@esk.fraunhofer.de
>> >>
>> >> Internet:
>> >> http://www.esk.fraunhofer.de
>> >> http://www.twitter.com/FraunhoferESK
>> >>
>> >
>> >
>> >
>> > --
>> > J=E9r=E9mie Galarneau
>> > EfficiOS Inc.
>> > http://www.efficios.com
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



--
J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
