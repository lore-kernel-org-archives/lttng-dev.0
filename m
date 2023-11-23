Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D10C5AD4C
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Nov 2023 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1700767978;
	bh=MKkBhw8zK0A45A9bladCDii+g/MEygBN7wJMO3zi+ZU=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=iJ6NW7LG2Nl0PMNXP6I8YTN5rB2eCJsgLqd4j0GPkUxJmFBBGlyl4nDewwNeA/5uG
	 BjgyXmZOhgtgnBnobmLqixRKFvKpNpnfdwKAaJTTZkOvOmdd4M471xDXLgJ+vRr2SV
	 v6+nxDwdrih44bkMW6ZzVZNL2atgYEvc36IE0W7IwUB2fiQ3FSDRn/W4vBxOgHOQqB
	 +LThj88hn+XSZ4FMvADk99owdmamhANv6rSZ3Q1ZAc9weqK3fRCbZDLkqIEPVCnM70
	 KxXMArvX3uinnb404BsUpr85ZGOphwDRaSTN4hxb5iyWxiHLku3b2aPAOVTbCTkmLB
	 4t1aLd2YoV7Uw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SbpDT5vH0zKdv;
	Thu, 23 Nov 2023 14:32:57 -0500 (EST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by lists.lttng.org (Postfix) with ESMTPS id 4SbpDS1vqqzKds
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 14:32:56 -0500 (EST)
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77d72aeae3bso44919285a.1
 for <lttng-dev@lists.lttng.org>; Thu, 23 Nov 2023 11:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700767975; x=1701372775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yipZyIMuVOvmkFGyuiDI/Ymf0x9QGBztTNUlbtS3r8=;
 b=mXJ97HjXF8jpNQ3rrna4fvN5wubfcPd5B/uEDF82Cv8HOelRd5hTUype9yhxv/j9Pj
 4F+dF/OmuLhwFBSQsp4YpdLSERX0fZdaHb8aeb9/ZsVyYYduD3RFBjD8+XxX1GP9V0zJ
 74yFpHzs0AG3+2ZIspSAoh53CjibUfG392isejccq6IAY+VjKyCQwjnj18doRoYu+Q+G
 LNHA+Fw4oBc+3v01YrYzMpn2Fn5dfl3lPdaCCVjjENhCtt6cG4an40EpPwBujYHsgPey
 hZW2zxANz5ffryLlE0jYZZQTeDXUQGZZgtFPTWGNCdi6Y/ME3urJV9vk4TAKLKXdOnIg
 isUA==
X-Gm-Message-State: AOJu0YwNM01U0PhIX9oyME//ac/FFxXnKGBJkishzPa7eewR6sBAv0af
 mq0Nwc4Lcb57eRxtPWTwlB59EMoGvchW7A==
X-Google-Smtp-Source: AGHT+IFALKFnTwLHkDqCTUIc93SJJOdNTnMard2MMg8t6turT6uOmA3j+0MuaxEI2NaXlDICpgrlfA==
X-Received: by 2002:a05:620a:8812:b0:77d:7b25:5c8e with SMTP id
 qj18-20020a05620a881200b0077d7b255c8emr344715qkn.70.1700767974735; 
 Thu, 23 Nov 2023 11:32:54 -0800 (PST)
Received: from localhost.localdomain ([174.112.183.231])
 by smtp.gmail.com with ESMTPSA id
 dt32-20020a05620a47a000b0077d71d46887sm662669qkb.112.2023.11.23.11.32.53
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:32:54 -0800 (PST)
To: lttng-dev@lists.lttng.org
Date: Thu, 23 Nov 2023 14:32:47 -0500
Message-Id: <20231123193249.3190764-1-bruce.ashfield@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH 1/3] statedump: adjust to v6.7 cpu topology
 struct
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

Adjusting the statedump to the following upstream commits:

  commit b9655e702dc5 [x86/cpu: Encapsulate topology information in cpuinfo_x86]
  commit e95256335d45 [x86/cpu: Move cpu_core_id into topology info]
  commit 02fb601d27a7 [x86/cpu: Move phys_proc_id into topology info]

We now have the topo struct, as well as some minor member name
changes.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
---

Someone else may or may not already have this in flight,
but I didn't see anything on the list or in the git
repo.

I ran into this failure when working on the v6.7-rc
kernel as part of yocto project kernel updates.

Tweak as necessary, as I'm no expert in the right way
to version these sort of changes.

Bruce

 include/instrumentation/events/lttng-statedump.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/instrumentation/events/lttng-statedump.h b/include/instrumentation/events/lttng-statedump.h
index 642aa356..5f52a29c 100644
--- a/include/instrumentation/events/lttng-statedump.h
+++ b/include/instrumentation/events/lttng-statedump.h
@@ -263,8 +263,13 @@ LTTNG_TRACEPOINT_EVENT(lttng_statedump_cpu_topology,
 		ctf_integer(uint8_t, family, c->x86)
 		ctf_integer(uint8_t, model, c->x86_model)
 		ctf_string(model_name, c->x86_model_id[0] ? c->x86_model_id : "unknown")
+#if (LTTNG_LINUX_VERSION_CODE < LTTNG_KERNEL_VERSION(6,7,0))
 		ctf_integer(uint16_t, physical_id, c->phys_proc_id)
 		ctf_integer(uint16_t, core_id, c->cpu_core_id)
+#else
+		ctf_integer(uint16_t, physical_id, c->topo.pkg_id)
+		ctf_integer(uint16_t, core_id, c->topo.core_id)
+#endif
 		ctf_integer(uint16_t, cores, c->booted_cores)
 	)
 )
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
