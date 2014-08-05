From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?=
	<jeremie.galarneau@efficios.com>
Subject: Re: [lttng-dev] [RFC] perf to ctf converter
Date: Tue, 5 Aug 2014 10:51:49 -0400
Message-ID: <CA+jJMxum9jFVZ9NN+FkHHQhwULDSCkxa=vbRpHZ-Es-ni57ffQ@mail.gmail.com>
References: <20140603163640.GA16279@linutronix.de>
	<20140714141533.GD17761@krava.redhat.com>
	<53C9143C.1060905@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53C9143C.1060905@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jiri Olsa <jolsa@redhat.com>, namhyung.kim@lge.com, linux-kernel@vger.kernel.org, acme@kernel.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On Fri, Jul 18, 2014 at 8:34 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 07/14/2014 04:15 PM, Jiri Olsa wrote:
>>> for more data while reading the "events" traces. The latter will be
>>> probably replaced by https://lkml.org/lkml/2014/4/3/217.
>>> Babeltrace needs only
>>>     "ctf-writer: Add support for the cpu_id field"
>>>     https://www.mail-archive.com/lttng-dev@lists.lttng.org/msg06057=
=2Ehtml
>>
>> any idea when this one will land in babeltrace git tree?
>
> Need to re-do them the way they asked. Could take some time. However =
I
> wanted first to make sure it make sense to continue that approach.
>

=46YI, I have made the changes and they are now upstream in Babeltrace =
as of

commit 12c8a1a3121ed7125e8758065c44658d8eda1333
Author: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Tue Jul 29 16:51:51 2014 -0400

    Add stream packet header accessors

    Stream packet contexts may now be modified to contain custom
    fields. The events_discarded field is now handled like a generic
    packet context field.

    Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@effic=
ios.com>


Regards,
J=C3=A9r=C3=A9mie

>>>
>>> for the assignment of the CPU number.
>>>
>>> The pickle step is nice because I see all type of events before I
>>> start writing the CTF trace and can create the necessary objects. O=
n
>>> the other hand it eats a lot of memory for huge traces so I will tr=
y to
>>> replace it with something that saves the data in a streaming like
>>> fashion.
>>> The other limitation is that babeltrace doesn't seem to work with
>>> python2 while perf doesn't compile against python3.
>>>
>>> What I haven't figured out yet is how to pass to the meta environme=
nt
>>> informations that is displayed by "perf script --header-only -I" an=
d if
>>> that information is really important. Probably an optional python
>>> callback will do it.
>>>
>>> The required steps:
>>> |   perf record -e raw_syscalls:* w
>>> |   perf script -s ./to-pickle.py
>>> |   ./ctf_writer
>>
>> I made similar effort in C:
>>
>> ---
>> I made some *VERY* early perf convert example, mostly to try the ctf=
-writer
>> interface.. you can check in here:
>>   https://git.kernel.org/cgit/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dperf/ctf_2
>
> Let me try it, maybe I can migrate my effort into one code basis.
>
>> It's able to convert single event (HW type) perf.data file into CTF =
data,
>> by adding just one integer field "period" and single stream, like:
>>
>>   [jolsa@krava perf]$ LD_LIBRARY_PATH=3D/opt/libbabeltrace/lib/ ./pe=
rf data convert --to-ctf=3D./ctf-data
>>   ...
>>   [jolsa@krava babeltrace]$ /opt/libbabeltrace/bin/babeltrace /home/=
jolsa/kernel.org/linux-perf/tools/perf/ctf-data
>>   [08:14:45.814456098] (+?.?????????) cycles: { }, { period =3D 1 }
>>   [08:14:45.814459237] (+0.000003139) cycles: { }, { period =3D 1 }
>>   [08:14:45.814460684] (+0.000001447) cycles: { }, { period =3D 9 }
>>   [08:14:45.814462073] (+0.000001389) cycles: { }, { period =3D 182 =
}
>>   [08:14:45.814463491] (+0.000001418) cycles: { }, { period =3D 4263=
 }
>>   [08:14:45.814465874] (+0.000002383) cycles: { }, { period =3D 9787=
8 }
>>   [08:14:45.814506385] (+0.000040511) cycles: { }, { period =3D 1365=
965 }
>>   [08:14:45.815056528] (+0.000550143) cycles: { }, { period =3D 2250=
012 }
>> ---
>>
>> the goals for me is to have a convert tool, like in above example
>> perf data command and support in perf record/report to directl
>> write/read ctf data
>>
>> Using python for this seems nice.. I'm not experienced python coder,
>> so just small comments/questions
>
> python looked nice because I saw libraries / interfaces on both sides=
=2E
>
>> SNIP
>>
>>> +list_type_h_uint64 =3D [ "addr" ]
>>> +
>>> +int32_type =3D CTFWriter.IntegerFieldDeclaration(32)
>>> +int32_type.signed =3D True
>>> +
>>> +uint64_type =3D CTFWriter.IntegerFieldDeclaration(64)
>>> +uint64_type.signed =3D False
>>> +
>>> +hex_uint64_type =3D CTFWriter.IntegerFieldDeclaration(64)
>>> +hex_uint64_type.signed =3D False
>>> +hex_uint64_type.base =3D 16
>>> +
>>> +string_type =3D CTFWriter.StringFieldDeclaration()
>>> +
>>> +events =3D {}
>>> +last_cpu =3D -1
>>> +
>>> +list_ev_entry_ignore =3D [ "common_s", "common_ns", "common_cpu" ]
>>> +
>>> +# First create all possible event class-es
>>
>> this first iteration could be handled in the to-pickle step,
>> which could gather events description and store/pickle it
>> before the trace data
>
> yes.
>
>>> +for entry in trace:
>>> +    event_name =3D entry[0]
>>> +    event_record =3D entry[1]
>>> +
>>> +    try:
>>> +        event_class =3D events[event_name]
>>> +    except:
>>> +        event_class =3D CTFWriter.EventClass(event_name);
>>> +        for ev_entry in sorted(event_record):
>>> +            if ev_entry in list_ev_entry_ignore:
>>> +                continue
>>> +            val =3D event_record[ev_entry]
>>> +            if isinstance(val, int):
>>> +                if ev_entry in list_type_h_uint64:
>>> +                    event_class.add_field(hex_uint64_type, ev_entr=
y)
>>> +                else:
>>> +                    event_class.add_field(int32_type, ev_entry)
>>> +            elif isinstance(val, str):
>>> +                event_class.add_field(string_type, ev_entry)
>>
>>
>> SNIP
>>
>>> +
>>> +def process_event(event_fields_dict):
>>> +    entry =3D []
>>> +    entry.append(str(event_fields_dict["ev_name"]))
>>> +    fields =3D {}
>>> +    fields["common_s"] =3D event_fields_dict["s"]
>>> +    fields["common_ns"] =3D event_fields_dict["ns"]
>>> +    fields["common_comm"] =3D event_fields_dict["comm"]
>>> +    fields["common_pid"] =3D event_fields_dict["pid"]
>>> +    fields["addr"] =3D event_fields_dict["addr"]
>>> +
>>> +    dso =3D ""
>>> +    symbol =3D ""
>>> +    try:
>>> +        dso =3D event_fields_dict["dso"]
>>> +    except:
>>> +        pass
>>> +    try:
>>> +        symbol =3D event_fields_dict["symbol"]
>>> +    except:
>>> +        pass
>>
>> I understand this is just a early stage, but we want here
>> detection of the all event arguments, right?
>
> Yes. The CTF writer is stupid and takes all arguments as-is and passe=
s
> it over the babeltrace part of CTF writer. This works well for the
> ftrace events (handled by trace_unhandled()).
>
>
>> I wonder we could add separated python callback for that
>
> This (the to pickle part) tries come up with the common basis for the
> CPU events. Therefore it renames the first few arguments (like s to
> common_s) to make it consistent with the ftrace events.
> The dso and symbol members look optional depending whether or not thi=
s
> data was available at trace time. I *think* those may change within a
> stream say if one library has debug symbols available and the other
> does not. So I have no idea how you plan specific callbacks for those=
=2E
>
>> thanks,
>> jirka
>
> Sebastian
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
