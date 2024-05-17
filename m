Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAF8C04FFE
	for <lttng-dev@archiver.kernel.org>; Fri, 17 May 2024 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1715956208;
	bh=kGW0SGQ8lTJokVH+2SqCaaVWE6rxNgVVKHBaB2NW/7o=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=XA1R/7jfQVU52/G7jq7jmUtNvJ/qfl2VgHvvH5pO8tDvWCIGHkrglU94nGTK4Y/AZ
	 U3qSQT8q6tJhPFFYlhf4iMQ/ttl1VfFJiDfh+QJmVdSk7rYkUuahFGoycCqjR+aLiH
	 pXqM+sAQlMjfDxu6XFkP6GIokgKZt/wIOhbqPm5mT5QFB2mJCbEBJO7FUR3U3pOA9/
	 Omg5L+FgmTRMCnZoW10UgyLnAUjkohFX1m3I70s1ssAbWHlgSbHevhd9K7VbhPNgTg
	 miRjrMNfodnTjUPsA/SN9/hjRjpOgC+wTF3S5Ayeg1aD+hH28InmIwc/UfwL2FnLI4
	 r4eTmP1Bmlw1Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Vgq9r147Xz2p0H;
	Fri, 17 May 2024 10:30:08 -0400 (EDT)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by lists.lttng.org (Postfix) with ESMTPS id 4Vgq9p6hnHz2ncx
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2024 10:30:06 -0400 (EDT)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-43dff9b28f6so5262021cf.1
 for <lttng-dev@lists.lttng.org>; Fri, 17 May 2024 07:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715956206; x=1716561006;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mz1DpUz6o5MtuGvId5Ln/hW2G8oSHqGWWAXUH3x1BHk=;
 b=m9qZPlf0NZGv3nXQdRyCakPLlAv6F9keGlq7JRjMbuTYIXTC7IpglJ+Foqt2crzy3T
 B85SpFJGR1D0L1a35xBVKZwsO+1NnwIvNTW4waCl6ckfUYkSuvrHhaPPZ2j/TLHUoUS+
 KQ9te/H4mlPZa4teRZnC6MgOrCgi+cmNheAAIllVeJ4DNtim5aBU3i94LliKc+ZJlycb
 Ccdx9hE4WxYGdeEG3srgfxqMX8uPyB4GeibJ7nlnda5iCnZlusGa4xp+gQtv6lL/x5Bn
 XYBIwN1aW9NZdoCCt8lXfQ1nLRCiOhDql0szrHqO1FSmUTI+mZf18IeEF0nPMCthroPA
 OglQ==
X-Gm-Message-State: AOJu0Yx1c5CDJXO8hmWo2buEyMHTuVkz2dguccjK8XigstALyepQRRv+
 GDajDFQz/UTrZDEERaifgyxs8AttU0YjpUbwjssyJBRkizVZuGEDUsg1RimC+3c9Z1d689OkI/a
 A
X-Google-Smtp-Source: AGHT+IHPzW9o+NxbNciD8ICIBGwIDdUZco/qnkx1c9QS/jaBUmuihhecGysWE9V0kDXAsQ1936KjRQ==
X-Received: by 2002:a05:622a:229f:b0:43a:c0c7:a218 with SMTP id
 d75a77b69052e-43dfce5d50cmr440303601cf.33.1715956205582; 
 Fri, 17 May 2024 07:30:05 -0700 (PDT)
Received: from t14.bork.org ([2001:470:b142::b46])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e1e528399sm62871981cf.6.2024.05.17.07.30.05
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 07:30:05 -0700 (PDT)
Date: Fri, 17 May 2024 10:30:03 -0400
To: lttng-dev@lists.lttng.org
Message-ID: <ZkdnIf/OX995MndN@t14.bork.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [PATCH] Fix mm_vmscan_lru_isolate tracepoint for RHEL
 9.4 kernel
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>



Redhat has moved to using the format first found in the 6.7 kernel
for the mm_vmscan_lru_isolate tracepoint.

Signed-off-by: Martin Hicks <martin@sr-research.com>
---
 include/instrumentation/events/mm_vmscan.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/instrumentation/events/mm_vmscan.h b/include/instrumentation/events/mm_vmscan.h
index ea6f4b7..49a9eae 100644
--- a/include/instrumentation/events/mm_vmscan.h
+++ b/include/instrumentation/events/mm_vmscan.h
@@ -369,7 +369,9 @@ LTTNG_TRACEPOINT_EVENT_MAP(mm_shrink_slab_end,
 )
 #endif
 
-#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,7,0))
+#if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(6,7,0) || \
+     LTTNG_RHEL_KERNEL_RANGE(5,14,0,427,0,0, 5,15,0,0,0,0))
+
 LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_isolate,
 
 	TP_PROTO(int classzone_idx,
-- 
2.43.0

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
