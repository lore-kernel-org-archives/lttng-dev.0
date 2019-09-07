From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST v2.11.0-rc4, v2.10.5,
 v2.9.6 (Linux user-space tracer)
Date: Sat, 7 Sep 2019 08:17:54 -0400 (EDT)
Message-ID: <433645114.42.1567858674197.JavaMail.zimbra__43728.7420661718$1567858695$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46QYNM5gSszsSN
 for <lttng-dev@lists.lttng.org>; Sat,  7 Sep 2019 08:17:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 01B6BA527F
 for <lttng-dev@lists.lttng.org>; Sat,  7 Sep 2019 08:17:55 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

Those are bugfix releases for all currently maintained branches of lttng-ust
(stable-2.9, stable-2.10, and finally stable-2.11 which is nearing completion
of its release candidate stage).

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2019-09-07 (Walter White's Anniversary) lttng-ust 2.11.0-rc4
        * Fix: don't wait for initial statedump when 0 session active
        * Fix: wait for initial statedump before proceeding to the main program
        * Use MAP_POPULATE to reduce pagefault when available
        * Fix: remove uninitialised value
        * Fix: GCC unaligned pointer warnings
        * Fix: do not use diagnostic pragma when GCC version is lower than 4.6.0
        * Fix: missing define when not building with gcc
        * Fix: client_sequence_number may dereference NULL pointer
        * Fix: namespace our gettid wrapper

2019-09-07 (Walter White's Anniversary) lttng-ust 2.10.5
        * Fix: don't wait for initial statedump when 0 session active
        * Fix: wait for initial statedump before proceeding to the main program
        * Fix: remove uninitialised value
        * Fix: GCC unaligned pointer warnings
        * Fix: do not use diagnostic pragma when GCC version is lower than 4.6.0
        * Fix: missing define when not building with gcc
        * Fix: client_sequence_number may dereference NULL pointer
        * Fix: namespace our gettid wrapper

2019-09-07 (Walter White's Anniversary) lttng-ust 2.9.6
        * Fix: don't wait for initial statedump when 0 session active
        * Fix: wait for initial statedump before proceeding to the main program
        * Fix: remove uninitialised value
        * Fix: GCC unaligned pointer warnings
        * Fix: do not use diagnostic pragma when GCC version is lower than 4.6.0
        * Fix: missing define when not building with gcc
        * Fix: client_sequence_number may dereference NULL pointer
        * Fix: namespace our gettid wrapper

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
