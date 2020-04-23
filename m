From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 2/3] Clarify monotonicity requirement on
 timestamp begin
Date: Thu, 23 Apr 2020 16:52:25 -0400
Message-ID: <20200423205226.496-3-mathieu.desnoyers@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 497Tyd0h7Sz1jcn
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 16:52:40 -0400 (EDT)
In-Reply-To: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: gbastien+lttng@versatic.net, matthew.khouzam@ericsson.com, diamon-discuss@linuxfoundation.org, pproulx@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index f5fea51..53b70f4 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -836,10 +836,12 @@ TSDL metadata):
     range between these timestamps should include all event timestamps
     assigned to events contained within the packet. The timestamp at the
     beginning of an event packet is guaranteed to be below or equal the
-    timestamp at the end of that event packet. The timestamp at the end
-    of an event packet is guaranteed to be below or equal the
-    timestamps at the end of any following packet within the same stream.
-    See [Clocks](#spec8) for more detail.
+    timestamp at the end of that event packet. The timestamp at the
+    beginning of an event packet is guaranteed to be above or equal the
+    timestamps at the beginning of any prior packet within the same
+    stream. The timestamp at the end of an event packet is guaranteed to
+    be below or equal the timestamps at the end of any following packet
+    within the same stream. See [Clocks](#spec8) for more detail.
   * **Events discarded count**. Snapshot of a per-stream
     free-running counter, counting the number of events discarded that
     were supposed to be written in the stream after the last event in
-- 
2.11.0
