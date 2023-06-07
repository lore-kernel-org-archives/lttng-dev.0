Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2E5C7EE43
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164100;
	bh=UYcUqSXAEjLYeLcjkCChDNAAlg4zdn4bY7nFtVggcEE=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=K7LZlxpR2fryPZwHH3CR2E/m4QnXaz1lz+OB0W3uHXAJwUJaaAfesLdt02F4R5n3A
	 FbQbsfZSJHup0aegMKPqNox2NaqFAVvQYJ9gnxdGHN5DRsnIl3HaeY6HgYlRJsuhn8
	 ohjyao3KLt52h9xKAnuPXM1RqD+Bswf1curHHsuA73g2Q3ASUUXeyuPbzBN6p2siXk
	 TpHj1EjUaHd+HaapUY5/Y1NGoJOYTkzDgwBtItlQn4p4IXRW98ifPeeDrxYLo3IANW
	 rsgAGYiX0v1AmGB3EI+jITB4g2CKSyKXbp8KZUB2HjqqB93m8I6V212+3PjzWBNaOe
	 LNTSEC5FeIahg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNh60KMz1Xqv;
	Wed,  7 Jun 2023 14:55:00 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNY23HYz1XvV
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNY0STDz16yy;
 Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:56 -0400
Message-Id: <20230607185359.8125-10-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 09/12] tests/unit/test_build: Quiet unused
 return value
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
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Change-Id: Ie5a18e0ccc4b1b5ee85c5bd140561cc2ff9e2fbc
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 tests/unit/test_build.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test_build.c b/tests/unit/test_build.c
index f6b667c..702c1ef 100644
--- a/tests/unit/test_build.c
+++ b/tests/unit/test_build.c
@@ -129,10 +129,10 @@ void test_build_rcu_dereference(void)
 	static struct a_clear_struct *clear = NULL;
 	static struct a_clear_struct *const clear_const = NULL;
 
-	rcu_dereference(opaque);
-	rcu_dereference(opaque_const);
-	rcu_dereference(clear);
-	rcu_dereference(clear_const);
+	(void) rcu_dereference(opaque);
+	(void) rcu_dereference(opaque_const);
+	(void) rcu_dereference(clear);
+	(void) rcu_dereference(clear_const);
 }
 
 int main(void)
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
