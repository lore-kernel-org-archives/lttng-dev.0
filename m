From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Make upper bound of
	kernel	version checking macro exclusive
Date: Tue, 27 Nov 2012 11:45:33 -0500
Message-ID: <20121127164533.GA27001__38538.9006733478$1354034863$gmane$org@Krystal>
References: <1354018913-14211-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TdOHw-0000eH-2I
	for lttng-dev@lists.lttng.org; Tue, 27 Nov 2012 11:45:36 -0500
Content-Disposition: inline
In-Reply-To: <1354018913-14211-1-git-send-email-andrew_gabbasov@mentor.com>
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
> It's more usable to have the upper limit exclusive. It helps to avoid
> hardcoding of stable branch highest version number, i.e. having a range
> from 3.1.0 up to 3.2.0 (exclusively) gives us all 3.1.x versions.
> 

Merged, thanks!

Mathieu

> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> ---
>  lttng-kernel-version.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
> index 280a398..0eb56b3 100644
> --- a/lttng-kernel-version.h
> +++ b/lttng-kernel-version.h
> @@ -27,10 +27,10 @@
>  
>  /*
>   * This macro checks if the kernel version is between the two specified
> - * versions (inclusive).
> + * versions (lower limit inclusive, upper limit exclusive).
>   */
>  #define LTTNG_KERNEL_RANGE(a_low, b_low, c_low, a_high, b_high, c_high) \
>  	(LINUX_VERSION_CODE >= KERNEL_VERSION(a_low, b_low, c_low) && \
> -	 LINUX_VERSION_CODE <= KERNEL_VERSION(a_high, b_high, c_high))
> +	 LINUX_VERSION_CODE < KERNEL_VERSION(a_high, b_high, c_high))
>  
>  #endif /* _LTTNG_KERNEL_VERSION_H */
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
