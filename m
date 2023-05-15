Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C673C7EE25
	for <lttng-dev@archiver.kernel.org>; Mon, 15 May 2023 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684181905;
	bh=DZMm0gOkujJ/q+ZiM6BwcVQ54CJZYrWq9wHVbdTxQEA=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=I0qr7ft0RWwTap4DxEO3u4yS+P5lE7LSRXRHCXWS11A4lCXmKBEPtfIQ+l1uearmh
	 L9ZPfkI4Yf8tD+vNS68DAo+W3K32W81gnXCwillVhGHceIe9sumsEB/iyg+rNBJKAo
	 S83LWzY63YVWdEshT8RjmhOg3sZEALUeKXZpDkIMoJgtXqaxdWnAGuD1yUVC4CLQB7
	 k11IdHmQjm9R10ICRzAenN7czNtN6IgNlSo2s3dlDtADodLqIxJTQS+aaFnPFcO0e5
	 uUJHE10DqUBlr09+n8G9e4dGYPbPXsr8qKmppPjdHiLyAMr/hBx62rtj9OpthTPq6V
	 GEmwCzZhEn7FQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QKrKY2qR2z1F04;
	Mon, 15 May 2023 16:18:25 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QKrKN1j8Cz1Df3
 for <lttng-dev@lists.lttng.org>; Mon, 15 May 2023 16:18:16 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKrKN0CCFz12nW;
 Mon, 15 May 2023 16:18:16 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 15 May 2023 16:17:14 -0400
Message-Id: <20230515201718.9809-8-odion@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 07/11] urcu-wait: Fix wait state load/store
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
Cc: Olivier Dion <odion@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The state of a wait node must be accessed atomically. Also, the action
of busy loading until the teardown state is seen must follow a
CMM_ACQUIRE semantic while storing the teardown must follow a
CMM_RELEASE semantic.

Change-Id: I9cd9cf4cd9ab2081551d7f33c0b1c23c3cf3942f
Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 src/urcu-wait.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/urcu-wait.h b/src/urcu-wait.h
index ef5f7ed..4667a13 100644
--- a/src/urcu-wait.h
+++ b/src/urcu-wait.h
@@ -135,7 +135,7 @@ void urcu_adaptative_wake_up(struct urcu_wait_node *wait)
 			urcu_die(errno);
 	}
 	/* Allow teardown of struct urcu_wait memory. */
-	uatomic_or(&wait->state, URCU_WAIT_TEARDOWN);
+	uatomic_or_mo(&wait->state, URCU_WAIT_TEARDOWN, CMM_RELEASE);
 }
 
 /*
@@ -193,7 +193,7 @@ skip_futex_wait:
 			break;
 		caa_cpu_relax();
 	}
-	while (!(uatomic_read(&wait->state) & URCU_WAIT_TEARDOWN))
+	while (!(uatomic_load(&wait->state, CMM_ACQUIRE) & URCU_WAIT_TEARDOWN))
 		poll(NULL, 0, 10);
 	urcu_posix_assert(uatomic_read(&wait->state) & URCU_WAIT_TEARDOWN);
 }
@@ -209,7 +209,7 @@ void urcu_wake_all_waiters(struct urcu_waiters *waiters)
 			caa_container_of(iter, struct urcu_wait_node, node);
 
 		/* Don't wake already running threads */
-		if (wait_node->state & URCU_WAIT_RUNNING)
+		if (uatomic_load(&wait_node->state, CMM_RELAXED) & URCU_WAIT_RUNNING)
 			continue;
 		urcu_adaptative_wake_up(wait_node);
 	}
-- 
2.39.2

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
