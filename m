From: Cristiana Voicu <cristiana.voicu@intel.com>
Subject: [PATCH] Fix out of tree build for doc examples
Date: Thu, 31 Oct 2013 13:51:46 +0200
Message-ID: <1383220306-25661-1-git-send-email-cristiana.voicu__22271.8886718669$1383220051$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga14.intel.com ([143.182.124.37])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1VbqiC-0004Jm-JE
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 07:46:53 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Cristiana Voicu <cristiana.voicu@intel.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>

Index: userspace-rcu-0.8.0/doc/examples/Makefile.am
===================================================================
--- userspace-rcu-0.8.0.orig/doc/examples/Makefile.am	2013-08-30 21:25:20.000000000 +0300
+++ userspace-rcu-0.8.0/doc/examples/Makefile.am	2013-10-21 17:52:34.774597179 +0300
@@ -128,7 +128,7 @@
 			cp -fR $(srcdir)/$$subdir $(builddir); \
 		done; \
 	fi
-	$(MAKE) -f dist-files/Makefile AM_CPPFLAGS="$(CPPFLAGS) -I../../../urcu/ -I../../../" AM_CFLAGS='$(CFLAGS)' AM_LDFLAGS='$(LDFLAGS) -L../../../.libs/ -Wl,-rpath="$(PWD)/../../.libs/"' $(AM_MAKEFLAGS) all
+	$(MAKE) -f dist-files/Makefile AM_CPPFLAGS="$(CPPFLAGS) -I$(top_srcdir) -I../../../urcu/ -I../../../" AM_CFLAGS='$(CFLAGS)' AM_LDFLAGS='$(LDFLAGS) -L../../../.libs/ -Wl,-rpath="$(PWD)/../../.libs/"' $(AM_MAKEFLAGS) all
 
 clean-local:
 	$(MAKE) -f dist-files/Makefile $(AM_MAKEFLAGS) clean
