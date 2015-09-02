From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [RFC PATCH lttng-ust] Produce section with tracepoint
	callsite addresses
Date: Wed,  2 Sep 2015 17:49:06 -0400
Message-ID: <1441230546-875-1-git-send-email-simon.marchi__22417.0770532966$1441230644$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [96.127.255.83] (helo=smtp.electronicbox.net)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1ZXFu5-000788-8j
 for lttng-dev@lists.lttng.org; Wed, 02 Sep 2015 17:49:22 -0400
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

There used to be an integration between lttng-ust 0.x and gdb, where gdb
could list locations of ust tracepoints and put its own tracepoints
there.  That means that this old-style lttng-ust marker:

  trace_mark(ust, bar33, "str %s", "FOOBAZ");

could be used to set a gdb tracepoint like this:

  (gdb) strace -m ust/bar33

Later, support for SystemTap and DTrace tracepoints was added in the
form of probe points.  Therefore, it's possible to list static probes
found in the program like this:

  (gdb) info probes
  Type Provider    Name          Where              Semaphore Object
  stap ze_provider ze_tracepoint 0x00000000004004f1

It's then possible to do many fun things with it, including setting a
breakpoint at its location:

  (gdb) b -probe ze_provider:ze_tracepoint
  Breakpoint 1 at 0x4004f1

I'd like if gdb was able to do the same for lttng-ust tracepoints.
Currently, you can make lttng-ust's tracepoint appear as SystemTap
probes (--with-sdt), so one could argue that it already works, but it
would be preferrable to have "native" support.

This patch adds a section in the ELF (__lttng_callsites) and records
pairs of pointers in it:

  <address of corresponding struct tracepoint> <callsite address>

so that it's possible to determine where each tracepoint is used (and
supporting tracepoints being called at multiple locations).  I made a
prototype of gdb that reads the content of this section, available here:

  https://github.com/simark/binutils-gdb.git

This is the result (not very exciting, but still):

  (gdb) info probes
  Type  Provider         Name    Where              Semaphore Object
  lttng sample_component message 0x0000000000400ced n/a       /home/emaisin/build/lttng-ust/doc/examples/easy-ust/sample

I'd like to know what you think about the way the information is laid
out in the ELF.  What should I be concerned about, especially in terms of
future-proofing and portability?  One thing I am aware of is that the
use of an 8 bytes pointer for 32-bits architectures is not optimal (we
are wasting _4 bytes_ every time), but I couldn't find a way to tell gas
"push a data word the size of a pointer".  We would probably have to
get an architecture-specific macro to define the right assembler
directive for a pointer.

Thanks in advance for the comments!
---
 include/lttng/tracepoint.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
index 4bc4fc9..04d3aa6 100644
--- a/include/lttng/tracepoint.h
+++ b/include/lttng/tracepoint.h
@@ -53,13 +53,17 @@ extern "C" {
 
 #define tracepoint(provider, name, ...)					    \
 	do {								    \
+		asm(".pushsection __lttng_callsites, \"a\", @progbits\n" \
+			".8byte __tracepoint_" #provider "___" #name "\n" \
+			".8byte 456f\n" \
+		    " .popsection\n" \
+			"456:\n"); \
 		STAP_PROBEV(provider, name, ## __VA_ARGS__);		    \
 		if (tracepoint_enabled(provider, name)) 		    \
 			do_tracepoint(provider, name, __VA_ARGS__);	    \
 	} while (0)
 
 #define TP_ARGS(...)       __VA_ARGS__
-
 /*
  * TP_ARGS takes tuples of type, argument separated by a comma.
  * It can take up to 10 tuples (which means that less than 10 tuples is
@@ -323,6 +327,16 @@ extern struct lttng_ust_tracepoint * const __start___tracepoints_ptrs[]
 	__attribute__((weak, visibility("hidden")));
 extern struct lttng_ust_tracepoint * const __stop___tracepoints_ptrs[]
 	__attribute__((weak, visibility("hidden")));
+extern void * const __start___lttng_callsites[]
+	__attribute__((weak, visibility("hidden")));
+extern void * const __stop___lttng_callsites[]
+	__attribute__((weak, visibility("hidden")));
+
+/*
+ * Make sure __start/stop__lttng_callsites symbols are generated.
+ */
+static const void * const ___start__lttng_callsites __attribute__((used)) = __start___lttng_callsites;
+static const void * const ___stop__lttng_callsites __attribute__((used)) = __stop___lttng_callsites;
 
 /*
  * When TRACEPOINT_PROBE_DYNAMIC_LINKAGE is defined, we do not emit a
-- 
2.5.1
