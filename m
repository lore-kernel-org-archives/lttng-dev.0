From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Tests: Add filtering tests for
	uncovered cases
Date: Wed, 31 Oct 2012 09:00:45 -0400
Message-ID: <1351688445-18551-1-git-send-email-christian.babeux__42875.2148677178$1351688528$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TTXuv-0000im-2e
	for lttng-dev@lists.lttng.org; Wed, 31 Oct 2012 09:01:09 -0400
Received: by mail-ia0-f176.google.com with SMTP id h11so1120396iae.35
	for <lttng-dev@lists.lttng.org>; Wed, 31 Oct 2012 06:01:03 -0700 (PDT)
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

While investigating the code coverage of the filtering feature,
a couple of possible tests cases were uncovered:

Error tests:
* Strings can't be IR root node
* Unary ! not allowed on string type
* Comparison with string type not allowed
* Logical operator not allowed with string types
* Nesting of binary operator not allowed

Valid tests:
* Cover all left/right operands permutations with
  fields ref. and numeric values.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/filtering/invalid-filters | 15 +++++++++++++++
 tests/tools/filtering/valid-filters   |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/tests/tools/filtering/invalid-filters b/tests/tools/filtering/invalid-filters
index d0777e5..b653705 100755
--- a/tests/tools/filtering/invalid-filters
+++ b/tests/tools/filtering/invalid-filters
@@ -118,6 +118,21 @@ INVALID_FILTERS=(
 		"!a.f.d"
 		"asdf.asdfsd.sadf < 4"
 		"asdfasdf->asdfasdf < 2"
+		# String can't be root node
+		"\"somestring\""
+		# Unary op on string not allowed
+		"!\"somestring\""
+		# Comparison with string type not allowed
+		"\"somestring\" > 42"
+		"\"somestring\" > 42.0"
+		"42 > \"somestring\""
+		"42.0 > \"somestring\""
+		# Logical operator with string type not allowed
+		"\"somestring\" || 1"
+		"1 || \"somestring\""
+		# Nesting of binary operator not allowed
+		"1 | (1 | (1 | 1))"
+		"1 > (1 > (1 > 1))"
 		)
 
 start_lttng_sessiond
diff --git a/tests/tools/filtering/valid-filters b/tests/tools/filtering/valid-filters
index b48b6ed..d32a60d 100755
--- a/tests/tools/filtering/valid-filters
+++ b/tests/tools/filtering/valid-filters
@@ -361,6 +361,8 @@ FILTERS=("intfield"                                                     #1
 	 "intfield < 0x2"                                               #24
 	 "intfield < 02"                                                #25
 	 "stringfield2 == \"\\\*\""                                     #26
+	 "1.0 || intfield || 1.0"                                       #27
+	 "1 < intfield"                                                 #28
 )
 
 VALIDATOR=("validator_intfield"                     #1
@@ -389,6 +391,8 @@ VALIDATOR=("validator_intfield"                     #1
 	   "validator_intfield_lt"                  #24
 	   "validator_intfield_lt"                  #25
 	   "validator_true_statement"               #26
+	   "validator_true_statement"               #27
+	   "validator_intfield_gt"                  #28
 )
 
 FILTER_COUNT=${#FILTERS[@]}
-- 
1.8.0
