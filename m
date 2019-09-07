From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.0-rc6, 2.10.11,
 2.9.14  (Linux kernel tracer)
Date: Sat, 7 Sep 2019 08:26:51 -0400 (EDT)
Message-ID: <1650973402.81.1567859211691.JavaMail.zimbra__23173.7105919578$1567859228$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46QYZh5rpzzsV0
 for <lttng-dev@lists.lttng.org>; Sat,  7 Sep 2019 08:26:52 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 53434A55BA
 for <lttng-dev@lists.lttng.org>; Sat,  7 Sep 2019 08:26:52 -0400 (EDT)
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

Those releases cover all actively maintained branches of the lttng-modules
project.

For stable-2.10 and stable-2.9, those include only bugfixes.

For the stable-2.11 branch, currently in release candidate
stage, it introduces two new ABI:

  * LTTNG_KERNEL_SESSION_SET_CREATION_TIME
  * LTTNG_KERNEL_SESSION_SET_NAME

It populates additional trace metadata environment fields
with internal information and with information provided by
the lttng session daemon. This allows trace readers to
re-create the trace directory hierarchy from the metadata
environment.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2019-09-07 (Walter White's Anniversary) LTTng modules 2.11.0-rc6
        * Fix: gcc-9.1 stack frame size warning
        * Introduce LTTNG_KERNEL_SESSION_SET_CREATION_TIME
        * Add metadata env fields
        * Introduce LTTNG_KERNEL_SESSION_SET_NAME
        * Fix: do not use diagnostic pragma when GCC version is lower than 4.6.0
        * Fix: missing define when not building with gcc
        * Fix: lttng-tracepoint module notifier should return NOTIFY_OK

2019-09-07 (Walter White's Anniversary) LTTng modules 2.10.11
        * Fix: gcc-9.1 stack frame size warning
        * Fix: do not use diagnostic pragma when GCC version is lower than 4.6.0
        * Fix: missing define when not building with gcc
        * Fix: lttng-tracepoint module notifier should return NOTIFY_OK

2019-09-07 (Walter White's Anniversary) LTTng modules 2.9.14
        * Fix: gcc-9.1 stack frame size warning
        * Fix: do not use diagnostic pragma when GCC version is lower than 4.6.0
        * Fix: missing define when not building with gcc
        * Fix: lttng-tracepoint module notifier should return NOTIFY_OK

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
