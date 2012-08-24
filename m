From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-tools] Filter: Notify the user when
	a filter	is already enabled on event(s)
Date: Thu, 23 Aug 2012 22:17:21 -0400
Message-ID: <20120824021721.GB13813__39854.3033785701$1345774673$gmane$org@Krystal>
References: <1345760474-29248-1-git-send-email-christian.babeux@efficios.com>
	<1345773912-30858-1-git-send-email-christian.babeux@efficios.com>
	<1345773912-30858-2-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T4jSc-0007W7-BC
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 22:17:22 -0400
Content-Disposition: inline
In-Reply-To: <1345773912-30858-2-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> When using the enable-event command in conjunction with the --filter option,
> a user can specify a filter expression to refine the trace output.
> 
> As stated in the lttng(1) man page, only the first activation of a filter on
> an event will work. Subsequent activation of any filter expression on the
> same event will fail.
> 
> e.g:
> 
> > lttng enable-event app:tp -s session -u --filter 'somefield > 42'
> 
> # Case: invalid filter expression
> > lttng enable-event app:tp -s session -u --filter 'invalid expression'
>   Error: Error setting filter
>   Warning: Some command(s) went wrong
> 
> > ...
> 
> # Case: filter already enabled for event app:tp
> > lttng enable-event app:tp -s session -u --filter 'someotherfield < 42'
>   Error: Error setting filter
>   Warning: Some command(s) went wrong
> 
> This commit differentiate the case where a filter was already set for the
> specified event from the generic 'Error setting filter' error message.
> 
> e.g:
> 
> > lttng enable-event app:tp -s session -u --filter 'somefield > 42'
> 
> # Case: invalid filter expression
> > lttng enable-event app:tp -s session -u --filter 'invalid expression'
>   Error: Error setting filter
>   Warning: Some command(s) went wrong
> 
> > ...
> 
> # Case: filter already enabled for event app:tp
> > lttng enable-event app:tp -s session -u --filter 'someotherfield < 42'
>   Error: Filter on event app:tp is already enabled (channel 0, session session)
>   Warning: Some command(s) went wrong
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> ---
>  src/bin/lttng/commands/enable_events.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
> index a2c8a68..5a81fdb 100644
> --- a/src/bin/lttng/commands/enable_events.c
> +++ b/src/bin/lttng/commands/enable_events.c
> @@ -384,7 +384,16 @@ static int enable_events(char *session_name)
>  			ret = lttng_set_event_filter(handle, ev.name, channel_name,
>  						opt_filter);
>  			if (ret < 0) {
> -				ERR("Error setting filter");
> +				switch (-ret) {
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
> @@ -554,7 +563,16 @@ static int enable_events(char *session_name)
>  			ret = lttng_set_event_filter(handle, ev.name,
>  				channel_name, opt_filter);
>  			if (ret < 0) {
> -				ERR("Error setting filter");
> +				switch (-ret) {
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
