From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.7.1 (Linux kernel tracer)
Date: Tue, 5 Jan 2016 18:37:35 +0000 (UTC)
Message-ID: <1055877487.338270.1452019055481.JavaMail.zimbra__38748.1361548$1452019120$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aGWUG-00068O-Ky
 for lttng-dev@lists.lttng.org; Tue, 05 Jan 2016 13:37:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8E2D43403DE
 for <lttng-dev@lists.lttng.org>; Tue,  5 Jan 2016 18:37:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ibedG5e40fDp for <lttng-dev@lists.lttng.org>;
 Tue,  5 Jan 2016 18:37:35 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C23553404F7
 for <lttng-dev@lists.lttng.org>; Tue,  5 Jan 2016 18:37:35 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qoyVg-n2uLNP for <lttng-dev@lists.lttng.org>;
 Tue,  5 Jan 2016 18:37:35 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id A17473403DE
 for <lttng-dev@lists.lttng.org>; Tue,  5 Jan 2016 18:37:35 +0000 (UTC)
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

Hi,

We just released lttng-modules 2.7.1, which is a bugfix release for
the stable-2.7 branch.

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2016-01-05 LTTng modules 2.7.1
        * Fix: Use MAX_RT_PRIO offset in sched_wakeup_template
        * Fix: update sched instrumentation for kernel 4.4.0
        * Fix: instrumentation: v4lv2 missing include
        * Fix: header size larger than 256 bytes
        * Fix: tracepoint listing misses last loaded probe
        * Fix: lttng trace-clock needs to disable preemption

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
