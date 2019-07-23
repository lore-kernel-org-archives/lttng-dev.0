From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Tue, 23 Jul 2019 16:27:23 -0400
Message-ID: <20190723202723.GD803__25969.9100440898$1563913661$gmane$org@joraj-alpa>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa> <20190723150744.GC803@joraj-alpa>
 <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45tVQP0dZjz18p6
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2019 16:27:24 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 948C22ABC6D
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2019 16:27:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yiteng Guo <guoyiteng@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

CC'ing the mailing list back.

On Tue, Jul 23, 2019 at 03:58:09PM -0400, Yiteng Guo wrote:
> Hi Jonathan,
> 
> Thank you for the patch! It is really helpful.

Were you able to observe a positive impact?

This is something we might be interested in upstreaming if we have good
feedback.

> 
> Is there any disadvantage of per-pid buffering? I don't want to have
> processes interfere with each other so I choose per-pid buffering.

The main downside is that each registered applications will get their own
subbuffers resulting in a lot of memory usage depending on your session
configuration. This can get out of hand quickly, especially on systems withs lots
of cores and unknown number of instrumented applications.

If you completely control the runtime, for example when doing benchmarking or
simple analysis, feel free to use what make more sense to you as long as you
understand the pitfalls of each mode.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
