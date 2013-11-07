From: Danny Serres <serres@live.ca>
Subject: [babeltrace PATCH] Python: Fix some examples for Python
	3
Date: Thu, 7 Nov 2013 15:51:39 -0500
Message-ID: <BLU0-SMTP579E39C31907D03FDB09FEC0F30__10559.6221438192$1383857628$gmane$org@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc3-s25.blu0.hotmail.com ([65.55.116.100])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1VeWYn-0004Pa-Gi
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 15:52:20 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Danny Serres <danny.serres@efficios.com>
List-Id: lttng-dev@lists.lttng.org

New pprint_table module for outputting tables
without using print as statement

Signed-off-by: Danny Serres <danny.serres@efficios.com>

---
 bindings/python/examples/eventcount.py             |   85 +++++++++++++++++
 bindings/python/examples/events_per_cpu.py         |  100 ++++++++++++++++++++
 .../examples/output_format_modules/pprint_table.py |   58 ++++++++++++
 bindings/python/examples/python2/eventcount.py     |   85 -----------------
 bindings/python/examples/python2/events_per_cpu.py |  100 --------------------
 .../python2/output_format_modules/pprint_table.py  |   69 +++++++++-----
 .../python/examples/python2/syscalls_by_pid.py     |   85 -----------------
 bindings/python/examples/syscalls_by_pid.py        |   85 +++++++++++++++++
 8 files changed, 373 insertions(+), 294 deletions(-)
 create mode 100644 bindings/python/examples/eventcount.py
 create mode 100644 bindings/python/examples/events_per_cpu.py
 create mode 100644 bindings/python/examples/output_format_modules/__init__.py
 create mode 100644 bindings/python/examples/output_format_modules/pprint_table.py
 delete mode 100644 bindings/python/examples/python2/eventcount.py
 delete mode 100644 bindings/python/examples/python2/events_per_cpu.py
 delete mode 100644 bindings/python/examples/python2/syscalls_by_pid.py
 create mode 100644 bindings/python/examples/syscalls_by_pid.py

diff --git a/bindings/python/examples/eventcount.py b/bindings/python/examples/eventcount.py
new file mode 100644
index 0000000..c088508
--- /dev/null
+++ b/bindings/python/examples/eventcount.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+# eventcount.py
+#
+# Babeltrace event count example script
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
+# The script prints a count of specified events and
+# their related tid's in a given trace.
+# The trace needs TID context (lttng add-context -k -t tid)
+
+import sys
+from babeltrace import *
+from output_format_modules.pprint_table import pprint_table as pprint
+
+if len(sys.argv) < 3:
+	raise TypeError("Usage: python eventcount.py event1 [event2 ...] path/to/trace")
+
+ctx = Context()
+ret = ctx.add_trace(sys.argv[len(sys.argv)-1], "ctf")
+if ret is None:
+	raise IOError("Error adding trace")
+
+counts = {}
+
+# Setting iterator
+bp = IterPos(SEEK_BEGIN)
+ctf_it = ctf.Iterator(ctx, bp)
+
+# Reading events
+event = ctf_it.read_event()
+while(event is not None):
+	for event_type in sys.argv[1:len(sys.argv)-1]:
+		if event_type == event.get_name():
+
+			# Getting scope definition
+			sco = event.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
+			if sco is None:
+				print("ERROR: Cannot get definition scope for {}".format(
+					event.get_name()))
+				continue
+
+			# Getting TID
+			tid_field = event.get_field(sco, "_tid")
+			tid = tid_field.get_int64()
+
+			if ctf.field_error():
+				print("ERROR: Missing TID info for {}".format(
+					event.get_name()))
+				continue
+
+			tmp = (tid, event.get_name())
+
+			if tmp in counts:
+				counts[tmp] += 1
+			else:
+				counts[tmp] = 1
+
+	# Next event
+	ret = ctf_it.next()
+	if ret < 0:
+		break
+	event = ctf_it.read_event()
+
+del ctf_it
+
+# Appending data to table for output
+table = []
+for item in counts:
+	table.append([item[0], item[1], counts[item]])
+table = sorted(table)
+table.insert(0,["TID", "EVENT", "COUNT"])
+pprint(table, 2)
diff --git a/bindings/python/examples/events_per_cpu.py b/bindings/python/examples/events_per_cpu.py
new file mode 100644
index 0000000..fa0417c
--- /dev/null
+++ b/bindings/python/examples/events_per_cpu.py
@@ -0,0 +1,100 @@
+#!/usr/bin/env python3
+# events_per_cpu.py
+#
+# Babeltrace events per cpu example script
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
+# The script opens a trace and prints out CPU statistics
+# for the given trace (event count per CPU, total active
+# time and % of time processing events).
+# It also outputs a .txt file showing each time interval
+# (since the beginning of the trace) in which each CPU
+# was active and the corresponding event.
+
+import sys, multiprocessing
+from output_format_modules.pprint_table import pprint_table as pprint
+from babeltrace import *
+
+if len(sys.argv) < 2:
+	raise TypeError("Usage: python events_per_cpu.py path/to/trace")
+
+# Adding trace
+ctx = Context()
+ret = ctx.add_trace(sys.argv[1], "ctf")
+if ret is None:
+	raise IOError("Error adding trace")
+
+cpu_usage = []
+nbEvents = 0
+i = 0
+while i < multiprocessing.cpu_count():
+	cpu_usage.append([])
+	i += 1
+
+# Setting iterator
+bp = IterPos(SEEK_BEGIN)
+ctf_it = ctf.Iterator(ctx, bp)
+
+# Reading events
+event = ctf_it.read_event()
+start_time = event.get_timestamp()
+
+while(event is not None):
+
+	event_name = event.get_name()
+	ts = event.get_timestamp()
+
+	# Getting cpu_id
+	scope = event.get_top_level_scope(ctf.scope.STREAM_PACKET_CONTEXT)
+	field = event.get_field(scope, "cpu_id")
+	cpu_id = field.get_uint64()
+	if ctf.field_error():
+		print("ERROR: Missing cpu_id info for {}".format(event.get_name()))
+	else:
+		cpu_usage[cpu_id].append( (int(ts), event_name) )
+		nbEvents += 1
+
+	# Next Event
+	ret = ctf_it.next()
+	if ret < 0:
+		break
+	event = ctf_it.read_event()
+
+
+# Outputting
+table = []
+output = open("events_per_cpu.txt", "wt")
+output.write("(timestamp, event)\n")
+
+for cpu in range(len(cpu_usage)):
+	# Setting table
+	event_str = str(100.0 * len(cpu_usage[cpu]) / nbEvents) + '000'
+	# % is printed with 2 decimals
+	table.append([cpu, len(cpu_usage[cpu]), event_str[0:event_str.find('.') + 3] + ' %'])
+
+	# Writing to file
+	output.write("\n\n\n----------------------\n")
+	output.write("CPU {}\n\n".format(cpu))
+	for event in cpu_usage[cpu]:
+		output.write(str(event) + '\n')
+
+# Printing table
+table.insert(0, ["CPU ID", "EVENT COUNT", "TRACE EVENT %"])
+pprint(table)
+print("Total event count: {}".format(nbEvents))
+print("Total trace time: {} ns".format(ts - start_time))
+
+output.close()
diff --git a/bindings/python/examples/output_format_modules/__init__.py b/bindings/python/examples/output_format_modules/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/bindings/python/examples/output_format_modules/pprint_table.py b/bindings/python/examples/output_format_modules/pprint_table.py
new file mode 100644
index 0000000..495a217
--- /dev/null
+++ b/bindings/python/examples/output_format_modules/pprint_table.py
@@ -0,0 +1,58 @@
+# pprint_table.py
+#
+# This module is used to pretty-print a table
+#
+# Copyright 2013 EfficiOS Inc.
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
+import sys
+
+def pprint_table(table, nbLeft=1, out=sys.stdout):
+	"""
+	Prints a nice table of data.
+	table is the table to print.  It must be a list of lists of equal lenghts.
+	nbLeft is the number of columns aligned left.
+	out is the output stream (a file-like object).
+	Returns None.
+	"""
+
+	# Returns the largest entry in column col of the table
+	max_width = lambda tbl, col : max([len(str(line[col])) for line in tbl])
+
+	col_widths = []
+	nbColumns = len(table[0])
+
+	# For each column, get its max width
+	i = 0
+	while i < nbColumns :
+		col_widths.append(max_width(table, i))
+		i += 1
+
+	out_string = ""
+
+	for line in table:
+		# For columns aligned left
+		for i in range(nbLeft):
+			out_string += str(line[i]).ljust(col_widths[i] + 1)
+		# For other columns (aligned right)
+		for i in range(nbLeft, nbColumns):
+			out_string += str(line[i]).rjust(col_widths[i] + 2)
+
+		# Print line
+		out.write(out_string + '\n')
+
+		# Clear string
+		out_string = ""
+
+	return None
diff --git a/bindings/python/examples/python2/eventcount.py b/bindings/python/examples/python2/eventcount.py
deleted file mode 100644
index 079633c..0000000
--- a/bindings/python/examples/python2/eventcount.py
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/usr/bin/env python2
-# eventcount.py
-#
-# Babeltrace event count example script
-#
-# Copyright 2012 EfficiOS Inc.
-#
-# Author: Danny Serres <danny.serres@efficios.com>
-#
-# Permission is hereby granted, free of charge, to any person obtaining a copy
-# of this software and associated documentation files (the "Software"), to deal
-# in the Software without restriction, including without limitation the rights
-# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-# copies of the Software, and to permit persons to whom the Software is
-# furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-
-# The script prints a count of specified events and
-# their related tid's in a given trace.
-# The trace needs TID context (lttng add-context -k -t tid)
-
-import sys
-from babeltrace import *
-from output_format_modules.pprint_table import pprint_table as pprint
-
-if len(sys.argv) < 3:
-	raise TypeError("Usage: python eventcount.py event1 [event2 ...] path/to/trace")
-
-ctx = Context()
-ret = ctx.add_trace(sys.argv[len(sys.argv)-1], "ctf")
-if ret is None:
-	raise IOError("Error adding trace")
-
-counts = {}
-
-# Setting iterator
-bp = IterPos(SEEK_BEGIN)
-ctf_it = ctf.Iterator(ctx, bp)
-
-# Reading events
-event = ctf_it.read_event()
-while(event is not None):
-	for event_type in sys.argv[1:len(sys.argv)-1]:
-		if event_type == event.get_name():
-
-			# Getting scope definition
-			sco = event.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
-			if sco is None:
-				print("ERROR: Cannot get definition scope for {}".format(
-					event.get_name()))
-				continue
-
-			# Getting TID
-			tid_field = event.get_field(sco, "_tid")
-			tid = tid_field.get_int64()
-
-			if ctf.field_error():
-				print("ERROR: Missing TID info for {}".format(
-					event.get_name()))
-				continue
-
-			tmp = (tid, event.get_name())
-
-			if tmp in counts:
-				counts[tmp] += 1
-			else:
-				counts[tmp] = 1
-
-	# Next event
-	ret = ctf_it.next()
-	if ret < 0:
-		break
-	event = ctf_it.read_event()
-
-del ctf_it
-
-# Appending data to table for output
-table = []
-for item in counts:
-	table.append([item[0], item[1], counts[item]])
-table = sorted(table)
-table.insert(0,["TID", "EVENT", "COUNT"])
-pprint(table, 2)
diff --git a/bindings/python/examples/python2/events_per_cpu.py b/bindings/python/examples/python2/events_per_cpu.py
deleted file mode 100644
index 6425b2d..0000000
--- a/bindings/python/examples/python2/events_per_cpu.py
+++ /dev/null
@@ -1,100 +0,0 @@
-#!/usr/bin/env python2
-# events_per_cpu.py
-#
-# Babeltrace events per cpu example script
-#
-# Copyright 2012 EfficiOS Inc.
-#
-# Author: Danny Serres <danny.serres@efficios.com>
-#
-# Permission is hereby granted, free of charge, to any person obtaining a copy
-# of this software and associated documentation files (the "Software"), to deal
-# in the Software without restriction, including without limitation the rights
-# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-# copies of the Software, and to permit persons to whom the Software is
-# furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-
-# The script opens a trace and prints out CPU statistics
-# for the given trace (event count per CPU, total active
-# time and % of time processing events).
-# It also outputs a .txt file showing each time interval
-# (since the beginning of the trace) in which each CPU
-# was active and the corresponding event.
-
-import sys, multiprocessing
-from output_format_modules.pprint_table import pprint_table as pprint
-from babeltrace import *
-
-if len(sys.argv) < 2:
-	raise TypeError("Usage: python events_per_cpu.py path/to/trace")
-
-# Adding trace
-ctx = Context()
-ret = ctx.add_trace(sys.argv[1], "ctf")
-if ret is None:
-	raise IOError("Error adding trace")
-
-cpu_usage = []
-nbEvents = 0
-i = 0
-while i < multiprocessing.cpu_count():
-	cpu_usage.append([])
-	i += 1
-
-# Setting iterator
-bp = IterPos(SEEK_BEGIN)
-ctf_it = ctf.Iterator(ctx, bp)
-
-# Reading events
-event = ctf_it.read_event()
-start_time = event.get_timestamp()
-
-while(event is not None):
-
-	event_name = event.get_name()
-	ts = event.get_timestamp()
-
-	# Getting cpu_id
-	scope = event.get_top_level_scope(ctf.scope.STREAM_PACKET_CONTEXT)
-	field = event.get_field(scope, "cpu_id")
-	cpu_id = field.get_uint64()
-	if ctf.field_error():
-		print("ERROR: Missing cpu_id info for {}".format(event.get_name()))
-	else:
-		cpu_usage[cpu_id].append( (int(ts), event_name) )
-		nbEvents += 1
-
-	# Next Event
-	ret = ctf_it.next()
-	if ret < 0:
-		break
-	event = ctf_it.read_event()
-
-
-# Outputting
-table = []
-output = open("events_per_cpu.txt", "wt")
-output.write("(timestamp, event)\n")
-
-for cpu in range(len(cpu_usage)):
-	# Setting table
-	event_str = str(100.0 * len(cpu_usage[cpu]) / nbEvents) + '000'
-	# % is printed with 2 decimals
-	table.append([cpu, len(cpu_usage[cpu]), event_str[0:event_str.find('.') + 3] + ' %'])
-
-	# Writing to file
-	output.write("\n\n\n----------------------\n")
-	output.write("CPU {}\n\n".format(cpu))
-	for event in cpu_usage[cpu]:
-		output.write(str(event) + '\n')
-
-# Printing table
-table.insert(0, ["CPU ID", "EVENT COUNT", "TRACE EVENT %"])
-pprint(table)
-print("Total event count: {}".format(nbEvents))
-print("Total trace time: {} ns".format(ts - start_time))
-
-output.close()
diff --git a/bindings/python/examples/python2/output_format_modules/pprint_table.py b/bindings/python/examples/python2/output_format_modules/pprint_table.py
index 3a63d62..495a217 100644
--- a/bindings/python/examples/python2/output_format_modules/pprint_table.py
+++ b/bindings/python/examples/python2/output_format_modules/pprint_table.py
@@ -1,37 +1,58 @@
 # pprint_table.py
 #
 # This module is used to pretty-print a table
-# Adapted from
-# http://ginstrom.com/scribbles/2007/09/04/pretty-printing-a-table-in-python/
+#
+# Copyright 2013 EfficiOS Inc.
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
 
 import sys
 
-def get_max_width(table, index):
-	"""Get the maximum width of the given column index"""
-
-	return max([len(str(row[index])) for row in table])
-
-
 def pprint_table(table, nbLeft=1, out=sys.stdout):
 	"""
-	Prints out a table of data, padded for alignment
-	@param table: The table to print. A list of lists.
-	Each row must have the same number of columns.
-	@param nbLeft: The number of columns aligned left
-	@param out: Output stream (file-like object)
+	Prints a nice table of data.
+	table is the table to print.  It must be a list of lists of equal lenghts.
+	nbLeft is the number of columns aligned left.
+	out is the output stream (a file-like object).
+	Returns None.
 	"""

-	col_paddings = []
+	# Returns the largest entry in column col of the table
+	max_width = lambda tbl, col : max([len(str(line[col])) for line in tbl])
+
+	col_widths = []
+	nbColumns = len(table[0])
 
-	for i in range(len(table[0])):
-		col_paddings.append(get_max_width(table, i))
+	# For each column, get its max width
+	i = 0
+	while i < nbColumns :
+		col_widths.append(max_width(table, i))
+		i += 1
 
-	for row in table:
-		# left cols
+	out_string = ""
+
+	for line in table:
+		# For columns aligned left
 		for i in range(nbLeft):
-			print >> out, str(row[i]).ljust(col_paddings[i] + 1),
-		# rest of the cols
-		for i in range(nbLeft, len(row)):
-			col = str(row[i]).rjust(col_paddings[i] + 2)
-			print >> out, col,
-		print >> out
+			out_string += str(line[i]).ljust(col_widths[i] + 1)
+		# For other columns (aligned right)
+		for i in range(nbLeft, nbColumns):
+			out_string += str(line[i]).rjust(col_widths[i] + 2)
+
+		# Print line
+		out.write(out_string + '\n')
+
+		# Clear string
+		out_string = ""
+
+	return None
diff --git a/bindings/python/examples/python2/syscalls_by_pid.py b/bindings/python/examples/python2/syscalls_by_pid.py
deleted file mode 100644
index cf1d581..0000000
--- a/bindings/python/examples/python2/syscalls_by_pid.py
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/usr/bin/env python2
-# syscall_by_pid.py
-#
-# Babeltrace syscall by pid example script
-#
-# Copyright 2012 EfficiOS Inc.
-#
-# Author: Danny Serres <danny.serres@efficios.com>
-#
-# Permission is hereby granted, free of charge, to any person obtaining a copy
-# of this software and associated documentation files (the "Software"), to deal
-# in the Software without restriction, including without limitation the rights
-# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-# copies of the Software, and to permit persons to whom the Software is
-# furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included in
-# all copies or substantial portions of the Software.
-
-# The script checks the number of events in the trace
-# and outputs a table and a .svg histogram for the specified
-# range (microseconds) or the total trace if no range specified.
-# The graph is generated using the cairoplot module.
-
-# The script checks all syscall in the trace and prints a list
-# showing the number of systemcalls executed by each PID
-# ordered from greatest to least number of syscalls.
-# The trace needs PID context (lttng add-context -k -t pid)
-
-import sys
-from babeltrace import *
-from output_format_modules.pprint_table import pprint_table as pprint
-
-if len(sys.argv) < 2 :
-	raise TypeError("Usage: python syscalls_by_pid.py path/to/trace")
-
-ctx = Context()
-ret = ctx.add_trace(sys.argv[1], "ctf")
-if ret is None:
-	raise IOError("Error adding trace")
-
-data = {}
-
-# Setting iterator
-bp = IterPos(SEEK_BEGIN)
-ctf_it = ctf.Iterator(ctx, bp)
-
-# Reading events
-event = ctf_it.read_event()
-while event is not None:
-	if event.get_name().find("sys") >= 0:
-		# Getting scope definition
-		sco = event.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
-		if sco is None:
-			print("ERROR: Cannot get definition scope for {}".format(
-				event.get_name()))
-		else:
-			# Getting PID
-			pid_field = event.get_field(sco, "_pid")
-			pid = pid_field.get_int64()
-
-			if ctf.field_error():
-				print("ERROR: Missing PID info for sched_switch".format(
-					event.get_name()))
-			elif pid in data:
-				data[pid] += 1
-			else:
-				data[pid] = 1
-	# Next event
-	ret = ctf_it.next()
-	if ret < 0:
-		break
-	event = ctf_it.read_event()
-
-del ctf_it
-
-# Setting table for output
-table = []
-for item in data:
-	table.append([data[item], item])  # [count, pid]
-table.sort(reverse = True)	# [big count first, pid]
-for i in range(len(table)):
-	table[i].reverse()	# [pid, big count first]
-table.insert(0, ["PID", "SYSCALL COUNT"])
-pprint(table)
diff --git a/bindings/python/examples/syscalls_by_pid.py b/bindings/python/examples/syscalls_by_pid.py
new file mode 100644
index 0000000..2d16ae2
--- /dev/null
+++ b/bindings/python/examples/syscalls_by_pid.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+# syscall_by_pid.py
+#
+# Babeltrace syscall by pid example script
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
+# The script checks the number of events in the trace
+# and outputs a table and a .svg histogram for the specified
+# range (microseconds) or the total trace if no range specified.
+# The graph is generated using the cairoplot module.
+
+# The script checks all syscall in the trace and prints a list
+# showing the number of systemcalls executed by each PID
+# ordered from greatest to least number of syscalls.
+# The trace needs PID context (lttng add-context -k -t pid)
+
+import sys
+from babeltrace import *
+from output_format_modules.pprint_table import pprint_table as pprint
+
+if len(sys.argv) < 2 :
+	raise TypeError("Usage: python syscalls_by_pid.py path/to/trace")
+
+ctx = Context()
+ret = ctx.add_trace(sys.argv[1], "ctf")
+if ret is None:
+	raise IOError("Error adding trace")
+
+data = {}
+
+# Setting iterator
+bp = IterPos(SEEK_BEGIN)
+ctf_it = ctf.Iterator(ctx, bp)
+
+# Reading events
+event = ctf_it.read_event()
+while event is not None:
+	if event.get_name().find("sys") >= 0:
+		# Getting scope definition
+		sco = event.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
+		if sco is None:
+			print("ERROR: Cannot get definition scope for {}".format(
+				event.get_name()))
+		else:
+			# Getting PID
+			pid_field = event.get_field(sco, "_pid")
+			pid = pid_field.get_int64()
+
+			if ctf.field_error():
+				print("ERROR: Missing PID info for sched_switch".format(
+					event.get_name()))
+			elif pid in data:
+				data[pid] += 1
+			else:
+				data[pid] = 1
+	# Next event
+	ret = ctf_it.next()
+	if ret < 0:
+		break
+	event = ctf_it.read_event()
+
+del ctf_it
+
+# Setting table for output
+table = []
+for item in data:
+	table.append([data[item], item])  # [count, pid]
+table.sort(reverse = True)	# [big count first, pid]
+for i in range(len(table)):
+	table[i].reverse()	# [pid, big count first]
+table.insert(0, ["PID", "SYSCALL COUNT"])
+pprint(table)
-- 
1.7.9.5
