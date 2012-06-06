From: Bill Trost <trost@cloud.rain.com>
Subject: Re: using --function/--probe
Date: Wed, 06 Jun 2012 07:48:17 -0700
Message-ID: <19046.1338994097__5704.07114360041$1338995733$gmane$org@cloud.rain.com>
References: <20120605154950.GA21955@Krystal><3551.1338647739@cloud.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sym.pathetech.com ([173.240.244.141])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <trost@cloud.rain.com>) id 1ScHWl-0003pt-Jh
	for lttng-dev@lists.lttng.org; Wed, 06 Jun 2012 10:48:03 -0400
In-reply-to: Your message of Tue, 05 Jun 2012 11:49:50 EDT.
	<20120605154950.GA21955@Krystal>
Content-ID: <19044.1338994097.1@cloud.rain.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu wrote:
    * Bill Trost (trost@cloud.rain.com) wrote:
    > and how does it differ from "--probe"? How do I determine
    > what symbols are valid for each of these options?

    It entirely depends on which functions are blacklisted in the kernel
    (this is an attribute added to the functions specifically for kprobes).
    The keyword is "__kprobes".

Is that the only basis? For example, I can add a dynamic tracepoint (of
either flawor) for queue_work_on(), but not work __queue_work(), yet
neither of those functions have any apparent annotation. Or does
EXPORT_SYMBOL_GPL imply a probe point?

    > ...how do I trace what work is being
    > enqueued and run by the kworker threads?

    For this level of details, I think kprobes/kretprobes will not
    currently allow you to fetch it. The two options we have are:

    - use static tracepoints. Is there a tracepoint that targets the
      information you are looking for ? Try "lttng list -k".

No, I've been capturing all kernel events and haven't seen
anything resembling the kworker tracepoints of lttng 0.x.

    - or extend the dynamic probing to allow fetching variables from
      debug information,

Hmm. Well, I did a bit more poking and got a bit closer -- at least now
I know what dynamic points to use. (eg, "queue_work_on" and friends to
see what is being queued). I take it that LTT can't capture function call
arguments as a form of additional context? That would be an ideal
bit of information in this case.

Thanks again,
Bill
