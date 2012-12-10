From: David Goulet <dgoulet@efficios.com>
Subject: [lttng-tools PATCH] Fix: Relayd and sessiond version
	check
Date: Mon, 10 Dec 2012 12:20:08 -0500
Message-ID: <1355160008-24270-1-git-send-email-dgoulet__1863.97120492092$1355160071$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Ti71p-0001kb-Tr
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 12:20:30 -0500
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

Now only checks for the major version to be equal. After 2.1 stable
release, both components will adapt to the lowest minor version for the
same major version. For this, the session daemon now send it's version
values to the relayd so slight change in the protocol here.

For instance, a relayd 2.4 talking to a sessiond 2.8, the communication
and available feature will only be those of 2.4 version.

For a relayd let say 3.2 and a sessiond 2.2, the communication stops
right there since both major version differs.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-relayd/main.c |   17 ++++++++++++++-
 src/common/relayd/relayd.c  |   51 +++++++++++++++++++++++++++++--------------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index a00fb3c..bd19a32 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -1281,7 +1281,7 @@ int relay_send_version(struct lttcomm_relayd_hdr *recv_hdr,
 		struct relay_command *cmd)
 {
 	int ret;
-	struct lttcomm_relayd_version reply;
+	struct lttcomm_relayd_version reply, msg;
 	struct relay_session *session;
 
 	if (cmd->session == NULL) {
@@ -1299,6 +1299,21 @@ int relay_send_version(struct lttcomm_relayd_hdr *recv_hdr,
 	}
 	session->version_check_done = 1;
 
+	/* Get version from the other side. */
+	ret = cmd->sock->ops->recvmsg(cmd->sock, &msg, sizeof(msg), MSG_WAITALL);
+	if (ret < 0 || ret != sizeof(msg)) {
+		ret = -1;
+		ERR("Relay failed to receive the version values.");
+		goto end;
+	}
+
+	/*
+	 * For now, we just ignore the received version but after 2.1 stable
+	 * release, a check must be done to see if we either adapt to the other
+	 * side version (which MUST be lower than us) or keep the latest data
+	 * structure considering that the other side will adapt.
+	 */
+
 	ret = sscanf(VERSION, "%u.%u", &reply.major, &reply.minor);
 	if (ret < 2) {
 		ERR("Error in scanning version");
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index daaf44e..5adb977 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -163,42 +163,61 @@ int relayd_version_check(struct lttcomm_sock *sock, uint32_t major,
 		uint32_t minor)
 {
 	int ret;
-	struct lttcomm_relayd_version reply;
+	struct lttcomm_relayd_version msg;
 
 	/* Code flow error. Safety net. */
 	assert(sock);
 
 	DBG("Relayd version check for major.minor %u.%u", major, minor);
 
+	/* Prepare network byte order before transmission. */
+	msg.major = htobe32(major);
+	msg.minor = htobe32(minor);
+
 	/* Send command */
-	ret = send_command(sock, RELAYD_VERSION, NULL, 0, 0);
+	ret = send_command(sock, RELAYD_VERSION, (void *) &msg, sizeof(msg), 0);
 	if (ret < 0) {
 		goto error;
 	}
 
 	/* Recevie response */
-	ret = recv_reply(sock, (void *) &reply, sizeof(reply));
+	ret = recv_reply(sock, (void *) &msg, sizeof(msg));
 	if (ret < 0) {
 		goto error;
 	}
 
 	/* Set back to host bytes order */
-	reply.major = be32toh(reply.major);
-	reply.minor = be32toh(reply.minor);
-
-	/* Validate version */
-	if (reply.major <= major) {
-		if (reply.minor <= minor) {
-			/* Compatible */
-			ret = 0;
-			DBG2("Relayd version is compatible");
-			goto error;
-		}
+	msg.major = be32toh(msg.major);
+	msg.minor = be32toh(msg.minor);
+
+	/*
+	 * Only validate the major version. If the other side is higher,
+	 * communication is not possible. Only major version equal can talk to each
+	 * other. If the minor version differs, the lowest version is used by both
+	 * sides.
+	 *
+	 * For now, before 2.1.0 stable release, we don't have to check the minor
+	 * because this new mechanism with the relayd will only be available with
+	 * 2.1 and NOT 2.0.x.
+	 */
+	if (msg.major == major) {
+		/* Compatible */
+		ret = 0;
+		DBG2("Relayd version is compatible");
+		goto error;
 	}
 
+	/*
+	 * After 2.1.0 release, for the 2.2 release, at this point will have to
+	 * check the minor version in order for the session daemon to know which
+	 * structure to use to communicate with the relayd. If the relayd's minor
+	 * version is higher, it will adapt to our version so we can continue to
+	 * use the latest relayd communication data structure.
+	 */
+
 	/* Version number not compatible */
-	DBG2("Relayd version is NOT compatible %u.%u > %u.%u", reply.major,
-			reply.minor, major, minor);
+	DBG2("Relayd version is NOT compatible %u.%u > %u.%u", msg.major,
+			msg.minor, major, minor);
 	ret = -1;
 
 error:
-- 
1.7.10.4
