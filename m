Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF91BEB64D7
	for <lttng-dev@archiver.kernel.org>; Wed, 14 Jun 2023 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686707541;
	bh=yaEQeqixwNgcZaWbzDbjxdcAnyPAq87EnCOWDIBghMc=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ONMLeOLoBPIe77oXpAlcFCv2uLG60d2REngAeZOne4ort9IrMcDnPoVRlod/V+IYn
	 dzuXUiM3knr25CLaKlqj6cm3NtoVts8WDfKDNb+8bAkvlz6nY/Y2YaoRSR9ck1l1JE
	 +jrfYGROmEa+4OAUxmuScsIJWZRBT83lF7naZru4IiQuRZcpIgsihSpvj54kpZ7HE7
	 6ggYhRvNWAziA9FWupk3HTBXrDMFJKP25XiF/HmnvrcU5ilDrudrCsoaWBJ0KAbb1y
	 xIaAMZoh3wNc1rU4IsDYngBG5gk+wbpx6LKN7MwjnmOpOqn6J/QJ+knRcEmmxQC/TI
	 ZgIsR8VzjhXPg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QgpMS5vW2z1fxR;
	Tue, 13 Jun 2023 21:52:20 -0400 (EDT)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by lists.lttng.org (Postfix) with ESMTPS id 4QgpMR4br0z1g5k
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2023 21:52:09 -0400 (EDT)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53482b44007so3267799a12.2
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2023 18:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686707528; x=1689299528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHyrO/+ymdASLDb/1wi+1ecufWyE5lJqEsZA0HnCMPU=;
 b=gCgThJvpE3zYpj18k4QEpe+s4DlsxfbHFty5FSu/xVI71uKJJJzfPWNaoptXppocf3
 s9bxbdoI0uBplGRb9tNup+D2mJIOCGeQ/rCAAf16qlxRnILScnECVDkj80QZgFy+o5WB
 ZK7g+9OLfMaKJqiejpkjOD50MOlVMMUOr1wtX8B5IUenCgl80EEzMEqwrZhd6fQuTlhg
 xD7mH5v/q9AZ+qFa6LsJn9SzboolFaB4BIvVfMh1+rxqwDwEPXmwfPQ6zZrFXGbstas1
 q9LZYkyxia7vvzWOGC/f6jL5WNmYtYbar69j3XzVPJyhuNiL0fvxR0z0HOJSIJ/vzhDj
 Gf3Q==
X-Gm-Message-State: AC+VfDztKh8h5t5bcgwe+fxP+5+IfQedrE12FExZgyJodqXAK9BCua4f
 WT4HiiudJWpV7TwQ+bmo1aGHxhhCqw==
X-Google-Smtp-Source: ACHHUZ745kk4gPI37ID7nmv+JJ+5zWCGZuoerSeGBqRI4vE4elkDtMGkH5MnGVeOGeuxEwsSRWrNbg==
X-Received: by 2002:a17:90a:198:b0:25b:8fcc:25fb with SMTP id
 24-20020a17090a019800b0025b8fcc25fbmr407164pjc.2.1686707527796; 
 Tue, 13 Jun 2023 18:52:07 -0700 (PDT)
Received: from korin-ASUS-TUF-Gaming-F15-FX507ZM-FX507ZM.. ([140.116.247.93])
 by smtp.gmail.com with ESMTPSA id
 ix20-20020a170902f81400b001b3c2f4c9casm5407214plb.253.2023.06.13.18.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:52:07 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Wed, 14 Jun 2023 09:51:48 +0800
Message-Id: <20230614015148.12974-1-k777k777tw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c43cf89e-99eb-9287-c46a-6ee936e910fc@efficios.com>
References: <c43cf89e-99eb-9287-c46a-6ee936e910fc@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] Fix: revise urcu_read_lock_update() comment
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
From: Li-Kuan Ou via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Li-Kuan Ou <k777k777tw@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Read-side critical section nesting is tracked in lower-order bits
and grace-period phase number use a single high-order bit

Signed-off-by: Li-Kuan Ou <k777k777tw@gmail.com>
---
 include/urcu/static/urcu-bp.h     | 6 +++---
 include/urcu/static/urcu-mb.h     | 6 +++---
 include/urcu/static/urcu-memb.h   | 6 +++---
 include/urcu/static/urcu-signal.h | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/urcu/static/urcu-bp.h b/include/urcu/static/urcu-bp.h
index 8ba3830..b163a90 100644
--- a/include/urcu/static/urcu-bp.h
+++ b/include/urcu/static/urcu-bp.h
@@ -137,9 +137,9 @@ static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr)
 
 /*
  * Helper for _urcu_bp_read_lock().  The format of urcu_bp_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _urcu_bp_read_lock() nesting, and a lower-order bit that contains either zero
- * or URCU_BP_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _urcu_bp_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
+ * that contains either zero or one.  The smp_mb_slave() ensures that the accesses in
  * _urcu_bp_read_lock() happen before the subsequent read-side critical section.
  */
 static inline void _urcu_bp_read_lock_update(unsigned long tmp)
diff --git a/include/urcu/static/urcu-mb.h b/include/urcu/static/urcu-mb.h
index b97e42a..253d29b 100644
--- a/include/urcu/static/urcu-mb.h
+++ b/include/urcu/static/urcu-mb.h
@@ -63,9 +63,9 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_mb_reader);
 
 /*
  * Helper for _urcu_mb_read_lock().  The format of urcu_mb_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _urcu_mb_read_lock() nesting, and a lower-order bit that contains either zero
- * or URCU_GP_CTR_PHASE.  The cmm_smp_mb() ensures that the accesses in
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _urcu_mb_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
+ * that contains either zero or one.  The cmm_smp_mb() ensures that the accesses in
  * _urcu_mb_read_lock() happen before the subsequent read-side critical section.
  */
 static inline void _urcu_mb_read_lock_update(unsigned long tmp)
diff --git a/include/urcu/static/urcu-memb.h b/include/urcu/static/urcu-memb.h
index c8d102f..f64cb57 100644
--- a/include/urcu/static/urcu-memb.h
+++ b/include/urcu/static/urcu-memb.h
@@ -86,9 +86,9 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_memb_reader);
 
 /*
  * Helper for _rcu_read_lock().  The format of urcu_memb_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
- * or URCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _rcu_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
+ * that contains either zero or one.  The smp_mb_slave() ensures that the accesses in
  * _rcu_read_lock() happen before the subsequent read-side critical section.
  */
 static inline void _urcu_memb_read_lock_update(unsigned long tmp)
diff --git a/include/urcu/static/urcu-signal.h b/include/urcu/static/urcu-signal.h
index c7577d3..707eaf8 100644
--- a/include/urcu/static/urcu-signal.h
+++ b/include/urcu/static/urcu-signal.h
@@ -64,9 +64,9 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_signal_reader);
 
 /*
  * Helper for _rcu_read_lock().  The format of urcu_signal_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
- * or URCU_GP_CTR_PHASE.  The cmm_barrier() ensures that the accesses in
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _rcu_read_lock() nesting, and a single high-order URCU_BP_GP_CTR_PHASE bit
+ * that contains either zero or one.  The cmm_barrier() ensures that the accesses in
  * _rcu_read_lock() happen before the subsequent read-side critical section.
  */
 static inline void _urcu_signal_read_lock_update(unsigned long tmp)
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
