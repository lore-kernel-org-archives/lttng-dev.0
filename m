From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-module patch] Improve documentation of the
	syscall extractor script
Date: Mon,  1 Jul 2013 12:24:27 -0400
Message-ID: <1372695867-5068-1-git-send-email-yannick.brosseau__22578.091818332$1373039995$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uv8Ps-0006HN-Di
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 11:59:24 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so2996561obc.24
	for <lttng-dev@lists.lttng.org>; Fri, 05 Jul 2013 08:59:19 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 instrumentation/syscalls/README                             |    2 +-
 instrumentation/syscalls/lttng-syscalls-generate-headers.sh |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/instrumentation/syscalls/README b/instrumentation/syscalls/README
index 6c235e1..1e9bec4 100644
--- a/instrumentation/syscalls/README
+++ b/instrumentation/syscalls/README
@@ -12,7 +12,7 @@ is expected). See the dmesg output for system call metadata.
 
 Take the dmesg metadata and feed it to lttng-syscalls-generate-headers.sh, e.g.,
 from the instrumentation/syscalls directory. See the script header for
-usage example.
+usage example. It should be run for both the integers and pointers types.
 
 After these are created, we just need to follow the new system call additions,
 no need to regenerate the whole thing, since system calls are only appended to.
diff --git a/instrumentation/syscalls/lttng-syscalls-generate-headers.sh b/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
index 1754ae8..4ab4599 100755
--- a/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
+++ b/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
@@ -1,8 +1,12 @@
 #!/bin/sh
 
 # Generate system call probe description macros from syscall metadata dump file.
+# The resulting header will be written in the headers subdirectory, in a file name
+# based on the name of the input file. 
+#
 # example usage:
 #
+# lttng-syscalls-generate-headers.sh <type> <input_dir> <input_filename_in_dir> <bitness>
 # lttng-syscalls-generate-headers.sh integers 3.0.4 x86-64-syscalls-3.0.4 64
 # lttng-syscalls-generate-headers.sh pointers 3.0.4 x86-64-syscalls-3.0.4 64
 
-- 
1.7.10.4
