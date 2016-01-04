From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Fix: missing _GNU_SOURCE define
Date: Mon,  4 Jan 2016 17:31:57 -0500
Message-ID: <1451946717-12219-1-git-send-email-jonathan.rajotte-julien__45728.790088515$1451946787$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1aGDfl-0008WC-Dm
 for lttng-dev@lists.lttng.org; Mon, 04 Jan 2016 17:32:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 53A6734024C
 for <lttng-dev@lists.lttng.org>; Mon,  4 Jan 2016 22:32:14 +0000 (UTC)
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

O_CLOEXEC require _GNU_SOURCE.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 liblttng-ust/lttng-ust-elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/liblttng-ust/lttng-ust-elf.c b/liblttng-ust/lttng-ust-elf.c
index dcae966..e906269 100644
--- a/liblttng-ust/lttng-ust-elf.c
+++ b/liblttng-ust/lttng-ust-elf.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
  */
 
+#define _GNU_SOURCE
 #include <helper.h>
 #include <string.h>
 #include <lttng/align.h>
-- 
2.5.0
