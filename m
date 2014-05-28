From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.0-rc1
Date: Wed, 28 May 2014 14:46:48 +0000 (UTC)
Message-ID: <1770950142.24180.1401288408233.JavaMail.zimbra__26026.9864149906$1401288470$gmane$org@efficios.com>
References: <1561093639.24160.1401287991633.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Wpf7z-000279-CK
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 10:46:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4484D34011B
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 14:46:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id fISxzhqiGtt4 for <lttng-dev@lists.lttng.org>;
 Wed, 28 May 2014 14:46:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9823A340274
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 14:46:48 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jLCL-yIMaP-e for <lttng-dev@lists.lttng.org>;
 Wed, 28 May 2014 14:46:48 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 6260934011B
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 14:46:48 +0000 (UTC)
In-Reply-To: <1561093639.24160.1401287991633.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

New and noteworthy:

- State dump of block devices,
- State dump of file descriptor flags and modes,
- 3.15 Linux kernel support,
- v4lv2 instrumentation support,
- MIPS32 system call tracing,
- New /proc/lttng-logger ABI.

How to use the new /proc/lttng-logger ABI:

From the command line (for instance):

Start lttng-sessiond as root,

# lttng-sessiond

Start tracing from root or from a user belonging to the
"tracing" group:

% lttng create
% lttng enable-event -k lttng-logger

Write event payload data to /proc/lttng-logger (from any user,
does not need to be in any group):

% echo -n "Some message" > /proc/lttng-logger

% Stop tracing, view trace

% lttng stop
% lttng view

You should see:

[10:44:24.810273367] (+?.?????????) thinkos lttng_logger: { cpu_id = 3 }, { _msg_length = 12, msg = "Some message" }

It is a quick and easy way to trace some events from user-space through
the kernel tracer. It is much more basic than UST: lttng-logger is slower
(involves system call round-trip to the kernel) and only supports
logging strings. But it's very quick and easy to use, especially from
scripts.


Detailed changelog:

2014-05-28 (International Hamburger Day) LTTng modules 2.5.0-rc1
        * Add TID field to some block_* events
        * Fix: refuse overwrite mode buffers with less than two subbuffers
        * Fix: lttng modules system call generation script
        * Dump FD flags and mode on state dump
        * Fix: incorrect rwbs field type in block_bio_queue
        * Fix: blktrace instrumentation for v3.2.58+ stable branch
        * Fix: pass proper args when writing commit counter
        * Cleanup: lib ringbuffer: pagecpy has unsigned semantic
        * Fix: allow racy tracepoint string input from kernel and userspace
        * Statedump event for block devices
        * Fix: update v4l2 instrumentation to 3.15 kernel
        * Fix: ext4 update instrumentation to 3.15 kernel
        * Fix: update block instrumentation to 3.15 kernel
        * Fix: module instrumentation: update to 3.15 kernel
        * Adapt to 3.15 tracepoint API
        * Kernel 3.15 don't define map unmap for pipe
        * Fix: add missing module version in v4l2 probe
        * Add V4L2 instrumentation
        * Fix: rcu instrumentation: add const qualifier to char pointers
        * Fix: add missing module version information
        * Use kernel 3.13 syscall tables for MIPS32
        * Add MIPS32 syscalls extracted from a 3.13 kernel
        * Fix: block instrumentation: < 3.14 don't have bi_iter
        * Fix: update btrfs instrumentation to kernel 3.14
        * Fix: update block layer instrumentation to kernel 3.14
        * Fix: remove __exit annotation
        * Fix file permissions for lttng-statedump-impl.c
        * LTTng logger ABI

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
