From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 16/28] Free exclusion data when
	ust_app_event is deleted
Date: Thu,  7 Nov 2013 12:21:40 +0200
Message-ID: <1383819703-6793-7-git-send-email-jp_ikaheimonen__27921.6856965379$1383819903$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMiy-0007WG-G3
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:05 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMit-0006Du-1c from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:59 -0800
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
 src/bin/lttng-sessiond/ust-app.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 2d8cb2c..9f9919e 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -287,7 +287,8 @@ void delete_ust_app_event(int sock, struct ust_app_event *ua_event)
 	assert(ua_event);
 
 	free(ua_event->filter);
-
+	if (ua_event->exclusion != NULL)
+		free(ua_event->exclusion);
 	if (ua_event->obj != NULL) {
 		ret = ustctl_release_object(sock, ua_event->obj);
 		if (ret < 0 && ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
-- 
1.8.1.2
