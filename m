From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 18/28] Copy exclusion data in
	shadow_copy_event
Date: Thu,  7 Nov 2013 12:21:42 +0200
Message-ID: <1383819703-6793-9-git-send-email-jp_ikaheimonen__25825.6756853827$1383819938$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMj1-0007Xg-6L
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:07 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMiv-0006E3-M9 from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:01 -0800
In-Reply-To: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/ust-app.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index adb31e8..255a41b 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1410,6 +1410,8 @@ error:
 static void shadow_copy_event(struct ust_app_event *ua_event,
 		struct ltt_ust_event *uevent)
 {
+	size_t exclusion_alloc_size;
+
 	strncpy(ua_event->name, uevent->attr.name, sizeof(ua_event->name));
 	ua_event->name[sizeof(ua_event->name) - 1] = '\0';
 
@@ -1423,6 +1425,16 @@ static void shadow_copy_event(struct ust_app_event *ua_event,
 		ua_event->filter = alloc_copy_ust_app_filter(uevent->filter);
 		/* Filter might be NULL here in case of ENONEM. */
 	}
+
+	/* Copy exclusion data */
+	if (uevent->exclusion) {
+		exclusion_alloc_size = sizeof(struct lttng_ust_event_exclusion) +
+				LTTNG_UST_SYM_NAME_LEN * uevent->exclusion->count;
+		ua_event->exclusion = zmalloc(exclusion_alloc_size);
+		if (ua_event->exclusion) {
+			memcpy(ua_event->exclusion, uevent->exclusion, exclusion_alloc_size);
+		}
+	}
 }
 
 /*
-- 
1.8.1.2
