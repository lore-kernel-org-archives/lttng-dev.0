From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] urcu: add notice to URCU_TLS() for
	it	is not async-signal-safe
Date: Thu, 6 Sep 2012 19:07:25 -0400
Message-ID: <20120906230725.GA11601__43281.027270905$1346972879$gmane$org@Krystal>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
	<1344414673-14714-2-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9lAV-0000nH-Vq
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 19:07:27 -0400
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

Finally, I'm merging this patch, and I won't go for the signal-disabling
implementation, mainly because we have the same kind of behavior with
the TLS fixup for TLS variables in DSO. So this comment apply both to
the TLS and pthread getspecific implementation of the URCU_TLS, so I'm
moving it slightly higher in the header file.

Thanks!

Mathieu

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
> + */
> +
>  # include <pthread.h>
>  
>  struct urcu_tls {
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
