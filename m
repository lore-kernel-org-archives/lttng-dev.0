From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: initialize sessions
 pointer to NULL
Date: Tue, 5 Nov 2019 00:25:01 -0500
Message-ID: <20191105052501.GC8933__49157.9201234103$1572931522$gmane$org@gmail.com>
References: <20191025215626.19148-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 476dQn4b3TzrXM
 for <lttng-dev@lists.lttng.org>; Tue,  5 Nov 2019 00:25:05 -0500 (EST)
Received: by mail-qk1-f194.google.com with SMTP id q70so20031011qke.12
 for <lttng-dev@lists.lttng.org>; Mon, 04 Nov 2019 21:25:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191025215626.19148-1-jonathan.rajotte-julien@efficios.com>
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

Merged in master, stable-2.11, and stable-2.10.

Thanks!
J=E9r=E9mie

On Fri, Oct 25, 2019 at 05:56:26PM -0400, Jonathan Rajotte wrote:
> lttng_list_sessions does not set the passed pointer to NULL on empty
> return. This lead to deallocation of non-allocated memory (segfault).
> =

> For returns of size 0, the value of the passed argument should be
> considered "undefined".
> =

> Refactor error handling a bit by removing the "error" jump. Always call
> free on the sessions object.
> =

> Fixes #1205
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng/commands/list.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> =

> diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
> index 28166c8be..65d8ea6f5 100644
> --- a/src/bin/lttng/commands/list.c
> +++ b/src/bin/lttng/commands/list.c
> @@ -1825,7 +1825,7 @@ static int list_sessions(const char *session_name)
>  	int ret =3D CMD_SUCCESS;
>  	int count, i;
>  	unsigned int session_found =3D 0;
> -	struct lttng_session *sessions;
> +	struct lttng_session *sessions =3D NULL;
>  =

>  	count =3D lttng_list_sessions(&sessions);
>  	DBG("Session count %d", count);
> @@ -1838,7 +1838,7 @@ static int list_sessions(const char *session_name)
>  	if (lttng_opt_mi) {
>  		/* Mi */
>  		if (session_name =3D=3D NULL) {
> -			/* List all session */
> +			/* List all sessions */
>  			ret =3D mi_list_sessions(sessions, count);
>  		} else {
>  			/* Note : this return an open session element */
> @@ -1846,7 +1846,7 @@ static int list_sessions(const char *session_name)
>  		}
>  		if (ret) {
>  			ret =3D CMD_ERROR;
> -			goto error;
> +			goto end;
>  		}
>  	} else {
>  		/* Pretty print */
> @@ -1893,7 +1893,7 @@ static int list_sessions(const char *session_name)
>  		if (!session_found && session_name !=3D NULL) {
>  			ERR("Session '%s' not found", session_name);
>  			ret =3D CMD_ERROR;
> -			goto error;
> +			goto end;
>  		}
>  =

>  		if (session_name =3D=3D NULL) {
> @@ -1901,9 +1901,8 @@ static int list_sessions(const char *session_name)
>  		}
>  	}
>  =

> -error:
> -	free(sessions);
>  end:
> +	free(sessions);
>  	return ret;
>  }
>  =

> -- =

> 2.17.1
> =
