From: Junchang Wang <junchangwang@gmail.com>
Subject: [RFC 4/4] userspace-rcu: Add a brief description of
 rculflist in cds-api.md
Date: Wed, 10 Jul 2019 11:28:10 +0800
Message-ID: <1562729290-6437-5-git-send-email-junchangwang__18411.4226185315$1562729605$gmane$org@gmail.com>
References: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by lists.lttng.org (Postfix) with ESMTPS id 45k4S55pZ7z164C
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jul 2019 23:29:41 -0400 (EDT)
Received: by mail-pf1-x443.google.com with SMTP id b13so385730pfo.1
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jul 2019 20:29:41 -0700 (PDT)
In-Reply-To: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
Cc: paulmck@linux.ibm.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Junchang Wang <junchangwang@gmail.com>
---
 doc/cds-api.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/cds-api.md b/doc/cds-api.md
index 49a3c7c..577126a 100644
--- a/doc/cds-api.md
+++ b/doc/cds-api.md
@@ -82,3 +82,10 @@ are supported. Provides "uniquify add" and "replace add"
 operations, along with associated read-side traversal uniqueness
 guarantees. Automatic hash table resize based on number of
 elements is supported. See the API for more details.
+
+
+### `urcu/rculflist.h`
+
+Ordered singly linked list with lock-free insert, delete and find operations.
+This list relies on RCU for existence guarantees and ABA-problem prevention.
+It is useful for implementing hash tables.
-- 
2.7.4
