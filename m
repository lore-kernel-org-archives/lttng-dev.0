From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix typo in lttng snapshot
	add-output example of lttng(1)
Date: Wed, 25 Sep 2013 10:06:05 -0400
Message-ID: <1380117966-30710-1-git-send-email-christian.babeux__20714.1551109546$1380118045$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VOpjS-0008DL-Tn
	for lttng-dev@lists.lttng.org; Wed, 25 Sep 2013 10:06:28 -0400
Received: by mail-qa0-f48.google.com with SMTP id hu16so3484272qab.0
	for <lttng-dev@lists.lttng.org>; Wed, 25 Sep 2013 07:06:17 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 doc/man/lttng.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index 57c89f0..659a27c 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -742,7 +742,7 @@ size will override the current output values. For instance, you can record a
 snapshot with a custom maximum size or with a different name.
 
 .nf
-$ lttng add-output -n mysnapshot file:///data/snapshot
+$ lttng snapshot add-output -n mysnapshot file:///data/snapshot
 [...]
 $ lttng snapshot record -n new_name_snapshot
 .fi
-- 
1.8.4
