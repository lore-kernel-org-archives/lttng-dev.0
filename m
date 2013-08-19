From: Thuya Aung <thuyaaung2002@yahoo.com>
Subject: babeltrace : Clock "monotonic" offset differs between
	traces
Date: Mon, 19 Aug 2013 07:32:06 -0700 (PDT)
Message-ID: <1376922726.78813.YahooMailBasic__23475.5614227199$1376922995$gmane$org@web163905.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm45-vm1.bullet.mail.gq1.yahoo.com ([67.195.87.87])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thuyaaung2002@yahoo.com>) id 1VBQVB-0003kt-9b
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 10:32:19 -0400
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

Hello lttng-dev,

First of all, I like to thank LTTng development team for such a wonderful tracing tool for us to use.

I am having the following messages when I viewed the trace file in babeltrace.
[warning] Clock "monotonic" offset differs between traces (delta 52116 ns). Using average.
[warning] Clock "monotonic" offset differs between traces (delta 72396 ns). Using average.

My questions are,
1. Why am I having these warning? Can I reliably analyze traces after having these warning?
2. How can I minimize or eliminate that kind of offset?

The version of LTTng tools we are using are,
lttng-modules : 2.1.1
lttng-tools   : 2.1.1
lttng-ust     : 2.1.2
userspace-rcu : 0.7.6
babeltrace    : 1.0.3

kernel version : 2.6.37.6 for power-pc

Best Regards,
Thuya
