From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Remove unused array
	in	bt_context_add_traces_recursive
Date: Wed, 15 May 2013 02:12:51 -0400
Message-ID: <20130515061251.GC16392__4125.58745961196$1368598404$gmane$org@Krystal>
References: <1368569620-6774-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UcUxI-0001VT-Rv
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 02:12:52 -0400
Content-Disposition: inline
In-Reply-To: <1368569620-6774-1-git-send-email-jeremie.galarneau@efficios.com>
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

merged, thanks!

Mathieu

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  converter/babeltrace.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> =

> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 2fd371c..1008351 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -490,15 +490,11 @@ int bt_context_add_traces_recursive(struct bt_conte=
xt *ctx, const char *path,
>  		void (*packet_seek)(struct bt_stream_pos *pos,
>  			size_t offset, int whence))
>  {
> -
> -	GArray *trace_ids;
> -	int ret =3D 0;
> +	int ret =3D 0, trace_ids =3D 0;
>  =

>  	/* Should lock traversed_paths mutex here if used in multithread */
>  =

>  	traversed_paths =3D g_ptr_array_new();
> -	trace_ids =3D g_array_new(FALSE, TRUE, sizeof(int));
> -
>  	ret =3D nftw(path, traverse_trace_dir, 10, 0);
>  =

>  	/* Process the array if ntfw did not return a fatal error */
> @@ -520,7 +516,7 @@ int bt_context_add_traces_recursive(struct bt_context=
 *ctx, const char *path,
>  				/* Allow to skip erroneous traces. */
>  				ret =3D 1;	/* partial error */
>  			} else {
> -				g_array_append_val(trace_ids, trace_id);
> +				trace_ids++;
>  			}
>  			g_string_free(trace_path, TRUE);
>  		}
> @@ -534,11 +530,10 @@ int bt_context_add_traces_recursive(struct bt_conte=
xt *ctx, const char *path,
>  	/*
>  	 * Return an error if no trace can be opened.
>  	 */
> -	if (trace_ids->len =3D=3D 0) {
> +	if (trace_ids =3D=3D 0) {
>  		fprintf(stderr, "[error] Cannot open any trace for reading.\n\n");
>  		ret =3D -ENOENT;		/* failure */
>  	}
> -	g_array_free(trace_ids, TRUE);
>  	return ret;
>  }
>  =

> -- =

> 1.8.2.2
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
