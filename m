From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 3/3] Clarify that timestamp begin/end
 need to be complete clock values
Date: Thu, 23 Apr 2020 16:52:26 -0400
Message-ID: <20200423205226.496-4-mathieu.desnoyers@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 497Tyd5hbvz1jZp
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 16:52:41 -0400 (EDT)
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
 common-trace-format-specification.md | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index 53b70f4..7681ce5 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -1580,7 +1580,8 @@ stream {
 };
 ~~~
 
-For a N-bit integer type referring to a clock, if the integer overflows
+Within the stream event context, event context, and event payload,
+fields of N-bit integer type referring to a clock, if the integer overflows
 compared to the N low order bits of the clock prior value found in the
 same stream, then it is assumed that one, and only one, overflow
 occurred. It is therefore important that events encoding time on a small
@@ -1589,8 +1590,8 @@ N-bit overflow occurs.
 
 In a packet context, clock field names ending with `_begin` and `_end`
 have a special meaning: this refers to the timestamps at, respectively,
-the beginning and the end of each packet.
-
+the beginning and the end of each packet. Those are required to be
+complete representations of the clock value.
 
 ## A. Helper macros
 
-- 
2.11.0
