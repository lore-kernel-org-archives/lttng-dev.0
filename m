From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.6, 2.6.3, 2.7.0-rc2
Date: Wed, 9 Sep 2015 20:54:33 +0000 (UTC)
Message-ID: <1377019833.2304.1441832073168.JavaMail.zimbra__35857.7781975784$1441832156$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZZmOI-0008Ic-MI
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 16:54:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4DDFD34063C
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2015 20:54:45 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id xKywsjF_3K4X for <lttng-dev@lists.lttng.org>;
 Wed,  9 Sep 2015 20:54:33 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C4A6734063E
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2015 20:54:33 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Tqq09CpwAorR for <lttng-dev@lists.lttng.org>;
 Wed,  9 Sep 2015 20:54:33 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 9E1BC34063C
 for <lttng-dev@lists.lttng.org>; Wed,  9 Sep 2015 20:54:33 +0000 (UTC)
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

This announces bugfix releases across the three stable branches:
stable-2.5 (near EOL), stable-2.6, and stable-2.7 (in release candidate
stage).

Changelog:

2015-09-09 lttng-ust 2.7.0-rc2
        * Fix: close socket on protocol error, sendmsg MSG_NOSIGNAL
        * Cleanup: more descriptive error message
        * Fix: add missing ust lock around objd_table_destroy()
        * Fix: application exit race with pthread cancel
        * Cleanup: configure layout for python agent detection
        * Build: python agent: use setup.py over autoconf
        * Build: add python interpreter used by python agent if built
        * Doc: basic lttng ust python agent documentation
        * Build: use AM_PATH_PYTHON to resolve python when building agent
        * Build: only check if python exists in path
        * Doc: add LTTNG_UST_CLOCK_PLUGIN to man page
        * Doc: add LTTNG_UST_GETCPU_PLUGIN to man page
        * Fix: Java agent: update ref count in enabledLoggers
        * Rename Python agent tracepoint to "event"
        * Fix: remove generated file from git tree

2015-09-09 lttng-ust 2.6.3
        * Fix: close socket on protocol error, sendmsg MSG_NOSIGNAL
        * Fix: add missing ust lock around objd_table_destroy()
        * Fix: application exit race with pthread cancel
        * Fix: Java agent: update ref count in enabledLoggers
        * Fix: Use $enableval with AC_ARG_ENABLE
        * Fix: Cleanup local_apps sock_info in lttng_ust_cleanup
        * Fix: handle sys_futex EINTR and EWOULDBLOCK
        * Fix: update liburcu URL
        * Fix: running java examples out of tree
        * Fix: java class check when uudecode is not present
        * Fix compilation warnings in the Java agent
        * Fix: out of tree build of java agents
        * Fix: Use env CLASSPATH when building log4j example
        * Fix: build log4j example when enabled
        * Fix: perform volatile load of tracepoint state

2015-09-09 lttng-ust 2.5.6
        * Fix: close socket on protocol error, sendmsg MSG_NOSIGNAL
        * Fix: add missing ust lock around objd_table_destroy()
        * Fix: application exit race with pthread cancel
        * Fix: Cleanup local_apps sock_info in lttng_ust_cleanup
        * Fix: handle sys_futex EINTR and EWOULDBLOCK
        * Fix: perform volatile load of tracepoint state

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
