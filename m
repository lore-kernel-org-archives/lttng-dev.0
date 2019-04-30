From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Bump LTTNG_UST_ABI to 8.0
Date: Tue, 30 Apr 2019 15:12:52 -0400
Message-ID: <20190430191250.GA11256__1212.37837463326$1556651593$gmane$org@gmail.com>
References: <20190430185951.12050-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44trlC3tH7z1Kc0
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 15:12:55 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id i31so8833587qti.13
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 12:12:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190430185951.12050-1-mathieu.desnoyers@efficios.com>
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

Merged in master and stable-2.11.

I added a note to the commit message referencing the fix
(6c737d05) in the lttng-ust tree.

Thanks!
J=E9r=E9mie

On Tue, Apr 30, 2019 at 02:59:51PM -0400, Mathieu Desnoyers wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/lttng-ust-abi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessi=
ond/lttng-ust-abi.h
> index 687eb0b2..40ba1f47 100644
> --- a/src/bin/lttng-sessiond/lttng-ust-abi.h
> +++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
> @@ -44,8 +44,8 @@
>  #define LTTNG_UST_COMM_MAGIC			0xC57C57C5
>  =

>  /* Version for ABI between liblttng-ust, sessiond, consumerd */
> -#define LTTNG_UST_ABI_MAJOR_VERSION		7
> -#define LTTNG_UST_ABI_MINOR_VERSION		2
> +#define LTTNG_UST_ABI_MAJOR_VERSION		8
> +#define LTTNG_UST_ABI_MINOR_VERSION		0
>  =

>  struct lttng_ust_calibrate;
>  =

> -- =

> 2.11.0
> =
