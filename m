From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH] Allow suppressing of base-address-state tracing
Date: Mon, 25 Nov 2013 13:05:33 +0100
Message-ID: <1385381133-2774-1-git-send-email-paul_woegerer__16069.2782993012$1385381188$gmane$org@mentor.com>
References: <1234203790.74752.1385280797186.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VkuvE-0008Hf-LA
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 07:05:49 -0500
In-Reply-To: <1234203790.74752.1385280797186.JavaMail.zimbra@efficios.com>
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

If environment variable LTTNG_UST_WITHOUT_BADDR_STATEDUMP is set prior
to tracing base-address-state tracing on session-enable gets suppressed.

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust/lttng-ust-comm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 77d8e3f..0b9c17d 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -260,6 +260,9 @@ int lttng_ust_baddr_statedump(struct lttng_session *session)
 	static
 	int (*lttng_ust_baddr_init_fn)(struct lttng_session *);
 
+	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
+		return 0;
+
 	if (!lttng_ust_baddr_init_fn) {
 		void *baddr_handle = lttng_ust_baddr_handle();
 		if (baddr_handle) {
-- 
1.8.4
