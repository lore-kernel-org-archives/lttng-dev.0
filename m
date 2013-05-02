From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: using --function/--probe
Date: Thu, 2 May 2013 15:54:31 -0400
Message-ID: <20130502195431.GA15675__15938.1560901695$1367524512$gmane$org@Krystal>
References: <20120605154950.GA21955@Krystal> <19046.1338994097@cloud.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UXzaL-00065s-GM
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 15:54:33 -0400
Content-Disposition: inline
In-Reply-To: <19046.1338994097@cloud.rain.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bill Trost <trost@cloud.rain.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Bill Trost (trost@cloud.rain.com) wrote:
> Mathieu wrote:
>     * Bill Trost (trost@cloud.rain.com) wrote:
>     > and how does it differ from "--probe"? How do I determine
>     > what symbols are valid for each of these options?
> 
>     It entirely depends on which functions are blacklisted in the kernel
>     (this is an attribute added to the functions specifically for kprobes).
>     The keyword is "__kprobes".
> 
> Is that the only basis? For example, I can add a dynamic tracepoint (of
> either flawor) for queue_work_on(), but not work __queue_work(), yet
> neither of those functions have any apparent annotation. Or does
> EXPORT_SYMBOL_GPL imply a probe point?

No, it doesn't.

> 
>     > ...how do I trace what work is being
>     > enqueued and run by the kworker threads?
> 
>     For this level of details, I think kprobes/kretprobes will not
>     currently allow you to fetch it. The two options we have are:
> 
>     - use static tracepoints. Is there a tracepoint that targets the
>       information you are looking for ? Try "lttng list -k".
> 
> No, I've been capturing all kernel events and haven't seen
> anything resembling the kworker tracepoints of lttng 0.x.

LTTng 2.2-rc has a new workqueue instrumentation. Maybe this can fit
your use-case ?

> 
>     - or extend the dynamic probing to allow fetching variables from
>       debug information,
> 
> Hmm. Well, I did a bit more poking and got a bit closer -- at least now
> I know what dynamic points to use. (eg, "queue_work_on" and friends to
> see what is being queued). I take it that LTT can't capture function call
> arguments as a form of additional context? That would be an ideal
> bit of information in this case.

Currently it can't.

(sorry for late reply)

Thanks,

Mathieu

> 
> Thanks again,
> Bill

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
