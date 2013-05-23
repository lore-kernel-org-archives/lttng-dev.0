From: Jan Glauber <jan.glauber@gmail.com>
Subject: [PATCH lttng-modules] Fix CPU hotplug section mismatches
Date: Thu, 23 May 2013 13:02:36 +0200
Message-ID: <1369306957-2562-1-git-send-email-jan.glauber__49366.6864502758$1369307099$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jan.glauber@gmail.com>) id 1UfTJj-0003Ko-14
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 07:04:19 -0400
Received: by mail-bk0-f46.google.com with SMTP id my13so1741406bkb.5
	for <lttng-dev@lists.lttng.org>; Thu, 23 May 2013 04:04:13 -0700 (PDT)
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

Get rid of the following section mismatches:

WARNING: /home/jang/temp/lttng-modules-2.2.0-r0/git/lttng-tracer.o(.text+0x19dc0): Section mismatch in reference from the function lttng_add_perf_counter_to_ctx() to the function .cpuinit.text:lttng_perf_counter_cpu_hp_callback()
The function lttng_add_perf_counter_to_ctx() references
the function __cpuinit lttng_perf_counter_cpu_hp_callback().
This is often because lttng_add_perf_counter_to_ctx lacks a __cpuinit
annotation or the annotation of lttng_perf_counter_cpu_hp_callback is wrong.

WARNING: /home/jang/temp/lttng-modules-2.2.0-r0/git/lib/lttng-lib-ring-buffer.o(.text+0x1204): Section mismatch in reference from the function channel_backend_init() to the function .cpuinit.text:lib_ring_buffer_cpu_hp_callback()
The function channel_backend_init() references
the function __cpuinit lib_ring_buffer_cpu_hp_callback().
This is often because channel_backend_init lacks a __cpuinit
annotation or the annotation of lib_ring_buffer_cpu_hp_callback is wrong.

WARNING: /home/jang/temp/lttng-modules-2.2.0-r0/git/lib/lttng-lib-ring-buffer.o(.text+0x269c): Section mismatch in reference from the function channel_create() to the function .cpuinit.text:lib_ring_buffer_cpu_hp_callback()
The function channel_create() references
the function __cpuinit lib_ring_buffer_cpu_hp_callback().
This is often because channel_create lacks a __cpuinit
annotation or the annotation of lib_ring_buffer_cpu_hp_callback is wrong.

WARNING: /home/jang/temp/lttng-modules-2.2.0-r0/git/lib/lttng-lib-ring-buffer.o(.text+0x4a1c): Section mismatch in reference from the function channel_iterator_init() to the function .cpuinit.text:channel_iterator_cpu_hotplug()
The function channel_iterator_init() references
the function __cpuinit channel_iterator_cpu_hotplug().
This is often because channel_iterator_init lacks a __cpuinit
annotation or the annotation of channel_iterator_cpu_hotplug is wrong.

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 lib/ringbuffer/ring_buffer_backend.c  |    2 +-
 lib/ringbuffer/ring_buffer_frontend.c |    2 +-
 lib/ringbuffer/ring_buffer_iterator.c |    2 +-
 lttng-context-perf-counters.c         |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/ringbuffer/ring_buffer_backend.c b/lib/ringbuffer/ring_buffer_backend.c
index 84e7dfb..69ad2a7 100644
--- a/lib/ringbuffer/ring_buffer_backend.c
+++ b/lib/ringbuffer/ring_buffer_backend.c
@@ -253,7 +253,7 @@ void channel_backend_reset(struct channel_backend *chanb)
  *	Returns the success/failure of the operation. (%NOTIFY_OK, %NOTIFY_BAD)
  */
 static
-int __cpuinit lib_ring_buffer_cpu_hp_callback(struct notifier_block *nb,
+int lib_ring_buffer_cpu_hp_callback(struct notifier_block *nb,
 					      unsigned long action,
 					      void *hcpu)
 {
diff --git a/lib/ringbuffer/ring_buffer_frontend.c b/lib/ringbuffer/ring_buffer_frontend.c
index 2626afa..bff920d 100644
--- a/lib/ringbuffer/ring_buffer_frontend.c
+++ b/lib/ringbuffer/ring_buffer_frontend.c
@@ -402,7 +402,7 @@ static void lib_ring_buffer_stop_read_timer(struct lib_ring_buffer *buf)
  *	Returns the success/failure of the operation. (%NOTIFY_OK, %NOTIFY_BAD)
  */
 static
-int __cpuinit lib_ring_buffer_cpu_hp_callback(struct notifier_block *nb,
+int lib_ring_buffer_cpu_hp_callback(struct notifier_block *nb,
 					      unsigned long action,
 					      void *hcpu)
 {
diff --git a/lib/ringbuffer/ring_buffer_iterator.c b/lib/ringbuffer/ring_buffer_iterator.c
index e7c6cb7..9d0197c 100644
--- a/lib/ringbuffer/ring_buffer_iterator.c
+++ b/lib/ringbuffer/ring_buffer_iterator.c
@@ -351,7 +351,7 @@ void lib_ring_buffer_iterator_init(struct channel *chan, struct lib_ring_buffer
 
 #ifdef CONFIG_HOTPLUG_CPU
 static
-int __cpuinit channel_iterator_cpu_hotplug(struct notifier_block *nb,
+int channel_iterator_cpu_hotplug(struct notifier_block *nb,
 					   unsigned long action,
 					   void *hcpu)
 {
diff --git a/lttng-context-perf-counters.c b/lttng-context-perf-counters.c
index e0714eb..73f4e95 100644
--- a/lttng-context-perf-counters.c
+++ b/lttng-context-perf-counters.c
@@ -120,7 +120,7 @@ void lttng_destroy_perf_counter_field(struct lttng_ctx_field *field)
  * soon).
  */
 static
-int __cpuinit lttng_perf_counter_cpu_hp_callback(struct notifier_block *nb,
+int lttng_perf_counter_cpu_hp_callback(struct notifier_block *nb,
 						 unsigned long action,
 						 void *hcpu)
 {
-- 
1.7.9.5
