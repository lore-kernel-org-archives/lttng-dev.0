From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.0-rc2
Date: Tue, 4 Nov 2014 17:03:28 +0000 (UTC)
Message-ID: <1399068322.7413.1415120608424.JavaMail.zimbra__31605.0325324342$1415120682$gmane$org@efficios.com>
References: <801466286.7412.1415120596677.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XlhW5-0007Ys-OD
 for lttng-dev@lists.lttng.org; Tue, 04 Nov 2014 12:03:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2F796340182
 for <lttng-dev@lists.lttng.org>; Tue,  4 Nov 2014 17:03:33 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id W8zucBnNBEGC for <lttng-dev@lists.lttng.org>;
 Tue,  4 Nov 2014 17:03:28 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D1D8434019A
 for <lttng-dev@lists.lttng.org>; Tue,  4 Nov 2014 17:03:28 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id B1UnIjkzh45H for <lttng-dev@lists.lttng.org>;
 Tue,  4 Nov 2014 17:03:28 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 9D34C340182
 for <lttng-dev@lists.lttng.org>; Tue,  4 Nov 2014 17:03:28 +0000 (UTC)
In-Reply-To: <801466286.7412.1415120596677.JavaMail.zimbra@efficios.com>
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

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

Changelog:
2014-11-04 lttng-ust 2.6.0-rc2
        * Fix: Add versioning to liblttng-ust-agent JAR
        * Fix: Warn when log4j version is too old
        * Update Java agent documentation
        * Fix: Try loading classes using the thread context class loader
        * Update version name

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README.md file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
