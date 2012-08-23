From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Filter: Notify the user when a
	filter is	already enabled on event(s)
Date: Thu, 23 Aug 2012 18:45:41 -0400
Message-ID: <20120823224541.GA3495__9081.92119463838$1345761975$gmane$org@Krystal>
References: <1345760474-29248-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T4g9m-0005y3-RJ
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 18:45:42 -0400
Content-Disposition: inline
In-Reply-To: <1345760474-29248-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  src/bin/lttng/commands/enable_events.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
> index a2c8a68..7a65ee6 100644
> --- a/src/bin/lttng/commands/enable_events.c
> +++ b/src/bin/lttng/commands/enable_events.c
> @@ -384,7 +384,17 @@ static int enable_events(char *session_name)
>  			ret = lttng_set_event_filter(handle, ev.name, channel_name,
>  						opt_filter);
>  			if (ret < 0) {
> -				ERR("Error setting filter");
> +				switch (-ret)

bracket on same line as switch statement please.

> +				{
> +				case LTTCOMM_FILTER_EXIST:
> +					ERR("Filter on events is already enabled (channel %s, session %s)",
> +						channel_name, session_name);
> +					break;
> +				default:
> +					ERR("Error setting filter");
> +					break;
> +				}
> +
>  				ret = -1;
>  				goto error;
>  			}
> @@ -554,7 +564,17 @@ static int enable_events(char *session_name)
>  			ret = lttng_set_event_filter(handle, ev.name,
>  				channel_name, opt_filter);
>  			if (ret < 0) {
> -				ERR("Error setting filter");
> +				switch (-ret)

same here.

Can you describe the change in the changelog ? What was the behavior
before, with some example cases (sequences of commands), and what this
is changing.

Thanks,

Mathieu

> +				{
> +				case LTTCOMM_FILTER_EXIST:
> +					ERR("Filter on event %s is already enabled (channel %s, session %s)",
> +						event_name, channel_name, session_name);
> +					break;
> +				default:
> +					ERR("Error setting filter");
> +					break;
> +				}
> +
>  				ret = -1;
>  				goto error;
>  			}
> -- 
> 1.7.11.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
