From: Vomlehn <vomlehnd@amazon.com>
Subject: [PATCH lttv] Modify documentation for git tree builds,
 common usage, installing as root
Date: Mon, 19 Aug 2013 12:34:16 -0700
Message-ID: <20130819193416.GA9139__28509.95116537$1376940923$gmane$org@ub8ca3a8c12a551e580d6.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=93604f4b1=vomlehnd@amazon.com>)
	id 1VBVDg-0001g9-NE
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 15:34:34 -0400
Received: from ub8ca3a8c12a551e580d6.ant.amazon.com
	(ub8ca3a8c12a551e580d6.ant.amazon.com [10.49.76.115])
	by smtp-in-5102.iad5.amazon.com (8.13.8/8.13.8) with ESMTP id
	r7JJYFCm008697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 19:34:16 GMT
Received: from ub8ca3a8c12a551e580d6.ant.amazon.com (localhost [127.0.0.1])
	by ub8ca3a8c12a551e580d6.ant.amazon.com (8.14.4/8.14.4/Debian-2ubuntu2)
	with ESMTP id r7JJYGpS009302
	for <lttng-dev@lists.lttng.org>; Mon, 19 Aug 2013 12:34:16 -0700
Received: (from vomlehnd@localhost)
	by ub8ca3a8c12a551e580d6.ant.amazon.com (8.14.4/8.14.4/Submit) id
	r7JJYGaa009299
	for lttng-dev@lists.lttng.org; Mon, 19 Aug 2013 12:34:16 -0700
Content-Disposition: inline
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

Modify documentation for git tree builds, common usage, installing as root

o	Document the use of the bootstrap shell script for builds starting
	with a git tree.
o	Use "$" to precede sample shell commands as it is more common that "-".
o	Note that the "make install" should be done as root.
---
 README |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 98849b3..24e7f4f 100644
--- a/README
+++ b/README
@@ -31,9 +31,16 @@ libc6 development librairies
 
 To compile the source tree from a tarball, simply follow these steps :
 
-- ./configure
-- make
-- make install
+$ ./configure
+$ make
+(as root)
+$ make install
+
+To compile from a git checkout, use:
+
+$ ./bootstrap
+
+and then follow the steps to compile from a tarball.
 
 After running ./configure, you can also go in specific subdirectories and
 use make, make install.
-- 
David VL
