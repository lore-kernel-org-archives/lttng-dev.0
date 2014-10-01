From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH 1/4] Introduce macros to check
 Ubuntu kernel version
Date: Wed, 1 Oct 2014 15:14:16 +0000 (UTC)
Message-ID: <1159337512.1717.1412176456144.JavaMail.zimbra__33074.9228051447$1412176526$gmane$org@efficios.com>
References: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XZLbp-0004oK-FA
 for lttng-dev@lists.lttng.org; Wed, 01 Oct 2014 11:14:37 -0400
In-Reply-To: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Whole series merged, thanks!

Mathieu

----- Original Message -----
> From: "Julien Desfossez" <jdesfossez@efficios.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez" <jdesfossez@efficios.com>
> Sent: Wednesday, October 1, 2014 11:05:08 AM
> Subject: [MODULES PATCH 1/4] Introduce macros to check Ubuntu kernel version
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  lttng-kernel-version.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
> index 0eb56b3..3958d74 100644
> --- a/lttng-kernel-version.h
> +++ b/lttng-kernel-version.h
> @@ -24,6 +24,7 @@
>   */
>  
>  #include <linux/version.h>
> +#include <linux/vermagic.h>
>  
>  /*
>   * This macro checks if the kernel version is between the two specified
> @@ -33,4 +34,18 @@
>  	(LINUX_VERSION_CODE >= KERNEL_VERSION(a_low, b_low, c_low) && \
>  	 LINUX_VERSION_CODE < KERNEL_VERSION(a_high, b_high, c_high))
>  
> +#define LTTNG_UBUNTU_KERNEL_VERSION(a,b,c,d) \
> +	(((a) << 24) + ((b) << 16) + (c << 8) + (d))
> +
> +#define LTTNG_UBUNTU_VERSION_CODE \
> +	((LINUX_VERSION_CODE << 8) + UTS_UBUNTU_RELEASE_ABI)
> +
> +#define LTTNG_UBUNTU_KERNEL_RANGE(a_low, b_low, c_low, d_low, \
> +		a_high, b_high, c_high, d_high) \
> +	(defined(UTS_UBUNTU_RELEASE_ABI) && \
> +		LTTNG_UBUNTU_VERSION_CODE >= \
> +		LTTNG_UBUNTU_KERNEL_VERSION(a_low, b_low, c_low, d_low) && \
> +		LTTNG_UBUNTU_VERSION_CODE < \
> +		LTTNG_UBUNTU_KERNEL_VERSION(a_high, b_high, c_high, d_high))
> +
>  #endif /* _LTTNG_KERNEL_VERSION_H */
> --
> 1.9.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
