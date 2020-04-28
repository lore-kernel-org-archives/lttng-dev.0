From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 3/4] Clarify that timestamp begin/end
 need to be complete clock values
Date: Tue, 28 Apr 2020 15:12:26 -0400
Message-ID: <20200428191227.16560-3-mathieu.desnoyers@efficios.com>
References: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BWW11KbSz1nM1
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 15:12:45 -0400 (EDT)
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
 common-trace-format-specification.md | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index 55d0601..5732e92 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -837,11 +837,12 @@ TSDL metadata):
     assigned to events contained within the packet. The timestamp at the
     beginning of an event packet is guaranteed to be below or equal the
     timestamp at the end of that event packet. The timestamp at the
-    beginning of an event packet is guaranteed to be above or equal the
-    timestamps at the beginning of any prior packet within the same
-    stream. The timestamp at the end of an event packet is guaranteed to
-    be below or equal the timestamps at the end of any following packet
-    within the same stream. See [Clocks](#spec8) for more detail.
+    beginning of an event packet is guaranteed to be grater than or
+    equal to timestamps at the beginning of any prior packet within the
+    same stream. The timestamp at the end of an event packet is
+    guaranteed to be less than or equal to the timestamps at the end of
+    any following packet within the same stream. See [Clocks](#spec8)
+    for more detail.
   * **Events discarded count**. Snapshot of a per-stream
     free-running counter, counting the number of events discarded that
     were supposed to be written in the stream after the last event in
@@ -1580,7 +1581,8 @@ stream {
 };
 ~~~
 
-For a N-bit integer type referring to a clock, if the integer overflows
+Within the stream event context, event context, and event payload,
+fields of N-bit integer type referring to a clock, if the integer overflows
 compared to the N low order bits of the clock prior value found in the
 same stream, then it is assumed that one, and only one, overflow
 occurred. It is therefore important that events encoding time on a small
@@ -1589,8 +1591,8 @@ N-bit overflow occurs.
 
 In a packet context, clock field names ending with `_begin` and `_end`
 have a special meaning: this refers to the timestamps at, respectively,
-the beginning and the end of each packet.
-
+the beginning and the end of each packet. Those are required to be
+complete representations of the clock value.
 
 ## A. Helper macros
 
-- 
2.11.0
