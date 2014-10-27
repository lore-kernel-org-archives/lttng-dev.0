From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 20/24] Android : %m[^] not supported
	in fscanf
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-21-git-send-email-c.briere__23865.716221235$1414443786$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEb-0007ni-AY
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:50 -0400
Received: from uscpsbgex2.samsung.com
 (u123.gpu85.samsung.co.kr [203.254.195.123]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4003LQF6MW130@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:34 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Replacing %m[^] and char* by %[^] and char[LTTNG_SYMBOL_NAME_LEN]

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 src/bin/lttng-sessiond/kernel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 2aeef26..3e1eff3 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -613,7 +613,7 @@ error:
 ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 {
 	int fd, ret;
-	char *event;
+	char event[LTTNG_SYMBOL_NAME_LEN];
 	size_t nbmem, count = 0;
 	FILE *fp;
 	struct lttng_event *elist;
@@ -644,7 +644,7 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 		goto end;
 	}
 
-	while (fscanf(fp, "event { name = %m[^;]; };\n", &event) == 1) {
+	while (fscanf(fp,"event { name = %[^;]; };\n", &event) == 1) {
 		if (count >= nbmem) {
 			struct lttng_event *new_elist;
 			size_t new_nbmem;
@@ -655,7 +655,6 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 			new_elist = realloc(elist, new_nbmem * sizeof(struct lttng_event));
 			if (new_elist == NULL) {
 				PERROR("realloc list events");
-				free(event);
 				free(elist);
 				count = -ENOMEM;
 				goto end;
@@ -670,7 +669,6 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 		elist[count].name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
 		elist[count].enabled = -1;
 		count++;
-		free(event);
 	}
 
 	*events = elist;
-- 
2.1.2
