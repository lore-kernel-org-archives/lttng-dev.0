From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace RFC PATCH 22/28] Add MinGW implementation
 of funlockfile.
Date: Thu, 2 May 2013 12:03:16 +0000
Message-ID: <009B25148989C6458484484699278506E537E991__20194.3854605362$1367496240$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXsEN-0002Ej-F2
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 08:03:23 -0400
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

Add dummy MinGW implementation of funlockfile.
This function does not do anything.
---
 include/babeltrace/compat/stdio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/babeltrace/compat/stdio.h b/include/babeltrace/compat/stdio.h
index 62ecf97..be64e60 100644
--- a/include/babeltrace/compat/stdio.h
+++ b/include/babeltrace/compat/stdio.h
@@ -8,6 +8,10 @@ static inline void flockfile (FILE * filehandle)
 {
 	return;
 }
+static inline void funlockfile(FILE * filehandle)
+{
+	return;
+}
 
 #endif
 
-- 
1.8.1.msysgit.1
