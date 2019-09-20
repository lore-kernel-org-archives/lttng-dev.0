From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools master,
 2.11] Fix: destroy command: put consumer output after destroy
 notifier
Date: Fri, 20 Sep 2019 17:53:33 -0400
Message-ID: <20190920215333.GA49780__4221.58509479544$1569016432$gmane$org@gmail.com>
References: <20190920214114.1073-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 46ZnXd4hKRz19Vy
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:53:37 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id u40so10363186qth.11
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 14:53:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190920214114.1073-1-mathieu.desnoyers@efficios.com>
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

Merged in master and stable-2.11. Thanks!

J=E9r=E9mie

On Fri, Sep 20, 2019 at 05:41:14PM -0400, Mathieu Desnoyers wrote:
> The destroy notifier needs to access the consumer output to format
> the absolute path to the last chunk.
> =

> The observed problematic behavior can be observed by doing a
> rotate and a destroy command in quick succession. Sometimes,
> the resulting path printed by the destroy command is incomplete:
> =

> e.g. /archives/20190920T163616-0400-20190920T163618-0400-1
> =

> when we would expect:
> =

> /home/efficios/lttng-traces/auto-20190920-164425/archives/20190920T164437=
-0400-20190920T164439-0400-1
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/se=
ssion.c
> index 9072a2ec..7fd4332e 100644
> --- a/src/bin/lttng-sessiond/session.c
> +++ b/src/bin/lttng-sessiond/session.c
> @@ -811,7 +811,6 @@ void session_release(struct urcu_ref *ref)
>  =

>  	DBG("Destroying session %s (id %" PRIu64 ")", session->name, session->i=
d);
>  =

> -	consumer_output_put(session->consumer);
>  	snapshot_destroy(&session->snapshot);
>  =

>  	pthread_mutex_destroy(&session->lock);
> @@ -823,6 +822,7 @@ void session_release(struct urcu_ref *ref)
>  	}
>  	session_notify_destruction(session);
>  =

> +	consumer_output_put(session->consumer);
>  	kernel_free_session(ksess);
>  	session->kernel_session =3D NULL;
>  	if (usess) {
> -- =

> 2.17.1
> =
