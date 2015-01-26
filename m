From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.0 (Gaia)
Date: Mon, 26 Jan 2015 19:58:38 +0000 (UTC)
Message-ID: <1799409529.53124.1422302318422.JavaMail.zimbra__30505.4791192108$1422302364$gmane$org@efficios.com>
References: <739551800.53106.1422302087713.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YFpny-0006TG-3q
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 14:58:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BD55D340046
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 19:58:39 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SDaF_LI5dR5l for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 19:58:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EBE7A3401E0
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 19:58:38 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id vxftrk8oJaAq for <lttng-dev@lists.lttng.org>;
 Mon, 26 Jan 2015 19:58:38 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id BB72534003B
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 19:58:38 +0000 (UTC)
In-Reply-To: <739551800.53106.1422302087713.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

New & noteworthy in this LTTng-UST release: it includes Java LOG4J
logger integration. Java LOG4J is a Java logging API. Java applications
can therefore use either JUL (since LTTng-UST 2.5) or LOG4J (since
LTTng-UST 2.6) to send their logs to LTTng-UST through the LTTng Log
Handler. See https://logging.apache.org/log4j/1.2/ for details.

Changelog since 2.6.0-rc3:
2015-01-26 lttng-ust 2.6.0
        * Fix: java-agent: out-of-tree path to java manifest
        * Fix: missing parenthesis in offset_align_floor
        * Fix: add ustctl_has_perf_counters
        * Fix: add urcu-bp TLS fixup
        * Fix: add missing poll.h include
        * Fix: get_subbuf: bound number of consumerd retry

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
