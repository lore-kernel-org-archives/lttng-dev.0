From: Stefan Seefeld <stefan@seefeld.name>
Subject: [PATCH 1/2] Add --with-lttng-ust-prefix config option.
Date: Mon, 16 Sep 2013 19:50:39 -0400
Message-ID: <1379375440-24087-2-git-send-email-stefan_seefeld__25544.0618414015$1379375647$gmane$org@mentor.com>
References: <1379375440-24087-1-git-send-email-stefan_seefeld@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1VLiZA-0002uC-H8
	for lttng-dev@lists.lttng.org; Mon, 16 Sep 2013 19:50:58 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so4726159pbc.32
	for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2013 16:50:46 -0700 (PDT)
In-Reply-To: <1379375440-24087-1-git-send-email-stefan_seefeld@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Stefan Seefeld <stefan@codesourcery.com>
List-Id: lttng-dev@lists.lttng.org

From: Stefan Seefeld <stefan@codesourcery.com>

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 configure.ac | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index f5f4b26..f4d5ad4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -196,6 +196,15 @@ AC_ARG_WITH(lttng-ust-prefix,
 		    LDFLAGS="$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
 		  ])
 
+AC_ARG_WITH(lttng-ust-prefix,
+  AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
+                 [Specify the installation prefix of the lttng-ust library.
+	          Headers must be in PATH/include; libraries in PATH/lib.]),
+		  [
+		    CPPFLAGS="$CPPFLAGS -I${withval}/include"
+		    LDFLAGS="$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
+		  ])
+
 # Check liblttng-ust-ctl library
 AC_ARG_ENABLE(lttng-ust,
 	AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST (Userspace Tracing) support]),
-- 
1.8.3.1
