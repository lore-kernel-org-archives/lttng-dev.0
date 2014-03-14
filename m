From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add 'unused' attribute to
	tracepoint callback
Date: Fri, 14 Mar 2014 13:39:49 +0000 (UTC)
Message-ID: <1459426645.3276.1394804389944.JavaMail.zimbra__45434.463726315$1394804452$gmane$org@efficios.com>
References: <1394803401-32171-1-git-send-email-zifeitong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WOSL1-0006un-4c
	for lttng-dev@lists.lttng.org; Fri, 14 Mar 2014 09:39:57 -0400
In-Reply-To: <1394803401-32171-1-git-send-email-zifeitong@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <zifeitong@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Zifei Tong" <zifeitong@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Zifei Tong" <zifeitong@gmail.com>
> Sent: Friday, March 14, 2014 9:23:21 AM
> Subject: [PATCH lttng-ust] Add 'unused' attribute to tracepoint callback
> 
> Compiling tracepoint provider with clang generates 'Wunused-function'
> warnings. Add 'unused' attribute to silence these warnings.
> 
> Fixes #760
> 
> Signed-off-by: Zifei Tong <zifeitong@gmail.com>
> ---
>  include/lttng/tracepoint.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index 66e2abd..c5a09d8 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -152,7 +152,7 @@ extern "C" {
>   */
>  #define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
>  extern struct tracepoint __tracepoint_##_provider##___##_name;				\
> -static inline __attribute__((always_inline)) lttng_ust_notrace				\
> +static inline __attribute__((always_inline, unused)) lttng_ust_notrace			\
>  void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__));
>  		\
>  static											\
>  void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__))		\
> --
> 1.9.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
