From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools 2/4] Tests: Add helper functions
	for printing status and test banner
Date: Mon, 24 Sep 2012 12:11:45 -0400
Message-ID: <1348503107-3830-3-git-send-email-christian.babeux__33426.6330035918$1348503159$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
	<1348503107-3830-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TGBGT-00031u-G9
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 12:12:09 -0400
Received: by mail-vb0-f48.google.com with SMTP id e21so7755995vbm.35
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 09:12:09 -0700 (PDT)
In-Reply-To: <1348503107-3830-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add three new printing functions:

print_ok: Print the OK status with optional color support.
print_fail: Print the FAIL status with optional color support.
print_test_banner: Print a test banner of the test description.

e.g.:
   	   sometest.sh:
	   TEST_DESC="A really useful test"
   	   [...]
	   source $TESTDIR/utils.sh
	   print_test_banner
	   [...]
	   print_ok
	   print_fail
	   [...]

	   $ ./sometest.sh
	   ----------------------
	    A really useful test
	   ----------------------
	   OK
	   FAIL

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/utils.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/utils.sh b/tests/utils.sh
index 42b18e3..8fcb0da 100644
--- a/tests/utils.sh
+++ b/tests/utils.sh
@@ -25,6 +25,38 @@ KERNEL_MAJOR_VERSION=2
 KERNEL_MINOR_VERSION=6
 KERNEL_PATCHLEVEL_VERSION=27
 
+function print_ok ()
+{
+	# Check if we are a terminal
+	if [ -t 1 ]; then
+		echo -e "\e[1;32mOK\e[0m"
+	else
+		echo -e "OK"
+	fi
+}
+
+function print_fail ()
+{
+	# Check if we are a terminal
+	if [ -t 1 ]; then
+		echo -e "\e[1;31mFAIL\e[0m"
+	else
+		echo -e "FAIL"
+	fi
+}
+
+function print_test_banner ()
+{
+	desc="$1"
+
+	count=$((${#desc}+2))
+	str=$(printf "%${count}s");
+	echo -e "\n"
+	echo -e ${str// /-}
+	echo -e " $desc "
+	echo -e ${str// /-}
+}
+
 function validate_kernel_version ()
 {
 	kern_version=($(uname -r | awk -F. '{ printf("%d.%d.%d\n",$1,$2,$3); }' | tr '.' '\n'))
-- 
1.7.12
