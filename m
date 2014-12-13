From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Bug in LTTng-UST
Date: Sat, 13 Dec 2014 00:29:55 -0500
Message-ID: <CAFXXi0m5NrM8AkQJgciXUmcK+sSu49SPvqA8iM4jRK+MtLfHAg__10545.764785684$1418448669$gmane$org@mail.gmail.com>
References: <1418432075.9766.6.camel@moya>
 <CAFXXi0nPMbLj-nAT281+7P=iUK+pg_PdMOP52XabquvVUikHSQ@mail.gmail.com>
 <CAB4xu_0abUHmaRSYSx1ehSx2jH1s3Oqm++mw6rNOXarbP31ZKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1XzfHj-00059A-L7
 for lttng-dev@lists.lttng.org; Sat, 13 Dec 2014 00:30:34 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so2841233iga.8
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 21:30:26 -0800 (PST)
In-Reply-To: <CAB4xu_0abUHmaRSYSx1ehSx2jH1s3Oqm++mw6rNOXarbP31ZKg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 12 December 2014 at 23:59, Philippe Proulx <eeppeliteloop@gmail.com> wrote:
> On Fri, Dec 12, 2014 at 11:21 PM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
>> Actually, I think the problem comes from UST not handling when a
>> program dlcloses a lib. There is a simpler way to show the problem.
>> Just have an app dlopen a .so that has a tracepoint and dlclose it.
>> When the app quits, UST will try to unregister the tracepoint and
>> read/write in the memory previously mapped to the library, causing a
>> segfault.
>>
>> I have made a small example. You just need to click on "Download gist"
>> in [1] to download a tarball, and a then simple make should be enough.
>> Start a UST session with -u -a and run ./app. Segfault should ensue.
>>
>> [1] https://gist.github.com/simark/9fc0e2395899fcd8d10d
>
> Don't you have to _preload_ the tracepoint provider in this context? Either
> by dlopen()ing the tracepoint provider shared object manually, or by using
> LD_PRELOAD?
>
> Try this instead <https://gist.github.com/eepp/d280a27f5e7d0a64abaa>.
> Look at the changes to Makefile, tracepoints.c and truc.c. Make, then
> launch the app while tracing is started:
>
>     ./app
>
> Nothing is recorded: the tracepoint provider shared object is not loaded.
> Now try preloading the tracepoint provider and launching the app:
>
>     LD_PRELOAD=./tracepoints.so ./app
>
> I get this:
>
>     lttng stop
>     lttng view
>     ...
>     [23:55:36.393480541] (+0.000074994) eeppdesk
> sample_tracepoint:message: { cpu_id = 0 }, { intfield = 4 }
>
> and no segfault.
>
> See: <http://lttng.org/docs/#doc-building-tracepoint-providers-and-user-application>,
> "Dynamic linking" section.
>
> Phil

Ok so as Philippe noticed, the man page is quite clear about this.

         - Note about dlclose() usage: it is not safe to use dlclose on a
           provider shared object that is being actively used for tracing due
           to a lack of reference counting from lttng-ust to the used shared
           object.

Given that game.so *is* the trace provider, we can't dlclose it. I
suppose the solution would be to put the tracepoints in a separate
library (game-tracepoints.so) and LD_PRELOAD that library whenever you
want to trace. I'll work on that.
