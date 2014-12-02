From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/4] Fix: tests: integer too large
	for long type
Date: Tue,  2 Dec 2014 17:21:12 -0500
Message-ID: <1417558872-25339-4-git-send-email-mathieu.desnoyers__20189.7460422062$1417558987$gmane$org@efficios.com>
References: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xvvp4-0005MN-VM
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 17:21:31 -0500
In-Reply-To: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Compiler warns on 32-bit builds.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tests/unit/test_utils_parse_size_suffix.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/test_utils_parse_size_suffix.c
index 2d3bbfc..a950a08 100644
--- a/tests/unit/test_utils_parse_size_suffix.c
+++ b/tests/unit/test_utils_parse_size_suffix.c
@@ -43,7 +43,7 @@ static struct valid_test_input valid_tests_inputs[] = {
 		{ "128K", 131072 },
 		{ "0x1234k", 4771840 },
 		{ "32M", 33554432 },
-		{ "1024G", 1099511627776 },
+		{ "1024G", 1099511627776ULL },
 		{ "0X400", 1024 },
 		{ "0x40a", 1034 },
 		{ "0X40b", 1035 },
@@ -66,15 +66,15 @@ static struct valid_test_input valid_tests_inputs[] = {
 		{ "0X0K", 0 },
 		{ "0x0M", 0 },
 		{ "0X0G", 0 },
-		{ "0X40G", 68719476736 },
+		{ "0X40G", 68719476736ULL },
 		{ "0300k", 196608 },
 		{ "0300K", 196608 },
 		{ "030M", 25165824 },
-		{ "020G", 17179869184 },
+		{ "020G", 17179869184ULL },
 		{ "0xa0k", 163840 },
 		{ "0xa0K", 163840 },
 		{ "0XA0M", 167772160 },
-		{ "0xA0G", 171798691840 },
+		{ "0xA0G", 171798691840ULL },
 };
 static const int num_valid_tests = sizeof(valid_tests_inputs) / sizeof(valid_tests_inputs[0]);
 
-- 
2.1.1
