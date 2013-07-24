From: Zifei Tong <soariez@gmail.com>
Subject: [PATCH lttng-ust 3/3] Update .gitignore
Date: Wed, 24 Jul 2013 13:55:47 +0800
Message-ID: <1374645347-20312-3-git-send-email-soariez__7862.05474655635$1374645595$gmane$org@gmail.com>
References: <1374645347-20312-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1V1s3t-0007qF-3q
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 01:56:38 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so247974pad.4
	for <lttng-dev@lists.lttng.org>; Tue, 23 Jul 2013 22:56:27 -0700 (PDT)
In-Reply-To: <1374645347-20312-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 3d17940..07d1306 100644
--- a/.gitignore
+++ b/.gitignore
@@ -34,6 +34,8 @@ ust-consumerd/ust-consumerd
 doc/examples/demo/demo
 doc/examples/easy-ust/sample
 doc/examples/hello-static-lib/hello
+doc/examples/gen-tp/sample
+doc/examples/gen-tp/sample_tracepoint.h
 
 tests/hello/hello
 tests/hello.cxx/hello
@@ -44,3 +46,5 @@ tests/trace_event/trace_event_test
 tests/tracepoint/benchmark/tracepoint_benchmark
 tests/tracepoint/tracepoint_test
 tests/snprintf/prog
+tests/benchmark/bench1
+tests/benchmark/bench2
-- 
1.8.3.3
