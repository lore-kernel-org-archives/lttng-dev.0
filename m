From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-patch] Add support of struct metadata
	in	tracepoints
Date: Thu, 11 Apr 2013 16:46:44 -0400
Message-ID: <20130411204644.GA27227__43794.4150566638$1365713235$gmane$org@Krystal>
References: <1365710851-1690-1-git-send-email-gbastien+lttng@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UQOOP-0002zS-2x
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 16:46:49 -0400
Content-Disposition: inline
In-Reply-To: <1365710851-1690-1-git-send-email-gbastien+lttng@versatic.net>
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
> This extra metadata is added to the metadata file only if events use it.
> =

> Signed-off-by: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
> ---
>  lttng-events.c              | 134 ++++++++++++++++++++++++++++++++++++++=
+++-
>  lttng-events.h              |  35 +++++++++++
>  probes/lttng-events-reset.h |  15 +++++
>  probes/lttng-events.h       | 138 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  4 files changed, 320 insertions(+), 2 deletions(-)
> =

> diff --git a/lttng-events.c b/lttng-events.c
> index 4f30904..431a17c 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -654,6 +654,13 @@ int _lttng_field_statedump(struct lttng_session *ses=
sion,
>  				" { encoding =3D ASCII; }" : "",
>  			field->name);
>  		break;
> +	case atype_struct:
> +		ret =3D lttng_metadata_printf(session,
> +			"		struct %s%s _%s;\n",

I think an underscore is missing:

                        "               struct %s_%s _%s;\n"

> +			field->type.u.ctf_struct.provider,
> +			field->type.u.ctf_struct.name,
> +			field->name);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return -EINVAL;
> @@ -662,6 +669,122 @@ int _lttng_field_statedump(struct lttng_session *se=
ssion,
>  }
>  =

>  static
> +int _lttng_is_extra_metadata_dumped(struct lttng_session *session,

rather than "extra_metadata", can we call this "type_metadata" ?

"extra" is rather "extra vague" ;-)

> +		const struct lttng_metadata *metadata) {

newline before { (coding style, this applies to other functions below
too)

> +	/* Is the metadata dumped yet ? */
> +	struct lttng_metadata_dumped *dumped;
> +	int is_dumped =3D 0;
> +
> +	dumped =3D session->extra_metadata[metadata->mtype];
> +	switch (metadata->mtype) {
> +	case mtype_struct:
> +		while (dumped) {

it looks like a for() would be clearer than a while.

> +			if (metadata->m.struct_desc =3D=3D
> +					dumped->dumped_ptr.struct_desc) {
> +				is_dumped =3D 1;
> +				break;
> +			}
> +			dumped =3D dumped->next;
> +		}
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +	return is_dumped;
> +}
> +
> +static int _lttng_extra_metadata_mark_dumped(struct lttng_session *sessi=
on,
> +		const struct lttng_metadata *metadata) {
> +	/* mark this metadata as dumped */
> +	struct lttng_metadata_dumped *dumped, *just_dumped;
> +
> +	just_dumped =3D kzalloc(sizeof(struct lttng_metadata_dumped),
> +			GFP_KERNEL);
> +	if (!just_dumped)
> +		return -ENOMEM;
> +
> +	dumped =3D session->extra_metadata[metadata->mtype];
> +
> +	switch (metadata->mtype) {
> +	case mtype_struct:
> +		just_dumped->dumped_ptr.struct_desc =3D metadata->m.struct_desc;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);

memory leak of just_dumped.

> +		return -EINVAL;
> +	}
> +
> +	just_dumped->next =3D session->extra_metadata[mtype_struct];
> +	session->extra_metadata[mtype_struct] =3D just_dumped;
> +	return 0;
> +}
> +
> +static
> +int _lttng_event_extra_metadata_do_statedump(struct lttng_session *sessi=
on,
> +		const struct lttng_metadata *meta)
> +{
> +	int i, ret =3D 0;
> +
> +	switch (meta->mtype) {
> +	case mtype_struct:

remove newline.

> +
> +		ret =3D lttng_metadata_printf(session,
> +			"struct %s%s {\n",

missing underscore ?

> +			meta->m.struct_desc->provider, meta->m.struct_desc->name
> +		);
> +		if (ret)
> +			return ret;
> +
> +		/* Print fields */
> +		for (i =3D 0; i < meta->m.struct_desc->nr_fields; i++) {
> +			const struct lttng_event_field *field;

add newline.

> +			field =3D &meta->m.struct_desc->fields[i];

remove newline.

> +
> +			ret =3D _lttng_field_statedump(session, field);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		ret =3D lttng_metadata_printf(session,
> +				"};\n\n");
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +	if (ret)
> +		return ret;
> +
> +	ret =3D _lttng_extra_metadata_mark_dumped(session, meta);
> +	return ret;
> +}
> +
> +static
> +int _lttng_event_extra_metadata_statedump(struct lttng_session *session,
> +			 struct lttng_event *event)
> +{
> +	const struct lttng_event_desc *desc =3D event->desc;
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; i < desc->nr_metadata; i++) {
> +		const struct lttng_metadata *meta =3D &desc->extra_metadata[i];
> +
> +		if (!_lttng_is_extra_metadata_dumped(session, meta)) {

if (_lttng_is_extra_metadata_dumped(session, meta))
        continue;

will save an indent level.

> +			ret =3D _lttng_event_extra_metadata_do_statedump(session,
> +					meta);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return ret;
> +
> +}
> +
> +static
>  int _lttng_context_metadata_statedump(struct lttng_session *session,
>  				    struct lttng_ctx *ctx)
>  {
> @@ -710,6 +833,11 @@ int _lttng_event_metadata_statedump(struct lttng_ses=
sion *session,
>  	if (chan =3D=3D session->metadata)
>  		return 0;
>  =

> +	/* Dump the extra metadata for this event */
> +	ret =3D _lttng_event_extra_metadata_statedump(session, event);
> +	if (ret)
> +		goto end;
> +
>  	ret =3D lttng_metadata_printf(session,
>  		"event {\n"
>  		"	name =3D %s;\n"
> @@ -905,7 +1033,7 @@ int _lttng_session_metadata_statedump(struct lttng_s=
ession *session)
>  	unsigned char uuid_s[37], clock_uuid_s[BOOT_ID_LEN];
>  	struct lttng_channel *chan;
>  	struct lttng_event *event;
> -	int ret =3D 0;
> +	int ret =3D 0, i;
>  =

>  	if (!ACCESS_ONCE(session->active))
>  		return 0;
> @@ -1042,6 +1170,10 @@ int _lttng_session_metadata_statedump(struct lttng=
_session *session)
>  	if (ret)
>  		goto end;
>  =

> +	/* Initialized undumped metadata */
> +	for (i =3D 0; i < NR_METADATA_TYPES; i++)
> +		session->extra_metadata[i] =3D 0;

this initialisation probably belongs to lttng_session_create().

> +
>  skip_session:
>  	list_for_each_entry(chan, &session->chan, list) {
>  		ret =3D _lttng_channel_metadata_statedump(session, chan);
> diff --git a/lttng-events.h b/lttng-events.h
> index 37a5db7..2cab5f3 100644
> --- a/lttng-events.h
> +++ b/lttng-events.h
> @@ -47,9 +47,16 @@ enum abstract_types {
>  	atype_array,
>  	atype_sequence,
>  	atype_string,
> +	atype_struct,
>  	NR_ABSTRACT_TYPES,
>  };
>  =

> +/* Metadata types */
> +enum metadata_types {
> +	mtype_struct,
> +	NR_METADATA_TYPES,
> +};
> +
>  /* Update the string_encodings name table in lttng-types.c along with th=
is enum */
>  enum lttng_string_encodings {
>  	lttng_encode_none =3D 0,
> @@ -115,6 +122,9 @@ struct lttng_type {
>  			struct lttng_basic_type length_type;
>  			struct lttng_basic_type elem_type;
>  		} sequence;
> +		struct {
> +			const char *name, *provider;
> +		} ctf_struct;
>  	} u;
>  };
>  =

> @@ -161,12 +171,36 @@ struct lttng_ctx {
>  	unsigned int allocated_fields;
>  };
>  =

> +struct lttng_struct_desc {
> +	const char *name, *provider;

const char *provider, *name;

seems clearer.

> +	const struct lttng_event_field *fields; /* fields */
> +	unsigned int nr_fields;
> +	struct module *owner;
> +};
> +
> +struct lttng_metadata {
> +	enum metadata_types mtype;
> +	union {
> +		struct lttng_struct_desc *struct_desc;
> +	} m;
> +};
> +
> +struct lttng_metadata_dumped {
> +	union {
> +		struct lttng_struct_desc *struct_desc;
> +	} dumped_ptr;
> +	struct lttng_metadata_dumped *next;
> +};
> +
>  struct lttng_event_desc {
>  	const char *name;
>  	void *probe_callback;
>  	const struct lttng_event_ctx *ctx;	/* context */
>  	const struct lttng_event_field *fields;	/* event payload */
> +	/* Extra metadata added by events */
> +	const struct lttng_metadata *extra_metadata;
>  	unsigned int nr_fields;
> +	unsigned int nr_metadata;
>  	struct module *owner;
>  };
>  =

> @@ -277,6 +311,7 @@ struct lttng_session {
>  	struct list_head list;		/* Session list */
>  	unsigned int free_chan_id;	/* Next chan ID to allocate */
>  	uuid_le uuid;			/* Trace session unique ID */
> +	struct lttng_metadata_dumped *extra_metadata[NR_METADATA_TYPES];
>  	unsigned int metadata_dumped:1;
>  };
>  =

> diff --git a/probes/lttng-events-reset.h b/probes/lttng-events-reset.h
> index 44e8ba5..bf8bbf1 100644
> --- a/probes/lttng-events-reset.h
> +++ b/probes/lttng-events-reset.h
> @@ -20,6 +20,9 @@
>  =

>  /* Reset macros used within TRACE_EVENT to "nothing" */
>  =

> +#undef TRACE_METADATA
> +#define TRACE_METADATA 1
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
> +#define tp_memcpy_struct(dest, src)
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
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _fields)
> diff --git a/probes/lttng-events.h b/probes/lttng-events.h
> index 8a3a886..8465095 100644
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
> +		.u.ctf_struct.name =3D #_type,			\
> +		.u.ctf_struct.provider =3D #_provider,		\
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
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _fields)	\
> +	static const struct lttng_event_field			\
> +		__struct_fields___##_provider##_name[] =3D {	\
> +			_fields					\
> +	};
> +
>  #undef DECLARE_EVENT_CLASS_NOARGS
>  #define DECLARE_EVENT_CLASS_NOARGS(_name, _tstruct, _assign, _print) \
>  	static const struct lttng_event_field __event_fields___##_name[] =3D { \
> @@ -301,6 +323,60 @@ static void __event_probe__##_name(void *__data);
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>  =

>  /*
> + * Stage 3.2 of the trace events.
> + *
> + * Create extra metadata description

extra -> type

> + */
> +
> +#include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT */
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _fields)	\
> +static struct lttng_struct_desc __struct_desc___##_provider##_name =3D {=
	\
> +		.fields =3D __struct_fields___##_provider##_name,		\
> +		.name =3D #_name,		\
> +		.provider =3D #_provider,	\

and exchange the two lines above, again for clarity.

> +		.nr_fields =3D ARRAY_SIZE(__struct_fields___##_provider##_name),\
> +		.owner =3D THIS_MODULE,	\
> +	};
> +
> +#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> +
> +/*
> + * Stage 3.3 of the trace events.
> + *
> + * Associate metadata description to event or event template
> + */
> +
> +/* Named field types must be defined in lttng-types.h */
> +
> +#include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT */
> +
> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)		\
> +	{							\
> +	  .mtype =3D mtype_struct,					\
> +	  .m.struct_desc =3D &__struct_desc___##_provider##_type,	\

2 lines above: change double-spaces to tabs ?

> +	},
> +
> +#undef TP_STRUCT__entry
> +#define TP_STRUCT__entry(args...) args	/* Only one used in this phase */
> +
> +#undef DECLARE_EVENT_CLASS_NOARGS
> +#define DECLARE_EVENT_CLASS_NOARGS(_name, _tstruct, _assign, _print) \
> +static const struct lttng_metadata __metadata_for__##_name[] =3D {	\

maybe call this:

__type_metadata_for__##_name

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
> @@ -318,9 +394,11 @@ static void __event_probe__##_name(void *__data);
>  #define DEFINE_EVENT_MAP_NOARGS(_template, _name, _map)			\
>  static const struct lttng_event_desc __event_desc___##_map =3D {		\
>  	.fields =3D __event_fields___##_template,		     		\
> +	.extra_metadata =3D __metadata_for__##_template,			\
>  	.name =3D #_map,					     		\
>  	.probe_callback =3D (void *) TP_PROBE_CB(_template),   		\
>  	.nr_fields =3D ARRAY_SIZE(__event_fields___##_template),		\
> +	.nr_metadata =3D ARRAY_SIZE(__metadata_for__##_template),		\
>  	.owner =3D THIS_MODULE,				     		\
>  };
>  =

> @@ -420,12 +498,33 @@ static __used struct lttng_probe_desc TP_ID(__probe=
_desc___, TRACE_SYSTEM) =3D {
>  	__event_len +=3D __dynamic_len[__dynamic_len_idx++] =3D		       \
>  		max_t(size_t, lttng_strlen_user_inatomic(_src), 1);
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	__event_len +=3D __dynamic_len[__dynamic_len_idx++] =3D		\
> +		__struct_get_size__##_provider##_type(__dynamic_len, _params);
> +
>  #undef TP_PROTO
>  #define TP_PROTO(args...) args
>  =

>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...) args
>  =

> +#undef TP_FIELDS
> +#define TP_FIELDS(args...) args
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _fields)	\

what happens if a structure has a field that contains itself ?

struct a {
        struct a blah;
}

> +static inline size_t __struct_get_size__##_provider##_name(size_t *__dyn=
amic_len, _proto)\
> +	{								\
> +	size_t __event_len =3D 0;						\
> +	unsigned int __dynamic_len_idx =3D 0;				\
> +									\
> +	if (0)								\
> +		(void) __dynamic_len_idx;	/* don't warn if unused */\
> +	_fields								\
> +	return __event_len;						\
> +}
> +
>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(_name, _proto, _args, _tstruct, _assign, _pr=
int)  \
>  static inline size_t __event_get_size__##_name(size_t *__dynamic_len, _p=
roto) \
> @@ -470,12 +569,29 @@ static inline size_t __event_get_size__##_name(size=
_t *__dynamic_len, _proto) \
>  #undef __string_from_user
>  #define __string_from_user(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)			\
> +	__event_align =3D max_t(size_t, __event_align,			\
> +		__struct_get_align__##_provider##_type(_params));
> +
>  #undef TP_PROTO
>  #define TP_PROTO(args...) args
>  =

>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...) args
>  =

> +#undef TP_FIELDS
> +#define TP_FIELDS(args...) args
> +
> +#undef TRACEPOINT_STRUCT
> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _fields)	\
> +static inline size_t __struct_get_align__##_provider##_name(_proto)	\

same worry here about structure nested within itself.

It might be good to first declare a function that gets the
size/alignment (2 phases like you currently do), but ensure that within
that function, you call a different functions is defined at later
stages, which each simply call into the original function.

This will ensure the compiler will issue an error if we try to nest a
structure within itself.

> +{									\
> +	size_t __event_align =3D 1;					\
> +	_fields								\
> +	return __event_align;						\
> +}
> +
>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(_name, _proto, _args, _tstruct, _assign, _pr=
int)  \
>  static inline size_t __event_get_align__##_name(_proto)			      \
> @@ -517,6 +633,9 @@ static inline size_t __event_get_align__##_name(_prot=
o)			      \
>  #define __string_from_user(_item, _src)		\
>  	__string(_item, _src)
>  =

> +#undef __struct
> +#define __struct(_provider, _type, _item, _params)		char _item;
> +
>  #undef TP_STRUCT__entry
>  #define TP_STRUCT__entry(args...) args
>  =

> @@ -568,6 +687,11 @@ __end_field_##_item:
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
> @@ -624,12 +748,24 @@ __assign_##dest##_2:							\
>  #define tp_memcpy_dyn_from_user(dest, src)				\
>  	tp_memcpy_dyn_gen(event_write_from_user, dest, src)
>  =

> +#undef tp_memcpy_struct_gen
> +#define tp_memcpy_struct_gen(write_ops, dest, src)	\
> +__assign_##dest:							\
> +	lib_ring_buffer_align_ctx(&__ctx, lttng_alignof(__typemap.dest));\

instead of lttng_alignof(__typemap.dest), you should probably call
something that returns the same alignment result as:

        __struct_get_align__##_provider##_type(_params))

above.

Given that a structure can contain a variant, we have to consider that
its alignment should be calculated dynamically. (ref: CTF spec for
Variant type).
  =


> +	__chan->ops->write_ops(&__ctx, src,				\
> +		sizeof(__typemap.dest) * __get_dynamic_array_len(dest));\

I expect that __typemap.dest is a char *, right ?

That's a very good start!

Thanks,

Mathieu

> +	goto __end_field_##dest;
> +
> +#undef tp_memcpy_struct
> +#define tp_memcpy_struct(dest, src)	\
> +		tp_memcpy_struct_gen(event_write, dest, src)
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
