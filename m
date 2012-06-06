From: Danny Serres <serres@live.ca>
Subject: [lttng-tools PATCH] Move metset in channel_set_attr
	after the null check
Date: Wed,  6 Jun 2012 14:54:30 -0400
Message-ID: <1339008870-4891-1-git-send-email-serres__15358.4463442259$1339010274$gmane$org@live.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1ScLNL-0005iQ-7U
	for lttng-dev@lists.lttng.org; Wed, 06 Jun 2012 14:54:35 -0400
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

Signed-off-by: Danny Serres <serres@live.ca>
---
 src/lib/lttng-ctl/lttng-ctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 36069ef..356fb34 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -885,13 +885,13 @@ int lttng_calibrate(struct lttng_handle *handle,
 void lttng_channel_set_default_attr(struct lttng_domain *domain,
 		struct lttng_channel_attr *attr)
 {
-	memset(attr, 0, sizeof(struct lttng_channel_attr));
-
 	/* Safety check */
 	if (attr == NULL || domain == NULL) {
 		return;
 	}
 
+	memset(attr, 0, sizeof(struct lttng_channel_attr));
+
 	switch (domain->type) {
 	case LTTNG_DOMAIN_KERNEL:
 		attr->overwrite = DEFAULT_CHANNEL_OVERWRITE;
-- 
1.7.9.5
