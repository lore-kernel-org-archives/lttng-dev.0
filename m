Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F53DC7EE2F
	for <lttng-dev@archiver.kernel.org>; Fri,  3 Mar 2023 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1677872351;
	bh=MaW+gkThBzEdFF7ACQWAYQa0h3VrlZusVRAK0JYWjyY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=JfOhTK2EszkUDAWrV0YkDQwXYPkSKsoSyssG9ZTBCi1o0s8s55FlQ3gds1PEhRNQW
	 sj+oqwFgAfVNJlHyJpGWjqBrTQxAuw0b5BPvQuRdJSjGwg4SfPnvejfbknPuMnuEWJ
	 ClZmLGhlnaQDF63alxRXo71RVCvsaBJTK7ibql9r9LqK1HCFQv0rp25Ii6ZOCAFz3i
	 Y/8zvTju3UQAvWID9C6Tz4eO92Kje/3skRBSdW1s1flA52QlLMlifbkCfw02xGXpYO
	 80Bh6I8NbFN69D31WUCHJQAicHs4BecQ2Y34+tDmOHRJ7/dFIoiav/qtUpxB6kD+Jy
	 bXfKvev7G9eeA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PSyvy453lz26CC;
	Fri,  3 Mar 2023 14:39:10 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4PSyvw1g90z25pm
 for <lttng-dev@lists.lttng.org>; Fri,  3 Mar 2023 14:39:07 -0500 (EST)
Received: from [172.16.0.91] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4PSyvC1wLgzp78;
 Fri,  3 Mar 2023 14:38:31 -0500 (EST)
Message-ID: <65d25dd8-7e4d-7f33-67de-1e4276a10d88@efficios.com>
Date: Fri, 3 Mar 2023 14:38:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.12.13 and 2.13.9 (Linux
 kernel tracer)
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

This is a release announcement for the two currently maintained stable 
branches of the LTTng-modules project.

* New in these releases

LTTng-modules v2.13.9 contains a fix required to build against Linux v6.2.

Both v2.12.13 and v2.13.9 contain a set of build fixes to follow 
evolution of the jbd2 tracepoint instrumentation within the Linux kernel 
5.4 and 5.10 stable branches.

* Changelog

2023-03-03 (Canadian Bacon Day) LTTng modules 2.13.9
         * fix: jbd2: use the correct print format (v5.4.229)
         * fix: jbd2 upper bound for v5.10.163
         * fix: jbd2: use the correct print format (v5.10.163)
         * fix: btrfs: move accessor helpers into accessors.h (v6.2)

2023-03-03 (Canadian Bacon Day) 2.12.13
         * fix: jbd2: use the correct print format (v5.4.229)
         * fix: jbd2 upper bound for v5.10.163
         * fix: jbd2: use the correct print format (v5.10.163)

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
