Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0BFC19F28
	for <lttng-dev@archiver.kernel.org>; Wed,  3 Aug 2022 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659554623;
	bh=CRqrpkXaIoNPyulUwrBJIv7sixrJTDVO433w4Y5GZLs=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=USdsK8KIDGZ7Mh2kz4p2gKMAEEUJu7+b7FfzomefAcyhYOvstqfvvCYBWJTFMdPsy
	 5gDNi/cuUDEoNwwN5zwqMgeIlR2vQo4IapFqBZ4N/k+gP2fHrMRuLXl5TtzuVkb603
	 wHZCGDv+zV8sD5OLXOZyMuM2Pcrgk0LpNRz+kXHOi0CMX02Ubpm5xnyMb1tdgAejLi
	 6ENKPYlL3cR4UKVponI8PIF1SW+6bXgo4sTLxJnbJMRcmQvPDBwz28l6kIzZvnGptn
	 0s5haB6s+ofjzWJ7SsJNnXpPwMJ9Dn6PS85r/Sp4gzlQN5C1xVrgv3A6OI0BSk3Bwn
	 g4Xh+0zSGgU8A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Lyhby3sPVz11yS;
	Wed,  3 Aug 2022 15:23:42 -0400 (EDT)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by lists.lttng.org (Postfix) with ESMTPS id 4Lyhbw4q2gz121d
 for <lttng-dev@lists.lttng.org>; Wed,  3 Aug 2022 15:23:30 -0400 (EDT)
Received: by mail-qk1-x72f.google.com with SMTP id w6so3563589qkf.3
 for <lttng-dev@lists.lttng.org>; Wed, 03 Aug 2022 12:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xR5winCx2WHg9p/im3K33BrRrpjbQS7xCQpEvbSaD/4=;
 b=pvqlSBnoYzh7karjKXetMMKVPWEiJqAyWJvSkGZXtUIgCE3dEXXWElCTOjr1lob2sC
 Rb1N1a3/HfiMcoEy890dulDh2sFhi+M4VPfoPPtdJ8E49E+ZKuhUXj7Q+JR2h+dmZxYV
 AWPlgSidv4Cywys4oV+J8jF7xZUGHjplc/f4SrvuOng9lb3swJRMlyQlPVWnDqzZ/+Mq
 8j5xeVN8t5kxeAdVBTF78kBdoLsUBJIbbLHohTKsm4rhyCcfpVWUvABKd/1tO17YEkLJ
 7fJxXgB9+HLf9n0sVPgRXGFaDtRHqu7OaBqltsd7BDujn0Ta11WJtC9jhRUi0rGsVjh1
 tr/A==
X-Gm-Message-State: AJIora+1c5aJtoGzXD3b2k6b8ovSNa/OssWUQjUF5MD1Kdy/0YBqTYtJ
 6ElvlUvk/XiqoaZ6YCGaVJOkt+Iqz/83Gw==
X-Google-Smtp-Source: AGRyM1smzBfX7Fn0xTDWQFeFOzTzoxNDUkazTEH5zXa7lgl1QSMRQp+C5Wj3OF6eg/Dy9k7nf1Q7Sg==
X-Received: by 2002:a05:620a:29d6:b0:6b5:bd2a:7d6c with SMTP id
 s22-20020a05620a29d600b006b5bd2a7d6cmr19066707qkp.322.1659554609164; 
 Wed, 03 Aug 2022 12:23:29 -0700 (PDT)
Received: from localhost.localdomain ([173.34.88.218])
 by smtp.gmail.com with ESMTPSA id
 bj3-20020a05620a190300b006b5ee4de4fbsm7791783qkb.37.2022.08.03.12.23.27
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Aug 2022 12:23:28 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  3 Aug 2022 15:23:27 -0400
Message-Id: <20220803192327.3726094-1-bruce.ashfield@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] compaction: make tracepoints condtional on
 CONFIG_COMPACTION
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

When building against a v5.19 mips kernel, the following errors
were triggered:

  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:105:42: note: expected 'struct compact_control *' but argument is of type 'struct compact_control *'
  |   105 |         TP_PROTO(struct compact_control *cc,
  |       |                  ~~~~~~~~~~~~~~~~~~~~~~~~^~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:779:68: note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
  |   779 | static inline size_t __event_get_align__##_name(void *__tp_locvar, _proto)    \
  |       |                                                                    ^~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:106:50: note: in expansion of macro 'PARAMS'
  |   106 |         LTTNG_TRACEPOINT_EVENT_CLASS_CODE(_name, PARAMS(_proto), PARAMS(_args), , , \
  |       |                                                  ^~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:41:9: note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
  |    41 |         LTTNG_TRACEPOINT_EVENT_CLASS(map,                               \
  |       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:42:30: note: in expansion of macro 'PARAMS'
  |    42 |                              PARAMS(proto),                             \
  |       |                              ^~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:101:1: note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
  |   101 | LTTNG_TRACEPOINT_EVENT_MAP(mm_compaction_migratepages,
  |       | ^~~~~~~~~~~~~~~~~~~~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:105:9: note: in expansion of macro 'TP_PROTO'
  |   105 |         TP_PROTO(struct compact_control *cc,
  |       |         ^~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:112:57: error: invalid use of undefined type 'struct compact_control'

...

  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:108:25: warning: 'struct compact_control' declared inside parameter list will not be visible outside of this definition or declaration
  |   108 |         TP_PROTO(struct compact_control *cc,
  |       |                         ^~~~~~~~~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:159:43: note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP'
  |   159 | void __event_template_proto___##_template(_proto);
  |       |                                           ^~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:45:61: note: in expansion of macro 'PARAMS'
  |    45 |         LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto), PARAMS(args))
  |       |                                                             ^~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:104:1: note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
  |   104 | LTTNG_TRACEPOINT_EVENT_MAP(mm_compaction_migratepages,
  |       | ^~~~~~~~~~~~~~~~~~~~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/instrumentation/events/compaction.h:108:9: note: in expansion of macro 'TP_PROTO'
  |   108 |         TP_PROTO(struct compact_control *cc,
  |       |         ^~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:159:6: error: conflicting types for '__event_template_proto___compaction_migratepages'; have 'void(struct compact_control *, unsigned int)'
  |   159 | void __event_template_proto___##_template(_proto);
  |       |      ^~~~~~~~~~~~~~~~~~~~~~~~~
  | lttng-modules-2.13.4/src/probes/../../include/lttng/tracepoint-event-impl.h:45:9: note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP'
  |    45 |         LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto), PARAMS(args))
  |       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The root cause appears to be that this particular mips kernel does not
have CONFIG_COMPACTION avaiable, and hence we end up with the struct
declaration within this tracepoint, and then conflicting types.

While putting the conditional around only compaction_migratepages seemed
sufficient to get the build working, it doesn't look like any of the
tracepoints should be valid, so we extend it to all definitions.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
---

Hi all,

This was found during the update of the yocto project reference
kernel to 5.19. Out of all the supported architectures, only
mips failed during the build of lttng-modules.

Specifically, it seems like the lack of CONFIG_COMPACTION being
enabled in the kernel was the significant issue. Only one of the
tracepoints blew up, but I can't see how any of them would be
valid in this scenario, or why it would be limited to mips.

While I don't think this is the right fix, this is what got me
up and passing sanity testing, so I wanted to send the change
and see what the actual, correct fix would be :)

Cheers,

Bruce


 include/instrumentation/events/compaction.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/instrumentation/events/compaction.h b/include/instrumentation/events/compaction.h
index ecae39a..155804a 100644
--- a/include/instrumentation/events/compaction.h
+++ b/include/instrumentation/events/compaction.h
@@ -9,6 +9,8 @@
 #include <linux/types.h>
 #include <lttng/kernel-version.h>
 
+#ifdef CONFIG_COMPACTION
+
 #if LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(4,0,0)
 
 LTTNG_TRACEPOINT_EVENT_CLASS(compaction_isolate_template,
@@ -97,6 +99,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(compaction_isolate_template,
 
 #endif /* #else #if LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(4,0,0) */
 
+
 #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0))
 LTTNG_TRACEPOINT_EVENT_MAP(mm_compaction_migratepages,
 
@@ -182,6 +185,8 @@ LTTNG_TRACEPOINT_EVENT_MAP(mm_compaction_migratepages,
 )
 #endif /* #else #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(3,16,0)) */
 
+#endif /* CONFIG_COMPACTION */
+
 #endif /* LTTNG_TRACE_COMPACTION_H */
 
 /* This part must be outside protection */
-- 
2.25.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
