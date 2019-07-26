From: Khem Raj <raj.khem@gmail.com>
Subject: [lttng-ust][PATCH V2] Add config time check for new
 gettid API
Date: Fri, 26 Jul 2019 12:02:23 -0700
Message-ID: <20190726190223.38027-1-raj.khem__25623.6221919366$1564167770$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 by lists.lttng.org (Postfix) with ESMTPS id 45wJP50rQHz1FYK
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2019 15:02:32 -0400 (EDT)
Received: by mail-pg1-x543.google.com with SMTP id i70so14452358pgd.4
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2019 12:02:32 -0700 (PDT)
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

glibc 2.30 introduced this function see [1]
so it's best to detect it
and provide fallback only if its not present

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399

Upstream-Status: Submitted [https://lists.lttng.org/pipermail/lttng-dev/2019-July/029131.html]

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: Fix typos in commit message

 configure.ac            | 1 +
 include/lttng/ust-tid.h | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7fa059a..b1099c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -137,6 +137,7 @@ AC_CHECK_FUNCS([ \
 	clock_gettime \
 	ftruncate \
 	getpagesize \
+	gettid \
 	gettimeofday \
 	localeconv \
 	memchr \
diff --git a/include/lttng/ust-tid.h b/include/lttng/ust-tid.h
index e669d7e..7995c78 100644
--- a/include/lttng/ust-tid.h
+++ b/include/lttng/ust-tid.h
@@ -26,7 +26,10 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */
-
+#include <config.h>
+#if HAVE_GETTID
+#include <unistd.h>
+#else
 #ifdef __linux__
 #include <syscall.h>
 #endif
@@ -49,5 +52,5 @@ static inline pid_t gettid(void)
 	return getpid();
 }
 #endif
-
+#endif /* HAVE_GETTID */
 #endif /* _LTTNG_UST_TID_H */
-- 
2.22.0
