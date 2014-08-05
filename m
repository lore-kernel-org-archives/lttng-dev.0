From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH] tests: test_ctf_writer: replace HOST_NAME_MAX
Date: Tue, 5 Aug 2014 22:02:51 +0200
Message-ID: <20140805200251.GA17716__28522.8673405529$1407269134$gmane$org@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from chamillionaire.breakpoint.cc ([80.244.247.6]
 ident=b4211bbfa85a4012b5a667b51e9e61d2)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sebastian@breakpoint.cc>) id 1XEkwf-000365-RC
 for lttng-dev@lists.lttng.org; Tue, 05 Aug 2014 16:03:00 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jeremie.galarneau@efficios.com
Cc: 751337@bugs.debian.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch replaces HOST_NAME_MAX by xgethostname() which is a wrapper
around malloc() + gethostname() to get a large enough buffer to fit the
hostname.
xgethostname.c was stolen from coreutils and slightly changed so it
works without xreallocte().

This should fix Debian #751337 where the package does not build KFreeBSD
due to missing HOST_NAME_MAX.

The test suite passed.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 tests/lib/Makefile.am       |  3 +-
 tests/lib/test_ctf_writer.c | 10 ++++--
 tests/lib/xgethostname.c    | 76 +++++++++++++++++++++++++++++++++++++++++++++
 tests/lib/xgethostname.h    |  1 +
 4 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 tests/lib/xgethostname.c
 create mode 100644 tests/lib/xgethostname.h

diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
index 7c96e4a..e3543af 100644
--- a/tests/lib/Makefile.am
+++ b/tests/lib/Makefile.am
@@ -24,7 +24,8 @@ noinst_PROGRAMS = test_seek test_bitfield test_ctf_writer
 
 test_seek_SOURCES = test_seek.c
 test_bitfield_SOURCES = test_bitfield.c
-test_ctf_writer_SOURCES = test_ctf_writer.c
+test_ctf_writer_SOURCES = test_ctf_writer.c \
+			  xgethostname.c xgethostname.h
 
 SCRIPT_LIST = test_seek_big_trace \
 	test_seek_empty_packet \
diff --git a/tests/lib/test_ctf_writer.c b/tests/lib/test_ctf_writer.c
index c642933..b80f543 100644
--- a/tests/lib/test_ctf_writer.c
+++ b/tests/lib/test_ctf_writer.c
@@ -39,6 +39,7 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include "tap/tap.h"
+#include "xgethostname.h"
 #include <math.h>
 #include <float.h>
 
@@ -1406,7 +1407,7 @@ int main(int argc, char **argv)
 	char *metadata_string;
 	struct bt_ctf_writer *writer;
 	struct utsname name;
-	char hostname[HOST_NAME_MAX];
+	char *hostname;
 	struct bt_ctf_clock *clock, *ret_clock;
 	struct bt_ctf_stream_class *stream_class;
 	struct bt_ctf_stream *stream1;
@@ -1432,10 +1433,15 @@ int main(int argc, char **argv)
 	ok(writer, "bt_ctf_create succeeds in creating trace with path");
 
 	/* Add environment context to the trace */
-	gethostname(hostname, HOST_NAME_MAX);
+	hostname = xgethostname();
+	if (!hostname) {
+		perror("xgethostname()");
+		return -1;
+	}
 	ok(bt_ctf_writer_add_environment_field(writer, "host", hostname) == 0,
 		"Add host (%s) environment field to writer instance",
 		hostname);
+	free(hostname);
 	ok(bt_ctf_writer_add_environment_field(NULL, "test_field",
 		"test_value"),
 		"bt_ctf_writer_add_environment_field error with NULL writer");
diff --git a/tests/lib/xgethostname.c b/tests/lib/xgethostname.c
new file mode 100644
index 0000000..26ee7ed
--- /dev/null
+++ b/tests/lib/xgethostname.c
@@ -0,0 +1,76 @@
+/* xgethostname.c -- return current hostname with unlimited length
+
+   Copyright (C) 1992, 1996, 2000-2001, 2003-2006, 2009-2013 Free Software
+   Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+/* written by Jim Meyering */
+
+#include <config.h>
+
+/* Specification.  */
+#include "xgethostname.h"
+
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+
+#ifndef INITIAL_HOSTNAME_LENGTH
+# define INITIAL_HOSTNAME_LENGTH 34
+#endif
+
+/* Return the current hostname in malloc'd storage.
+   If malloc fails, exit.
+   Upon any other failure, return NULL and set errno.  */
+char *xgethostname (void)
+{
+	char *hostname = NULL;
+	size_t size = INITIAL_HOSTNAME_LENGTH;
+
+	while (1) {
+		char *new_hn;
+		/* Use SIZE_1 here rather than SIZE to work around the bug in
+		 * SunOS 5.5's gethostname whereby it NUL-terminates HOSTNAME
+		 * even when the name is as long as the supplied buffer.
+		 */
+		size_t size_1;
+
+		new_hn = realloc(hostname, size);
+		if (!new_hn) {
+			free(hostname);
+			return NULL;
+
+		} else {
+			hostname = new_hn;
+		}
+		size_1 = size - 1;
+		hostname[size_1 - 1] = '\0';
+		errno = 0;
+
+		if (gethostname (hostname, size_1) == 0) {
+			if (!hostname[size_1 - 1])
+				break;
+		} else if (errno != 0 && errno != ENAMETOOLONG && errno != EINVAL
+				/* OSX/Darwin does this when the buffer is not large enough */
+				&& errno != ENOMEM) {
+			int saved_errno = errno;
+			free (hostname);
+			errno = saved_errno;
+			return NULL;
+		}
+	}
+
+	return hostname;
+}
diff --git a/tests/lib/xgethostname.h b/tests/lib/xgethostname.h
new file mode 100644
index 0000000..0177a40
--- /dev/null
+++ b/tests/lib/xgethostname.h
@@ -0,0 +1 @@
+char *xgethostname (void);
-- 
2.0.1
