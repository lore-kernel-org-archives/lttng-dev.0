From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Babeltrace API timestamp manipulation changes
Date: Fri, 03 Aug 2012 15:27:35 -0400
Message-ID: <501C2627.6060401__1311.02671516619$1344022091$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([93.20.26.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1SxNXD-0007LP-IW
	for lttng-dev@lists.lttng.org; Fri, 03 Aug 2012 15:27:43 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Yannick Brosseau <yannick.brosseau@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hi,

Previously, the Babeltrace API forced the user to manipulate "raw
timestamps" to seek, to get the timestamp begin and end of a trace, etc.

This raw timestamp represented the cycle value scaled with the frequency
but did not meant anything to the user and was likely to cause problem
when dealing with traces recorded with different clock sources.

The new patches commited in Babeltrace today removed the notion of the
raw clock-source all over the code, and now the users can manipulate
real timestamps (with the timezone offset applied) or cycle values if
they want more fine-grained control on a specific trace.

This means some API changes :
- the "seek_time" member of the bt_iter_pos structure now takes real
timestamp (with the offset applied)
- the functions "bt_ctf_get_timestamp_raw" is removed
- the funtion "bt_ctf_get_timestamp" is replaced by
"bt_ctf_get_real_timestamp"
- the function "bt_ctf_get_cycles_timestamp" is added
- the functions "bt_trace_handle_get_timestamp_begin" and
"bt_trace_handle_get_timestamp_end" now take a third parameter, either
BT_CLOCK_CYCLES or BT_CLOCK_REAL.

If you have any questions, feel free to ask.

Thanks,

Julien
