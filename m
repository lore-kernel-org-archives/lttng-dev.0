From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/2] Add FreeBSD,
 DragonFly to syscall-compat.h
Date: Thu, 30 Jan 2020 13:33:33 -0500 (EST)
Message-ID: <2101491926.603875.1580409213914.JavaMail.zimbra@efficios.com>
References: <20200127200830.29347-1-alex_y_xu.ref@yahoo.ca>
 <20200127200830.29347-1-alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 487prv0F73z22jx
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2020 13:33:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4B64E251DF6
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2020 13:33:34 -0500 (EST)
In-Reply-To: <20200127200830.29347-1-alex_y_xu@yahoo.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alex Xu <alex_y_xu@yahoo.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
List-Id: lttng-dev@lists.lttng.org

Merged into liburcu master, thanks!

Mathieu

----- On Jan 27, 2020, at 3:08 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> ---
> include/urcu/syscall-compat.h | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/urcu/syscall-compat.h b/include/urcu/syscall-compat.h
> index fa63a7b..23b266e 100644
> --- a/include/urcu/syscall-compat.h
> +++ b/include/urcu/syscall-compat.h
> @@ -32,8 +32,9 @@
> #elif defined(__linux__) || defined(__GLIBC__)
> #include <syscall.h>
> 
> -#elif defined(__CYGWIN__) || defined(__APPLE__)
> -/* Don't include anything on Cygwin or MacOSX. */
> +#elif defined(__CYGWIN__) || defined(__APPLE__) || \
> +	defined(__FreeBSD__) || defined(__DragonFly__)
> +/* Don't include anything on these platforms. */
> 
> #else
> #error "Add platform support to urcu/syscall-compat.h"
> --
> 2.25.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
