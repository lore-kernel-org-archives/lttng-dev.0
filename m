From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [LTTng UST PATCH 1/2] Store the callsites into the
 library callsite list.
Date: Thu, 3 Oct 2013 06:46:27 +0000
Message-ID: <009B25148989C6458484484699278506E538AF3E__25193.2745254182$1380782842$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VRcgF-000872-KA
	for lttng-dev@lists.lttng.org; Thu, 03 Oct 2013 02:46:37 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VRcgA-0007io-5b from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 23:46:30 -0700
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Fix the issue where the callsites are registered but never
properly unregistered.

---
 liblttng-ust/tracepoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/liblttng-ust/tracepoint.c b/liblttng-ust/tracepoint.c
index 7bb38fa..4870d45 100644
--- a/liblttng-ust/tracepoint.c
+++ b/liblttng-ust/tracepoint.c
@@ -314,7 +314,7 @@ static void remove_tracepoint(struct tracepoint_entry *e)
  * Add the callsite to the callsite hash table. Must be called with
  * tracepoint mutex held.
  */
-static void add_callsite(struct tracepoint *tp)
+static void add_callsite(struct tracepoint_lib * lib, struct tracepoint *tp)
 {
 	struct cds_hlist_head *head;
 	struct callsite_entry *e;
@@ -332,6 +332,7 @@ static void add_callsite(struct tracepoint *tp)
 	assert(e);
 	cds_hlist_add_head(&e->hlist, head);
 	e->tp = tp;
+	cds_list_add(&e->node, &(lib->callsites));
 }
 
 /*
@@ -480,7 +481,7 @@ static void lib_register_callsites(struct tracepoint_lib *lib)
 		if (!(*iter)->name) {
 			continue;
 		}
-		add_callsite(*iter);
+		add_callsite(lib, *iter);
 	}
 }
 
-- 
1.8.1.2
