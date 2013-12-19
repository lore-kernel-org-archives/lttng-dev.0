From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH] baddr: Added ust_baddr & ust_baddr_statedump
	docu
Date: Thu, 19 Dec 2013 16:21:19 +0100
Message-ID: <1387466479-17334-1-git-send-email-paul_woegerer__21557.2840570987$1387466622$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VtfQx-0006hV-0t
	for lttng-dev@lists.lttng.org; Thu, 19 Dec 2013 10:22:47 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 doc/Makefile.am        |  1 +
 doc/man/lttng-ust-dl.3 | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 doc/man/lttng-ust.3    | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 doc/man/lttng-ust-dl.3

diff --git a/doc/Makefile.am b/doc/Makefile.am
index 4349713..72dcde2 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -2,6 +2,7 @@ SUBDIRS = . examples
 
 dist_man_MANS = man/lttng-gen-tp.1 \
 	man/lttng-ust.3 \
+	man/lttng-ust-dl.3 \
 	man/lttng-ust-cyg-profile.3
 
 dist_doc_DATA = java-util-logging.txt
diff --git a/doc/man/lttng-ust-dl.3 b/doc/man/lttng-ust-dl.3
new file mode 100644
index 0000000..ff46f6b
--- /dev/null
+++ b/doc/man/lttng-ust-dl.3
@@ -0,0 +1,47 @@
+.TH "LTTNG-UST-DL" "3" "December 19, 2013" "" ""
+
+.SH "NAME"
+lttng-ust-dl \(em LTTng UST 2.x Dynamic Linker Tracing
+
+.SH "SYNOPSIS"
+Launch your application with:
+.TP
+\fBLD_PRELOAD=liblttng-ust-dl.so\fP appname
+.PP
+This LD_PRELOAD library causes all calls to dlopen and dlclose in the
+application to be traced with LTTng. The following two events need to be
+enabled: ust_baddr:push and ust_baddr:pop.
+
+.SH "DESCRIPTION"
+The events have the following detailed definitions:
+.PP
+.IP "ust_baddr:push"
+This event is used to trace dlopen calls. The base address (where the dynamic
+linker has placed the shared object) is recorded in the baddr-field. The path
+to the shared object gets recorded in the sopath-field (as string). The file
+size of the loaded object (in bytes) is recorded to the size-field and its time
+of last modification (in seconds since Epoch) is recorded in the mtime-field.
+.IP "ust_baddr:pop"
+This event is used to trace dlclose calls. The base address of the shared
+object that got closed is recorded in the baddr-field.
+.PP
+
+.SH "SEE ALSO"
+lttng-ust(3), dlopen(3), lttng(1)
+.SH "BUGS"
+If you encounter any issues or usability problem, please report it on
+our mailing list <lttng-dev@lists.lttng.org> to help improve this
+project.
+.SH "CREDITS"
+liblttng-ust is distributed under the GNU Lesser General Public License
+version 2.1. The headers are distributed under the MIT license.
+
+See http://lttng.org for more information on the LTTng project.
+
+Mailing list for support and development: <lttng-dev@lists.lttng.org>.
+
+You can find us on IRC server irc.oftc.net (OFTC) in #lttng.
+.SH "AUTHORS"
+liblttng-ust was originally written by Mathieu Desnoyers, with additional
+contributions from various other people. It is currently maintained by
+Mathieu Desnoyers <mathieu.desnoyers@efficios.com>.
diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
index 7624e88..55de9fd 100644
--- a/doc/man/lttng-ust.3
+++ b/doc/man/lttng-ust.3
@@ -347,6 +347,13 @@ process namespace.
 .PP
 
 .PP
+.IP "ip"
+Instruction pointer: Enables recording of the exact location where a tracepoint
+was emitted. Can be used to reverse-lookup the source location that caused the
+event to be emitted.
+.PP
+
+.PP
 .IP "procname"
 Thread name, as set by exec() or prctl(). It is recommended that
 programs set their thread name with prctl() before hitting the first
@@ -359,6 +366,28 @@ Pthread identifier. Can be used on architectures where pthread_t maps
 nicely to an unsigned long type.
 .PP
 
+.SH "BASE ADDRESS STATEDUMP"
+
+.PP
+If an application that uses liblttng-ust.so becomes part of a session,
+information about its currently loaded shared objects will be traced to the
+session at session-enable time. To record this information, the following event
+needs to be enabled:
+.PP
+.IP "ust_baddr_statedump:soinfo"
+This event is used to trace a currently loaded shared object. The base address
+(where the dynamic linker has placed the shared object) is recorded in the
+baddr-field. The path to the shared object gets recorded in the sopath-field
+(as string). The file size of the loaded object (in bytes) is recorded to the
+size-field and its time of last modification (in seconds since Epoch) is
+recorded in the mtime-field.
+.PP
+If the event above is enabled, a series of ust_baddr_statedump:soinfo events is
+recorded at session-enable time, that represents the state of currently loaded
+shared objects (of the traced application). If this information gets combined
+with the lttng-ust-dl(3) instrumentation, all aspects of dynamic loading that
+are relevant for symbol and linenumber-lookup are traced by LTTng.
+.PP
 .SH "ENVIRONMENT VARIABLES"
 
 .PP
@@ -375,12 +404,15 @@ specified in milliseconds. The value 0 means "don't wait". The value
 recommended for applications with time constraints on the process
 startup time.
 .PP
+.IP "LTTNG_UST_WITHOUT_BADDR_STATEDUMP"
+Prevent liblttng-ust to perform a base-address statedump on session-enable.
+.PP
 
 .SH "SEE ALSO"
 
 .PP
 lttng-gen-tp(1), lttng(1), babeltrace(1), lttng-ust-cyg-profile(3),
-lttng-sessiond(8)
+lttng-ust-dl(3), lttng-sessiond(8)
 .PP
 
 .SH "COMPATIBILITY"
-- 
1.8.5
