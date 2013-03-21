From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 6/6] Tests: Do not exit when a
	failure occurs in test_buffers_uid
Date: Thu, 21 Mar 2013 15:56:47 -0400
Message-ID: <1363895807-17892-6-git-send-email-christian.babeux__42742.0666594573$1363895911$gmane$org@efficios.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIlcS-0006jp-0Q
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 15:57:48 -0400
Received: by mail-ia0-f169.google.com with SMTP id j5so2934915iaf.0
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 12:57:42 -0700 (PDT)
In-Reply-To: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/ust/buffers-uid/test_buffers_uid | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/regression/ust/buffers-uid/test_buffers_uid b/tests/regression/ust/buffers-uid/test_buffers_uid
index 1c590f2..215a060 100755
--- a/tests/regression/ust/buffers-uid/test_buffers_uid
+++ b/tests/regression/ust/buffers-uid/test_buffers_uid
@@ -230,11 +230,6 @@ start_lttng_sessiond
 while [ $i -lt $TEST_COUNT ]; do
 	TRACE_PATH=$(mktemp -d)
 	${TESTS[$i]}
-	if [ $? -ne 0 ]; then
-		stop_lttng_sessiond
-		exit 1
-	fi
-
 	rm -rf $TRACE_PATH
 	let "i++"
 done
-- 
1.8.1.3
