From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracepoint event exclusion
Date: Wed, 27 Jun 2012 14:33:08 -0400
Message-ID: <20120627183308.GA19735__5274.95700303024$1340822014$gmane$org@Krystal>
References: <4FEB13CE.1010206@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sjx37-0006Gs-TD
	for lttng-dev@lists.lttng.org; Wed, 27 Jun 2012 14:33:09 -0400
Content-Disposition: inline
In-Reply-To: <4FEB13CE.1010206@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> Hi,
>
> In order to support situations where a user wants generally all  =

> tracepoints enabled but specific tracepoints to be suppressed during a  =

> trace session, I created a small patch that allows us to do the =

> following:
>
> ...
> lttng enable-event -u -c met_tools -a
> lttng enable-event -u -c met_tools --tracepoint '!met_func:*'
> lttng enable-event -u -c met_tools --tracepoint '!met_call:*'

hrm, although possibly interesting, I don't think this semantic follows
the lttng UI event enabling semantic. There are a few use-cases to
cover:

1) enable tracepoints, start tracing, run app.

2) enable some tracepoints, start tracing, run app, enable more
   tracepoints while app is running.

3) start tracing, run app, enable all tracepoints while app is running.

AFAIU, your patch and proposed semantic covers use-case #1, but breaks
the other 2. Basically, we have to apply a logical "or" between each
enable-event command (rather than an "and" as your proposed semantic
suggests), because they can be applied independently.

We could however try to come up with an event attribute that gets
applied on a specific event, e.g.:

lttng enable-event -u -a --exclude 'met_func:*' --exclude 'met_call:*'

thoughts ?

Thanks,

Mathieu

> ...
>
> This has the effect that all tracepoints get recorded except for  =

> tracepoints that match met_func:* or met_call:*.
>
> If you think this feature is useful for others we would be happy to see  =

> this patch merged into trunk.
>
> Thanks,
> Paul
>
> -- =

> Paul Woegerer | SW Development Engineer
> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> P 43.1.535991320
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
>
> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.
>

> From 74602f6f4ea4b1d7faa01f76542f62b496b94091 Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Wed, 27 Jun 2012 15:21:30 +0200
> Subject: [PATCH] Added excluding/filtering of events with !NAME
> =

> ---
>  liblttng-ust/ltt-events.c |   33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> =

> diff --git a/liblttng-ust/ltt-events.c b/liblttng-ust/ltt-events.c
> index 0fdfd2f..b663312 100644
> --- a/liblttng-ust/ltt-events.c
> +++ b/liblttng-ust/ltt-events.c
> @@ -150,11 +150,32 @@ struct wildcard_entry *match_wildcard(const struct =
lttng_event_desc *desc)
>  	struct wildcard_entry *e;
>  =

>  	cds_list_for_each_entry(e, &wildcard_list, list) {
> +	    size_t len =3D strlen(e->name);
> +	    if (len < 1 || e->name[0] !=3D '!')
> +		continue;
> +
> +	    DBG("Filter %s against wildcard_entry %s\n", desc->name, e->name);
> +
> +	    /* Compare exclusion wildcards excluding initial '!' and final '*' =
*/
> +	    if (!strncmp(desc->name, e->name + 1, len - 2))
> +	    {
> +		DBG("Exclude %s due to exclusion wildcard_entry %s\n", desc->name, e->=
name);
> +		return NULL; /* exclusion wildcard matched */
> +	    }
> +	}
> +
> +	cds_list_for_each_entry(e, &wildcard_list, list) {
> +	    size_t len =3D strlen(e->name);
> +	    if (len > 0 && e->name[0] =3D=3D '!')
> +		continue;
> +
> +	    DBG("Match %s against wildcard_entry %s\n", desc->name, e->name);
> +
>  		/* If only contain '*' */
> -		if (strlen(e->name) =3D=3D 1)
> +		if (len =3D=3D 1)
>  			goto possible_match;
>  		/* Compare excluding final '*' */
> -		if (!strncmp(desc->name, e->name, strlen(e->name) - 1))
> +		if (!strncmp(desc->name, e->name, len - 1))
>  			goto possible_match;
>  		continue;	/* goto next, no match */
>  	possible_match:
> @@ -507,6 +528,13 @@ int ltt_event_create(struct ltt_channel *chan,
>  	struct ltt_event *event;
>  	int ret =3D 0;
>  =

> +	if (strlen(event_param->name) > 0 && event_param->name[0] =3D=3D '!')
> +	{
> +	    struct session_wildcard *sw =3D NULL;
> +	    ltt_wildcard_create(chan, event_param, &sw );
> +	    goto filter;
> +	}
> +
>  	if (chan->used_event_id =3D=3D -1U) {
>  		ret =3D -ENOMEM;
>  		goto full;
> @@ -607,6 +635,7 @@ cache_error:
>  no_loglevel_match:
>  exist:
>  full:
> +filter:
>  	return ret;
>  }
>  =

> -- =

> 1.7.10.4
> =


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
