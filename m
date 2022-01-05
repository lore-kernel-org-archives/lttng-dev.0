Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33699C433EF
	for <lttng-dev@archiver.kernel.org>; Wed,  5 Jan 2022 20:39:48 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JThDg1K04zB4y;
	Wed,  5 Jan 2022 15:39:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1641415187;
	bh=sm/WUa3zoooH1CrBn6G1VLK86DN4ko6pm9Rm6rXZqAQ=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=orumK+aRxiY1VRB2gS9V9/FBL8LBZYKHLjk8uhxwpGnJnjjUNZ3c2AhbzSIYucKxm
	 ObeBrsJOz7H0W2wPIfK3a9ROaNO1x+XrBkYw/PC2kxHY1FbC/DBfMA2ks4MrXIijZv
	 vur3hUvzfsiY+sT2XVOvdnPUAsoHUlwABZkGd/fdstang/8JO0BjDKMDYN+MRpzki/
	 tfbiLNly+73ST6GvBtDJzPIij7Yu9A6MEMHCATwwz02Ond/m7dm4OhTayNIZ2BqFkZ
	 ymM0rJV7c5oeQIPygm14nLFGHs1uhpC+kPljvmmJHyJP6LDUAoQ2XlpX3xzmieWMxS
	 8OkHnQpetqsew==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JThDd0txbz9vw
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 15:39:44 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8686B3C980A
 for <lttng-dev@lists.lttng.org>; Wed,  5 Jan 2022 15:39:38 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id FbqI1sBWzjtz; Wed,  5 Jan 2022 15:39:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CFFA13C95C0;
 Wed,  5 Jan 2022 15:39:37 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CFFA13C95C0
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Mt3U6jItNVuz; Wed,  5 Jan 2022 15:39:37 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id BFE7F3C9374;
 Wed,  5 Jan 2022 15:39:37 -0500 (EST)
Date: Wed, 5 Jan 2022 15:39:37 -0500 (EST)
To: linux-kernel <linux-kernel@vger.kernel.org>, 
 lttng-dev <lttng-dev@lists.lttng.org>, rp <rp@svcs.cs.pdx.edu>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1604976069.5148.1641415177661.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF95 (Linux)/8.8.15_GA_4177)
Thread-Index: hFOmTmvfinaOxKagaO3L6KLVzo7LIA==
Thread-Topic: Userspace RCU 0.11.4, 0.12.3 and 0.13.1
Subject: [lttng-dev] [RELEASE] Userspace RCU 0.11.4, 0.12.3 and 0.13.1
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

Hi,

This is a release announcement for the currently maintained stable
branches of the Userspace RCU library. Please note that 0.11.4 is
the last release of the 0.11 stable branch, which is reaching end
of life. Users facing issues with the 0.11 stable branch are expected
to upgrade to 0.12.3 or 0.13.1.

The content of those bug fix releases is fairly straightforward,
and the change log small enough to be shown in this release
announcement (see below).

Feedback is as always welcome!

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

Changelog:

2022-01-05 Userspace RCU 0.13.1
        * fix: properly detect 'cmpxchg' on x86-32
        * fix: use urcu-tls compat with c++ compiler
        * fix: remove autoconf features default value in help message
        * fix: add missing pkgconfig file for memb flavour lib
        * Make temporary variable in _rcu_dereference non-const
        * Fix: x86 and s390: uatomic __hp() macro C++ support
        * Fix: x86 and s390: uatomic __hp() macro clang support
        * Fix: x86 and s390 uatomic: __hp() macro warning with gcc 11
        * Fix: changelog: v0.13.0 was released in 2021

2022-01-05 Userspace RCU 0.12.3
        * fix: use urcu-tls compat with c++ compiler
        * fix: add missing pkgconfig file for memb flavour lib
        * Make temporary variable in _rcu_dereference non-const
        * Fix: x86 and s390: uatomic __hp() macro C++ support
        * Fix: x86 and s390: uatomic __hp() macro clang support
        * Fix: x86 and s390 uatomic: __hp() macro warning with gcc 11
        * Document known ABI issue in README.md
        * fix: clock_gettime on macOs
        * Fix: rculist header: use parenthesis around macro parameters
        * Fix: rcuhlist header: use parenthesis around macro parameters
        * Fix: hlist header: use parenthesis around macro parameters
        * Fix: list.h: use parenthesis around macro parameters, caa_container_of()
        * Fix: hlist iteration relies on undefined behavior
        * Fix: use __atomic_load() rather than atomic load explicit
        * Fix: use atomic load memory_order_consume for rcu_dereference on C11/C++11
        * fix: warnings on non-Linux platforms
        * fix: HAVE_SCHED_SETAFFINITY is not defined
        * Add git review config to stable branch
        * fix: include 'sys/endian.h' on FreeBSD
        * cleanup: explicitly mark unused parameters (-Wunused-parameter)
        * fix: shadowed local variable (-Wshadow)
        * cleanup: all functions have declarations (-Wmissing-prototypes)
        * Import libtap from babeltrace

2022-01-05 Userspace RCU 0.11.4
        * fix: add missing pkgconfig file for memb flavour lib
        * Make temporary variable in _rcu_dereference non-const
        * Fix: x86 and s390: uatomic __hp() macro C++ support
        * Fix: x86 and s390: uatomic __hp() macro clang support
        * Fix: x86 and s390 uatomic: __hp() macro warning with gcc 11
        * Document known ABI issue in README.md
        * fix: clock_gettime on macOs
        * Fix: rculist header: use parenthesis around macro parameters
        * Fix: rcuhlist header: use parenthesis around macro parameters
        * Fix: hlist header: use parenthesis around macro parameters
        * Fix: list.h: use parenthesis around macro parameters, caa_container_of()
        * Fix: hlist iteration relies on undefined behavior
        * Fix: use __atomic_load() rather than atomic load explicit
        * Fix: use atomic load memory_order_consume for rcu_dereference on C11/C++11
        * Fix: gitreview defaultbranch should be stable-0.11
        * fix: warnings on non-Linux platforms
        * fix: HAVE_SCHED_SETAFFINITY is not defined
        * Add git review config to stable branch
        * fix: include 'sys/endian.h' on FreeBSD
        * cleanup: explicitly mark unused parameters (-Wunused-parameter)
        * fix: shadowed local variable (-Wshadow)
        * cleanup: all functions have declarations (-Wmissing-prototypes)
        * Import libtap from babeltrace

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
