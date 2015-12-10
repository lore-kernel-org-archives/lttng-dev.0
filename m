From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Use generic
	irqs_disabled_flags
Date: Thu, 10 Dec 2015 12:56:31 +0000 (UTC)
Message-ID: <1963287036.231122.1449752191524.JavaMail.zimbra__43655.171924229$1449752255$gmane$org@efficios.com>
References: <1449699919-26929-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a70lw-00022c-OA
 for lttng-dev@lists.lttng.org; Thu, 10 Dec 2015 07:56:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0903E3403BF
 for <lttng-dev@lists.lttng.org>; Thu, 10 Dec 2015 12:56:33 +0000 (UTC)
In-Reply-To: <1449699919-26929-1-git-send-email-mjeanson@efficios.com>
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

----- On Dec 9, 2015, at 5:25 PM, Michael Jeanson mjeanson@efficios.com wrote:

> instead of arch_irqs_disabled_flags, this fixes the build for kernel < 2.6.37
> 
> See linux commit df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 for more details.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> wrapper/irqflags.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wrapper/irqflags.h b/wrapper/irqflags.h
> index 77f8382..74c340b 100644
> --- a/wrapper/irqflags.h
> +++ b/wrapper/irqflags.h
> @@ -33,7 +33,7 @@ int lttng_regs_irqs_disabled(struct pt_regs *regs)
> {
> 	unsigned long flags = regs->flags;
> 
> -	return arch_irqs_disabled_flags(flags);
> +	return irqs_disabled_flags(flags);

Can you try with raw_irqs_disabled_flags(flags) instead ?

The non-raw version comes with tracing, and I don't want to invoke
tracing from within the tracer, which could cause infinite recursion
if this instrumentation gets enabled.

Thanks,

Mathieu

> }
> 
> #else
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
