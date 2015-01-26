From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.3
Date: Mon, 26 Jan 2015 20:14:02 +0000 (UTC)
Message-ID: <859580996.53164.1422303242389.JavaMail.zimbra__29455.63597973$1422303274$gmane$org@efficios.com>
References: <1925350532.53162.1422303212935.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YFq2r-0006ce-KZ
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 15:14:02 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4A2CF340279
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:14:03 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PW-q8qyufHDB for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:14:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D63AE340286
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:14:02 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Uq-PNWthhQUY for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 20:14:02 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id B0FBB340279
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 20:14:02 +0000 (UTC)
In-Reply-To: <1925350532.53162.1422303212935.JavaMail.zimbra@efficios.com>
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

This is a bugfix release.

Changelog since lttng-ust 2.5.2:

2015-01-26 lttng-ust 2.5.3
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
