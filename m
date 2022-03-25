Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D1C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 25 Mar 2022 19:21:10 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KQBlT05NKzJQ3;
	Fri, 25 Mar 2022 15:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648236069;
	bh=3XbfdSLDTuJuahqMRnooKmXjDXgK+KZUdgYEvRhaUyM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=L1GM6JtdXjhTsR6Igck7zWKLU7yihyODQ63TwT/1e8WINEbfwbLSSvAQhEq0iJJlX
	 aZYKMRtyVguzY+e0pbVoQot3N5ymAcMmgpWMu7tICG29IW7zaKC8TkZBGa92eBiHi6
	 0X81QbjppVJ01sGNuCBQgq6iXjMe5D/GYFdN3jB0IDkhnHxG9n7UG9FIutxbFm1JSh
	 3eaGQXlG3M+Tbv3Let1LIRYoCsXDCDtFczuEIB6MOR7zKwYWSS0oABvwbu304I3/X0
	 iJ008+uyl1ncv1ypM1lyosIu+NldgIDInq7lEq+8qoJmbPJvu0WtdoC1JTysan8eQi
	 z7DCHIrk7OSnw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KQBlR3vvqzJwl
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 15:21:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 04DAD3F93FF
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2022 15:21:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Di5e2I5kUZyI; Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6E1EF3F92E5;
 Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6E1EF3F92E5
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id SN81cawGgHhn; Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 49FFA3F962D;
 Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
Date: Fri, 25 Mar 2022 15:21:00 -0400 (EDT)
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, 
 linux-trace-users@vger.kernel.org, 
 linux-kernel <linux-kernel@vger.kernel.org>
Cc: lwn <lwn@lwn.net>
Message-ID: <298059821.194836.1648236060140.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Index: /XuRM8m30UNxv1/uEfXFqpcCoOViXw==
Thread-Topic: LTTng-UST 2.13.2 and 2.12.4 (Linux user-space tracer)
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.13.2 and 2.12.4 (Linux user-space
 tracer)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

This is a stable release announcement for the LTTng-UST project. LTTng-UST
is a tracer for Linux user-space applications. The respective versions are
2.13.2 and 2.12.4.

The most important change introduced in these releases is the implementation
of a LTTng-UST Log4j 2.x log appender. Note that in the context of
CVE-2021-45046 [2], LTTng-UST per-se is not affected because it does not
use Log4j for its own logging, but rather implements a log appender (a log
"sink").

Here are the noteworthy changes:

In both 2.13.2 and 2.12.4:

* Add a Log4j 2.x Java agent

    Before those releases, LTTng-UST only implemented a Log4j 1.x appender.
    Considering that Log4j 1.x has been unmaintained since 2015 [1], and that
    a range of Log4j 2.x versions are affected by the critical vulnerability
    CVE-2021-45046, allowing Log4j users which use LTTng-UST as a log appender
    to upgrade from Log4j 1.x to an up-to-date 2.x is very much relevant,
    thus explaining why this new feature is introduced in LTTng-UST stable
    releases.

    This adds a new agent to the LTTng-UST Java agents suite supporting the
    Log4j 2.x logging backend.

    This backport differs from the master branch for the
    '--enable-java-agent-all' option won't select this new agent since we
    wanted to avoid introducing a new dependency in existing configurations.

    The name of the new agent jar file is "lttng-ust-agent-log4j2.jar".
    It will be installed in the arch-agnostic "$prefix/share/java" path
    e.g: "/usr/share/java".
    
    It uses the same jni library "liblttng-ust-log4j-jni.so" as the Log4j 1.x agent.
    
    The agent was designed as a mostly drop-in replacement for applications
    upgrading from Log4j 1.x to 2.x. It requires no modification to the
    tracing configuration as it uses the same domain "-l / LOG4J" and the
    loglevels integer representations are converted to the Log4j 1.x values
    (excluding custom loglevels).

* Fix: concurrent exec(2) file descriptor leak

    If exec(2) is executed by the application concurrently with LTTng-UST
    listener threads between the creation of a file descriptor with
    socket(2), recvmsg(2), or pipe(2) and call to fcntl(3) FD_CLOEXEC, those
    file descriptors will stay open after the exec, which is not intended.
    
    As a consequence, shared memory files for ring buffers can stay present
    on the file system for long-running traced processes.

    Rather than fcntl(2) FD_CLOEXEC to make sure the file descriptors are
    closed on exec immediately upon their creation.

Noteworthy specifically in 2.13.2:

* Fix: sample discarded events count before reserve

    Sampling the discarded events count in the buffer_end callback is done
    out of order, and may therefore include increments performed by following
    events (in following packets) if the thread doing the end-of-packet
    event write is preempted for a long time.
    
    Sampling the event discarded counts before reserving space for the last
    event in a packet, and keeping this as part of the private ring buffer
    context, should fix this race.

    This fix is only part of the 2.13 stable branch and not backported to
    2.12 because the lib ring buffer code used to implement this fix did not
    exist in 2.12. Given that the impact of this bug is only imprecision of
    discarded event reporting in corner-case scenarios (small impact, rare
    occurrence), the complexity of implementing this fix in 2.12 is not justified.
    The effect of this issue is that the lttng-tools
    tests/regression/tools/streaming/test_high_throughput_limits test is flaky.

Feedback is welcome!

Thanks,

Mathieu

[1] https://blogs.apache.org/foundation/entry/apache_logging_services_project_announces
[2] https://www.cve.org/CVERecord?id=CVE-2021-45046

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
