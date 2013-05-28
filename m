From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Add a format-agnostic
	iterator	creation mechanism
Date: Tue, 28 May 2013 13:30:47 -0400
Message-ID: <20130528173047.GD20859__7439.98234761438$1369762289$gmane$org@Krystal>
References: <1369712328-17921-1-git-send-email-jeremie.galarneau@efficios.com>
	<1369712328-17921-3-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UhNjV-00037n-Mf
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 13:30:49 -0400
Content-Disposition: inline
In-Reply-To: <1369712328-17921-3-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Iterators now expose an event providing function so that a user does not
> need to know the input trace format to get "bt_ctf_event"s.
> =

> A context can now create a specialized iterator depending on its input
> trace format.

Please resubmit after API update.

Thanks,

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  converter/babeltrace.c                 | 10 +++---
>  formats/ctf/ctf.c                      |  3 ++
>  formats/ctf/iterator.c                 | 34 +++++++++++++-------
>  include/babeltrace/context-internal.h  |  1 +
>  include/babeltrace/context.h           | 31 ++++++++++++++++++
>  include/babeltrace/ctf/iterator.h      |  6 ++--
>  include/babeltrace/format.h            | 14 +++++++++
>  include/babeltrace/iterator-internal.h |  1 +
>  include/babeltrace/iterator.h          | 11 +++++++
>  lib/context.c                          | 57 ++++++++++++++++++++++++++++=
++++++
>  lib/iterator.c                         | 14 +++++++++
>  tests/lib/test-seeks.c                 | 42 ++++++++++++-------------
>  12 files changed, 183 insertions(+), 41 deletions(-)
> =

> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 8f09845..c86df93 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -617,19 +617,19 @@ static
>  int convert_trace(struct bt_trace_descriptor *td_write,
>  		  struct bt_context *ctx)
>  {
> -	struct bt_ctf_iter *iter;
> +	struct bt_iter *iter;
>  	struct bt_iter_pos begin_pos;
>  	struct bt_ctf_event *ctf_event;
>  	int ret;
>  	const GPtrArray *out_streams =3D bt_trace_descriptor_get_stream_pos(td_=
write);
>  =

>  	begin_pos.type =3D BT_SEEK_BEGIN;
> -	iter =3D bt_ctf_iter_create(ctx, &begin_pos, NULL);
> +	iter =3D bt_context_create_iterator(ctx, &begin_pos, NULL);
>  	if (!iter) {
>  		ret =3D -1;
>  		goto error_iter;
>  	}
> -	while ((ctf_event =3D bt_ctf_iter_read_event(iter))) {
> +	while ((ctf_event =3D bt_iter_get_event(iter))) {
>  		int sout_nr;
>  		for (sout_nr =3D 0; sout_nr < out_streams->len; ++sout_nr) {
>  			struct bt_stream_pos *sout =3D
> @@ -643,7 +643,7 @@ int convert_trace(struct bt_trace_descriptor *td_writ=
e,
>  				goto end;
>  			}
>  		}
> -		ret =3D bt_iter_next(bt_ctf_get_iter(iter));
> +		ret =3D bt_iter_next(iter);
>  		if (ret < 0) {
>  			goto end;
>  		}
> @@ -651,7 +651,7 @@ int convert_trace(struct bt_trace_descriptor *td_writ=
e,
>  	ret =3D 0;
>  =

>  end:
> -	bt_ctf_iter_destroy(iter);
> +	bt_context_destroy_iterator(ctx, iter);
>  error_iter:
>  	return ret;
>  }
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index aee80b1..c029791 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -29,6 +29,7 @@
>  #include <babeltrace/format.h>
>  #include <babeltrace/ctf/types.h>
>  #include <babeltrace/ctf/metadata.h>
> +#include <babeltrace/ctf/iterator.h>
>  #include <babeltrace/babeltrace-internal.h>
>  #include <babeltrace/ctf/events-internal.h>
>  #include <babeltrace/trace-handle-internal.h>
> @@ -144,6 +145,8 @@ struct bt_format ctf_format =3D {
>  	.timestamp_begin =3D ctf_timestamp_begin,
>  	.timestamp_end =3D ctf_timestamp_end,
>  	.convert_index_timestamp =3D ctf_convert_index_timestamp,
> +	.iterator_create =3D bt_ctf_iter_create,
> +	.iterator_destroy =3D bt_ctf_iter_destroy
>  };
>  =

>  static
> diff --git a/formats/ctf/iterator.c b/formats/ctf/iterator.c
> index d2cd914..a294167 100644
> --- a/formats/ctf/iterator.c
> +++ b/formats/ctf/iterator.c
> @@ -30,6 +30,7 @@
>  #include <babeltrace/babeltrace.h>
>  #include <babeltrace/format.h>
>  #include <babeltrace/ctf/events.h>
> +#include <babeltrace/ctf/iterator.h>
>  #include <babeltrace/ctf-ir/metadata.h>
>  #include <babeltrace/prio_heap.h>
>  #include <babeltrace/iterator-internal.h>
> @@ -39,7 +40,7 @@
>  =

>  #include "events-private.h"
>  =

> -struct bt_ctf_iter *bt_ctf_iter_create(struct bt_context *ctx,
> +struct bt_iter *bt_ctf_iter_create(struct bt_context *ctx,
>  		const struct bt_iter_pos *begin_pos,
>  		const struct bt_iter_pos *end_pos)
>  {
> @@ -60,10 +61,11 @@ struct bt_ctf_iter *bt_ctf_iter_create(struct bt_cont=
ext *ctx,
>  	iter->recalculate_dep_graph =3D 0;
>  	iter->main_callbacks.callback =3D NULL;
>  	iter->dep_gc =3D g_ptr_array_new();
> -	return iter;
> +	iter->parent.get_event =3D bt_ctf_iter_read_event;
> +	return &iter->parent;
>  }
>  =

> -void bt_ctf_iter_destroy(struct bt_ctf_iter *iter)
> +void bt_ctf_iter_destroy(struct bt_iter *iter)
>  {
>  	struct bt_stream_callbacks *bt_stream_cb;
>  	struct bt_callback_chain *bt_chain;
> @@ -71,13 +73,16 @@ void bt_ctf_iter_destroy(struct bt_ctf_iter *iter)
>  =

>  	assert(iter);
>  =

> +	struct bt_ctf_iter *ctf_iter =3D
> +		container_of(iter, struct bt_ctf_iter, parent);
> +
>  	/* free all events callbacks */
> -	if (iter->main_callbacks.callback)
> -		g_array_free(iter->main_callbacks.callback, TRUE);
> +	if (ctf_iter->main_callbacks.callback)
> +		g_array_free(ctf_iter->main_callbacks.callback, TRUE);
>  =

>  	/* free per-event callbacks */
> -	for (i =3D 0; i < iter->callbacks->len; i++) {
> -		bt_stream_cb =3D &g_array_index(iter->callbacks,
> +	for (i =3D 0; i < ctf_iter->callbacks->len; i++) {
> +		bt_stream_cb =3D &g_array_index(ctf_iter->callbacks,
>  				struct bt_stream_callbacks, i);
>  		if (!bt_stream_cb || !bt_stream_cb->per_id_callbacks)
>  			continue;
> @@ -90,10 +95,10 @@ void bt_ctf_iter_destroy(struct bt_ctf_iter *iter)
>  		}
>  		g_array_free(bt_stream_cb->per_id_callbacks, TRUE);
>  	}
> -	g_array_free(iter->callbacks, TRUE);
> -	g_ptr_array_free(iter->dep_gc, TRUE);
> +	g_array_free(ctf_iter->callbacks, TRUE);
> +	g_ptr_array_free(ctf_iter->dep_gc, TRUE);
>  =

> -	bt_iter_fini(&iter->parent);
> +	bt_iter_fini(iter);
>  	g_free(iter);
>  }
>  =

> @@ -158,9 +163,14 @@ stop:
>  	return NULL;
>  }
>  =

> -struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_ctf_iter *iter)
> +struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_iter *iter)
>  {
> -	return bt_ctf_iter_read_event_flags(iter, NULL);
> +	struct bt_ctf_iter *ctf_iter;
> +	if (!iter) {
> +		return NULL;
> +	}
> +	ctf_iter =3D container_of(iter, struct bt_ctf_iter, parent);
> +	return bt_ctf_iter_read_event_flags(ctf_iter, NULL);
>  }
>  =

>  uint64_t bt_ctf_get_lost_events_count(struct bt_ctf_iter *iter)
> diff --git a/include/babeltrace/context-internal.h b/include/babeltrace/c=
ontext-internal.h
> index 17d6202..7600d8d 100644
> --- a/include/babeltrace/context-internal.h
> +++ b/include/babeltrace/context-internal.h
> @@ -51,6 +51,7 @@ struct bt_context {
>  	int refcount;
>  	int last_trace_handle_id;
>  	struct bt_iter *current_iterator;
> +	struct bt_format *input_trace_format;
>  };
>  =

>  #endif /* _BABELTRACE_CONTEXT_INTERNAL_H */
> diff --git a/include/babeltrace/context.h b/include/babeltrace/context.h
> index b28df09..6455b65 100644
> --- a/include/babeltrace/context.h
> +++ b/include/babeltrace/context.h
> @@ -32,6 +32,7 @@
>   */
>  =

>  #include <unistd.h>
> +#include <stdio.h>
>  #include <babeltrace/format.h>
>  =

>  #ifdef __cplusplus
> @@ -96,6 +97,36 @@ int bt_context_add_trace(struct bt_context *ctx, const=
 char *path,
>  int bt_context_remove_trace(struct bt_context *ctx, int trace_id);
>  =

>  /*
> + * bt_context_create_iterator: Allocate an iterator on the current trace
> + * collection's events.
> + *
> + * begin_pos and end_pos are optional parameters to specify the position
> + * at which the trace collection should be seeked upon iterator
> + * creation, and the position at which iteration will start returning
> + * "EOF".
> + *
> + * By default, if begin_pos is NULL, a BT_SEEK_CUR is performed at
> + * creation. By default, if end_pos is NULL, a BT_SEEK_END (end of
> + * trace) is the EOF criterion.
> + *
> + * Return a pointer to the newly allocated iterator.
> + *
> + * Only one iterator can be created against a context. If more than one
> + * iterator is being created for the same context, the second creation
> + * will return NULL. The previous iterator must be destroyed before
> + * creation of the new iterator for this function to succeed.
> + */
> +struct bt_iter *bt_context_create_iterator(struct bt_context *ctx,
> +	const struct bt_iter_pos *position_begin,
> +	const struct bt_iter_pos *position_end);
> +
> +/*
> + * bt_context_destroy_iterator: Free a trace collection iterator.
> + */
> +void bt_context_destroy_iterator(struct bt_context *ctx,
> +		 struct bt_iter *iterator);
> +
> +/*
>   * bt_context_get and bt_context_put : increments and decrement the
>   * refcount of the context
>   *
> diff --git a/include/babeltrace/ctf/iterator.h b/include/babeltrace/ctf/i=
terator.h
> index ec6aac7..159e4a4 100644
> --- a/include/babeltrace/ctf/iterator.h
> +++ b/include/babeltrace/ctf/iterator.h
> @@ -59,7 +59,7 @@ struct bt_ctf_event;
>   * will return NULL. The previous iterator must be destroyed before
>   * creation of the new iterator for this function to succeed.
>   */
> -struct bt_ctf_iter *bt_ctf_iter_create(struct bt_context *ctx,
> +struct bt_iter *bt_ctf_iter_create(struct bt_context *ctx,
>  		const struct bt_iter_pos *begin_pos,
>  		const struct bt_iter_pos *end_pos);
>  =

> @@ -71,7 +71,7 @@ struct bt_iter *bt_ctf_get_iter(struct bt_ctf_iter *ite=
r);
>  /*
>   * bt_ctf_iter_destroy - Free a CTF trace collection iterator.
>   */
> -void bt_ctf_iter_destroy(struct bt_ctf_iter *iter);
> +void bt_ctf_iter_destroy(struct bt_iter *iter);
>  =

>  /*
>   * bt_ctf_iter_read_event: Read the iterator's current event data.
> @@ -80,7 +80,7 @@ void bt_ctf_iter_destroy(struct bt_ctf_iter *iter);
>   *
>   * Return current event on success, NULL on end of trace.
>   */
> -struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_ctf_iter *iter);
> +struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_iter *iter);
>  =

>  /*
>   * bt_ctf_iter_read_event_flags: Read the iterator's current event data.
> diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
> index 9f3d1c8..c170d83 100644
> --- a/include/babeltrace/format.h
> +++ b/include/babeltrace/format.h
> @@ -45,6 +45,9 @@ typedef int bt_intern_str;
>  struct bt_stream_pos;
>  struct bt_context;
>  struct bt_trace_handle;
> +struct bt_trace_descriptor;
> +struct bt_iter;
> +struct bt_iter_pos;
>  =

>  struct bt_mmap_stream {
>  	int fd;
> @@ -77,6 +80,17 @@ struct bt_format {
>  	uint64_t (*timestamp_end)(struct bt_trace_descriptor *descriptor,
>  			struct bt_trace_handle *handle, enum bt_clock_type type);
>  	int (*convert_index_timestamp)(struct bt_trace_descriptor *descriptor);
> +
> +	/*
> +	 * Only one iterator can be created against a context. If more than one
> +	 * iterator is being created for the same context, the second creation
> +	 * will return NULL. The previous iterator must be destroyed before
> +	 * creation of the new iterator for this function to succeed.
> +	 */
> +	struct bt_iter *(*iterator_create)(struct bt_context *ctx,
> +			const struct bt_iter_pos *begin_pos,
> +			const struct bt_iter_pos *end_pos);
> +	void (*iterator_destroy)(struct bt_iter *iterator);
>  };
>  =

>  extern struct bt_format *bt_lookup_format(bt_intern_str qname);
> diff --git a/include/babeltrace/iterator-internal.h b/include/babeltrace/=
iterator-internal.h
> index 2b0b2f2..2008d76 100644
> --- a/include/babeltrace/iterator-internal.h
> +++ b/include/babeltrace/iterator-internal.h
> @@ -39,6 +39,7 @@ struct bt_iter {
>  	struct ptr_heap *stream_heap;
>  	struct bt_context *ctx;
>  	const struct bt_iter_pos *end_pos;
> +	struct bt_ctf_event *(*get_event)(struct bt_iter *iter);
>  };
>  =

>  /*
> diff --git a/include/babeltrace/iterator.h b/include/babeltrace/iterator.h
> index 360a9c7..aa189a8 100644
> --- a/include/babeltrace/iterator.h
> +++ b/include/babeltrace/iterator.h
> @@ -27,6 +27,7 @@
>  =

>  #include <babeltrace/format.h>
>  #include <babeltrace/context.h>
> +#include <stdint.h>
>  =

>  #ifdef __cplusplus
>  extern "C" {
> @@ -40,6 +41,7 @@ enum {
>  /* Forward declarations */
>  struct bt_iter;
>  struct bt_saved_pos;
> +struct bt_ctf_event;
>  =

>  /*
>   * bt_iter is an abstract class, each format has to implement its own
> @@ -123,6 +125,15 @@ int bt_iter_set_pos(struct bt_iter *iter, const stru=
ct bt_iter_pos *pos);
>  struct bt_iter_pos *bt_iter_create_time_pos(struct bt_iter *iter,
>  		uint64_t timestamp);
>  =

> +/*
> + * bt_iter_get_event: Get the iterator's current event data
> + *
> + * @iter trace collection iterator (input). Should not be NULL.
> + *
> + * Return current event on success, NULL on end of trace.
> + */
> +struct bt_ctf_event *bt_iter_get_event(struct bt_iter *iter);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/lib/context.c b/lib/context.c
> index dc77366..61215a3 100644
> --- a/lib/context.c
> +++ b/lib/context.c
> @@ -87,6 +87,12 @@ int bt_context_add_trace(struct bt_context *ctx, const=
 char *path,
>  		ret =3D -1;
>  		goto end;
>  	}
> +	if (ctx->input_trace_format && ctx->input_trace_format !=3D fmt) {
> +		fprintf(stderr, "[error] [Context] Opening traces of different formats=
 in the same context is not supported.\n");
> +		ret =3D -1;
> +		goto end;
> +	}
> +	ctx->input_trace_format =3D fmt;
>  	if (path) {
>  		td =3D fmt->open_trace(path, O_RDONLY, packet_seek, NULL);
>  		if (!td) {
> @@ -211,3 +217,54 @@ void bt_context_put(struct bt_context *ctx)
>  	if (ctx->refcount =3D=3D 0)
>  		bt_context_destroy(ctx);
>  }
> +
> +struct bt_iter *bt_context_create_iterator(struct bt_context *ctx,
> +			const struct bt_iter_pos *position_begin,
> +			const struct bt_iter_pos *position_end)
> +{
> +	struct bt_iter *iter =3D NULL;
> +	struct bt_format *fmt;
> +	assert(ctx);
> +
> +	if (!ctx->input_trace_format) {
> +		fprintf(stderr, "[error] No trace opened in context.\n");
> +		goto end;
> +	}
> +	fmt =3D ctx->input_trace_format;
> +	if (!fmt->iterator_create) {
> +		fprintf(stderr, "[error] The %s format plug-in did not register an ite=
rator creation function.\n", g_quark_to_string(fmt->name));
> +		goto end;
> +	}
> +	iter =3D fmt->iterator_create(ctx, position_begin, position_end);
> +
> +	if (!ctx->current_iterator) {
> +		fprintf(stderr, "[error] The %s format plug-in did not call bt_iter_in=
it in its iterator creation function.\n",
> +			g_quark_to_string(fmt->name));
> +	}
> +
> +end:
> +	return iter;
> +}
> +
> +void bt_context_destroy_iterator(struct bt_context *ctx,
> +			struct bt_iter *iter)
> +{
> +	struct bt_format *fmt;
> +	assert(ctx);
> +
> +	if (!ctx->input_trace_format) {
> +		fprintf(stderr, "[error] No trace opened in context.\n");
> +		return;
> +	}
> +	fmt =3D ctx->input_trace_format;
> +	if (!fmt->iterator_destroy) {
> +		fprintf(stderr, "[error] The %s format plug-in did not register an ite=
rator destruction function.\n",
> +			g_quark_to_string(fmt->name));
> +		return;
> +	}
> +	fmt->iterator_destroy(iter);
> +	if (ctx->current_iterator) {
> +		fprintf(stderr, "[warn] The %s format plug-in did not call bt_iter_fin=
i in its iterator destruction function.\n",
> +			g_quark_to_string(fmt->name));
> +	}
> +}
> diff --git a/lib/iterator.c b/lib/iterator.c
> index 4190e65..b838000 100644
> --- a/lib/iterator.c
> +++ b/lib/iterator.c
> @@ -805,3 +805,17 @@ int bt_iter_next(struct bt_iter *iter)
>  end:
>  	return ret;
>  }
> +
> +struct bt_ctf_event *bt_iter_get_event(struct bt_iter *iter)
> +{
> +	struct bt_ctf_event *event;
> +	if (!iter->get_event) {
> +		event =3D NULL;
> +		fprintf(stderr, "[error] No get_event callback registered by the outpu=
t plug-in.\n");
> +		goto end;
> +	}
> +	event =3D iter->get_event(iter);
> +
> +end:
> +	return event;
> +}
> diff --git a/tests/lib/test-seeks.c b/tests/lib/test-seeks.c
> index 47bb42e..69e4d4b 100644
> --- a/tests/lib/test-seeks.c
> +++ b/tests/lib/test-seeks.c
> @@ -37,7 +37,7 @@
>  void run_seek_begin(char *path, uint64_t expected_begin)
>  {
>  	struct bt_context *ctx;
> -	struct bt_ctf_iter *iter;
> +	struct bt_iter *iter;
>  	struct bt_ctf_event *event;
>  	struct bt_iter_pos newpos;
>  	int ret;
> @@ -51,12 +51,12 @@ void run_seek_begin(char *path, uint64_t expected_beg=
in)
>  	}
>  =

>  	/* Create iterator with null begin and end */
> -	iter =3D bt_ctf_iter_create(ctx, NULL, NULL);
> +	iter =3D bt_context_create_iterator(ctx, NULL, NULL);
>  	if (!iter) {
>  		plan_skip_all("Cannot create valid iterator");
>  	}
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event, "Event valid");
>  =

> @@ -67,7 +67,7 @@ void run_seek_begin(char *path, uint64_t expected_begin)
>  =

>  	/* Validate that we get the same value after a seek begin */
>  	newpos.type =3D BT_SEEK_BEGIN;
> -	ret =3D bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
> +	ret =3D bt_iter_set_pos(iter, &newpos);
>  =

>  	ok(ret =3D=3D 0, "Seek begin retval %d", ret);
>  =

> @@ -86,7 +86,7 @@ void run_seek_begin(char *path, uint64_t expected_begin)
>  void run_seek_last(char *path, uint64_t expected_last)
>  {
>  	struct bt_context *ctx;
> -	struct bt_ctf_iter *iter;
> +	struct bt_iter *iter;
>  	struct bt_ctf_event *event;
>  	struct bt_iter_pos newpos;
>  	int ret;
> @@ -99,18 +99,18 @@ void run_seek_last(char *path, uint64_t expected_last)
>  	}
>  =

>  	/* Create iterator with null last and end */
> -	iter =3D bt_ctf_iter_create(ctx, NULL, NULL);
> +	iter =3D bt_context_create_iterator(ctx, NULL, NULL);
>  	if (!iter) {
>  		plan_skip_all("Cannot create valid iterator");
>  	}
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event, "Event valid at beginning");
>  =

>  	/* Seek to last */
>  	newpos.type =3D BT_SEEK_LAST;
> -	ret =3D bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
> +	ret =3D bt_iter_set_pos(iter, &newpos);
>  =

>  	ok(ret =3D=3D 0, "Seek last retval %d", ret);
>  =

> @@ -123,11 +123,11 @@ void run_seek_last(char *path, uint64_t expected_la=
st)
>  	ok1(timestamp_last =3D=3D expected_last);
>  =

>  	/* Try to read next event */
> -	ret =3D bt_iter_next(bt_ctf_get_iter(iter));
> +	ret =3D bt_iter_next(iter);
>  =

>  	ok(ret =3D=3D 0, "iter next should return an error");
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event =3D=3D 0, "Event after last should be invalid");
>  =

> @@ -139,7 +139,7 @@ void run_seek_cycles(char *path,
>  		uint64_t expected_last)
>  {
>  	struct bt_context *ctx;
> -	struct bt_ctf_iter *iter;
> +	struct bt_iter *iter;
>  	struct bt_ctf_event *event;
>  	struct bt_iter_pos newpos;
>  	int ret;
> @@ -152,22 +152,22 @@ void run_seek_cycles(char *path,
>  	}
>  =

>  	/* Create iterator with null last and end */
> -	iter =3D bt_ctf_iter_create(ctx, NULL, NULL);
> +	iter =3D bt_context_create_iterator(ctx, NULL, NULL);
>  	if (!iter) {
>  		plan_skip_all("Cannot create valid iterator");
>  	}
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event, "Event valid at beginning");
>  =

>  	/* Seek to last */
>  	newpos.type =3D BT_SEEK_LAST;
> -	ret =3D bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
> +	ret =3D bt_iter_set_pos(iter, &newpos);
>  =

>  	ok(ret =3D=3D 0, "Seek last retval %d", ret);
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event, "Event valid at last position");
>  =

> @@ -176,21 +176,21 @@ void run_seek_cycles(char *path,
>  	ok1(timestamp =3D=3D expected_last);
>  =

>  	/* Try to read next event */
> -	ret =3D bt_iter_next(bt_ctf_get_iter(iter));
> +	ret =3D bt_iter_next(iter);
>  =

>  	ok(ret =3D=3D 0, "iter next should return an error");
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event =3D=3D 0, "Event after last should be invalid");
>  =

>  	/* Seek to BEGIN */
>  	newpos.type =3D BT_SEEK_BEGIN;
> -	ret =3D bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
> +	ret =3D bt_iter_set_pos(iter, &newpos);
>  =

>  	ok(ret =3D=3D 0, "Seek begin retval %d", ret);
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event, "Event valid at first position");
>  =

> @@ -200,11 +200,11 @@ void run_seek_cycles(char *path,
>  =

>  	/* Seek last again */
>  	newpos.type =3D BT_SEEK_LAST;
> -	ret =3D bt_iter_set_pos(bt_ctf_get_iter(iter), &newpos);
> +	ret =3D bt_iter_set_pos(iter, &newpos);
>  =

>  	ok(ret =3D=3D 0, "Seek last retval %d", ret);
>  =

> -	event =3D bt_ctf_iter_read_event(iter);
> +	event =3D bt_iter_get_event(iter);
>  =

>  	ok(event, "Event valid at last position");
>  =

> -- =

> 1.8.2.3
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
