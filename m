From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Fix: Fallback mechanism not working on
	platform	where TLS is unsupported
Date: Thu, 8 Nov 2012 14:31:11 -0500
Message-ID: <20121108193111.GB20848__17050.4018934027$1352403103$gmane$org@Krystal>
References: <1352402005-26604-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWXom-0006L2-Rk
	for lttng-dev@lists.lttng.org; Thu, 08 Nov 2012 14:31:12 -0500
Content-Disposition: inline
In-Reply-To: <1352402005-26604-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> The CONFIG_RCU_TLS entry in config.h.in is defined by default to "TLS".
> This has the unfortunate consequence of defining CONFIG_RCU_TLS on platform
> where TLS is unsupported and effectively disabling the pthread based
> fallback mechanism. This macro should be #undef by default and the
> AX_TLS m4 macro will properly detect if TLS is supported.

merged, thanks!

Mathieu

> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  urcu/config.h.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/urcu/config.h.in b/urcu/config.h.in
> index de1d1d0..98ea365 100644
> --- a/urcu/config.h.in
> +++ b/urcu/config.h.in
> @@ -18,4 +18,4 @@
>  #undef CONFIG_RCU_ARM_HAVE_DMB
>  
>  /* TLS provided by the compiler. */
> -#define CONFIG_RCU_TLS TLS
> +#undef CONFIG_RCU_TLS
> -- 
> 1.8.0
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
