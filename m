From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Test: mi: test for greater or equal
	to a minimum of events on ust listing.
Date: Wed, 10 Jun 2015 11:27:41 -0400
Message-ID: <1433950061-27364-1-git-send-email-jonathan.rajotte-julien__7115.7468054027$1433950183$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Z2hvO-0005XM-FT
 for lttng-dev@lists.lttng.org; Wed, 10 Jun 2015 11:28:26 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Since the number of events present in the tests apps in prone to change it
make more sense to look for a minimum of events. This is less rigourous
but more flexible to change.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/tools/mi/test_mi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/mi/test_mi
index ccf9236..c44b598 100755
--- a/tests/regression/tools/mi/test_mi
+++ b/tests/regression/tools/mi/test_mi
@@ -328,7 +328,7 @@ function test_ust_lttng_event ()
 	$XML_VALIDATE $OUTPUT_DEST
 	ok $? "Mi test: Multiple enable ust event with inside fail xsd validation"
 
-	#Check for 2 success = true et 1 false
+	#Check for 2 success = true and 1 success = false
 	extract_xml $OUTPUT_DEST $XPATH_ENABLE_EVENT_SUCCESS result
 	num_ocur=$(grep -o "true" <<< "$result" | wc -l)
 	test "$num_ocur" -eq "2"
@@ -511,16 +511,21 @@ function test_list_ust_event ()
 	$XML_VALIDATE $OUTPUT_DEST
 	ok $? "Mi test: list ust event xsd validation"
 
-	#Extract events 5 events should be present
+	#Extract events
 	extract_xml $OUTPUT_DEST "$XPATH_LIST_UST_EVENT""/name/text()" result
 	num=$(echo "$result" | wc -l)
-	test "$num" -eq "5"
+
+	#Since the number of events is prone to change we only look for >= from a
+	#base number. An alternative would be to look for each events but this
+	#is complicated for nothing.
+	test "$num" -ge "5"
 	ok $? "Mi test: $num / 5 ust events discovered"
 
-	#Extract field from tp:tptest event. Expect 12
+	#Extract field from tp:tptest event. Expect >= to 12 because number of
+	#field is prone to change.
 	extract_xml $OUTPUT_DEST "$XPATH_LIST_UST_EVENT""[./name = 'tp:tptest']/event_fields/event_field/name/text()" result
 	num=$(echo "$result" | wc -l)
-	test "$num" -eq "12"
+	test "$num" -ge "12"
 	ok $? "Mi test: $num / 12 ust event fields discovered"
 
 	#Wait for all background processes
-- 
2.1.4
