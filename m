From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: notrace missing in lttng-ust
Date: Tue, 17 Jul 2012 10:13:01 -0400
Message-ID: <20120717141301.GA21204__11902.1270693795$1342534412$gmane$org@Krystal>
References: <4FED6718.1000205@mentor.com> <20120630181600.GB30747@Krystal>
	<4FF2A31D.9020100@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sr8WN-0007hz-Un
	for lttng-dev@lists.lttng.org; Tue, 17 Jul 2012 10:13:04 -0400
Content-Disposition: inline
In-Reply-To: <4FF2A31D.9020100@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> Hi Mathieu,
>
> here is the revised patch that makes tracepoint.h and  
> ust-tracepoint-event.h robust against -finstrument-functions.
> I tested it against our small ackermann sample (3 custom tracepoints +  
> -finstrument-functions). See screenshots.
>
> Btw, nice macro metaprogramming in ust-tracepoint-event.h :)

Some feedback, sorry for the delay, I've been busy working on filtering,

[...]


> From 29ce637941c1e3efefb2b5a82c2683c57f583ac1 Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Tue, 3 Jul 2012 09:28:24 +0200
> Subject: [PATCH] Make lttng-ust robust against -finstrument-functions.
> 
> ---
>  configure.ac                         |   12 ++++++++++++
>  include/lttng/ringbuffer-config.h    |   20 ++++++++++++++++++++
>  include/lttng/tracepoint.h           |   11 +++++++++++
>  include/lttng/ust-config.h.in        |    3 +++
>  include/lttng/ust-tracepoint-event.h |   11 +++++++++++
>  5 files changed, 57 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index edd3c20..b12216f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -21,6 +21,7 @@ AC_CONFIG_SRCDIR([include/lttng/tracepoint.h])
>  AC_CONFIG_HEADERS([config.h include/lttng/ust-config.h])
>  AH_TEMPLATE([LTTNG_UST_HAVE_EFFICIENT_UNALIGNED_ACCESS], [Use efficient unaligned access.])
>  AH_TEMPLATE([LTTNG_UST_HAVE_SDT_INTEGRATION], [SystemTap integration via sdt.h])
> +AH_TEMPLATE([LTTNG_NOTRACE], [Prevent -finstrument-functions instrumentation])

I think we want to make the notrace always active. I don't see the point
in letting UST lib be compiled with those tracing stubs in place.

>  
>  # Compute minor/major/patchlevel version numbers
>  AC_PROG_SED
> @@ -264,6 +265,17 @@ AS_IF([test "x$with_sdt" = "xyes"],[
>  	])
>  ])
>  
> +instrument_func_save_cflags="$CFLAGS"
> +CFLAGS=-finstrument-functions
> +AC_MSG_CHECKING([whether CC supports -finstrument-functions])
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([])],[
> +	AC_MSG_RESULT([yes])
> +	AC_DEFINE([LTTNG_NOTRACE], [__attribute__((no_instrument_function))])
> +],[
> +	AC_MSG_RESULT([no])
> +])
> +CFLAGS="$instrument_func_save_cflags"

Well, pretty much all recent gcc and compilers supporting gcc extensions
like llvm seem to support the no_instrument_function attribute. I'd be
tempted to remove this stuff from configure.ac and assume
__attribute__((no_instrument_function)) can be used. We'll manage if we
see that it breaks compilers we care about.

We should create a include/lttng/ust-compiler.h with:

#define lttng_ust_notrace __attribute__((no_instrument_function))

so we don't duplicate the define.

> +
>  #currently disabled.
>  	#tests/hello2/Makefile
>  	#tests/basic/Makefile
> diff --git a/include/lttng/ringbuffer-config.h b/include/lttng/ringbuffer-config.h
> index 24e7dbe..232e754 100644
> --- a/include/lttng/ringbuffer-config.h
> +++ b/include/lttng/ringbuffer-config.h
> @@ -219,6 +219,10 @@ struct lttng_ust_lib_ring_buffer_ctx {
>  	char padding[LTTNG_UST_RING_BUFFER_CTX_PADDING];
>  };
>  
> +#ifndef LTTNG_NOTRACE
> +#define LTTNG_NOTRACE
> +#endif
> +
>  /**
>   * lib_ring_buffer_ctx_init - initialize ring buffer context
>   * @ctx: ring buffer context to initialize
> @@ -232,6 +236,11 @@ static inline
>  void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>  			      struct channel *chan, void *priv,
>  			      size_t data_size, int largest_align,
> +			      int cpu, struct lttng_ust_shm_handle *handle) LTTNG_NOTRACE;
> +static inline
> +void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
> +			      struct channel *chan, void *priv,
> +			      size_t data_size, int largest_align,
>  			      int cpu, struct lttng_ust_shm_handle *handle)

Can't we simply specify the attribute on the function definition, rather
than having to duplicate its prototype ?

Thanks,

Mathieu

>  {
>  	ctx->chan = chan;
> @@ -276,6 +285,8 @@ void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>   * size_of_type must be non-zero.
>   */
>  static inline
> +unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_type) LTTNG_NOTRACE;
> +static inline
>  unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_type)
>  {
>  	return offset_align(align_drift, size_of_type);
> @@ -290,6 +301,8 @@ unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_type)
>   * size_of_type must be non-zero.
>   */
>  static inline
> +unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_type) LTTNG_NOTRACE;
> +static inline
>  unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_type)
>  {
>  	return 0;
> @@ -303,6 +316,9 @@ unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_type)
>   */
>  static inline
>  void lib_ring_buffer_align_ctx(struct lttng_ust_lib_ring_buffer_ctx *ctx,
> +			   size_t alignment) LTTNG_NOTRACE;
> +static inline
> +void lib_ring_buffer_align_ctx(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>  			   size_t alignment)
>  {
>  	ctx->buf_offset += lib_ring_buffer_align(ctx->buf_offset,
> @@ -316,6 +332,10 @@ void lib_ring_buffer_align_ctx(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>  static inline
>  int lib_ring_buffer_check_config(const struct lttng_ust_lib_ring_buffer_config *config,
>  			     unsigned int switch_timer_interval,
> +			     unsigned int read_timer_interval) LTTNG_NOTRACE;
> +static inline
> +int lib_ring_buffer_check_config(const struct lttng_ust_lib_ring_buffer_config *config,
> +			     unsigned int switch_timer_interval,
>  			     unsigned int read_timer_interval)
>  {
>  	if (config->alloc == RING_BUFFER_ALLOC_GLOBAL
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index 5bab476..855b022 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -23,6 +23,10 @@
>  #include <assert.h>
>  #include <lttng/ust-config.h>	/* for sdt */
>  
> +#ifndef LTTNG_NOTRACE
> +#define LTTNG_NOTRACE
> +#endif
> +
>  #ifdef LTTNG_UST_HAVE_SDT_INTEGRATION
>  #define SDT_USE_VARIADIC
>  #include <sys/sdt.h>
> @@ -137,6 +141,7 @@ extern "C" {
>  
>  #define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
>  extern struct tracepoint __tracepoint_##_provider##___##_name;				\
> +static inline void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__)) LTTNG_NOTRACE;	\
>  static inline void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROTO(__VA_ARGS__))	\
>  {											\
>  	struct tracepoint_probe *__tp_probe;						\
> @@ -158,12 +163,16 @@ end:											\
>  	tp_rcu_read_unlock_bp();							\
>  }											\
>  static inline void __tracepoint_register_##_provider##___##_name(char *name,		\
> +		void (*func)(void), void *data) LTTNG_NOTRACE;					\
> +static inline void __tracepoint_register_##_provider##___##_name(char *name,		\
>  		void (*func)(void), void *data)							\
>  {											\
>  	__tracepoint_probe_register(name, func, data,					\
>  		__tracepoint_##_provider##___##_name.signature);			\
>  }											\
>  static inline void __tracepoint_unregister_##_provider##___##_name(char *name,		\
> +		void (*func)(void), void *data) LTTNG_NOTRACE;					\
> +static inline void __tracepoint_unregister_##_provider##___##_name(char *name,		\
>  		void (*func)(void), void *data)							\
>  {											\
>  	__tracepoint_probe_unregister(name, func, data);				\
> @@ -249,6 +258,7 @@ int __tracepoint_registered
>  struct tracepoint_dlopen tracepoint_dlopen
>  	__attribute__((weak, visibility("hidden")));
>  
> +static void __attribute__((constructor)) __tracepoints__init(void) LTTNG_NOTRACE;
>  static void __attribute__((constructor)) __tracepoints__init(void)
>  {
>  	if (__tracepoint_registered++)
> @@ -285,6 +295,7 @@ static void __attribute__((constructor)) __tracepoints__init(void)
>  				__start___tracepoints_ptrs);
>  }
>  
> +static void __attribute__((destructor)) __tracepoints__destroy(void) LTTNG_NOTRACE;
>  static void __attribute__((destructor)) __tracepoints__destroy(void)
>  {
>  	int ret;
> diff --git a/include/lttng/ust-config.h.in b/include/lttng/ust-config.h.in
> index 5d1ee40..b75dfb8 100644
> --- a/include/lttng/ust-config.h.in
> +++ b/include/lttng/ust-config.h.in
> @@ -5,3 +5,6 @@
>  
>  /* DTrace/GDB/SystemTap integration via sdt.h */
>  #undef LTTNG_UST_HAVE_SDT_INTEGRATION
> +
> +/* Prevent -finstrument-functions instrumentation */
> +#undef LTTNG_NOTRACE
> diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
> index 78d85af..35c33dd 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -89,6 +89,10 @@
>  		__max1 > __max2 ? __max1: __max2;	\
>  	})
>  
> +#ifndef LTTNG_NOTRACE
> +#define LTTNG_NOTRACE
> +#endif
> +
>  /*
>   * Stage 0 of tracepoint event generation.
>   *
> @@ -278,6 +282,7 @@ static void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args));
>  
>  #undef TRACEPOINT_EVENT_CLASS
>  #define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)      \
> +static inline size_t __event_get_size__##_provider##___##_name(size_t *__dynamic_len, _TP_ARGS_DATA_PROTO(_args)) LTTNG_NOTRACE; \
>  static inline size_t __event_get_size__##_provider##___##_name(size_t *__dynamic_len, _TP_ARGS_DATA_PROTO(_args)) \
>  {									      \
>  	size_t __event_len = 0;						      \
> @@ -330,6 +335,7 @@ static inline size_t __event_get_size__##_provider##___##_name(size_t *__dynamic
>  #undef TRACEPOINT_EVENT_CLASS
>  #define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)	      \
>  static inline								      \
> +size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args)) LTTNG_NOTRACE; \
>  size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))      \
>  {									      \
>  	size_t __event_align = 1;					      \
> @@ -400,6 +406,7 @@ size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))      \
>  
>  #undef TRACEPOINT_EVENT_CLASS
>  #define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)	      \
> +static void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args)) LTTNG_NOTRACE; \
>  static void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))\
>  {									      \
>  	struct ltt_event *__event = __tp_data;				      \
> @@ -547,6 +554,8 @@ static struct lttng_probe_desc _TP_COMBINE_TOKENS(__probe_desc___, TRACEPOINT_PR
>  /* Reset all macros within TRACEPOINT_EVENT */
>  #include <lttng/ust-tracepoint-event-reset.h>
>  static void __attribute__((constructor))
> +_TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void) LTTNG_NOTRACE;
> +static void __attribute__((constructor))
>  _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
>  {
>  	int ret;
> @@ -556,6 +565,8 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
>  }
>  
>  static void __attribute__((destructor))
> +_TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void) LTTNG_NOTRACE;
> +static void __attribute__((destructor))
>  _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)
>  {
>  	ltt_probe_unregister(&_TP_COMBINE_TOKENS(__probe_desc___, TRACEPOINT_PROVIDER));
> -- 
> 1.7.10.4
> 




-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
