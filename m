Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6254EC001DB
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Aug 2023 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1691421250;
	bh=urW+q2bWFsVSYW2mkjwn10qHhBEKDaNTFQbco9Gak8o=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=D+j5mP/8fUetRY0GC2v7a9kTV6CVupph+RSmgY4X2kcrDe/EklUZRKPO79YJf4k5N
	 C5zg735I4TWgfaZH/ePso6Lb7qwKyh/34/9wjJBXspN9wIlqd9799JHNukb4juYATw
	 Oy0TPpD9gHMryy25Cy7vYemXWuzn5/fIo8zKhhj9xNX59bfLSuKJ4ydAhudOIJCGn8
	 qySiZc0C7pgod+KddEsGCstT72Qz9fe3osiCsUMz7aH9ItanaZNOT8Oe038HiWA38r
	 y54zFO1N223M3c3/Z8PwQBlM45fZcoLk7vkomP4zorLbKgcnlxBEZvExd4VH4xWVom
	 hoI2InNdJm4xw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RKKbj2DS6z2JtD;
	Mon,  7 Aug 2023 11:14:09 -0400 (EDT)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by lists.lttng.org (Postfix) with ESMTPS id 4RJ9w205r0z2Hyh
 for <lttng-dev@lists.lttng.org>; Sat,  5 Aug 2023 14:24:17 -0400 (EDT)
Date: Sat, 05 Aug 2023 18:24:10 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Message-ID: <tFicevizpfz9CtNCCV6nl0_0SGJOSKJwbWV2s4XvDMWHogGJvJe4yrgcIndnifk0doSMNuVlONo0S5z_yrIWmh8TjxX2hs_RykJRZcOCIKQ=@strager.net>
Feedback-ID: 62574427:user:proton
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 07 Aug 2023 11:14:08 -0400
Subject: [lttng-dev] [barectf] why YAML instead of CTF?
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
From: strager via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: strager <s@strager.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

I have a CTF metadata file (schema) and hand-written parsers and writers for streams with that schema. I am interested in writing a tool which generates the parsers and writers (instead of hand-writing them).

It looks like barectf is similar to the tool I want to build. However, barectf reads a custom file format for the schema instead of reading a CTF metadata file.

Question: Why does barectf read a custom YAML format instead of reading CTF metadata? My plan was for my tool to read the schema from a CTF metadata file. Are there technical reasons why it's bad to make a code generator with CTF metadata as input? Because babeltrace2 can read CTF metadata files, I thought CTF metadata was machine-readable.

Thanks,
strager

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
