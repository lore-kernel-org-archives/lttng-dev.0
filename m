From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH] Clarify limitations of the --syscall flag with
	enable-event command
Date: Wed, 16 Apr 2014 12:26:25 -0400
Message-ID: <1397665585-31197-1-git-send-email-christian.babeux__9943.03567936203$1397665675$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <christian.babeux@0x80.ca>) id 1WaSfn-00024f-Uf
 for lttng-dev@lists.lttng.org; Wed, 16 Apr 2014 12:27:01 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so2197582qga.17
 for <lttng-dev@lists.lttng.org>; Wed, 16 Apr 2014 09:26:50 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 doc/man/lttng.1 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index 972f71c..9882083 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -541,7 +541,9 @@ Dynamic function entry/return probe. Addr and offset can be octal
 .BR "\-\-syscall"
 System call event. Enabling syscalls tracing (kernel tracer), you will
 not be able to disable them with disable-event. This is a known
-limitation. You can disable the entire channel to do the trick.
+limitation. You can disable the entire channel to do the trick. Also note
+that per-syscall selection is not supported yet. Use with "-a" to enable
+all syscalls.
 .TP
 .BR "\-\-filter 'expression'"
 Set a filter on a newly enabled event. Filter expression on event
-- 
1.9.2
