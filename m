Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DE7C433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Dec 2021 20:45:49 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J9jbc0KZ4z1sZd;
	Fri, 10 Dec 2021 15:45:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639169148;
	bh=SFrEBKB77LzuoI4Y35SQ4tE3cncmom7B8RFKVEGXDzs=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=iaazd/V1rrIaFGa9SK7EMISdLcC/2ph1fHyoGhphAGdl8wX9a+tjN/sqvl8T2Moaj
	 NxY496DaxXUE7jsm1R5k4DjuaYHXMv4vVoPTHGbxyP4lCxAzcy27rTd6kUrsEbr8uS
	 KpqsECiVSbFjCj6g58saIchBUTCUjKjoVHGn5Bze4Q7uCcOoCTQso5k3WVj/89Eoxa
	 qXdMjbmT8ZXcl7tRzM4aTEh8uLi8/HxPjW4h95hXNWgAKn5/qDgXyf2hr2sl5uM8Dy
	 haC+KD89kUg2t5qNJ0fMMDvLCNv03GFuXXQUz/jW+/y62xK1SksS5UT6uFT+/Xh0ZI
	 6MZyFKrWre7eg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4J9jbZ2Wtwz1sk1
 for <lttng-dev@lists.lttng.org>; Fri, 10 Dec 2021 15:45:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1B4683927DA
 for <lttng-dev@lists.lttng.org>; Fri, 10 Dec 2021 15:45:40 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id agyuk7p1VXmw; Fri, 10 Dec 2021 15:45:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2609F3928D0;
 Fri, 10 Dec 2021 15:45:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2609F3928D0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lPglTssnjNj3; Fri, 10 Dec 2021 15:45:39 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 18C10392B27;
 Fri, 10 Dec 2021 15:45:39 -0500 (EST)
Date: Fri, 10 Dec 2021 15:45:38 -0500 (EST)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <1697490258.28441.1639169138969.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Index: A/kqqja9BDVf/kUNVOsd4rXMEufssA==
Thread-Topic: LTTng-UST 2.13.1 (Linux user-space tracer)
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.13.1 (Linux user-space tracer)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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

This 2.13.1 release of LTTng-UST is a bugfix-only release for various
shortcomings that were identified in the 2.13.0 release.

A few key highlights: the C++ support for building probe providers has
been improved, async-signal-safety of the close wrapper has been fixed,
pthread cancelstate in nested use scenarios is now properly handled.

2021-12-10 (Lost and Found Day) lttng-ust 2.13.1
        * Fix: ust-compiler: constructor/destructor build on g++ 4.8
        * ust-compiler: constructor/destructor whitespaces layout and macro dependency
        * Fix: ust-cancelstate: include string.h for strerror
        * Fix: libnuma is prepended to LIBS
        * fix: Allow disabling some abi compat tests
        * Fix: generate probe registration constructor as a C++ constuctor
        * Fix: nestable pthread cancelstate
        * Fix: abort on decrement_sem_count during concurrent tracing start and teardown
        * fix: allocating C++ compound literal on heap with Clang
        * Check for C++11 when building C++ probe providers
        * fix: liblttng-ust-fd async-signal-safe close()
        * tracepoints: print debug message when lttng-ust-tracepoint.so is not found
        * Fix: static_assert unavailable with glibc < 2.16
        * Fix: combined tracing of lttng-ust 2.12/2.13 generates corrupted traces
        * doc/man: Document LTTNG_UST_ABORT_ON_CRITICAL variable
        * fix: remove autoconf features default value in help message
        * Set git-review branch to stable-2.13
        * Fix: add extern "C" to two header files

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
