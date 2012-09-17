From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Mismatch of field name between
	latest lttng-ust abi and lttng-tools
Date: Mon, 17 Sep 2012 17:32:03 -0400
Message-ID: <1347917523-9848-1-git-send-email-christian.babeux__6088.00771083242$1347917572$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TDivZ-0005H8-DD
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 17:32:25 -0400
Received: by qcsc21 with SMTP id c21so6276654qcs.35
	for <lttng-dev@lists.lttng.org>; Mon, 17 Sep 2012 14:32:19 -0700 (PDT)
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

The "written" field of the lttng_event_field and lttng_ust_field_iter
structures has been renamed to "nowrite" in the upstream version of
lttng-ust.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 include/lttng/lttng.h                  | 2 +-
 src/bin/lttng-sessiond/lttng-ust-abi.h | 2 +-
 src/bin/lttng-sessiond/ust-app.c       | 2 +-
 src/bin/lttng/commands/list.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index d066728..f92ccb6 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -261,7 +261,7 @@ struct lttng_event_field {
 	enum lttng_event_field_type type;
 	char padding[LTTNG_EVENT_FIELD_PADDING];
 	struct lttng_event event;
-	int written;
+	int nowrite;
 };
 
 /*
diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessiond/lttng-ust-abi.h
index 91639a7..c9be4bd 100644
--- a/src/bin/lttng-sessiond/lttng-ust-abi.h
+++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
@@ -105,7 +105,7 @@ struct lttng_ust_field_iter {
 	char field_name[LTTNG_UST_SYM_NAME_LEN];
 	enum lttng_ust_field_type type;
 	int loglevel;				/* event loglevel */
-	int written;
+	int nowrite;
 	char padding[LTTNG_UST_FIELD_ITER_PADDING];
 };
 
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 81b1f41..3202cd4 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1667,7 +1667,7 @@ int ust_app_list_event_fields(struct lttng_event_field **fields)
 
 			memcpy(tmp[count].field_name, uiter.field_name, LTTNG_UST_SYM_NAME_LEN);
 			tmp[count].type = uiter.type;
-			tmp[count].written = uiter.written;
+			tmp[count].nowrite = uiter.nowrite;
 
 			memcpy(tmp[count].event.name, uiter.event_name, LTTNG_UST_SYM_NAME_LEN);
 			tmp[count].event.loglevel = uiter.loglevel;
diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index eced2b7..0467cc6 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -281,7 +281,7 @@ static void print_event_field(struct lttng_event_field *field)
 		return;
 	}
 	MSG("%sfield: %s (%s)%s", indent8, field->field_name,
-		field_type(field), field->written ? "" : " [no write]");
+		field_type(field), field->nowrite ? "" : " [no write]");
 }
 
 /*
-- 
1.7.12
