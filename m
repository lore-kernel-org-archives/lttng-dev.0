From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix relayd: initialize
 beacon to -1ULL
Date: Thu, 25 Apr 2019 14:26:45 -0400
Message-ID: <20190425182644.GC4708__39902.040925675$1556216822$gmane$org@gmail.com>
References: <20190402174117.8663-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 44qlyJ2Vwxz1KnG
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 14:26:48 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id b3so1169405qtc.12
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 11:26:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190402174117.8663-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Both patches are merged in master, stable-2.11, stable-2.10, and
stable-2.9.

Thanks!
J=E9r=E9mie

On Tue, Apr 02, 2019 at 01:41:16PM -0400, Mathieu Desnoyers wrote:
> The relayd stream beacon_ts_end field is expected to have the value
> -1ULL when unset (no beacon has been received since last index).
> =

> However, the initial state is wrong. It is left at the value 0, which
> indicates that a live beacon has indeed been received (which is untrue),
> which in turn causes a live beacon with ctf_stream_id of -1ULL to be
> sent to babeltrace, which does not expect it, and fails.
> =

> This issue can be triggered with the following scenario:
> =

> 1) create live session
> 2) setup UST per-uid buffers tracing
> 3) start tracing, without any active traced application
> 4) hook with babeltrace live client to view the trace
> 5) run a traced application
> =

> Step 5) will cause the babeltrace live client to receive a stream_id of
> -1ULL, and error out.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-relayd/stream.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
> index 80c8aa0c..1218c2f4 100644
> --- a/src/bin/lttng-relayd/stream.c
> +++ b/src/bin/lttng-relayd/stream.c
> @@ -98,6 +98,7 @@ struct relay_stream *stream_create(struct ctf_trace *tr=
ace,
>  	stream->tracefile_count =3D tracefile_count;
>  	stream->path_name =3D path_name;
>  	stream->channel_name =3D channel_name;
> +	stream->beacon_ts_end =3D -1ULL;
>  	lttng_ht_node_init_u64(&stream->node, stream->stream_handle);
>  	pthread_mutex_init(&stream->lock, NULL);
>  	pthread_mutex_init(&stream->reflock, NULL);
> -- =

> 2.17.1
> =
