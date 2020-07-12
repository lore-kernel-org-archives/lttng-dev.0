From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH lttng-ust] Add ctor/dtor priorities for
 tracepoints/events
Date: Sun, 12 Jul 2020 09:49:34 -0400 (EDT)
Message-ID: <756801034.9565.1594561774215.JavaMail.zimbra@efficios.com>
References: <20200711152907.676582-1-olivier.dion@polymtl.ca>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4B4Snc4MYrz1TWx
 for <lttng-dev@lists.lttng.org>; Sun, 12 Jul 2020 09:49:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B9D32299A0D
 for <lttng-dev@lists.lttng.org>; Sun, 12 Jul 2020 09:49:34 -0400 (EDT)
In-Reply-To: <20200711152907.676582-1-olivier.dion@polymtl.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Olivier Dion <olivier.dion@polymtl.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 11, 2020, at 11:29 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Some library might want to generate events in their ctor/dtor.  If
> LTTng initialize/finalize its tracepoints/events at the wrong time,
> events are lost.
> 
> Order of execution of the ctor/dtor is determined by priority.  When
> some priorities are equal, the order of execution seems to be
> determined by:
> 
>	   a) Order of appearance if in the same compilation unit
> 
>	   b) Order of link if in different compilation units
> 
>	   c) Order of load by ld-linux.so or dlopen(3) for
>	      share objects

I recall different rules about constructor priorities. Can you provide
links to documentation stating the priority order you describe above ?

Also, we should compare two approaches to fulfill your goal:
one alternative would be to have application/library constructors
explicitly call tracepoint constructors if they wish to use them.

Thanks,

Mathieu

> 
> Also, using the constructor/destructor attributes without any priority
> will default to the _lowest_ priority 65535, at least for GCC.
> 
> Thus, Providing the LTTNG_*_PRIO definitions allows users to set their
> ctor/dtor priority like so:
> ----------------------------------------------------------------------
> ...
> __attribute__((constructor(LTTNG_CTOR_PRIO + 1)))
> ...
> __attribute__((destructor(LTTNG_DTOR_PRIO + 1)))
> ...
> ----------------------------------------------------------------------
> or without any priority, that would also work.
> 
> Note that LTTNG_*_PRIO are set to 101 because it is the _highest_
> priority and 0 to 100 are reserved.
> 
> Signed-off-by: Olivier Dion <olivier.dion@polymtl.ca>
> ---
> include/lttng/tracepoint.h           | 8 ++++----
> include/lttng/ust-compiler.h         | 7 +++++++
> include/lttng/ust-tracepoint-event.h | 4 ++--
> 3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index d77a2fb2..70903757 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -318,7 +318,7 @@ __tracepoint__init_urcu_sym(void)
> }
> #endif
> 
> -static void lttng_ust_notrace __attribute__((constructor))
> +static void lttng_ust_notrace __attribute__((constructor(LTTNG_CTOR_PRIO)))
> __tracepoints__init(void);
> static void
> __tracepoints__init(void)
> @@ -340,7 +340,7 @@ __tracepoints__init(void)
> 	__tracepoint__init_urcu_sym();
> }
> 
> -static void lttng_ust_notrace __attribute__((destructor))
> +static void lttng_ust_notrace __attribute__((destructor(LTTNG_DTOR_PRIO)))
> __tracepoints__destroy(void);
> static void
> __tracepoints__destroy(void)
> @@ -444,7 +444,7 @@ extern struct lttng_ust_tracepoint * const
> __stop___tracepoints_ptrs[]
> 		__attribute__((used, section("__tracepoints_ptrs"))) =		\
> 			&__tracepoint_##_provider##___##_name;
> 
> -static void lttng_ust_notrace __attribute__((constructor))
> +static void lttng_ust_notrace __attribute__((constructor(LTTNG_CTOR_PRIO)))
> __tracepoints__ptrs_init(void);
> static void
> __tracepoints__ptrs_init(void)
> @@ -488,7 +488,7 @@ __tracepoints__ptrs_init(void)
> 	}
> }
> 
> -static void lttng_ust_notrace __attribute__((destructor))
> +static void lttng_ust_notrace __attribute__((destructor(LTTNG_DTOR_PRIO)))
> __tracepoints__ptrs_destroy(void);
> static void
> __tracepoints__ptrs_destroy(void)
> diff --git a/include/lttng/ust-compiler.h b/include/lttng/ust-compiler.h
> index 1d04da1a..4f1b1a40 100644
> --- a/include/lttng/ust-compiler.h
> +++ b/include/lttng/ust-compiler.h
> @@ -27,4 +27,11 @@
> #define lttng_ust_notrace __attribute__((no_instrument_function))
> #define LTTNG_PACKED	__attribute__((__packed__))
> 
> +/*
> + * Value in range [0, 100] are reserved.  Thus 101 is the higest
> + * priority that can be used.
> + */
> +#define LTTNG_CTOR_PRIO 101
> +#define LTTNG_DTOR_PRIO 101
> +
> #endif /* _LTTNG_UST_COMPILER_H */
> diff --git a/include/lttng/ust-tracepoint-event.h
> b/include/lttng/ust-tracepoint-event.h
> index 7890c247..cd45ae08 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -1009,7 +1009,7 @@ static int
> _TP_COMBINE_TOKENS(__probe_register_refcount___, TRACEPOINT_PROVIDER)
> 
> /* Reset all macros within TRACEPOINT_EVENT */
> #include <lttng/ust-tracepoint-event-reset.h>
> -static void lttng_ust_notrace __attribute__((constructor))
> +static void lttng_ust_notrace __attribute__((constructor(LTTNG_CTOR_PRIO)))
> _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void);
> static void
> _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
> @@ -1036,7 +1036,7 @@ _TP_COMBINE_TOKENS(__lttng_events_init__,
> TRACEPOINT_PROVIDER)(void)
> 	}
> }
> 
> -static void lttng_ust_notrace __attribute__((destructor))
> +static void lttng_ust_notrace __attribute__((destructor(LTTNG_DTOR_PRIO)))
> _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void);
> static void
> _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)
> --
> 2.27.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
