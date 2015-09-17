From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: use start and stop sessiond
	from utils.sh
Date: Thu, 17 Sep 2015 16:42:35 -0400
Message-ID: <1442522555-31856-1-git-send-email-jonathan.rajotte-julien__593.509889631782$1442522957$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1264422057=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Zcg1G-0007WT-EH
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 16:43:09 -0400
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

--===============1264422057==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 tests/regression/ust/daemon/test_daemon             | 18 +++++----------=
---
 tests/regression/ust/exit-fast/test_exit-fast       | 18 +++++----------=
---
 tests/regression/ust/fork/test_fork                 | 18 +++++----------=
---
 tests/regression/ust/libc-wrapper/test_libc-wrapper | 18 +++++----------=
---
 tests/regression/ust/linking/test_linking           | 18 +++++----------=
---
 5 files changed, 25 insertions(+), 65 deletions(-)

diff --git a/tests/regression/ust/daemon/test_daemon b/tests/regression/u=
st/daemon/test_daemon
index 54afd0c..13dda1b 100755
--- a/tests/regression/ust/daemon/test_daemon
+++ b/tests/regression/ust/daemon/test_daemon
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (C) - 2013 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@ef=
ficios.com>
 #
@@ -15,21 +15,13 @@
 # this program; if not, write to the Free Software Foundation, Inc., 51
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
=20
-# Check for a running sessiond
-`pidof lt-lttng-sessiond`
-STOP_SESSIOND=3D$?
-
 CURDIR=3D$(dirname $0)
 TESTDIR=3D${CURDIR}/../../..
=20
-# Try to launch a sessiond before invoking the python test script
-if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=3D$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --c=
onsumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --con=
sumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
-fi
+source $TESTDIR/utils/utils.sh
+
+start_lttng_sessiond_notap
=20
 python3 ${CURDIR}/test_daemon.py
=20
-if [ $STOP_SESSIOND -ne 0 ]; then
-    kill `pidof lt-lttng-sessiond`
-fi
+stop_lttng_sessiond_notap
diff --git a/tests/regression/ust/exit-fast/test_exit-fast b/tests/regres=
sion/ust/exit-fast/test_exit-fast
index e8a0bd6..4b72171 100755
--- a/tests/regression/ust/exit-fast/test_exit-fast
+++ b/tests/regression/ust/exit-fast/test_exit-fast
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (C) - 2013 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@ef=
ficios.com>
 #
@@ -15,21 +15,13 @@
 # this program; if not, write to the Free Software Foundation, Inc., 51
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
=20
-# Check for a running sessiond
-`pidof lt-lttng-sessiond`
-STOP_SESSIOND=3D$?
-
 CURDIR=3D$(dirname $0)
 TESTDIR=3D${CURDIR}/../../..
=20
-# Try to launch a sessiond before invoking the python test script
-if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=3D$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --c=
onsumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --con=
sumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
-fi
+source $TESTDIR/utils/utils.sh
+
+start_lttng_sessiond_notap
=20
 python3 ${CURDIR}/test_exit-fast.py
=20
-if [ $STOP_SESSIOND -ne 0 ]; then
-    kill `pidof lt-lttng-sessiond`
-fi
+stop_lttng_sessiond_notap
diff --git a/tests/regression/ust/fork/test_fork b/tests/regression/ust/f=
ork/test_fork
index e05b556..3d0fb89 100755
--- a/tests/regression/ust/fork/test_fork
+++ b/tests/regression/ust/fork/test_fork
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (C) - 2013 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@ef=
ficios.com>
 #
@@ -15,21 +15,13 @@
 # this program; if not, write to the Free Software Foundation, Inc., 51
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
=20
-# Check for a running sessiond
-`pidof lt-lttng-sessiond`
-STOP_SESSIOND=3D$?
-
 CURDIR=3D$(dirname $0)
 TESTDIR=3D${CURDIR}/../../..
=20
-# Try to launch a sessiond before invoking the python test script
-if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=3D$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --c=
onsumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --con=
sumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
-fi
+source $TESTDIR/utils/utils.sh
+
+start_lttng_sessiond_notap
=20
 python3 ${CURDIR}/test_fork.py
=20
-if [ $STOP_SESSIOND -ne 0 ]; then
-    kill `pidof lt-lttng-sessiond`
-fi
+stop_lttng_sessiond_notap
diff --git a/tests/regression/ust/libc-wrapper/test_libc-wrapper b/tests/=
regression/ust/libc-wrapper/test_libc-wrapper
index 8c6b128..14d227f 100755
--- a/tests/regression/ust/libc-wrapper/test_libc-wrapper
+++ b/tests/regression/ust/libc-wrapper/test_libc-wrapper
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (C) - 2013 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@ef=
ficios.com>
 #
@@ -15,21 +15,13 @@
 # this program; if not, write to the Free Software Foundation, Inc., 51
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
=20
-# Check for a running sessiond
-`pidof lt-lttng-sessiond`
-STOP_SESSIOND=3D$?
-
 CURDIR=3D$(dirname $0)
 TESTDIR=3D${CURDIR}/../../..
=20
-# Try to launch a sessiond before invoking the python test script
-if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=3D$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --c=
onsumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --con=
sumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
-fi
+source $TESTDIR/utils/utils.sh
+
+start_lttng_sessiond_notap
=20
 python3 ${CURDIR}/test_libc-wrapper.py
=20
-if [ $STOP_SESSIOND -ne 0 ]; then
-    kill `pidof lt-lttng-sessiond`
-fi
+stop_lttng_sessiond_notap
diff --git a/tests/regression/ust/linking/test_linking b/tests/regression=
/ust/linking/test_linking
index 77e0b82..e630b09 100755
--- a/tests/regression/ust/linking/test_linking
+++ b/tests/regression/ust/linking/test_linking
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # Copyright (C) - 2013 J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@ef=
ficios.com>
 #
@@ -14,22 +14,14 @@
 # You should have received a copy of the GNU General Public License alon=
g with
 # this program; if not, write to the Free Software Foundation, Inc., 51
 # Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-# Check for a running sessiond
-`pidof lt-lttng-sessiond`
-STOP_SESSIOND=3D$?
-
 CURDIR=3D$(dirname $0)
 TESTDIR=3D${CURDIR}/../../..
=20
+source $TESTDIR/utils/utils.sh
+
 # Try to launch a sessiond before invoking the python test script
-if [ $STOP_SESSIOND -ne 0 ]; then
-	DIR=3D$(readlink -f ${TESTDIR})
-	${DIR}/../src/bin/lttng-sessiond/lttng-sessiond --daemonize --quiet --c=
onsumerd32-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --con=
sumerd64-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
-fi
+start_lttng_sessiond_notap
=20
 python3 ${CURDIR}/test_linking.py
=20
-if [ $STOP_SESSIOND -ne 0 ]; then
-    kill `pidof lt-lttng-sessiond`
-fi
+stop_lttng_sessiond_notap
--=20
2.1.4



--===============1264422057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1264422057==--
