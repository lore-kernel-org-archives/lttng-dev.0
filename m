From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.10.5 and 2.11.3 (Linux kernel tracer)
Date: Wed, 8 Apr 2020 11:33:43 -0400 (EDT)
Message-ID: <173230590.27143.1586360023462.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

This announcement covers the 2.10.15 and 2.11.3 stable branch releases
for the LTTng-modules project. The 2.10.15 version will be the last for
the 2.10 branch given that the 2.12 final release is expected today.

Those releases include changes to support updated Ubuntu and CentOS
(RHEL) kernels. The unused ftrace integration has been removed, and
some dependencies on kallsyms were replaced by use of exported kernel
symbols.

Thanks,

Mathieu


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
