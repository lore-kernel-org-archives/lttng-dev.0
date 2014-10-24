From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [urcu][PATCH] compiler: use __GNUC__ instead of
	the	undefined __GNUC_MAJOR__
Date: Fri, 24 Oct 2014 20:07:19 +0000 (UTC)
Message-ID: <465505776.1563.1414181239110.JavaMail.zimbra__9791.28129915825$1414181287$gmane$org@efficios.com>
References: <1413253885-7154-1-git-send-email-cota@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xhl8z-0002mF-E0
 for lttng-dev@lists.lttng.org; Fri, 24 Oct 2014 16:07:30 -0400
In-Reply-To: <1413253885-7154-1-git-send-email-cota@braap.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Emilio G. Cota" <cota@braap.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into master and stable-0.8, thanks!

Mathieu

----- Original Message -----
> From: "Emilio G. Cota" <cota@braap.org>
> To: lttng-dev@lists.lttng.org
> Sent: Monday, October 13, 2014 10:31:25 PM
> Subject: [lttng-dev] [urcu][PATCH] compiler: use __GNUC__ instead of the	undefined __GNUC_MAJOR__
> 
> gcc defines the major number with __GNUC__, not __GNUC_MAJOR__:
>   https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  urcu/compiler.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/urcu/compiler.h b/urcu/compiler.h
> index 1e30903..2e0237e 100644
> --- a/urcu/compiler.h
> +++ b/urcu/compiler.h
> @@ -97,8 +97,8 @@
>  		(unsigned long) (v))
>  
>  #if defined (__GNUC__) \
> -	&& ((__GNUC_MAJOR__ == 4) && (__GNUC_MINOR__ >= 5)	\
> -		|| __GNUC_MAJOR__ >= 5)
> +	&& ((__GNUC__ == 4) && (__GNUC_MINOR__ >= 5)	\
> +		|| __GNUC__ >= 5)
>  #define CDS_DEPRECATED(msg)	\
>  	__attribute__((deprecated(msg)))
>  #else
> --
> 1.8.3
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
