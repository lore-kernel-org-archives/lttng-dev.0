From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: make hello.cxx compile with
	g++
Date: Thu, 30 May 2013 10:18:52 -0400
Message-ID: <20130530141852.GA23476__32350.1037237749$1369923576$gmane$org@Krystal>
References: <1366649058-9848-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ui3gv-0003mD-M7
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 10:18:57 -0400
Content-Disposition: inline
In-Reply-To: <1366649058-9848-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged with edits as:

commit 46d522007b647e0b64d18d0ed518205c2bbad424
Author: Zifei Tong <soariez@gmail.com>
Date:   Thu May 30 10:11:52 2013 -0400

    Allow tracepoint providers to be compiled with g++
    
    Move enumeration definition out of lttng_ust_lib_ring_buffer_config to
    make them visible at global scope for C++ compilers.
    
    Modify designated initializers: reordering initializers, add missing
    initializers, reformat nested initializers, in order to make g++
    compile.
    
    Relevant discussion:
    
    > So each field need to be listed ? We usually don't put NULL
    > initialization for structures that are always in zero-initialized
    > memory. (coding style)
    
    This is related to a known issue of g++:
    http://gcc.gnu.org/bugzilla/show_bug.cgi?id=55606 (Bug 55606 - sorry,
    unimplemented: non-trivial designated initializers not supported).
    
    g++'s 'trivial designated initializers' means no out-of-order
    initialization, no missing
    initialization (except the fields on the tail of a struct), and nested
    initialization should be done in the form {.foo = {.bar = 1}} instead of
    {.foo.bar = 1}. That's why I made such modification.
    
    > Are those changes also compatible with the LLVM c++ compiler ?
    Actually, clang++ have designated initializers better supported than g++.
    All the modification about designated initializers are not required for
    clang++. No need to add NULL initialization, reorder initializations or
    change {.foo.bar = 1} into {.foo = {.bar = 1}}. These (ugly) hacks are just
    to make g++ happy.
    
    [ Updates done by Mathieu Desnoyers to fix merge conflicts. Updated
      README. ]
    
    Fixes #338
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

It will be part of LTTng-UST 2.3 (not the release currently in RC, but
the next one).

Thanks,

Mathieu

* Zifei Tong (soariez@gmail.com) wrote:
> > +#ifdef TRACEPOINT_CREATE_PROBES
> > +
> >  #ifdef __cplusplus
> >  extern "C" {
> >  #endif
> >
> > -#ifdef TRACEPOINT_CREATE_PROBES
> > -
> >
> > -#define TRACEPOINT_CREATE_PROBES
> > -
> > -#endif /* TRACEPOINT_CREATE_PROBES */
> > -
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > +
> > +#define TRACEPOINT_CREATE_PROBES
> > +
> > +#endif /* TRACEPOINT_CREATE_PROBES */
> 
> > Hrm, I don't get what this is supposed to fix ?
> >
> > Normall
> 
> The "extern "C" { }" part is not guarded by the TRACEPOINT_CREATE_PROBES macro.  So
> 
> > static inline void _TP_COMBINE_TOKENS(__tracepoint_provider_check_, TRACEPOINT_PROVIDER)(void)
> > {
> > #include TRACEPOINT_INCLUDE
> > }
> 
> will expand to something like:
> 
> > static inline
> > void __tracepoint_provider_check_ust_tests_hello(void)
> > {
> > __tracepoint_provider_mismatch_ust_tests_hello(); __tracepoint_provider_mismatch_ust_tests_hello();
> > extern "C" {
> > }
> > }
> 
> which does not compile.
> 
> Modified patch attached. Please review.
> 
> Thanks.
> 
> Zifei Tong
> ----
> Move enumeration definition out of lttng_ust_lib_ring_buffer_config to
> make them visible at global scope for C++ compilers.
> 
> Modify designated initializers: reordering initializers, add missing
> initializers, reformat nested initializers, in order to make g++ compile.
> 
> Fixes #338
> 
> Signed-off-by: Zifei Tong <soariez@gmail.com>
> ---
>  include/lttng/ringbuffer-config.h    | 97 +++++++++++++++++++++---------------
>  include/lttng/tracepoint-event.h     | 12 ++---
>  include/lttng/ust-events.h           | 42 ++++++++++------
>  include/lttng/ust-tracepoint-event.h | 32 ++++++++----
>  tests/hello.cxx/Makefile.am          |  2 +-
>  tests/hello.cxx/tp.c                 | 26 ----------
>  tests/hello.cxx/tp.cpp               | 26 ++++++++++
>  7 files changed, 138 insertions(+), 99 deletions(-)
>  delete mode 100644 tests/hello.cxx/tp.c
>  create mode 100644 tests/hello.cxx/tp.cpp
> 
> diff --git a/include/lttng/ringbuffer-config.h b/include/lttng/ringbuffer-config.h
> index ca52fc7..42889cc 100644
> --- a/include/lttng/ringbuffer-config.h
> +++ b/include/lttng/ringbuffer-config.h
> @@ -134,47 +134,64 @@ struct lttng_ust_lib_ring_buffer_client_cb {
>   * has the responsibility to perform wakeups.
>   */
>  #define LTTNG_UST_RING_BUFFER_CONFIG_PADDING	32
> +
> +enum lttng_ust_lib_ring_buffer_alloc_types {
> +	RING_BUFFER_ALLOC_PER_CPU,
> +	RING_BUFFER_ALLOC_GLOBAL,
> +};
> +
> +enum lttng_ust_lib_ring_buffer_sync_types {
> +	RING_BUFFER_SYNC_PER_CPU,	/* Wait-free */
> +	RING_BUFFER_SYNC_GLOBAL,	/* Lock-free */
> +};
> +
> +enum lttng_ust_lib_ring_buffer_mode_types {
> +	RING_BUFFER_OVERWRITE,		/* Overwrite when buffer full */
> +	RING_BUFFER_DISCARD,		/* Discard when buffer full */
> +};
> +
> +enum lttng_ust_lib_ring_buffer_output_types {
> +	RING_BUFFER_SPLICE,
> +	RING_BUFFER_MMAP,
> +	RING_BUFFER_READ,		/* TODO */
> +	RING_BUFFER_ITERATOR,
> +	RING_BUFFER_NONE,
> +};
> +
> +enum lttng_ust_lib_ring_buffer_backend_types {
> +	RING_BUFFER_PAGE,
> +	RING_BUFFER_VMAP,		/* TODO */
> +	RING_BUFFER_STATIC,		/* TODO */
> +};
> +
> +enum lttng_ust_lib_ring_buffer_oops_types {
> +	RING_BUFFER_NO_OOPS_CONSISTENCY,
> +	RING_BUFFER_OOPS_CONSISTENCY,
> +};
> +
> +enum lttng_ust_lib_ring_buffer_ipi_types {
> +	RING_BUFFER_IPI_BARRIER,
> +	RING_BUFFER_NO_IPI_BARRIER,
> +};
> +
> +enum lttng_ust_lib_ring_buffer_wakeup_types {
> +	RING_BUFFER_WAKEUP_BY_TIMER,	/* wake up performed by timer */
> +	RING_BUFFER_WAKEUP_BY_WRITER,	/*
> +					 * writer wakes up reader,
> +					 * not lock-free
> +					 * (takes spinlock).
> +					 */
> +};
> +
>  struct lttng_ust_lib_ring_buffer_config {
> -	enum {
> -		RING_BUFFER_ALLOC_PER_CPU,
> -		RING_BUFFER_ALLOC_GLOBAL,
> -	} alloc;
> -	enum {
> -		RING_BUFFER_SYNC_PER_CPU,	/* Wait-free */
> -		RING_BUFFER_SYNC_GLOBAL,	/* Lock-free */
> -	} sync;
> -	enum {
> -		RING_BUFFER_OVERWRITE,		/* Overwrite when buffer full */
> -		RING_BUFFER_DISCARD,		/* Discard when buffer full */
> -	} mode;
> -	enum {
> -		RING_BUFFER_SPLICE,
> -		RING_BUFFER_MMAP,
> -		RING_BUFFER_READ,		/* TODO */
> -		RING_BUFFER_ITERATOR,
> -		RING_BUFFER_NONE,
> -	} output;
> -	enum {
> -		RING_BUFFER_PAGE,
> -		RING_BUFFER_VMAP,		/* TODO */
> -		RING_BUFFER_STATIC,		/* TODO */
> -	} backend;
> -	enum {
> -		RING_BUFFER_NO_OOPS_CONSISTENCY,
> -		RING_BUFFER_OOPS_CONSISTENCY,
> -	} oops;
> -	enum {
> -		RING_BUFFER_IPI_BARRIER,
> -		RING_BUFFER_NO_IPI_BARRIER,
> -	} ipi;
> -	enum {
> -		RING_BUFFER_WAKEUP_BY_TIMER,	/* wake up performed by timer */
> -		RING_BUFFER_WAKEUP_BY_WRITER,	/*
> -						 * writer wakes up reader,
> -						 * not lock-free
> -						 * (takes spinlock).
> -						 */
> -	} wakeup;
> +	enum lttng_ust_lib_ring_buffer_alloc_types alloc;
> +	enum lttng_ust_lib_ring_buffer_sync_types sync;
> +	enum lttng_ust_lib_ring_buffer_mode_types mode;
> +	enum lttng_ust_lib_ring_buffer_output_types output;
> +	enum lttng_ust_lib_ring_buffer_backend_types backend;
> +	enum lttng_ust_lib_ring_buffer_oops_types oops;
> +	enum lttng_ust_lib_ring_buffer_ipi_types ipi;
> +	enum lttng_ust_lib_ring_buffer_wakeup_types wakeup;
>  	/*
>  	 * tsc_bits: timestamp bits saved at each record.
>  	 *   0 and 64 disable the timestamp compression scheme.
> diff --git a/include/lttng/tracepoint-event.h b/include/lttng/tracepoint-event.h
> index 077eaa0..4630788 100644
> --- a/include/lttng/tracepoint-event.h
> +++ b/include/lttng/tracepoint-event.h
> @@ -20,12 +20,12 @@
>   * SOFTWARE.
>   */
>  
> +#ifdef TRACEPOINT_CREATE_PROBES
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
>  
> -#ifdef TRACEPOINT_CREATE_PROBES
> -
>  #define __tp_stringify1(x)	#x
>  #define __tp_stringify(x)	__tp_stringify1(x)
>  
> @@ -65,10 +65,10 @@ extern "C" {
>  #undef TRACEPOINT_INCLUDE_FILE
>  #undef TRACEPOINT_INCLUDE
>  
> -#define TRACEPOINT_CREATE_PROBES
> -
> -#endif /* TRACEPOINT_CREATE_PROBES */
> -
>  #ifdef __cplusplus
>  }
>  #endif
> +
> +#define TRACEPOINT_CREATE_PROBES
> +
> +#endif /* TRACEPOINT_CREATE_PROBES */
> diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
> index 749478a..bda0fbc 100644
> --- a/include/lttng/ust-events.h
> +++ b/include/lttng/ust-events.h
> @@ -89,15 +89,21 @@ struct lttng_enum_entry {
>  
>  #define __type_integer(_type, _byte_order, _base, _encoding)	\
>  	{							\
> -	    .atype = atype_integer,				\
> -	    .u.basic.integer =					\
> +	  .atype = atype_integer,				\
> +	  .u =							\
>  		{						\
> -		  .size = sizeof(_type) * CHAR_BIT,		\
> -		  .alignment = lttng_alignof(_type) * CHAR_BIT,	\
> -		  .signedness = lttng_is_signed_type(_type),	\
> -		  .reverse_byte_order = _byte_order != BYTE_ORDER,	\
> -		  .base = _base,				\
> -		  .encoding = lttng_encode_##_encoding,		\
> +		  .basic = 					\
> +			{					\
> +			  .integer =				\
> +				{				\
> +				  .size = sizeof(_type) * CHAR_BIT,		\
> +				  .alignment = lttng_alignof(_type) * CHAR_BIT,	\
> +				  .signedness = lttng_is_signed_type(_type),	\
> +				  .reverse_byte_order = _byte_order != BYTE_ORDER, \
> +				  .base = _base,				\
> +				  .encoding = lttng_encode_##_encoding,		\
> +				}				\
> +			}					\
>  		},						\
>  	}							\
>  
> @@ -123,14 +129,20 @@ struct lttng_integer_type {
>  
>  #define __type_float(_type)					\
>  	{							\
> -	    .atype = atype_float,				\
> -	    .u.basic._float =					\
> +	  .atype = atype_float,					\
> +	  .u =							\
>  		{						\
> -		  .exp_dig = sizeof(_type) * CHAR_BIT		\
> -				- _float_mant_dig(_type),	\
> -		  .mant_dig = _float_mant_dig(_type),		\
> -		  .alignment = lttng_alignof(_type) * CHAR_BIT,	\
> -		  .reverse_byte_order = BYTE_ORDER != FLOAT_WORD_ORDER, \
> +		  .basic =					\
> +			{					\
> +			  ._float =				\
> +				{				\
> +				  .exp_dig = sizeof(_type) * CHAR_BIT		\
> +						  - _float_mant_dig(_type),	\
> +				  .mant_dig = _float_mant_dig(_type),		\
> +				  .alignment = lttng_alignof(_type) * CHAR_BIT,	\
> +				  .reverse_byte_order = BYTE_ORDER != FLOAT_WORD_ORDER,	\
> +				}				\
> +			}					\
>  		},						\
>  	}							\
>  
> diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
> index e46cc1a..bf4aeb4 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -147,11 +147,14 @@ static const char							\
>  	  .type =						\
>  		{						\
>  		  .atype = atype_array,				\
> -		  .u.array =					\
> +		  .u =						\
>  			{					\
> -			    .length = _length,			\
> -			    .elem_type = __type_integer(_type, BYTE_ORDER, 10, _encoding), \
> -			},					\
> +			  .array =				\
> +				{				\
> +				  .elem_type = __type_integer(_type, BYTE_ORDER, 10, _encoding), \
> +				  .length = _length,		\
> +				}				\
> +			}					\
>  		},						\
>  	  .nowrite = _nowrite,					\
>  	},
> @@ -164,10 +167,13 @@ static const char							\
>  	  .type =						\
>  		{						\
>  		  .atype = atype_sequence,			\
> -		  .u.sequence =					\
> +		  .u =						\
>  			{					\
> -			    .length_type = __type_integer(_length_type, BYTE_ORDER, 10, none), \
> -			    .elem_type = __type_integer(_type, BYTE_ORDER, 10, _encoding), \
> +			  .sequence =				\
> +				{				\
> +				  .length_type = __type_integer(_length_type, BYTE_ORDER, 10, none), \
> +				  .elem_type = __type_integer(_type, BYTE_ORDER, 10, _encoding), \
> +				},				\
>  			},					\
>  		},						\
>  	  .nowrite = _nowrite,					\
> @@ -180,7 +186,10 @@ static const char							\
>  	  .type =						\
>  		{						\
>  		  .atype = atype_string,			\
> -		  .u.basic.string.encoding = lttng_encode_UTF8,	\
> +		  .u =						\
> +			{					\
> +			  .basic = { .string = { .encoding = lttng_encode_UTF8 } } \
> +			},					\
>  		},						\
>  	  .nowrite = _nowrite,					\
>  	},
> @@ -483,7 +492,7 @@ void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args));      \
>  static									      \
>  void __event_probe__##_provider##___##_name(_TP_ARGS_DATA_PROTO(_args))	      \
>  {									      \
> -	struct lttng_event *__event = __tp_data;			      \
> +	struct lttng_event *__event = (struct lttng_event *) __tp_data;			      \
>  	struct lttng_channel *__chan = __event->chan;			      \
>  	struct lttng_ust_lib_ring_buffer_ctx __ctx;			      \
>  	size_t __event_len, __event_align;				      \
> @@ -612,13 +621,14 @@ static const char *							       \
>  	__ref_model_emf_uri___##_provider##___##_name			       \
>  	__attribute__((weakref ("_model_emf_uri___" #_provider "___" #_name)));\
>  const struct lttng_event_desc __event_desc___##_provider##_##_name = {	       \
> -	.fields = __event_fields___##_provider##___##_template,		       \
>  	.name = #_provider ":" #_name,					       \
>  	.probe_callback = (void (*)(void)) &__event_probe__##_provider##___##_template,\
> +	.ctx = NULL,							       \
> +	.fields = __event_fields___##_provider##___##_template,		       \
>  	.nr_fields = _TP_ARRAY_SIZE(__event_fields___##_provider##___##_template), \
>  	.loglevel = &__ref_loglevel___##_provider##___##_name,		       \
>  	.signature = __tp_event_signature___##_provider##___##_template,       \
> -	.u.ext.model_emf_uri = &__ref_model_emf_uri___##_provider##___##_name, \
> +	.u = { .ext = { .model_emf_uri = &__ref_model_emf_uri___##_provider##___##_name } }, \
>  };
>  
>  #include TRACEPOINT_INCLUDE
> diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefile.am
> index 897416d..5f6c615 100644
> --- a/tests/hello.cxx/Makefile.am
> +++ b/tests/hello.cxx/Makefile.am
> @@ -1,7 +1,7 @@
>  AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = hello
> -hello_SOURCES = hello.cpp tp.c ust_tests_hello.h
> +hello_SOURCES = hello.cpp tp.cpp ust_tests_hello.h
>  hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
>  
>  if LTTNG_UST_BUILD_WITH_LIBDL
> diff --git a/tests/hello.cxx/tp.c b/tests/hello.cxx/tp.c
> deleted file mode 100644
> index 4790965..0000000
> --- a/tests/hello.cxx/tp.c
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * tp.c
> - *
> - * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> - * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> - * SOFTWARE.
> - */
> -
> -#define TRACEPOINT_CREATE_PROBES
> -#include "ust_tests_hello.h"
> diff --git a/tests/hello.cxx/tp.cpp b/tests/hello.cxx/tp.cpp
> new file mode 100644
> index 0000000..a2099ab
> --- /dev/null
> +++ b/tests/hello.cxx/tp.cpp
> @@ -0,0 +1,26 @@
> +/*
> + * tp.cpp
> + *
> + * Copyright (c) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +#define TRACEPOINT_CREATE_PROBES
> +#include "ust_tests_hello.h"
> -- 
> 1.8.2.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
