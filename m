From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] urcu-bp/urcu-qsbr: remove unneeded
	DEBUG_YIELD code
Date: Tue, 2 Dec 2014 13:04:49 +0000 (UTC)
Message-ID: <709695674.22224.1417525489274.JavaMail.zimbra__28449.1363367581$1417525535$gmane$org@efficios.com>
References: <1417512752-9711-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xvn8P-0002c7-5l
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 08:04:58 -0500
In-Reply-To: <1417512752-9711-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into master, thanks!

Mathieu

----- Original Message -----
> From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
> To: lttng-dev@lists.lttng.org, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Lai Jiangshan" <laijs@cn.fujitsu.com>
> Sent: Tuesday, December 2, 2014 4:32:32 AM
> Subject: [PATCH] urcu-bp/urcu-qsbr: remove unneeded DEBUG_YIELD code
> 
> They were moved to debug-yield.c
> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
>  urcu-bp.c   |    5 -----
>  urcu-qsbr.c |    5 -----
>  2 files changed, 0 insertions(+), 10 deletions(-)
> 
> diff --git a/urcu-bp.c b/urcu-bp.c
> index 1856d3f..6b2875d 100644
> --- a/urcu-bp.c
> +++ b/urcu-bp.c
> @@ -106,11 +106,6 @@ static int initialized;
>  
>  static pthread_key_t urcu_bp_key;
>  
> -#ifdef DEBUG_YIELD
> -unsigned int rcu_yield_active;
> -DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
> -#endif
> -
>  struct rcu_gp rcu_gp = { .ctr = RCU_GP_COUNT };
>  
>  /*
> diff --git a/urcu-qsbr.c b/urcu-qsbr.c
> index 71e7a39..a35dcfc 100644
> --- a/urcu-qsbr.c
> +++ b/urcu-qsbr.c
> @@ -66,11 +66,6 @@ struct rcu_gp rcu_gp = { .ctr = RCU_GP_ONLINE };
>   */
>  DEFINE_URCU_TLS(struct rcu_reader, rcu_reader);
>  
> -#ifdef DEBUG_YIELD
> -unsigned int rcu_yield_active;
> -DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
> -#endif
> -
>  static CDS_LIST_HEAD(registry);
>  
>  /*
> --
> 1.7.4.4
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
