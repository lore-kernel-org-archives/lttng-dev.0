From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH urcu] Add compilation support for the TileGX
	architecture.
Date: Fri,  9 Nov 2012 01:46:54 -0500
Message-ID: <1352443614-8272-1-git-send-email-simon.marchi__24199.5132332251$1352443648$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TWiMi-0002xe-V0
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 01:46:57 -0500
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
index 1d04062..a4ef8c9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,7 @@ AS_CASE([$host_cpu],
 	[ia64], [ARCHTYPE="gcc"],
 	[arm*], [ARCHTYPE="arm"],
 	[mips*], [ARCHTYPE="mips"],
+	[tile], [ARCHTYPE="gcc"],
 	[ARCHTYPE="unknown"]
 )
 
-- 
1.7.1
