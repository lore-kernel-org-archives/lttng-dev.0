From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.4 and 2.6.1
Date: Wed, 29 Apr 2015 15:23:45 +0000 (UTC)
Message-ID: <590553016.40776.1430321025277.JavaMail.zimbra__38730.8948128068$1430321112$gmane$org@efficios.com>
References: <163621053.40773.1430320965875.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YnTq1-0001LI-5U
 for lttng-dev@lists.lttng.org; Wed, 29 Apr 2015 11:23:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9D2E73403B1
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 15:23:54 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id rHghFM8wo4JP for <lttng-dev@lists.lttng.org>;
 Wed, 29 Apr 2015 15:23:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AA05C3403B2
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 15:23:45 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id HBP0lCm70ZA8 for <lttng-dev@lists.lttng.org>;
 Wed, 29 Apr 2015 15:23:45 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 768B23403B1
 for <lttng-dev@lists.lttng.org>; Wed, 29 Apr 2015 15:23:45 +0000 (UTC)
In-Reply-To: <163621053.40773.1430320965875.JavaMail.zimbra@efficios.com>
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

This is a small bugfix release for LTTng-UST 2.5 and 2.6 branches.

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

Changelogs:

2015-04-29 lttng-ust 2.5.4
        * Fix: use lttng_secure_getenv to handle env. vars. involving paths
        * Fix: add missing getenv wrapper
        * Fix: Don't wait during registration if clock_gettime() fails

2015-04-29 lttng-ust 2.6.1
        * Fix: use lttng_secure_getenv to handle env. vars. involving paths
        * Fix: add missing getenv wrapper
        * Fix: Don't wait during registration if clock_gettime() fails
        * Fix: Mismatching code and console output in log4j example

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
