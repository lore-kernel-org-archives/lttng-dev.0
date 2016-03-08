From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH lttng-tools 2/2] Fix: add missing sys/types.h
	header
Date: Tue,  8 Mar 2016 14:55:05 +0200
Message-ID: <97a27dbdf6ed5397497eb4d76302be2a0b11a993.1457441705.git.baruch__13402.4189821959$1457441948$gmane$org@tkos.co.il>
References: <17f5fc70d86b42e09f71fc46f6dfbd85b9ee3eaf.1457441705.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <baruch@tkos.co.il>) id 1adHB0-0007xQ-NF
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 07:55:53 -0500
In-Reply-To: <17f5fc70d86b42e09f71fc46f6dfbd85b9ee3eaf.1457441705.git.baruch@tkos.co.il>
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

The musl C library requires inclusion of sys/types.h for mode_t.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 src/common/runas.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/common/runas.h b/src/common/runas.h
index 2c5565af3646..ac1143eecf84 100644
--- a/src/common/runas.h
+++ b/src/common/runas.h
@@ -19,6 +19,7 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include <sys/types.h>
 #include <unistd.h>
 #include <pthread.h>
 
-- 
2.7.0
