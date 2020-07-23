From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF] Clarify signedness of clock offset_s
 and offset fields
Date: Thu, 23 Jul 2020 10:45:03 -0400
Message-ID: <20200723144503.5477-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4BCFVp3XpPz1g1v
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:45:22 -0400 (EDT)
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

Clarify that both offset_s and offset fields of clock may have
negative values.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 common-trace-format-specification.md | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/common-trace-format-specification.md b/common-trace-format-specification.md
index b40082c..d4c69ad 100644
--- a/common-trace-format-specification.md
+++ b/common-trace-format-specification.md
@@ -1545,11 +1545,11 @@ The `offset_s` and `offset` fields indicate the offset from
 POSIX.1 Epoch, 1970-01-01 00:00:00 +0000 (UTC), to the zero of value
 of the clock. The `offset_s` field is in seconds. The `offset` field is
 in (1/freq) units. If any of the `offset_s` or `offset` field is not
-present, it is assigned the 0 value. The field `absolute` is `TRUE` if
-the clock is a global reference across different clock UUID
-(e.g. NTP time). Otherwise, `absolute` is `FALSE`, and the clock can
-be considered as synchronized only with other clocks that have the same
-UUID.
+present, it is assigned the 0 value. Both `offset_s` and `offset`
+fields are signed integers. The field `absolute` is `TRUE` if the clock
+is a global reference across different clock UUID (e.g. NTP time).
+Otherwise, `absolute` is `FALSE`, and the clock can be considered as
+synchronized only with other clocks that have the same UUID.
 
 Secondly, a reference to this clock should be added within an integer
 type:
-- 
2.11.0
