Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E77BC433FE
	for <lttng-dev@archiver.kernel.org>; Sun,  2 Oct 2022 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664727233;
	bh=VnF4u7YJjTv1CHkWAGEDJVgHBXkzk4TXaW2CGyePr30=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=cuUZkb/hK0eWbSiGONcSBE3q5JWLHDarZjDCD7oEslpM9kAkeU0NoCe+ojAeUtSpo
	 k/Wl7TLCkem1lRu9ANRCjeFT8bcw3bqsNLV4aEty1PbJQATzk3MdMMiphEg9dgqais
	 Xi20KVnSng+zJfOrOq9pZJKwmSahsZlNNWbfTbBU3gZWW9DG24p713YG3X2CqeCqq3
	 f01oR5wzI4udMz+ToGotdp9Vj1ZY+L07tuHix3NLhXQshu62oy++JQxa2TaPR1FnQw
	 TvzblQnZRaL9KsIzPgbkb6qOVtddIRZiMz1Gs2bHguxJh/TVDHr8ISlPaKR5Il5ORu
	 M04rfFVnvizHQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MgTYF1C8cz27ln;
	Sun,  2 Oct 2022 12:13:53 -0400 (EDT)
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
 by lists.lttng.org (Postfix) with ESMTPS id 4MgTYC1hr0z27xm
 for <lttng-dev@lists.lttng.org>; Sun,  2 Oct 2022 12:13:51 -0400 (EDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
 by dcvr.yhbt.net (Postfix) with ESMTP id C31BD1F51E
 for <lttng-dev@lists.lttng.org>; Sun,  2 Oct 2022 16:13:43 +0000 (UTC)
To: lttng-dev@lists.lttng.org
Date: Sun,  2 Oct 2022 16:13:43 +0000
Message-Id: <20221002161343.854582-1-normalperson@yhbt.net>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] always check pthread_create for failures
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
From: Eric Wong via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

pthread_create may fail with EAGAIN (which is no fault of the
programmer), so don't allow the check to be compiled out.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 src/urcu-defer-impl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/urcu-defer-impl.h b/src/urcu-defer-impl.h
index 1c96287..cbb0ca8 100644
--- a/src/urcu-defer-impl.h
+++ b/src/urcu-defer-impl.h
@@ -417,7 +417,8 @@ static void start_defer_thread(void)
 	urcu_posix_assert(!ret);
 
 	ret = pthread_create(&tid_defer, NULL, thr_defer, NULL);
-	urcu_posix_assert(!ret);
+	if (ret)
+		urcu_die(ret);
 
 	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
 	urcu_posix_assert(!ret);
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
