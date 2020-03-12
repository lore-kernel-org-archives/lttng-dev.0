From: "mingli.yu--- via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: [babeltrace][PATCH v2] fs.c: initialize the other_entry
 variable
Date: Thu, 12 Mar 2020 11:42:07 +0800
Message-ID: <1583984527-121944-1-git-send-email-mingli.yu@windriver.com>
References: <1707083610.24791.1583935086375.JavaMail.zimbra@efficios.com>
Reply-To: mingli.yu@windriver.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by lists.lttng.org (Postfix) with ESMTPS id 48dF5T1tsGz1GwV
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2020 23:42:36 -0400 (EDT)
In-Reply-To: <1707083610.24791.1583935086375.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

From: Mingli Yu <mingli.yu@windriver.com>

Initialize the pointer other_entry to silence the
gcc 9.2.0 compiler warnings:
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
