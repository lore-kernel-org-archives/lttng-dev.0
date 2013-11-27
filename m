From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 4/5] Fix: Do not redefine gettid on
	Android
Date: Wed, 27 Nov 2013 16:09:36 +0000 (UTC)
Message-ID: <1654904571.76707.1385568576182.JavaMail.zimbra__43608.4142573693$1385568642$gmane$org@efficios.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-4-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlhgG-0003JM-FK
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 11:09:43 -0500
In-Reply-To: <1385567313-8138-4-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Charles Briere" <charlesbriere.flatzo@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Charles Briere" <charlesbriere.flatzo@gmail.com>
> Sent: Wednesday, November 27, 2013 10:48:32 AM
> Subject: [PATCH liburcu 4/5] Fix: Do not redefine gettid on Android
> 
> Bionic already defines gettid through <unistd.h>
> 
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  tests/common/thread-id.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
> index bad3006..b89a100 100644
> --- a/tests/common/thread-id.h
> +++ b/tests/common/thread-id.h
> @@ -42,6 +42,11 @@ unsigned long urcu_get_thread_id(void)
>  {
>  	return (unsigned long) pthread_getthreadid_np();
>  }
> +#elif defined(__Android__)
> +/*

I removed a whitespace at the end of this line.

Thanks,

Mathieu

> + * Do not redefine gettid() as it is already included
> + * in bionic through <unistd.h>
> + */
>  #else
>  # warning "use pid as thread ID"
>  static inline
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
