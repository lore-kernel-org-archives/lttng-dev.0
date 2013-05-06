From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Tests: Add missing
	test_utils_parse_size_suffix to unit tests
Date: Mon,  6 May 2013 11:32:07 -0400
Message-ID: <1367854327-17078-1-git-send-email-christian.babeux__10284.8975839608$1367854399$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UZNP6-00076E-Hz
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 11:32:40 -0400
Received: by mail-qa0-f45.google.com with SMTP id hu16so1528546qab.11
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 08:32:35 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/unit_tests | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/unit_tests b/tests/unit_tests
index d7c68b6..6bf33cc 100644
--- a/tests/unit_tests
+++ b/tests/unit_tests
@@ -2,3 +2,4 @@ unit/test_kernel_data
 unit/test_session
 unit/test_uri
 unit/test_ust_data
+unit/test_utils_parse_size_suffix
-- 
1.8.2.2
