From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [RFC PATCH] wfqueue: expand API,
 simplify implementation, small performance boost
Date: Thu, 16 Aug 2012 10:08:54 +0800
Message-ID: <CACvQF52Z-wyz=LPOjZyJpfhHdF8cAtr8A5bWABM=3A95=q8Egg__27356.0693873607$1345082966$gmane$org@mail.gmail.com>
References: <20120812145000.GA32747@Krystal>
	<CACvQF52366ewREnRrDgi+xUBVQ6_ifWjoDv==nHik8FbCnMugA@mail.gmail.com>
	<20120813201219.GA27637@Krystal>
	<CACvQF51tWXaTdm9jCC=0S2XA+BdzJmR0W2sFVZAuVVZiWX8jAA@mail.gmail.com>
	<20120814222724.GA9751@Krystal>
	<CACvQF51LxhB+H8X9MqmDTS4xmGUyttTMNk66=NLvqsBkw00qXg@mail.gmail.com>
	<20120815125209.GA11737@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eag0628@gmail.com>) id 1T1pW7-000591-Ja
	for lttng-dev@lists.lttng.org; Wed, 15 Aug 2012 22:08:59 -0400
Received: by qcsc21 with SMTP id c21so2229383qcs.35
	for <lttng-dev@lists.lttng.org>; Wed, 15 Aug 2012 19:08:54 -0700 (PDT)
In-Reply-To: <20120815125209.GA11737@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

>>
>> Is it false sharing?
>> Access to q->head.next and access to q->tail have the same performance
>> because they are in the same cache line.
>
> Yes! you are right! And a quick benchmark confirms it:
>
> with head and tail on same cache line:
>
> SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    100833595 nr_dequeues     88647134 successful enqueues 100833595 successful dequeues     88646898 end_dequeues 12186697 nr_ops 189480729
>
> with a 256 bytes padding between head and tail, keeping the mutex on the
> "head" cache line:
>
> SUMMARY /home/compudj/doc/userspace-rcu/tests/.libs/lt-test_urcu_wfq testdur   10 nr_enqueuers   1 wdelay      0 nr_dequeuers   1 rdur      0 nr_enqueues    228992829 nr_dequeues    228921791 successful enqueues 228992829 successful dequeues    228921367 end_dequeues 71462 nr_ops 457914620
>
> enqueue: 127% speedup
> dequeue: 158% speedup
>
> That is indeed a _really_ huge difference. However, to get this, we
> would have to increase the size of struct cds_wfq_queue beyond its
> current size, which would break API compatibility. Any idea on how to
> best do this without causing incompatibility would be welcome.
>

choice 1) two set of APIs?(cache-line-opt and none-cache-line-opt),
many users don't need the cache-line-opt.
choice 2) Just break the compatibility for NONE-LGPL. I think
NONE-LGPL-user of it is rare. And current version of urcu <1.0, I
don't like too much burden when <1.0.


thanks,
Lai
