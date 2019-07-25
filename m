From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Thu, 25 Jul 2019 11:40:23 -0400 (EDT)
Message-ID: <1962899258.11638.1564069223526.JavaMail.zimbra__45876.3324118749$1564069310$gmane$org@efficios.com>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa> <20190723150744.GC803@joraj-alpa>
 <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
 <20190723202723.GD803@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45vbyQ3X5Gz1HGs
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jul 2019 11:40:30 -0400 (EDT)
In-Reply-To: <20190723202723.GD803@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>, Yiteng Guo <guoyiteng@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 23, 2019, at 9:27 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> CC'ing the mailing list back.
> 
> On Tue, Jul 23, 2019 at 03:58:09PM -0400, Yiteng Guo wrote:
>> Hi Jonathan,
>> 
>> Thank you for the patch! It is really helpful.
> 
> Were you able to observe a positive impact?
> 
> This is something we might be interested in upstreaming if we have good
> feedback.
> 
>> 
>> Is there any disadvantage of per-pid buffering? I don't want to have
>> processes interfere with each other so I choose per-pid buffering.
> 
> The main downside is that each registered applications will get their own
> subbuffers resulting in a lot of memory usage depending on your session
> configuration. This can get out of hand quickly, especially on systems withs
> lots
> of cores and unknown number of instrumented applications.

I can add 2 extra cents (or actually a few more) to this answer:

There are a few reasons for using per-uid buffers over per-pid:

- Lower memory consumption for use-cases with many processes,
- Faster process launch time: no need to allocate buffers for each process.
  Useful for use-cases with short-lived processes.
- Keep a flight recorder "snapshot" available for all processes, including
  those which recently exited. Indeed, the per-pid buffers don't stay around
  for snapshot after a process exits or is killed.

There are however a few advantages for per-pid buffers:

- Isolation: if one PID generates corrupted trace data, it does not interfere
  with other PIDs buffers,
- If one PID is killed between reserve and commit, it does not make that specific
  per-cpu ring buffer unusable for the rest of the tracing session lifetime.

Hoping this information helps making the right choice for your deployment!

Thanks,

Mathieu


> 
> If you completely control the runtime, for example when doing benchmarking or
> simple analysis, feel free to use what make more sense to you as long as you
> understand the pitfalls of each mode.
> 
> Cheers
> 
> --
> Jonathan Rajotte-Julien
> EfficiOS
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
