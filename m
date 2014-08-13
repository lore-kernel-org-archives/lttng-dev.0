From: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tool] fix: mi: xsd: wrong comment for
	context_type_type
Date: Wed, 13 Aug 2014 16:58:29 -0400
Message-ID: <1407963509-6920-1-git-send-email-jonathan.r.julien__34780.9420353316$1407963603$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@ericsson.com>)
 id 1XHfd5-00080E-EW
 for lttng-dev@lists.lttng.org; Wed, 13 Aug 2014 16:58:49 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
---
 src/common/mi_lttng.xsd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
index f63065c..d2cc5d4 100644
--- a/src/common/mi_lttng.xsd
+++ b/src/common/mi_lttng.xsd
@@ -83,7 +83,7 @@ THE SOFTWARE.
 		</xs:restriction>
 	</xs:simpleType>
 
-	<!-- Maps to the lttng_loglevel_type enum -->
+	<!-- Maps to the lttng_event_context_type enum -->
 	<xs:simpleType name="context_type_type">
 		<xs:restriction base="xs:string">
 			<xs:enumeration value="PERF_COUNTER" />
-- 
2.0.4
