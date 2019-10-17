From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.9.7 (EOL),
 2.10.6 (Linux user-space tracer)
Date: Thu, 17 Oct 2019 16:01:07 -0400 (EDT)
Message-ID: <656595855.12717.1571342467573.JavaMail.zimbra__504.994571541317$1571342487$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46vKmN4ksBz184D
 for <lttng-dev@lists.lttng.org>; Thu, 17 Oct 2019 16:01:08 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 471233453BB
 for <lttng-dev@lists.lttng.org>; Thu, 17 Oct 2019 16:01:08 -0400 (EDT)
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

Hi,

We are pleased to announce the 2.9.7 (EOL) and 2.10.6 stable releases
of the LTTng-UST 2.9 and 2.10 stable branches.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

* New in this release:

Important fixes to the lttng-ust fd tracker (liblttng-ust-fd.so) were done,
taking care of locking the fd tracker across fork() in the liblttng-ust-fork.so
wrapper, eliminating hangs observed in the child if the parent was executing
close() concurrently with fork(). Also, given that close() is an async-signal-safe
function, ensure that the synchronization strategy is robust against signals
by disabling signals and using a TLS nesting counter when taking the fd tracker
lock. [1, 2]

Another important fix to the lttng-ust fd tracker is disabling thread
cancellation around fd tracker lock, and locking the fd tracker across
fork() in the liblttng-ust-fork.so wrapper. Failure to do so causes
deadlocks in child applications if a pthread cancellation is performed
on a thread while it ran the liblttng-ust-fd close(3) wrapper. [3]

The locking strategy of the LTTng perf counter contexts was revisited to
eliminate a deadlock occurring once in a while when using the perf counters
context with lttng-ust. [4]

Now that the release of LTTng-UST 2.11.0 is imminent, version 2.9.7 marks
the end of life (EOL) of the 2.9 stable branch of LTTng-UST.

Thanks!

Mathieu

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

[1] https://bugs.lttng.org/issues/1199
[2] https://bugs.lttng.org/issues/1200
[3] https://bugs.lttng.org/issues/1201
[4] https://bugs.lttng.org/issues/1202

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
