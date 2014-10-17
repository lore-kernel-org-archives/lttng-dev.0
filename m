From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Best way to analyze CTF files
Date: Fri, 17 Oct 2014 19:43:01 -0400
Message-ID: <5441A985.5030505__11469.7926365354$1413589419$gmane$org@voxpopuli.im>
References: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1XfHAc-0001hp-QE
 for lttng-dev@lists.lttng.org; Fri, 17 Oct 2014 19:42:57 -0400
In-Reply-To: <E949C1E351B4914B87A26A5F96E06A9286AC1D@PAYTON.anl.gov>
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

Hi S=E9bastien,

You could always write custom scripts using grep and sed, but those tend =

to be a bit inflexible. ;)

Have you heard about Trace Compass [1] (previously known as TMF, or "The =

Eclipse LTTng plugin") ? It's a generic trace viewer and analyzer based =

on Eclipse, and it supports LTTng traces. It's not officially "out" yet, =

because the project itself is still being set up. We don't have any =

download links on the new website, but in the meantime there are =

relatively recent builds at [2].

There are some default basic views for UST traces, like event list, =

statistics, memory usage if you have the right events enabled, etc. But =

in your case it seems you need something more specific. Depending on =

your level of wanting to dig into it, you could write an "analysis =

module" that would receive each event in the trace, and then check if =

they're of type "actor_receive" or "actor_send", and calculate the delay =

between two consecutive ones. Then aggregate the results and possibly =

print the worst offenders in a view (or even to the console if it's =

sufficient).

See [3] for how to setup the dev environment, and [4] for the analysis =

framework documentation.
Let us know if you need more information!

Cheers,
Alexandre


[1] http://eclipse.org/tracecompass
[2] http://secretaire.dorsal.polymtl.ca/~gbastien/TracingRCP/TraceCompass/
[3] https://wiki.eclipse.org/Trace_Compass/Development_Environment_Setup
[4] =

http://wiki.eclipse.org/Linux_Tools_Project/TMF/User_Guide#Analysis_Framewo=
rk

On 10/17/2014 06:23 PM, Boisvert, Sebastien wrote:
> Bonjour,
>
> First, thank you for LTTng-UST. This is very useful and convenient.
>
> I just got started today using LTTng (LTTng-UST) for tracing a HPC applic=
ation
> that I am working on (I am a postdoc). I am impressed by how easy LTTng i=
s to use it.
>
> In my system, an actor message is represented by a pair
> <message_actor_source, message_number>.
>
> I want to list all messages that have a high delivery time (message:actor=
_receive - message:actor_send).
>
> I am doing this to get the messages of one actor (actor 1000019):
>
> [boisvert@bigmem biosal]$ babeltrace ~/lttng-traces/auto-20141017-181240|=
grep "message_source_actor =3D 1000019"  > actor_1000019
>
> Then, I can look at one message with (message <1000019, 14>):
>
> [boisvert@bigmem biosal]$ grep "message_number =3D 14," actor_1000019
> [18:12:43.647017211] (+0.000005110) bigmem.knoxville.kbase.us message:act=
or_send: { cpu_id =3D 30 }, { message_number =3D 14, message_action =3D 315=
92, message_count =3D 8, message_source_actor =3D 1000019, message_destinat=
ion_actor =3D 1000059, message_source_node =3D -1, message_destination_node=
 =3D -1 }
> [18:12:43.647025249] (+0.000002860) bigmem.knoxville.kbase.us message:act=
or_receive: { cpu_id =3D 49 }, { message_number =3D 14, message_action =3D =
31592, message_count =3D 8, message_source_actor =3D 1000019, message_desti=
nation_actor =3D 1000059, message_source_node =3D 3, message_destination_no=
de =3D 3 }
>
> If I substract the times:
>
> irb(main):003:0> (43.647025249-43.647017211)*10**9
> =3D> 8038.00000426236
>
> This message (<1000019, 14>) required 8038 ns for the delivery. This one =
is fine.
>
>
> So basically my question is:
>
> Is there an easy way to analyze these tracepoint files ?
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
