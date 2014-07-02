From: Martin Townsend <martin.townsend@xsilon.com>
Subject: Re: lttng-tools compilation error v2.5.0 rc1
Date: Wed, 02 Jul 2014 10:48:29 +0100
Message-ID: <53B3D56D.8040009__18849.6538009078$1404294557$gmane$org@xsilon.com>
References: <53AD6327.3080501@xsilon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.kundenserver.de ([212.227.126.130])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martin.townsend@xsilon.com>) id 1X2H9a-0003v0-1c
 for lttng-dev@lists.lttng.org; Wed, 02 Jul 2014 05:48:39 -0400
In-Reply-To: <53AD6327.3080501@xsilon.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Any update on this?

Best Regards,
Martin.

On 27/06/14 13:27, Martin Townsend wrote:
> Hi,
>
> I updated to version 2.5.0 rc1 today and found that I couldn't build 
> lttng-tools for my Microblaze based system.
>
> | error.c: In function 'log_add_time':
> | error.c:52:17: error: 'error_log_time' undeclared (first use in this 
> function)
> |   ret = snprintf(error_log_time.str, sizeof(error_log_time.str),
> |                  ^
> | error.c:52:17: note: each undeclared identifier is reported only 
> once for each function it appears in
> | make[3]: *** [error.lo] Error 1
> | make[3]: *** Waiting for unfinished jobs....
>
> After grepping URCU_TLS in the source I could see it was used 
> elsewhere with accessor macros so I used the following patch which 
> fixes the compiler error.
>
> I'm not familiar with the code so I was wondering if this is the 
> correct fix?
>
> Best Regards,
> Martin
>
> From 8a2789962fb22e92f8e9b46747c4d56cdaae04ca Mon Sep 17 00:00:00 2001
> From: Martin Townsend <martin.townsend@xsilon.com>
> Date: Fri, 27 Jun 2014 11:41:03 +0100
> Subject: [PATCH] fixed compile error mising URCU_TLS
>
> ---
>  src/common/error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/common/error.c b/src/common/error.c
> index 418fc47..92852f9 100644
> --- a/src/common/error.c
> +++ b/src/common/error.c
> @@ -49,14 +49,14 @@ const char *log_add_time(void)
>      }
>
>      /* Format time in the TLS variable. */
> -    ret = snprintf(error_log_time.str, sizeof(error_log_time.str),
> +    ret = snprintf(URCU_TLS(error_log_time).str, 
> sizeof(URCU_TLS(error_log_time).str),
>              "%02d:%02d:%02d.%06ld",
>              tm.tm_hour, tm.tm_min, tm.tm_sec, tp.tv_nsec);
>      if (ret < 0) {
>          goto error;
>      }
>
> -    return error_log_time.str;
> +    return URCU_TLS(error_log_time).str;
>
>  error:
>      /* Return an empty string on error so logging is not affected. */
