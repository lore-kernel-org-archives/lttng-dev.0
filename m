From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH ust] Add missing --record in Python's Makefile
Date: Wed, 14 Oct 2015 01:34:36 -0400
Message-ID: <1444800876-23552-1-git-send-email-simon.marchi__16000.4892888994$1444800940$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [96.127.255.83] (helo=smtp.electronicbox.net)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1ZmEi2-0002cn-9r
 for lttng-dev@lists.lttng.org; Wed, 14 Oct 2015 01:34:43 -0400
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

I believe this is missing.  Fixes this error when doing

  $ make install DESTDIR=/tmp/lttng-ust2

make[1]: Entering directory '/home/simark/src/lttng-ust/liblttng-ust-python-agent'
if [ "/tmp/lttng-ust2" = "" ]; then \
	/usr/bin/python setup.py install --prefix=/tmp/lttng-ust --record install_files.txt  --verbose --no-compile ;  \
else \
	/usr/bin/python setup.py install --root=/tmp/lttng-ust2 --verbose install_files.txt  --prefix=/tmp/lttng-ust --no-compile ; \
fi
invalid command name 'install_files.txt'
Makefile:713: recipe for target 'install-exec-local' failed
make[1]: *** [install-exec-local] Error 1
make[1]: Leaving directory '/home/simark/src/lttng-ust/liblttng-ust-python-agent'
Makefile:594: recipe for target 'install-am' failed
make: *** [install-am] Error 2

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 liblttng-ust-python-agent/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/liblttng-ust-python-agent/Makefile.am b/liblttng-ust-python-agent/Makefile.am
index f80b8a3..8bac3fb 100644
--- a/liblttng-ust-python-agent/Makefile.am
+++ b/liblttng-ust-python-agent/Makefile.am
@@ -18,7 +18,7 @@ install-exec-local:
 	if [ "$(DESTDIR)" = "" ]; then \
 		$(PYTHON) setup.py install --prefix=$(prefix) --record install_files.txt  --verbose --no-compile $(DISTSETUPOPTS);  \
 	else \
-		$(PYTHON) setup.py install --root=$(DESTDIR) --verbose install_files.txt  --prefix=$(prefix) --no-compile $(DISTSETUPOPTS); \
+		$(PYTHON) setup.py install --root=$(DESTDIR) --verbose --record install_files.txt  --prefix=$(prefix) --no-compile $(DISTSETUPOPTS); \
 	fi
 clean-local:
 	rm -rf build
-- 
2.6.1
