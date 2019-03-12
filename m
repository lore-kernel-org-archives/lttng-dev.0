From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: test: unit: the tree
 origin can be a symlink itself
Date: Tue, 12 Mar 2019 14:30:31 -0400
Message-ID: <20190312183031.20265-2-jonathan.rajotte-julien__20007.4083217018$1552415487$gmane$org@efficios.com>
References: <20190312183031.20265-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Jk746cMjz16Bp
 for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2019 14:30:40 -0400 (EDT)
In-Reply-To: <20190312183031.20265-1-jonathan.rajotte-julien@efficios.com>
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Problem:

The base tree is defined as "/tmp/.....XXXXXX".
On systems where "/tmp/" is itself a symlink utils_expand_path will
expand the tree origin itself.

For example on a base core-image-minimal Yocto build /tmp is a symlink
to "/var/tmp", which is a symlink to "/var/volatile".

utils_expand_path will return something like this for the symlink test:
"/var/volative/.....XXXXXX/...." which is the valid result.

Solution:

Simply use realpath on the tree_origin and use this path to perform the
test validation.

This work was performed in the effort to support yocto fully and be able
to run the test suite to detect problem as early as possible.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/unit/test_utils_expand_path.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_utils_expand_path.c
index d5cab002e..d047c207d 100644
--- a/tests/unit/test_utils_expand_path.c
+++ b/tests/unit/test_utils_expand_path.c
@@ -281,8 +281,8 @@ error:
 static void test_utils_expand_path(void)
 {
 	char *result;
-	char name[100], tmppath[PATH_MAX];
-	int i;
+	char name[100], tmppath[PATH_MAX], real_tree_origin[PATH_MAX];
+	int i, treelen;
 
 	/* Test valid cases */
 	for (i = 0; i < num_valid_tests; i++) {
@@ -295,14 +295,24 @@ static void test_utils_expand_path(void)
 		free(result);
 	}
 
+	/*
+	 * Get the realpath for the tree_origin since it can itself be a
+	 * symlink.
+	 */
+	result = realpath(tree_origin, real_tree_origin);
+	if (!result) {
+		fail("realpath failed.");
+		return;
+	}
+
 	/* Test symlink tree cases */
-	int treelen = strlen(tree_origin) + 1;
+	treelen = strlen(real_tree_origin) + 1;
 	for (i = 0; i < num_symlink_tests; i++) {
 		sprintf(name, "symlink tree test case: [tmppath/]%s",
 				symlink_tests_inputs[i].input);
 
 		snprintf(tmppath, PATH_MAX, "%s/%s",
-				tree_origin, symlink_tests_inputs[i].input);
+				real_tree_origin, symlink_tests_inputs[i].input);
 		result = utils_expand_path(tmppath);
 		ok(result != NULL && strcmp(result + treelen,
 					symlink_tests_inputs[i].expected_result) == 0, name);
-- 
2.17.1
