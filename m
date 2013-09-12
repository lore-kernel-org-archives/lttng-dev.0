From: Stefan Seefeld <stefan@seefeld.name>
Subject: [PATCH] Enable support for installcheck.
Date: Wed, 11 Sep 2013 20:37:41 -0400
Message-ID: <1378946261-16279-2-git-send-email-stefan_seefeld__20921.4740236805$1378946368$gmane$org@mentor.com>
References: <1378946261-16279-1-git-send-email-stefan_seefeld@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1VJuv1-0006IT-0h
	for lttng-dev@lists.lttng.org; Wed, 11 Sep 2013 20:38:02 -0400
Received: by mail-qe0-f54.google.com with SMTP id cy11so5993428qeb.41
	for <lttng-dev@lists.lttng.org>; Wed, 11 Sep 2013 17:37:53 -0700 (PDT)
In-Reply-To: <1378946261-16279-1-git-send-email-stefan_seefeld@mentor.com>
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

Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
---
 tests/Makefile.am | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6d5b00d..3774f9d 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,14 +1,17 @@
 SUBDIRS = utils regression unit stress
 
-if USE_PYTHON
-check-am:
+installcheck-am:
 	./run.sh unit_tests
 	./run.sh fast_regression
+if USE_PYTHON
 	./run.sh with_bindings_regression
-else
+endif
+
 check-am:
 	./run.sh unit_tests
 	./run.sh fast_regression
+if USE_PYTHON
+	./run.sh with_bindings_regression
 endif
 
 dist_noinst_SCRIPTS = run.sh unit_tests fast_regression long_regression root_regression with_bindings_regression
-- 
1.8.3.1
