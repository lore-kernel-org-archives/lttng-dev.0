From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 04/18] namespace the scope_path
	functions
Date: Thu, 24 Jan 2013 16:21:36 -0500
Message-ID: <1359062510-7557-4-git-send-email-jdesfossez__31226.3077627451$1359062587$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFJ-0008E4-D8
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:05 -0500
In-Reply-To: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/babeltrace/types.h |    2 +-
 types/sequence.c           |    2 +-
 types/types.c              |    4 ++--
 types/variant.c            |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 00c928b..772abb2 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -511,7 +511,7 @@ int sequence_rw(struct stream_pos *pos, struct definition *definition);
 /*
  * in: path (dot separated), out: q (GArray of GQuark)
  */
-void append_scope_path(const char *path, GArray *q);
+void bt_append_scope_path(const char *path, GArray *q);
 
 /*
  * Lookup helpers.
diff --git a/types/sequence.c b/types/sequence.c
index 0e84b1d..3967f97 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -111,7 +111,7 @@ struct declaration_sequence *
 	declaration = &sequence_declaration->p;
 
 	sequence_declaration->length_name = g_array_new(FALSE, TRUE, sizeof(GQuark));
-	append_scope_path(length, sequence_declaration->length_name);
+	bt_append_scope_path(length, sequence_declaration->length_name);
 
 	declaration_ref(elem_declaration);
 	sequence_declaration->elem = elem_declaration;
diff --git a/types/types.c b/types/types.c
index 139e318..9c5cfca 100644
--- a/types/types.c
+++ b/types/types.c
@@ -547,7 +547,7 @@ struct definition_scope *
 
 	if (root_name) {
 		scope = _new_definition_scope(parent_scope, 0);
-		append_scope_path(root_name, scope->scope_path);
+		bt_append_scope_path(root_name, scope->scope_path);
 	} else {
 		int scope_path_len = 1;
 
@@ -574,7 +574,7 @@ struct definition_scope *
 /*
  * in: path (dot separated), out: q (GArray of GQuark)
  */
-void append_scope_path(const char *path, GArray *q)
+void bt_append_scope_path(const char *path, GArray *q)
 {
 	const char *ptrbegin, *ptrend = path;
 	GQuark quark;
diff --git a/types/variant.c b/types/variant.c
index 55b4b1f..4f1e524 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -114,7 +114,7 @@ struct declaration_variant *
 	variant_declaration->untagged_variant = untagged_variant;
 	declaration_ref(&untagged_variant->p);
 	variant_declaration->tag_name = g_array_new(FALSE, TRUE, sizeof(GQuark));
-	append_scope_path(tag, variant_declaration->tag_name);
+	bt_append_scope_path(tag, variant_declaration->tag_name);
 	declaration->id = CTF_TYPE_VARIANT;
 	declaration->alignment = 1;
 	declaration->declaration_free = _variant_declaration_free;
-- 
1.7.10.4
