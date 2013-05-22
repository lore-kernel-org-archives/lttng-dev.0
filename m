From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 09/23] Add MinGW implementaion of
	localtime_r
Date: Wed, 22 May 2013 08:06:29 +0000
Message-ID: <009B25148989C6458484484699278506E5382F40__48511.9330035106$1369210035$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf44D-0006Tq-ED
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:06:37 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=28jeremie=2Egalarneau=40efficios=2E?= =?iso-8859-1?Q?com=29?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Add a (non-recursive) implementation of localtime_r for MinGW32.
MinGW does not include the Windows Visual C function localtime_s,
so the implementation uses localtime() instead.
---
 include/babeltrace/compat/time.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/babeltrace/compat/time.h b/include/babeltrace/compat/time.h
index 3238d58..5f23bfa 100644
--- a/include/babeltrace/compat/time.h
+++ b/include/babeltrace/compat/time.h
@@ -16,5 +16,14 @@ struct tm *gmtime_r(const time_t *timep, struct tm *result)
 	return result;
 }
 
+static inline
+struct tm *localtime_r(const time_t *timep, struct tm *result)
+{
+	struct tm * r;
+
+	r = localtime(timep);
+	memcpy(result, r, sizeof (struct tm));
+	return result;
+}
 #endif
 #endif
-- 
1.8.1.msysgit.1
