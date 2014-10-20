From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Re: Best way to analyze CTF files
Date: Mon, 20 Oct 2014 15:48:41 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286AE83__11860.0407535725$1413820188$gmane$org@PAYTON.anl.gov>
References: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>,
 <CAF1eGnSoWSxZjKVuOBLdHcXVKVW+nCFA+nbDAqTwv1kUhOz1UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1XgFCS-0004ZR-Cv
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 11:48:52 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id 019AE7CC169
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 10:48:43 -0500 (CDT)
In-Reply-To: <CAF1eGnSoWSxZjKVuOBLdHcXVKVW+nCFA+nbDAqTwv1kUhOz1UA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eugene Ivanov <eiva@tbricks.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> From: Eugene Ivanov [eiva@tbricks.com]
> Sent: Monday, October 20, 2014 6:01 AM
> To: Boisvert, Sebastien
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Best way to analyze CTF files
> =

> =

> =

> Hi Sebastian,

*Sebastien* or *S=E9bastien*

> =

> In our company one of the main lttng applications is to measure latency b=
etween two probes which get same ID as argument.

We do the same thing with LTTng (our ID is called message_number, and every=
 actor message carries one):

> For this purpose we've implemented in C a special utility which is based =
on libraries to read CTF (IIRC). Also some developers often
>  use own simple perl scripts to analyze babeltrace output.

In our system, messages are sent by actors (like Erlang processes, but in C=
 1999 for throughput).

We ended up using LTTng's powerful real-time filtering engine to filter onl=
y messages
for a single actor:

lttng enable-event --userspace thorium_message:* --filter "message_source_a=
ctor =3D=3D 1001563"


Then we are simply just looking at individual messages (LTTng provides us w=
ith the delivery path of
every actor message for the selected actor):

[boisvert@bigmem biosal]$ cat trace.txt | grep "message_number =3D 99,"|awk=
 '{print $4" "$2}'
thorium_message:actor_send: (+0.003747706)
thorium_message:worker_send: (+0.000001442)
thorium_message:worker_enqueue_message: (+0.000001257)
thorium_message:worker_publish_message: (+0.000000976)
thorium_message:worker_pool_dequeue: (+0.003363601)
thorium_message:node_send: (+0.000001483)
thorium_message:node_send_system: (+0.000001349)
thorium_message:transport_send: (+0.000001040)
thorium_message:node_receive: (+0.000073889)
thorium_message:node_dispatch_message: (+0.000001891)
thorium_message:worker_pool_enqueue: (+0.000001696)
thorium_message:worker_receive: (+0.000001774)
thorium_message:actor_receive: (+0.000002841)


> I wish there is a better way to implement custom CTF analyzers, probably =
some basic DSL.

I think that an approach that would be efficient would be to just import ev=
erything in
sqlite. Otherwise, I think that filtering is good since it does generates f=
iles that are too large.

Without filtering, our HPC app (supercomputing, not cloud) generates ~30 Gi=
B worth of
LTTng CTF data in 2 minutes with only 4 Thorium nodes (~ 30 x86-64 cores).
In production, we are using
~6000 x86 cores on a Cray XE6 for ~20 minutes and ~30000 POWER cores (A2) f=
or ~=A020 minutes.
So LTTng's builtin filter is really our only option IMO.

> =

> =

> =

> On Sat, Oct 18, 2014 at 2:23 AM, Boisvert, Sebastien =

> <boisvert@anl.gov> wrote:
> =

> Bonjour,
> =

> First, thank you for LTTng-UST. This is very useful and convenient.
> =

> I just got started today using LTTng (LTTng-UST) for tracing a HPC applic=
ation
> that I am working on (I am a postdoc). I am impressed by how easy LTTng i=
s to use it.
> =

> In my system, an actor message is represented by a pair
> <message_actor_source, message_number>.
> =

> I want to list all messages that have a high delivery time (message:actor=
_receive - message:actor_send).
> =

> I am doing this to get the messages of one actor (actor 1000019):
> =

> [boisvert@bigmem biosal]$ babeltrace ~/lttng-traces/auto-20141017-181240|=
grep "message_source_actor =3D 1000019"  > actor_1000019
> =

> Then, I can look at one message with (message <1000019, 14>):
> =

> [boisvert@bigmem biosal]$ grep "message_number =3D 14," actor_1000019
> [18:12:43.647017211] (+0.000005110) =

> bigmem.knoxville.kbase.us message:actor_send: { cpu_id =3D 30 }, { messag=
e_number =3D 14, message_action =3D 31592, message_count =3D 8, message_sou=
rce_actor =3D 1000019, message_destination_actor =3D 1000059, message_sourc=
e_node =3D -1, message_destination_node =3D -1
>  }
> [18:12:43.647025249] (+0.000002860) =

> bigmem.knoxville.kbase.us message:actor_receive: { cpu_id =3D 49 }, { mes=
sage_number =3D 14, message_action =3D 31592, message_count =3D 8, message_=
source_actor =3D 1000019, message_destination_actor =3D 1000059, message_so=
urce_node =3D 3, message_destination_node =3D
>  3 }
> =

> If I substract the times:
> =

> irb(main):003:0> (43.647025249-43.647017211)*10**9
> =3D> 8038.00000426236
> =

> This message (<1000019, 14>) required 8038 ns for the delivery. This one =
is fine.
> =

> =

> So basically my question is:
> =

> Is there an easy way to analyze these tracepoint files ?
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =

> =

> =

> =

> -- =

> Eugene
> =

> =
