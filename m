From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH v2 ust] Add compilation support for Tile
	architectures
Date: Thu, 24 Jan 2013 14:18:33 -0500
Message-ID: <1359055113-25549-1-git-send-email-simon.marchi__9910.43026228926$1359055163$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TySJp-0007Bq-0W
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 14:18:37 -0500
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

Also add missing space on the mips line for OCD purposes.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 configure.ac |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index c4377a5..919b742 100644
--- a/configure.ac
+++ b/configure.ac
@@ -189,7 +189,8 @@ changequote([,])dnl
 	s390) NO_UNALIGNED_ACCESS=1 ;;
 	s390x) NO_UNALIGNED_ACCESS=1 ;;
         arm*) NO_UNALIGNED_ACCESS=1 ;;
-	mips*) NO_UNALIGNED_ACCESS=1;;
+	mips*) NO_UNALIGNED_ACCESS=1 ;;
+	tile*) NO_UNALIGNED_ACCESS=1 ;;
 	*) AC_MSG_ERROR([unable to detect alignment requirements (unsupported architecture ($host_cpu)?)]) ;;
 esac
 
-- 
1.7.1
