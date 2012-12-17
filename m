From: "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>
Subject: lttng: How to enable larger buffers?
Date: Mon, 17 Dec 2012 18:01:57 +0000
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A930031959__21937.2797095732$1355767970$gmane$org@NTXBOIMBX02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from masquerade.micron.com ([137.201.242.130])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sbradshaw@micron.com>) id 1Tkf0u-0000jj-7F
	for lttng-dev@lists.lttng.org; Mon, 17 Dec 2012 13:02:04 -0500
Received: from mail.micron.com (ntxboicas04.micron.com [137.201.20.214])
	by masquerade.micron.com (8.13.6/8.13.6) with ESMTP id qBHI1v7m019648
	for <lttng-dev@lists.lttng.org>; Mon, 17 Dec 2012 11:01:57 -0700
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

I'm trying to use lttng tools to identify some block stack latencies.  I'm tracing
syscall, softirq_*, and block_* kernel entry points using the latest 2.0 lttng on
RHEL 6.3 with a 3.6.6 kernel.

When I 'lttng view' the trace, I get all sorts of messages like:

"[warning] Tracer discarded XXXX events between <timestamp1> and <timestamp2>.  You
should consider recording a new trace with larger buffers or with fewer events 
enabled."

How/where do I modify the code to enable larger buffers?  Its not obvious from any
of the documentation I could find or a superficial code inspection.

Thanks,
-Sam
