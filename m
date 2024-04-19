Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5E6C4345F
	for <lttng-dev@archiver.kernel.org>; Fri, 19 Apr 2024 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1713551121;
	bh=DVFaBgdlg1uRnVN3THWrZIyW4WLo+CblhTsHKuCe3jo=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ar3LiHpNO5p2MxucYi8UgR5vNf0BDySJrbzTrP+nYY+znKRr6u9ReV6GmCQlnz7vm
	 Nbwke1AkjFCxt0KzXysDszpFbYTBd6LLCTtPPgykZEDDl6UNQ8cKHCGklYryBZGhuf
	 FQGS5CYZrvl+EgSYKdfBJq3k57pLaOK3M/1ZuKQ/QswXC+5/9qvBA53ifhvVgxc3rO
	 uz+lAixoxC9jNJMBfovIdAeSdQ2XipyFOTT0nTzDYo4SfGzH2IZmPdnArQiHk0Ndl1
	 XxzobquX1qLG5sGEHov1772HEwokzXkKVLuDyqg8D6MZiJv0IzMLy4REsTAfRMEOSR
	 K0S6lPpXcJTiA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VLjk91qytz2j1F;
	Fri, 19 Apr 2024 14:25:21 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4VLjk74HbHz2hbS
 for <lttng-dev@lists.lttng.org>; Fri, 19 Apr 2024 14:25:19 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4VLjk70MsCzwgk;
 Fri, 19 Apr 2024 14:25:19 -0400 (EDT)
Message-ID: <8987e081-13bb-4af2-80d7-5819ad5d4784@efficios.com>
Date: Fri, 19 Apr 2024 14:25:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [lttng-dev] [RELEASE] LTTng-UST 2.12.10 and 2.13.8 (Linux
 user-space tracer)
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

New in both 2.12.10 and 2.13.8:

* Add close_range wrapper to liblttng-ust-fd.so

GNU libc 2.34 implements a new close_range symbol which is used
by the ssh client and other applications to close all file descriptors,
including those which do not belong to the application. Override
this symbol to prevent the application from closing file descriptors
actively used by lttng-ust.

* Fix: libc wrapper: use initial-exec for malloc_nesting TLS

Use the initial-exec TLS model for the malloc_nesting nesting guard
variable to ensure that the GNU libc implementation of the TLS access
don't trigger infinite recursion by calling the memory allocator wrapper
functions, which can happen with global-dynamic.

This fixes a liblttng-ust-libc-wrapper.so regression on recent
Fedora distributions.

* lttng-ust(3): Fix wrong len_type for sequence

`len_type' of a sequence field must be of type unsigned integer. Some
provided examples in the man page were incorrectly using a type signed
integer, resulting in correct compilation, but error while decoding.

New in 2.13.8:

* ust-tracepoint-event: Add static check of sequences length type

Add a compile-time check to validate that unsigned types are used
for the length field of sequences.

Detailed change logs:

2024-04-19 (National Garlic Day) lttng-ust 2.13.8
         * Add close_range wrapper to liblttng-ust-fd.so
         * ust-tracepoint-event: Add static check of sequences length type
         * lttng-ust(3): Fix wrong len_type for sequence
         * Fix: libc wrapper: use initial-exec for malloc_nesting TLS

2024-04-19 (National Garlic Day) lttng-ust 2.12.10
         * Add close_range wrapper to liblttng-ust-fd.so
         * lttng-ust(3): Fix wrong len_type for sequence
         * Fix: libc wrapper: use initial-exec for malloc_nesting TL


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
