From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 4/4] Use the formulation "less than or
 equal to" rather than "below or equal"
Date: Tue, 28 Apr 2020 15:12:27 -0400
Message-ID: <20200428191227.16560-4-mathieu.desnoyers@efficios.com>
References: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BWW20wg1z1mrF
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 15:12:46 -0400 (EDT)
In-Reply-To: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: diamon-discuss@lists.linuxfoundation.org
Cc: Jeremie Galarneau <jgalar@efficios.com>, lttng-dev@lists.lttng.org, Philippe Proulx <pproulx@efficios.com>, Genevieve Bastien <gbastien+lttng@versatic.net>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index 5732e92..8a3a745 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -835,9 +835,9 @@ TSDL metadata):
     while (or after) writing the last event in the packet. The inclusive
     range between these timestamps should include all event timestamps
     assigned to events contained within the packet. The timestamp at the
-    beginning of an event packet is guaranteed to be below or equal the
-    timestamp at the end of that event packet. The timestamp at the
-    beginning of an event packet is guaranteed to be grater than or
+    beginning of an event packet is guaranteed to be less than or equal
+    to the timestamp at the end of that event packet. The timestamp at
+    the beginning of an event packet is guaranteed to be grater than or
     equal to timestamps at the beginning of any prior packet within the
     same stream. The timestamp at the end of an event packet is
     guaranteed to be less than or equal to the timestamps at the end of
-- 
2.11.0
