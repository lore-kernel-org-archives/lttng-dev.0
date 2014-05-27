From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH babeltrace] bindings/python/babeltrace.i.in:
	don't use a return code in _bt_ctf_stream_append_discarded_events()
Date: Tue, 27 May 2014 10:08:13 +0200
Message-ID: <1401178093-9691-1-git-send-email-bigeasy__44783.4518774927$1401178150$gmane$org@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>) id 1WpCQp-0006tu-Lc
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 04:08:24 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: lttng-dev@lists.lttng.org

that function is defined as void:
| File "/usr/lib/python3/dist-packages/babeltrace.py", line 2284, in
| append_discarded_events
| if ret < 0:
| TypeError: unorderable types: NoneType() < int()

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 bindings/python/babeltrace.i.in        | 4 +---
 include/babeltrace/ctf-writer/stream.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index 9fda6b9..0f81c40 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -2100,9 +2100,7 @@ void bt_ctf_writer_put(struct bt_ctf_writer *writer);
 		Increase the current packet's discarded event count.
 		"""
 		def append_discarded_events(self, event_count):
-			ret = _bt_ctf_stream_append_discarded_events(self._s, event_count)
-			if ret < 0:
-				raise ValueError("Could not append discarded events.")
+			_bt_ctf_stream_append_discarded_events(self._s, event_count)
 
 		"""
 		Append "event" to the stream's current packet. The stream's associated clock
diff --git a/include/babeltrace/ctf-writer/stream.h b/include/babeltrace/ctf-writer/stream.h
index 9229f77..22fb697 100644
--- a/include/babeltrace/ctf-writer/stream.h
+++ b/include/babeltrace/ctf-writer/stream.h
@@ -111,7 +111,6 @@ extern void bt_ctf_stream_class_put(struct bt_ctf_stream_class *stream_class);
  * @param event_count Number of discarded events to add to the stream's current
  *	packet.
  *
- * Returns 0 on success, a negative value on error.
  */
 extern void bt_ctf_stream_append_discarded_events(struct bt_ctf_stream *stream,
 		uint64_t event_count);
-- 
2.0.0.rc4
