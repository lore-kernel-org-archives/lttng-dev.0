From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix converter code relying
	on	the output type being ctf-text
Date: Tue, 28 May 2013 13:30:15 -0400
Message-ID: <20130528173015.GC20859__26713.2519664758$1369762250$gmane$org@Krystal>
References: <1369712328-17921-1-git-send-email-jeremie.galarneau@efficios.com>
	<1369712328-17921-2-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UhNiz-000374-4F
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 13:30:17 -0400
Content-Disposition: inline
In-Reply-To: <1369712328-17921-2-git-send-email-jeremie.galarneau@efficios.com>
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
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  converter/babeltrace.c      | 92 ++++++++++++++++++++++++++-------------=
------
>  include/babeltrace/format.h |  2 +-
>  2 files changed, 54 insertions(+), 40 deletions(-)
> =

> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index d5a7040..8f09845 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -546,25 +546,33 @@ static
>  int trace_pre_handler(struct bt_trace_descriptor *td_write,
>  		  struct bt_context *ctx)
>  {
> -	struct ctf_text_stream_pos *sout;
> -	struct trace_collection *tc;
>  	int ret, i;
> +	struct trace_collection *tc =3D ctx->tc;
> +	const GPtrArray *out_streams =3D bt_trace_descriptor_get_stream_pos(td_=
write);

please resubmit after fixing the bt_trace_descriptor_get_stream_pos
API exposing glib.

Thanks,

Mathieu

>  =

> -	sout =3D container_of(td_write, struct ctf_text_stream_pos,
> -			trace_descriptor);
> -
> -	if (!sout->parent.pre_trace_cb)
> -		return 0;
> +	if (!out_streams) {
> +		ret =3D -1;
> +		goto end;
> +	}
>  =

> -	tc =3D ctx->tc;
>  	for (i =3D 0; i < tc->array->len; i++) {
> -		struct bt_trace_descriptor *td =3D
> +		int sout_nr;
> +		struct bt_trace_descriptor *in_descriptor =3D
>  			g_ptr_array_index(tc->array, i);
>  =

> -		ret =3D sout->parent.pre_trace_cb(&sout->parent, td);
> -		if (ret) {
> -			fprintf(stderr, "[error] Writing to trace pre handler failed.\n");
> -			goto end;
> +		for (sout_nr =3D 0; sout_nr < out_streams->len; ++sout_nr) {
> +			struct bt_stream_pos *sout =3D
> +				g_ptr_array_index(out_streams, sout_nr);
> +
> +			if (!sout->pre_trace_cb) {
> +				continue;
> +			}
> +
> +			ret =3D sout->pre_trace_cb(sout, in_descriptor);
> +			if (ret) {
> +				fprintf(stderr, "[error] Writing to trace pre handler failed.\n");
> +				goto end;
> +			}
>  		}
>  	}
>  	ret =3D 0;
> @@ -576,25 +584,28 @@ static
>  int trace_post_handler(struct bt_trace_descriptor *td_write,
>  		  struct bt_context *ctx)
>  {
> -	struct ctf_text_stream_pos *sout;
> -	struct trace_collection *tc;
>  	int ret, i;
> +	struct trace_collection *tc =3D ctx->tc;
> +	const GPtrArray *out_streams =3D bt_trace_descriptor_get_stream_pos(td_=
write);
>  =

> -	sout =3D container_of(td_write, struct ctf_text_stream_pos,
> -			trace_descriptor);
> -
> -	if (!sout->parent.post_trace_cb)
> -		return 0;
> -
> -	tc =3D ctx->tc;
>  	for (i =3D 0; i < tc->array->len; i++) {
> -		struct bt_trace_descriptor *td =3D
> +		int sout_nr;
> +		struct bt_trace_descriptor *in_descriptor =3D
>  			g_ptr_array_index(tc->array, i);
>  =

> -		ret =3D sout->parent.post_trace_cb(&sout->parent, td);
> -		if (ret) {
> -			fprintf(stderr, "[error] Writing to trace post handler failed.\n");
> -			goto end;
> +		for (sout_nr =3D 0; sout_nr < out_streams->len; ++sout_nr) {
> +			struct bt_stream_pos *sout =3D
> +				g_ptr_array_index(out_streams, sout_nr);
> +
> +			if (!sout->pre_trace_cb) {
> +				continue;
> +			}
> +
> +			ret =3D sout->post_trace_cb(sout, in_descriptor);
> +			if (ret) {
> +				fprintf(stderr, "[error] Writing to trace post handler failed.\n");
> +				goto end;
> +			}
>  		}
>  	}
>  	ret =3D 0;
> @@ -607,16 +618,10 @@ int convert_trace(struct bt_trace_descriptor *td_wr=
ite,
>  		  struct bt_context *ctx)
>  {
>  	struct bt_ctf_iter *iter;
> -	struct ctf_text_stream_pos *sout;
>  	struct bt_iter_pos begin_pos;
>  	struct bt_ctf_event *ctf_event;
>  	int ret;
> -
> -	sout =3D container_of(td_write, struct ctf_text_stream_pos,
> -			trace_descriptor);
> -
> -	if (!sout->parent.event_cb)
> -		return 0;
> +	const GPtrArray *out_streams =3D bt_trace_descriptor_get_stream_pos(td_=
write);
>  =

>  	begin_pos.type =3D BT_SEEK_BEGIN;
>  	iter =3D bt_ctf_iter_create(ctx, &begin_pos, NULL);
> @@ -625,14 +630,23 @@ int convert_trace(struct bt_trace_descriptor *td_wr=
ite,
>  		goto error_iter;
>  	}
>  	while ((ctf_event =3D bt_ctf_iter_read_event(iter))) {
> -		ret =3D sout->parent.event_cb(&sout->parent, ctf_event->parent->stream=
);
> -		if (ret) {
> -			fprintf(stderr, "[error] Writing event failed.\n");
> -			goto end;
> +		int sout_nr;
> +		for (sout_nr =3D 0; sout_nr < out_streams->len; ++sout_nr) {
> +			struct bt_stream_pos *sout =3D
> +				g_ptr_array_index(out_streams, sout_nr);
> +			if (!sout->event_cb) {
> +				continue;
> +			}
> +			ret =3D sout->event_cb(sout, ctf_event->parent->stream);
> +			if (ret) {
> +				fprintf(stderr, "[error] Writing event failed.\n");
> +				goto end;
> +			}
>  		}
>  		ret =3D bt_iter_next(bt_ctf_get_iter(iter));
> -		if (ret < 0)
> +		if (ret < 0) {
>  			goto end;
> +		}
>  	}
>  	ret =3D 0;
>  =

> diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
> index 07e854f..9f3d1c8 100644
> --- a/include/babeltrace/format.h
> +++ b/include/babeltrace/format.h
> @@ -31,6 +31,7 @@
>  =

>  #include <babeltrace/list.h>
>  #include <babeltrace/clock-types.h>
> +#include <babeltrace/trace-descriptor.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  =

> @@ -44,7 +45,6 @@ typedef int bt_intern_str;
>  struct bt_stream_pos;
>  struct bt_context;
>  struct bt_trace_handle;
> -struct bt_trace_descriptor;
>  =

>  struct bt_mmap_stream {
>  	int fd;
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
