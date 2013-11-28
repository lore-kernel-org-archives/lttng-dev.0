From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 3/3] Allow suppressing of
	base-address-state tracing
Date: Thu, 28 Nov 2013 13:26:54 +0100
Message-ID: <1385641614-18806-4-git-send-email-paul_woegerer__25953.6537145779$1385641761$gmane$org@mentor.com>
References: <1385641614-18806-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Vm0gn-0001L5-OP
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 07:27:26 -0500
In-Reply-To: <1385641614-18806-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 liblttng-ust-baddr/lttng-ust-baddr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c b/liblttng-ust-baddr/lttng-ust-baddr.c
index 8412233..1e6e08d 100644
--- a/liblttng-ust-baddr/lttng-ust-baddr.c
+++ b/liblttng-ust-baddr/lttng-ust-baddr.c
@@ -99,6 +99,8 @@ extract_soinfo_events(struct dl_phdr_info *info, size_t size, void *data)
 int
 lttng_ust_baddr_statedump(struct lttng_session *session)
 {
+	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
+		return 0;
 	/*
 	 * Iterate through the list of currently loaded shared objects and
 	 * generate events for loadable segments using extract_soinfo_events
-- 
1.8.4
