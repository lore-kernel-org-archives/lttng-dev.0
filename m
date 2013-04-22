From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: [RFC-patch] Add support of struct metadata in
	tracepoints
Date: Mon, 22 Apr 2013 11:25:33 -0400
Message-ID: <5175566D.9080106__18651.0759791874$1366645812$gmane$org@versatic.net>
References: <1366309257-17855-1-git-send-email-gbastien+lttng@versatic.net>
	<20130421135006.GA27816@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien@versatic.net>) id 1UUIcZ-00082N-Ho
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 11:25:36 -0400
In-Reply-To: <20130421135006.GA27816@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 04/21/2013 09:50 AM, Mathieu Desnoyers wrote:
> * Genevi=E8ve Bastien (gbastien+lttng@versatic.net) wrote:
>> Introduce the new macro TRACEPOINT_STRUCT to define ctf struct metadata
>> that can be used by tracepoints using _struct as entry and tp_memcpy_str=
uct
>> to copy a struct field.
>> Struct metadata can contain nested structs.
>> This extra metadata is added to the metadata file only if events use it.
> Have you tried nesting structures into a sequence or array ? What
> changes would be needed to support this ?
No I haven't tried.  And supporting this wouldn't be trivial. Sequences =

and arrays are associated with basic types (in the lttng_type struct) =

and use assign functions memcpy to assign the data.  That supposes the =

elements of the array or sequence are sequential in memory themselves.

That assumption does not work for struct (and variants), especially =

those whose fields are already not sequential (field-by-field copy, see =

comment below).

Supporting that would mean changes to many of the structs in =

/lttng-events.h.  And an extra level of macro to indicate how to loop =

for each element of the array or sequence.

To illustrate, here is more or less what it could be like.

TRACEPOINT_STRUCT(provider, name, TP_PROTO(struct foo *one, struct bar =

*loop), [...])

TRACE_EVENT([...],

     TP_STRUCT__entry(
         __array(STRUCT(provider, name, one, loop), arr_struct, 5)
     ),
     TP_fast_assign(
         tp_assign_array(arr_struct, one, TP_LOOP(loop))
         // where loop[i] is a struct bar *
     )
)

>
> More comments below,
>
>> Signed-off-by: Genevi=E8ve Bastien <gbastien+lttng@versatic.net>
>> ---
>>   lttng-events.c              | 166 ++++++++++++++++++++++++++++++++++-
>>   lttng-events.h              |  44 ++++++++++
>>   probes/lttng-events-reset.h |  15 ++++
>>   probes/lttng-events.h       | 206 ++++++++++++++++++++++++++++++++++++=
++++++--
>>   4 files changed, 421 insertions(+), 10 deletions(-)
>>
[...]
>> diff --git a/probes/lttng-events-reset.h b/probes/lttng-events-reset.h
>> index 44e8ba5..dd60ca6 100644
>> --- a/probes/lttng-events-reset.h
>> +++ b/probes/lttng-events-reset.h
>> @@ -20,6 +20,9 @@
>>   =

>>   /* Reset macros used within TRACE_EVENT to "nothing" */
>>   =

>> +#undef TRACE_METADATA
>> +#define TRACE_METADATA 1
> What is TRACE_METADATA used for ?
The type metadata macros must be enclosed between #ifdef TRACE_METADATA =

#endif, otherwise they are preprocessed in a first pass by the =

linux/include/tracepoint.h file and since those macros are not defined =

there they are copied as is and give error.
>
>> +
>>   #undef __field_full
>>   #define __field_full(_type, _item, _order, _base)
>>   =

>> @@ -35,6 +38,9 @@
>>   #undef __string
>>   #define __string(_item, _src)
>>   =

>> +#undef __struct
>> +#define __struct(_provider, _type, _item, _params)
>> +
>>   #undef tp_assign
>>   #define tp_assign(dest, src)
>>   =

>> @@ -47,6 +53,9 @@
>>   #undef tp_strcpy
>>   #define tp_strcpy(dest, src)
>>   =

>> +#undef tp_memcpy_struct
>> +#define tp_memcpy_struct(provider, name, dest, src)
>> +
>>   #undef __get_str
>>   #define __get_str(field)
>>   =

>> @@ -65,6 +74,9 @@
>>   #undef TP_STRUCT__entry
>>   #define TP_STRUCT__entry(args...)
>>   =

>> +#undef TP_FIELDS
>> +#define TP_FIELDS(args...)
>> +
>>   #undef TP_fast_assign
>>   #define TP_fast_assign(args...)
>>   =

>> @@ -94,3 +106,6 @@
>>   =

>>   #undef TRACE_EVENT_FLAGS
>>   #define TRACE_EVENT_FLAGS(name, value)
>> +
>> +#undef TRACEPOINT_STRUCT
>> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)
>> diff --git a/probes/lttng-events.h b/probes/lttng-events.h
>> index 8a3a886..93f4abc 100644
>> --- a/probes/lttng-events.h
>> +++ b/probes/lttng-events.h
>> @@ -263,9 +263,31 @@ void trace_##_name(void *__data);
>>   #define __string_from_user(_item, _src)				\
>>   	__string(_item, _src)
>>   =

>> +#undef __struct
>> +#define __struct(_provider, _type, _item, _params)		\
>> +	{							\
>> +	  .name =3D #_item,					\
>> +	  .type =3D						\
>> +	  {							\
>> +		.atype =3D atype_struct,				\
>> +		.u.ctf_struct.provider =3D #_provider,		\
>> +		.u.ctf_struct.name =3D #_type,			\
>> +	  },							\
>> +	},
>> +
>>   #undef TP_STRUCT__entry
>>   #define TP_STRUCT__entry(args...) args	/* Only one used in this phase =
*/
>>   =

>> +#undef TP_FIELDS
>> +#define TP_FIELDS(args...) args	/* Only one used in this phase */
>> +
>> +#undef TRACEPOINT_STRUCT
>> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
>> +	static const struct lttng_event_field			\
>> +		__struct_fields___##_provider##_##_name[] =3D {	\
>> +			_fields					\
>> +	};
>> +
>>   #undef DECLARE_EVENT_CLASS_NOARGS
>>   #define DECLARE_EVENT_CLASS_NOARGS(_name, _tstruct, _assign, _print) \
>>   	static const struct lttng_event_field __event_fields___##_name[] =3D =
{ \
>> @@ -301,6 +323,74 @@ static void __event_probe__##_name(void *__data);
>>   #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>   =

>>   /*
>> + * Stage 3.2 of the trace events.
>> + *
>> + * Create type metadata description
>> + */
>> +
>> +#include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT =
*/
>> +
>> +#undef TRACEPOINT_STRUCT
>> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
>> +static struct lttng_struct_desc __struct_desc___##_provider##_##_name =
=3D {\
>> +		.fields =3D __struct_fields___##_provider##_##_name,	\
>> +		.nr_fields =3D ARRAY_SIZE(__struct_fields___##_provider##_##_name),\
>> +		.provider =3D #_provider,					\
>> +		.name =3D #_name,						\
>> +		.owner =3D THIS_MODULE,					\
>> +	};
>> +
>> +#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>> +
>> +/*
>> + * Stage 3.3 of the trace events.
>> + *
>> + * Associate metadata description to event or event template or other s=
truct
>> + */
>> +
>> +/* Named field types must be defined in lttng-types.h */
>> +
>> +#include "lttng-events-reset.h"	/* Reset all macros within TRACE_EVENT =
*/
>> +
>> +#undef __struct
>> +#define __struct(_provider, _type, _item, _params)			\
>> +	{								\
>> +		.mtype =3D mtype_struct,					\
>> +		.m.ctf_st.struct_desc =3D &__struct_desc___##_provider##_##_type,\
>> +		.m.ctf_st.type_metadata =3D __type_metadata_for__##_provider##_##_typ=
e,\
>> +		.m.ctf_st.nr_metadata =3D ARRAY_SIZE(__type_metadata_for__##_provider=
##_##_type),\
>> +	},
>> +
>> +
>> +#undef TP_STRUCT__entry
>> +#define TP_STRUCT__entry(args...) args	/* Only one used in this phase */
>> +
>> +#undef TP_FIELDS
>> +#define TP_FIELDS(args...) args
>> +
>> +#undef TRACEPOINT_STRUCT
>> +#define TRACEPOINT_STRUCT(_provider, _name, _proto, _args, _fields)	\
>> +static const struct lttng_metadata __type_metadata_for__##_provider##_#=
#_name[] =3D {\
>> +	_fields								\
>> +};
>> +
>> +
>> +
>> +#undef DECLARE_EVENT_CLASS_NOARGS
>> +#define DECLARE_EVENT_CLASS_NOARGS(_name, _tstruct, _assign, _print) \
>> +static const struct lttng_metadata __type_metadata_for__##_name[] =3D {=
	\
>> +	_tstruct		\
>> +};
>> +
>> +#undef DECLARE_EVENT_CLASS
>> +#define DECLARE_EVENT_CLASS(_name, _proto, _args, _tstruct, _assign, _p=
rint) \
>> +	DECLARE_EVENT_CLASS_NOARGS(_name, PARAMS(_tstruct), PARAMS(_assign), \
>> +			PARAMS(_print))
>> +
>> +#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>> +
>> +
>> +/*
>>    * Stage 3.9 of the trace events.
>>    *
>>    * Create event descriptions.
>> @@ -318,9 +408,11 @@ static void __event_probe__##_name(void *__data);
>>   #define DEFINE_EVENT_MAP_NOARGS(_template, _name, _map)			\
>>   static const struct lttng_event_desc __event_desc___##_map =3D {		\
>>   	.fields =3D __event_fields___##_template,		     		\
>> +	.type_metadata =3D __type_metadata_for__##_template,		\
>>   	.name =3D #_map,					     		\
>>   	.probe_callback =3D (void *) TP_PROBE_CB(_template),   		\
>>   	.nr_fields =3D ARRAY_SIZE(__event_fields___##_template),		\
>> +	.nr_metadata =3D ARRAY_SIZE(__type_metadata_for__##_template),	\
>>   	.owner =3D THIS_MODULE,				     		\
>>   };
>>   =

>> @@ -379,9 +471,12 @@ static __used struct lttng_probe_desc TP_ID(__probe=
_desc___, TRACE_SYSTEM) =3D {
>>   #undef TP_ID
>>   =

>>   /*
>> - * Stage 6 of the trace events.
>> + * Stage 6.0 of the trace events.
>>    *
>>    * Create static inline function that calculates event size.
>> + *
>> + * First stage creates function to calculate sizes of sub-metadata
>> + * (with no effect on the dynamic length values)
> This approach seems to only consider the case where you memcpy a struct
> directly into the buffers, no ?
Indeed this is the implemented case here (and the easiest for a start).  =

It is useful when what you want is to copy a C struct and have its =

fields available directly in the metadata.  For this case, I'll change =

the macro name to TRACEPOINT_STRUCT_RAW to indicate that it is just =

field description, no field-by-field copy.
>
> How does it deal with copying field-by-field into the structure's fields ?
The TRACEPOINT_STRUCT macro should do it by adding an extra argument: =

TP_fast_assign that would be like the one for the events. A function =

would be created for it, similar to __event_probe__#_eventname and would =

be called by the macro tp_struct_assign(...) inside a TP_fast_assign.

That extension should be fairly easy to implement.  But I wouldn't do it =

in the scope of this patch.
>
> On a different point, I see nothing here that documents where/how
> recursion that could happen by nesting an array within itself is
> handled.
I will add those comments where necessary.

Thanks, Genevi=E8ve

[...]
