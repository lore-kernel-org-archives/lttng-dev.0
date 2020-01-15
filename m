From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] doc: Fix bind address example for
 lttng-relayd
Date: Tue, 14 Jan 2020 19:45:13 -0500
Message-ID: <20200115004513.GA61030@gmail.com>
References: <20200106051954.138370-1-benjamin.poirier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com
 [209.85.219.68])
 by lists.lttng.org (Postfix) with ESMTPS id 47y7s91h1mz1jCg
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jan 2020 19:45:17 -0500 (EST)
Received: by mail-qv1-f68.google.com with SMTP id x1so6629195qvr.8
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jan 2020 16:45:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200106051954.138370-1-benjamin.poirier@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, and stable-2.10.

Thanks!
J=E9r=E9mie

On Mon, Jan 06, 2020 at 02:19:54PM +0900, Benjamin Poirier wrote:
> INADDR_ANY is 0.0.0.0
> =

> Fixes: c93eadade277 ("doc/man: use propagated default values in man pages=
")
> Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
> ---
>  doc/man/lttng-relayd.8.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/doc/man/lttng-relayd.8.txt b/doc/man/lttng-relayd.8.txt
> index be59675d..bf88a535 100644
> --- a/doc/man/lttng-relayd.8.txt
> +++ b/doc/man/lttng-relayd.8.txt
> @@ -40,7 +40,7 @@ it can write to the output directory and listen on the =
configured ports.
>  If a user is within a secured network and/or has proper firewall
>  settings, `lttng-relayd` can listen to LTTng live connections from _all_
>  network interfaces by specifying
> -+--live-port=3Dtcp://{default_network_viewer_bind_address}:{default_netw=
ork_viewer_port}+.
> ++--live-port=3Dtcp://0.0.0.0:{default_network_viewer_port}+.
>  =

>  Once a trace has been streamed completely, the trace can be processed by
>  any tool that can process an LTTng trace located on the local
> -- =

> 2.25.0.rc0
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
