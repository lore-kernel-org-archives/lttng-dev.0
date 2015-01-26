From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.4 (EOL)
Date: Mon, 26 Jan 2015 20:27:33 +0000 (UTC)
Message-ID: <920300812.53215.1422304053308.JavaMail.zimbra__33641.7977851399$1422304086$gmane$org@efficios.com>
References: <1140108668.53198.1422303829605.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YFqFw-0006kZ-N1
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 15:27:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F7C0340292
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:27:34 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id lAa1_4sPgKTC for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:27:34 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C331B3402B1
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:27:33 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id DP9iMdUcEmoj for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:27:33 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 932D9340292
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:27:33 +0000 (UTC)
In-Reply-To: <1140108668.53198.1422303829605.JavaMail.zimbra@efficios.com>
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

This is the last bugfix release of the stable-2.4 lttng-ust branch.
This branch has now reached end of life.

Changelog:

2015-01-26 lttng-ust 2.4.4
        * Fix: missing parenthesis in offset_align_floor
        * Fix: add urcu-bp TLS fixup
        * Fix: add missing poll.h include
        * Fix: get_subbuf: bound number of consumerd retry

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
