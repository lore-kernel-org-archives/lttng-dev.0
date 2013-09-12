From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Feedback on your ARM LTTng benchmarks
Date: Thu, 12 Sep 2013 17:44:57 -0400
Message-ID: <20130912214457.GA7783__35997.7940832779$1379022359$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VKEhC-0000D8-JW
	for lttng-dev@lists.lttng.org; Thu, 12 Sep 2013 17:45:08 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Colin Ian King <colin.king@canonical.com>
Cc: lttng-dev@lists.lttng.org, kernel-team@lists.ubuntu.com
List-Id: lttng-dev@lists.lttng.org

Hi Colin,

I just read your post on:

https://lists.ubuntu.com/archives/kernel-team/2013-May/028450.html

and, although I'm very pleased to see that LTTng provides good
performances in your tests, there is a small detail on your benchmarking
approach I would like to bring to your attention. If you followed the
benchmarking procedure used by Romik Guha Anjoy and Soumya Kanti
Chakraborty's "Efficiency of Lttng as a Kernel and Userspace Tracer"
work, you only have part of the picture. I pointed this issue to them
when I stumbled on their work after it has been published.

You see, they only benchmark the equivalent of lttng-consumerd and
lttng-sessiond (in the lttng 0.x days, that was lttd). They entirely
miss the impact of the lttng-modules kernel tracer and lttng-ust
userspace tracer: the parts that write into the ring buffers.

This part is slightly harder to benchmark. This is why I relied on
system benchmarks with typical workloads to measure the overall system
slowdown in my thesis
(http://www.lttng.org/pub/thesis/desnoyers-dissertation-2009-12.pdf)
rather than use profiling.

If you only profile lttng-sessiond and lttng-consumerd, you will end up
noticing a very tiny impact indeed: while tracing is active,
lttng-sessiond is almost never active. lttng-consumerd needs to
transport the data, which indeed brings some overhead. However, if you
use lttng's flight recorder tracing (with snapshots) introduced in lttng
2.3, the consumerd is entirely out of the picture: it's just writing
into memory buffers.  Even then, the lttng-modules and lttng-ust parts
of the tracer have _some_ impact when writing into the buffers from the
kernel and user-space application contexts.

So overall, there is a part of the lttng footprint not accounted for.
It's very small, but it exists.

I just want to make sure that nobody can say later than "lttng is fast"
claim is based on bogus benchmarks. It is very fast, yes, but I
recommend revisiting your benchmarking approach if you based it solely
on Romik Guha Anjoy and Soumya Kanti Chakraborty's work.

On typical benchmarks, my own results were usually under 5% of overhead
system-side (see my thesis for details).

Thank you !

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
