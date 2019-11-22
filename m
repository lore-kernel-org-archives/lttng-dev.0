From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: update apps on untrack
 only when session is active
Date: Fri, 22 Nov 2019 18:00:44 -0500
Message-ID: <20191122230044.GA51696__28237.2253642947$1574463668$gmane$org@gmail.com>
References: <20191118201220.7525-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 47KX341cKZz1R3K
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 18:00:47 -0500 (EST)
Received: by mail-qt1-f195.google.com with SMTP id t20so9678408qtn.9
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 15:00:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191118201220.7525-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Mon, Nov 18, 2019 at 03:12:20PM -0500, Jonathan Rajotte wrote:
> This mimics what is done on the track side.
> =

> Fixes #1210
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> =

> Used wrong issue number.
> =

> ---
>  src/bin/lttng-sessiond/trace-ust.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/=
trace-ust.c
> index 486b53d30..a6c0c04ad 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -922,6 +922,7 @@ end:
>  int trace_ust_untrack_pid(struct ltt_ust_session *session, int pid)
>  {
>  	int retval =3D LTTNG_OK;
> +	bool should_update_apps =3D false;
>  =

>  	if (pid =3D=3D -1) {
>  		/* Create empty tracker, replace old tracker. */
> @@ -938,7 +939,7 @@ int trace_ust_untrack_pid(struct ltt_ust_session *ses=
sion, int pid)
>  		fini_pid_tracker(&tmp_tracker);
>  =

>  		/* Remove session from all applications */
> -		ust_app_global_update_all(session);
> +		should_update_apps =3D true;
>  	} else {
>  		int ret;
>  		struct ust_app *app;
> @@ -957,9 +958,12 @@ int trace_ust_untrack_pid(struct ltt_ust_session *se=
ssion, int pid)
>  		/* Remove session from application. */
>  		app =3D ust_app_find_by_pid(pid);
>  		if (app) {
> -			ust_app_global_update(session, app);
> +			should_update_apps =3D true;
>  		}
>  	}
> +	if (should_update_apps && session->active) {
> +		ust_app_global_update_all(session);
> +	}
>  end:
>  	return retval;
>  }
> -- =

> 2.17.1
> =
