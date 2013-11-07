From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 3/7] Send exclusion data through
	ustcomm
Date: Thu,  7 Nov 2013 12:22:31 +0200
Message-ID: <1383819755-6891-4-git-send-email-jp_ikaheimonen__22945.7270740115$1383820266$gmane$org@mentor.com>
References: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjp-0007nJ-7W
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:58 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjj-0006IF-Po from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:51 -0800
In-Reply-To: <1383819755-6891-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Define a function ustctl_set_exclusion that sends the
exclusion data through ustcomm with the LTTNG_UST_EXCLUSION
command message.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/ust-ctl.h   |  2 ++
 liblttng-ust-ctl/ustctl.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index c8ac3f9..40e831e 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -73,6 +73,8 @@ int ustctl_add_context(int sock, struct lttng_ust_context *ctx,
 		struct lttng_ust_object_data **context_data);
 int ustctl_set_filter(int sock, struct lttng_ust_filter_bytecode *bytecode,
 		struct lttng_ust_object_data *obj_data);
+int ustctl_set_exclusion(int sock, struct lttng_ust_event_exclusion *exclusion,
+		struct lttng_ust_object_data *obj_data);
 
 int ustctl_enable(int sock, struct lttng_ust_object_data *object);
 int ustctl_disable(int sock, struct lttng_ust_object_data *object);
diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 11fc704..00d9802 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -273,6 +273,40 @@ int ustctl_set_filter(int sock, struct lttng_ust_filter_bytecode *bytecode,
 	return ustcomm_recv_app_reply(sock, &lur, lum.handle, lum.cmd);
 }
 
+int ustctl_set_exclusion(int sock, struct lttng_ust_event_exclusion *exclusion,
+		struct lttng_ust_object_data *obj_data)
+{
+	struct ustcomm_ust_msg lum;
+	struct ustcomm_ust_reply lur;
+	int ret;
+
+	if (!obj_data) {
+		return -EINVAL;
+	}
+
+	memset(&lum, 0, sizeof(lum));
+	lum.handle = obj_data->handle;
+	lum.cmd = LTTNG_UST_EXCLUSION;
+	lum.u.exclusion.count = exclusion->count;
+
+	ret = ustcomm_send_app_msg(sock, &lum);
+	if (ret) {
+		return ret;
+	}
+
+	/* send var len bytecode */
+	ret = ustcomm_send_unix_sock(sock,
+			exclusion->names,
+			exclusion->count * LTTNG_UST_SYM_NAME_LEN);
+	if (ret < 0) {
+		return ret;
+	}
+	if (ret != exclusion->count * LTTNG_UST_SYM_NAME_LEN) {
+		return -EINVAL;
+	}
+	return ustcomm_recv_app_reply(sock, &lur, lum.handle, lum.cmd);
+}
+
 /* Enable event, channel and session ioctl */
 int ustctl_enable(int sock, struct lttng_ust_object_data *object)
 {
-- 
1.8.1.2
