Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB66DC4707B
	for <lttng-dev@archiver.kernel.org>; Wed, 10 Jan 2024 20:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1704918573;
	bh=u1arDYqfK1XgAHJUVoXW2jTByFQ9f4dlUw0dCaEOb/I=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=jHmyiUbLQr8Chv7rp9XDpP+TpeAY7ADwFZbbKsJercTURNjRRwCp1MtaeT0Umk0mT
	 YsClOP4ZhJa7BTPHtUCd0o1aEUOFbx4A5XfQMUZCTalqJi4AZJoCtdotzmFQwAeM1x
	 u5OXR+noVKMcMyzP0EIfOxIH72uVPJ/HwXm6QLd6bWP1FrKDWNIWxqsnk0cVGlJa34
	 HSpO2o3wmddKy4Lz/SUvIyujB/MF3GlWBtfTtGl3kqRc+PPLk/Gq8GVO/HhxMJ1DG7
	 RFLAomgBfuMnH2kJFrKA6AOjaWIFE5/7E0dCru0PRFTxX8GHCMGXUn1a8+odmOTNel
	 gqXqtkQYQ7OgA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4T9KCc6GP7z1JNV;
	Wed, 10 Jan 2024 15:29:32 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4T9KCY5pWbz1JNS
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jan 2024 15:29:29 -0500 (EST)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4T9KCW6Cj9zKL0;
 Wed, 10 Jan 2024 15:29:27 -0500 (EST)
Message-ID: <26640415-9822-45d3-a713-060726de2166@efficios.com>
Date: Wed, 10 Jan 2024 15:29:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.12.9 and 2.13.7 (Linux user-space
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer,
is a low-overhead application tracer. The library "liblttng-ust" enables
tracing of applications and libraries.

* New and noteworthy in these releases:

Specific to 2.13.7, a fix for misaligned urcu reader accesses was
introduced. It only applies to the lttng-ust 2.13 branch because
it implements its own "lttng-ust-urcu" flavor.

Also specific to 2.13.7, "sync" vs "unsync" enablers are introduced
to eliminate an O(n*m) algorithm:

     Eliminate iteration over unmodified enablers when synchronizing the
     enablers vs event state.

     The intent is to turn a O(m*n) algorithm (m = number of enablers, n =
     number of event probes) into a O(n) when enabling many additional events
     when tracing is active.

Specifically in 2.12.9, the rfork() wrapper is fixed: it was not
passing the flags arguments. This was fixed in a larger commit
in the master and stable-2.13 branches.

Both stable branches include:

- a build system fix for documentation examples with old autoconf when
   used with a relative path.

- a clang warning fix around volatile qualifier on function pointers.

- Python agent uplift to adapt to modern python (>= 3.10),

- a possible race condition in the ustfork helper.

Enjoy!

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Detailed change logs:

2024-01-10 (National Houseplant Appreciation Day) lttng-ust 2.13.7
         * fix: invoke MKDIR_P before changing directories
         * fix: -Wsingle-bit-bitfield-constant-conversion with clang16
         * fix: clean java inner class files in examples
         * Introduce sync vs unsync enablers
         * Fix: misaligned urcu reader accesses
         * ustfork: Fix warning about volatile qualifier
         * ustfork: Fix possible race conditions
         * Fix: tracepoint: Remove trailing \ at the end of macro
         * fix: python agent: use stdlib distutils when setuptools is installed
         * fix: python agent: install on Debian python >= 3.10
         * fix: python agent: Add a dependency on generated files
         * python: use setuptools with python >= 3.12

2024-01-10 (National Houseplant Appreciation Day) lttng-ust 2.12.9
         * fix: invoke MKDIR_P before changing directories
         * fix: clean java inner class files in examples
         * ustfork: Fix warning about volatile qualifier
         * ustfork: Fix possible race conditions
         * Fix: FreeBSD: Pass flags arguments to rfork wrapper
         * fix: python agent: use stdlib distutils when setuptools is installed
         * fix: python agent: install on Debian python >= 3.10
         * fix: python agent: Add a dependency on generated files
         * python: use setuptools with python >= 3.12


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
