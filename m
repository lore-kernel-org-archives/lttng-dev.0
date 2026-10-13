Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84CFCC6B10
	for <lttng-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4j3x9r651Sz1dMT
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1791900754;
	b=AUCiFQeLedvxjw9xYI8VQdqQrdZM4zKO4zrH2KAGg0+6ep+YvFDlB/bjXyTyA8oMHx0s
	 X++jFiJ4Pc+YpB+7IqAD/2gLQoFWTgYmm4kPvpPlRwXiF7Hd0waSfV8+CLmqKgZVjLAXq
	 H1UoX2kZTsimvanI9RROeMT6go/98XwAh4Esa2/WS9bEKRiJH7PP/UrtGl5vxIbjMmLJ8
	 QYI7mv57z/WXvZJyc93Ht4CvYWyVbzw/BNqD0RpqgY/X3YcdAKO+ITUGPjhDiFnM14HZF
	 X+hshhk9Zj//Y1u6lRONe1dg+idrBgO4Ak6cry6U2Kw2Mv9g86P2f2Jsvb0glhqbEWw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1791900754;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=d4muYcg8ZUQHILcR4PNITQcugPxzVbnspnsK0kVbghY=;
	b=odFY2bDutTkWCSSkkx6lXx21ChHru6/x5NjyClun9FiKCSZ/2zeeN9W7doa9ZE9NC/oZ
	 hJIbHRm892kLEdrPoGhFqLLyPUz/jisg/yl56RND1F3y32XHv3ZFcRnNuVEjq9kVgU+ij
	 NxbTPGx34jZIo6II5twGu601ti7Eym6wo3PVaVIxATAux0up0eaGacOgXtgt1XGLQbwsk
	 eWUaVRKffSyaC/ACzXWu6ckncTfJOfPj62398ETEcuF5yuX6LnEY9CE2qhNAkGD+i5BkU
	 kIlJx8zwPLC5m3iiMEqbNfmRreLB+20lGQ0nwpd5F9HhGq6R6LRNxRGWf7/x2SqtJpw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4j3x9r651Sz1dMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1791900754;
	bh=nn7sg9h0/hAytSaIhs7HdLTHx5aQf1GPJfMMiCTeNXg=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Fn4bkFrvH4f4zPBKwmDEdaKIF7l61p2PU/Wuk2z8QW5lzL/Fg50HnbSTaKmCPJsM7
	 e0UR5/KdJLwcScjNyy9y5+596UdJ3ZvyKOyts6aXiN2CYRzjiydhazRVMIxSCII2Gb
	 J6buLf6qhBMXAUI6oTUJ5HSZHHSQqCJWs6M+pbJC89IHVPmkLXWkrcIihaHIHons/g
	 e1UmB2FjJUVHUZwKiKS6b0YKSgBwvoGWgAnnHrXNLQmzjEcAtoHpdra8G1NCkemMYQ
	 fxKqQBRJQZ65WZoV/2+qJcYybo818u7dK2TiWdV6O+35WXV8cWPsKLf7udhTgcWP55
	 96vTAfFfyj4jA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4j3x9r651Sz1dMT;
	Tue, 13 Oct 2026 10:12:32 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4j3pzl1xwmz1Zsw
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4j3pzl1xwmz1Zsw
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by lists.lttng.org (Postfix) with ESMTPS id 4j3pzl1xwmz1Zsw
 for <lttng-dev@lists.lttng.org>; Tue, 13 Oct 2026 05:33:22 -0400 (EDT)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2e7496f947so432095366b.1
 for <lttng-dev@lists.lttng.org>; Tue, 13 Oct 2026 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791884000; x=1792488800;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nn7sg9h0/hAytSaIhs7HdLTHx5aQf1GPJfMMiCTeNXg=;
 b=e/dyiZxUENrr6PhxrDJMLEky9TH9CpK6qs8L0/SSgJP5shAvsLvQtw+JaQQM4l/4du
 mvxgI9L1JR9jPboYPsYRlfk9gTS/ReTO1HItXo6tXOL8t0NXfHPIglmGEs6WzngJyIY6
 FQ+geV9+E1lfc6B9A88hHCyZz3QwATFZJnvs/GZgELtiUN40YN+j3IJj0szp5rDlTJnH
 9EvSlJmQwt28IyPLZ5zgrZHU+i6lrDhlvZ8yhDW9Ft+o2CDxkAnpAseFwBJfJ8Va2T5g
 0aUqnmQk/qtHKeQDPAC/3iwvmOBjR1e27FPJIqqKPPaJsxS1EU8l6q/IYgDXGVELbLJv
 x/3w==
X-Gm-Message-State: AFq9FYI3BcyTqTTC4g4gxruLlW40fSJcyT7OFhe6MFq7ahqsiRMaoMMQ
 s4swvJixW5qQei69xvxgajbNyYZ9Lp8fWQd9rcjALXC5/4F2BkH2XuC+LSdLAV9f3qE=
X-Gm-Gg: AYBFou3wIafuj9cMvwpTmBPHnntync1wtzRPTycNLJfFSekuYdZ5E5y8F0EcSSXl5rq
 2ivI0ok/BjjV7FX6h46sjmZzHw6SicV68sOzcGPjHNO/Hs5Nyr+ki75ue3tHnfLsd8dJW8JQ3Og
 cDcJSGsHOwoZ6rRcQgmOfFcv8rQzlVUrZ7R2fOliHSsuB2W+XI6Ng837xUU6xR/7xk/V1wrEQ6i
 T0VKLoaNs4pdzlkOZl6hgETjwJ1oybyyFwlodfTbFjrYl0Cn+COQzlMUSNBQRTXzhikS6fJVh1d
 iBqO7a/FA6F1bznSFvcXHlQOOgHCr5f+JZeYsRmjbg3MviXBVDCz2G7hRkWPcvdO1jwxQFn/p1S
 fbTCMgGkRgFV4VFaoZ17ubmaD1n3xeix9xYvzRK6FAxENPzJyGtw32uFLydocR/Gn38z8bZjuQX
 X/AAcE8rAqZrxyBp5uGX5KjrJp2YMkkZ3QZk30ujyXpafAsrU/VfdaQZE/jpi0f8O4Jerp9jMFa
 xSDceP+M+vGpW9P8Yu7VHHGqR8xqKAPKA==
X-Received: by 2002:a17:907:9709:b0:c2e:1b4d:e9f4 with SMTP id
 a640c23a62f3a-c31a9f68e76mr1241513166b.31.1791883999658; 
 Tue, 13 Oct 2026 02:33:19 -0700 (PDT)
Received: from hp-z640.fritz.box ([109.78.82.167])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9aa8511sm558244266b.59.2026.10.13.02.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:19 -0700 (PDT)
X-Google-Original-From: OOHehir <40183643+OOHehir@users.noreply.github.com>
To: lttng-dev@lists.lttng.org
Cc: OOHehir <oo.hehir@gmail.com>
Subject: [PATCH] Fix: tests: honour LTTNG_TOOLS_DISABLE_KERNEL_TESTS in two
 Python tests
Date: Tue, 13 Oct 2026 10:33:18 +0100
Message-ID: <20261013093318.202203-1-40183643+OOHehir@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 10:12:31 -0400
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
From: OOHehir via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: OOHehir <oo.hehir@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

From: OOHehir <oo.hehir@gmail.com>

OBSERVED ISSUE
━━━━━━━━━━━━━━
On a target without lttng-modules, kernel/test_event_disable.py & the
kernel cases of tools/save-load/test_save_load.py fail with "Kernel tracer
not available", although the test run sets LTTNG_TOOLS_DISABLE_KERNEL_TESTS=1.
Observed with the Yocto Project ptest on riscv64, which ships no lttng-modules.

CAUSE
━━━━━
Both scripts only check that they run as root before running kernel cases,
while the other Python tests use lttngtest._Environment.run_kernel_tests(),
which also honours LTTNG_TOOLS_DISABLE_KERNEL_TESTS.

SOLUTION
━━━━━━━━
Use run_kernel_tests() in both scripts. It checks for root as before, & also
honours LTTNG_TOOLS_DISABLE_KERNEL_TESTS.

Signed-off-by: OOHehir <oo.hehir@gmail.com>
---
 tests/regression/kernel/test_event_disable.py      | 7 ++-----
 tests/regression/tools/save-load/test_save_load.py | 9 ++++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/regression/kernel/test_event_disable.py b/tests/regression/kernel/test_event_disable.py
index da9f146..a373544 100755
--- a/tests/regression/kernel/test_event_disable.py
+++ b/tests/regression/kernel/test_event_disable.py
@@ -15,7 +15,6 @@ Validates that disabling events works correctly:
 - Disabling by name disables all matching rules regardless of filters
 """
 
-import os
 import pathlib
 import sys
 import traceback
@@ -307,11 +306,9 @@ if __name__ == "__main__":
         ),
     ]
 
-    is_root = os.getuid() == 0
-
-    if not is_root:
+    if not lttngtest._Environment.run_kernel_tests():
         tap = lttngtest.TapGenerator(len(kernel_tests))
-        tap.skip_all_remaining("Kernel tests require root privileges")
+        tap.skip_all_remaining("Kernel tests not enabled")
         sys.exit(0)
 
     tap = lttngtest.TapGenerator(len(kernel_tests))
diff --git a/tests/regression/tools/save-load/test_save_load.py b/tests/regression/tools/save-load/test_save_load.py
index 9dd8042..1983263 100755
--- a/tests/regression/tools/save-load/test_save_load.py
+++ b/tests/regression/tools/save-load/test_save_load.py
@@ -13,7 +13,6 @@ through save/load cycles, including:
 - Kernel syscalls and tracepoints
 """
 
-import os
 import pathlib
 import sys
 import traceback
@@ -953,11 +952,11 @@ if __name__ == "__main__":
         ),
     ]
 
-    is_root = os.getuid() == 0
+    run_kernel_tests = lttngtest._Environment.run_kernel_tests()
     allows_destructive = lttngtest._Environment.allows_destructive()
 
     total_tests = len(user_tests) + len(agent_tests)
-    if is_root:
+    if run_kernel_tests:
         total_tests += len(kernel_tests)
         if allows_destructive:
             total_tests += len(destructive_kernel_tests)
@@ -971,7 +970,7 @@ if __name__ == "__main__":
         for test_name, test_func, kwargs in agent_tests:
             run_test(tap, test_env, test_func, test_name, **kwargs)
 
-    if is_root:
+    if run_kernel_tests:
         with lttngtest.test_environment(
             with_sessiond=True, log=tap.diagnostic, enable_kernel_domain=True
         ) as test_env:
@@ -986,6 +985,6 @@ if __name__ == "__main__":
                     "Skipping destructive kernel tests (LTTNG_ENABLE_DESTRUCTIVE_TESTS not set)"
                 )
     else:
-        tap.diagnostic("Skipping kernel tests (not running as root)")
+        tap.diagnostic("Skipping kernel tests (not enabled)")
 
     sys.exit(0 if tap.is_successful else 1)
-- 
2.43.0

