From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 2/3] urcu: remove the wrong comma
Date: Fri, 7 Dec 2012 17:24:54 +0800
Message-ID: <1354872295-32371-2-git-send-email-laijs__6359.8420042128$1354872356$gmane$org@cn.fujitsu.com>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TguBF-0007oh-BL
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 04:25:13 -0500
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qB79PaD2016400
	for <lttng-dev@lists.lttng.org>; Fri, 7 Dec 2012 17:25:36 +0800
In-Reply-To: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
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

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 tests/test_urcu_wfcq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/test_urcu_wfcq.c b/tests/test_urcu_wfcq.c
index 939bf7a..17814a7 100644
--- a/tests/test_urcu_wfcq.c
+++ b/tests/test_urcu_wfcq.c
@@ -544,7 +544,7 @@ int main(int argc, char **argv)
 		       tot_enqueues, tot_dequeues);
 	printf_verbose("total number of successful enqueues : %llu, "
 		       "enqueues to empty dest : %llu, "
-		       "successful dequeues %llu, ",
+		       "successful dequeues %llu, "
 		       "splice : %llu\n",
 		       tot_successful_enqueues,
 		       tot_empty_dest_enqueues,
-- 
1.7.4.4
