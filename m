From: Michael Haberler <mail17@mah.priv.at>
Subject: introduction  & usage of LTTNG in machinekit
Date: Fri, 27 Mar 2015 16:51:22 +0100
Message-ID: <887B7027-5FE6-4D13-B35A-7DCBD785DC57__16794.4646477283$1427471582$gmane$org@mah.priv.at>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YbWXd-0003qt-8h
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 11:51:33 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

before I start asking questions - a short intro:

I learned about lttng by David Goulet's talk at FOSDEM 2013

I am involved in machinekit.io, a portable realtime application for motion control
machinekit runs on several kernels - starting from vanilla (no time guarantees), RT-PREEMPT, Xenomai, and RTAI; on x86, amd64 and ARM platforms.

As some of the processing is highly time sensitive, I'm looking into integrating LTTNG into the machinekit build so we have options beyond logging and timestamping manually. For instance, currently some transcendental math functions on ARM overrun the time budget.

I've started integrating the build support and am running into my first problems. So, that's the context of my following questions - thanks in advance for guiding me through any blunders.

looking forward using lttng productively.

Michael

ps: in case you're interested - a talk about the portable realtime API: http://static.mah.priv.at/public/portable-realtime-API-talk/
