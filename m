From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.5.1
Date: Mon, 20 Oct 2014 21:15:20 +0000 (UTC)
Message-ID: <1903268089.12446.1413839720213.JavaMail.zimbra__24410.3267592893$1413839800$gmane$org@efficios.com>
References: <1906495631.12444.1413839690937.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XgKIi-0006ZR-6n
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 17:15:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 71D01340309
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 21:15:27 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id LoE9_YDH2dho for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 21:15:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7F7BF34031A
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 21:15:22 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id F8ALtgEdDMGf for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 21:15:21 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 7FF59340309
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 21:15:21 +0000 (UTC)
In-Reply-To: <1906495631.12444.1413839690937.JavaMail.zimbra@efficios.com>
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

This is a small bugfix release.

Changelog:
2014-10-20 lttng-ust 2.5.1
        * Fix: preserve example files' timestamps when copying
        * configure.ac: fix "missing jni.h" error message

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
