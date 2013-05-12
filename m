From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST context causes empty trace
Date: Sat, 11 May 2013 23:08:02 -0400
Message-ID: <20130512030802.GE405__13913.1306823858$1368328115$gmane$org@Krystal>
References: <518EEC19.6080504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UbMdo-0006qs-Fv
	for lttng-dev@lists.lttng.org; Sat, 11 May 2013 23:08:04 -0400
Content-Disposition: inline
In-Reply-To: <518EEC19.6080504@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>, dgoulet@efficios.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Yes, it's broken here too. Can you open a bug report against UST please?

it looks like those are missing when we enable UST contexts:

libust[26034/26049]: Sent register channel notification: chan_id 0, header_type 1
 (in ustcomm_register_channel() at lttng-ust-comm.c:1053)
[...]
libust[26034/26034]: Sent register event notification for name "ust_tests_hello:tptest": ret_code 0, event_id 0
 (in ustcomm_register_event() at lttng-ust-comm.c:948)
libust[26034/26034]: Sent register event notification for name "ust_tests_hello:tptest_sighandler": ret_code 0, event_id 1
 (in ustcomm_register_event() at lttng-ust-comm.c:948)

(I get those in a run where I don't enable any UST context, but not in
the problematic case)

the rest seems to be there when launching the app with LTTNG_UST_DEBUG=1
env var set. So it looks like an issue within UST.

Thanks,

Mathieu

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> With 2.2.0-rc2, when enabling some context for UST, the generated trace
> is empty. Here is a small script to reproduce the problem:
> 
> $ cat do.sh
> lttng create
> lttng enable-channel u -u
> lttng enable-event -c u -a -u
> lttng add-context -c u -u -t vpid -t vtid
> lttng start
> $@
> lttng stop
> lttng view
> lttng destroy
> 
> When commenting out the "add-context" command, then the trace is
> generated correctly. Does someone else is able to confirm the problem?
> 
> Thanks,
> 
> Francis Giraldeau
> 



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
