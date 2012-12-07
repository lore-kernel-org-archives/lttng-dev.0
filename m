From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/3] urcu: avoid "expression result
	unused"	from clang
Date: Fri, 7 Dec 2012 11:58:48 -0500
Message-ID: <20121207165848.GB12338__42773.3860946775$1354899574$gmane$org@Krystal>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Th1GD-00036n-PW
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 11:58:49 -0500
Content-Disposition: inline
In-Reply-To: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> The last expression result is unused and clang will complain.
> The trick in the patch supresses the complaint

Hrm, but with this patch, gcc complains:

rculfhash.c:1921:3: warning: variable '_w' set but not used
[-Wunused-but-set-variable]

using

gcc version 4.7.2 (Debian 4.7.2-4)

Thoughts ?

Thanks,

Mathieu

> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
>  urcu/system.h        |    5 ++++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/urcu/system.h b/urcu/system.h
> index 2a45f22..6b7b0af 100644
> --- a/urcu/system.h
> +++ b/urcu/system.h
> @@ -46,12 +46,15 @@
>  /*
>   * Store v into x, where x is located in shared memory. Performs the
>   * required cache flush after writing. Returns v.
> + * "_w" here avoids the warning from clang:
> + * 	warning: expression result unused [-Wunused-value]
>   */
>  #define CMM_STORE_SHARED(x, v)		\
>  	({				\
>  		__typeof__(x) _v = _CMM_STORE_SHARED(x, v);	\
> +		__typeof__(x) _w;	\
>  		cmm_smp_wmc();		\
> -		_v;			\
> +		_w = _v;		\
>  	})
>  
>  #endif /* _URCU_SYSTEM_H */
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
