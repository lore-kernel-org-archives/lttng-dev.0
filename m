From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.9.4, 2.10.3,
 2.11.0-rc2 (Linux user-space tracer)
Date: Fri, 25 Jan 2019 17:51:02 -0500 (EST)
Message-ID: <1228686375.1419.1548456662640.JavaMail.zimbra__41745.3610849165$1548456678$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43mZ4l4LZTzn8f
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 17:51:03 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Those are bugfix releases of LTTng-UST for the stable-2.9 and
stable-2.10 branches, as well as for the 2.11 branch, which is
currently in release candidate stage.

The fix "Fix: race between statedump and library destructor" takes
care of a crash happening in short-lived applications that use
lttng-ust.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:
2019-01-25 (National Opposite Day) lttng-ust 2.11.0-rc2
        * Fix: Initialize fd field of struct lttng_ust_elf to -1 at allocation
        * Clarify lib_ring_buffer_switch_slow() requirements
        * Fix: address shellcheck warnings/errors in example scripts
        * Fix: check for event class/instance prototype mismatch
        * Fix: race between statedump and library destructor
        * Fix: reset procname on fork in child process

2019-01-25 (National Opposite Day) lttng-ust 2.10.3
        * Fix: Initialize fd field of struct lttng_ust_elf to -1 at allocation
        * Clarify lib_ring_buffer_switch_slow() requirements
        * Fix: address shellcheck warnings/errors in example scripts
        * Fix: check for event class/instance prototype mismatch
        * Fix: race between statedump and library destructor
        * Fix: reset procname on fork in child process
        * Fix: Remove unused line from liblttng-ust-fd makefile

2019-01-25 (National Opposite Day) lttng-ust 2.9.4
        * Fix: Initialize fd field of struct lttng_ust_elf to -1 at allocation
        * Clarify lib_ring_buffer_switch_slow() requirements
        * Fix: address shellcheck warnings/errors in example scripts
        * Fix: check for event class/instance prototype mismatch
        * Fix: race between statedump and library destructor
        * Fix: reset procname on fork in child process
        * Fix: Remove unused line from liblttng-ust-fd makefile



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
