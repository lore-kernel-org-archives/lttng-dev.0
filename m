From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Close socket handle on
 error
Date: Fri, 20 Sep 2019 17:23:37 -0400
Message-ID: <20190920212337.GB20024__36938.0115925864$1569014634$gmane$org@gmail.com>
References: <20190920153421.67837-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zmt45qNXzqs9
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:23:40 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id 3so7883402qta.1
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 14:23:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190920153421.67837-1-jonathan.rajotte-julien@efficios.com>
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

Merged in master and stable-2.11. Thanks!

J=E9r=E9mie

On Fri, Sep 20, 2019 at 11:34:21AM -0400, Jonathan Rajotte wrote:
> Fixes coverity #1399739
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/client.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/cli=
ent.c
> index 956dab8c8..870277534 100644
> --- a/src/bin/lttng-sessiond/client.c
> +++ b/src/bin/lttng-sessiond/client.c
> @@ -1985,8 +1985,11 @@ static int create_client_sock(void)
>  	/* File permission MUST be 660 */
>  	ret =3D chmod(config.client_unix_sock_path.value, S_IRUSR | S_IWUSR | S=
_IRGRP | S_IWGRP);
>  	if (ret < 0) {
> -		ERR("Set file permissions failed: %s", config.client_unix_sock_path.va=
lue);
> +		ERR("Set file permissions failed: %s",
> +				config.client_unix_sock_path.value);
>  		PERROR("chmod");
> +		(void) lttcomm_close_unix_sock(client_sock);
> +		ret =3D -1;
>  		goto end;
>  	}
>  	DBG("Created client socket (fd =3D %i)", client_sock);
> -- =

> 2.17.1
> =
