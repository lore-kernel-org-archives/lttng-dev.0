From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH 4/4] tile: select HAVE_SYSCALL_TRACEPOINTS
Date: Mon, 21 Jan 2013 19:54:58 -0500
Message-ID: <1358816098-13070-4-git-send-email-simon.marchi__43423.788136761$1358816167$gmane$org@polymtl.ca>
References: <1358816098-13070-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TxS8t-0007o2-38
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 19:55:11 -0500
In-Reply-To: <1358816098-13070-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: cmetcalf@tilera.com
Cc: lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org, Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 arch/tile/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 8cab409..1adb853 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -22,6 +22,7 @@ config TILE
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_SYSCALL_TRACEPOINTS
 
 # FIXME: investigate whether we need/want these options.
 #	select HAVE_IOREMAP_PROT
-- 
1.7.1
