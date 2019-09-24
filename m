From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: use newly created event
 filter for condition check
Date: Tue, 24 Sep 2019 11:23:05 -0400
Message-ID: <20190924152305.GJ187569__39215.180398763$1569338602$gmane$org@joraj-alpa>
References: <20190924152114.45975-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46d4hC6dkfz1Mx0
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 11:23:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190924152114.45975-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Do not review, this include a change that should not be part of this commit.

On Tue, Sep 24, 2019 at 11:21:14AM -0400, Jonathan Rajotte wrote:
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
>  src/bin/lttng-sessiond/agent.c | 1 +
>  src/bin/lttng-sessiond/event.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> =

> diff --git a/src/bin/lttng-sessiond/agent.c b/src/bin/lttng-sessiond/agen=
t.c
> index 9ea899f57..79233ab7c 100644
> --- a/src/bin/lttng-sessiond/agent.c
> +++ b/src/bin/lttng-sessiond/agent.c
> @@ -1145,6 +1145,7 @@ struct agent_event *agent_create_event(const char *=
name,
>  	event->loglevel_type =3D loglevel_type;
>  	event->filter =3D filter;
>  	event->filter_expression =3D filter_expression;
> +	event->enabled =3D 0;
>  error:
>  	return event;
>  }
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


-- =

Jonathan Rajotte-Julien
EfficiOS
