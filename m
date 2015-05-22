From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-modules PATCH] Fix: Update kmem event for
 recent	Ubuntu kernel
Date: Fri, 22 May 2015 19:43:06 +0000 (UTC)
Message-ID: <121533344.6379.1432323786856.JavaMail.zimbra__11320.0116939426$1432323873$gmane$org@efficios.com>
References: <1432319813-6978-1-git-send-email-alexmonthy@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yvsqc-0007B5-Tf
 for lttng-dev@lists.lttng.org; Fri, 22 May 2015 15:43:19 -0400
In-Reply-To: <1432319813-6978-1-git-send-email-alexmonthy@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into stable-2.6 and master, thanks!

Mathieu

----- Original Message -----
> Ubuntu backported a patch into their 3.13 (Trusty) branch which
> changes kmem event definition.
> 
> Upstream commit
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=99592d598eca62bdbbf62b59941c189176dfc614
> first appears in 4.0 (and was later backported to 3.19.2).
> We already have the proper check for this.
> 
> This corresponds to Ubuntu commit
> http://kernel.ubuntu.com/git/ubuntu/ubuntu-trusty.git/commit/?id=d938e4bff1089a1f4757ed94a5cace803c6a363b
> which was first released with 3.13.0-50.82.
> This required adding a new check specifically for the
> Ubuntu version.
> 
> Signed-off-by: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
> ---
>  instrumentation/events/lttng-module/kmem.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/kmem.h
> b/instrumentation/events/lttng-module/kmem.h
> index ee83d38..1d4eb62 100644
> --- a/instrumentation/events/lttng-module/kmem.h
> +++ b/instrumentation/events/lttng-module/kmem.h
> @@ -202,7 +202,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page,
> mm_page_pcpu_drain,
>  
>  #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)	\
>  	|| LTTNG_KERNEL_RANGE(3,14,36, 3,15,0)		\
> -	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0))
> +	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0)	\
> +	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,0,50, 3,14,0,0))
>  
>  LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
>  
> --
> 2.1.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
