From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: HugePages shared memory support in LLTng
Date: Mon, 22 Jul 2019 15:23:08 -0400
Message-ID: <20190722192308.GA803__14897.1952543192$1563823417$gmane$org@joraj-alpa>
References: <CAO+PNdHdLFk=Q0L2BLGnz8xCvdgMw3aYpZuAZumBOWKraKTnAw@mail.gmail.com>
 <20190715143302.GA2017@joraj-alpa>
 <CAO+PNdHW7O98QSdWyA5U6e=gtLmdFt77wHOT=eHb-Py1W3A-oQ@mail.gmail.com>
 <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45ss2n4L2dz16kp
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2019 15:23:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C314424E9A2
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2019 15:23:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAO+PNdFotFk6uCF1dySZi9dV6PYpAazWoQpsnU+N58F2b-73FQ@mail.gmail.com>
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

Hi Yiteng,

On Mon, Jul 22, 2019 at 02:44:09PM -0400, Yiteng Guo wrote:
> Hi Jonathan,
> 
> I spent these days on this problem and finally figured it out. Here
> are patches I've written.

Sorry for that, I had other stuff ongoing.

I had a brief discussion about this with Mathieu Desnoyers.

Mathieu mentioned that the page faults you are seeing might be related to
qemu/kvm usage of KSM [1]. I did not have time to play around with it and see if
this indeed have an effect. You might be better off trying it since you are
already all setup. Might want to disable it and retry your experiment (if only
doing this on a vm).

[1] https://www.linux-kvm.org/page/KSM

> 
> https://github.com/lttng/lttng-ust/compare/master...guoyiteng:hugepages
> https://github.com/lttng/lttng-tools/compare/master...guoyiteng:hugepages

I'll have a look as soon as possible.

> 
> These two patches are just ad-hoc supports for hugepages, which are
> not intended to be a pull request. If you want to support hugepages in
> future lttng releases, I am glad to help you with that. What I did
> here is to replace `shm_open` with `open` on a hugetlbfs directory. I
> also modified other parts of code (such as memory alignment) to make
> them compatible with huge pages. I didn't use `shm-path` option
> because I noticed that this option would not only relocate the shm of
> ring buffer but also other shm and metadata files. However, we only
> wanted to use huge pages for ring buffer here. Here are commands I
> used to launch an lttng session.
> 
> ```
> lttng create
> lttng enable-channel --userspace --subbuf-size=4M --num-subbuf=2
> --buffers-pid my-channel

Any particular reason to user per-pid buffering?

We normally recommend per-uid tracing + lttng track when possible. Depends on
the final usecase.

> lttng add-context --userspace --type=perf:thread:page-fault
> lttng enable-event --userspace -c my-channel hello_world:my_first_tracepoint
> lttng start
> ```
> 
> My patches worked very well and I didn't get page faults anymore.
> However, the only caveat of this patch is that ringbuffers are not
> destroyed correctly. It leads to a problem that every new lttng
> session acquires some hugepages but never releases them. After I
> created and destroyed several sessions, I would get an error that told
> me there were not enough hugepages to be used. I get around this
> problem by restarting the session daemon. But there should be some way
> to have ringbuffers (or its channel) destroyed elegently when its
> session is destroyed.

That is weird. I would expect the cleanup code to get rid of the ringbuffers as
needed. Or at least try and fail.

> 
> In the meantime, I am also trying another way to get rid of these page
> faults, which is to prefault the ringbuffer shared memory in my
> program. This solution does not need any modification on lttng souce
> codes, which, I think, is a safer way to go. However, to prefault the
> ringbuffer shm, I need to know the address (and size) of the
> ringbuffer. Is there any way to learn this piece of information from
> the user program?

AFAIK, we do not expose the address. I might be wrong here.

How to you plan on prefaulting the pages?

MAP_POPULATE?

Cheers
