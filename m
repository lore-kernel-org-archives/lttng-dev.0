From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Build: fallback to AC_CHECK_LIBS
	when looking for popt and uuid
Date: Tue,  1 Dec 2015 15:19:01 -0500
Message-ID: <1449001141-25393-1-git-send-email-jonathan.rajotte-julien__6555.67362341589$1449001226$gmane$org@efficios.com>
References: <CA+jJMxsz6+erSA2joBgH2+PrYZrnaA-89m54=Gg3HeHyCXOxoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1a3rOY-0006yO-6G
 for lttng-dev@lists.lttng.org; Tue, 01 Dec 2015 15:19:30 -0500
In-Reply-To: <CA+jJMxsz6+erSA2joBgH2+PrYZrnaA-89m54=Gg3HeHyCXOxoQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Not all distro ship .pc so fallback to basic libs searching if necessary.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/configure.ac b/configure.ac
index 978e3bc..5537c15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -214,13 +214,23 @@ AC_DEFINE_DIR([CONFIG_LTTNG_SYSTEM_DATADIR],[datadir], [LTTng system data direct
 #
 # Check for pthread
 AC_CHECK_LIB([pthread], [pthread_create], [],
-	[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])]
+	[AC_MSG_ERROR([Cannot find libpthread. Use LDFLAGS=-Ldir to specify its location.])]
 )
 
 # Check libpopt
 PKG_CHECK_MODULES([POPT], [popt],
 	[LIBS="$LIBS $POPT_LIBS"],
-	[AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])]
+	[
+		AC_MSG_WARN([pkg-config was unable to find a valid .pc for libpopt. Set PKG_CONFIG_PATH to specify the pkgconfig configuration file location])
+		AC_MSG_WARN([Finding libpopt without pkg-config.])
+		AC_CHECK_LIB([popt],
+			[poptGetContext],
+			[],
+			[
+				 AC_MSG_ERROR([Cannot find libpopt. Either set PKG_CONFIG_PATH to the configuration file location or use LDFLAGS=-Ldir to specify the library location])
+			]
+		)
+	]
 )
 
 AM_PATH_XML2(2.7.6, true, AC_MSG_ERROR(No supported version of libxml2 found.))
@@ -233,17 +243,29 @@ PKG_CHECK_MODULES([UUID], [uuid],
 	have_libuuid=yes
 ],
 [
-	# libuuid not found, check for uuid_create in libc.
-	AC_CHECK_LIB([c], [uuid_create],
-	[
-		AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBC_UUID], 1, [Has libc uuid support.])
-		have_libc_uuid=yes
-	],
-	[
-		AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
-	])
-]
-)
+	AC_MSG_WARN([pkg-config was unable to find a valid .pc for libuuid. Set PKG_CONFIG_PATH to specify the pkgconfig configuration file location])
+	AC_MSG_WARN([Finding libuuid without pkg-config.])
+	AC_CHECK_LIB([uuid],
+		[uuid_generate],
+		[
+			AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBUUID], 1, [Has libuuid support.])
+			have_libuuid=yes
+		],
+		[
+			# libuuid not found, check for uuid_create in libc.
+			AC_CHECK_LIB([c],
+				[uuid_create],
+				[
+					AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBC_UUID], 1, [Has libc uuid support.])
+					have_libc_uuid=yes
+				],
+				[
+					AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Either set PKG_CONFIG_PATH to the configuration file location or use LDFLAGS=-Ldir to specify the library location])
+				]
+			)
+		]
+	)
+])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
 
-- 
2.5.0
