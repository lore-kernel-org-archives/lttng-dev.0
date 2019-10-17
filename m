From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.15 (EOL),
 2.10.12 (Linux kernel tracer)
Date: Thu, 17 Oct 2019 16:01:09 -0400 (EDT)
Message-ID: <1993019012.12718.1571342469013.JavaMail.zimbra__20526.9261424959$1571342523$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46vKmP4KVRz184W
 for <lttng-dev@lists.lttng.org>; Thu, 17 Oct 2019 16:01:09 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 64DF33453CF
 for <lttng-dev@lists.lttng.org>; Thu, 17 Oct 2019 16:01:09 -0400 (EDT)
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

We are pleased to announce the 2.9.15 (EOL) and 2.10.12 stable releases
of the LTTng-modules project 2.9 and 2.10 stable branches.

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New in these release:

Both releases contain an update the the scheduler "prev_state" field
of the sched_switch event. It now traces payload which matches the
various changes that went through the various upstream Linux kernel
versions.

Now that the release of LTTng-modules 2.11.0 is imminent, version
2.9.15 marks the end of life (EOL) of the 2.9 stable branch of
LTTng-modules.

Thanks!

Mathieu

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
