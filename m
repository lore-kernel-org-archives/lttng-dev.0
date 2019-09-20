From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Null check before
 destroying health_sessiond
Date: Fri, 20 Sep 2019 17:24:44 -0400
Message-ID: <20190920212444.GC20024__2752.34197485901$1569014702$gmane$org@gmail.com>
References: <20190920151512.12956-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 46ZmvM4W6nzqt2
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:24:47 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id u22so10264296qtq.13
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 14:24:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190920151512.12956-1-jonathan.rajotte-julien@efficios.com>
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

On Fri, Sep 20, 2019 at 11:15:12AM -0400, Jonathan Rajotte wrote:
> Fixes coverity #1399735
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> =

> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 5f99bdbf6..a428630f8 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -1819,7 +1819,9 @@ stop_threads:
>  	lttng_pipe_destroy(ust64_channel_monitor_pipe);
>  	lttng_pipe_destroy(kernel_channel_monitor_pipe);
>  =

> -	health_app_destroy(health_sessiond);
> +	if (health_sessiond) {
> +		health_app_destroy(health_sessiond);
> +	}
>  exit_create_run_as_worker_cleanup:
>  exit_options:
>  	sessiond_cleanup_lock_file();
> -- =

> 2.17.1
> =
