Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F67C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 28 Mar 2022 18:38:51 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KS1gF44RbzKbS;
	Mon, 28 Mar 2022 14:38:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1648492730;
	bh=52ZTFLWe9bf+RpzM2/0hQyXIuXtZcGSDgO1KHyg4qR4=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=R0IMgfGAyVa59zb9n1knQBoZWHo+wUJQOdXNXwxX2eslsxeDugdofxTELvrBl4Mir
	 9ONdu8MHAHi1smzS6GgHBeGiWAi60E6KtXOThgBANEUv2uwEoR15lMXNSZFsdMD7oU
	 6MilAC+7zNnAH5DHbkz69opV1tMR6UTVosJgQrR5LQUkyGNeN6S2vO+k4XGNhBVb3L
	 2o8sTPRceX9iScAvFEauPkE6TG8wZ1pGjDGnH0NAx4QoZU2fNSEGeenON6udaNB6vC
	 SAoWGhBl4yg4kLzRT5cy9ISWInUB4y0vdaWpFpZ7ggN/cZx0cmrJIyM5aPVRT43KRd
	 QaysUcAdO88Eg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KS1gC6jjNzKsf
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 14:38:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2AAE83FB1E4
 for <lttng-dev@lists.lttng.org>; Mon, 28 Mar 2022 14:38:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id j3teuTtbCbZD; Mon, 28 Mar 2022 14:38:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 853B13FB33C;
 Mon, 28 Mar 2022 14:38:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 853B13FB33C
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4MHL4H4TQyuq; Mon, 28 Mar 2022 14:38:40 -0400 (EDT)
Received: from carbonara (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
 by mail.efficios.com (Postfix) with ESMTPSA id 5C1D83FB423;
 Mon, 28 Mar 2022 14:38:40 -0400 (EDT)
Date: Mon, 28 Mar 2022 14:38:40 -0400
To: lttng-dev@lists.lttng.org
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>,
 diamon-discuss <diamon-discuss@lists.linuxfoundation.org>
Message-ID: <YkIAsNVc2xq0hxZM@carbonara>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E5_?=
 =?iso-8859-1?q?-_Nordicit=E9?=
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the fifth bug-fix release of LTTng-tools 2.13 - Nordi=
cit=E9.
This release addresses a number of issues listed below.

2022-03-28 lttng-tools 2.13.5 (National Hot Tub Day)
	* Fix: doc: action: wrong function documented for action_list destroy
	* Fix: lttng-elf: wrong error label used by error path
	* Fix: use the correct endian compat macros
	* Fix: tests: uninitialized lttng_payload
	* Fix: sessiond: ust-app: uninitialized name logged on stream copy failure
	* Fix: lttng-elf: untrusted entry size divisor
	* Fix: event: erroneous bound check on perf counter name size
	* Fix: sessiond: event name length check is too strict
	* Fix: relayd: missing session unlock on error path
	* fix: warning '-Wstringop-truncation' with GCC 11.2
	* Add Log4j 2.x agent tests for the 'log4j' domain
	* Fix: relayd: session id is ignored by 2.11+ create session command
	* Build fix: consumer: aggregate initialization isn't supported
	* Fix: consumerd: use-after-free of metadata bucket
	* Fix: ust-consumerd: leak of stream control structure
	* Fix: liblttng-ctl: erroneous flat size computation
	* Fix: test: babeltrace1 python bindings exposes `op_enum` as a string
	* Build fix: relayd: mismatching function signatures
	* Build fix: use of mutable keyword in C file
	* Fix: relayd: connection abruptly closed on viewer stream creation failure
	* Fix: relayd: live client fails on clear of multi-domain session
	* fix: msgpack requires limits.h for UINT_MAX
	* Fix: liblttng-ctl: hide symbols introduced by packing fixes
	* Fix: rotation: hang on destroy when using scheduled rotation based on ti=
mer
	* Fix: consumerd: fd still open after `lttng snapshot record` returns
	* Fix: event: unchecked return value for lttng_strncpy
	* Fix: event: format specifier for ssize_t
	* Fix: sessiond: use after free
	* Fix: sessiond: `break` used instead of `goto`
	* Fix: sessiond: lttng_channel object is not reclaimed
	* Fix: common: local_attr might leak
	* Fix: session: end goto label used for error path
	* Fix: sessiond: event, filter expression, bytecode, exclusions might leak
	* Fix: lttng-sessiond: event_context might leak
	* Fix: lttng-ctl: uninitialized pointer read
	* Fix: ser/des: missing null terminator on payload append
	* Fix: test: test plan/skip must come after TAP initialization
	* Fix: test: missing test plan for non-x86/arm platforms (i.e powerpc)
	* Fix: remove debugging output
	* Fix: tests: test_kernel: break should only be used in loops
	* Fix: tools/snapshots/test_kernel flaky test
	* Tests: Fix: test_list_triggers_cli: support in-kernel builtin lttng-modu=
les
	* Fix: lttng: truncated addresses and offsets on 32-bit builds
	* Fix: liblttng-ctl comm: lttng_event_field is not packed
	* Fix: liblttng-ctl comm: lttng_event_context is not packed
	* Fix: liblttng-ctl comm: lttng_event is not packed
	* libcommon: move event.c to libcommon-lgpl
	* Fix: liblttng-ctl comm: lttng_channel is not packed
	* Fix: conversion from KB to bytes overflow on arm32
	* Fix: Unexpected payload size in cmd_recv_stream_2_11
	* Fix: liblttng-ctl: missing index allocator symbols
	* Fix: lttng-sessiond: null pointer used to log session name
	* Tests: add kernel test into the `make check` test suite.
	* Build dist fix: some kernel tests are not distributed
	* Tests: fix: test_kernel_function: erroneous test count
	* Tests: fix: test_kernel_function: event name mismatch
	* Tests: fix: select_poll_epoll: test assumes epoll fd value
	* Fix: missing RCU read side critical sections

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.5.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.5.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
