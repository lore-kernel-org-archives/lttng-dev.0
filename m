Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B49C02183
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Jan 2025 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1736950985;
	bh=cssthcMLf0Gqb7n97ZvhB5rkuKWwfqjXKz2a1sW5/n0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=APxa4kgNs99eSVQDyZIkVmp9uPxSGEB++etBNyJk7cYWllo40d5yoJmJrMuR21LCf
	 WHYzPzLBnB/RpT8k0eo+E7mnnyVLU0qVL7Irp/h08ZaWVGftbj4nrTcQYtcOUzoc6y
	 uR0LNJ9WO7BnrpOTp8jFrBHnPFkzghhfYtmGbwOa2wZPEHfNtU3X7qk31TYdVG0Ami
	 9HmUQvJ/lCn+h3Yclkqi4vbZmrmRytDHUsxFy/izNiiV+wBQWzduCitMxTq8/T3FdQ
	 HK32ujArzLoYAm25AWEWOLLPfbwGgzbfR3BsaOWEantd7d5WeipxccRioi4PJ/TCEp
	 O4Nt9KIfOYLCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4YY7WX5Yf1z1TcY;
	Wed, 15 Jan 2025 09:23:04 -0500 (EST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by lists.lttng.org (Postfix) with ESMTPS id 4YY7WW3lr3z1TcW
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jan 2025 09:23:03 -0500 (EST)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-467a17055e6so78744791cf.3
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jan 2025 06:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736950982; x=1737555782;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUKlJumAoUt+mFJH1BiDNkxQLXm7BCoKWk8YJu/NPEo=;
 b=QaIZLsSlLPgQLzoj/2LnLcpNAhIqVeDaoXCE29dfUz4W4qCUuh7nJaHuW98+5CqykJ
 iKk8uCKL92Ag5mJuINbSyljTtP5dLXXfpKiFZLvVe9R/ZUGnDIXvs9pgJh26f07I9z6c
 W3RUMxDKQiUy5YY82jQN0HG/7FC/sHfLWme2uhfTrNk2iuAC1ydqfhM0G9lHbqatgP7/
 aHWQn2BQYC8Mmjy6r2FUsBLThBU53vzUbJALL0viIV5vwTcMSq/14x4C3k7K3x3caP1D
 XXJyxhYpNONvQy1m2NQYAmnN7MqqArzXPzugobWUA32SgFJqRVbpA7LAwt5P3gB1iytK
 /QCw==
X-Gm-Message-State: AOJu0Yw9+WgvzEwDR/09AgWMBsFiJvnoIjnMqRTa9Zlte5YPcTfcgzar
 RKlIXIe2ooizKID9NGpc173FA9uzrvIWFEjwgkowuKtDmf6x6zawzsMFgunAbHRKDO6j4pIB9mM
 7
X-Gm-Gg: ASbGncvUNe2ZJTlFE2on3CclrMJZVdfjPJ4NDj9csjXcY4FINxvOg631JquhNL8Ux4+
 UcPbdaqc8OMx63Wbn8+GrASf9f8PM2jZUkr1lszdXLs4tzZmJxNikRFMdcnt9QP9MAqkUSd1PzU
 2KuG2Z9fSXu0i8vyOnCEcUqYBu9uVQarB2ESuUeAC65DGwvH+rDHiBooHHbmMWfu3piZCU+PblK
 4/F/9J50wVS8ouInyYecZOk7A9CoyjQYWzHSUcdKWI1EeU7qWEB9qCvBw==
X-Google-Smtp-Source: AGHT+IFNLpinM9d6Ysf9Bczq+gF8e4sG1qJSFsbOkKdxtUZenYWYXvjJMo/mwPAhK/udlYJQ+Q5Z+A==
X-Received: by 2002:ad4:5d66:0:b0:6d8:8109:a547 with SMTP id
 6a1803df08f44-6df9b229b3dmr360985066d6.22.1736950982489; 
 Wed, 15 Jan 2025 06:23:02 -0800 (PST)
Received: from martin-pc ([204.101.17.200]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c87321695sm65063021cf.15.2025.01.15.06.23.02
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 06:23:02 -0800 (PST)
Date: Wed, 15 Jan 2025 09:23:00 -0500
To: lttng-dev@lists.lttng.org
Subject: [PATCH] lttng-modules fix for RHEL 9.5 kernels
Message-ID: <20250115142300.vlupsqd2lr5bipfo@martin-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
From: Martin Hicks via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Martin Hicks <martin@sr-research.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


This fixes the asoc_snd_*, kfree_skb and udp related tracepoints for the
RHEL 9.5 distro kernel.

In all cases they've updated to the format of newer kernels.

Signed-off-by: Martin Hicks <martin@sr-research.com>
---
 include/instrumentation/events/asoc.h | 8 ++++++--
 include/instrumentation/events/skb.h  | 4 +++-
 include/instrumentation/events/udp.h  | 4 +++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/instrumentation/events/asoc.h b/include/instrumentation/events/asoc.h
index f6b2c76..31bedfe 100644
--- a/include/instrumentation/events/asoc.h
+++ b/include/instrumentation/events/asoc.h
@@ -120,7 +120,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(asoc_snd_soc_preg, snd_soc_preg_read,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT_CLASS(asoc_snd_soc_dapm_context,
 
 	TP_PROTO(struct snd_soc_dapm_context *dapm, int val),
@@ -187,7 +189,9 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(asoc_snd_soc_card, snd_soc_bias_level_done,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,9,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT_CLASS(asoc_snd_soc_dapm_basic,
 
 	TP_PROTO(struct snd_soc_card *card, int event),
diff --git a/include/instrumentation/events/skb.h b/include/instrumentation/events/skb.h
index 5556ab6..becfd80 100644
--- a/include/instrumentation/events/skb.h
+++ b/include/instrumentation/events/skb.h
@@ -40,7 +40,9 @@ LTTNG_TRACEPOINT_ENUM(skb_drop_reason,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,11,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,11,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT_MAP(kfree_skb,
 
 	skb_kfree,
diff --git a/include/instrumentation/events/udp.h b/include/instrumentation/events/udp.h
index 0a94b46..c228ef6 100644
--- a/include/instrumentation/events/udp.h
+++ b/include/instrumentation/events/udp.h
@@ -9,7 +9,9 @@
 #include <linux/udp.h>
 #include <lttng/kernel-version.h>
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,10,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,10,0) || \
+    LTTNG_RHEL_KERNEL_RANGE(5,14,0,503,21,1,  5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_ENUM(lttng_sk_family,
 	TP_ENUM_VALUES(
 		ctf_enum_value("AF_INET", AF_INET)
-- 
2.43.5



-- 
Martin Hicks
SR Research Ltd.
Fast, Accurate, Reliable Eye Tracking
