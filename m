From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/1] Fix: consumer snapshot:
 handle unsigned long overflow
Date: Fri, 29 Mar 2019 14:37:35 -0400
Message-ID: <20190329183734.GG28162__19289.9863862962$1553884672$gmane$org@gmail.com>
References: <20190219224749.8979-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 44W9TH2F7Vz1Kcn
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:37:39 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id t28so3741176qte.6
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:37:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190219224749.8979-1-mathieu.desnoyers@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com, joraj@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, stable-2.10, and stable-2.9.

Thanks!
J=E9r=E9mie

On Tue, Feb 19, 2019 at 05:47:49PM -0500, Mathieu Desnoyers wrote:
> Comparing the consumed iterator and the produced position without
> using a difference generates an empty snapshot when the iterator is
> before unsigned long overflow and the produced position is after
> unsigned long overflow.
> =

> This applies to both UST and kernel consumers.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/kernel-consumer/kernel-consumer.c | 2 +-
>  src/common/ust-consumer/ust-consumer.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/ke=
rnel-consumer/kernel-consumer.c
> index 9bed7b55..1533e9ef 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -234,7 +234,7 @@ int lttng_kconsumer_snapshot_channel(struct lttng_con=
sumer_channel *channel,
>  				produced_pos, nb_packets_per_stream,
>  				stream->max_sb_size);
>  =

> -		while (consumed_pos < produced_pos) {
> +		while ((long) (consumed_pos - produced_pos) < 0) {
>  			ssize_t read_len;
>  			unsigned long len, padded_len;
>  =

> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-cons=
umer/ust-consumer.c
> index 46f33005..94b761cb 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -1168,7 +1168,7 @@ static int snapshot_channel(struct lttng_consumer_c=
hannel *channel,
>  				produced_pos, nb_packets_per_stream,
>  				stream->max_sb_size);
>  =

> -		while (consumed_pos < produced_pos) {
> +		while ((long) (consumed_pos - produced_pos) < 0) {
>  			ssize_t read_len;
>  			unsigned long len, padded_len;
>  =

> -- =

> 2.11.0
> =
