From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] test: test for the proper pointer
Date: Sat, 13 Oct 2012 12:44:02 -0400
Message-ID: <20121013164402.GE29985__5578.49748661301$1350146689$gmane$org@Krystal>
References: <1350144514-4132-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TN4om-0006qg-G2
	for lttng-dev@lists.lttng.org; Sat, 13 Oct 2012 12:44:04 -0400
Content-Disposition: inline
In-Reply-To: <1350144514-4132-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> We should use "if (snode)" instead of "if (node)" in case of
> the struct cds_lfs_node_rcu is not the first field of struct node.
> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>

merged, thanks!

Mathieu

> ---
>  tests/test_urcu_lfs.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/test_urcu_lfs.c b/tests/test_urcu_lfs.c
> index 88bf65d..681b654 100644
> --- a/tests/test_urcu_lfs.c
> +++ b/tests/test_urcu_lfs.c
> @@ -242,13 +242,14 @@ void *thr_dequeuer(void *_count)
>  
>  	for (;;) {
>  		struct cds_lfs_node_rcu *snode;
> -		struct test *node;
>  
>  		rcu_read_lock();
>  		snode = cds_lfs_pop_rcu(&s);
> -		node = caa_container_of(snode, struct test, list);
>  		rcu_read_unlock();
> -		if (node) {
> +		if (snode) {
> +			struct test *node;
> +
> +			node = caa_container_of(snode, struct test, list);
>  			call_rcu(&node->rcu, free_node_cb);
>  			URCU_TLS(nr_successful_dequeues)++;
>  		}
> -- 
> 1.7.7.6
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
