From: Vomlehn <vomlehnd@amazon.com>
Subject: [PATCH lttv] Add build instructions for git tree pulls
 and use more standard formatting
Date: Wed, 7 Aug 2013 12:48:53 -0700
Message-ID: <20130807194853.GA11032__46991.6777023629$1375908400$gmane$org@ub8ca3a8c12a551e580d6.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=924a95d67=vomlehnd@amazon.com>)
	id 1V79jA-00046g-GP
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 15:49:05 -0400
Received: from ub8ca3a8c12a551e580d6.ant.amazon.com
	(ub8ca3a8c12a551e580d6.ant.amazon.com [10.49.76.115])
	by smtp-in-1002.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id
	r77Jmvk5006550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Wed, 7 Aug 2013 19:48:58 GMT
Received: from ub8ca3a8c12a551e580d6.ant.amazon.com (localhost [127.0.0.1])
	by ub8ca3a8c12a551e580d6.ant.amazon.com (8.14.4/8.14.4/Debian-2ubuntu2)
	with ESMTP id r77Jmssc011116
	for <lttng-dev@lists.lttng.org>; Wed, 7 Aug 2013 12:48:54 -0700
Received: (from vomlehnd@localhost)
	by ub8ca3a8c12a551e580d6.ant.amazon.com (8.14.4/8.14.4/Submit) id
	r77JmrAP011113
	for lttng-dev@lists.lttng.org; Wed, 7 Aug 2013 12:48:53 -0700
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

If the source is obtained directly from git, the file "configure" must be
built with the autoconf tools. In addition, example shell commands are
traditionally preceeded with a "$" instead of a "-", so this convention
is used.
---
 README |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 98849b3..ac28f9e 100644
--- a/README
+++ b/README
@@ -31,9 +31,16 @@ libc6 development librairies
 
 To compile the source tree from a tarball, simply follow these steps :
 
-- ./configure
-- make
-- make install
+  $ ./configure
+  $ make
+  $ make install
+
+To compile the source tree from a git checkout, use:
+
+  $ autoreconf
+  $ automake --add-missing --gnu
+  $ make
+  $ make install
 
 After running ./configure, you can also go in specific subdirectories and
 use make, make install.
-- 
David VL
