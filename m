From: Eugene Ivanov <eiva@tbricks.com>
Subject: Re: Best way to analyze CTF files
Date: Mon, 20 Oct 2014 15:01:40 +0400
Message-ID: <CAF1eGnSoWSxZjKVuOBLdHcXVKVW+nCFA+nbDAqTwv1kUhOz1UA__27279.2154727087$1413802963$gmane$org@mail.gmail.com>
References: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0210034623=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eiva@tbricks.com>) id 1XgAig-00033Z-6h
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 07:01:49 -0400
Received: by mail-qa0-f50.google.com with SMTP id w8so3074186qac.23
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 04:01:40 -0700 (PDT)
In-Reply-To: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>
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

--===============0210034623==
Content-Type: multipart/alternative; boundary=001a11352550abe1270505d8a39d

--001a11352550abe1270505d8a39d
Content-Type: text/plain; charset=UTF-8

Hi Sebastian,

In our company one of the main lttng applications is to measure latency
between two probes which get same ID as argument. For this purpose we've
implemented in C a special utility which is based on libraries to read CTF
(IIRC). Also some developers often use own simple perl scripts to analyze
babeltrace output.
I wish there is a better way to implement custom CTF analyzers, probably
some basic DSL.


On Sat, Oct 18, 2014 at 2:23 AM, Boisvert, Sebastien <boisvert@anl.gov>
wrote:

> Bonjour,
>
> First, thank you for LTTng-UST. This is very useful and convenient.
>
> I just got started today using LTTng (LTTng-UST) for tracing a HPC
> application
> that I am working on (I am a postdoc). I am impressed by how easy LTTng is
> to use it.
>
> In my system, an actor message is represented by a pair
> <message_actor_source, message_number>.
>
> I want to list all messages that have a high delivery time
> (message:actor_receive - message:actor_send).
>
> I am doing this to get the messages of one actor (actor 1000019):
>
> [boisvert@bigmem biosal]$ babeltrace
> ~/lttng-traces/auto-20141017-181240|grep "message_source_actor = 1000019"
> > actor_1000019
>
> Then, I can look at one message with (message <1000019, 14>):
>
> [boisvert@bigmem biosal]$ grep "message_number = 14," actor_1000019
> [18:12:43.647017211] (+0.000005110) bigmem.knoxville.kbase.us
> message:actor_send: { cpu_id = 30 }, { message_number = 14, message_action
> = 31592, message_count = 8, message_source_actor = 1000019,
> message_destination_actor = 1000059, message_source_node = -1,
> message_destination_node = -1 }
> [18:12:43.647025249] (+0.000002860) bigmem.knoxville.kbase.us
> message:actor_receive: { cpu_id = 49 }, { message_number = 14,
> message_action = 31592, message_count = 8, message_source_actor = 1000019,
> message_destination_actor = 1000059, message_source_node = 3,
> message_destination_node = 3 }
>
> If I substract the times:
>
> irb(main):003:0> (43.647025249-43.647017211)*10**9
> => 8038.00000426236
>
> This message (<1000019, 14>) required 8038 ns for the delivery. This one
> is fine.
>
>
> So basically my question is:
>
> Is there an easy way to analyze these tracepoint files ?
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Eugene

--001a11352550abe1270505d8a39d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sebastian,<div><br></div><div>In our company one of the=
 main lttng applications is to measure latency between two probes which get=
 same ID as argument. For this purpose we&#39;ve implemented in C a special=
 utility which is based on libraries to read CTF (IIRC). Also some develope=
rs often use own simple perl scripts to analyze babeltrace output.</div><di=
v>I wish there is a better way to implement custom CTF analyzers, probably =
some basic DSL.</div><div><br></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Sat, Oct 18, 2014 at 2:23 AM, Boisvert, Sebasti=
en <span dir=3D"ltr">&lt;<a href=3D"mailto:boisvert@anl.gov" target=3D"_bla=
nk">boisvert@anl.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">Bonjour,<br>
<br>
First, thank you for LTTng-UST. This is very useful and convenient.<br>
<br>
I just got started today using LTTng (LTTng-UST) for tracing a HPC applicat=
ion<br>
that I am working on (I am a postdoc). I am impressed by how easy LTTng is =
to use it.<br>
<br>
In my system, an actor message is represented by a pair<br>
&lt;message_actor_source, message_number&gt;.<br>
<br>
I want to list all messages that have a high delivery time (message:actor_r=
eceive - message:actor_send).<br>
<br>
I am doing this to get the messages of one actor (actor 1000019):<br>
<br>
[boisvert@bigmem biosal]$ babeltrace ~/lttng-traces/auto-20141017-181240|gr=
ep &quot;message_source_actor =3D 1000019&quot;=C2=A0 &gt; actor_1000019<br=
>
<br>
Then, I can look at one message with (message &lt;1000019, 14&gt;):<br>
<br>
[boisvert@bigmem biosal]$ grep &quot;message_number =3D 14,&quot; actor_100=
0019<br>
[18:12:43.647017211] (+0.000005110) <a href=3D"http://bigmem.knoxville.kbas=
e.us" target=3D"_blank">bigmem.knoxville.kbase.us</a> message:actor_send: {=
 cpu_id =3D 30 }, { message_number =3D 14, message_action =3D 31592, messag=
e_count =3D 8, message_source_actor =3D 1000019, message_destination_actor =
=3D 1000059, message_source_node =3D -1, message_destination_node =3D -1 }<=
br>
[18:12:43.647025249] (+0.000002860) <a href=3D"http://bigmem.knoxville.kbas=
e.us" target=3D"_blank">bigmem.knoxville.kbase.us</a> message:actor_receive=
: { cpu_id =3D 49 }, { message_number =3D 14, message_action =3D 31592, mes=
sage_count =3D 8, message_source_actor =3D 1000019, message_destination_act=
or =3D 1000059, message_source_node =3D 3, message_destination_node =3D 3 }=
<br>
<br>
If I substract the times:<br>
<br>
irb(main):003:0&gt; (43.647025249-43.647017211)*10**9<br>
=3D&gt; 8038.00000426236<br>
<br>
This message (&lt;1000019, 14&gt;) required 8038 ns for the delivery. This =
one is fine.<br>
<br>
<br>
So basically my question is:<br>
<br>
Is there an easy way to analyze these tracepoint files ?<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Eugene</div>
</div>

--001a11352550abe1270505d8a39d--


--===============0210034623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0210034623==--
