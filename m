From: Mohamad Gebai <mohamad.gebai@gmail.com>
Subject: [PATCH lttng-tools] Automatically load kvm-x86 and
	kvm-x86-mmu probes.
Date: Mon,  8 Jul 2013 15:26:27 -0400
Message-ID: <1373311587-11538-1-git-send-email-mohamad.gebai__1227.13416717506$1373311678$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mohamad.gebai@gmail.com>) id 1UwH5c-000869-Tl
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 15:27:13 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so10387136iea.25
	for <lttng-dev@lists.lttng.org>; Mon, 08 Jul 2013 12:27:07 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>
---
 src/bin/lttng-sessiond/modprobe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
index 7e06dad..a010e7c 100644
--- a/src/bin/lttng-sessiond/modprobe.c
+++ b/src/bin/lttng-sessiond/modprobe.c
@@ -55,6 +55,8 @@ const struct kern_modules_param kern_modules_list[] = {
 	{ "lttng-probe-jbd2", 0 },
 	{ "lttng-probe-kmem", 0 },
 	{ "lttng-probe-kvm", 0 },
+	{ "lttng-probe-kvm-x86", 0 },
+	{ "lttng-probe-kvm-x86-mmu", 0 },
 	{ "lttng-probe-lock", 0 },
 	{ "lttng-probe-module", 0 },
 	{ "lttng-probe-napi", 0 },
-- 
1.7.10.4
