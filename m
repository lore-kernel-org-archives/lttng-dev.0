Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC961C433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 19 May 2022 15:03:03 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4L3tQG1kZhz1PWC;
	Thu, 19 May 2022 11:03:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1652972582;
	bh=9IJOFCe/Za8B1fl2criGkUX1fX6/2+Z/Vo2SB4wrwHQ=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=xz/hZr9F8RuEwYe1i1ihe1578YohF8JVN2eRuo9ox0P8KMgv906EScKjsDMoKPSKL
	 8aj2i3GaqiEGw4xkWDy13OTGTXwJTCqX0ZFrwgL0/7aeB15a6bwTWD/GaewxB4f97s
	 EfXA8qpmlM6dUfRDrb7Er4keZDhPhymi+dGu8k6TpgoxymU3lrg9QNqwLEt4mmDLs4
	 tY6Gl07i8Wb44U+R4+8FcHy0C3t/ffGoYFNp9+341R1WsofYc2RTV5CHw1Oj1fw9zv
	 GVzEtBlbxOMxDxOS1dW5jb2YzVSGCcKa6SPAwzcZnTjn/ULf89jnaT9Rjz1Cgcl5LG
	 eBz3SBHs+AH/g==
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by lists.lttng.org (Postfix) with ESMTPS id 4L3tQD5my8z1Q2Z
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2022 11:03:00 -0400 (EDT)
Received: by mail-qt1-x830.google.com with SMTP id 11so2712493qtp.9
 for <lttng-dev@lists.lttng.org>; Thu, 19 May 2022 08:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Hx9EGZbANo20AbGG7gdIjXSDUKKHxXvzZFI6dulnlIo=;
 b=bHKHhk1jIs10xrkoz5Z2LhfO5zPBxFDHOJfbClXtElquRGhurT/C6BAinJFeEa4QAA
 NEbJS06P4YCOIUOCJJg4hSu1pjQ6ZUrbqAVAxCiIWF4TjDUrCYnhVgV6Liihnx/DURDK
 bVl3ZDGGfv7oEPi21uiFi4u4py29qy8Xa6f4RC2QZrthaG4LKwMwVafuzTopymC3jKM7
 S0X5Y6QsVqkno1bljzzknN30+vtF6cooIKNf4Sy/+wpBIkOIcFfLU9acESrTtbLItJg8
 fMacpocnnYfNtYRQB5FfOnwBrdT4eCD/VfSOlrN+wNV9d/POxrndBbAkBHA/lPR7l0aR
 wigg==
X-Gm-Message-State: AOAM533WqMrnYru8Zoh9hWrrQIl6F998tYEEZA0zoU3QZ7nKHK7GrDZf
 xZSDUh/43wbMQXjZmTiu2LeLs+LuqDc2fQ==
X-Google-Smtp-Source: ABdhPJwHnF2jV3AU/m/2Z4Nu4R619zRvMxCQSysD1fePbViG3Dfv6F8zUDjMwxYjmDR/9ZRZnPRS2A==
X-Received: by 2002:ac8:5cd1:0:b0:2f9:b8c:e2b2 with SMTP id
 s17-20020ac85cd1000000b002f90b8ce2b2mr4148236qta.614.1652972579678; 
 Thu, 19 May 2022 08:02:59 -0700 (PDT)
Received: from build.lan ([173.34.88.218]) by smtp.gmail.com with ESMTPSA id
 k128-20020a37ba86000000b0069c72b41b59sm1461531qkf.2.2022.05.19.08.02.58
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 08:02:59 -0700 (PDT)
To: lttng-dev@lists.lttng.org
Date: Thu, 19 May 2022 11:02:57 -0400
Message-Id: <20220519150257.26136-1-bruce.ashfield@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH] sched/tracing: fix __trace_sched_switch_state
 (5.18-rc7+)
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

The commit [fix: sched/tracing: Don't re-read p->state when emitting
sched_switch event (v5.18)] was correct, but the kernel changed their
mind with the following commit:

   commit 9c2136be0878c88c53dea26943ce40bb03ad8d8d
   Author: Delyan Kratunov <delyank@fb.com>
   Date:   Wed May 11 18:28:36 2022 +0000

       sched/tracing: Append prev_state to tp args instead

       Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
       sched_switch event, 2022-01-20) added a new prev_state argument to the
       sched_switch tracepoint, before the prev task_struct pointer.

       This reordering of arguments broke BPF programs that use the raw
       tracepoint (e.g. tp_btf programs). The type of the second argument has
       changed and existing programs that assume a task_struct* argument
       (e.g. for bpf_task_storage access) will now fail to verify.

       If we instead append the new argument to the end, all existing programs
       would continue to work and can conditionally extract the prev_state
       argument on supported kernel versions.

       Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting sched_switch event, 2022-01-20)
       Signed-off-by: Delyan Kratunov <delyank@fb.com>
       Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
       Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
       Link: https://lkml.kernel.org/r/c8a6930dfdd58a4a5755fc01732675472979732b.camel@fb.com

By reordering the parameters (again) we can get back up and building.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
---

Hi all,

This is more than likely NOT a correct fix, but while working on the
yocto -dev reference kernel, I ran into this build failure against
5.18-rc7.

I didn't see any sign of another fix on the mailing list, so I wanted
to send this in case anyone else runs into the failure and to check
to see if there's a better fix in progress.

Cheers,

Bruce


 include/instrumentation/events/sched.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/instrumentation/events/sched.h b/include/instrumentation/events/sched.h
index 339bec9..f9e9c38 100644
--- a/include/instrumentation/events/sched.h
+++ b/include/instrumentation/events/sched.h
@@ -23,8 +23,9 @@
 #if (LTTNG_LINUX_VERSION_CODE >= LTTNG_KERNEL_VERSION(5,18,0))
 
 static inline long __trace_sched_switch_state(bool preempt,
-		unsigned int prev_state,
-		struct task_struct *p)
+		struct task_struct *p,
+		struct task_struct *n,
+		unsigned int prev_state )
 {
         unsigned int state;
 
@@ -356,20 +357,20 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(sched_wakeup_template, sched_wakeup_new,
 LTTNG_TRACEPOINT_EVENT(sched_switch,
 
 	TP_PROTO(bool preempt,
-		unsigned int prev_state,
 		struct task_struct *prev,
-		struct task_struct *next),
+		struct task_struct *next,
+		unsigned int prev_state),
 
-	TP_ARGS(preempt, prev_state, prev, next),
+	TP_ARGS(preempt, prev, next, prev_state),
 
 	TP_FIELDS(
 		ctf_array_text(char, prev_comm,	prev->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, prev_tid, prev->pid)
 		ctf_integer(int, prev_prio, prev->prio - MAX_RT_PRIO)
 #ifdef CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM
-		ctf_enum(task_state, long, prev_state, __trace_sched_switch_state(preempt, prev_state, prev))
+		ctf_enum(task_state, long, prev_state, __trace_sched_switch_state(preempt, prev, next, prev_state))
 #else
-		ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev_state, prev))
+		ctf_integer(long, prev_state, __trace_sched_switch_state(preempt, prev, next, prev_state))
 #endif
 		ctf_array_text(char, next_comm, next->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, next_tid, next->pid)
-- 
2.19.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
