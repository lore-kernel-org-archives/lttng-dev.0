From: Omair Majid <omajid@redhat.com>
Subject: [PATCH lttng-ust] Fix: address shellcheck
 warnings/errors in example scripts
Date: Thu, 11 Oct 2018 16:45:29 -0400
Message-ID: <20181011204529.GA3421__43438.9480659322$1539290621$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by lists.lttng.org (Postfix) with ESMTPS id 42WNJy3XnQz13WX
 for <lttng-dev@lists.lttng.org>; Thu, 11 Oct 2018 16:45:38 -0400 (EDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4007C30BF46F
 for <lttng-dev@lists.lttng.org>; Thu, 11 Oct 2018 20:45:37 +0000 (UTC)
Received: from redhat.com (ovpn-123-39.rdu2.redhat.com [10.10.123.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 984CA76516
 for <lttng-dev@lists.lttng.org>; Thu, 11 Oct 2018 20:45:36 +0000 (UTC)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline



--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-Fix-address-shellcheck-warnings-errors-in-example-sc.patch"

From 377e35cdcc5ec057dd48accccc619b7ba295a59b Mon Sep 17 00:00:00 2001
From: Omair Majid <omajid@redhat.com>
Date: Thu, 11 Oct 2018 14:28:49 -0400
Subject: [PATCH lttng-ust] Fix: address shellcheck warnings/errors in example
 scripts

ShellCheck points out a number of warnings in the example scripts. In
particular, a number of normal and special shell variables are not
quoted correctly.

Signed-off-by: Omair Majid <omajid@redhat.com>
---
 doc/examples/clock-override/run-clock-override   | 6 +++---
 doc/examples/demo/demo-trace                     | 6 +++---
 doc/examples/getcpu-override/run-getcpu-override | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/examples/clock-override/run-clock-override b/doc/examples/clock-override/run-clock-override
index 295b4839..3c7f82be 100755
--- a/doc/examples/clock-override/run-clock-override
+++ b/doc/examples/clock-override/run-clock-override
@@ -2,7 +2,7 @@
 
 # launch with: run-clock-override progname args
 
-DIR=$(dirname $0)
-DIR=$(readlink -f $DIR)
+DIR=$(dirname "$0")
+DIR=$(readlink -f "$DIR")
 
-LTTNG_UST_CLOCK_PLUGIN="$DIR/lttng-ust-clock-override-example.so" ${*}
+LTTNG_UST_CLOCK_PLUGIN="$DIR/lttng-ust-clock-override-example.so" "${@}"
diff --git a/doc/examples/demo/demo-trace b/doc/examples/demo/demo-trace
index dd677277..000139b8 100755
--- a/doc/examples/demo/demo-trace
+++ b/doc/examples/demo/demo-trace
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-DIR=$(dirname $0)
-DIR=$(readlink -f $DIR)
+DIR=$(dirname "$0")
+DIR=$(readlink -f "$DIR")
 
-LD_PRELOAD=$DIR/lttng-ust-provider-ust-tests-demo.so:$DIR/lttng-ust-provider-ust-tests-demo3.so $DIR/demo ${*}
+LD_PRELOAD="$DIR/lttng-ust-provider-ust-tests-demo.so:$DIR/lttng-ust-provider-ust-tests-demo3.so" "$DIR/demo" "${@}"
diff --git a/doc/examples/getcpu-override/run-getcpu-override b/doc/examples/getcpu-override/run-getcpu-override
index d0532334..3602c249 100755
--- a/doc/examples/getcpu-override/run-getcpu-override
+++ b/doc/examples/getcpu-override/run-getcpu-override
@@ -2,7 +2,7 @@
 
 # launch with: run-getcpu-override progname args
 
-DIR=$(dirname $0)
-DIR=$(readlink -f $DIR)
+DIR=$(dirname "$0")
+DIR=$(readlink -f "$DIR")
 
-LTTNG_UST_GETCPU_PLUGIN="$DIR/lttng-ust-getcpu-override-example.so" ${*}
+LTTNG_UST_GETCPU_PLUGIN="$DIR/lttng-ust-getcpu-override-example.so" "${@}"
-- 
2.17.1


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--mYCpIKhGyMATD0i+--
