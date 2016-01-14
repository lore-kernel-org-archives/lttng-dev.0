From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Fix: RHEL 7.2 kvm
	instrumentation
Date: Thu, 14 Jan 2016 19:56:02 +0000 (UTC)
Message-ID: <666432530.346102.1452801362823.JavaMail.zimbra__40269.9288134047$1452801432$gmane$org@efficios.com>
References: <1452800147-4002-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aJo06-0001uD-Ux
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 14:56:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F19F334031F
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jan 2016 19:56:03 +0000 (UTC)
In-Reply-To: <1452800147-4002-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

patch 1 and 2 merged into master and stable-2.7, thanks!

Mathieu

----- On Jan 14, 2016, at 2:35 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/kvm.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/kvm.h
> b/instrumentation/events/lttng-module/kvm.h
> index 87d605c..cb73011 100644
> --- a/instrumentation/events/lttng-module/kvm.h
> +++ b/instrumentation/events/lttng-module/kvm.h
> @@ -111,7 +111,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_fpu,
> 	)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) \
> +	|| LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
> 
> LTTNG_TRACEPOINT_EVENT(kvm_age_page,
> 	TP_PROTO(ulong gfn, int level, struct kvm_memory_slot *slot, int ref),
> --
> 2.7.0.rc3

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
