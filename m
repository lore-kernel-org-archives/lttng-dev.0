From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] urcu: add hint to DEFINE_URCU_TLS() for
	compound	types
Date: Thu, 9 Aug 2012 10:11:21 -0400
Message-ID: <20120809141121.GB9064__31454.0469357327$1344521515$gmane$org@Krystal>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SzTSN-0002c8-0G
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:11:23 -0400
Content-Disposition: inline
In-Reply-To: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, eag0628@gmail.com
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> Just a hint.

merged, thanks!

Mathieu

> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
>  urcu/tls-compat.h |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/urcu/tls-compat.h b/urcu/tls-compat.h
> index 9686eca..192a536 100644
> --- a/urcu/tls-compat.h
> +++ b/urcu/tls-compat.h
> @@ -34,6 +34,21 @@ extern "C" {
>  
>  #ifdef CONFIG_RCU_TLS	/* Based on ax_tls.m4 */
>  
> +/*
> + * Hint: How to define/declare TLS variables of compound types
> + *       such as array or function pointers?
> + *
> + * Answer: Use typedef to assign a type_name to the compound type.
> + * Example: Define a TLS variable which is an int array with len=4:
> + *
> + * 	typedef int my_int_array_type[4];
> + * 	DEFINE_URCU_TLS(my_int_array_type, var_name);
> + *
> + * Another exmaple:
> + * 	typedef void (*call_rcu_flavor)(struct rcu_head *, XXXX);
> + * 	DECLARE_URCU_TLS(call_rcu_flavor, p_call_rcu);
> + */
> +
>  # define DECLARE_URCU_TLS(type, name)	\
>  	CONFIG_RCU_TLS type name
>  
> -- 
> 1.7.4.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
