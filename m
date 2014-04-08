From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.1
Date: Tue, 8 Apr 2014 19:09:58 +0000 (UTC)
Message-ID: <2019402475.871.1396984198303.JavaMail.zimbra__5883.16310099817$1396984272$gmane$org@efficios.com>
References: <582563764.869.1396984175624.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WXbPM-0002SM-Cv
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 15:10:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7CE663402AE
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:10:03 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 66XUim-6Gs62 for <lttng-dev@lists.lttng.org>;
 Tue,  8 Apr 2014 19:09:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4C56A3402AF
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:09:59 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id DQI_Bxs0Ipps for <lttng-dev@lists.lttng.org>;
 Tue,  8 Apr 2014 19:09:59 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id EA0463402AE
 for <lttng-dev@lists.lttng.org>; Tue,  8 Apr 2014 19:09:58 +0000 (UTC)
In-Reply-To: <582563764.869.1396984175624.JavaMail.zimbra@efficios.com>
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
2014-04-08 lttng-ust 2.4.1
        * Revert "Fix: disable liblttng-ust-dl if dlinfo is not available in C library"
        * Fix: .split() the CC environment variable in lttng-gen-tp
        * Fix: disable liblttng-ust-dl if dlinfo is not available in C library
        * Fix: python invocation through env
        * Fix: Override AM_PATH_PYTHON's default action-if-not-found
        * Fix: don't accept configure --disable-shared
        * Fix: configure.ac: add missing result to alignment req. check
        * Fix: malloc wrapper: infinite recursion with compat TLS
        * Fix: liblttng-ust-libc-wrapper recursive use of calloc
        * Fix: mismatch between code and comments
        * Fix: incorrect urcu git URL in README

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
