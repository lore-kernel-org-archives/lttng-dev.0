From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.2
Date: Fri, 12 Dec 2014 15:37:43 +0000 (UTC)
Message-ID: <474165704.26668.1418398663045.JavaMail.zimbra__3945.26835666529$1418398708$gmane$org@efficios.com>
References: <785596807.26667.1418398652699.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XzSHq-0000m1-KN
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 10:37:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CEFF9340043
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 15:37:44 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id YlDcZoyETzCe for <lttng-dev@lists.lttng.org>;
 Fri, 12 Dec 2014 15:37:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9A1283400E6
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 15:37:43 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Eezj6ydJtxNU for <lttng-dev@lists.lttng.org>;
 Fri, 12 Dec 2014 15:37:43 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 3C103340043
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 15:37:43 +0000 (UTC)
In-Reply-To: <785596807.26667.1418398652699.JavaMail.zimbra@efficios.com>
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
2014-12-12 LTTng modules 2.5.2
        * Fix: compaction instrumentation update for 3.14.x stable kernels
        * Fix: context alignment not properly handled

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README.md files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
