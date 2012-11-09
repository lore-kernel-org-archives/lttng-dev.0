From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-ust] Add compilation support for the
	TileGX architecture.
Date: Fri,  9 Nov 2012 01:48:31 -0500
Message-ID: <1352443711-8662-1-git-send-email-simon.marchi__28027.4371536963$1352443744$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TWiOI-0002zG-2H
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 01:48:34 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 configure.ac |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7f12f23..97a9f65 100644
--- a/configure.ac
+++ b/configure.ac
@@ -213,6 +213,7 @@ changequote([,])dnl
         armv5) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
 	arm) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
 	mips*) LIBFORMAT=""; NO_UNALIGNED_ACCESS=1;;
+	tile) LIBFORMAT="elf64-tilegx-le"; NO_UNALIGNED_ACCESS=1;;
 	*) AC_MSG_ERROR([unable to detect library format (unsupported architecture ($host_cpu)?)]) ;;
 esac
 AC_SUBST(LIBFORMAT)
-- 
1.7.1
