From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Fix: max_t/min_t macros are
 missing cast on input
Date: Fri, 16 Nov 2018 18:22:00 -0500
Message-ID: <20181116232159.GC2851__11480.6655714803$1542410407$gmane$org@gmail.com>
References: <20181113171221.2634-1-mathieu.desnoyers@efficios.com>
 <20181113171221.2634-2-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by lists.lttng.org (Postfix) with ESMTPS id 42xZ4r4DDczsQX
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 18:22:04 -0500 (EST)
Received: by mail-qk1-f196.google.com with SMTP id y16so40199140qki.7
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 15:22:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181113171221.2634-2-mathieu.desnoyers@efficios.com>
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

Merged all the way back to 2.9.

Thanks!
J=E9r=E9mie

On Tue, Nov 13, 2018 at 12:12:21PM -0500, Mathieu Desnoyers wrote:
> The semantic expected from max_t and min_t is to perform the max/min
> comparison in the type provided as first parameter.
> =

> Cast the input parameters to the proper type before comparing them,
> rather than after. There is no more need to cast the result of the
> expression now that both inputs are cast to the right type.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/macros.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/common/macros.h b/src/common/macros.h
> index c521aacd..461202ff 100644
> --- a/src/common/macros.h
> +++ b/src/common/macros.h
> @@ -72,7 +72,7 @@ void *zmalloc(size_t len)
>  #endif
>  =

>  #ifndef max_t
> -#define max_t(type, a, b)	((type) max(a, b))
> +#define max_t(type, a, b)	max((type) a, (type) b)
>  #endif
>  =

>  #ifndef min
> @@ -80,7 +80,7 @@ void *zmalloc(size_t len)
>  #endif
>  =

>  #ifndef min_t
> -#define min_t(type, a, b)	((type) min(a, b))
> +#define min_t(type, a, b)	min((type) a, (type) b)
>  #endif
>  =

>  #ifndef LTTNG_PACKED
> -- =

> 2.11.0
> =
