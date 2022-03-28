Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF7C433F5
	for <lttng-dev@archiver.kernel.org>; Mon, 28 Mar 2022 18:40:58 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KS1jj3D5ZzL3M;
	Mon, 28 Mar 2022 14:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648492858;
	bh=lHY+boY1iXYjpFlfAxR7+iDaBim4KIZTOAw5uLr8VlE=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=jlZ86s/FqqR05arcjlb4BWQAnnvN4wmtybymwmYFYMN651V+u3RXKFIUHX/18rRb+
	 ngUSHNyy+Be8eU7m697Yewp0yLY8LEcyFWCqXmIhH4NDnrY4giwG/kPtMZw6TK56vS
	 e2MNX+L+t8aGjjlX458jjsYQmldN4S9Syu5ENmQvYwxjCv+/KCj+TVOCgbjfTnS+R1
	 Gy8q3kPZkBhY0Pwt2opPbrxul+dCPR+zooa+P7MFECWg2Wm9cacEq7cX5q3i4xtfvs
	 5Nkx6jR6IAMeLmzpQZBflV7hxwqabZV5TR1Vj5YgKylkRtCGgXhSe/5q3aebQkYl4r
	 sYL7n0epcxOFg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KS1jh2DhmzKsk
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 14:40:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 05C1F3FB1EB
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 14:40:50 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gwDKu693KqJH; Mon, 28 Mar 2022 14:40:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7BFAD3FB519;
 Mon, 28 Mar 2022 14:40:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7BFAD3FB519
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 7e9PqeqEKrBD; Mon, 28 Mar 2022 14:40:49 -0400 (EDT)
Received: from carbonara (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id 5E9683FB063;
 Mon, 28 Mar 2022 14:40:49 -0400 (EDT)
Date: Mon, 28 Mar 2022 14:40:49 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <YkIBMfCWRUTdQn3D@carbonara>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.9 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the ninth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2022-03-28 lttng-tools 2.12.9 (National Hot Tub Day)
	* Fix: lttng-elf: wrong error label used by error path
	* Fix: use the correct endian compat macros
	* Fix: lttng-elf: untrusted entry size divisor
	* Fix: event: erroneous bound check on perf counter name size
	* Fix: relayd: missing session unlock on error path
	* fix: warning '-Wstringop-truncation' with GCC 11.2
	* Add Log4j 2.x agent tests for the 'log4j' domain
	* Fix: relayd: session id is ignored by 2.11+ create session command
	* Fix: consumerd: use-after-free of metadata bucket
	* Fix: ust-consumerd: leak of stream control structure
	* Fix: liblttng-ctl: erroneous flat size computation
	* Build fix: relayd: mismatching function signatures
	* Build fix: use of mutable keyword in C file
	* Fix: relayd: connection abruptly closed on viewer stream creation failure
	* Fix: relayd: live client fails on clear of multi-domain session
	* Tests: fix: select_poll_epoll: test assumes epoll fd value
	* Fix: rotation: hang on destroy when using scheduled rotation based on timer
	* Fix: consumerd: fd still open after `lttng snapshot record` returns
	* Fix: event: unchecked return value for lttng_strncpy
	* Fix: event: format specifier for ssize_t
	* Fix: sessiond: lttng_channel object is not reclaimed
	* Fix: common: local_attr might leak
	* Fix: session: end goto label used for error path
	* Fix: ser/des: missing null terminator on payload append
	* Fix: test: test plan/skip must come after TAP initialization
	* Fix: test: missing test plan for non-x86/arm platforms (i.e powerpc)
	* Fix: liblttng-ctl comm: lttng_event_field is not packed
	* Fix: liblttng-ctl comm: lttng_event_context is not packed
	* Fix: liblttng-ctl comm: lttng_event is not packed
	* libcommon: move event.c to libcommon-lgpl
	* Fix: liblttng-ctl comm: lttng_channel is not packed
	* Fix: lttng-ctl: erroneous uses of LTTNG_PACKED
	* Backport: lttng_buffer_view_is_valid, lttng_buffer_view_contains_string
	* Fix: conversion from KB to bytes overflow on arm32
	* Fix: Unexpected payload size in cmd_recv_stream_2_11
	* Tests: add kernel test into the `make check` test suite.

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.9.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.9.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
