From: Evgeniy Ivanov <i@eivanov.com>
Subject: Re: Problem with perf:thread in 2.5.0
Date: Thu, 31 Jul 2014 17:55:37 +0400
Message-ID: <CAO6Ho0fpyfDfL3V-qC3pqTzN66XU0TBtVQt8N-Krh0hxXx_Ruw__6937.27613329447$1406816569$gmane$org@mail.gmail.com>
References: <CAO6Ho0fvPCgt6vK3S1DjsjfnRymRG=NUDSb8M_gJPdOjJ8UP0g@mail.gmail.com>
 <53D11FD0.8060400@ericsson.com>
 <CAO6Ho0c3TsMVAC5P=oDWkwmfoH4sKeRBc=np+w19CV2U=8AEGQ@mail.gmail.com>
 <53D170A2.6010103@ericsson.com> <53D175AD.4030904@ericsson.com>
 <CAO6Ho0fY==DNxF08VjOWq7fzKEzHiCChBpf=UXT6-T0YrSFECQ@mail.gmail.com>
 <CAO6Ho0c=FLs=e_TR2mz5913mmCVCE8v4wKJAJwhU4xPOKAp1=A@mail.gmail.com>
 <53D7AA3D.9090200@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0080562211=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lolkaantimat@gmail.com>) id 1XCrEt-0003rS-Aw
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 10:21:54 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so9511278igc.6
 for <lttng-dev@lists.lttng.org>; Thu, 31 Jul 2014 07:21:45 -0700 (PDT)
In-Reply-To: <53D7AA3D.9090200@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0080562211==
Content-Type: multipart/alternative; boundary=047d7b3a95989ab62404ff7da0b4

--047d7b3a95989ab62404ff7da0b4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Jonathan,

Thanks a lot for your help and clarifications. Sounds reasonable, if
someone disagrees, I'll file a bug and do additional testing.


On Tue, Jul 29, 2014 at 6:05 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@ericsson.com> wrote:

> Hey Evgeniy,
>
> At first I would says that this is proper behaviour. If we look into the
> lttng-module README file there is little paragraph about "Attach 'context=
;
> information to events in the trace".
>
> - Have the ability to attach "context" information to events in the
>   trace (e.g. any PMU counter, pid, ppid, tid, comm name, etc).
>   All the extra information fields to be collected with events are
>   optional, specified on a per-tracing-session basis (except for
>   timestamp and event id, which are mandatory).
>
> I would assume that the absence of lttng-module disable the ability to
> attach 'context'.
>
> If we read a little more down the readme file we get to this:
>
> The following kernel configuration options will affect the features
> available from LTTng:
>
> ...
>
> CONFIG_PERF_EVENTS:
>             performance counters
>                lttng add-context -t perf:*
>
> ...
>
> This seems to confirm my assumption. I won't have time today to test
> without kernel to really confirm this sorry.
>
> BUT if I'm wrong, I'm sure someone from efficiOS will jump in and correct
> me.  :P
>
> If this is actually correct behaviour, I invite you to open a bug for
> lttng-tool about it not warning the user that context attachment is not
> possible with no lttng-module (if this is possible).
>
> Cheers,
> Jonathan
>
> On 07/29/2014 08:32 AM, Evgeniy Ivanov wrote:
> > Hey Jonathan,
> >
> > On the machine with zeroes in results for perf counters, there is no
> lttng modules. Is it proper behavior then?
> >
> >
> > On Fri, Jul 25, 2014 at 11:33 PM, Evgeniy Ivanov <i@eivanov.com <mailto=
:
> i@eivanov.com>> wrote:
> >
> >     Hey Jonathan,
> >
> >     Thanks a lot for help! I think I've found the reason of invalid
> context messages: I reran root's lttng-sessiond, but didn't check session=
s
> for my user (since I've done 'destroy -a'). Today again I got issue with
> invalid context and noticed, that there are two pairs of lttng-sessiond a=
nd
> lttng-consumerd: from old version and from new version according dates. O=
ld
> one is from July 7, which is surprising, since I often do "destroy -a".
> After killing everything seems to work. Btw, it's Oracle linux 6.5 with
> linux 3.8.
> >
> >     I'll check that zeros after weekend: I don't have own access to tha=
t
> machine.
> >
> >
> >
> >
> >     On Fri, Jul 25, 2014 at 1:07 AM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@ericsson.com <mailto:
> jonathan.rajotte-julien@ericsson.com>> wrote:
> >
> >
> >
> >         On 07/24/2014 04:46 PM, Jonathan Rajotte-Julien wrote:
> >         >
> >         > Hey Evgeniy,
> >         >
> >         >
> >         >> Jonathan, sorry, I've copied wrong output, original command
> was with perf:thread:cpu-cycles:
> >         >>
> >         >>> lttng add-context -u -t vpid -t perf:thread:cpu-cycles -t
> perf:thread:instructions -t perf:thread:cache-misses
> >         >> Session auto-20140724-091524 created.
> >         >> Traces will be written in
> /export/home/eiva/lttng-traces/auto-20140724-091524
> >         >> UST context vpid added to all channels
> >         >> Error: perf:thread:cpu-cycles: UST invalid context
> >         >> Error: perf:thread:instructions: UST invalid context
> >         >> Error: perf:thread:cache-misses: UST invalid context
> >         >> Warning: Some command(s) went wrong
> >         >> UST event eiva_test:* created in channel channel0
> >         >
> >         > Weird, it works on my side (c&p) with latest version witch is
> 2.5 stable :P.
> >
> >         I just tested a fresh install from stable ppa (
> https://launchpad.net/~lttng/+archive/ubuntu/ppa).
> >
> >         and everything seems to work fine. Cycle,cache etc.
> >
> >         Well, keep us up to date.
> >
> >         Cheers
> >         Jonathan
> >
> >         >
> >         >>
> >         >>> lttng --version
> >         >> lttng (LTTng Trace Control) 2.5.0 - Fumisterie
> >         >
> >         > From this output I guess you are working with the lttng
> package and not the source from git. I don't think packaging is the probl=
em
> here but let just keep that in mind.
> >         > What dist are you on ?
> >         >
> >         > I'm sure you already done it a thousand time but could you
> just run these and send the output ?
> >         >
> >         > First make sure no lttng-sessiond is running then launch:
> >         >
> >         > lttng-sessiond -vvv
> >         >
> >         > In a separate terminal:
> >         >
> >         > lttng destroy -a  // Just in case
> >         > lttng -vvv create test
> >         >
> >         > lttng -vvv add-context -u -t vpid -t perf:thread:cpu-cycles -=
t
> perf:thread:instructions -t perf:thread:cache-misses
> >         >
> >         > If this work, you could test if you get the data or zero.
> >         >
> >         > lttng enable-event -u -a -s test
> >         >
> >         > lttng start
> >         > // Run the program
> >         >
> >         > lttng stop
> >         >
> >         > Make sure to send the output from lttng-sessiond -vvv.
> >         >
> >         >
> >         > Cheers,
> >         > Jonathan
> >         >
> >         >>
> >         >> Later I've tried cpu-cycles separately and then accidentally
> switched to perf:cpu. Now everything started to work, but nothing changed
> since then. Though didn't check if we still get zeroes on another machine=
.
> >         >>
> >         >>
> >         >> On Thu, Jul 24, 2014 at 7:01 PM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@ericsson.com <mailto:
> jonathan.rajotte-julien@ericsson.com> <mailto:
> jonathan.rajotte-julien@ericsson.com <mailto:
> jonathan.rajotte-julien@ericsson.com>>> wrote:
> >         >>
> >         >>     Hi!
> >         >>
> >         >>     > Hi!
> >         >>     >
> >         >>     > I use lttng-2.5.0 (tools, modules, =E2=80=A6) and linu=
x-3.8.13.
> When I try to add context for performance counters I get the following
> error:
> >         >>     >
> >         >>     >> lttng add-context -u -t perf:cpu:cpu-cycles
> >         >>     > Error: perf:cpu:cpu-cycles: UST invalid context
> >         >>     > Warning: Some command(s) went wrong
> >         >>
> >         >>     Well i think we will both agree that the help page does
> not help very much.(Should fix that)
> >         >>
> >         >>     If we go deep down into the code we get the supported
> context for UST domain. :)
> >         >>
> >         >>     Ust domain support 6 type of context:
> >         >>     LTTNG_EVENT_CONTEXT_VTID
> >         >>     LTTNG_EVENT_CONTEXT_VPID
> >         >>     LTTNG_UST_CONTEXT_VPID
> >         >>     LTTNG_EVENT_CONTEXT_PTHREAD_ID
> >         >>     LTTNG_EVENT_CONTEXT_PROCNAME
> >         >>     LTTNG_EVENT_CONTEXT_IP
> >         >>     LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER
> >         >>
> >         >>     Well this does help a little ... If we dig a little
> deeper and search around we get more info and see that an enum from
> "./lttng-tools/include/lttng/event.h" lttng_event_context_t maps to anoth=
er
> one in the lttng-tool side ( context_type in add_context.c)
> >         >>
> >         >>     *Important Part*
> >         >>     So if we decrypt the macros and functions in
> add-context.c, we get that the following contexts are supported for UST:
> >         >>
> >         >>     vpid
> >         >>     vtid
> >         >>     pthread_id
> >         >>     procname
> >         >>     ip
> >         >>
> >         >>     perf:thread:cpu-cycles
> >         >>     perf:thread:cycles
> >         >>     perf:thread:stalled-cycles-frontend
> >         >>     perf:thread:idle-cycles-frontend
> >         >>     perf:thread:stalled-cycles-backend
> >         >>     perf:thread:idle-cycles-backend
> >         >>     perf:thread:instructions
> >         >>     perf:thread:cache-references
> >         >>     perf:thread:cache-misses
> >         >>     perf:thread:branch-instructions
> >         >>     perf:thread:branches
> >         >>     perf:thread:branch-misses
> >         >>     perf:thread:bus-cycles
> >         >>
> >         >>     perf:thread:L1-dcache
> >         >>     perf:thread:L1-icache
> >         >>     perf:thread:LLC
> >         >>     perf:thread:dTLB
> >         >>     perf:thread:iTLB-loads
> >         >>     perf:thread:iTLB-load-misses
> >         >>     perf:thread:branch-loads
> >         >>     perf:thread:branch-load-misses
> >         >>
> >         >>     perf:thread:cpu-clock
> >         >>     perf:thread:task-clock
> >         >>     perf:thread:page-fault
> >         >>     perf:thread:faults
> >         >>     perf:thread:major-faults
> >         >>     perf:thread:minor-faults
> >         >>     perf:thread:context-switches
> >         >>     perf:thread:cs
> >         >>     perf:thread:cpu-migrations
> >         >>     perf:thread:migrations
> >         >>     perf:thread:alignment-faults
> >         >>     perf:thread:emulation-faults
> >         >>
> >         >>     **(TL;DR : perf:cpu:cpu-cycles is not in the list)**
> >         >>
> >         >>     If you want perf:cpu:cpu-cycles you will need a kernel
> tracing domain.
> >         >>
> >         >>     Even if it make sense that a ust tracing session cannot
> touch hardware stuff it won=E2=80=99t hurt to be more explicit about it. =
:).
> >         >>
> >         >>     >
> >         >>     > We have another machine with 2.5.0 (modules are not
> installed though) and adding perf:cpu:cpu-cycles works fine, but it is
> always zero in results.
> >         >>
> >         >>     As for this, I cannot explain why lttng-tool does not
> complain on adding the context.
> >         >>     You can open a bug here
> http://bugs.lttng.org/projects/lttng-tools (you will need to create an
> account and sign in)
> >         >>
> >         >>     Cheers,
> >         >>     Jonathan
> >         >>
> >         >>     >
> >         >>     > --
> >         >>     > Cheers,
> >         >>     > Evgeniy
> >         >>     >
> >         >>     >
> >         >>     > _______________________________________________
> >         >>     > lttng-dev mailing list
> >         >>     > lttng-dev@lists.lttng.org <mailto:
> lttng-dev@lists.lttng.org> <mailto:lttng-dev@lists.lttng.org <mailto:
> lttng-dev@lists.lttng.org>>
> >         >>     >
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >         >>     >
> >         >>
> >         >>
> >         >>
> >         >>
> >         >> --
> >         >> Cheers,
> >         >> Evgeniy
> >         >
> >         >
> >         > _______________________________________________
> >         > lttng-dev mailing list
> >         > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >         > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >         >
> >
> >
> >         _______________________________________________
> >         lttng-dev mailing list
> >         lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >         http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> >
> >
> >     --
> >     Cheers,
> >     Evgeniy
> >
> >
> >
> >
> > --
> > Cheers,
> > Evgeniy
>
>


--=20
Cheers,
Evgeniy

--047d7b3a95989ab62404ff7da0b4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey Jonathan,<div><br></div><div>Thanks a lot for your hel=
p and clarifications. Sounds reasonable, if someone disagrees, I&#39;ll fil=
e a bug and do additional testing.</div></div><div class=3D"gmail_extra"><b=
r>
<br><div class=3D"gmail_quote">On Tue, Jul 29, 2014 at 6:05 PM, Jonathan Ra=
jotte-Julien <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julie=
n@ericsson.com" target=3D"_blank">jonathan.rajotte-julien@ericsson.com</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hey Evgeniy,<br>
<br>
At first I would says that this is proper behaviour. If we look into the lt=
tng-module README file there is little paragraph about &quot;Attach &#39;co=
ntext; information to events in the trace&quot;.<br>
<br>
- Have the ability to attach &quot;context&quot; information to events in t=
he<br>
=C2=A0 trace (e.g. any PMU counter, pid, ppid, tid, comm name, etc).<br>
=C2=A0 All the extra information fields to be collected with events are<br>
=C2=A0 optional, specified on a per-tracing-session basis (except for<br>
=C2=A0 timestamp and event id, which are mandatory).<br>
<br>
I would assume that the absence of lttng-module disable the ability to atta=
ch &#39;context&#39;.<br>
<br>
If we read a little more down the readme file we get to this:<br>
<br>
The following kernel configuration options will affect the features<br>
available from LTTng:<br>
<br>
...<br>
<br>
CONFIG_PERF_EVENTS:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 performance counters<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lttng add-context -t=
 perf:*<br>
<br>
...<br>
<br>
This seems to confirm my assumption. I won&#39;t have time today to test wi=
thout kernel to really confirm this sorry.<br>
<br>
BUT if I&#39;m wrong, I&#39;m sure someone from efficiOS will jump in and c=
orrect me. =C2=A0:P<br>
<br>
If this is actually correct behaviour, I invite you to open a bug for lttng=
-tool about it not warning the user that context attachment is not possible=
 with no lttng-module (if this is possible).<br>
<br>
Cheers,<br>
Jonathan<br>
<div class=3D""><br>
On 07/29/2014 08:32 AM, Evgeniy Ivanov wrote:<br>
&gt; Hey Jonathan,<br>
&gt;<br>
&gt; On the machine with zeroes in results for perf counters, there is no l=
ttng modules. Is it proper behavior then?<br>
&gt;<br>
&gt;<br>
</div><div class=3D"">&gt; On Fri, Jul 25, 2014 at 11:33 PM, Evgeniy Ivanov=
 &lt;<a href=3D"mailto:i@eivanov.com">i@eivanov.com</a> &lt;mailto:<a href=
=3D"mailto:i@eivanov.com">i@eivanov.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Hey Jonathan,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Thanks a lot for help! I think I&#39;ve found the reason=
 of invalid context messages: I reran root&#39;s lttng-sessiond, but didn&#=
39;t check sessions for my user (since I&#39;ve done &#39;destroy -a&#39;).=
 Today again I got issue with invalid context and noticed, that there are t=
wo pairs of lttng-sessiond and lttng-consumerd: from old version and from n=
ew version according dates. Old one is from July 7, which is surprising, si=
nce I often do &quot;destroy -a&quot;. After killing everything seems to wo=
rk. Btw, it&#39;s Oracle linux 6.5 with linux 3.8.<br>

&gt;<br>
&gt; =C2=A0 =C2=A0 I&#39;ll check that zeros after weekend: I don&#39;t hav=
e own access to that machine.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div><div><div class=3D"h5">&gt; =C2=A0 =C2=A0 On Fri, Jul 25, 2014 at 1:0=
7 AM, Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien=
@ericsson.com">jonathan.rajotte-julien@ericsson.com</a> &lt;mailto:<a href=
=3D"mailto:jonathan.rajotte-julien@ericsson.com">jonathan.rajotte-julien@er=
icsson.com</a>&gt;&gt; wrote:<br>

&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 On 07/24/2014 04:46 PM, Jonathan Rajotte-J=
ulien wrote:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Hey Evgeniy,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Jonathan, sorry, I&#39;ve copied =
wrong output, original command was with perf:thread:cpu-cycles:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; lttng add-context -u -t vpid =
-t perf:thread:cpu-cycles -t perf:thread:instructions -t perf:thread:cache-=
misses<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Session auto-20140724-091524 crea=
ted.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Traces will be written in /export=
/home/eiva/lttng-traces/auto-20140724-091524<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; UST context vpid added to all cha=
nnels<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Error: perf:thread:cpu-cycles: US=
T invalid context<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Error: perf:thread:instructions: =
UST invalid context<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Error: perf:thread:cache-misses: =
UST invalid context<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Warning: Some command(s) went wro=
ng<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; UST event eiva_test:* created in =
channel channel0<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Weird, it works on my side (c&amp;p) =
with latest version witch is 2.5 stable :P.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I just tested a fresh install from stable =
ppa (<a href=3D"https://launchpad.net/~lttng/+archive/ubuntu/ppa" target=3D=
"_blank">https://launchpad.net/~lttng/+archive/ubuntu/ppa</a>).<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 and everything seems to work fine. Cycle,c=
ache etc.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Well, keep us up to date.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Cheers<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Jonathan<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;&gt; lttng --version<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; lttng (LTTng Trace Control) 2.5.0=
 - Fumisterie<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; From this output I guess you are work=
ing with the lttng package and not the source from git. I don&#39;t think p=
ackaging is the problem here but let just keep that in mind.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; What dist are you on ?<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;m sure you already done it a th=
ousand time but could you just run these and send the output ?<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; First make sure no lttng-sessiond is =
running then launch:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng-sessiond -vvv<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; In a separate terminal:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng destroy -a =C2=A0// Just in cas=
e<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng -vvv create test<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng -vvv add-context -u -t vpid -t =
perf:thread:cpu-cycles -t perf:thread:instructions -t perf:thread:cache-mis=
ses<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; If this work, you could test if you g=
et the data or zero.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng enable-event -u -a -s test<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng start<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; // Run the program<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng stop<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Make sure to send the output from ltt=
ng-sessiond -vvv.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Cheers,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Jonathan<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Later I&#39;ve tried cpu-cycles s=
eparately and then accidentally switched to perf:cpu. Now everything starte=
d to work, but nothing changed since then. Though didn&#39;t check if we st=
ill get zeroes on another machine.<br>

&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
</div></div><div><div class=3D"h5">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt=
; On Thu, Jul 24, 2014 at 7:01 PM, Jonathan Rajotte-Julien &lt;<a href=3D"m=
ailto:jonathan.rajotte-julien@ericsson.com">jonathan.rajotte-julien@ericsso=
n.com</a> &lt;mailto:<a href=3D"mailto:jonathan.rajotte-julien@ericsson.com=
">jonathan.rajotte-julien@ericsson.com</a>&gt; &lt;mailto:<a href=3D"mailto=
:jonathan.rajotte-julien@ericsson.com">jonathan.rajotte-julien@ericsson.com=
</a> &lt;mailto:<a href=3D"mailto:jonathan.rajotte-julien@ericsson.com">jon=
athan.rajotte-julien@ericsson.com</a>&gt;&gt;&gt; wrote:<br>

&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Hi!<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; Hi!<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; I use lttng-2.=
5.0 (tools, modules, =E2=80=A6) and linux-3.8.13. When I try to add context=
 for performance counters I get the following error:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;&gt; lttng add-=
context -u -t perf:cpu:cpu-cycles<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; Error: perf:cp=
u:cpu-cycles: UST invalid context<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; Warning: Some =
command(s) went wrong<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Well i think we wil=
l both agree that the help page does not help very much.(Should fix that)<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 If we go deep down =
into the code we get the supported context for UST domain. :)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Ust domain support =
6 type of context:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT=
_VTID<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT=
_VPID<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_UST_CONTEXT_V=
PID<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT=
_PTHREAD_ID<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT=
_PROCNAME<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT=
_IP<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT=
_PERF_THREAD_COUNTER<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Well this does help=
 a little ... If we dig a little deeper and search around we get more info =
and see that an enum from &quot;./lttng-tools/include/lttng/event.h&quot; l=
ttng_event_context_t maps to another one in the lttng-tool side ( context_t=
ype in add_context.c)<br>

&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 *Important Part*<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 So if we decrypt th=
e macros and functions in add-context.c, we get that the following contexts=
 are supported for UST:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 vpid<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 vtid<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 pthread_id<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 procname<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 ip<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cpu-cyc=
les<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cycles<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:stalled=
-cycles-frontend<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:idle-cy=
cles-frontend<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:stalled=
-cycles-backend<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:idle-cy=
cles-backend<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:instruc=
tions<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cache-r=
eferences<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cache-m=
isses<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-=
instructions<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:branche=
s<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-=
misses<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:bus-cyc=
les<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:L1-dcac=
he<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:L1-icac=
he<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:LLC<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:dTLB<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:iTLB-lo=
ads<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:iTLB-lo=
ad-misses<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-=
loads<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-=
load-misses<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cpu-clo=
ck<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:task-cl=
ock<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:page-fa=
ult<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:faults<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:major-f=
aults<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:minor-f=
aults<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:context=
-switches<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cs<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:cpu-mig=
rations<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:migrati=
ons<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:alignme=
nt-faults<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 perf:thread:emulati=
on-faults<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 **(TL;DR : perf:cpu=
:cpu-cycles is not in the list)**<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 If you want perf:cp=
u:cpu-cycles you will need a kernel tracing domain.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Even if it make sen=
se that a ust tracing session cannot touch hardware stuff it won=E2=80=99t =
hurt to be more explicit about it. :).<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; We have anothe=
r machine with 2.5.0 (modules are not installed though) and adding perf:cpu=
:cpu-cycles works fine, but it is always zero in results.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 As for this, I cann=
ot explain why lttng-tool does not complain on adding the context.<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 You can open a bug =
here <a href=3D"http://bugs.lttng.org/projects/lttng-tools" target=3D"_blan=
k">http://bugs.lttng.org/projects/lttng-tools</a> (you will need to create =
an account and sign in)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Cheers,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 Jonathan<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; --<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; Cheers,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; Evgeniy<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; ______________=
_________________________________<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; lttng-dev mail=
ing list<br>
</div></div>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt; <a=
 href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a> &l=
t;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng=
.org</a>&gt; &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-=
dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.=
org">lttng-dev@lists.lttng.org</a>&gt;&gt;<br>

<div class=3D"">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt=
; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" tar=
get=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a=
><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; --<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Cheers,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;&gt; Evgeniy<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; _____________________________________=
__________<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; lttng-dev mailing list<br>
</div>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"mailto:lttng-dev@lis=
ts.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lt=
tng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;<br>
<div class=3D"im HOEnZb">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; <a href=3D"h=
ttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank"=
>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 __________________________________________=
_____<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng-dev mailing list<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org<=
/a> &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists=
.lttng.org</a>&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 --<br>
&gt; =C2=A0 =C2=A0 Cheers,<br>
&gt; =C2=A0 =C2=A0 Evgeniy<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; Cheers,<br>
&gt; Evgeniy<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Cheers,<br>Evgeniy
</div>

--047d7b3a95989ab62404ff7da0b4--


--===============0080562211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0080562211==--
