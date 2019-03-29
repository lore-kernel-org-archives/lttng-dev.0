From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: Properly sanitize input
 parameter
Date: Fri, 29 Mar 2019 14:13:46 -0400
Message-ID: <20190329181344.GA28162__36203.3390252449$1553883248$gmane$org@gmail.com>
References: <20190326195306.8278-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by lists.lttng.org (Postfix) with ESMTPS id 44W8xr0nhwz1KXC
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:13:51 -0400 (EDT)
Received: by mail-qk1-f195.google.com with SMTP id k189so1946075qkc.0
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:13:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190326195306.8278-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, stable-2.10, and stable-2.9.

Thanks!
J=E9r=E9mie

On Tue, Mar 26, 2019 at 03:53:06PM -0400, Yannick Lamarre wrote:
> The lttng client uses the sizeof the containing buffer, defined as
> LTTNG_SYMBOL_NAME_LEN, for input string sanitation instead of libc defined
> macro NAME_MAX. lttng-enable_channel improperly verified user input
> and wrongly discarded valid input in case NAME_MAX was less than the
> sizeof the containing buffer for the channel's name.
> This patch also fixes potential buffer overflow caused by an improperly
> bounded strcpy in the case where NAME_MAX would have been greater than
> LTTNG_SYMBOL_NAME_LEN.
> =

> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  src/bin/lttng/commands/enable_channels.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/com=
mands/enable_channels.c
> index b4e2942c..5e314d9b 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -244,7 +244,7 @@ static int enable_channel(char *session_name)
>  		void *extended_ptr;
>  =

>  		/* Validate channel name's length */
> -		if (strlen(channel_name) >=3D NAME_MAX) {
> +		if (strlen(channel_name) > sizeof(chan_opts.name) - 1) {
>  			ERR("Channel name is too long (max. %zu characters)",
>  					sizeof(chan_opts.name) - 1);
>  			error =3D 1;
> -- =

> 2.11.0
> =
