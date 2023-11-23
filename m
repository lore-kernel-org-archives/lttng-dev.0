Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037ECC624B4
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Nov 2023 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1700767983;
	bh=fjVHUpsakeNMJ4qT8bobp3OVefsRrgPYnlawwCJ4EBQ=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=TzfN+PUqjeKqTI67bDfPlIKInF8ajd9PkpknZrOcCYzpPHc4t/Ularj51Q0OUaN3w
	 IEbfE6Fup0TVvUZ1m4kAuhx6+6bYasTWnFyMyk2DeBPVdlX6TNTdczRqYuuUnoXsg3
	 /8AbatJl27rmjkkb0k5RNZ8Ounfg09LUJOBDj1AJejZOrW1ixS20mT0VX42XcVof5h
	 ZISIiTXCw53wq8h6m0BgeNEwcekCrRgb8CiJRzP5uKLXr9X2kiqtaAcqMK4CUxSIMO
	 +uYJWDOwy/Es9d79RdH9ARy1hu6TGMqTmFCFnMpLxSubcSOtdwIOON9xzA/g8/Re2e
	 2K8dUnIy56QJA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SbpDb6BdnzKdx;
	Thu, 23 Nov 2023 14:33:03 -0500 (EST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by lists.lttng.org (Postfix) with ESMTPS id 4SbpDW1ytBzKdw
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 14:32:59 -0500 (EST)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2e72fe47fso765112b6e.1
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 11:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700767978; x=1701372778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4gws+sXQVlsJQARDBWAqx7EZrHv5V4/ySD957+B5B+A=;
 b=SfAtiAcOx233uz9hRXM0MCe+4e2RYeRLMfbzPNEL9288PVy2HWzaBIQMiuvob4CEtn
 HljAsIsUXDBa9unnozXoaYQMlcGO+qlK1+miAjM28LRGRhmhgRt130JxztDQFSaCKKIq
 czmh91fiUlkT0haibuIRHUyW9lQEW+8Or293TF+h2QJxeaU6dlEDPwZNAzorBWTfRzN6
 rmf7Ly6ZrK00n76Dc0OOVy1wN/MDBwK0A30DETgnaYjvgJ6EmhR8J5GTqFn/KbfVTu8s
 j/xb2eDRGoFVscAabslZHomw6lQWNQEei+TEjsR2qNT8gHAekNcKfy9RKCtfjRM/yQ5g
 9q+Q==
X-Gm-Message-State: AOJu0YwRfhRMeGv5gJMWdgTNlT9gBOjSYR1KPJHshkDUl+5q7QHUnIRw
 2twOnKqqa29iy3N9nVEC1VxIA+jnc3uf9g==
X-Google-Smtp-Source: AGHT+IFN1+uFtIcPB2O5Vb18gzhBlzGw/PsPuw9727oSur7VTd5e8qK4SpRFRV9EjezwcKs44GzJKg==
X-Received: by 2002:a05:6808:3c99:b0:3b5:8586:b17e with SMTP id
 gs25-20020a0568083c9900b003b58586b17emr412665oib.52.1700767977573; 
 Thu, 23 Nov 2023 11:32:57 -0800 (PST)
Received: from localhost.localdomain ([174.112.183.231])
 by smtp.gmail.com with ESMTPSA id
 dt32-20020a05620a47a000b0077d71d46887sm662669qkb.112.2023.11.23.11.32.56
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:32:57 -0800 (PST)
To: lttng-dev@lists.lttng.org
Date: Thu, 23 Nov 2023 14:32:49 -0500
Message-Id: <20231123193249.3190764-3-bruce.ashfield@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
References: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 3/3] vmscan: drop isolate_mode (v6.7+)
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
From: Bruce Ashfield via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: bruce.ashfield@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: Bruce Ashfield <bruce.ashfield@gmail.com>

commit 3dfbb555c98ac55b9 [mm, vmscan: remove ISOLATE_UNMAPPED]
makes the isolate_mode parameter unused, so it is removed.

This updates the event to match.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
---

Repeating the comment from patch 1 & 2 of this series:

Someone else may or may not already have this in flight,
but I didn't see anything on the list or in the git
repo.

I ran into this failure when working on the v6.7-rc
kernel as part of yocto project kernel updates.

Tweak as necessary, as I'm no expert in the right way
to version these sort of changes.

Bruce

 include/instrumentation/events/mm_vmscan.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/instrumentation/events/mm_vmscan.h b/include/instrumentation/events/mm_vmscan.h
index e7e9b613..a3e9ddf2 100644
--- a/include/instrumentation/events/mm_vmscan.h
+++ b/include/instrumentation/events/mm_vmscan.h
@@ -343,12 +343,18 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_isolate,
 		unsigned long nr_scanned,
 		unsigned long nr_skipped,
 		unsigned long nr_taken,
+#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
 		isolate_mode_t isolate_mode,
+#endif
 		int lru
 	),
 
 	TP_ARGS(classzone_idx, order, nr_requested, nr_scanned, nr_skipped,
-		nr_taken, isolate_mode, lru
+		nr_taken,
+#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
+		isolate_mode,
+#endif
+		lru
 	),
 
 	TP_FIELDS(
@@ -358,7 +364,9 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_isolate,
 		ctf_integer(unsigned long, nr_scanned, nr_scanned)
 		ctf_integer(unsigned long, nr_skipped, nr_skipped)
 		ctf_integer(unsigned long, nr_taken, nr_taken)
+#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
 		ctf_integer(isolate_mode_t, isolate_mode, isolate_mode)
+#endif
 		ctf_integer(int, lru, lru)
 	)
 )
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
