From: Evgeniy Ivanov <i@eivanov.com>
Subject: Re: Problem with perf:thread in 2.5.0
Date: Fri, 25 Jul 2014 23:33:56 +0400
Message-ID: <CAO6Ho0fY==DNxF08VjOWq7fzKEzHiCChBpf=UXT6-T0YrSFECQ__29654.9000930556$1406316892$gmane$org@mail.gmail.com>
References: <CAO6Ho0fvPCgt6vK3S1DjsjfnRymRG=NUDSb8M_gJPdOjJ8UP0g@mail.gmail.com>
 <53D11FD0.8060400@ericsson.com>
 <CAO6Ho0c3TsMVAC5P=oDWkwmfoH4sKeRBc=np+w19CV2U=8AEGQ@mail.gmail.com>
 <53D170A2.6010103@ericsson.com> <53D175AD.4030904@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0476265420=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lolkaantimat@gmail.com>) id 1XAlFi-0007H4-IF
 for lttng-dev@lists.lttng.org; Fri, 25 Jul 2014 15:34:04 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so4159817iec.36
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jul 2014 12:33:56 -0700 (PDT)
In-Reply-To: <53D175AD.4030904@ericsson.com>
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

--===============0476265420==
Content-Type: multipart/alternative; boundary=e89a8f839e937d0db104ff09a7ee

--e89a8f839e937d0db104ff09a7ee
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey Jonathan,

Thanks a lot for help! I think I've found the reason of invalid context
messages: I reran root's lttng-sessiond, but didn't check sessions for my
user (since I've done 'destroy -a'). Today again I got issue with invalid
context and noticed, that there are two pairs of lttng-sessiond
and lttng-consumerd: from old version and from new version according dates.
Old one is from July 7, which is surprising, since I often do "destroy -a".
After killing everything seems to work. Btw, it's Oracle linux 6.5 with
linux 3.8.

I'll check that zeros after weekend: I don't have own access to that
machine.




On Fri, Jul 25, 2014 at 1:07 AM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@ericsson.com> wrote:

>
>
> On 07/24/2014 04:46 PM, Jonathan Rajotte-Julien wrote:
> >
> > Hey Evgeniy,
> >
> >
> >> Jonathan, sorry, I've copied wrong output, original command was with
> perf:thread:cpu-cycles:
> >>
> >>> lttng add-context -u -t vpid -t perf:thread:cpu-cycles -t
> perf:thread:instructions -t perf:thread:cache-misses
> >> Session auto-20140724-091524 created.
> >> Traces will be written in
> /export/home/eiva/lttng-traces/auto-20140724-091524
> >> UST context vpid added to all channels
> >> Error: perf:thread:cpu-cycles: UST invalid context
> >> Error: perf:thread:instructions: UST invalid context
> >> Error: perf:thread:cache-misses: UST invalid context
> >> Warning: Some command(s) went wrong
> >> UST event eiva_test:* created in channel channel0
> >
> > Weird, it works on my side (c&p) with latest version witch is 2.5 stabl=
e
> :P.
>
> I just tested a fresh install from stable ppa (
> https://launchpad.net/~lttng/+archive/ubuntu/ppa).
>
> and everything seems to work fine. Cycle,cache etc.
>
> Well, keep us up to date.
>
> Cheers
> Jonathan
>
> >
> >>
> >>> lttng --version
> >> lttng (LTTng Trace Control) 2.5.0 - Fumisterie
> >
> > From this output I guess you are working with the lttng package and not
> the source from git. I don't think packaging is the problem here but let
> just keep that in mind.
> > What dist are you on ?
> >
> > I'm sure you already done it a thousand time but could you just run
> these and send the output ?
> >
> > First make sure no lttng-sessiond is running then launch:
> >
> > lttng-sessiond -vvv
> >
> > In a separate terminal:
> >
> > lttng destroy -a  // Just in case
> > lttng -vvv create test
> >
> > lttng -vvv add-context -u -t vpid -t perf:thread:cpu-cycles -t
> perf:thread:instructions -t perf:thread:cache-misses
> >
> > If this work, you could test if you get the data or zero.
> >
> > lttng enable-event -u -a -s test
> >
> > lttng start
> > // Run the program
> >
> > lttng stop
> >
> > Make sure to send the output from lttng-sessiond -vvv.
> >
> >
> > Cheers,
> > Jonathan
> >
> >>
> >> Later I've tried cpu-cycles separately and then accidentally switched
> to perf:cpu. Now everything started to work, but nothing changed since
> then. Though didn't check if we still get zeroes on another machine.
> >>
> >>
> >> On Thu, Jul 24, 2014 at 7:01 PM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@ericsson.com <mailto:
> jonathan.rajotte-julien@ericsson.com>> wrote:
> >>
> >>     Hi!
> >>
> >>     > Hi!
> >>     >
> >>     > I use lttng-2.5.0 (tools, modules, =E2=80=A6) and linux-3.8.13. =
When I
> try to add context for performance counters I get the following error:
> >>     >
> >>     >> lttng add-context -u -t perf:cpu:cpu-cycles
> >>     > Error: perf:cpu:cpu-cycles: UST invalid context
> >>     > Warning: Some command(s) went wrong
> >>
> >>     Well i think we will both agree that the help page does not help
> very much.(Should fix that)
> >>
> >>     If we go deep down into the code we get the supported context for
> UST domain. :)
> >>
> >>     Ust domain support 6 type of context:
> >>     LTTNG_EVENT_CONTEXT_VTID
> >>     LTTNG_EVENT_CONTEXT_VPID
> >>     LTTNG_UST_CONTEXT_VPID
> >>     LTTNG_EVENT_CONTEXT_PTHREAD_ID
> >>     LTTNG_EVENT_CONTEXT_PROCNAME
> >>     LTTNG_EVENT_CONTEXT_IP
> >>     LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER
> >>
> >>     Well this does help a little ... If we dig a little deeper and
> search around we get more info and see that an enum from
> "./lttng-tools/include/lttng/event.h" lttng_event_context_t maps to anoth=
er
> one in the lttng-tool side ( context_type in add_context.c)
> >>
> >>     *Important Part*
> >>     So if we decrypt the macros and functions in add-context.c, we get
> that the following contexts are supported for UST:
> >>
> >>     vpid
> >>     vtid
> >>     pthread_id
> >>     procname
> >>     ip
> >>
> >>     perf:thread:cpu-cycles
> >>     perf:thread:cycles
> >>     perf:thread:stalled-cycles-frontend
> >>     perf:thread:idle-cycles-frontend
> >>     perf:thread:stalled-cycles-backend
> >>     perf:thread:idle-cycles-backend
> >>     perf:thread:instructions
> >>     perf:thread:cache-references
> >>     perf:thread:cache-misses
> >>     perf:thread:branch-instructions
> >>     perf:thread:branches
> >>     perf:thread:branch-misses
> >>     perf:thread:bus-cycles
> >>
> >>     perf:thread:L1-dcache
> >>     perf:thread:L1-icache
> >>     perf:thread:LLC
> >>     perf:thread:dTLB
> >>     perf:thread:iTLB-loads
> >>     perf:thread:iTLB-load-misses
> >>     perf:thread:branch-loads
> >>     perf:thread:branch-load-misses
> >>
> >>     perf:thread:cpu-clock
> >>     perf:thread:task-clock
> >>     perf:thread:page-fault
> >>     perf:thread:faults
> >>     perf:thread:major-faults
> >>     perf:thread:minor-faults
> >>     perf:thread:context-switches
> >>     perf:thread:cs
> >>     perf:thread:cpu-migrations
> >>     perf:thread:migrations
> >>     perf:thread:alignment-faults
> >>     perf:thread:emulation-faults
> >>
> >>     **(TL;DR : perf:cpu:cpu-cycles is not in the list)**
> >>
> >>     If you want perf:cpu:cpu-cycles you will need a kernel tracing
> domain.
> >>
> >>     Even if it make sense that a ust tracing session cannot touch
> hardware stuff it won=E2=80=99t hurt to be more explicit about it. :).
> >>
> >>     >
> >>     > We have another machine with 2.5.0 (modules are not installed
> though) and adding perf:cpu:cpu-cycles works fine, but it is always zero =
in
> results.
> >>
> >>     As for this, I cannot explain why lttng-tool does not complain on
> adding the context.
> >>     You can open a bug here http://bugs.lttng.org/projects/lttng-tools
> (you will need to create an account and sign in)
> >>
> >>     Cheers,
> >>     Jonathan
> >>
> >>     >
> >>     > --
> >>     > Cheers,
> >>     > Evgeniy
> >>     >
> >>     >
> >>     > _______________________________________________
> >>     > lttng-dev mailing list
> >>     > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >>     > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>     >
> >>
> >>
> >>
> >>
> >> --
> >> Cheers,
> >> Evgeniy
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
Cheers,
Evgeniy

--e89a8f839e937d0db104ff09a7ee
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey Jonathan,<div><br></div><div>Thanks a lot for help! I =
think I&#39;ve found the reason of invalid context messages: I reran root&#=
39;s lttng-sessiond, but didn&#39;t check sessions for my user (since I&#39=
;ve done &#39;destroy -a&#39;). Today again I got issue with invalid contex=
t and noticed, that there are two pairs of lttng-sessiond and=C2=A0lttng-co=
nsumerd: from old version and from new version according dates. Old one is =
from July 7, which is surprising, since I often do &quot;destroy -a&quot;. =
After killing everything seems to work. Btw, it&#39;s Oracle linux 6.5 with=
 linux 3.8.</div>
<div><br></div><div>I&#39;ll check that zeros after weekend: I don&#39;t ha=
ve own access to that machine.</div><div><br></div><div><br></div></div><di=
v class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Jul 25, =
2014 at 1:07 AM, Jonathan Rajotte-Julien <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:jonathan.rajotte-julien@ericsson.com" target=3D"_blank">jonathan.rajo=
tte-julien@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D""><br>
<br>
On 07/24/2014 04:46 PM, Jonathan Rajotte-Julien wrote:<br>
&gt;<br>
&gt; Hey Evgeniy,<br>
&gt;<br>
&gt;<br>
&gt;&gt; Jonathan, sorry, I&#39;ve copied wrong output, original command wa=
s with perf:thread:cpu-cycles:<br>
&gt;&gt;<br>
&gt;&gt;&gt; lttng add-context -u -t vpid -t perf:thread:cpu-cycles -t perf=
:thread:instructions -t perf:thread:cache-misses<br>
&gt;&gt; Session auto-20140724-091524 created.<br>
&gt;&gt; Traces will be written in /export/home/eiva/lttng-traces/auto-2014=
0724-091524<br>
&gt;&gt; UST context vpid added to all channels<br>
&gt;&gt; Error: perf:thread:cpu-cycles: UST invalid context<br>
&gt;&gt; Error: perf:thread:instructions: UST invalid context<br>
&gt;&gt; Error: perf:thread:cache-misses: UST invalid context<br>
&gt;&gt; Warning: Some command(s) went wrong<br>
&gt;&gt; UST event eiva_test:* created in channel channel0<br>
&gt;<br>
&gt; Weird, it works on my side (c&amp;p) with latest version witch is 2.5 =
stable :P.<br>
<br>
</div>I just tested a fresh install from stable ppa (<a href=3D"https://lau=
nchpad.net/~lttng/+archive/ubuntu/ppa" target=3D"_blank">https://launchpad.=
net/~lttng/+archive/ubuntu/ppa</a>).<br>
<br>
and everything seems to work fine. Cycle,cache etc.<br>
<br>
Well, keep us up to date.<br>
<br>
Cheers<br>
Jonathan<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; lttng --version<br>
&gt;&gt; lttng (LTTng Trace Control) 2.5.0 - Fumisterie<br>
&gt;<br>
&gt; From this output I guess you are working with the lttng package and no=
t the source from git. I don&#39;t think packaging is the problem here but =
let just keep that in mind.<br>
&gt; What dist are you on ?<br>
&gt;<br>
&gt; I&#39;m sure you already done it a thousand time but could you just ru=
n these and send the output ?<br>
&gt;<br>
&gt; First make sure no lttng-sessiond is running then launch:<br>
&gt;<br>
&gt; lttng-sessiond -vvv<br>
&gt;<br>
&gt; In a separate terminal:<br>
&gt;<br>
&gt; lttng destroy -a =C2=A0// Just in case<br>
&gt; lttng -vvv create test<br>
&gt;<br>
&gt; lttng -vvv add-context -u -t vpid -t perf:thread:cpu-cycles -t perf:th=
read:instructions -t perf:thread:cache-misses<br>
&gt;<br>
&gt; If this work, you could test if you get the data or zero.<br>
&gt;<br>
&gt; lttng enable-event -u -a -s test<br>
&gt;<br>
&gt; lttng start<br>
&gt; // Run the program<br>
&gt;<br>
&gt; lttng stop<br>
&gt;<br>
&gt; Make sure to send the output from lttng-sessiond -vvv.<br>
&gt;<br>
&gt;<br>
&gt; Cheers,<br>
&gt; Jonathan<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Later I&#39;ve tried cpu-cycles separately and then accidentally s=
witched to perf:cpu. Now everything started to work, but nothing changed si=
nce then. Though didn&#39;t check if we still get zeroes on another machine=
.<br>

&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Jul 24, 2014 at 7:01 PM, Jonathan Rajotte-Julien &lt;<a hr=
ef=3D"mailto:jonathan.rajotte-julien@ericsson.com">jonathan.rajotte-julien@=
ericsson.com</a> &lt;mailto:<a href=3D"mailto:jonathan.rajotte-julien@erics=
son.com">jonathan.rajotte-julien@ericsson.com</a>&gt;&gt; wrote:<br>

&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Hi!<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; Hi!<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; I use lttng-2.5.0 (tools, modules, =E2=80=A6) a=
nd linux-3.8.13. When I try to add context for performance counters I get t=
he following error:<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; lttng add-context -u -t perf:cpu:cpu-cycles=
<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; Error: perf:cpu:cpu-cycles: UST invalid context=
<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; Warning: Some command(s) went wrong<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Well i think we will both agree that the help page d=
oes not help very much.(Should fix that)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 If we go deep down into the code we get the supporte=
d context for UST domain. :)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Ust domain support 6 type of context:<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT_VTID<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT_VPID<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_UST_CONTEXT_VPID<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT_PTHREAD_ID<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT_PROCNAME<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT_IP<br>
&gt;&gt; =C2=A0 =C2=A0 LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Well this does help a little ... If we dig a little =
deeper and search around we get more info and see that an enum from &quot;.=
/lttng-tools/include/lttng/event.h&quot; lttng_event_context_t maps to anot=
her one in the lttng-tool side ( context_type in add_context.c)<br>

&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 *Important Part*<br>
&gt;&gt; =C2=A0 =C2=A0 So if we decrypt the macros and functions in add-con=
text.c, we get that the following contexts are supported for UST:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 vpid<br>
&gt;&gt; =C2=A0 =C2=A0 vtid<br>
&gt;&gt; =C2=A0 =C2=A0 pthread_id<br>
&gt;&gt; =C2=A0 =C2=A0 procname<br>
&gt;&gt; =C2=A0 =C2=A0 ip<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cpu-cycles<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cycles<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:stalled-cycles-frontend<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:idle-cycles-frontend<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:stalled-cycles-backend<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:idle-cycles-backend<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:instructions<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cache-references<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cache-misses<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-instructions<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:branches<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-misses<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:bus-cycles<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:L1-dcache<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:L1-icache<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:LLC<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:dTLB<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:iTLB-loads<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:iTLB-load-misses<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-loads<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:branch-load-misses<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cpu-clock<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:task-clock<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:page-fault<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:faults<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:major-faults<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:minor-faults<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:context-switches<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cs<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:cpu-migrations<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:migrations<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:alignment-faults<br>
&gt;&gt; =C2=A0 =C2=A0 perf:thread:emulation-faults<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 **(TL;DR : perf:cpu:cpu-cycles is not in the list)**=
<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 If you want perf:cpu:cpu-cycles you will need a kern=
el tracing domain.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Even if it make sense that a ust tracing session can=
not touch hardware stuff it won=E2=80=99t hurt to be more explicit about it=
. :).<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; We have another machine with 2.5.0 (modules are=
 not installed though) and adding perf:cpu:cpu-cycles works fine, but it is=
 always zero in results.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 As for this, I cannot explain why lttng-tool does no=
t complain on adding the context.<br>
&gt;&gt; =C2=A0 =C2=A0 You can open a bug here <a href=3D"http://bugs.lttng=
.org/projects/lttng-tools" target=3D"_blank">http://bugs.lttng.org/projects=
/lttng-tools</a> (you will need to create an account and sign in)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 Cheers,<br>
&gt;&gt; =C2=A0 =C2=A0 Jonathan<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; --<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; Cheers,<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; Evgeniy<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; _______________________________________________=
<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; lttng-dev mailing list<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lt=
tng-dev@lists.lttng.org</a> &lt;mailto:<a href=3D"mailto:lttng-dev@lists.lt=
tng.org">lttng-dev@lists.lttng.org</a>&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 &gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mai=
lman/listinfo/lttng-dev</a><br>
&gt;&gt; =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Cheers,<br>
&gt;&gt; Evgeniy<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
</div></div>&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev</a><br>
<div class=3D"">&gt;<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
</div><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Cheers,<br>E=
vgeniy
</div>

--e89a8f839e937d0db104ff09a7ee--


--===============0476265420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0476265420==--
