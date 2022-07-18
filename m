Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BFBC433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jul 2022 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658181626;
	bh=QXnHxm5AXabnvlPzYbFO6lSAaihbjqoOrciXaNYb9y0=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=GBdddGSenizzBCmXxqBxcBHCHnQwJnRXzwbYgmqhXfGVaXA9CvRdPxcw0VdHZBIUj
	 fCAb7onpZuO1+ANMVU+9QhJQtJH6zu5sTsxmbg8htwBuyDG9j/vCmkZCIXkIGOtFQp
	 1Ubh9BpCt/rV9DjeFGxmhblubIUW/pSZBDHcKizaXbu7PGSM4Kpgo9YL2Q4NuwxQSP
	 n68sD/UsiJW/XhadDnG6TUv0O/6VztSR1U9ONzAQJBoSp3PRleDnNkdOl+GnDYBQ0S
	 kaYJpocbKkMXKOVjETUn+IasDRwh/cl3dG7vMSA85YM+qK64j5KTWygGwkOnYroDIp
	 WZ/PICyclsxgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Lmwr950MWzPbl;
	Mon, 18 Jul 2022 18:00:25 -0400 (EDT)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by lists.lttng.org (Postfix) with ESMTPS id 4Lmwr75LpgzPSl
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 18:00:23 -0400 (EDT)
Received: by mail-ej1-x633.google.com with SMTP id tk8so12451227ejc.7
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 15:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3dvEK5WP8KcHeCSyIZ8hyd5GHgESnMbiXc/+SFooWOs=;
 b=MzA1/TVu+C00au5hE9DtQMCg6qHZBq4+KD223sr4dokLHh730JRmsUN9M4sM3AivQv
 mFDunb17kpBsH1SaM7gq6Cbj8HF2YK1sT2DwunQM/BtKC9emsaHp1A1ctUVUTkzMf4Dd
 aLZ7SnA2UtoUXcw10ofXntavghNbLBZClUHpnH3ixBTj7xIazGRa2GPaIKmclRZSXVmi
 oQp0aLszHe824QuUBt2f62bJLilP5kCurpiHOGZmL0+bCMfgjJuHIAeeiVC8FjP/cICg
 JbdKuXBiSxFB7jwU3kzub0YvfOLBZwII3/2f1Zmb/biAU6j//cPFxhAt9wZzl3ALUhTE
 7Ljg==
X-Gm-Message-State: AJIora9g8GxayRSol4pcc8tM57LvOigRECyIlO6sZ30pCJqlHCrNLezB
 oafk9ooDvdoioWR1eYtWvxNHrGw6lbf+hQ==
X-Google-Smtp-Source: AGRyM1tejujpTV4TjEMT9yV+YRUw7pskol5DUOeKF8iHQ4BfPifrPwOaMcRnmm+75yf4fLtTE0MxmQ==
X-Received: by 2002:a17:906:8a63:b0:72b:3796:9d0b with SMTP id
 hy3-20020a1709068a6300b0072b37969d0bmr27091471ejc.573.1658181622439; 
 Mon, 18 Jul 2022 15:00:22 -0700 (PDT)
Received: from debian-noppl.. (62-178-205-20.cable.dynamic.surfer.at.
 [62.178.205.20]) by smtp.gmail.com with ESMTPSA id
 u18-20020a05640207d200b0042dcbc3f302sm9231847edy.36.2022.07.18.15.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jul 2022 15:00:22 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Mon, 18 Jul 2022 23:59:55 +0200
Message-Id: <20220718215955.124991-2-nolange79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718215955.124991-1-nolange79@gmail.com>
References: <20220718215955.124991-1-nolange79@gmail.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 2/2] lttng_ust_init_thread: call
 urcu_register_thread
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Eagerly register the thread, and avoid taking mutex during the
first tracepoint.

Signed-off-by: Norbert Lange <nolange79@gmail.com>
---
 src/lib/lttng-ust/lttng-ust-comm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng-ust-comm.c
index ba0bd985..3ff6b086 100644
--- a/src/lib/lttng-ust/lttng-ust-comm.c
+++ b/src/lib/lttng-ust/lttng-ust-comm.c
@@ -447,6 +447,8 @@ void lttng_ust_init_thread(void)
 	 * this thread attempts to use them.
 	 */
 	lttng_ust_alloc_tls(true);
+
+	lttng_ust_urcu_register_thread();
 }
 
 int lttng_get_notify_socket(void *owner)
-- 
2.35.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
