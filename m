From: ravi <ravi@linux.vnet.ibm.com>
Subject: Support for new arch 'ppc64le'
Date: Mon, 03 Mar 2014 06:32:12 +0530
Message-ID: <5313D494.5040508__20546.7145111927$1393808625$gmane$org@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040501020901040403070901"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ravi@linux.vnet.ibm.com>) id 1WKHGz-0006zH-Ih
	for lttng-dev@lists.lttng.org; Sun, 02 Mar 2014 20:02:32 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <ravi@linux.vnet.ibm.com>;
	Mon, 3 Mar 2014 06:32:17 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 22DA73940023
	for <lttng-dev@lists.lttng.org>; Mon,  3 Mar 2014 06:32:15 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	s2312GHl64684238
	for <lttng-dev@lists.lttng.org>; Mon, 3 Mar 2014 06:32:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s2312Df6002288
	for <lttng-dev@lists.lttng.org>; Mon, 3 Mar 2014 06:32:13 +0530
Received: from [9.79.223.19] ([9.79.223.19])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s2312Dd1002274
	for <lttng-dev@lists.lttng.org>; Mon, 3 Mar 2014 06:32:13 +0530
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

This is a multi-part message in MIME format.
--------------040501020901040403070901
Content-Type: multipart/alternative;
 boundary="------------050006060508020704040701"


--------------050006060508020704040701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

        We are in the process of adding support for new architecture 
'ppc64le' (PowerPC 64 Little Endian) and as part of that, We have worked 
with libtool maintainer to get alpha release (links below) which has all 
the needed bits to support building on ppc64le arch.
ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz(1.6MB)
ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz(920KB)
(A stable libtool release is expected soon this year)

' userspace-rcu-0.8.1' didn't build on 'ppc64le' system because of 
outdated libtoo.m4/config.guess files.
Latest ' liburcu' source package we picked is from : 
http://lttng.org/files/urcu/userspace-rcu-0.8.1.tar.bz2

Along with changes to libtool related files,  we have found a patch 
available in ubuntu src repo, which is required to build 'liburcu' 
successfully on 'ppc64le' system.
Im attaching the same patch which is created on top of "liburcu-0.7.7-1"...

hence we request you to apply attached patch , and spin off a new 
version of 'liburcu' using the latest libtool alpha release . So that we 
can test ppc64le fixes.
Your response is highly appreciated

-- 
Ravindran
IBM LinuxTechnologyCenter


--------------050006060508020704040701
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi,
    <br>
    <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We are in the process of adding support for new architecture
    'ppc64le' (PowerPC 64 Little Endian) and as part of that, We have
    worked with libtool maintainer to get alpha release (links below)
    which has all the needed bits to support building on ppc64le arch.
    <br>
    <a class="moz-txt-link-freetext"
href="ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz%281.6MB%29">ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz(1.6MB)</a>
    <br>
    <a class="moz-txt-link-freetext"
href="ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz%28920KB%29">ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz(920KB)</a>
    <br>
    (A stable libtool release is expected soon this year)
    <br>
    <br>
    '&nbsp;
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    userspace-rcu-0.8.1' didn't build on 'ppc64le' system because of
    outdated libtoo.m4/config.guess files.
    <br>
    Latest '
    <meta http-equiv="content-type" content="text/html;
      charset=ISO-8859-1">
    liburcu' source package we picked is from :
    <a class="moz-txt-link-freetext" href="http://lttng.org/files/urcu/userspace-rcu-0.8.1.tar.bz2">http://lttng.org/files/urcu/userspace-rcu-0.8.1.tar.bz2</a><br>
    <br>
    Along with changes to libtool related files,&nbsp; we have found a patch
    available in ubuntu src repo, which is required to build 'liburcu'
    successfully on 'ppc64le' system.
    <br>
    Im attaching the same patch which is created on top of
    "liburcu-0.7.7-1"...<br>
    <br>
    hence we request you to apply attached patch , and spin off a new
    version of 'liburcu' using the latest libtool alpha release .&nbsp;
    So that we can test ppc64le fixes.
    <br>
    Your response is highly appreciated
    <pre class="moz-signature" cols="72">-- 
Ravindran
IBM LinuxTechnologyCenter</pre>
  </body>
</html>

--------------050006060508020704040701--

--------------040501020901040403070901
Content-Type: text/x-patch;
 name="arm64-archtype.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="arm64-archtype.patch"

Description: Use gcc atomics on aarch64 for bootstrapping.
Author: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>

Index: b/configure.ac
===================================================================
--- a/configure.ac	2013-06-19 01:08:41.000000000 +0000
+++ b/configure.ac	2013-12-22 11:17:28.821288999 +0000
@@ -69,6 +69,7 @@
 	[powerpc], [ARCHTYPE="ppc"],
 	[ppc64], [ARCHTYPE="ppc"],
 	[powerpc64], [ARCHTYPE="ppc"],
+	[powerpc64le], [ARCHTYPE="gcc"],
 	[ppc], [ARCHTYPE="ppc"],
 	[s390], [ARCHTYPE="s390"],
 	[s390x], [ARCHTYPE="s390"],
@@ -78,6 +79,7 @@
 	[ia64], [ARCHTYPE="gcc"],
 	[arm*], [ARCHTYPE="arm"],
 	[mips*], [ARCHTYPE="mips"],
+	[aarch64], [ARCHTYPE="gcc"],
 	[ARCHTYPE="unknown"]
 )
 

--------------040501020901040403070901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------040501020901040403070901--
