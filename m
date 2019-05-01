From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [RFC PATCH lttng-tools v2 07/20] Document
 inter-proccesses communication protocols requirements
Date: Wed,  1 May 2019 15:34:31 -0400
Message-ID: <20190501193444.17403-8-ylamarre__4318.69865148968$1556739878$gmane$org@efficios.com>
References: <20190501193444.17403-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44vTBC6b42z1Kj4
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 15:34:59 -0400 (EDT)
In-Reply-To: <20190501193444.17403-1-ylamarre@efficios.com>
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

The introduction of serialization changes previously established
requirements for lttng-tools.
This document drafts the guidelines to follow in future communication
protocol development.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
Unsure how this document should be structured and what specific information
should be kept here or even if it's the right place.
It might be interesting to move this to lttng-doc since it is likely to also
document communication protocols between consumers (ust and kernel modules)
and the sessiond.

 doc/comm-requirements.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 doc/comm-requirements.txt

diff --git a/doc/comm-requirements.txt b/doc/comm-requirements.txt
new file mode 100644
index 00000000..7f62260d
--- /dev/null
+++ b/doc/comm-requirements.txt
@@ -0,0 +1,9 @@
+LTTng Communication Protocols' Requirements
+Yannick Lamarre, April 2019
+
+This document describes the requirements for the development of communication
+protocols.
+The integration of serialization officially breaks from the implicit
+requirement to keep backward compatibility by removing padding fields from
+serialized structures. This forces users to upgrade in a lock-step fashion.
+
-- 
2.11.0
