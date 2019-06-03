From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: get tid not pid in vtid context
Date: Mon,  3 Jun 2019 14:21:10 -0400
Message-ID: <20190603182110.13044-1-mjeanson__36447.3221403145$1559586108$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45Hk083Ns5z10Tf
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jun 2019 14:21:27 -0400 (EDT)
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
List-Id: lttng-dev@lists.lttng.org

Looks like an over enthusiastic copy/paste error in
commit 98357ffd0125c23387d42d4b706c56077392326d.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 liblttng-ust/lttng-context-vtid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust/lttng-context-vtid.c b/liblttng-ust/lttng-context-vtid.c
index 5cefe953..80661f63 100644
--- a/liblttng-ust/lttng-context-vtid.c
+++ b/liblttng-ust/lttng-context-vtid.c
@@ -63,7 +63,7 @@ pid_t wrapper_getvtid(void)
 
 	vtid = CMM_LOAD_SHARED(URCU_TLS(cached_vtid));
 	if (caa_unlikely(!vtid)) {
-		vtid = getpid();
+		vtid = gettid();
 		CMM_STORE_SHARED(URCU_TLS(cached_vtid), vtid);
 	}
 	return vtid;
-- 
2.17.1
