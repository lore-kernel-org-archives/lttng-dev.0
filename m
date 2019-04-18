From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools 16/18] Add serialized versions
 of lttng_event structs
Date: Thu, 18 Apr 2019 12:18:48 -0400
Message-ID: <20190418161850.1536-17-ylamarre__5664.80523427657$1555604757$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lPS633RNz1Jp7
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 12:19:02 -0400 (EDT)
In-Reply-To: <20190418161850.1536-1-ylamarre@efficios.com>
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Serialized version of lttng_snapshot_output is a packed structure to be
used in communication protocols for consistent size across platforms.
The serialized version is stripped of pointers and padding.

Pointers are removed since their size can vary on platforms supporting
variable sized registers (x86-64).
Padding is also removed since it defeats the purpose of a packed struct.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 include/lttng/snapshot-internal.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/lttng/snapshot-internal.h b/include/lttng/snapshot-internal.h
index b7391c22..bf9dfbe4 100644
--- a/include/lttng/snapshot-internal.h
+++ b/include/lttng/snapshot-internal.h
@@ -45,6 +45,14 @@ struct lttng_snapshot_output {
 	char data_url[PATH_MAX];
 };
 
+struct lttng_snapshot_output_serialized {
+	uint32_t id;
+	uint64_t max_size;
+	char name[LTTNG_NAME_MAX];
+	char ctrl_url[PATH_MAX];
+	char data_url[PATH_MAX];
+} LTTNG_PACKED;
+
 /*
  * Snapshot output list object opaque to the user.
  */
-- 
2.11.0
