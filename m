From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Update using of
	kernel	version checking macro to new range
Date: Tue, 27 Nov 2012 11:45:45 -0500
Message-ID: <20121127164545.GB27001__8522.35240531645$1354034837$gmane$org@Krystal>
References: <1354018946-14252-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TdOI6-0000f7-5d
	for lttng-dev@lists.lttng.org; Tue, 27 Nov 2012 11:45:46 -0500
Content-Disposition: inline
In-Reply-To: <1354018946-14252-1-git-send-email-andrew_gabbasov@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Merged, thanks!

Mathieu

> ---
>  probes/lttng-probe-vmscan.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/probes/lttng-probe-vmscan.c b/probes/lttng-probe-vmscan.c
> index 0205c7e..4f5739c 100644
> --- a/probes/lttng-probe-vmscan.c
> +++ b/probes/lttng-probe-vmscan.c
> @@ -39,8 +39,8 @@
>  #define CREATE_TRACE_POINTS
>  #define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
>  
> -#if (LINUX_VERSION_CODE <= KERNEL_VERSION(3,0,38)) || \
> -	LTTNG_KERNEL_RANGE(3,1,0, 3,1,10)
> +#if ((LINUX_VERSION_CODE <= KERNEL_VERSION(3,0,38)) || \
> +	LTTNG_KERNEL_RANGE(3,1,0, 3,2,0))
>  typedef int isolate_mode_t;
>  #endif
>  
> -- 
> 1.7.10.4
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
