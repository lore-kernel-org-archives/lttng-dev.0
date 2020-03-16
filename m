From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Large number of stream files in CTF trace -- too
 many file handles
Date: Mon, 16 Mar 2020 10:51:25 -0400
Message-ID: <20200316145125.GC14185@joraj-alpa>
References: <CADtyBo77-N3SscU7K_HCTwVq7+5f_d9yb19buve66p+SrHxVHQ@mail.gmail.com>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48gzlR4MSVz1L2q
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2020 10:51:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9854A26BC07
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2020 10:51:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CADtyBo77-N3SscU7K_HCTwVq7+5f_d9yb19buve66p+SrHxVHQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rocky Dunlap <dunlap@ucar.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

> If this is not the right approach, how should I proceed?  E.g., should the
> source-ctf-fs manage a limited pool of file handles?  I would think this
> would be pretty inefficient as you would need to constantly open/close
> files--expensive.

I would probably start looking at the soft and hardlimit for the babeltrace2
process in terms of open file:

On my machine:

joraj@~[]$ ulimit -Sn
1024

joraj@~[]$ ulimit -Hn
1048576

That is a lot of headspace.

I might have a setting somewhere increasing the base hardlimit but
in any case you will see how much room you have.

Based on the number of streams you have, I would say that you will
need more than 2000 as a base soft limit for this trace.

We do have a FD pooling system in place in another project we maintain
(lttng-tools[1] GPL-2.0) that might be pertinent for babeltrace2 at some point
in time. As for the overhead that would occur in a scenario with not enough FD
available, I think it is a good compromise between either reading a trace or
not reading it at all. A warning informing the user that we reached
the limit of the pool might be a good start in such case.

[1] https://github.com/lttng/lttng-tools/tree/master/src/common/fd-tracker

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
