From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Make python bindings
	compile	with trunk
Date: Thu, 27 Jun 2013 09:10:22 -0400
Message-ID: <20130627131022.GA20611__18646.7659463689$1372338665$gmane$org@Krystal>
References: <CAMMh03NJNPvYEcXLcaUBhiJTgM2hEQm1Q8-pL0nRSixNPc0ctA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UsBxz-0001Fj-5u
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 09:10:27 -0400
Content-Disposition: inline
In-Reply-To: <CAMMh03NJNPvYEcXLcaUBhiJTgM2hEQm1Q8-pL0nRSixNPc0ctA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Xiaona Han <xiaonahappy13@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Xiaona Han (xiaonahappy13@gmail.com) wrote:
> Signed-off-by: Xiaona Han <xiaonahappy13@gmail.com>
> ---
>  bindings/python/babeltrace.i.in      |   73
> +++++++++++++++++-----------------
>  bindings/python/python-complements.c |   12 +++---
>  bindings/python/python-complements.h |    8 ++--
>  3 files changed, 46 insertions(+), 47 deletions(-)
> 
> diff --git a/bindings/python/babeltrace.i.in b/bindings/python/
> babeltrace.i.in
> index a5426c8..bb0a9b3 100644
> --- a/bindings/python/babeltrace.i.in
> +++ b/bindings/python/babeltrace.i.in
> @@ -45,7 +45,6 @@ trace to it."
>  #include <babeltrace/iterator-internal.h>
>  #include <babeltrace/format.h>
>  #include <babeltrace/list.h>
> -#include <babeltrace/uuid.h>
>  #include <babeltrace/types.h>
>  #include <babeltrace/ctf/iterator.h>
>  #include "python-complements.h"
> @@ -74,8 +73,8 @@ typedef int bt_intern_str;
> 
>  struct bt_context *bt_context_create(void);
>  int bt_context_add_trace(struct bt_context *ctx, const char *path, const
> char *format,
> -        void (*packet_seek)(struct stream_pos *pos, size_t index, int
> whence),

I think your patch has line wrapping issues. Please check your email
client.

Thanks,

Mathieu

> -        struct mmap_stream_list *stream_list, FILE *metadata);
> +        void (*packet_seek)(struct bt_stream_pos *pos, size_t index, int
> whence),
> +        struct bt_mmap_stream_list *stream_list, FILE *metadata);
>  void bt_context_remove_trace(struct bt_context *ctx, int trace_id);
>  void bt_context_get(struct bt_context *ctx);
>  void bt_context_put(struct bt_context *ctx);
> @@ -192,7 +191,7 @@ class Context:
> 
>  extern struct format *bt_lookup_format(bt_intern_str qname);
>  extern void bt_fprintf_format_list(FILE *fp);
> -extern int bt_register_format(struct format *format);
> +extern int bt_register_format(struct bt_format *format);
> 
>  %pythoncode %{
> 
> @@ -550,58 +549,58 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct
> bt_ctf_iter *iter);
>          const struct bt_ctf_event *ctf_event);
> 
>  %rename("_bt_ctf_get_field") bt_ctf_get_field(const struct bt_ctf_event
> *ctf_event,
> -        const struct definition *scope,    const char *field);
> +        const struct bt_definition *scope,    const char *field);
>  %rename("_bt_ctf_get_index") bt_ctf_get_index(const struct bt_ctf_event
> *ctf_event,
> -        const struct definition *field,    unsigned int index);
> -%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct definition
> *field);
> -%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct declaration
> *field);
> +        const struct bt_definition *field,    unsigned int index);
> +%rename("_bt_ctf_field_name") bt_ctf_field_name(const struct bt_definition
> *field);
> +%rename("_bt_ctf_field_type") bt_ctf_field_type(const struct
> bt_declaration *field);
>  %rename("_bt_ctf_get_int_signedness") bt_ctf_get_int_signedness(
> -        const struct declaration *field);
> -%rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct
> declaration *field);
> +        const struct bt_declaration *field);
> +%rename("_bt_ctf_get_int_base") bt_ctf_get_int_base(const struct
> bt_declaration *field);
>  %rename("_bt_ctf_get_int_byte_order") bt_ctf_get_int_byte_order(
> -        const struct declaration *field);
> -%rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct declaration
> *field);
> -%rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct
> declaration *field);
> -%rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct
> declaration *field);
> -%rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct definition
> *field);
> -%rename("_bt_ctf_get_int64") bt_ctf_get_int64(const struct definition
> *field);
> -%rename("_bt_ctf_get_char_array") bt_ctf_get_char_array(const struct
> definition *field);
> -%rename("_bt_ctf_get_string") bt_ctf_get_string(const struct definition
> *field);
> +        const struct bt_declaration *field);
> +%rename("_bt_ctf_get_int_len") bt_ctf_get_int_len(const struct
> bt_declaration *field);
> +%rename("_bt_ctf_get_encoding") bt_ctf_get_encoding(const struct
> bt_declaration *field);
> +%rename("_bt_ctf_get_array_len") bt_ctf_get_array_len(const struct
> bt_declaration *field);
> +%rename("_bt_ctf_get_uint64") bt_ctf_get_uint64(const struct bt_definition
> *field);
> +%rename("_bt_ctf_get_int64") bt_ctf_get_int64(const struct bt_definition
> *field);
> +%rename("_bt_ctf_get_char_array") bt_ctf_get_char_array(const struct
> bt_definition *field);
> +%rename("_bt_ctf_get_string") bt_ctf_get_string(const struct bt_definition
> *field);
>  %rename("_bt_ctf_field_get_error") bt_ctf_field_get_error(void);
>  %rename("_bt_ctf_get_decl_event_name") bt_ctf_get_decl_event_name(const
> struct
>          bt_ctf_event_decl *event);
>  %rename("_bt_ctf_get_decl_field_name") bt_ctf_get_decl_field_name(
>          const struct bt_ctf_field_decl *field);
>  %rename("_bt_ctf_get_decl_from_def") bt_ctf_get_decl_from_def(
> -        const struct definition *field);
> +        const struct bt_definition *field);
> 
> -const struct definition *bt_ctf_get_top_level_scope(const struct
> bt_ctf_event *ctf_event,
> +const struct bt_definition *bt_ctf_get_top_level_scope(const struct
> bt_ctf_event *ctf_event,
>          enum bt_ctf_scope scope);
>  const char *bt_ctf_event_name(const struct bt_ctf_event *ctf_event);
>  uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event);
>  uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event);
> -const struct definition *bt_ctf_get_field(const struct bt_ctf_event
> *ctf_event,
> -        const struct definition *scope,
> +const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_event
> *ctf_event,
> +        const struct bt_definition *scope,
>          const char *field);
> -const struct definition *bt_ctf_get_index(const struct bt_ctf_event
> *ctf_event,
> -        const struct definition *field,
> +const struct bt_definition *bt_ctf_get_index(const struct bt_ctf_event
> *ctf_event,
> +        const struct bt_definition *field,
>          unsigned int index);
> -const char *bt_ctf_field_name(const struct definition *field);
> -enum ctf_type_id bt_ctf_field_type(const struct declaration *field);
> -int bt_ctf_get_int_signedness(const struct declaration *field);
> -int bt_ctf_get_int_base(const struct declaration *field);
> -int bt_ctf_get_int_byte_order(const struct declaration *field);
> -ssize_t bt_ctf_get_int_len(const struct declaration *field);
> -enum ctf_string_encoding bt_ctf_get_encoding(const struct declaration
> *field);
> -int bt_ctf_get_array_len(const struct declaration *field);
> -uint64_t bt_ctf_get_uint64(const struct definition *field);
> -int64_t bt_ctf_get_int64(const struct definition *field);
> -char *bt_ctf_get_char_array(const struct definition *field);
> -char *bt_ctf_get_string(const struct definition *field);
> +const char *bt_ctf_field_name(const struct bt_definition *field);
> +enum ctf_type_id bt_ctf_field_type(const struct bt_declaration *field);
> +int bt_ctf_get_int_signedness(const struct bt_declaration *field);
> +int bt_ctf_get_int_base(const struct bt_declaration *field);
> +int bt_ctf_get_int_byte_order(const struct bt_declaration *field);
> +ssize_t bt_ctf_get_int_len(const struct bt_declaration *field);
> +enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declaration
> *field);
> +int bt_ctf_get_array_len(const struct bt_declaration *field);
> +uint64_t bt_ctf_get_uint64(const struct bt_definition *field);
> +int64_t bt_ctf_get_int64(const struct bt_definition *field);
> +char *bt_ctf_get_char_array(const struct bt_definition *field);
> +char *bt_ctf_get_string(const struct bt_definition *field);
>  int bt_ctf_field_get_error(void);
>  const char *bt_ctf_get_decl_event_name(const struct bt_ctf_event_decl
> *event);
>  const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl
> *field);
> -const struct declaration *bt_ctf_get_decl_from_def(const struct definition
> *field);
> +const struct bt_declaration *bt_ctf_get_decl_from_def(const struct
> bt_definition *field);
> 
>  %pythoncode%{
> 
> diff --git a/bindings/python/python-complements.c
> b/bindings/python/python-complements.c
> index a4ee37e..aa65555 100644
> --- a/bindings/python/python-complements.c
> +++ b/bindings/python/python-complements.c
> @@ -44,16 +44,16 @@ void _bt_file_close(FILE *fp)
>  */
> 
>  /* ctf-field-list */
> -struct definition **_bt_python_field_listcaller(
> +struct bt_definition **_bt_python_field_listcaller(
>          const struct bt_ctf_event *ctf_event,
> -        const struct definition *scope)
> +        const struct bt_definition *scope)
>  {
> -    struct definition **list;
> +    struct bt_definition **list;
>      unsigned int count;
>      int ret;
> 
>      ret = bt_ctf_get_field_list(ctf_event, scope,
> -        (const struct definition * const **)&list, &count);
> +        (const struct bt_definition * const **)&list, &count);
> 
>      if (ret < 0)    /* For python to know an error occured */
>          list = NULL;
> @@ -63,8 +63,8 @@ struct definition **_bt_python_field_listcaller(
>      return list;
>  }
> 
> -struct definition *_bt_python_field_one_from_list(
> -        struct definition **list, int index)
> +struct bt_definition *_bt_python_field_one_from_list(
> +        struct bt_definition **list, int index)
>  {
>      return list[index];
>  }
> diff --git a/bindings/python/python-complements.h
> b/bindings/python/python-complements.h
> index 9597d70..4335d8a 100644
> --- a/bindings/python/python-complements.h
> +++ b/bindings/python/python-complements.h
> @@ -32,11 +32,11 @@ FILE *_bt_file_open(char *file_path, char *mode);
>  void _bt_file_close(FILE *fp);
> 
>  /* ctf-field-list */
> -struct definition **_bt_python_field_listcaller(
> +struct bt_definition **_bt_python_field_listcaller(
>          const struct bt_ctf_event *ctf_event,
> -        const struct definition *scope);
> -struct definition *_bt_python_field_one_from_list(
> -        struct definition **list, int index);
> +        const struct bt_definition *scope);
> +struct bt_definition *_bt_python_field_one_from_list(
> +        struct bt_definition **list, int index);
> 
>  /* event_decl_list */
>  struct bt_ctf_event_decl **_bt_python_event_decl_listcaller(
> -- 
> 1.7.1

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
