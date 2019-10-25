From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/5] Fix: move set base_path of
 session to URI configuration
Date: Fri, 25 Oct 2019 18:12:00 -0400
Message-ID: <20191025221204.29696-1-jonathan.rajotte-julien__10190.5853067123$1572041577$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 470JHx4ZdWz1PXZ
 for <lttng-dev@lists.lttng.org>; Fri, 25 Oct 2019 18:12:13 -0400 (EDT)
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

The load code still use the "old" API to create and configure network
session output (lttng_create_session followed by
lttng_set_consumer_url). The session base_path is only set in the
cmd_create_session_from_descriptor function. This results in invalid
network output path when using a loaded session configuration (xml).

While we might want to move the load code to the new API, there is a case
to be made in not breaking the previous API behaviour.

To restore the expected behaviour of lttng_set_consumer_url, move the
assignation of the session base_path to the cmd_set_consumer_uri function
(LTTNG_SET_CONSUMER_URI).

Both the previous and session descriptor based creation API uses this code
path when needed (network output).

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---

Note that this is the "base fix". The next 2 commits extracts the added for
loops into its own function and also remove
lttng_session_descriptor_get_base_path from the code base. Feel free to "squash"
them. I was not sure what you would prefer.

---
 src/bin/lttng-sessiond/cmd.c     | 36 +++++++++++++++++++++++---------
 src/bin/lttng-sessiond/session.c | 12 +----------
 src/bin/lttng-sessiond/session.h |  2 +-
 tests/unit/test_session.c        |  4 ++--
 4 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index a164cffc0..1dec61ea1 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -2759,11 +2759,32 @@ int cmd_set_consumer_uri(struct ltt_session *session, size_t nb_uri,
 		goto error;
 	}
 
+	for (i = 0; i < nb_uri; i++) {
+		if (uris[i].stype != LTTNG_STREAM_CONTROL ||
+				uris[i].subdir[0] == '\0') {
+			/* Not interested in these URIs */
+			continue;
+		}
+
+		if (session->base_path != NULL) {
+			free(session->base_path);
+			session->base_path = NULL;
+		}
+
+		/* Set session base_path */
+		session->base_path = strdup(uris[i].subdir);
+		if (!session->base_path) {
+			PERROR("Copying base path: %s", uris[i].subdir);
+			goto error;
+		}
+		DBG2("Setting base path for session %" PRIu64 ": %s",
+				session->id, session->base_path);
+	}
+
 	/* Set the "global" consumer URIs */
 	for (i = 0; i < nb_uri; i++) {
-		ret = add_uri_to_consumer(session,
-				session->consumer,
-				&uris[i], LTTNG_DOMAIN_NONE);
+		ret = add_uri_to_consumer(session, session->consumer, &uris[i],
+				LTTNG_DOMAIN_NONE);
 		if (ret != LTTNG_OK) {
 			goto error;
 		}
@@ -2894,7 +2915,6 @@ enum lttng_error_code cmd_create_session_from_descriptor(
 	const char *session_name;
 	struct ltt_session *new_session = NULL;
 	enum lttng_session_descriptor_status descriptor_status;
-	const char *base_path;
 
 	session_lock_list();
 	if (home_path) {
@@ -2917,13 +2937,9 @@ enum lttng_error_code cmd_create_session_from_descriptor(
 		ret_code = LTTNG_ERR_INVALID;
 		goto end;
 	}
-	ret = lttng_session_descriptor_get_base_path(descriptor, &base_path);
-	if (ret) {
-		ret_code = LTTNG_ERR_INVALID;
-		goto end;
-	}
+
 	ret_code = session_create(session_name, creds->uid, creds->gid,
-			base_path, &new_session);
+			&new_session);
 	if (ret_code != LTTNG_OK) {
 		goto end;
 	}
diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/session.c
index 383c6fde7..ed68d153f 100644
--- a/src/bin/lttng-sessiond/session.c
+++ b/src/bin/lttng-sessiond/session.c
@@ -962,7 +962,7 @@ end:
  * Session list lock must be held by the caller.
  */
 enum lttng_error_code session_create(const char *name, uid_t uid, gid_t gid,
-		const char *base_path, struct ltt_session **out_session)
+		struct ltt_session **out_session)
 {
 	int ret;
 	enum lttng_error_code ret_code;
@@ -1086,16 +1086,6 @@ enum lttng_error_code session_create(const char *name, uid_t uid, gid_t gid,
 		}
 	}
 
-	if (base_path) {
-		new_session->base_path = strdup(base_path);
-		if (!new_session->base_path) {
-			ERR("Failed to allocate base path of session \"%s\"",
-					name);
-			ret_code = LTTNG_ERR_SESSION_FAIL;
-			goto error;
-		}
-	}
-
 	new_session->uid = uid;
 	new_session->gid = gid;
 
diff --git a/src/bin/lttng-sessiond/session.h b/src/bin/lttng-sessiond/session.h
index 31a40a741..20a7fcbc8 100644
--- a/src/bin/lttng-sessiond/session.h
+++ b/src/bin/lttng-sessiond/session.h
@@ -193,7 +193,7 @@ struct ltt_session {
 
 /* Prototypes */
 enum lttng_error_code session_create(const char *name, uid_t uid, gid_t gid,
-		const char *base_path, struct ltt_session **out_session);
+		struct ltt_session **out_session);
 void session_lock(struct ltt_session *session);
 void session_lock_list(void);
 int session_trylock_list(void);
diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c
index b538bddc6..d01117809 100644
--- a/tests/unit/test_session.c
+++ b/tests/unit/test_session.c
@@ -132,7 +132,7 @@ static int create_one_session(char *name)
 	struct ltt_session *session = NULL;
 
 	session_lock_list();
-	ret_code = session_create(name, geteuid(), getegid(), NULL, &session);
+	ret_code = session_create(name, geteuid(), getegid(), &session);
 	session_put(session);
 	if (ret_code == LTTNG_OK) {
 		/* Validate */
@@ -288,7 +288,7 @@ void test_session_name_generation(void)
 	const char *expected_session_name_prefix = DEFAULT_SESSION_NAME;
 
 	session_lock_list();
-	ret_code = session_create(NULL, geteuid(), getegid(), NULL, &session);
+	ret_code = session_create(NULL, geteuid(), getegid(), &session);
 	ok(ret_code == LTTNG_OK,
 		"Create session with a NULL name (auto-generate a name)");
 	if (!session) {
-- 
2.17.1
