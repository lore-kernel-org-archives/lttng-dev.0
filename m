From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: [PATCH] fix timestamps on architectures without
	CONFIG_KTIME_SCALAR
Date: Thu, 30 Aug 2012 17:36:32 +0200
Message-ID: <1346340992-27307-1-git-send-email-gerlando.falauto__32083.4659542472$1346341038$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.1])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <gerlando.falauto@keymile.com>) id 1T76nV-0002cg-Q3
	for lttng-dev@lists.lttng.org; Thu, 30 Aug 2012 11:36:45 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>
List-Id: lttng-dev@lists.lttng.org

trace_clock_monotonic_wrapper() should return a u64 representing the
number of nanoseconds since system startup.
ktime_get() provides that value directly within its .tv64 field only
on those architectures defining CONFIG_KTIME_SCALAR, whereas in all
other cases (e.g. PowerPC) a ktime_to_ns() conversion (which
translates back to .tv64 when CONFIG_KTIME_SCALAR is defined)
becomes necessary.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 wrapper/trace-clock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper/trace-clock.h b/wrapper/trace-clock.h
index 6ea9e81..bced61c 100644
--- a/wrapper/trace-clock.h
+++ b/wrapper/trace-clock.h
@@ -46,7 +46,7 @@ static inline u64 trace_clock_monotonic_wrapper(void)
 		return (u64) -EIO;
 
 	ktime = ktime_get();
-	return (u64) ktime.tv64;
+	return ktime_to_ns(ktime);
 }
 
 static inline u32 trace_clock_read32(void)
-- 
1.7.10.1
