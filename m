From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] urcu: add notice to URCU_TLS() for it
	is not	async-signal-safe
Date: Thu, 9 Aug 2012 10:14:17 -0400
Message-ID: <20120809141417.GC9064__23458.6024460897$1344521686$gmane$org@Krystal>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
	<1344414673-14714-2-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SzTVC-0002eQ-Cm
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:14:18 -0400
Content-Disposition: inline
In-Reply-To: <1344414673-14714-2-git-send-email-laijs@cn.fujitsu.com>
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
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
>  urcu/tls-compat.h |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/urcu/tls-compat.h b/urcu/tls-compat.h
> index 192a536..b7bf363 100644
> --- a/urcu/tls-compat.h
> +++ b/urcu/tls-compat.h
> @@ -59,6 +59,20 @@ extern "C" {
>  
>  #else /* #ifndef CONFIG_RCU_TLS */
>  
> +/*
> + * NOTE: URCU_TLS() is NOT async-signal-safe, you can't use it
> + * inside any function which can be called from signal handler.
> + *
> + * But if pthread_getspecific() is async-signal-safe in your
> + * platform, you can make URCU_TLS() async-signal-safe via:
> + * ensuring the first call to URCU_TLS() of a given TLS variable of
> + * all threads is called earliest from a non-signal handler function.
> + *
> + * Exmaple: In any thread, the first call of URCU_TLS(rcu_reader)
> + * is called from rcu_register_thread(), so we can ensure all later
> + * URCU_TLS(rcu_reader) in any thread is async-signal-safe.

Hrm. We could also just block all signals within type *__tls_access_ ##
name(void)  (in tls-compat.h) and make sure it is async-signal-safe I
guess ? I would prefer that solution: it would make the code more robust
for a rarely taken performance hit.

Thoughts ?

Thanks,

Mathieu

> + */
> +
>  # include <pthread.h>
>  
>  struct urcu_tls {
> -- 
> 1.7.4.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
