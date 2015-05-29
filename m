From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Update kmem event
	for	Ubuntu's 3.16 kernel too
Date: Fri, 29 May 2015 20:24:13 +0000 (UTC)
Message-ID: <1307631030.105.1432931053011.JavaMail.zimbra__26304.4769912542$1432931127$gmane$org@efficios.com>
References: <1432671120-15661-1-git-send-email-alexmonthy@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YyQpR-0003h3-Lg
 for lttng-dev@lists.lttng.org; Fri, 29 May 2015 16:24:36 -0400
In-Reply-To: <1432671120-15661-1-git-send-email-alexmonthy@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

----- On May 26, 2015, at 4:12 PM, Alexandre Montplaisir alexmonthy@voxpopuli.im wrote:

> The upstream patch in question in commit 72906e1 was also
> cherry-picked into Ubuntu's 3.16 kernel backport branch
> (called lts-utopic).
> The version check should also include this branch.
> 
> The other backport branch, lts-vivid, and all following ones
> will be covered by the standard
> 
>  LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)
> 
> check, so should not require other workarounds.
> 
> References #889.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> ---
> instrumentation/events/lttng-module/kmem.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/kmem.h
> b/instrumentation/events/lttng-module/kmem.h
> index 1d4eb62..6461788 100644
> --- a/instrumentation/events/lttng-module/kmem.h
> +++ b/instrumentation/events/lttng-module/kmem.h
> @@ -203,7 +203,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page,
> mm_page_pcpu_drain,
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)	\
> 	|| LTTNG_KERNEL_RANGE(3,14,36, 3,15,0)		\
> 	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0)	\
> -	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,0,50, 3,14,0,0))
> +	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,0,50, 3,14,0,0)	\
> +	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,0,38, 3,17,0,0))
> 
> LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
> 
> --
> 2.1.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
