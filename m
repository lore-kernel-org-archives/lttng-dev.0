From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-patch] Add support of struct metadata
	in	tracepoints
Date: Sun, 21 Apr 2013 09:50:06 -0400
Message-ID: <20130421135006.GA27816__25007.7418204912$1366552235$gmane$org@Krystal>
References: <1366309257-17855-1-git-send-email-gbastien+lttng@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UTuee-0004G9-Gz
	for lttng-dev@lists.lttng.org; Sun, 21 Apr 2013 09:50:08 -0400
Content-Disposition: inline
In-Reply-To: <1366309257-17855-1-git-send-email-gbastien+lttng@versatic.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien+lttng@versatic.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Genevi=E8ve Bastien (gbastien+lttng@versatic.net) wrote:
> Introduce the new macro TRACEPOINT_STRUCT to define ctf struct metadata
> that can be used by tracepoints using _struct as entry and tp_memcpy_stru=
ct
> to copy a struct field.
> Struct metadata can contain nested structs.
> This extra metadata is added to the metadata file only if events use it.

Have you tried nesting structures into a sequence or array ? What
changes would be needed to support this ?

More comments below,

> =

> Signed-off-by: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
> ---
>  lttng-events.c              | 166 ++++++++++++++++++++++++++++++++++-
>  lttng-events.h              |  44 ++++++++++
>  probes/lttng-events-reset.h |  15 ++++
>  probes/lttng-events.h       | 206 ++++++++++++++++++++++++++++++++++++++=
++++--
>  4 files changed, 421 insertions(+), 10 deletions(-)
> =

> diff --git a/lttng-events.c b/lttng-events.c
> index 4f30904..b332c29 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -61,6 +61,7 @@ void synchronize_trace(void)
>  struct lttng_session *lttng_session_create(void)
>  {
>  	struct lttng_session *session;
> +	int i;
>  =

>  	mutex_lock(&sessions_mutex);
>  	session =3D kzalloc(sizeof(struct lttng_session), GFP_KERNEL);
> @@ -70,6 +71,11 @@ struct lttng_session *lttng_session_create(void)
>  	INIT_LIST_HEAD(&session->events);
>  	uuid_le_gen(&session->uuid);
>  	list_add(&session->list, &sessions);
> +	/* Initialize dumped metadata */
> +	for (i =3D 0; i < NR_METADATA_TYPES; i++) {
> +		session->dumped_metadata[i].nr_metadata =3D 0;
> +		session->dumped_metadata[i].next =3D 0;
> +	}
>  	mutex_unlock(&sessions_mutex);
>  	return session;
>  }
> @@ -78,7 +84,8 @@ void lttng_session_destroy(struct lttng_session *sessio=
n)
>  {
>  	struct lttng_channel *chan, *tmpchan;
>  	struct lttng_event *event, *tmpevent;
> -	int ret;
> +	struct lttng_metadata_dumped_data *dumped;
> +	int ret, i, j;

int ret, i;

>  =

>  	mutex_lock(&sessions_mutex);
>  	ACCESS_ONCE(session->active) =3D 0;
> @@ -96,6 +103,15 @@ void lttng_session_destroy(struct lttng_session *sess=
ion)
>  	list_for_each_entry_safe(chan, tmpchan, &session->chan, list)
>  		_lttng_channel_destroy(chan);
>  	list_del(&session->list);
> +	/* Destroy dumped metadata */
> +	for (i =3D 0; i < NR_METADATA_TYPES; i++) {

int j;


(limit scope)

> +		dumped =3D session->dumped_metadata[i].next;
> +		for (j =3D 0; j < session->dumped_metadata[i].nr_metadata; j++) {
> +			dumped =3D dumped->next;
> +			kfree(dumped);
> +		}
> +
> +	}
>  	mutex_unlock(&sessions_mutex);
>  	kfree(session);
>  }
[...]

> diff --git a/probes/lttng-events-reset.h b/probes/lttng-events-reset.h
> index 44e8ba5..dd60ca6 100644
> --- a/probes/lttng-events-reset.h
> +++ b/probes/lttng-events-reset.h
> @@ -20,6 +20,9 @@
>  =

>  /* Reset macros used within TRACE_EVENT to "nothing" */
>  =

> +#undef TRACE_METADATA
> +#define TRACE_METADATA 1

What is TRACE_METADATA used for ?

> +
>  #undef __field_full
>  #define __field_full(_type, _item, _order, _base)
>  =

> @@ -35,6 +38,9 @@
>  #undef __string
>  #define __string(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)
> +
>  #undef tp_assign
>  #define tp_assign(dest, src)
>  =

> @@ -47,6 +53,9 @@
>  #undef tp_strcpy
>  #define tp_strcpy(dest, src)
>  =

> +#undef tp_memcpy_struct
> +#define tp_memcpy_struct(provider, name, dest, src)
> +
>  #undef __get_str
>  #define __get_str(field)
>  =

> @@ -65,6 +74,9 @@
>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...)
>  =

> +#undef TP_FIELDS
> +#define TP_FIELDS(args...)
> +
>  #undef TP_fast_assign
>  #define TP_fast_assign(args...)
>  =

> @@ -94,3 +106,6 @@
>  =

>  #undef TRACE_EVENT_FLAGS
>  #define TRACE_EVENT_FLAGS(name, value)
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)
> diff --git a/probes/lttng-events.h b/probes/lttng-events.h
> index 8a3a886..93f4abc 100644
> --- a/probes/lttng-events.h
> +++ b/probes/lttng-events.h
> @@ -263,9 +263,31 @@ void trace_##_name(void *__data);
>  #define __string_from_user(_item, _src)				\
>  	__string(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)		\
> +	{							\
> +	  .name =3D #_item,					\
> +	  .type =3D						\
> +	  {							\
> +		.atype =3D atype_struct,				\
> +		.u.ctf_struct.provider =3D #_provider,		\
> +		.u.ctf_struct.name =3D #_type,			\
> +	  },							\
> +	},
> +
>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...) args	/* Only one used in this phase */
>  =

> +#undef TP_FIELDS
> +#define TP_FIELDS(args...) args	/* Only one used in this phase */
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
> +	static const struct lttng_event_field			\
> +		__struct_fields___##_provider##_##_name[] =3D {	\
> +			_fields					\
> +	};
> +
>  #undef DECLARE_EVENT_CLASS_NOARGS
>  #define DECLARE_EVENT_CLASS_NOARGS(_name, _tstruct, _assign, _print) \
>  	static const struct lttng_event_field __event_fields___##_name[] =3D { \
> @@ -301,6 +323,74 @@ static void __event_probe__##_name(void *__data);
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>  =

>  /*
> + * Stage 3.2 of the trace events.
> + *
> + * Create type metadata description
> + */
> +
> +#include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT */
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
> +static struct lttng_struct_desc __struct_desc___##_provider##_##_name =
=3D {\
> +		.fields =3D __struct_fields___##_provider##_##_name,	\
> +		.nr_fields =3D ARRAY_SIZE(__struct_fields___##_provider##_##_name),\
> +		.provider =3D #_provider,					\
> +		.name =3D #_name,						\
> +		.owner =3D THIS_MODULE,					\
> +	};
> +
> +#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> +
> +/*
> + * Stage 3.3 of the trace events.
> + *
> + * Associate metadata description to event or event template or other st=
ruct
> + */
> +
> +/* Named field types must be defined in lttng-types.h */
> +
> +#include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT */
> +
> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	{								\
> +		.mtype =3D mtype_struct,					\
> +		.m.ctf_st.struct_desc =3D &__struct_desc___##_provider##_##_type,\
> +		.m.ctf_st.type_metadata =3D __type_metadata_for__##_provider##_##_type=
,\
> +		.m.ctf_st.nr_metadata =3D ARRAY_SIZE(__type_metadata_for__##_provider#=
#_##_type),\
> +	},
> +
> +
> +#undef TP_STRUCT__entry
> +#define TP_STRUCT__entry(args...) args	/* Only one used in this phase */
> +
> +#undef TP_FIELDS
> +#define TP_FIELDS(args...) args
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
> +static const struct lttng_metadata __type_metadata_for__##_provider##_##=
_name[] =3D {\
> +	_fields								\
> +};
> +
> +
> +
> +#undef DECLARE_EVENT_CLASS_NOARGS
> +#define DECLARE_EVENT_CLASS_NOARGS(_name, _tstruct, _assign, _print) \
> +static const struct lttng_metadata __type_metadata_for__##_name[] =3D {	\
> +	_tstruct		\
> +};
> +
> +#undef DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_CLASS(_name, _proto, _args, _tstruct, _assign, _pr=
int) \
> +	DECLARE_EVENT_CLASS_NOARGS(_name, PARAMS(_tstruct), PARAMS(_assign), \
> +			PARAMS(_print))
> +
> +#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> +
> +
> +/*
>   * Stage 3.9 of the trace events.
>   *
>   * Create event descriptions.
> @@ -318,9 +408,11 @@ static void __event_probe__##_name(void *__data);
>  #define DEFINE_EVENT_MAP_NOARGS(_template, _name, _map)			\
>  static const struct lttng_event_desc __event_desc___##_map =3D {		\
>  	.fields =3D __event_fields___##_template,		     		\
> +	.type_metadata =3D __type_metadata_for__##_template,		\
>  	.name =3D #_map,					     		\
>  	.probe_callback =3D (void *) TP_PROBE_CB(_template),   		\
>  	.nr_fields =3D ARRAY_SIZE(__event_fields___##_template),		\
> +	.nr_metadata =3D ARRAY_SIZE(__type_metadata_for__##_template),	\
>  	.owner =3D THIS_MODULE,				     		\
>  };
>  =

> @@ -379,9 +471,12 @@ static __used struct lttng_probe_desc TP_ID(__probe_=
desc___, TRACE_SYSTEM) =3D {
>  #undef TP_ID
>  =

>  /*
> - * Stage 6 of the trace events.
> + * Stage 6.0 of the trace events.
>   *
>   * Create static inline function that calculates event size.
> + *
> + * First stage creates function to calculate sizes of sub-metadata
> + * (with no effect on the dynamic length values)

This approach seems to only consider the case where you memcpy a struct
directly into the buffers, no ?

How does it deal with copying field-by-field into the structure's fields ?

On a different point, I see nothing here that documents where/how
recursion that could happen by nesting an array within itself is
handled.

Thanks,

Mathieu

>   */
>  =

>  #include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT */
> @@ -403,6 +498,57 @@ static __used struct lttng_probe_desc TP_ID(__probe_=
desc___, TRACE_SYSTEM) =3D {
>  	__event_len +=3D lib_ring_buffer_align(__event_len, lttng_alignof(u32))=
;   \
>  	__event_len +=3D sizeof(u32);					       \
>  	__event_len +=3D lib_ring_buffer_align(__event_len, lttng_alignof(_type=
)); \
> +	__event_len +=3D sizeof(_type) * (_length);			       \
> +
> +#undef __string
> +#define __string(_item, _src)						       \
> +	__event_len +=3D strlen(_src) + 1;
> +
> +/*
> + * strlen_user includes \0. If returns 0, it faulted, so we set size to
> + * 1 (\0 only).
> + */
> +#undef __string_from_user
> +#define __string_from_user(_item, _src)					       \
> +	__event_len +=3D max_t(size_t, lttng_strlen_user_inatomic(_src), 1);
> +
> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	__event_len +=3D __struct_get_size__##_provider##_##_type(_params);\
> +
> +#undef TP_PROTO
> +#define TP_PROTO(args...) args
> +
> +#undef TP_STRUCT__entry
> +#define TP_STRUCT__entry(args...) args
> +
> +#undef TP_FIELDS
> +#define TP_FIELDS(args...) args
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
> +static inline size_t __struct_get_size__##_provider##_##_name(_proto)   \
> +	{								\
> +	size_t __event_len =3D 0;						\
> +									\
> +	_fields								\
> +	return __event_len;						\
> +}
> +
> +#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> +
> +/*
> + * Stage 6.1 of the trace events.
> + *
> + * Create static inline function that calculates event size, this time a=
dding
> + * the size to the dynamic_len array
> + */
> +
> +#undef __dynamic_array_enc_ext
> +#define __dynamic_array_enc_ext(_type, _item, _length, _order, _base, _e=
ncoding)\
> +	__event_len +=3D lib_ring_buffer_align(__event_len, lttng_alignof(u32))=
; \
> +	__event_len +=3D sizeof(u32);					       \
> +	__event_len +=3D lib_ring_buffer_align(__event_len, lttng_alignof(_type=
));\
>  	__dynamic_len[__dynamic_len_idx] =3D (_length);			       \
>  	__event_len +=3D sizeof(_type) * __dynamic_len[__dynamic_len_idx];     =
  \
>  	__dynamic_len_idx++;
> @@ -420,11 +566,13 @@ static __used struct lttng_probe_desc TP_ID(__probe=
_desc___, TRACE_SYSTEM) =3D {
>  	__event_len +=3D __dynamic_len[__dynamic_len_idx++] =3D		       \
>  		max_t(size_t, lttng_strlen_user_inatomic(_src), 1);
>  =

> -#undef TP_PROTO
> -#define TP_PROTO(args...) args
> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	__event_len +=3D __dynamic_len[__dynamic_len_idx++] =3D		\
> +		__struct_get_size__##_provider##_##_type(_params);
>  =

> -#undef TP_STRUCT__entry
> -#define TP_STRUCT__entry(args...) args
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)
>  =

>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(_name, _proto, _args, _tstruct, _assign, _pr=
int)  \
> @@ -470,12 +618,36 @@ static inline size_t __event_get_size__##_name(size=
_t *__dynamic_len, _proto) \
>  #undef __string_from_user
>  #define __string_from_user(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	__event_align =3D max_t(size_t, __event_align,			\
> +		__instruct_get_align__##_provider##_##_type(_params));
> +
>  #undef TP_PROTO
>  #define TP_PROTO(args...) args
>  =

> +#undef TP_ARGS
> +#define TP_ARGS(args...) args
> +
>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...) args
>  =

> +#undef TP_FIELDS
> +#define TP_FIELDS(args...) args
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
> +static inline size_t __struct_get_align__##_provider##_##_name(_proto)	\
> +{									\
> +	size_t __event_align =3D 1;					\
> +	_fields								\
> +	return __event_align;						\
> +}									\
> +static inline size_t __instruct_get_align__##_provider##_##_name(_proto)\
> +{									\
> +	return __struct_get_align__##_provider##_##_name(_args);	\
> +}
> +
>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(_name, _proto, _args, _tstruct, _assign, _pr=
int)  \
>  static inline size_t __event_get_align__##_name(_proto)			      \
> @@ -487,7 +659,6 @@ static inline size_t __event_get_align__##_name(_prot=
o)			      \
>  =

>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>  =

> -
>  /*
>   * Stage 8 of the trace events.
>   *
> @@ -517,6 +688,9 @@ static inline size_t __event_get_align__##_name(_prot=
o)			      \
>  #define __string_from_user(_item, _src)		\
>  	__string(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)	char _item;
> +
>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...) args
>  =

> @@ -528,7 +702,6 @@ struct __event_typemap__##_name {					      \
>  =

>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>  =

> -
>  /*
>   * Stage 9 of the trace events.
>   *
> @@ -568,6 +741,11 @@ __end_field_##_item:
>  #define __string_from_user(_item, _src)					\
>  	__string(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	goto __assign_##_item;						\
> +__end_field_##_item:
> +
>  /*
>   * Macros mapping tp_assign() to "=3D", tp_memcpy() to memcpy() and tp_s=
trcpy() to
>   * strcpy().
> @@ -624,12 +802,24 @@ __assign_##dest##_2:							\
>  #define tp_memcpy_dyn_from_user(dest, src)				\
>  	tp_memcpy_dyn_gen(event_write_from_user, dest, src)
>  =

> +#undef tp_memcpy_struct_gen
> +#define tp_memcpy_struct_gen(write_ops, provider, name, dest, src)	\
> +__assign_##dest:							\
> +	lib_ring_buffer_align_ctx(&__ctx, __struct_get_align__##provider##_##na=
me(src));\
> +	__chan->ops->write_ops(&__ctx, src,				\
> +		sizeof(__typemap.dest) * __get_dynamic_array_len(dest));\
> +	goto __end_field_##dest;
> +
> +#undef tp_memcpy_struct
> +#define tp_memcpy_struct(provider, name, dest, src)	\
> +		tp_memcpy_struct_gen(event_write, provider, name, dest, src)
> +
>  /*
>   * The string length including the final \0.
>   */
>  #undef tp_copy_string_from_user
>  #define tp_copy_string_from_user(dest, src)				\
> -	__assign_##dest:						\
> +__assign_##dest:							\
>  	{								\
>  		size_t __ustrlen;					\
>  									\
> -- =

> 1.8.2.1
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
