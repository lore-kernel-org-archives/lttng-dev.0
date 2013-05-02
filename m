From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 12/28] Add MinGW implementation
	of localtime_r
Date: Thu, 2 May 2013 11:53:39 +0000
Message-ID: <009B25148989C6458484484699278506E537E8E9__44737.1609662243$1367495662$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXs54-00020W-Au
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:53:46 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

---
 include/babeltrace/compat/time.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/babeltrace/compat/time.h b/include/babeltrace/compat/time.h
index ccfc860..d5cb7fd 100644
--- a/include/babeltrace/compat/time.h
+++ b/include/babeltrace/compat/time.h
@@ -15,5 +15,13 @@ struct tm *gmtime_r(const time_t *timep, struct tm *result)
 	return result;
 }
 
+static inline
+struct tm *localtime_r(const time_t *timep, struct tm *result)
+{
+	struct tm * r;
+	r = localtime(timep);
+	memcpy(result, r, sizeof (struct tm));
+	return result;
+}
 #endif
 #endif
-- 
1.8.1.msysgit.1
