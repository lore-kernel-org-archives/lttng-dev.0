From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 01/30] Bump minimum kernel
 version to 3.0
Date: Thu,  8 Nov 2018 16:45:06 -0500
Message-ID: <20181108214535.12081-1-mjeanson__17992.8148784258$1541713434$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKT2z4Fzq8T
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:48 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3779724ACA3
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:48 -0500 (EST)
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

Upstream Linux 3.0 was released 7 years ago, the oldest longterm release
still supported is 3.16. On the distro kernels side, we still cover :

 RHEL / CentOS 7 and up
 SLES11 SP2 and up
 SLES12 and up
 Ubuntu 12.04 (Precise) and up
 Debian 7 (Wheezy) and up
 Fedora 16 and up

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 201a579..66bf925 100644
--- a/README.md
+++ b/README.md
@@ -107,7 +107,7 @@ to print traces as a human-readable text log.
 Support
 -------
 
-Linux kernels >= 2.6.36 are supported.
+Linux kernels >= 3.0 are supported.
 
 
 Notes
-- 
2.17.1
