From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace 3/3] Add a sequence test in the
	python binding
Date: Sat,  3 Aug 2013 05:42:34 +0800
Message-ID: <1375479754-22999-3-git-send-email-xiaonahappy13__21326.6828949147$1375451174$gmane$org@163.com>
References: <1375479754-22999-1-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V5FdB-0008Pp-0E
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 09:43:05 -0400
In-Reply-To: <1375479754-22999-1-git-send-email-xiaonahappy13@163.com>
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

This example is to test whether we can get a sequence's value in
the python binding well or not. It is used in conjunction with the
sequence test in the dir tests/ctf-traces/succeed/sequence.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/examples/sequence_test.py |   64 +++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 bindings/python/examples/sequence_test.py

diff --git a/bindings/python/examples/sequence_test.py b/bindings/python/examples/sequence_test.py
new file mode 100644
index 0000000..382f48b
--- /dev/null
+++ b/bindings/python/examples/sequence_test.py
@@ -0,0 +1,64 @@
+#!/usr/bin/env python3
+# sequence_test.py
+#
+# Babeltrace example script based on the Babeltrace API test script
+#
+# Copyright 2012 EfficiOS Inc.
+#
+# Author: Danny Serres <danny.serres@efficios.com>
+#
+# Permission is hereby granted, free of charge, to any person obtaining a copy
+# of this software and associated documentation files (the "Software"), to deal
+# in the Software without restriction, including without limitation the rights
+# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+# copies of the Software, and to permit persons to whom the Software is
+# furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+
+# This example uses the babeltrace python module
+# to partially test the api.
+
+import sys
+from babeltrace import *
+
+# Check for path arg:
+if len(sys.argv) < 2:
+	raise TypeError("Usage: sequence_test.py path/to/file")
+
+# Create context and add trace:
+ctx = Context()
+trace_handle = ctx.add_trace(sys.argv[1], "ctf")
+if trace_handle is None:
+	raise IOError("Error adding trace")
+
+# Listing events
+lst = ctf.get_event_decl_list(trace_handle, ctx)
+print("--- Event list ---")
+for item in lst:
+	print("event : {}".format(item.get_name()))
+print("--- Done ---")
+
+# Iter trace
+bp = IterPos(SEEK_BEGIN)
+ctf_it = ctf.Iterator(ctx,bp)
+event = ctf_it.read_event()
+
+while(event is not None):
+	print("TS: {}, {} : {}".format(event.get_timestamp(),
+		event.get_cycles(), event.get_name()))
+	field = event.get_field("seq_int_field")
+	if field is not None:
+		print("The int sequence value: {}". format(field[0].get_value()))
+	field = event.get_field("seq_long_field")
+	if field is not None:
+		print("The long sequence value: {}". format(field[0].get_value()))
+
+	ret = ctf_it.next()
+	if ret < 0:
+		break
+	else:
+		event = ctf_it.read_event()
+
+del ctf_it
-- 
1.7.1
