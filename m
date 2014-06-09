From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [lttng-tool] Fix: wrong casting of return value
Date: Mon, 9 Jun 2014 11:40:36 -0400
Message-ID: <1402328436-13404-1-git-send-email-jonathan.r.julien__36136.3934971907$1402328503$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1Wu1gj-00014K-Ca
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 11:40:50 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The function uri_parse_str_urls return a ssize_t and the return was
casted to a size_t. This caused the following error checking to fail as
-1 was interpreted as 18446744073709551615.

Fixes #803

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/lib/lttng-ctl/save.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/lib/lttng-ctl/save.c b/src/lib/lttng-ctl/save.c
index d136b2d..d414a9d 100644
--- a/src/lib/lttng-ctl/save.c
+++ b/src/lib/lttng-ctl/save.c
@@ -99,7 +99,8 @@ int lttng_save_session_attr_set_output_url(
 	struct lttng_save_session_attr *attr, const char *url)
 {
 	int ret = 0;
-	size_t len, size;
+	size_t len;
+	ssize_t size;
 	struct lttng_uri *uris = NULL;
 
 	if (!attr) {
-- 
2.0.0
