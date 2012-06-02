From: Bill Trost <trost@cloud.rain.com>
Subject: using --function/--probe
Date: Sat, 02 Jun 2012 07:35:39 -0700
Message-ID: <3551.1338647739__49255.0764502541$1338867577$gmane$org@cloud.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sym.pathetech.com ([173.240.244.141])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <trost@cloud.rain.com>) id 1SapQK-0002P0-UM
	for lttng-dev@lists.lttng.org; Sat, 02 Jun 2012 10:35:25 -0400
Content-ID: <3549.1338647739.1@cloud.rain.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm trying to investigate a problem under Linux 2.6.39.4 involving
kworker threads and am pretty much stymied. I've tried enabling
various events using --function and --probe and it's been
very hit or miss. Very often, "lttng enable-event" comes back
with nothing more specific than "bad ioctl", but every once
in a while I'll find a symbol I can add a probe point for.

So: What does "--probe" mean? What does "--function" mean, and how does
it differ from "--probe"? How do I determine what symbols are valid for
each of these options? And, maybe as a worked example, how do I
trace what work is being enqueued and run by the kworker threads?

Thanks,
Bill
