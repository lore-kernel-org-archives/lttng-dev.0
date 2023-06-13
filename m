Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE23EB64D0
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Jun 2023 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686671152;
	bh=SwyP9RtDGTMpDUzCnqvlzWP5hpKmkzNjSgRtalFIhVU=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=dHd0pv+IXWWNY9BaENZaKbh7FTUY1IUxkozCxxziD8h6JXP/m+erQemirvAnciNeT
	 3rkJ5sWYDgnT6anfTPrd+VAW7FlZmDBUcvbD1YCj6BL8dVEB2V4Lrub3Bs0o6myGGW
	 MHrQe4t2w7mTenBpMMZv93Zz+4RxpJpVWH7i0UPe2C7AQlo+OyYSDmN2Zl+IDzWRer
	 6J3h5rVN0/Xl4iC3++kyKi5RSsYgDR3ZS1NdHiXkjxTjy5HhG6X6z6oTnRwN8OTFST
	 v52qIaDKA6Ek12cN2b1C6fALh67zZ3lqwSSKdukKKYlNPx6B8ScDWEKDCGW/sCw7qv
	 DNl0mQqgpuHow==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QgXvg1sz2z1gLy;
	Tue, 13 Jun 2023 11:45:51 -0400 (EDT)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by lists.lttng.org (Postfix) with ESMTPS id 4QgXvd6qC7z1gLw
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2023 11:45:44 -0400 (EDT)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-662b85f4640so4732414b3a.0
 for <lttng-dev@lists.lttng.org>; Tue, 13 Jun 2023 08:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686671143; x=1689263143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ki14TB10SKX139FaSaE6XkR4DBu8UltYOccjvXinh4s=;
 b=SfnP2aot9nMqux8KBzFD6+7EHriReG/q0xmw0+mVX2cNH3IS061cKB4dlwkKeObdFs
 WRzd0PUXLz16joIGGWChjJwGs0Ex5FPJE+ldbx7UKHDlfVVUL8CN9pukPX/ReNqtyNeS
 K1qq9WYrO6M3VTXiz7PJqJE62CgvsppV11Y6tWbr/7ICTCwIIRFFMC2KkzgH1J8iQF3J
 l31aq5Wuc+Y5JnozOhc3mee5M0jnMhc98ARBk04XPCJe9HQFFXvbtS1cPOiobPaUwEBW
 r8XpTCfA2opTsAkQPBfVn46jvzFU/iUoFeuDcZ41QM4isiXt5LXNQ+ma+v8IEcEI+MyI
 43Nw==
X-Gm-Message-State: AC+VfDyFUgDXK6bFg6OOaA0VX3OUNZIDdpHh0urF9PXUzajVrRopWBPc
 vDl8xvWjQfIajVt24EDGpoU3199VaQ==
X-Google-Smtp-Source: ACHHUZ6yC7BDIhZS2p++AVkXTwNlNGE4pAvHKMzpL4493qD3oREqwXsQHLNHl3mGgkha7bUfFYPshQ==
X-Received: by 2002:a05:6a21:99a5:b0:10c:62b3:7dc4 with SMTP id
 ve37-20020a056a2199a500b0010c62b37dc4mr13550856pzb.55.1686671143114; 
 Tue, 13 Jun 2023 08:45:43 -0700 (PDT)
Received: from korin-ASUS-TUF-Gaming-F15-FX507ZM-FX507ZM.. ([140.116.136.92])
 by smtp.gmail.com with ESMTPSA id
 t1-20020aa79381000000b0064381853bfcsm8804775pfe.89.2023.06.13.08.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 08:45:42 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Tue, 13 Jun 2023 23:45:23 +0800
Message-Id: <20230613154523.17184-1-k777k777tw@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 include/urcu/static/urcu-bp.h     | 4 ++--
 include/urcu/static/urcu-mb.h     | 4 ++--
 include/urcu/static/urcu-memb.h   | 4 ++--
 include/urcu/static/urcu-signal.h | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/urcu/static/urcu-bp.h b/include/urcu/static/urcu-bp.h
index 8ba3830..c90c9f1 100644
--- a/include/urcu/static/urcu-bp.h
+++ b/include/urcu/static/urcu-bp.h
@@ -137,8 +137,8 @@ static inline enum urcu_bp_state urcu_bp_reader_state(unsigned long *ctr)
 
 /*
  * Helper for _urcu_bp_read_lock().  The format of urcu_bp_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _urcu_bp_read_lock() nesting, and a lower-order bit that contains either zero
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _urcu_bp_read_lock() nesting, and a single high-order bit that contains either zero
  * or URCU_BP_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
  * _urcu_bp_read_lock() happen before the subsequent read-side critical section.
  */
diff --git a/include/urcu/static/urcu-mb.h b/include/urcu/static/urcu-mb.h
index b97e42a..218e2f3 100644
--- a/include/urcu/static/urcu-mb.h
+++ b/include/urcu/static/urcu-mb.h
@@ -63,8 +63,8 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_mb_reader);
 
 /*
  * Helper for _urcu_mb_read_lock().  The format of urcu_mb_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _urcu_mb_read_lock() nesting, and a lower-order bit that contains either zero
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _urcu_mb_read_lock() nesting, and a single high-order bit that contains either zero
  * or URCU_GP_CTR_PHASE.  The cmm_smp_mb() ensures that the accesses in
  * _urcu_mb_read_lock() happen before the subsequent read-side critical section.
  */
diff --git a/include/urcu/static/urcu-memb.h b/include/urcu/static/urcu-memb.h
index c8d102f..b923f73 100644
--- a/include/urcu/static/urcu-memb.h
+++ b/include/urcu/static/urcu-memb.h
@@ -86,8 +86,8 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_memb_reader);
 
 /*
  * Helper for _rcu_read_lock().  The format of urcu_memb_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _rcu_read_lock() nesting, and a single high-order bit that contains either zero
  * or URCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
  * _rcu_read_lock() happen before the subsequent read-side critical section.
  */
diff --git a/include/urcu/static/urcu-signal.h b/include/urcu/static/urcu-signal.h
index c7577d3..00588b8 100644
--- a/include/urcu/static/urcu-signal.h
+++ b/include/urcu/static/urcu-signal.h
@@ -64,8 +64,8 @@ extern DECLARE_URCU_TLS(struct urcu_reader, urcu_signal_reader);
 
 /*
  * Helper for _rcu_read_lock().  The format of urcu_signal_gp.ctr (as well as
- * the per-thread rcu_reader.ctr) has the upper bits containing a count of
- * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
+ * the per-thread rcu_reader.ctr) has the lower-order bits containing a count of
+ * _rcu_read_lock() nesting, and a single high-order bit that contains either zero
  * or URCU_GP_CTR_PHASE.  The cmm_barrier() ensures that the accesses in
  * _rcu_read_lock() happen before the subsequent read-side critical section.
  */
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
