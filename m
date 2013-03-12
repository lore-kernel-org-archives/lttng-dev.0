From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [PATCH babeltrace] Move memstream.h and uuid.h to
 include/babeltrace/compat directory
Date: Tue, 12 Mar 2013 13:16:25 +0000
Message-ID: <009B25148989C6458484484699278506985C2118__35311.416097875$1363094250$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UFP4D-0007y2-Op
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 09:16:33 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

As preparation for a new compatibility layer, the files memstream.h
and uuid.h are moved to include/babeltrace/compat.
---
 converter/babeltrace-log.c                             |    2 +-
 formats/ctf/Makefile.am                                |    3 +--
 formats/ctf/ctf.c                                      |    4 ++--
 formats/ctf/metadata/ctf-visitor-generate-io-struct.c  |    2 +-
 include/Makefile.am                                    |    3 ++-
 {formats/ctf => include/babeltrace/compat}/memstream.h |    0
 include/babeltrace/{ => compat}/uuid.h                 |    0
 include/babeltrace/ctf-ir/metadata.h                   |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)
 rename {formats/ctf => include/babeltrace/compat}/memstream.h (100%)
 rename include/babeltrace/{ => compat}/uuid.h (100%)

diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
index 2148711..0214e9a 100644
--- a/converter/babeltrace-log.c
+++ b/converter/babeltrace-log.c
@@ -45,7 +45,7 @@
 
 #include <babeltrace/babeltrace-internal.h>
 #include <babeltrace/ctf/types.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 
 #define USEC_PER_SEC 1000000UL
diff --git a/formats/ctf/Makefile.am b/formats/ctf/Makefile.am
index d803b69..6dcc1bb 100644
--- a/formats/ctf/Makefile.am
+++ b/formats/ctf/Makefile.am
@@ -9,8 +9,7 @@ libbabeltrace_ctf_la_SOURCES = \
 	events.c \
 	iterator.c \
 	callbacks.c \
-	events-private.h \
-	memstream.h
+	events-private.h
 
 # Request that the linker keeps all static libraries objects.
 libbabeltrace_ctf_la_LDFLAGS = \
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 5a51495..bb3ba83 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -33,7 +33,7 @@
 #include <babeltrace/ctf/events-internal.h>
 #include <babeltrace/trace-handle-internal.h>
 #include <babeltrace/context-internal.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 #include <inttypes.h>
 #include <stdio.h>
@@ -51,7 +51,7 @@
 #include "metadata/ctf-parser.h"
 #include "metadata/ctf-ast.h"
 #include "events-private.h"
-#include "memstream.h"
+#include <babeltrace/compat/memstream.h>"
 
 /*
  * We currently simply map a page to read the packet header and packet
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 9bcc170..3be054d 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -36,7 +36,7 @@
 #include <babeltrace/list.h>
 #include <babeltrace/types.h>
 #include <babeltrace/ctf/metadata.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
 #include <babeltrace/ctf/events-internal.h>
 #include "ctf-scanner.h"
diff --git a/include/Makefile.am b/include/Makefile.am
index 824be61..0ade99b 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -30,6 +30,7 @@ noinst_HEADERS = \
 	babeltrace/ctf/types.h \
 	babeltrace/ctf/callbacks-internal.h \
 	babeltrace/trace-handle-internal.h \
-	babeltrace/uuid.h \
+	babeltrace/compat/uuid.h \
+	babeltrace/compat/memstream.h \
 	babeltrace/endian.h \
 	babeltrace/mmap-align.h
diff --git a/formats/ctf/memstream.h b/include/babeltrace/compat/memstream.h
similarity index 100%
rename from formats/ctf/memstream.h
rename to include/babeltrace/compat/memstream.h
diff --git a/include/babeltrace/uuid.h b/include/babeltrace/compat/uuid.h
similarity index 100%
rename from include/babeltrace/uuid.h
rename to include/babeltrace/compat/uuid.h
diff --git a/include/babeltrace/ctf-ir/metadata.h b/include/babeltrace/ctf-ir/metadata.h
index 04e8945..fdb671a 100644
--- a/include/babeltrace/ctf-ir/metadata.h
+++ b/include/babeltrace/ctf-ir/metadata.h
@@ -32,7 +32,7 @@
 #include <babeltrace/ctf/types.h>
 #include <sys/types.h>
 #include <dirent.h>
-#include <babeltrace/uuid.h>
+#include <babeltrace/compat/uuid.h>
 #include <assert.h>
 #include <glib.h>
 
-- 
1.7.10.4
