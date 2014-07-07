From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add lttng_ust_notrace to static
 inline functions
Date: Mon, 7 Jul 2014 14:57:36 +0000 (UTC)
Message-ID: <1716559010.9467.1404745056024.JavaMail.zimbra__12012.1476044462$1404745106$gmane$org@efficios.com>
References: <1404741861-26337-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X4AMN-00087Z-6J
 for lttng-dev@lists.lttng.org; Mon, 07 Jul 2014 10:57:41 -0400
In-Reply-To: <1404741861-26337-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into master and stable-2.4, thanks!

Mathieu

----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Paul Woegerer" <paul_woegerer@mentor.com>
> Sent: Monday, July 7, 2014 10:04:21 AM
> Subject: [PATCH lttng-ust] Add lttng_ust_notrace to static inline functions
> 
> The static inline functions
> __tracepoint_provider_mismatch_<TRACEPOINT_PROVIDER> and
> __tracepoint_provider_check_<TRACEPOINT_PROVIDER> are missing the
> lttng_ust_notrace attribute to prevent them from getting instrumented
> with -finstrument-functions (if e.g. defined in CFLAGS). This patch is
> adding the attribute to those functions.
> 
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  include/lttng/ust-tracepoint-event.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/lttng/ust-tracepoint-event.h
> b/include/lttng/ust-tracepoint-event.h
> index d12e8bb..8895310 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -75,6 +75,8 @@
>  /* Reset all macros within TRACEPOINT_EVENT */
>  #include <lttng/ust-tracepoint-event-reset.h>
>  
> +static inline lttng_ust_notrace
> +void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_,
> TRACEPOINT_PROVIDER)(void);
>  static inline
>  void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_,
>  TRACEPOINT_PROVIDER)(void)
>  {
> @@ -88,6 +90,8 @@ void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_,
> TRACEPOINT_PROVIDER)(vo
>  #define TRACEPOINT_EVENT_INSTANCE(_provider, _template, _name, _args)	\
>  	__tracepoint_provider_mismatch_##_provider();
>  
> +static inline lttng_ust_notrace
> +void _TP_COMBINE_TOKENS(__tracepoint_provider_check_,
> TRACEPOINT_PROVIDER)(void);
>  static inline
>  void _TP_COMBINE_TOKENS(__tracepoint_provider_check_,
>  TRACEPOINT_PROVIDER)(void)
>  {
> --
> 2.0.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
