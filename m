From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 19/24] Android : Looking for pthread
	in libc
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-20-git-send-email-c.briere__35697.250653948$1414443695$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEb-0007nm-4M
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:50 -0400
Received: from uscpsbgex3.samsung.com
 (u124.gpu85.samsung.co.kr [203.254.195.124]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4004IOF6MPV30@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:34 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Pthread in included in BIONIC libc

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 16852b1..45c6b30 100644
--- a/configure.ac
+++ b/configure.ac
@@ -150,7 +150,9 @@ AC_DEFINE_DIR([CONFIG_LTTNG_SYSTEM_DATADIR],[datadir], [LTTng system data direct
 #
 # Check for pthread
 AC_CHECK_LIB([pthread], [pthread_create], [],
-	[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])]
+	[AC_CHECK_LIB([c], [pthread_create], [],
+		[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])]
+	)]
 )
 
 # Check libpopt
-- 
2.1.2
