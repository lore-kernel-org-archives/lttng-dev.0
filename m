From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Fix: Initialize fd field of struct
 lttng_ust_elf to -1 at allocation
Date: Wed, 14 Nov 2018 14:38:37 -0500
Message-ID: <20181114193837.23813-1-jonathan.rajotte-julien__30927.6562919424$1542224213$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42wFDB1hTMzs2R
 for <lttng-dev@lists.lttng.org>; Wed, 14 Nov 2018 14:38:49 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C7788249A53
 for <lttng-dev@lists.lttng.org>; Wed, 14 Nov 2018 14:38:42 -0500 (EST)
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

In rare cases when the executable cannot be open, using a default value
of zero lead to invalid close call and fd tracker removal.

fixes #1171

Reported-by: Stefan Palade <stefan.palade@windriver.com>
Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 liblttng-ust/lttng-ust-elf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/liblttng-ust/lttng-ust-elf.c b/liblttng-ust/lttng-ust-elf.c
index c073e7a5..3d6a9379 100644
--- a/liblttng-ust/lttng-ust-elf.c
+++ b/liblttng-ust/lttng-ust-elf.c
@@ -250,6 +250,8 @@ struct lttng_ust_elf *lttng_ust_elf_create(const char *path)
 		goto error;
 	}
 
+	/* Initialize fd field to -1. 0 is a valid fd number */
+	elf->fd = -1;
 
 	elf->path = strdup(path);
 	if (!elf->path) {
-- 
2.17.1
