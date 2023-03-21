Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F554C6FD1D
	for <lttng-dev@archiver.kernel.org>; Tue, 21 Mar 2023 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679405488;
	bh=guSEmzne4QGjePsMFGQ5/GtN7KBT6ywteWTySGSM95I=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0pa1ML8Pa3BbgiuPOmZzxfHNX4nZLWe9raJYTt/JP9z7nOhz65Pwld/iNDuCSFlX8
	 GDxwey+LgLk7sjTNaKLI9S4NzLGPmuKR2zW6qO1LVHTApw8yIjjS4M9Y5UjxUzNHL8
	 J05c+Z0PUuPjJnxAPuWQ4qxwnLvPnpjMHNs5G783etEByNda/YkV5lezo40gKAzXEf
	 XgRd8PBq7tg8v0iivCo1P2ubL9LQhIEqKWSUZ0OUgUDzrPqSz17j7oHW9a2zTlogJR
	 gty2kI9YHBoWmiGQLJpfoUHniI8DKhZ0yrR+nPUbqy/VWZ0Dtk9dRVaxUrpni6fkQk
	 A8AfDi74ggIbw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PgsvM2ms2z2HCf;
	Tue, 21 Mar 2023 09:31:27 -0400 (EDT)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by lists.lttng.org (Postfix) with ESMTPS id 4PgsvK5yxMz2H1y
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 09:31:25 -0400 (EDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 9B65B320070D
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 09:31:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 21 Mar 2023 09:31:18 -0400
X-ME-Sender: <xms:pbEZZMPcGAl7u9n6VRM7kWvalfJ26dPKhMF7k5DtHLwZhaPAOgYCTQ>
 <xme:pbEZZC9Npxu8cgXNX4ED2SyxloJcS2HzZvWeWELtOy1DgmC65stNo_ln_0Hp05PQn
 gNo3gO0ofYM9aP6_vY>
X-ME-Received: <xmr:pbEZZDRvSPZRoIGuMYECoBEMyz0qJZYywjiF6KT3cWeJMT9wEnKge0vemM_F4vvaljALzjYj96U0C_fDprpncgO03rtfonFFMS5i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegtddghedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdenuc
 fjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefqnhgurhgvjhcu
 ufhurhpuuceoohhnughrvghjsehsuhhrhidrohhrgheqnecuggftrfgrthhtvghrnhepie
 evieeujeevleffgfekhfekheekveeileduvdevhfelgeegueejvdetkeelfeevnecuvehl
 uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhnughrvghjse
 hsuhhrhidrohhrgh
X-ME-Proxy: <xmx:pbEZZEt9k9Gd20GaUp5ZHtHkqiI1-gCf161gMKw-iBBrYGmB8Phj0A>
 <xmx:pbEZZEd_xYWRI-nxnQq1SzSpJ_ub6535hd3ISgXN5FyY4iAwb5LBZg>
 <xmx:pbEZZI2Xy83BsEq0ywy8YsP88ON9fN9GorPxli0Eec-QnnldinqByA>
 <xmx:prEZZOpWEEJjDHntISrLMlT3JSdVEZVK06lVHa-DMljxB9UIqhkwzw>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 09:31:17 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 21 Mar 2023 14:30:55 +0100
Message-Id: <20230321133102.1054238-1-ondrej@sury.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Subject: [lttng-dev] (no subject)
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
From: =?utf-8?q?Ond=C5=99ej_Sur=C3=BD_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?q?Ond=C5=99ej=20Sur=C3=BD?= <ondrej@sury.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a second round of the patches after implementing the requested changes
from the first round.

Ondrej

[PATCH 1/7] Require __atomic builtins to build
- no changes

[PATCH 2/7] Use gcc __atomic builtis for <urcu/uatomic.h>
- the non return macros are now __ATOMIC_RELAXED
- the return macros are now __ATOMIC_SEQ_CST
- the memory barriers are now

[PATCH 3/7] Use __atomic_signal_fence() for cmm_barrier()
- this now uses __atomic_signal_fence() instead of __atomic_thread_fence()

[PATCH 4/7] Replace the internal pointer manipulation with __atomic
- changed the memory ordering to __ATOMIC_SEQ_CST for xchg and cmpxchg 

[PATCH 5/7] Replace the arch-specific memory barriers with __atomic
- dropped the changes to urcu/arch.h
- removed all custom cmm_*() macros from urcu/arch/*.h
- added the generic __atomic implementation to urcu/arch/generic.h

This was it's still possible to override the generics with arch specific macros.

[PATCH 6/7] Use __atomic builtins to implement CMM_{LOAD,STORE}_SHARED
- _CMM_STORE_SHARED and CMM_STORE_SHARED now returns the stored value

[PATCH 7/7] Fix: uatomic_or() need retyping to uintptr_t in
- no changes

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
