From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.0-rc3
Date: Fri, 12 Dec 2014 16:14:12 +0000 (UTC)
Message-ID: <1991568982.26719.1418400852854.JavaMail.zimbra__33961.1175157644$1418400895$gmane$org@efficios.com>
References: <1757798463.26715.1418400839860.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XzSr9-00013n-BD
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 11:14:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BC906340260
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 16:14:13 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 1_y2fd0J9QAS for <lttng-dev@lists.lttng.org>;
 Fri, 12 Dec 2014 16:14:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 410CF340261
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 16:14:13 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MGIyZxgx7jgX for <lttng-dev@lists.lttng.org>;
 Fri, 12 Dec 2014 16:14:13 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 22A51340260
 for <lttng-dev@lists.lttng.org>; Fri, 12 Dec 2014 16:14:13 +0000 (UTC)
In-Reply-To: <1757798463.26715.1418400839860.JavaMail.zimbra@efficios.com>
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
2014-12-12 lttng-ust 2.6.0-rc3
        * Fix: man: you can't link a lib with a static lib
        * Fix: context alignment not properly handled
        * Fix: Shorthand option -cp not supported in all version of Java
        * Fix: allow tracepoints to build with --std=c99
        * Fix: filter attach vs event enable race
        * Fix: add a configure check for weak symbols support
        * Fix coverity warning about sizeof(void **) != sizeof(void *)
        * Fix: off-by-one in sequence filter comparator
        * Fix: Java Agent JAR file symlink should be created after objects install

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README.md file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
