From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: notrace missing in lttng-ust
Date: Wed, 18 Jul 2012 07:42:16 -0400
Message-ID: <20120718114216.GA4061__17850.8678604432$1342611771$gmane$org@Krystal>
References: <4FED6718.1000205@mentor.com> <20120630181600.GB30747@Krystal>
	<4FF2A31D.9020100@mentor.com> <20120717141301.GA21204@Krystal>
	<500690E4.4020503@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SrSe3-0000dD-0p
	for lttng-dev@lists.lttng.org; Wed, 18 Jul 2012 07:42:19 -0400
Content-Disposition: inline
In-Reply-To: <500690E4.4020503@mentor.com>
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
> On 07/17/2012 04:13 PM, Mathieu Desnoyers wrote:
>
>> I think we want to make the notrace always active. I don't see the point
>> in letting UST lib be compiled with those tracing stubs in place.
>
> OK, I'll remove that ...
>
>> We should create a include/lttng/ust-compiler.h with:
>>
>> #define lttng_ust_notrace __attribute__((no_instrument_function))
>>
>> so we don't duplicate the define.
>
> ... and use include/lttng/ust-compiler.h instead.
>
>> Can't we simply specify the attribute on the function definition, rather
>> than having to duplicate its prototype ?
>
> No. I tried that before but unfortunately it didn't work. It only works  =

> consistently if the attribute is on the function declaration. If you try  =

> to put it on the definition it will result in compiler errors either  =

> when tracepoint providers are compiled or when tracepoint provider  =

> header files are used.

Please try with the change I propose below,

>
> The updated patch is in the attachment.
>
> Thanks,
> Paul
>
> -- =

> Paul Woegerer | SW Development Engineer
> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> P 43.1.535991320
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
>
> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.
>

> From 46e709a85edbca6b9c869148cadd2abac2f98acf Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Wed, 18 Jul 2012 12:27:07 +0200
> Subject: [PATCH] Make lttng-ust robust against -finstrument-functions.
> =

> ---
>  include/Makefile.am                  |    1 +
>  include/lttng/ringbuffer-config.h    |   17 +++++++++++++++++
>  include/lttng/tracepoint.h           |    8 ++++++++
>  include/lttng/ust-compiler.h         |   21 +++++++++++++++++++++
>  include/lttng/ust-tracepoint-event.h |    8 ++++++++
>  5 files changed, 55 insertions(+)
>  create mode 100644 include/lttng/ust-compiler.h
> =

> diff --git a/include/Makefile.am b/include/Makefile.am
> index 633260b..208e74e 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -14,6 +14,7 @@ nobase_include_HEADERS =3D \
>  	lttng/ringbuffer-abi.h \
>  	lttng/ust-tracer.h \
>  	lttng/ust-config.h \
> +	lttng/ust-compiler.h \
>  	lttng/ust.h \
>  	lttng/ust-endian.h \
>  	lttng/ringbuffer-config.h \
> diff --git a/include/lttng/ringbuffer-config.h b/include/lttng/ringbuffer=
-config.h
> index 24e7dbe..408d95a 100644
> --- a/include/lttng/ringbuffer-config.h
> +++ b/include/lttng/ringbuffer-config.h
> @@ -27,6 +27,7 @@
>  #include <urcu/arch.h>
>  #include <string.h>
>  #include "lttng/align.h"
> +#include <lttng/ust-compiler.h>
>  =

>  struct lttng_ust_lib_ring_buffer;
>  struct channel;
> @@ -232,6 +233,11 @@ static inline
>  void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>  			      struct channel *chan, void *priv,
>  			      size_t data_size, int largest_align,
> +			      int cpu, struct lttng_ust_shm_handle *handle) lttng_ust_notrace;
> +static inline
> +void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
> +			      struct channel *chan, void *priv,
> +			      size_t data_size, int largest_align,
>  			      int cpu, struct lttng_ust_shm_handle *handle)

e.g. here:

static lttng_ust_notrace
void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ring_buffer_ctx *ctx,
                        struct channel *chan, void *priv,
                        size_t data_size, int largest_align,
                        int cpu, struct lttng_ust_shm_handle *handle)
{
        ... body of function ...
}

Thanks,

Mathieu

>  {
>  	ctx->chan =3D chan;
> @@ -276,6 +282,8 @@ void lib_ring_buffer_ctx_init(struct lttng_ust_lib_ri=
ng_buffer_ctx *ctx,
>   * size_of_type must be non-zero.
>   */
>  static inline
> +unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_ty=
pe) lttng_ust_notrace;
> +static inline
>  unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_ty=
pe)
>  {
>  	return offset_align(align_drift, size_of_type);
> @@ -290,6 +298,8 @@ unsigned int lib_ring_buffer_align(size_t align_drift=
, size_t size_of_type)
>   * size_of_type must be non-zero.
>   */
>  static inline
> +unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_ty=
pe) lttng_ust_notrace;
> +static inline
>  unsigned int lib_ring_buffer_align(size_t align_drift, size_t size_of_ty=
pe)
>  {
>  	return 0;
> @@ -303,6 +313,9 @@ unsigned int lib_ring_buffer_align(size_t align_drift=
, size_t size_of_type)
>   */
>  static inline
>  void lib_ring_buffer_align_ctx(struct lttng_ust_lib_ring_buffer_ctx *ctx,
> +			   size_t alignment) lttng_ust_notrace;
> +static inline
> +void lib_ring_buffer_align_ctx(struct lttng_ust_lib_ring_buffer_ctx *ctx,
>  			   size_t alignment)
>  {
>  	ctx->buf_offset +=3D lib_ring_buffer_align(ctx->buf_offset,
> @@ -316,6 +329,10 @@ void lib_ring_buffer_align_ctx(struct lttng_ust_lib_=
ring_buffer_ctx *ctx,
>  static inline
>  int lib_ring_buffer_check_config(const struct lttng_ust_lib_ring_buffer_=
config *config,
>  			     unsigned int switch_timer_interval,
> +			     unsigned int read_timer_interval) lttng_ust_notrace;
> +static inline
> +int lib_ring_buffer_check_config(const struct lttng_ust_lib_ring_buffer_=
config *config,
> +			     unsigned int switch_timer_interval,
>  			     unsigned int read_timer_interval)
>  {
>  	if (config->alloc =3D=3D RING_BUFFER_ALLOC_GLOBAL
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index 5bab476..77595d3 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -22,6 +22,7 @@
>  #include <string.h>	/* for memset */
>  #include <assert.h>
>  #include <lttng/ust-config.h>	/* for sdt */
> +#include <lttng/ust-compiler.h>
>  =

>  #ifdef LTTNG_UST_HAVE_SDT_INTEGRATION
>  #define SDT_USE_VARIADIC
> @@ -137,6 +138,7 @@ extern "C" {
>  =

>  #define _DECLARE_TRACEPOINT(_provider, _name, ...)			 		\
>  extern struct tracepoint __tracepoint_##_provider##___##_name;				\
> +static inline void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROT=
O(__VA_ARGS__)) lttng_ust_notrace;	\
>  static inline void __tracepoint_cb_##_provider##___##_name(_TP_ARGS_PROT=
O(__VA_ARGS__))	\
>  {											\
>  	struct tracepoint_probe *__tp_probe;						\
> @@ -158,12 +160,16 @@ end:											\
>  	tp_rcu_read_unlock_bp();							\
>  }											\
>  static inline void __tracepoint_register_##_provider##___##_name(char *n=
ame,		\
> +		void (*func)(void), void *data) lttng_ust_notrace;					\
> +static inline void __tracepoint_register_##_provider##___##_name(char *n=
ame,		\
>  		void (*func)(void), void *data)							\
>  {											\
>  	__tracepoint_probe_register(name, func, data,					\
>  		__tracepoint_##_provider##___##_name.signature);			\
>  }											\
>  static inline void __tracepoint_unregister_##_provider##___##_name(char =
*name,		\
> +		void (*func)(void), void *data) lttng_ust_notrace;					\
> +static inline void __tracepoint_unregister_##_provider##___##_name(char =
*name,		\
>  		void (*func)(void), void *data)							\
>  {											\
>  	__tracepoint_probe_unregister(name, func, data);				\
> @@ -249,6 +255,7 @@ int __tracepoint_registered
>  struct tracepoint_dlopen tracepoint_dlopen
>  	__attribute__((weak, visibility("hidden")));
>  =

> +static void __attribute__((constructor)) __tracepoints__init(void) lttng=
_ust_notrace;
>  static void __attribute__((constructor)) __tracepoints__init(void)
>  {
>  	if (__tracepoint_registered++)
> @@ -285,6 +292,7 @@ static void __attribute__((constructor)) __tracepoint=
s__init(void)
>  				__start___tracepoints_ptrs);
>  }
>  =

> +static void __attribute__((destructor)) __tracepoints__destroy(void) ltt=
ng_ust_notrace;
>  static void __attribute__((destructor)) __tracepoints__destroy(void)
>  {
>  	int ret;
> diff --git a/include/lttng/ust-compiler.h b/include/lttng/ust-compiler.h
> new file mode 100644
> index 0000000..c35a23e
> --- /dev/null
> +++ b/include/lttng/ust-compiler.h
> @@ -0,0 +1,21 @@
> +#ifndef _LTTNG_UST_COMPILER_H
> +#define _LTTNG_UST_COMPILER_H
> +
> +/*
> + * Copyright 2011-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.c=
om>
> + *                       Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + */
> +
> +#define lttng_ust_notrace __attribute__((no_instrument_function))
> +
> +#endif /* _LTTNG_UST_COMPILER_H */
> diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tra=
cepoint-event.h
> index 8db1e68..8628dbe 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -16,6 +16,7 @@
>  #include <urcu/compiler.h>
>  #include <lttng/ust-events.h>
>  #include <lttng/ringbuffer-config.h>
> +#include <lttng/ust-compiler.h>
>  #include <string.h>
>  =

>  /*
> @@ -244,6 +245,7 @@ static void __event_probe__##_provider##___##_name(_T=
P_ARGS_DATA_PROTO(_args));
>  =

>  #undef TRACEPOINT_EVENT_CLASS
>  #define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)      \
> +static inline size_t __event_get_size__##_provider##___##_name(size_t *_=
_dynamic_len, _TP_ARGS_DATA_PROTO(_args)) lttng_ust_notrace; \
>  static inline size_t __event_get_size__##_provider##___##_name(size_t *_=
_dynamic_len, _TP_ARGS_DATA_PROTO(_args)) \
>  {									      \
>  	size_t __event_len =3D 0;						      \
> @@ -361,6 +363,7 @@ void __event_prepare_filter_stack__##_provider##___##=
_name(char *__stack_data,\
>  #undef TRACEPOINT_EVENT_CLASS
>  #define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)	      \
>  static inline								      \
> +size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))=
 lttng_ust_notrace; \
>  size_t __event_get_align__##_provider##___##_name(_TP_ARGS_PROTO(_args))=
      \
>  {									      \
>  	size_t __event_align =3D 1;					      \
> @@ -438,6 +441,7 @@ size_t __event_get_align__##_provider##___##_name(_TP=
_ARGS_PROTO(_args))      \
>   */
>  #undef TRACEPOINT_EVENT_CLASS
>  #define TRACEPOINT_EVENT_CLASS(_provider, _name, _args, _fields)	      \
> +static void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_=
args)) lttng_ust_notrace; \
>  static void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_=
args))\
>  {									      \
>  	struct ltt_event *__event =3D __tp_data;				      \
> @@ -594,6 +598,8 @@ static struct lttng_probe_desc _TP_COMBINE_TOKENS(__p=
robe_desc___, TRACEPOINT_PR
>  /* Reset all macros within TRACEPOINT_EVENT */
>  #include <lttng/ust-tracepoint-event-reset.h>
>  static void __attribute__((constructor))
> +_TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void) ltt=
ng_ust_notrace;
> +static void __attribute__((constructor))
>  _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
>  {
>  	int ret;
> @@ -603,6 +609,8 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_=
PROVIDER)(void)
>  }
>  =

>  static void __attribute__((destructor))
> +_TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void) ltt=
ng_ust_notrace;
> +static void __attribute__((destructor))
>  _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)
>  {
>  	ltt_probe_unregister(&_TP_COMBINE_TOKENS(__probe_desc___, TRACEPOINT_PR=
OVIDER));
> -- =

> 1.7.10.4
> =



-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
