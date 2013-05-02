From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [babeltrace RFC PATCH 05/28] Add *.exe files to
	.gitignore
Date: Thu, 2 May 2013 11:47:02 +0000
Message-ID: <009B25148989C6458484484699278506E537E85A__35504.3710362681$1367495262$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UXryf-0001rb-NO
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 07:47:09 -0400
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
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 752308e..dab17d3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,3 +28,4 @@ core
 formats/ctf/metadata/ctf-parser.output
 stamp-h1
 babeltrace.pc
+*.exe
-- 
1.8.1.msysgit.1
