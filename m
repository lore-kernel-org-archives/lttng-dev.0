Return-Path: <SRS0=Hq7A=FN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF28C4361B
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 18:15:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B2D23BAC
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Dec 2020 18:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B2D23BAC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CrlbT24Xmz1WHB;
	Wed,  9 Dec 2020 13:15:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1607537749;
	bh=7GMuuO+wRo11Be897tuPlxgNfwzOKisqMBUWAqZ6sNg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=0reX9jEYjeq5fI6R41kI6mKDLYaccDDKG8ul4/dBCfe7bx5GmTC3UIOW6CwZTBrzT
	 f31CKEqNLPsSCL9vKb4Yf3pACG0KpFNStlLYPK497Do82YiarHTSPY7Dkaz04XYNjP
	 8URQXMo3/WNUZ6KBVAca2oFmCDTXwlnWM1sGyQ1OfJPmdC/b6Y1LSW43wb9qoLr+F1
	 8lfButTvWrEX8dPGzVKuhYGaI1y3o4O3+fWhZysIRaS50ceRDTGudOFUvLE+SvVcja
	 RznJ90BnDJ0rZOpN4NlM0e19swknXJ18DJ0QBkc7pmZGX+KpxsegI6Tr3LIni2Bhzu
	 FWMQ1+gllNwEQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CrlbR57GMz1Vq0
 for <lttng-dev@lists.lttng.org>; Wed,  9 Dec 2020 13:15:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D5D82FDBF0;
 Wed,  9 Dec 2020 13:15:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id z5AzpZv2dxx3; Wed,  9 Dec 2020 13:15:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D25272FDBEF;
 Wed,  9 Dec 2020 13:15:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D25272FDBEF
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qNobr5udgcrf; Wed,  9 Dec 2020 13:15:46 -0500 (EST)
Received: from multivac.lan (96-127-212-112.qc.cable.ebox.net [96.127.212.112])
 by mail.efficios.com (Postfix) with ESMTPSA id 968D42FE087;
 Wed,  9 Dec 2020 13:15:46 -0500 (EST)
To: lttng-dev@lists.lttng.org
Date: Wed,  9 Dec 2020 13:15:37 -0500
Message-Id: <20201209181537.444048-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH urcu] fix: bump tests thread limit to 256
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Machines with more than 128 CPUs are becomming more common, the proper
fix here would be to dynamically allocate the array which we will do,
but in the meantime bump the limit to 256 to fix the problem on a 160
CPUs ppc64el system where this was reported.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Change-Id: Ib3cb5d8cb4515e6f626be33c2685fa38cb081782
---
 tests/common/api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/common/api.h b/tests/common/api.h
index 2b72ec5..b15e588 100644
--- a/tests/common/api.h
+++ b/tests/common/api.h
@@ -108,7 +108,7 @@ static void spin_unlock(spinlock_t *sp)
 
 typedef pthread_t thread_id_t;
 
-#define NR_THREADS 128
+#define NR_THREADS 256
 
 #define __THREAD_ID_MAP_EMPTY ((thread_id_t) 0)
 #define __THREAD_ID_MAP_WAITING ((thread_id_t) 1)
-- 
2.29.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
