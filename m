From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Fix python agent
	build/install/uninstall with DESTDIR specified
Date: Fri, 16 Oct 2015 15:07:31 -0400
Message-ID: <1445022451-9748-1-git-send-email-jonathan.rajotte-julien__1755.60383727333$1445022536$gmane$org@efficios.com>
References: <1709596766.52753.1444944270873.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZnAM4-0004Ta-8l
 for lttng-dev@lists.lttng.org; Fri, 16 Oct 2015 15:07:53 -0400
In-Reply-To: <1709596766.52753.1444944270873.JavaMail.zimbra@efficios.com>
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

Remove the install_files.txt record since it's simpler to delete the complete
folder on uninstall.

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 liblttng-ust-python-agent/Makefile.am | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/liblttng-ust-python-agent/Makefile.am b/liblttng-ust-python-agent/Makefile.am
index f80b8a3..e2a15f4 100644
--- a/liblttng-ust-python-agent/Makefile.am
+++ b/liblttng-ust-python-agent/Makefile.am
@@ -15,16 +15,16 @@ all-local:
 	$(PYTHON) setup.py build --verbose
 
 install-exec-local:
-	if [ "$(DESTDIR)" = "" ]; then \
-		$(PYTHON) setup.py install --prefix=$(prefix) --record install_files.txt  --verbose --no-compile $(DISTSETUPOPTS);  \
-	else \
-		$(PYTHON) setup.py install --root=$(DESTDIR) --verbose install_files.txt  --prefix=$(prefix) --no-compile $(DISTSETUPOPTS); \
-	fi
+	@opts="--prefix=$(prefix) --verbose --no-compile $(DISTSETUPOPTS)"; \
+	if [ "$(DESTDIR)" != "" ]; then \
+		opts="$$opts --root=$(DESTDIR)"; \
+	fi; \
+	$(PYTHON) setup.py install $$opts;
+
 clean-local:
 	rm -rf build
 
 uninstall-local:
-	cat install_files.txt | xargs rm -rf
 	rm -rf $(DESTDIR)$(pkgpythondir)
 
 EXTRA_DIST=$(agent_path)
-- 
2.1.4
