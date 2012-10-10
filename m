From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] Changes to the stop command
Date: Wed, 10 Oct 2012 15:34:04 -0400
Message-ID: <20121010193404.GA29797__33929.8189770945$1349897692$gmane$org@Krystal>
References: <5075AC59.3050704@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TM22f-0006s0-SS
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 15:34:05 -0400
Content-Disposition: inline
In-Reply-To: <5075AC59.3050704@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> Hi everyone,
> 
> We discovered a week ago a "broken guarantee" which is that when a
> session is stopped by either using the lttng command or the API call
> lttng_stop_session the traced data MUST be ready to be read.
> 
> However, we don't offer that at all for now for both local storage and
> network streaming. The stop command/call simply does _not_ wait for that
> state.
> 
> Here is the proposal to fix this issue before the 2.1 stable release.
> Let's add a new API call (extending it) that probes the session daemon
> for the trace files state (still writing, no more data, closed, ...).
> 
> Ex: lttng_data_state(handle)
> 
> This will bring a change to the default behavior of the stop command.
> From now on, it will wait by default until the data is available to read
> (for both network and local). This will however be done on the client
> side in order to avoid blocking the session daemon client command sub
> system for an unknown amount of time.
> 
> The way I propose we proceed is to use the new API call (mention above)
> on the liblttng-ctl side when a stop is done that requires it to wait.
> Unfortunately, there is no clean way to do that other than an active
> loop polling the session daemon...
> 
> The "no wait" use case of the stop command will also be added with a
> lttng_stop_session_no_wait or something like that.
> 
> In a nutshell:
> 
> (new) lttng_data_state(handle) --> name is NOT final, please chip in for
> ideas! :)

ideas:

- lttng_data_pending()
- lttng_data_available()


> (new) lttng_stop_session_no_wait(session_name) --> naming NOT final.

lttng_stop_session_no_wait sounds ok to me.

The rest looks good. Let's see if others find better names ;)

Thanks,

Mathieu

> 
> (changes) lttng stop (and lttng_stop_session) will now wait for the data
> to be available so babeltrace could be use right after for instance. A
> --no-wait will be added as well to the UI command.
> 
> I would like everyone opinion on that because this is an important issue
> that _MUST_ be fixed in 2.1 stable or at least in the 2.1.x series.
> 
> Thanks a lot!
> David
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
