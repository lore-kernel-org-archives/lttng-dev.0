From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: getenv can return null
Date: Tue, 30 Apr 2019 19:09:24 -0400
Message-ID: <20190430230924.23711-1-jonathan.rajotte-julien__48695.4177425773$1556665792$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44ty0D5Q0Kz1Kwg
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 19:09:32 -0400 (EDT)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

On system with LANG not defined getenv will return null.

An example of such system is the lava runner used by ci.lttng.org.

https://ci.lttng.org/view/System%20Tests/

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/common/time.c b/src/common/time.c
index 5519e3ab4..a01c16df5 100644
--- a/src/common/time.c
+++ b/src/common/time.c
@@ -76,7 +76,7 @@ void __attribute__((constructor)) init_locale_utf8_support(void)
 
 	if (program_locale && strstr(program_locale, "utf8")) {
 		utf8_output_supported = true;
-	} else if (strstr(lang, "utf8")) {
+	} else if (lang && strstr(lang, "utf8")) {
 		utf8_output_supported = true;
 	}
 }
-- 
2.17.1
