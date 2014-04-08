From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.4.1
Date: Tue, 8 Apr 2014 19:10:39 +0000 (UTC)
Message-ID: <2111457467.873.1396984239674.JavaMail.zimbra__7643.44133572212$1396984420$gmane$org@efficios.com>
References: <859398624.872.1396984232434.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WXbQ5-0002Sw-7s
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 15:10:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 823F93402AE
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:10:46 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id P1tF-cCh7DiT for <lttng-dev@lists.lttng.org>;
 Tue,  8 Apr 2014 19:10:41 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C932F3402AF
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:10:40 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kHPh9K-VefAb for <lttng-dev@lists.lttng.org>;
 Tue,  8 Apr 2014 19:10:40 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 62FC43402AE
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:10:40 +0000 (UTC)
In-Reply-To: <859398624.872.1396984232434.JavaMail.zimbra@efficios.com>
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
2014-04-08 LTTng modules 2.4.1
        * Fix: rcu instrumentation: add const qualifier to char pointers
        * Fix: add missing module version information
        * Fix: block instrumentation: < 3.14 don't have bi_iter
        * Fix: update btrfs instrumentation to kernel 3.14
        * Fix: update block layer instrumentation to kernel 3.14
        * Fix file permissions for lttng-statedump-impl.c

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
