From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 1/4] Clarify that unlisted enumeration
 values are allowed
Date: Tue, 28 Apr 2020 15:12:24 -0400
Message-ID: <20200428191227.16560-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BWW03Wjqz1n2V
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 15:12:44 -0400 (EDT)
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
 common-trace-format-specification.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index fd49e59..d6d196c 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -464,6 +464,9 @@ enum {
 }
 ~~~
 
+An enumeration field can have an integral value which its type does not
+map to a string.
+
 ### 4.2 Compound types
 
 Compound are aggregation of type declarations. Compound types include
-- 
2.11.0
