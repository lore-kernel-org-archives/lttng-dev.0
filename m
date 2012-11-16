From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] wfcqueue: Fix lock and unlock functions
Date: Thu, 15 Nov 2012 22:08:19 -0500
Message-ID: <20121116030819.GB21972__4312.70795311338$1353035353$gmane$org@Krystal>
References: <20121116002412.GA32432@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TZCI0-00010p-LC
	for lttng-dev@lists.lttng.org; Thu, 15 Nov 2012 22:08:20 -0500
Content-Disposition: inline
In-Reply-To: <20121116002412.GA32432@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: eag0628@gmail.com, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> The current implementation of cds_wfcq_dequeue_lock() and
> cds_wfcq_dequeue_unlock() entails mutually assured recursion.
> Redirect to _cds_wfcq_dequeue_lock() and _cds_wfcq_dequeue_unlock(),
> respectively.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Good catch !!

Merged, thanks!

Mathieu

> 
> diff --git a/wfcqueue.c b/wfcqueue.c
> index 3474ee0..90b810e 100644
> --- a/wfcqueue.c
> +++ b/wfcqueue.c
> @@ -57,13 +57,13 @@ void cds_wfcq_enqueue(struct cds_wfcq_head *head,
>  void cds_wfcq_dequeue_lock(struct cds_wfcq_head *head,
>  		struct cds_wfcq_tail *tail)
>  {
> -	cds_wfcq_dequeue_lock(head, tail);
> +	_cds_wfcq_dequeue_lock(head, tail);
>  }
>  
>  void cds_wfcq_dequeue_unlock(struct cds_wfcq_head *head,
>  		struct cds_wfcq_tail *tail)
>  {
> -	cds_wfcq_dequeue_unlock(head, tail);
> +	_cds_wfcq_dequeue_unlock(head, tail);
>  }
>  
>  struct cds_wfcq_node *cds_wfcq_dequeue_blocking(
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
