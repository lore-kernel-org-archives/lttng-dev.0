From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.0-rc7 (Linux kernel tracer)
Date: Fri, 11 Oct 2019 16:28:40 -0400 (EDT)
Message-ID: <907852202.19209.1570825720359.JavaMail.zimbra__5489.94000289298$1570825766$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46qffx040zz1Qr1
 for <lttng-dev@lists.lttng.org>; Fri, 11 Oct 2019 16:28:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B49D33408DC
 for <lttng-dev@lists.lttng.org>; Fri, 11 Oct 2019 16:28:40 -0400 (EDT)
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

* New in this release:

Changes since the last 2.11 release candidate are very few: one commit
fixes compilation on the current 5.4-rc Linux kernels, and one user-visible
change is related to the sched_switch Linux kernel tracepoint "prev_state"
field. It adapts to the upstream Linux changes that were integrated in
4.14, 4.15, and 4.20, making sure we provide relevant information in the
trace in every build scenario.

We expect this release candidate to be the last one before releasing
2.11 final.

In order to keep the release announcements short, we will stop including
the detailed Changelog. It is always available in the project source tree.

Thanks!

Mathieu

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
