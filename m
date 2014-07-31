From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] x86: drop extra semi-colon in
	caa_cpu_relax
Date: Thu, 31 Jul 2014 19:59:33 +0000 (UTC)
Message-ID: <865912392.24056.1406836773592.JavaMail.zimbra__12700.7103911184$1406836839$gmane$org@efficios.com>
References: <20140731002151.GA32652@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XCwVi-0005mr-Q1
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 15:59:40 -0400
In-Reply-To: <20140731002151.GA32652@dcvr.yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Eric Wong" <normalperson@yhbt.net>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, July 30, 2014 8:21:51 PM
> Subject: [PATCH urcu] x86: drop extra semi-colon in caa_cpu_relax
> 
> This fixes compilation in braceless if/else constructs:
> 
> 	if (expr)
> 		caa_cpu_relax();
> 	else
> 		...
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   Btw, did you notice my rculfhash patches last month.
>   I just realize I forgot to Cc you directly.
>   Thanks for URCU!

Hi Eric,

Patch merged, thanks!

Yes, I've seen them in my inbox, but was unfortunately
very busy at the time. Thanks for the reminder!

Mathieu


> 
>  urcu/arch/x86.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/urcu/arch/x86.h b/urcu/arch/x86.h
> index 7af1ca5..ccc4ce8 100644
> --- a/urcu/arch/x86.h
> +++ b/urcu/arch/x86.h
> @@ -66,7 +66,7 @@ extern "C" {
>  #endif
>  #endif
>  
> -#define caa_cpu_relax()	__asm__ __volatile__ ("rep; nop" : : : "memory");
> +#define caa_cpu_relax()	__asm__ __volatile__ ("rep; nop" : : : "memory")
>  
>  #define rdtscll(val)							  \
>  	do {						  		  \
> --
> EW
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
