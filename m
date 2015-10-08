From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH v3] Extract the bitmask of FDs set in
	select syscall
Date: Thu,  8 Oct 2015 10:43:58 -0400
Message-ID: <1444315438-7681-1-git-send-email-jdesfossez__12734.0066632771$1444315507$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZkCQT-0007CD-Ce
 for lttng-dev@lists.lttng.org; Thu, 08 Oct 2015 10:44:12 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Instead of extracting the user-space pointers of the 3 fd_set, we now
extract the bitmask of the FDs in the sets (in, out, ex) in the form of
an array of unsigned long (1024 FDs is the limit in the kernel).

In this example, we select in input FDs 3, 5 and 10 (0x428), it returns
that one FD is ready: FD 10 (0x400).

syscall_entry_select: { n = 11,
	_fdset_in_length = 1, fdset_in = [ [0] = 0x428 ],
	_fdset_out_length = 1, fdset_out = [ [0] = 0x0 ],
	_fdset_ex_length = 0, fdset_ex = [ ],
	tvp = 0
}
syscall_exit_select: { ret = 1,
	_fdset_in_length = 1, fdset_in = [ [0] = 0x400 ],
	_fdset_out_length = 1, fdset_out = [ [0] = 0x0 ],
	_fdset_ex_length = 0, fdset_ex = [ ],
	tvp = 0
}

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 .../syscalls/headers/syscalls_pointers_override.h  | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/instrumentation/syscalls/headers/syscalls_pointers_override.h b/instrumentation/syscalls/headers/syscalls_pointers_override.h
index c9478f4..009c16b 100644
--- a/instrumentation/syscalls/headers/syscalls_pointers_override.h
+++ b/instrumentation/syscalls/headers/syscalls_pointers_override.h
@@ -52,4 +52,64 @@ SC_LTTNG_TRACEPOINT_EVENT(pipe2,
 	)
 )
 
+#define OVERRIDE_32_select
+#define OVERRIDE_64_select
+SC_LTTNG_TRACEPOINT_EVENT_CODE(select,
+	TP_PROTO(sc_exit(long ret,) int n, fd_set __user * inp, fd_set __user * outp,
+		fd_set __user * exp, struct timeval * tvp),
+	TP_ARGS(sc_exit(ret,) n, inp, outp, exp, tvp),
+	TP_locvar(
+		unsigned long fds_in[__FD_SETSIZE / (8 * sizeof(long))],
+			fds_out[__FD_SETSIZE / (8 * sizeof(long))],
+			fds_ex[__FD_SETSIZE / (8 * sizeof(long))];
+		int nb_in, nb_out, nb_ex;
+	),
+	TP_code(
+		sc_inout(
+		{
+			unsigned long nr;
+			int ret;
+
+			nr = FDS_BYTES(n);
+			tp_locvar->nb_in = 0;
+			tp_locvar->nb_out = 0;
+			tp_locvar->nb_ex = 0;
+
+			if (nr > __FD_SETSIZE)
+				goto skip_code;
+			if (inp) {
+				ret = get_fd_set(nr, inp, tp_locvar->fds_in);
+				if (ret < 0)
+					goto skip_code;
+				tp_locvar->nb_in = nr/sizeof(long);
+			}
+			if (outp) {
+				ret = get_fd_set(nr, outp, tp_locvar->fds_out);
+				if (ret < 0)
+					goto skip_code;
+				tp_locvar->nb_out = nr/sizeof(long);
+			}
+			if (exp) {
+				ret = get_fd_set(nr, exp, tp_locvar->fds_ex);
+				if (ret < 0)
+					goto skip_code;
+				tp_locvar->nb_ex = nr/sizeof(long);
+			}
+		}
+		skip_code:
+		)
+	),
+	TP_FIELDS(
+		sc_exit(ctf_integer(long, ret, ret))
+		sc_in(ctf_integer(int, n, n))
+		sc_inout(ctf_sequence_hex(unsigned long, fdset_in,
+				&tp_locvar->fds_in, unsigned long, tp_locvar->nb_in))
+		sc_inout(ctf_sequence_hex(unsigned long, fdset_out,
+				&tp_locvar->fds_out, unsigned long, tp_locvar->nb_out))
+		sc_inout(ctf_sequence_hex(unsigned long, fdset_ex,
+				&tp_locvar->fds_ex, unsigned long, tp_locvar->nb_ex))
+		sc_inout(ctf_integer(struct timeval *, tvp, tvp))
+	)
+)
+
 #endif /* CREATE_SYSCALL_TABLE */
-- 
1.9.1
