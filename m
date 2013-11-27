From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 4/5] Fix: Do not redefine gettid on
	Android
Date: Wed, 27 Nov 2013 09:34:13 +0000 (UTC)
Message-ID: <619278900.76525.1385544853544.JavaMail.zimbra__45397.7121775553$1385544904$gmane$org@efficios.com>
References: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385528902-4797-4-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlbVe-0005hn-B2
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 04:34:15 -0500
In-Reply-To: <1385528902-4797-4-git-send-email-charlesbriere.flatzo@gmail.com>
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
> Sent: Wednesday, November 27, 2013 12:08:21 AM
> Subject: [PATCH liburcu 4/5] Fix: Do not redefine gettid on Android
> 
> Bionic already defines gettid through <unistd.h>
> 
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  tests/common/thread-id.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
> index bad3006..a2c9e3a 100644
> --- a/tests/common/thread-id.h
> +++ b/tests/common/thread-id.h
> @@ -42,6 +42,9 @@ unsigned long urcu_get_thread_id(void)
>  {
>  	return (unsigned long) pthread_getthreadid_np();
>  }
> +#elif defined(__Android__)
> +// Do not redefine gettid() as it is already included
> +// in bionic through <unistd.h>

Please use

/*
 * blah
 * blah blah
 */

style comments,

Thanks,

Mathieu

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
