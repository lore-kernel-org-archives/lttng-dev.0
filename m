From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.4 and 2.6.1
Date: Wed, 29 Apr 2015 15:17:42 +0000 (UTC)
Message-ID: <1873773903.40702.1430320662881.JavaMail.zimbra__218.461376107548$1430320760$gmane$org@efficios.com>
References: <1814803923.40695.1430320559235.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YnTkB-0001I8-Qy
 for lttng-dev@lists.lttng.org; Wed, 29 Apr 2015 11:17:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BE12D3402F9
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 15:17:53 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id zH8_fZREB5so for <lttng-dev@lists.lttng.org>;
 Wed, 29 Apr 2015 15:17:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 57AA83403A7
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 15:17:43 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id AV0R_EbGb7zf for <lttng-dev@lists.lttng.org>;
 Wed, 29 Apr 2015 15:17:43 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 2F82D340344
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 15:17:43 +0000 (UTC)
In-Reply-To: <1814803923.40695.1430320559235.JavaMail.zimbra@efficios.com>
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

Those releases cover bugfixes, and support for newer kernels (up
to 4.0) in the 2.6.1 release.

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Changelogs:

2015-04-29 LTTng modules 2.5.4
        * Fix: mmutrace warnings about redefined macros
        * Fix: x86 mmutrace event extra field for kernels >= 3.11
        * Fix: add missing x86 mmutrace kernel header include
        * Fix: update README file to match reality: kernels >= 2.6.36 are supported
        * Fix: add struct file_handle forward declaration
        * Fix: atomic.h wrapper for kernels < 2.6.37
        * Fix: disable x86 kvm instrumentation for kernels < 2.6.38
        * Fix: mm_page_alloc_extfrag instrumentation for kernel 3.14.36
        * Fix: update backported kmem patches to lttng-modules 2.5 API
        * Fix: kmem instrumentation update for mm_page_alloc_extfrag kernel 3.19.2+
        * Fix: kmem instrumentation: mm_page_alloc extfrag change_ownership field

2015-04-29 LTTng modules 2.6.1
        * Fix: regmap build against kernel 4.0 kernel headers
        * Fix: mmutrace warnings about redefined macros
        * Fix: add missing x86 mmutrace kernel header include
        * Fix: x86 mmutrace event extra field for kernels >= 3.11
        * Fix: remove execute flag from kvm.h file
        * Fix: build x86 kvm probes on kernels >= 4.1-rc1
        * Fix: compilation warnings on 4.1-rc1 kernel
        * Fix: compilation on 4.1-rc1 kernel, remove unused WB_WORK_REASON
        * Fix: 4.1-rc1 Linux build and regmap instrumentation
        * Fix: don't clash with older Debian kernel versions
        * Fix: update get_pfnblock_flags_mask wrapper for debian kernels
        * Fix: discover Debian API
        * Fix: Update README.md to match reality: kernels >= 2.6.36 are supported
        * Fix: add struct file_handle forward declaration
        * Fix: atomic.h wrapper for kernels < 2.6.37
        * Fix: disable x86 kvm instrumentation for kernels < 2.6.38
        * Fix: check that class and instance prototype match
        * Fix: lttng-events.h check function takes void
        * Update regmap instrumentation for Linux 3.19.4 and 4.0
        * Fix: kernels >= 2.6.33 put utsrelease.h in generated/
        * Fix: Include utsrelease.h in lttng-kernel-version.h
        * Fix: old kernels need module.h included before vermagic.h
        * Fix: version condition in makefile
        * Implement wrapper around get_pfnblock_flags_mask
        * Fix: Support 4.x kernel versions in Makefile
        * Fix: mm_page_alloc_extfrag instrumentation for kernel 3.14.36
        * Fix: update writeback instrumentation for kernel 4.0+
        * Fix: compaction mm_compaction_isolate_template update for Linux 4.0+
        * Fix: kmem instrumentation update for mm_page_alloc_extfrag kernel 3.19.2+
        * Fix: kmem instrumentation: mm_page_alloc extfrag change_ownership field

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
