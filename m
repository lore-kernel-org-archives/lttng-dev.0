From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] Implement bt_getline
Date: Tue, 13 Oct 2015 14:35:23 -0400
Message-ID: <1444761323-8153-2-git-send-email-mathieu.desnoyers__23479.4344324202$1444761430$gmane$org@efficios.com>
References: <1444761323-8153-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Zm4QT-000774-Nd
 for lttng-dev@lists.lttng.org; Tue, 13 Oct 2015 14:35:55 -0400
In-Reply-To: <1444761323-8153-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, jmeanson@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Implement our own getline to remove dependency from glibc 2.10+ and to
increase portability to other operating systems.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 converter/babeltrace-log.c  | 5 ++---
 tests/lib/test_ctf_writer.c | 7 ++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 5900b32..acbd0ee 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -24,8 +24,6 @@
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
- *
- * Depends on glibc 2.10 for getline().
  */
 
 #define _GNU_SOURCE
@@ -47,6 +45,7 @@
 #include <babeltrace/ctf/types.h>
 #include <babeltrace/compat/uuid.h>
 #include <babeltrace/compat/utc.h>
+#include <babeltrace/compat/stdio.h>
 #include <babeltrace/endian.h>
 
 #define NSEC_PER_USEC 1000UL
@@ -331,7 +330,7 @@ void trace_text(FILE *input, int output)
 	write_packet_header(&pos, s_uuid);
 	write_packet_context(&pos);
 	for (;;) {
-		len = getline(&line, &linesize, input);
+		len = bt_getline(&line, &linesize, input);
 		if (len < 0)
 			break;
 		nl = strrchr(line, '\n');
diff --git a/tests/lib/test_ctf_writer.c b/tests/lib/test_ctf_writer.c
index b626a66..91ef81a 100644
--- a/tests/lib/test_ctf_writer.c
+++ b/tests/lib/test_ctf_writer.c
@@ -35,6 +35,7 @@
 #include <stdio.h>
 #include <sys/utsname.h>
 #include <babeltrace/compat/limits.h>
+#include <babeltrace/compat/stdio.h>
 #include <string.h>
 #include <assert.h>
 #include <sys/wait.h>
@@ -160,12 +161,12 @@ result:
 		rewind(metadata_fp);
 
 		/* Output the metadata and parser output as diagnostic */
-		while (getline(&line, &len, metadata_fp) > 0) {
+		while (bt_getline(&line, &len, metadata_fp) > 0) {
 			fprintf(stderr, "# %s", line);
 		}
 
 		rewind(parser_output_fp);
-		while (getline(&line, &len, parser_output_fp) > 0) {
+		while (bt_getline(&line, &len, parser_output_fp) > 0) {
 			fprintf(stderr, "# %s", line);
 		}
 
@@ -257,7 +258,7 @@ result:
 			diag("malloc error");
 		}
 		rewind(babeltrace_output_fp);
-		while (getline(&line, &len, babeltrace_output_fp) > 0) {
+		while (bt_getline(&line, &len, babeltrace_output_fp) > 0) {
 			diag("%s", line);
 		}
 
-- 
2.1.4
