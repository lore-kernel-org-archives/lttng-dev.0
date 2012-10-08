From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [URCU PATCH 1/3] wfcqueue: implement
	concurrency-efficient queue
Date: Mon, 08 Oct 2012 17:47:10 +0200
Message-ID: <5072F57E.4020308__42814.256475731$1349711272$gmane$org@redhat.com>
References: <20121002141307.GA4057@Krystal> <20121002141444.GB4057@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paolo.bonzini@gmail.com>) id 1TLFYB-0005IL-TS
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 11:47:24 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so5305461pab.35
	for <lttng-dev@lists.lttng.org>; Mon, 08 Oct 2012 08:47:18 -0700 (PDT)
In-Reply-To: <20121002141444.GB4057@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Il 02/10/2012 16:14, Mathieu Desnoyers ha scritto:
> +/*
> + * Concurrent queue with wait-free enqueue/blocking dequeue.
> + *
> + * Inspired from half-wait-free/half-blocking queue implementation done by
> + * Paul E. McKenney.
> + *
> + * Mutual exclusion of __cds_wfcq_* API
> + *
> + * Unless otherwise stated, the caller must ensure mutual exclusion of
> + * queue update operations "dequeue" and "splice" (for source queue).
> + * Queue read operations "first" and "next" need to be protected against
> + * concurrent "dequeue" and "splice" (for source queue) by the caller.
> + * "enqueue", "splice" (for destination queue), and "empty" are the only
> + * operations that can be used without any mutual exclusion.
> + * Mutual exclusion can be ensured by holding cds_wfcq_dequeue_lock().
> + *
> + * For convenience, cds_wfcq_dequeue_blocking() and
> + * cds_wfcq_splice_blocking() hold the dequeue lock.
> + */

Hi,

can you add a for-like macro for iteration?  Iteration does not require
holding the lock and assumes that you are the sole user of the data
structure, which is useful together with splice.

Paolo
