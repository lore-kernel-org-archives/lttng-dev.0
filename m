From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-tools] Add dependency to libcommon for
	python binding
Date: Thu,  5 Jun 2014 12:39:48 +0200
Message-ID: <1401964788-24312-1-git-send-email-paul_woegerer__38856.660857755$1401964865$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1WsV5U-0006n5-VU
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 06:40:04 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1WsV5O-00029w-Eb from Paul_Woegerer@mentor.com
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 03:39:54 -0700
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

Using the python binding library currently results in in the following error message:

ImportError: No module named '_lttng'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "./test_daemon.py", line 31, in <module>
    from test_utils import *
  File "/home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/tests/utils/test_utils.py", line 33, in <module>
    from lttng import *
  File "/home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/extras/bindings/swig/python/lttng.py", line 34, in <module>
    _lttng = swig_import_helper()
  File "/home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/extras/bindings/swig/python/lttng.py", line 26, in swig_import_helper
    import _lttng
ImportError: /home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/extras/bindings/swig/python/.libs/_lttng.so: undefined symbol: log_add_time

This patch adds the missing dependency to libcommon that contains the definition of log_add_time.

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 extras/bindings/swig/python/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/extras/bindings/swig/python/Makefile.am b/extras/bindings/swig/python/Makefile.am
index caf1934..ec35930 100644
--- a/extras/bindings/swig/python/Makefile.am
+++ b/extras/bindings/swig/python/Makefile.am
@@ -13,7 +13,8 @@ MAINTAINERCLEANFILES = lttng_wrap.c lttng.py
 nodist__lttng_la_SOURCES = lttng_wrap.c
 _lttng_la_LDFLAGS = -module
 _lttng_la_LIBADD = 	$(top_srcdir)/src/lib/lttng-ctl/liblttng-ctl.la 		\
-			$(top_srcdir)/src/common/sessiond-comm/libsessiond-comm.la
+			$(top_srcdir)/src/common/sessiond-comm/libsessiond-comm.la		\
+			$(top_srcdir)/src/common/libcommon.la
 
 lttng_wrap.c: lttng.i
 	$(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i
-- 
1.9.3
