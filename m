From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.0-rc2
Date: Fri, 27 Jun 2014 14:24:23 +0000 (UTC)
Message-ID: <686006560.5328.1403879063674.JavaMail.zimbra__43721.4654441506$1403879158$gmane$org@efficios.com>
References: <1545776973.5327.1403879030732.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X0X4k-0007uY-VX
 for lttng-dev@lists.lttng.org; Fri, 27 Jun 2014 10:24:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F19F534010E
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:24:28 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 89qJrMtyVACE for <lttng-dev@lists.lttng.org>;
 Fri, 27 Jun 2014 14:24:24 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 938BC3401A0
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:24:24 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UEjFOTcZvJi9 for <lttng-dev@lists.lttng.org>;
 Fri, 27 Jun 2014 14:24:24 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 3AFAC34010E
 for <lttng-dev@lists.lttng.org>; Fri, 27 Jun 2014 14:24:24 +0000 (UTC)
In-Reply-To: <1545776973.5327.1403879030732.JavaMail.zimbra@efficios.com>
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

2014-06-27 lttng-ust 2.5.0-rc2
        * Fix: lttng-ust-jul: set thread in daemon mode
        * JUL: use root logger to capture events
        * Fix: Wrong configure check for UST perf event counters context support
        * Fix: multiple providers in same C file failure
        * Fix: header inclusion guard typo in lttng-ust-tracef-provider.h
        * Fix: 2.5.0-rc1 changelog has off-by-one date


Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
