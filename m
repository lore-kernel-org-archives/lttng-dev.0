From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [URCU PATCH 1/3] wfcqueue: implement
	concurrency-efficient queue
Date: Mon, 08 Oct 2012 18:33:15 +0200
Message-ID: <5073004B.2050400__17423.5606137247$1349714037$gmane$org@redhat.com>
References: <20121002141307.GA4057@Krystal> <20121002141444.GB4057@Krystal>
	<5072F57E.4020308@redhat.com> <20121008161544.GB30083@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paolo.bonzini@gmail.com>) id 1TLGGm-0005jc-K7
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 12:33:28 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy7so5440089pbc.35
	for <lttng-dev@lists.lttng.org>; Mon, 08 Oct 2012 09:33:22 -0700 (PDT)
In-Reply-To: <20121008161544.GB30083@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Il 08/10/2012 18:15, Mathieu Desnoyers ha scritto:
> Hi Paolo,
> 
> We actually already have those, they are just not described in this
> comment. I will fix this right away. By the way, you will notice the
> wording:
> 
> + * Queue read operations "first" and "next", which are used by
> + * "for_each" iterations, need to be protected against concurrent
> + * "dequeue" and "splice" (for source queue) by the caller.
> 
> Being the only one iterating on a queue with local head/tail after a
> splice operation is one way to provide mutual exclusion. Holding a lock
> is not the only way to achieve mutual exclusion.

Uh, I was confused by the _blocking suffix.  But when used together with
splice you know it is not blocking---only the splice will block.

Paolo
