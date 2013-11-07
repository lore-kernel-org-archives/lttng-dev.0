From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 15/28] Copy event exclusion data in
	add_unique_ust_app_event
Date: Thu,  7 Nov 2013 12:21:39 +0200
Message-ID: <1383819703-6793-6-git-send-email-jp_ikaheimonen__47038.7881425724$1383819878$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMix-0007WF-Ax
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:04 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMir-0006Dq-Sq from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:57 -0800
In-Reply-To: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/ust-app.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index cc611fc..2d8cb2c 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -181,6 +181,7 @@ static void add_unique_ust_app_event(struct ust_app_channel *ua_chan,
 	key.name = event->attr.name;
 	key.filter = event->filter;
 	key.loglevel = event->attr.loglevel;
+	key.exclusion = event->exclusion;
 
 	node_ptr = cds_lfht_add_unique(ht->ht,
 			ht->hash_fct(event->node.key, lttng_ht_seed),
-- 
1.8.1.2
