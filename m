From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.10.2 and 2.9.5 (Linux kernel tracer)
Date: Thu, 5 Oct 2017 21:16:24 +0000 (UTC)
Message-ID: <923225973.32274.1507238184545.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Those are two important bugfix releases coming shortly after 2.10.1 and
2.9.4, which introduced a NULL pointer dereference in the block layer
instrumentation for kernels before 4.14. This issue has been caught by
our CI at <http://ci.lttng.org>.

All LTTng-modules users of versions 2.10.1 and 2.9.4 should upgrade.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2017-10-05 LTTng modules 2.10.2
        * Fix: update block instrumentation for 4.14 kernel
        * Revert "Fix: update block instrumentation for kernel 4.14"

2017-10-05 LTTng modules 2.9.5
        * Fix: update block instrumentation for 4.14 kernel
        * Revert "Fix: update block instrumentation for kernel 4.14"

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
