From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.6.0-rc1
Date: Mon, 20 Oct 2014 23:07:41 +0000 (UTC)
Message-ID: <170192919.12502.1413846461057.JavaMail.zimbra__1649.3005714894$1413846521$gmane$org@efficios.com>
References: <1950717008.12500.1413846406635.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XgM3M-0007Cu-BE
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 19:07:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 788A034034A
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 23:07:48 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mJj8yUo7ZSG5 for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 23:07:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 487D934034D
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 23:07:43 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id HV8Owo2csVtw for <lttng-dev@lists.lttng.org>;
 Mon, 20 Oct 2014 23:07:42 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id 2B16E34034A
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 23:07:42 +0000 (UTC)
In-Reply-To: <1950717008.12500.1413846406635.JavaMail.zimbra@efficios.com>
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

New & noteworthy in this release: we implemented a Java LOG4J support.
(see https://logging.apache.org/log4j/1.2/)

Changelog:
2014-10-20 lttng-ust 2.6.0-rc1
        * Add missing file to gitignore
        * Fix: preserve example files' timestamps when copying
        * Fix: Abort loading log4j agent classes when detected log4j version is too old
        * Cleanup: Remove the no longer needed liblttng-ust-jul folder
        * Fix: Wrong CLASSPATH when building liblttng-ust-java oot
        * Fix: Wrong CLASSPATH when building liblttng-ust-java-agent oot
        * Rename public structure to avoid collisions
        * Refactor liblttng-ust-jul in liblttng-ust-agent
        * Build the liblttng-ust-java library using the new M4 macros
        * Add M4 macros helpers to build Java programs
        * Modernize README using Markdown
        * Documentation: clarify event name in lttng-ust.3
        * Add cscope to gitignore
        * configure.ac: fix "missing jni.h" error message
        * Fix: remove references to trace_printf()
        * Change JUL agent to use the new ABI

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
