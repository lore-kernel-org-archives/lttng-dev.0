From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.4.2
Date: Wed, 16 Jul 2014 22:06:32 +0000 (UTC)
Message-ID: <2029133555.15778.1405548392799.JavaMail.zimbra__47935.4210001931$1405548461$gmane$org@efficios.com>
References: <1464246885.15777.1405548378024.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1X7XLO-00080L-Ao
 for lttng-dev@lists.lttng.org; Wed, 16 Jul 2014 18:06:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A2FDE3400FD
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:06:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3lfqj0c7WjRO for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:06:33 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4267234010F
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:06:33 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id GWBfV2t_vesc for <lttng-dev@lists.lttng.org>;
 Wed, 16 Jul 2014 22:06:33 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 0AA5C3400FD
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jul 2014 22:06:33 +0000 (UTC)
In-Reply-To: <1464246885.15777.1405548378024.JavaMail.zimbra@efficios.com>
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

2014-07-16 lttng-ust 2.4.2
        * Move enablers syncing after the channel registration
        * Add lttng_ust_notrace to static inline functions
        * Fix: lttng-ust-jul: set thread in daemon mode
        * JUL: use root logger to capture events
        * Fix: multiple providers in same C file failure
        * Fix: out of tree build for lib Java and JUL
        * Fix: refuse overwrite mode buffers with less than two subbuffers
        * Fix: remove JUL loglevel filtering from the agent
        * Fix: cleanup JUL agent state on sessiond disconnect
        * Fix: Move generated headers to the BUILT_SOURCES target
        * Fix linking failure when cross-compiling
        * Fix: disable liblttng-ust-dl if dlinfo is not available in C library
        * Fix: pass proper args when writing commit counter
        * Fix: pad strings that are modified concurrently with tracing

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
