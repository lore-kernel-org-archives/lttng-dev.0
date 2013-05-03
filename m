From: Bill Trost <trost@cloud.rain.com>
Subject: Re: using --function/--probe
Date: Fri, 03 May 2013 07:46:30 -0700
Message-ID: <32266.1367592390__32007.126560393$1367593257$gmane$org@cloud.rain.com>
References: <20130502195431.GA15675@Krystal><20120605154950.GA21955@Krystal>
	<19046.1338994097@cloud.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sym.pathetech.com ([173.240.244.141])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <trost@cloud.rain.com>) id 1UYHFS-0006tC-AH
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 10:46:10 -0400
In-reply-to: Your message of Thu, 02 May 2013 15:54:31 EDT.
	<20130502195431.GA15675@Krystal>
Content-ID: <32264.1367592390.1@cloud.rain.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu wrote:
    * Bill Trost (trost@cloud.rain.com) wrote:
    > Mathieu wrote:
    >     * Bill Trost (trost@cloud.rain.com) wrote:
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

Hi, Mathieu,

I'd forgotten all about this. We eventually discovered,
as part of investigating the kworkers, that we had a
misconfigured sysctl. When we fixed that, the offending
kwork then disappeared completely -- problem solved.

Thanks for the "blast from the past",
Bill
