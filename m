Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833E2CD11DD
	for <lttng-dev@archiver.kernel.org>; Fri, 29 Mar 2024 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711721184;
	bh=nvp9eWXj+I+yQmSO7MJ/jFKkvaxvmSQGGEGYkWsTORY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=oiUViGcGVIk5tAeVIBnBBjsc+Gmer30V2KZ4G4AVWg6NlCtnkIWlfwUdA2PEz+KUW
	 qxYW/ctw82CF6mCMaucSm2l+qaODDKGakG8pRPhFq2bLzPmBhNUdbRrwgIQ1dmafFu
	 A5jkvvKx67QNdW807JYOdHFOfCI32MT1t8N/0KowjEBDcpS5GgUsmt+45Z6yw2eS2g
	 zyN6RLM6Ftnt512n1w3tAn9Bd16P9GdGHCmuOBD2gjKfHYPTU/GCchwN48kV/ocMaT
	 mcrB8qtU3fpw/8djdCaotIWpNeiA/vFV+CcgLYwo+xhWmNBM/u5kJG2vs3pIayEC6R
	 4GApNCs9c68Qg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V5hz33Svjz2YBc;
	Fri, 29 Mar 2024 10:06:23 -0400 (EDT)
Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
 by lists.lttng.org (Postfix) with ESMTP id 4V5hz05WpNz2XqT
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2024 10:06:20 -0400 (EDT)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by smtpfb1-g21.free.fr (Postfix) with ESMTP id E232683400A
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2024 15:06:17 +0100 (CET)
Received: from [IPV6:2a01:e0a:255:1000:d488:d48:eaf6:3074] (unknown
 [IPv6:2a01:e0a:255:1000:d488:d48:eaf6:3074])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 616D1200590
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2024 15:06:05 +0100 (CET)
Message-ID: <c0fa14f8-2771-4597-9232-0438a67badca@free.fr>
Date: Fri, 29 Mar 2024 15:06:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Compile fix for urcu-bp.c
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
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--- src/urcu-bp.c
+++ src/urcu-bp.c
@@ -409,7 +409,7 @@ void expand_arena(struct registry_arena *arena)
  		new_chunk_size_bytes, 0);
  	if (new_chunk != MAP_FAILED) {
  		/* Should not have moved. */
-		assert(new_chunk == last_chunk);
+		urcu_posix_assert(new_chunk == last_chunk);
  		memset((char *) last_chunk + old_chunk_size_bytes, 0,
  			new_chunk_size_bytes - old_chunk_size_bytes);
  		last_chunk->capacity = new_capacity;
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
