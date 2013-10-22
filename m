From: Cristiana Voicu <cristiana.voicu@intel.com>
Subject: liburcu fix out of tree build
Date: Tue, 22 Oct 2013 14:23:01 +0300
Message-ID: <1382440981-24074-1-git-send-email-cristiana.voicu__37452.8624852703$1382440756$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga09.intel.com ([134.134.136.24])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1VYZyg-0000de-EV
	for lttng-dev@lists.lttng.org; Tue, 22 Oct 2013 07:18:24 -0400
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

liburcu: fix out of tree build for doc examples
10/22/2013 - created by Cristiana Voicu <cristiana.voicu@intel.com>

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
