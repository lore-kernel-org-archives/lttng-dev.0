From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 18/23] Add MinGW implementation of
	funlockfile
Date: Wed, 22 May 2013 08:07:27 +0000
Message-ID: <009B25148989C6458484484699278506E5382FB2__5037.09566914967$1369210090$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1Uf458-0006aT-OY
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 04:07:34 -0400
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

Add a dummy MinGW implementation of funlockfile.
This function does not do anything, it only returns.
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
