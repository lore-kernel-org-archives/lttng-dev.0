From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] urcu: fix deprecation warning with new glibc
Date: Mon, 1 Jun 2015 14:25:37 +0000 (UTC)
Message-ID: <1237864258.1418.1433168737082.JavaMail.zimbra__13192.1044471257$1433168854$gmane$org@efficios.com>
References: <1433164590-9078-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YzQf3-0006YI-P7
 for lttng-dev@lists.lttng.org; Mon, 01 Jun 2015 10:26:03 -0400
In-Reply-To: <1433164590-9078-1-git-send-email-mkl@pengutronix.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 1, 2015, at 3:16 PM, Marc Kleine-Budde mkl@pengutronix.de wrote:

> This patch fixes the following warning:
> 
> /usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVID_SOURCE
> are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
> # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_SOURCE"

And why does this patch just add _DEFAULT_SOURCE without removing _BSD_SOURCE ?
Is it the intended transition path ? Is it documented somewhere ?

Thanks,

Mathieu

> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> urcu.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/urcu.c b/urcu.c
> index 1429f6dfbbd3..6f5b1e01ea04 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -26,6 +26,7 @@
> #define _BSD_SOURCE
> #define _GNU_SOURCE
> #define _LGPL_SOURCE
> +#define _DEFAULT_SOURCE
> #include <stdio.h>
> #include <pthread.h>
> #include <signal.h>
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
