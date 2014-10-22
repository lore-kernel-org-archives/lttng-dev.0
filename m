From: Eugene Ivanov <eiva@tbricks.com>
Subject: Re: Best way to analyze CTF files
Date: Wed, 22 Oct 2014 15:27:48 +0400
Message-ID: <CAF1eGnQJGndWm+MW77rsq9b562JhMULURnQyztDE-h-GXUYckw__13667.9897936576$1413977318$gmane$org@mail.gmail.com>
References: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>
 <CAF1eGnSoWSxZjKVuOBLdHcXVKVW+nCFA+nbDAqTwv1kUhOz1UA@mail.gmail.com>
 <E949C1E351B4914B87A26A5F96E06A9286AE83@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1686726049=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eiva@tbricks.com>) id 1Xgu54-0002AP-QV
 for lttng-dev@lists.lttng.org; Wed, 22 Oct 2014 07:27:58 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so2374946qgd.29
 for <lttng-dev@lists.lttng.org>; Wed, 22 Oct 2014 04:27:49 -0700 (PDT)
In-Reply-To: <E949C1E351B4914B87A26A5F96E06A9286AE83@PAYTON.anl.gov>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Boisvert, Sebastien" <boisvert@anl.gov>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1686726049==
Content-Type: multipart/alternative; boundary=001a11c3c12ed2914d0506013c35

--001a11c3c12ed2914d0506013c35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2014 at 7:48 PM, Boisvert, Sebastien <boisvert@anl.gov>
wrote:

> > From: Eugene Ivanov [eiva@tbricks.com]
> > Sent: Monday, October 20, 2014 6:01 AM
> > To: Boisvert, Sebastien
> > Cc: lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] Best way to analyze CTF files
> >
> >
> >
> > Hi Sebastian,
>
> *Sebastien* or *S=C3=A9bastien*
>

Oops, I'm sorry, Sebastien.


> >
> > In our company one of the main lttng applications is to measure latency
> between two probes which get same ID as argument.
>
> We do the same thing with LTTng (our ID is called message_number, and
> every actor message carries one):
>
> > For this purpose we've implemented in C a special utility which is base=
d
> on libraries to read CTF (IIRC). Also some developers often
> >  use own simple perl scripts to analyze babeltrace output.
>
> In our system, messages are sent by actors (like Erlang processes, but in
> C 1999 for throughput).
>
> We ended up using LTTng's powerful real-time filtering engine to filter
> only messages
> for a single actor:
>
> lttng enable-event --userspace thorium_message:* --filter
> "message_source_actor =3D=3D 1001563"
>
>
> Then we are simply just looking at individual messages (LTTng provides us
> with the delivery path of
> every actor message for the selected actor):
>
> [boisvert@bigmem biosal]$ cat trace.txt | grep "message_number =3D 99,"|a=
wk
> '{print $4" "$2}'
> thorium_message:actor_send: (+0.003747706)
> thorium_message:worker_send: (+0.000001442)
> thorium_message:worker_enqueue_message: (+0.000001257)
> thorium_message:worker_publish_message: (+0.000000976)
> thorium_message:worker_pool_dequeue: (+0.003363601)
> thorium_message:node_send: (+0.000001483)
> thorium_message:node_send_system: (+0.000001349)
> thorium_message:transport_send: (+0.000001040)
> thorium_message:node_receive: (+0.000073889)
> thorium_message:node_dispatch_message: (+0.000001891)
> thorium_message:worker_pool_enqueue: (+0.000001696)
> thorium_message:worker_receive: (+0.000001774)
> thorium_message:actor_receive: (+0.000002841)
>
>
> > I wish there is a better way to implement custom CTF analyzers, probabl=
y
> some basic DSL.
>
> I think that an approach that would be efficient would be to just import
> everything in
> sqlite. Otherwise, I think that filtering is good since it does generates
> files that are too large.
>
> Without filtering, our HPC app (supercomputing, not cloud) generates ~30
> GiB worth of
> LTTng CTF data in 2 minutes with only 4 Thorium nodes (~ 30 x86-64 cores)=
.
> In production, we are using
> ~6000 x86 cores on a Cray XE6 for ~20 minutes and ~30000 POWER cores (A2)
> for ~ 20 minutes.
> So LTTng's builtin filter is really our only option IMO.
>

I see.


> >
> >
> >
> > On Sat, Oct 18, 2014 at 2:23 AM, Boisvert, Sebastien
> > <boisvert@anl.gov> wrote:
> >
> > Bonjour,
> >
> > First, thank you for LTTng-UST. This is very useful and convenient.
> >
> > I just got started today using LTTng (LTTng-UST) for tracing a HPC
> application
> > that I am working on (I am a postdoc). I am impressed by how easy LTTng
> is to use it.
> >
> > In my system, an actor message is represented by a pair
> > <message_actor_source, message_number>.
> >
> > I want to list all messages that have a high delivery time
> (message:actor_receive - message:actor_send).
> >
> > I am doing this to get the messages of one actor (actor 1000019):
> >
> > [boisvert@bigmem biosal]$ babeltrace
> ~/lttng-traces/auto-20141017-181240|grep "message_source_actor =3D 100001=
9"
> > actor_1000019
> >
> > Then, I can look at one message with (message <1000019, 14>):
> >
> > [boisvert@bigmem biosal]$ grep "message_number =3D 14," actor_1000019
> > [18:12:43.647017211] (+0.000005110)
> > bigmem.knoxville.kbase.us message:actor_send: { cpu_id =3D 30 }, {
> message_number =3D 14, message_action =3D 31592, message_count =3D 8,
> message_source_actor =3D 1000019, message_destination_actor =3D 1000059,
> message_source_node =3D -1, message_destination_node =3D -1
> >  }
> > [18:12:43.647025249] (+0.000002860)
> > bigmem.knoxville.kbase.us message:actor_receive: { cpu_id =3D 49 }, {
> message_number =3D 14, message_action =3D 31592, message_count =3D 8,
> message_source_actor =3D 1000019, message_destination_actor =3D 1000059,
> message_source_node =3D 3, message_destination_node =3D
> >  3 }
> >
> > If I substract the times:
> >
> > irb(main):003:0> (43.647025249-43.647017211)*10**9
> > =3D> 8038.00000426236
> >
> > This message (<1000019, 14>) required 8038 ns for the delivery. This on=
e
> is fine.
> >
> >
> > So basically my question is:
> >
> > Is there an easy way to analyze these tracepoint files ?
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> >
> >
> > --
> > Eugene
> >
> >
>



--=20
Eugene

--001a11c3c12ed2914d0506013c35
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Oct 20, 2014 at 7:48 PM, Boisvert, Sebastien <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:boisvert@anl.gov" target=3D"_blank">boisvert@anl.gov</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">&gt; From: Eugene Ivanov [<a href=3D"mail=
to:eiva@tbricks.com">eiva@tbricks.com</a>]<br>
&gt; Sent: Monday, October 20, 2014 6:01 AM<br>
&gt; To: Boisvert, Sebastien<br>
&gt; Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a><br>
&gt; Subject: Re: [lttng-dev] Best way to analyze CTF files<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Sebastian,<br>
<br>
*Sebastien* or *S=C3=A9bastien*<br></blockquote><div><br></div><div>Oops, I=
&#39;m sorry,=C2=A0Sebastien.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
&gt;<br>
&gt; In our company one of the main lttng applications is to measure latenc=
y between two probes which get same ID as argument.<br>
<br>
We do the same thing with LTTng (our ID is called message_number, and every=
 actor message carries one):<br>
<br>
&gt; For this purpose we&#39;ve implemented in C a special utility which is=
 based on libraries to read CTF (IIRC). Also some developers often<br>
&gt;=C2=A0 use own simple perl scripts to analyze babeltrace output.<br>
<br>
In our system, messages are sent by actors (like Erlang processes, but in C=
 1999 for throughput).<br>
<br>
We ended up using LTTng&#39;s powerful real-time filtering engine to filter=
 only messages<br>
for a single actor:<br>
<br>
lttng enable-event --userspace thorium_message:* --filter &quot;message_sou=
rce_actor =3D=3D 1001563&quot;<br>
<br>
<br>
Then we are simply just looking at individual messages (LTTng provides us w=
ith the delivery path of<br>
every actor message for the selected actor):<br>
<br>
[boisvert@bigmem biosal]$ cat trace.txt | grep &quot;message_number =3D 99,=
&quot;|awk &#39;{print $4&quot; &quot;$2}&#39;<br>
thorium_message:actor_send: (+0.003747706)<br>
thorium_message:worker_send: (+0.000001442)<br>
thorium_message:worker_enqueue_message: (+0.000001257)<br>
thorium_message:worker_publish_message: (+0.000000976)<br>
thorium_message:worker_pool_dequeue: (+0.003363601)<br>
thorium_message:node_send: (+0.000001483)<br>
thorium_message:node_send_system: (+0.000001349)<br>
thorium_message:transport_send: (+0.000001040)<br>
thorium_message:node_receive: (+0.000073889)<br>
thorium_message:node_dispatch_message: (+0.000001891)<br>
thorium_message:worker_pool_enqueue: (+0.000001696)<br>
thorium_message:worker_receive: (+0.000001774)<br>
thorium_message:actor_receive: (+0.000002841)<br>
<br>
<br>
&gt; I wish there is a better way to implement custom CTF analyzers, probab=
ly some basic DSL.<br>
<br>
I think that an approach that would be efficient would be to just import ev=
erything in<br>
sqlite. Otherwise, I think that filtering is good since it does generates f=
iles that are too large.<br>
<br>
Without filtering, our HPC app (supercomputing, not cloud) generates ~30 Gi=
B worth of<br>
LTTng CTF data in 2 minutes with only 4 Thorium nodes (~ 30 x86-64 cores).<=
br>
In production, we are using<br>
~6000 x86 cores on a Cray XE6 for ~20 minutes and ~30000 POWER cores (A2) f=
or ~=C2=A020 minutes.<br>
So LTTng&#39;s builtin filter is really our only option IMO.<br></blockquot=
e><div><br></div><div>I see.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Sat, Oct 18, 2014 at 2:23 AM, Boisvert, Sebastien<br>
&gt; &lt;<a href=3D"mailto:boisvert@anl.gov">boisvert@anl.gov</a>&gt; wrote=
:<br>
&gt;<br>
&gt; Bonjour,<br>
&gt;<br>
&gt; First, thank you for LTTng-UST. This is very useful and convenient.<br=
>
&gt;<br>
&gt; I just got started today using LTTng (LTTng-UST) for tracing a HPC app=
lication<br>
&gt; that I am working on (I am a postdoc). I am impressed by how easy LTTn=
g is to use it.<br>
&gt;<br>
&gt; In my system, an actor message is represented by a pair<br>
&gt; &lt;message_actor_source, message_number&gt;.<br>
&gt;<br>
&gt; I want to list all messages that have a high delivery time (message:ac=
tor_receive - message:actor_send).<br>
&gt;<br>
&gt; I am doing this to get the messages of one actor (actor 1000019):<br>
&gt;<br>
&gt; [boisvert@bigmem biosal]$ babeltrace ~/lttng-traces/auto-20141017-1812=
40|grep &quot;message_source_actor =3D 1000019&quot;=C2=A0 &gt; actor_10000=
19<br>
&gt;<br>
&gt; Then, I can look at one message with (message &lt;1000019, 14&gt;):<br=
>
&gt;<br>
&gt; [boisvert@bigmem biosal]$ grep &quot;message_number =3D 14,&quot; acto=
r_1000019<br>
&gt; [18:12:43.647017211] (+0.000005110)<br>
&gt; <a href=3D"http://bigmem.knoxville.kbase.us" target=3D"_blank">bigmem.=
knoxville.kbase.us</a> message:actor_send: { cpu_id =3D 30 }, { message_num=
ber =3D 14, message_action =3D 31592, message_count =3D 8, message_source_a=
ctor =3D 1000019, message_destination_actor =3D 1000059, message_source_nod=
e =3D -1, message_destination_node =3D -1<br>
&gt;=C2=A0 }<br>
&gt; [18:12:43.647025249] (+0.000002860)<br>
&gt; <a href=3D"http://bigmem.knoxville.kbase.us" target=3D"_blank">bigmem.=
knoxville.kbase.us</a> message:actor_receive: { cpu_id =3D 49 }, { message_=
number =3D 14, message_action =3D 31592, message_count =3D 8, message_sourc=
e_actor =3D 1000019, message_destination_actor =3D 1000059, message_source_=
node =3D 3, message_destination_node =3D<br>
&gt;=C2=A0 3 }<br>
&gt;<br>
&gt; If I substract the times:<br>
&gt;<br>
&gt; irb(main):003:0&gt; (43.647025249-43.647017211)*10**9<br>
&gt; =3D&gt; 8038.00000426236<br>
&gt;<br>
&gt; This message (&lt;1000019, 14&gt;) required 8038 ns for the delivery. =
This one is fine.<br>
&gt;<br>
&gt;<br>
&gt; So basically my question is:<br>
&gt;<br>
&gt; Is there an easy way to analyze these tracepoint files ?<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
<span class=3D""><font color=3D"#888888">&gt;<br>
&gt; --<br>
&gt; Eugene<br>
&gt;<br>
&gt;<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr">Eugene</div>
</div></div>

--001a11c3c12ed2914d0506013c35--


--===============1686726049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1686726049==--
