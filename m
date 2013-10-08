From: Michael Lausch <michael.lausch@omicron.at>
Subject: Use lttng for my own module which already has trace
	events
Date: Tue, 8 Oct 2013 13:03:36 +0200
Message-ID: <6B3AC2788014DD49B43AF9611365BBAA21CACCA460__49381.6274487928$1381230270$gmane$org@mary.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns.omicron.at ([212.183.10.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michael.lausch@omicron.at>) id 1VTV4q-0005M9-Ei
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 07:03:45 -0400
Received: from counter.omicron.at ([212.183.10.29])
	by ns.omicron.at (8.13.1/8.13.1) with ESMTP id r98B3bGX025552
	for <lttng-dev@lists.lttng.org>; Tue, 8 Oct 2013 13:03:42 +0200
Received: from mary.at.omicron.at (mary.at.omicron.at [172.22.100.48])
	by counter.omicron.at (8.14.4/8.14.4) with ESMTP id r98B3bdE027313
	for <lttng-dev@lists.lttng.org>; Tue, 8 Oct 2013 13:03:37 +0200
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

Hi,

I've developed a kernel module which defines TRACE_EVENTS. These events
are shown in /sys/kernel/debug/tracing/events and i can read them
from /sys/kernel/debug/tracing/trace if they are enabled.

But i want to use these events in lttng. 
# lttng list -k 
does not show them. 

How to make these events available to lttng? Do i need to write a lttng
module? If so, what's the best way to do this for a out of kernel module
which is under the GPL? 
