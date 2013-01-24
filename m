From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 11/18] namespace the string functions
Date: Thu, 24 Jan 2013 16:21:43 -0500
Message-ID: <1359062510-7557-11-git-send-email-jdesfossez__21582.6208623641$1359064627$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFR-0008Ey-3z
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:13 -0500
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
 formats/ctf/events.c                                  |    2 +-
 formats/ctf/metadata/ctf-visitor-generate-io-struct.c |    2 +-
 include/babeltrace/types.h                            |    6 +++---
 types/string.c                                        |    6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index 036ce46..3660c04 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -601,7 +601,7 @@ char *bt_ctf_get_string(const struct definition *field)
 	char *ret = NULL;
 
 	if (field && bt_ctf_field_type(bt_ctf_get_decl_from_def(field)) == CTF_TYPE_STRING)
-		ret = get_string(field);
+		ret = bt_get_string(field);
 	else
 		bt_ctf_field_set_error(-EINVAL);
 
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 94dd0c8..bdb9f5f 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -1558,7 +1558,7 @@ struct declaration *ctf_declaration_string_visit(FILE *fd, int depth,
 	}
 	if (encoding_c && !strcmp(encoding_c, "ASCII"))
 		encoding = CTF_STRING_ASCII;
-	string_declaration = string_declaration_new(encoding);
+	string_declaration = bt_string_declaration_new(encoding);
 	return &string_declaration->p;
 }
 
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index a0c5467..da69b91 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -426,9 +426,9 @@ struct declaration_enum *
 	bt_enum_declaration_new(struct declaration_integer *integer_declaration);
 
 struct declaration_string *
-	string_declaration_new(enum ctf_string_encoding encoding);
-char *get_string(const struct definition *field);
-enum ctf_string_encoding get_string_encoding(const struct definition *field);
+	bt_string_declaration_new(enum ctf_string_encoding encoding);
+char *bt_get_string(const struct definition *field);
+enum ctf_string_encoding bt_get_string_encoding(const struct definition *field);
 
 struct declaration_struct *
 	struct_declaration_new(struct declaration_scope *parent_scope,
diff --git a/types/string.c b/types/string.c
index cebce12..255388f 100644
--- a/types/string.c
+++ b/types/string.c
@@ -48,7 +48,7 @@ void _string_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_string *
-	string_declaration_new(enum ctf_string_encoding encoding)
+	bt_string_declaration_new(enum ctf_string_encoding encoding)
 {
 	struct declaration_string *string_declaration;
 
@@ -109,7 +109,7 @@ void _string_definition_free(struct definition *definition)
 	g_free(string);
 }
 
-enum ctf_string_encoding get_string_encoding(const struct definition *field)
+enum ctf_string_encoding bt_get_string_encoding(const struct definition *field)
 {
 	struct definition_string *string_definition;
 	const struct declaration_string *string_declaration;
@@ -120,7 +120,7 @@ enum ctf_string_encoding get_string_encoding(const struct definition *field)
 	return string_declaration->encoding;
 }
 
-char *get_string(const struct definition *field)
+char *bt_get_string(const struct definition *field)
 {
 	struct definition_string *string_definition =
 		container_of(field, struct definition_string, p);
-- 
1.7.10.4
