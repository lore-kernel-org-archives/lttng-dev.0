From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.6, 2.6.3, 2.7.0-rc2
Date: Wed, 9 Sep 2015 20:56:48 +0000 (UTC)
Message-ID: <1083741246.2329.1441832208691.JavaMail.zimbra__42685.4127589197$1441832296$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZZmQR-0008Kx-4v
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 16:57:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C8710340643
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2015 20:56:57 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Lf6DTLciKgNO for <lttng-dev@lists.lttng.org>;
 Wed,  9 Sep 2015 20:56:49 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 19018340645
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2015 20:56:49 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id F8wK43ayGjXV for <lttng-dev@lists.lttng.org>;
 Wed,  9 Sep 2015 20:56:48 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id D8744340643
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2015 20:56:48 +0000 (UTC)
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

This announces bugfix releases across the three stable branches:
stable-2.5 (near EOL), stable-2.6, and stable-2.7 (in release candidate
stage).

Changelog:

2015-09-09 LTTng modules 2.7.0-rc2
        * Use 3.18 syscall instrumentation for MIPS32
        * Update the MIPS32 syscall instrumentation to 3.18
        * Fix: Move pipe override to the arch specific pointers_override.h
        * Implement lttng test module
        * Cleanup: remove logically dead code
        * Fix: filter validator use after free
        * Fix: use after free in channel release
        * Fix: non-enabler events should be disabled by default
        * Fix: build failure on 2.6.36
        * Cleanup: split bdi_dirty_ratelimit with ifdef into separate macros
        * Fix: writeback instrumentation for 4.2 kernels
        * Fix: kmem probe with Ubuntu 3.13 kernels
        * Fix: disable kvm probe if lapic.h isn't found
        * Fix: timer instrumentation for 4.2 kernels
        * Fix: ext4 instrumentation for 4.2 kernels
        * Fix: kvm instrumentation for 4.2 kernels
        * Fix: mm_page_alloc_extfrag instrumentation for kernel 3.18.10
        * Fix: allow LTTng to be built within kernel tree

2015-09-09 LTTng modules 2.6.3
        * Fix: use after free in channel release
        * Fix: build failure on 2.6.36
        * Fix: writeback instrumentation for 4.2 kernels
        * Fix: mm_page_alloc_extfrag instrumentation for kernel 3.18.10
        * Fix: kmem probe with Ubuntu 3.13 kernels
        * Fix: disable kvm probe if lapic.h isn't found
        * Fix: timer instrumentation for 4.2 kernels
        * Fix: ext4 instrumentation for 4.2 kernels
        * Fix: kvm instrumentation for 4.2 kernels
        * Fix: allow LTTng to be built within kernel tree
        * Fix: Building the event list fails on fragmented memory
        * Fix: use after free on metadata cache reallocation

2015-09-09 LTTng modules 2.5.6
        * Fix: use after free in channel release
        * Fix: build failure on 2.6.36
        * Fix: Update kmem event for Ubuntu's 3.16 kernel
        * Fix: Update kmem event for recent Ubuntu kernel
        * Fix: kmem probe with Ubuntu 3.13 kernels
        * Implement wrapper around get_pfnblock_flags_mask
        * Fix: Building the event list fails on fragmented memory
        * Fix: use after free on metadata cache reallocation

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
