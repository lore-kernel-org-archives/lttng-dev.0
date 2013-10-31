From: Cristiana Voicu <cristiana.voicu@intel.com>
Subject: [PATCH] Use cross compiler for doc exemples too
Date: Thu, 31 Oct 2013 10:10:44 +0200
Message-ID: <1383207044-30477-1-git-send-email-cristiana.voicu__15515.1214603849$1383206801$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga09.intel.com ([134.134.136.24])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1VbnGJ-0002af-07
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 04:05:52 -0400
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

Index: userspace-rcu-0.8.0/doc/examples/Makefile.examples.template
===================================================================
--- userspace-rcu-0.8.0.orig/doc/examples/Makefile.examples.template	2013-08-30 21:25:20.000000000 +0300
+++ userspace-rcu-0.8.0/doc/examples/Makefile.examples.template	2013-10-23 13:34:30.405550556 +0300
@@ -11,7 +11,9 @@
 #
 # This makefile is purposefully kept simple to support GNU and BSD make.
 
+ifndef CC
 CC = gcc
+endif
 CFLAGS = -g -O2 -Wall
 
 all: $(BINARY)
