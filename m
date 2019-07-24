From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Wed, 24 Jul 2019 11:59:53 -0400
Message-ID: <20190724155953.GB27633__38636.0958263808$1563984010$gmane$org@joraj-alpa>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
 <20190722192308.GA803@joraj-alpa> <20190723150744.GC803@joraj-alpa>
 <CAO+PNdGhEgeTo35du4ysMcCOUQ0PKE4tuyGg593AE5feZZ4_JQ@mail.gmail.com>
 <20190723202723.GD803@joraj-alpa>
 <CAO+PNdEfTq5vAqWJAoWK_hyxdjUuQgPPf0sqJXNO9jw1J6RoNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45v0RH2BZmz1GFX
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 11:59:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A44582AC60F
 for <lttng-dev@lists.lttng.org>; Wed, 24 Jul 2019 11:59:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAO+PNdEfTq5vAqWJAoWK_hyxdjUuQgPPf0sqJXNO9jw1J6RoNg@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Yiteng,

Make sure to always CC the mailing list.

> > Were you able to observe a positive impact?
> >
> > This is something we might be interested in upstreaming if we have good
> > feedback.
> 
> Yes, page faults disappeared and I didn't get those periodic overheads anymore.

Good. We will have to discuss this with Mathieu Desnoyers when he is back from
vacation and see if always using MAP_POPULATE make sense.

> 
> And I also solved the problem that hugepages are not closed correctly
> in my patch. It is my fault that I forgot to close the mmap pointer. I
> updated the patch here:
> https://github.com/lttng/lttng-ust/compare/master...guoyiteng:hugepages

Good. Would you be interested in posting those patches as RFC on the mailing
list so that we have a trace of this work in the future? Github cannot give us
the persistence needed for this. It might also lead to broader discussion.

> The current prefault solution works well for me and I will use that
> for now. In my opinion, using hugepages could further reduce the TLB
> misses, but that involved more changes in source codes than the
> prefault solution.
> 
> Best,
> Yiteng

-- 
Jonathan Rajotte-Julien
EfficiOS
