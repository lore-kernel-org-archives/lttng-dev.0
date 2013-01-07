From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/3] Extras: Change TYPE of braces
	around single statement warning in checkpatch
Date: Mon,  7 Jan 2013 17:12:41 -0500
Message-ID: <1357596762-14132-2-git-send-email-christian.babeux__22.9003876031086$1357596831$gmane$org@efficios.com>
References: <1357596762-14132-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TsKwJ-0003XO-Vj
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 17:13:04 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so24826731iec.13
	for <lttng-dev@lists.lttng.org>; Mon, 07 Jan 2013 14:12:58 -0800 (PST)
In-Reply-To: <1357596762-14132-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Change the TYPE of the "braces {} are not necessary for single statement
blocks" warning from BRACES to BRACES_SINGLE_STMT in order to correctly
ignore this particular warning and continue to warn for other BRACES warnings.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 extras/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extras/checkpatch.pl b/extras/checkpatch.pl
index 4d2c7df..7b2d29b 100755
--- a/extras/checkpatch.pl
+++ b/extras/checkpatch.pl
@@ -3198,7 +3198,7 @@ sub process {
 					$herectx .= raw_line($linenr, $n) . "\n";
 				}
 
-				WARN("BRACES",
+				WARN("BRACES_SINGLE_STMT",
 				     "braces {} are not necessary for single statement blocks\n" . $herectx);
 			}
 		}
-- 
1.8.0.2
