From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.2
Date: Wed, 16 Jul 2014 22:07:17 +0000 (UTC)
Message-ID: <1347111743.15780.1405548437868.JavaMail.zimbra__1521.67984419993$1405548563$gmane$org@efficios.com>
References: <817971335.15779.1405548425824.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X7XM7-000819-2R
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 18:07:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7C50D3400FD
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:07:22 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZLsRZ1dlchly for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:07:18 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 280D334010F
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:07:18 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yWQDv-3gAbdO for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:07:18 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 095DF3400FD
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:07:18 +0000 (UTC)
In-Reply-To: <817971335.15779.1405548425824.JavaMail.zimbra@efficios.com>
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

Changelog:

2014-07-16 LTTng modules 2.4.2
        * Fix: statedump handle oom case, handle errors
        * Fix: correct typo in kernel version number
        * Fix: blktrace instrumentation for backported branches
        * Fix: refuse overwrite mode buffers with less than two subbuffers
        * Fix: lttng modules system call generation script
        * Fix: incorrect rwbs field type in block_bio_queue
        * Fix: blktrace instrumentation for v3.2.58+ stable branch
        * Fix: update block instrumentation to 3.15 kernel
        * Fix: pass proper args when writing commit counter
        * Fix: allow racy tracepoint string input from kernel and userspace

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
