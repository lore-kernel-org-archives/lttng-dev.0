From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: [PATCH lttng-tools] Fix: replace 1 for true in libxml
	checking
Date: Mon, 14 Apr 2014 10:42:38 -0400
Message-ID: <20140414144238.GA14396__37084.1366159313$1397486624$gmane$org@psrcode-MS-7693>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1WZi5p-0001ZF-3M
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 10:42:46 -0400
Received: by mail-qg0-f52.google.com with SMTP id q107so8418087qgd.11
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 07:42:35 -0700 (PDT)
Received: from psrcode-MS-7693 (cable-28.246.173-253.electronicbox.net.
 [173.246.28.253])
 by mx.google.com with ESMTPSA id x5sm31693326qaj.9.2014.04.14.07.42.34
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Mon, 14 Apr 2014 07:42:35 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Initial bug on ./configure:
checking for libxml - version >= 2.7.6... yes (version 2.9.1)
./configure: line 5137: 1: command not found

Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 54f82cf..a8fd7f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -147,7 +147,7 @@ AC_CHECK_LIB([popt], [poptGetContext], [],
 	[AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])]
 )
 
-AM_PATH_XML2(2.7.6, 1, AC_MSG_ERROR(No supported version of libxml2 found.))
+AM_PATH_XML2(2.7.6, true, AC_MSG_ERROR(No supported version of libxml2 found.))
 
 # Check for libuuid
 AC_CHECK_LIB([uuid], [uuid_generate],
-- 
1.8.3.2
