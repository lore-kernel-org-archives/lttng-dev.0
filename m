From: <mingli.yu@windriver.com>
Subject: [babeltrace][PATCH] fs.c: initialize the other_entry
 variable
Date: Wed, 11 Mar 2020 21:39:30 +0800
Message-ID: <1583933970-68840-1-git-send-email-mingli.yu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by lists.lttng.org (Postfix) with ESMTPS id 48ctNk5nKZz1G1L
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2020 09:39:34 -0400 (EDT)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 02BDdWle023679
 (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2020 06:39:32 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

From: Mingli Yu <mingli.yu@windriver.com>

Initialize the pointer other_entry to fix the below error:
| ../../../../../git/src/plugins/ctf/fs-src/fs.c: In function 'ds_index_insert_ds_index_entry_sorted':
| ../../../../../git/src/plugins/ctf/fs-src/fs.c:702:5: error: 'other_entry' may be used uninitialized in this function [-Werror=maybe-uninitialized]
|  702 |    !ds_index_entries_equal(entry, other_entry)) {

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 src/plugins/ctf/fs-src/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/plugins/ctf/fs-src/fs.c b/src/plugins/ctf/fs-src/fs.c
index e87523a..a6b5315 100644
--- a/src/plugins/ctf/fs-src/fs.c
+++ b/src/plugins/ctf/fs-src/fs.c
@@ -680,7 +680,7 @@ void ds_index_insert_ds_index_entry_sorted(
 	struct ctf_fs_ds_index_entry *entry)
 {
 	guint i;
-	struct ctf_fs_ds_index_entry *other_entry;
+	struct ctf_fs_ds_index_entry *other_entry = NULL;
 
 	/* Find the spot where to insert this index entry. */
 	for (i = 0; i < index->entries->len; i++) {
-- 
2.7.4
