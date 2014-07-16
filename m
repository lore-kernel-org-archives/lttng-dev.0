From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng modules 2.5.0
Date: Wed, 16 Jul 2014 22:30:23 +0000 (UTC)
Message-ID: <425850539.15819.1405549823846.JavaMail.zimbra__27431.8685442724$1405549898$gmane$org@efficios.com>
References: <2131645234.15817.1405549740816.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X7XiT-0008D3-T7
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 18:30:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D37B3401D9
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:30:29 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id bUI-xYW471xc for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:30:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CF8693401F8
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:30:24 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BHGS3RpuO5pV for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:30:24 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 8AD5A3401D9
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:30:24 +0000 (UTC)
In-Reply-To: <2131645234.15817.1405549740816.JavaMail.zimbra@efficios.com>
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

The LTTng modules provide Linux kernel tracing capability to the LTTng
2.x tracer toolset.

New and noteworthy:

- State dump of block devices,
- State dump of file descriptor flags and modes,
- 3.15 Linux kernel support,
- v4lv2 instrumentation support,
- MIPS32 system call tracing,
- New /proc/lttng-logger ABI.

How to use the new /proc/lttng-logger ABI:

From the command line (for instance):

Start lttng-sessiond as root,

# lttng-sessiond

Start tracing from root or from a user belonging to the
"tracing" group:

% lttng create
% lttng enable-event -k lttng-logger

Write event payload data to /proc/lttng-logger (from any user,
does not need to be in any group):

% echo -n "Some message" > /proc/lttng-logger

% Stop tracing, view trace

% lttng stop
% lttng view

You should see:

[10:44:24.810273367] (+?.?????????) thinkos lttng_logger: { cpu_id = 3 }, { _msg_length = 12, msg = "Some message" }

It is a quick and easy way to trace some events from user-space through
the kernel tracer. It is much more basic than UST: lttng-logger is slower
(involves system call round-trip to the kernel) and only supports
logging strings. But it's very quick and easy to use, especially from
scripts.

Changelog:
2014-07-16 (Take Your Poet to Work Day) LTTng modules 2.5.0
        * (no change)

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README files for installation instructions and
lttng-tools doc/quickstart.txt for usage information)


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
