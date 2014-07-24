From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@ericsson.com>
Subject: Re: Problem with perf:thread in 2.5.0
Date: Thu, 24 Jul 2014 11:01:36 -0400
Message-ID: <53D11FD0.8060400__7309.29826754636$1406214168$gmane$org@ericsson.com>
References: <CAO6Ho0fvPCgt6vK3S1DjsjfnRymRG=NUDSb8M_gJPdOjJ8UP0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XAKWd-0006Jb-Fa
 for lttng-dev@lists.lttng.org; Thu, 24 Jul 2014 11:01:48 -0400
In-Reply-To: <CAO6Ho0fvPCgt6vK3S1DjsjfnRymRG=NUDSb8M_gJPdOjJ8UP0g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Evgeniy Ivanov <i@eivanov.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi!

> Hi!
> =

> I use lttng-2.5.0 (tools, modules, =85) and linux-3.8.13. When I try to a=
dd context for performance counters I get the following error:
> =

>> lttng add-context -u -t perf:cpu:cpu-cycles
> Error: perf:cpu:cpu-cycles: UST invalid context
> Warning: Some command(s) went wrong

Well i think we will both agree that the help page does not help very much.=
(Should fix that)

If we go deep down into the code we get the supported context for UST domai=
n. :)

Ust domain support 6 type of context:
LTTNG_EVENT_CONTEXT_VTID
LTTNG_EVENT_CONTEXT_VPID
LTTNG_UST_CONTEXT_VPID
LTTNG_EVENT_CONTEXT_PTHREAD_ID
LTTNG_EVENT_CONTEXT_PROCNAME
LTTNG_EVENT_CONTEXT_IP
LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER

Well this does help a little ... If we dig a little deeper and search aroun=
d we get more info and see that an enum from "./lttng-tools/include/lttng/e=
vent.h" lttng_event_context_t maps to another one in the lttng-tool side ( =
context_type in add_context.c)

*Important Part*
So if we decrypt the macros and functions in add-context.c, we get that the=
 following contexts are supported for UST:

vpid
vtid
pthread_id
procname
ip

perf:thread:cpu-cycles
perf:thread:cycles
perf:thread:stalled-cycles-frontend
perf:thread:idle-cycles-frontend
perf:thread:stalled-cycles-backend
perf:thread:idle-cycles-backend
perf:thread:instructions
perf:thread:cache-references
perf:thread:cache-misses
perf:thread:branch-instructions
perf:thread:branches
perf:thread:branch-misses
perf:thread:bus-cycles
    =

perf:thread:L1-dcache
perf:thread:L1-icache
perf:thread:LLC
perf:thread:dTLB
perf:thread:iTLB-loads
perf:thread:iTLB-load-misses                                               =
                                                                           =
                     =

perf:thread:branch-loads
perf:thread:branch-load-misses
        =

perf:thread:cpu-clock
perf:thread:task-clock
perf:thread:page-fault
perf:thread:faults
perf:thread:major-faults
perf:thread:minor-faults
perf:thread:context-switches
perf:thread:cs
perf:thread:cpu-migrations
perf:thread:migrations
perf:thread:alignment-faults
perf:thread:emulation-faults

**(TL;DR : perf:cpu:cpu-cycles is not in the list)**

If you want perf:cpu:cpu-cycles you will need a kernel tracing domain.

Even if it make sense that a ust tracing session cannot touch hardware stuf=
f it won=92t hurt to be more explicit about it. :).

> =

> We have another machine with 2.5.0 (modules are not installed though) and=
 adding perf:cpu:cpu-cycles works fine, but it is always zero in results.

As for this, I cannot explain why lttng-tool does not complain on adding th=
e context.
You can open a bug here http://bugs.lttng.org/projects/lttng-tools (you wil=
l need to create an account and sign in)

Cheers,
Jonathan

> =

> -- =

> Cheers,
> Evgeniy
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> =
