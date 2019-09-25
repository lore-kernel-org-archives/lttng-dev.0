From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v3] Fix: use newly created event
 filter for condition check
Date: Wed, 25 Sep 2019 12:41:41 -0400
Message-ID: <20190925164141.GA12820__49669.8456395947$1569429847$gmane$org@gmail.com>
References: <20190924152417.47028-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 46dkNV0GnqzqQf
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 12:41:45 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id 3so116599qta.1
 for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2019 09:41:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190924152417.47028-1-jonathan.rajotte-julien@efficios.com>
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

Backported to stable-2.10, and stable-2.9.

Thanks!
J=E9r=E9mie

On Tue, Sep 24, 2019 at 11:24:17AM -0400, Jonathan Rajotte wrote:
> The following commit introduced a regression while
> fixing the filter and filter_expression ownership.
> =

> commit b0a23296344e57bd2e48e62ec2d7e0d8a38661bb
> Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> Date:   Sat Jan 12 14:53:56 2019 -0500
> =

>     Fix: leak of filter bytecode and expression on agent event re-enable
> =

>     The agent subsystem does not properly assume the clean-up of an
>     event's filter bytecode and expression when a previously disabled
>     event is re-enabled.
> =

>     This change ensures that the ownership of both the filter bytecode
>     and expression is assumed by the agent subsystem and discarded
>     when a matching event is found.
> =

>     Steps to reproduce the leak:
>     $ lttng create
>     $ lttng enable-event --python allo --filter 'a[42] =3D=3D 241'
>     $ lttng disable-event --python allo
>     $ lttng enable-event --python allo --filter 'a[42] =3D=3D 241'
> =

>     Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> =

> Setting the "filter" object to NULL prevents the call to
> add_filter_app_ctx when needed.
> =

> We use the filter from the newly created event to
> perform the check and the call to add_filter_app_ctx.
> =

> Fixes coverity #1399733
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/event.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/even=
t.c
> index f32db4429..a8b7646da 100644
> --- a/src/bin/lttng-sessiond/event.c
> +++ b/src/bin/lttng-sessiond/event.c
> @@ -513,8 +513,9 @@ int event_agent_enable(struct ltt_ust_session *usess,
>  		created =3D 1;
>  	}
>  =

> -	if (created && filter) {
> -		ret =3D add_filter_app_ctx(filter, filter_expression, agt);
> +	if (created && aevent->filter) {
> +		ret =3D add_filter_app_ctx(
> +				aevent->filter, aevent->filter_expression, agt);
>  		if (ret !=3D LTTNG_OK) {
>  			goto error;
>  		}
> -- =

> 2.17.1
> =
