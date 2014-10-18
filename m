From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Re: Best way to analyze CTF files
Date: Sat, 18 Oct 2014 15:18:38 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286AC83__47711.1684544527$1413645565$gmane$org@PAYTON.anl.gov>
References: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>
 <CAGDH53kBntaqFvMe=LAQ9OG5Y0yx9JRHhbLhLZiaNhWCn4yVWg@mail.gmail.com>,
 <CAB4xu_0CHASSN7qNb0qpUzQ7PSuh2B-EapiWySNePrHmf3VAVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XfVmG-0006bD-9Z
 for lttng-dev@lists.lttng.org; Sat, 18 Oct 2014 11:18:46 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id CC2F27CC3B7
 for <lttng-dev@lists.lttng.org>; Sat, 18 Oct 2014 10:18:38 -0500 (CDT)
In-Reply-To: <CAB4xu_0CHASSN7qNb0qpUzQ7PSuh2B-EapiWySNePrHmf3VAVA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>, Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Philippe,

Thanks for the detailed Python code.

In my application, I know that something is wrong with the message delivery=
 path =

for specific actors. But I need to know more.

I looked carefully at the LTTng documentation and I found what I needed.
There is a --filter option which carefully selects events, and
reduces the amount of recorded events.


Thanks to LTTng, I am closer to solving this problem:

One message with the same source node and destination node:

[boisvert@bigmem biosal]$ babeltrace  ~/lttng-traces/auto-20141018-104939/ =
|grep "message_number =3D 8000," | awk '{print $4" "$2}'|sed 's/: / /g'|sed=
 's/(//g'|sed 's/)//g'
thorium_message:actor_send +0.000010835
thorium_message:worker_send +0.000000876
thorium_message:worker_enqueue_message +0.000001410
thorium_message:worker_dequeue_message +0.003886256   <=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
thorium_message:worker_pool_dequeue +0.000001434
thorium_message:node_send +0.000001438
thorium_message:node_send_system +0.000001006
thorium_message:node_dispatch_message +0.000001231
thorium_message:worker_pool_enqueue +0.000001827
thorium_message:node_send_dispatch +0.000001100
thorium_message:worker_receive +0.000003944
thorium_message:actor_receive +0.000003028

A message sent between nodes:

[boisvert@bigmem biosal]$ babeltrace  ~/lttng-traces/auto-20141018-104939/ =
|grep "message_number =3D 8800," | awk '{print $4" "$2}'|sed 's/: / /g'|sed=
 's/(//g'|sed 's/)//g'
thorium_message:actor_send +0.004115537
thorium_message:worker_send +0.000001402
thorium_message:worker_enqueue_message +0.000001457
thorium_message:worker_dequeue_message +0.004062639   <=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
thorium_message:worker_pool_dequeue +0.000001536
thorium_message:node_send +0.000000934
thorium_message:node_send_system +0.000001185
thorium_message:transport_send +0.000001039
thorium_message:node_receive +0.000061961
thorium_message:node_dispatch_message +0.000001502
thorium_message:worker_pool_enqueue +0.000002299
thorium_message:worker_receive +0.000001632
thorium_message:actor_receive +0.000003461


> ________________________________________
> From: Philippe Proulx [eeppeliteloop@gmail.com]
> Sent: Friday, October 17, 2014 9:15 PM
> To: Christian Babeux
> Cc: Boisvert, Sebastien; lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Best way to analyze CTF files
> On Fri, Oct 17, 2014 at 8:13 PM, Christian Babeux
> <christian.babeux@efficios.com> wrote:
> > Hi Sebastien,
> >
> > A simple Python script using the Babeltrace bindings would probably do
> > the job here. See [1] for an example using the bindings.
> Yes, here's a start S=E9bastien <http://pastebin.com/QXfev1ve>:
> import babeltrace
> import json
> import sys
> =

> def get_msg_intervals(trace_path):
> col =3D babeltrace.TraceCollection()
> if col.add_trace(trace_path, 'ctf') is None:
> raise RuntimeError('Cannot add trace')
> msg_intervals =3D {}
> for ev in col.events:
> if ev.name not in ['message:actor_send', 'message:actor_receive']:
> continue
> msg_source_actor =3D ev['message_source_actor']
> msg_number =3D ev['message_number']
> if msg_source_actor not in msg_intervals:
> msg_intervals[msg_source_actor] =3D {}
> if msg_number not in msg_intervals[msg_source_actor]:
> msg_intervals[msg_source_actor][msg_number] =3D {}
> interval =3D msg_intervals[msg_source_actor][msg_number]
> if ev.name =3D=3D 'message:actor_send':
> interval['send_ts'] =3D ev.timestamp
> else:
> interval['recv_ts'] =3D ev.timestamp
> return msg_intervals
> =

> if __name__ =3D=3D '__main__':
> msg_intervals =3D get_msg_intervals(sys.argv[1])
> print(json.dumps(msg_intervals, indent=3D2))
> This will output a JSON dict mapping actors to message numbers, and then
> each message number to a dict containing both the send and receive timest=
amps:
> python3 intervals.py /path/to/trace > intervals.json
> Once you have that JSON database, you may either read it manually or quer=
y it
> easily using another Python script <http://pastebin.com/fLwyvEz8>:
> import json
> import sys
> =

> def print_msg_diff(filename, actor_id, msg_number):
> def get_diff(msg):
> send_ts =3D msg['send_ts']
> recv_ts =3D msg['recv_ts']
> if send_ts =3D=3D -1 or recv_ts =3D=3D -1:
> return None
> return recv_ts - send_ts
> with open(filename) as f:
> msg_intervals =3D json.load(f)
> actor =3D msg_intervals[actor_id]
> if msg_number is None:
> for msg_number in sorted(actor.keys()):
> msg =3D actor[msg_number]
> print('{}: {}'.format(msg_number, get_diff(msg)))
> else:
> print(get_diff(actor[msg_number]))
> =

> if __name__ =3D=3D '__main__':
> filename =3D sys.argv[1]
> actor_id =3D sys.argv[2]
> msg_number =3D None
> if len(sys.argv) > 3:
> msg_number =3D sys.argv[3]
> print_msg_diff(filename, actor_id, msg_number)
> Use it like this:
> python3 query.py <JSON file path> <actor ID> [<message number>]
> For example:
> python3 query.py intervals.json 1000019
> python3 query.py intervals.json 1000059
> python3 query.py intervals.json 1000019 14
> Modify those scripts at will to fit your exact use case. Of course the ve=
rsions
> above could crash in many ways because they lack a few run time checks, e=
tc.
> Hope it helps,
> Phil
> >
> > Thanks,
> >
> > Christian
> >
> > [1] - https://lttng.org/docs/#doc-viewing-and-analyzing-your-traces
> >
> > On Fri, Oct 17, 2014 at 6:23 PM, Boisvert, Sebastien <boisvert@anl.gov>=
 wrote:
> >> Bonjour,
> >>
> >> First, thank you for LTTng-UST. This is very useful and convenient.
> >>
> >> I just got started today using LTTng (LTTng-UST) for tracing a HPC app=
lication
> >> that I am working on (I am a postdoc). I am impressed by how easy LTTn=
g is to use it.
> >>
> >> In my system, an actor message is represented by a pair
> >> <message_actor_source, message_number>.
> >>
> >> I want to list all messages that have a high delivery time (message:ac=
tor_receive - message:actor_send).
> >>
> >> I am doing this to get the messages of one actor (actor 1000019):
> >>
> >> [boisvert@bigmem biosal]$ babeltrace ~/lttng-traces/auto-20141017-1812=
40|grep "message_source_actor =3D 1000019"  > actor_1000019
> >>
> >> Then, I can look at one message with (message <1000019, 14>):
> >>
> >> [boisvert@bigmem biosal]$ grep "message_number =3D 14," actor_1000019
> >> [18:12:43.647017211] (+0.000005110) bigmem.knoxville.kbase.us message:=
actor_send: { cpu_id =3D 30 }, { message_number =3D 14, message_action =3D =
31592, message_count =3D 8, message_source_actor =3D 1000019, message_desti=
nation_actor =3D 1000059, message_source_node =3D -1, message_destination_n=
ode =3D -1 }
> >> [18:12:43.647025249] (+0.000002860) bigmem.knoxville.kbase.us message:=
actor_receive: { cpu_id =3D 49 }, { message_number =3D 14, message_action =
=3D 31592, message_count =3D 8, message_source_actor =3D 1000019, message_d=
estination_actor =3D 1000059, message_source_node =3D 3, message_destinatio=
n_node =3D 3 }
> >>
> >> If I substract the times:
> >>
> >> irb(main):003:0> (43.647025249-43.647017211)*10**9
> >> =3D> 8038.00000426236
> >>
> >> This message (<1000019, 14>) required 8038 ns for the delivery. This o=
ne is fine.
> >>
> >>
> >> So basically my question is:
> >>
> >> Is there an easy way to analyze these tracepoint files ?
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
