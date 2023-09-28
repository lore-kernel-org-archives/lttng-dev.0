Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E603E732FD
	for <lttng-dev@archiver.kernel.org>; Thu, 28 Sep 2023 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1695920977;
	bh=YSmahmu4BJhFmZxkX9eDIg1g1qrDbRItrsGc/xUPqgg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=CJDZDD76ZBxdzt8p1JyZIh/QYU6nHKLjzlG45s9tSg6XPrVygupkRHZr0f32EccKW
	 PfBP3ydWBeR7etbZ9rKW8hNkitYt9qtURbD8Qs+rPoKIdx21z67X03sBxWeHPx+AAy
	 W3fOq1a+ZfidFbMYKMrl2LoB7EmAi1yL2NnG+JlBMxnMJoaG7v0S7EbthUeatK/Cks
	 f6A1My5mijNj0X6Vn5L6brJfgfUJI1I/ALv8cABSz+Tc5Ikqg4pl6NlCX15UKMWG6q
	 W6xGEblr0TsD6R8A0JjPtXYCjeuxjdb3VEwVydAczIAXcwbvMXZEU+aagztBWttKAa
	 YuDZcPinN6uwg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RxKhx1k5wz2dCp;
	Thu, 28 Sep 2023 13:09:36 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RxKhr3zFpz2dCl
 for <lttng-dev@lists.lttng.org>; Thu, 28 Sep 2023 13:09:32 -0400 (EDT)
Received: from localhost (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RxKhq400Fz1RR3
 for <lttng-dev@lists.lttng.org>; Thu, 28 Sep 2023 13:09:31 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Organization: EfficiOS
Date: Thu, 28 Sep 2023 13:09:31 -0400
Message-ID: <87il7uxm0k.fsf@laura>
MIME-Version: 1.0
Subject: [lttng-dev] RCU - Bugs in atomic operations for RISC-V with GCC
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We recently have been informed that the implementation of atomic
operations in GCC for RISC-V have bugs in them [1].  However, the fixing
patches missed the 13.2 release and it does not seem that they have been
back-ported to other versions yet.

For this reasons, we concur that it was best to mark Userspace RCU as
broken for RISC-V when compiling with GCC.  However, it is still
possible to compile Userspace RCU for RISC-V with other toolchains such
as Clang.

Cheers,
Olivier

[1] https://review.lttng.org/c/userspace-rcu/+/10942

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
