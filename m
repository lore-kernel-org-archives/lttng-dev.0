From: Jan Glauber <jan.glauber@gmail.com>
Subject: [Patch lttng-modules] ARM: Resolve sys_unknown system
	calls
Date: Fri, 11 Apr 2014 14:13:46 +0200
Message-ID: <1397218426-782-1-git-send-email-jan.glauber__14490.192794665$1397218576$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WYaMf-0000yp-6v
 for lttng-dev@lists.lttng.org; Fri, 11 Apr 2014 08:15:27 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so4144411eek.9
 for <lttng-dev@lists.lttng.org>; Fri, 11 Apr 2014 05:15:19 -0700 (PDT)
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

The LTTng system call extractor relies on kallsyms. Not every system
call is defined in the kernel with SYSCALL_DEFINE, so some system calls
are missing in kallsyms and shown as sys_unknown by LTTng.

Manually declare the following missing calls for the ARM list:
- sys_recv
- sys_sigreturn
- sys_rt_sigreturn
- sys_pread64
- sys_prwite64
- sys_vfork
- sys_ftruncate64
- sys_fstatfs64
- sys_fallocate

Signed-off-by: Jan Glauber <jan.glauber@gmail.com>
---
 instrumentation/syscalls/3.4.25/arm-32-syscalls-3.4.25         |    9 +++
 instrumentation/headers/arm-32-syscalls-3.4.25_integers.h      |   30 ++++++++
 instrumentation/headers/arm-32-syscalls-3.4.25_pointers.h      |   72 ++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/instrumentation/syscalls/3.4.25/arm-32-syscalls-3.4.25 b/instrumentation/syscalls/3.4.25/arm-32-syscalls-3.4.25
index 65c3973..824c879 100644
--- a/instrumentation/syscalls/3.4.25/arm-32-syscalls-3.4.25
+++ b/instrumentation/syscalls/3.4.25/arm-32-syscalls-3.4.25
@@ -80,6 +80,7 @@ syscall sys_wait4 nr 114 nbargs 4 types: (pid_t, int *, int, struct rusage *) ar
 syscall sys_swapoff nr 115 nbargs 1 types: (const char *) args: (specialfile)
 syscall sys_sysinfo nr 116 nbargs 1 types: (struct sysinfo *) args: (info)
 syscall sys_fsync nr 118 nbargs 1 types: (unsigned int) args: (fd)
+syscall sys_sigreturn nr 119 nbargs 1 types: (struct pt_regs *) args: (regs)
 syscall sys_setdomainname nr 121 nbargs 2 types: (char *, int) args: (name, len)
 syscall sys_newuname nr 122 nbargs 1 types: (struct new_utsname *) args: (name)
 syscall sys_adjtimex nr 124 nbargs 1 types: (struct timex *) args: (txc_p)
@@ -125,18 +126,23 @@ syscall sys_poll nr 168 nbargs 3 types: (struct pollfd *, unsigned int, int) arg
 syscall sys_setresgid16 nr 170 nbargs 3 types: (old_gid_t, old_gid_t, old_gid_t) args: (rgid, egid, sgid)
 syscall sys_getresgid16 nr 171 nbargs 3 types: (old_gid_t *, old_gid_t *, old_gid_t *) args: (rgid, egid, sgid)
 syscall sys_prctl nr 172 nbargs 5 types: (int, unsigned long, unsigned long, unsigned long, unsigned long) args: (option, arg2, arg3, arg4, arg5)
+syscall sys_rt_sigreturn nr 173 nbargs 1 types: (struct pt_regs *) args: (regs)
 syscall sys_rt_sigaction nr 174 nbargs 4 types: (int, const struct sigaction *, struct sigaction *, size_t) args: (sig, act, oact, sigsetsize)
 syscall sys_rt_sigprocmask nr 175 nbargs 4 types: (int, sigset_t *, sigset_t *, size_t) args: (how, nset, oset, sigsetsize)
 syscall sys_rt_sigpending nr 176 nbargs 2 types: (sigset_t *, size_t) args: (set, sigsetsize)
 syscall sys_rt_sigtimedwait nr 177 nbargs 4 types: (const sigset_t *, siginfo_t *, const struct timespec *, size_t) args: (uthese, uinfo, uts, sigsetsize)
 syscall sys_rt_sigqueueinfo nr 178 nbargs 3 types: (pid_t, int, siginfo_t *) args: (pid, sig, uinfo)
 syscall sys_rt_sigsuspend nr 179 nbargs 2 types: (sigset_t *, size_t) args: (unewset, sigsetsize)
+syscall sys_pread64 nr 180 nbargs 4 types: (unsigned int, const char *, size_t, loff_t) args: (fd, buf, count, pos)
+syscall sys_pwrite64 nr 181 nbargs 4 types: (unsigned int, const char *, size_t, loff_t) args: (fd, buf, count, pos)
 syscall sys_chown16 nr 182 nbargs 3 types: (const char *, old_uid_t, old_gid_t) args: (filename, user, group)
 syscall sys_getcwd nr 183 nbargs 2 types: (char *, unsigned long) args: (buf, size)
 syscall sys_capget nr 184 nbargs 2 types: (cap_user_header_t, cap_user_data_t) args: (header, dataptr)
 syscall sys_capset nr 185 nbargs 2 types: (cap_user_header_t, const cap_user_data_t) args: (header, data)
 syscall sys_sendfile nr 187 nbargs 4 types: (int, int, off_t *, size_t) args: (out_fd, in_fd, offset, count)
+syscall sys_vfork nr 190 nbargs 0 types: () args: ()
 syscall sys_getrlimit nr 191 nbargs 2 types: (unsigned int, struct rlimit *) args: (resource, rlim)
+syscall sys_ftruncate64 nr 194 nbargs 2 types: (unsigned int, loff_t) args: (fd, length)
 syscall sys_stat64 nr 195 nbargs 2 types: (const char *, struct stat64 *) args: (filename, statbuf)
 syscall sys_lstat64 nr 196 nbargs 2 types: (const char *, struct stat64 *) args: (filename, statbuf)
 syscall sys_fstat64 nr 197 nbargs 2 types: (unsigned long, struct stat64 *) args: (fd, statbuf)
@@ -202,6 +208,7 @@ syscall sys_clock_settime nr 262 nbargs 2 types: (const clockid_t, const struct
 syscall sys_clock_gettime nr 263 nbargs 2 types: (const clockid_t, struct timespec *) args: (which_clock, tp)
 syscall sys_clock_getres nr 264 nbargs 2 types: (const clockid_t, struct timespec *) args: (which_clock, tp)
 syscall sys_clock_nanosleep nr 265 nbargs 4 types: (const clockid_t, int, const struct timespec *, struct timespec *) args: (which_clock, flags, rqtp, rmtp)
+syscall sys_fstatfs64 nr 267 nbargs 3 types: (unsigned int, size_t, struct statfs64 *) args: (fd, sz, buf)
 syscall sys_tgkill nr 268 nbargs 3 types: (pid_t, pid_t, int) args: (tgid, pid, sig)
 syscall sys_utimes nr 269 nbargs 2 types: (char *, struct timeval *) args: (filename, utimes)
 syscall sys_mq_open nr 274 nbargs 4 types: (const char *, int, umode_t, struct mq_attr *) args: (u_name, oflag, mode, u_attr)
@@ -221,6 +228,7 @@ syscall sys_getpeername nr 287 nbargs 3 types: (int, struct sockaddr *, int *) a
 syscall sys_socketpair nr 288 nbargs 4 types: (int, int, int, int *) args: (family, type, protocol, usockvec)
 syscall sys_send nr 289 nbargs 4 types: (int, void *, size_t, unsigned) args: (fd, buff, len, flags)
 syscall sys_sendto nr 290 nbargs 6 types: (int, void *, size_t, unsigned, struct sockaddr *, int) args: (fd, buff, len, flags, addr, addr_len)
+syscall sys_recv nr 291 nbargs 6 types: (int, void *, size_t, unsigned, struct sockaddr *, int *) args: (fd, ubuf, size, flags, addr, addr_len)
 syscall sys_recvfrom nr 292 nbargs 6 types: (int, void *, size_t, unsigned, struct sockaddr *, int *) args: (fd, ubuf, size, flags, addr, addr_len)
 syscall sys_shutdown nr 293 nbargs 2 types: (int, int) args: (fd, how)
 syscall sys_setsockopt nr 294 nbargs 5 types: (int, int, int, char *, int) args: (fd, level, optname, optval, optlen)
@@ -273,6 +281,7 @@ syscall sys_utimensat nr 348 nbargs 4 types: (int, const char *, struct timespec
 syscall sys_signalfd nr 349 nbargs 3 types: (int, sigset_t *, size_t) args: (ufd, user_mask, sizemask)
 syscall sys_timerfd_create nr 350 nbargs 2 types: (int, int) args: (clockid, flags)
 syscall sys_eventfd nr 351 nbargs 1 types: (unsigned int) args: (count)
+syscall sys_fallocate nr 352 nbargs 4 types: (int, int, loff_t, loff_t) args: (fd, mode, offset, len)
 syscall sys_timerfd_settime nr 353 nbargs 4 types: (int, int, const struct itimerspec *, struct itimerspec *) args: (ufd, flags, utmr, otmr)
 syscall sys_timerfd_gettime nr 354 nbargs 2 types: (int, struct itimerspec *) args: (ufd, otmr)
 syscall sys_signalfd4 nr 355 nbargs 4 types: (int, sigset_t *, size_t, int) args: (ufd, user_mask, sizemask, flags)
diff --git a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers.h b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers.h
index 9b10e5e..444de89 100644
--- a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers.h
+++ b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers.h
@@ -56,6 +56,9 @@ SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_munlockall)
 #ifndef OVERRIDE_32_sys_sched_yield
 SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_sched_yield)
 #endif
+#ifndef OVERRIDE_32_sys_vfork
+SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_vfork)
+#endif
 #ifndef OVERRIDE_32_sys_getuid
 SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_getuid)
 #endif
@@ -497,6 +500,15 @@ SC_TRACE_EVENT(sys_munlock,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_ftruncate64
+SC_TRACE_EVENT(sys_ftruncate64,
+	TP_PROTO(unsigned int fd, loff_t length),
+	TP_ARGS(fd, length),
+	TP_STRUCT__entry(__field(unsigned int, fd) __field(loff_t, length)),
+	TP_fast_assign(tp_assign(fd, fd) tp_assign(length, length)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_setreuid
 SC_TRACE_EVENT(sys_setreuid,
 	TP_PROTO(uid_t ruid, uid_t euid),
@@ -812,6 +824,15 @@ SC_TRACE_EVENT(sys_tee,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_fallocate
+SC_TRACE_EVENT(sys_fallocate,
+	TP_PROTO(int fd, int mode, loff_t offset, loff_t len),
+	TP_ARGS(fd, mode, offset, len),
+	TP_STRUCT__entry(__field(int, fd) __field(int, mode) __field(loff_t, offset) __field(loff_t, len)),
+	TP_fast_assign(tp_assign(fd, fd) tp_assign(mode, mode) tp_assign(offset, offset) tp_assign(len, len)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_mremap
 SC_TRACE_EVENT(sys_mremap,
 	TP_PROTO(unsigned long addr, unsigned long old_len, unsigned long new_len, unsigned long flags, unsigned long new_addr),
@@ -901,6 +922,9 @@ TRACE_SYSCALL_TABLE(syscalls_noargs, sys_munlockall, 153, 0)
 #ifndef OVERRIDE_TABLE_32_sys_sched_yield
 TRACE_SYSCALL_TABLE(syscalls_noargs, sys_sched_yield, 158, 0)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_vfork
+TRACE_SYSCALL_TABLE(syscalls_noargs, sys_vfork, 190, 0)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_getuid
 TRACE_SYSCALL_TABLE(syscalls_noargs, sys_getuid, 199, 0)
 #endif
@@ -1057,6 +1081,9 @@ TRACE_SYSCALL_TABLE(sys_setresgid16, sys_setresgid16, 170, 3)
 #ifndef OVERRIDE_TABLE_32_sys_prctl
 TRACE_SYSCALL_TABLE(sys_prctl, sys_prctl, 172, 5)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_ftruncate64
+TRACE_SYSCALL_TABLE(sys_ftruncate64, sys_ftruncate64, 194, 2)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_setreuid
 TRACE_SYSCALL_TABLE(sys_setreuid, sys_setreuid, 203, 2)
 #endif
@@ -1156,6 +1183,9 @@ TRACE_SYSCALL_TABLE(sys_timerfd_create, sys_timerfd_create, 350, 2)
 #ifndef OVERRIDE_TABLE_32_sys_eventfd
 TRACE_SYSCALL_TABLE(sys_eventfd, sys_eventfd, 351, 1)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_fallocate
+TRACE_SYSCALL_TABLE(sys_fallocate, sys_fallocate, 352, 4)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_eventfd2
 TRACE_SYSCALL_TABLE(sys_eventfd2, sys_eventfd2, 356, 2)
 #endif
diff --git a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers.h b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers.h
index 3a9c146..796ca52 100644
--- a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers.h
+++ b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers.h
@@ -108,6 +108,15 @@ SC_TRACE_EVENT(sys_sysinfo,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_sigreturn
+SC_TRACE_EVENT(sys_sigreturn,
+	TP_PROTO(struct pt_regs * regs),
+	TP_ARGS(regs),
+	TP_STRUCT__entry(__field_hex(struct pt_regs *, regs)),
+	TP_fast_assign(tp_assign(regs, regs)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_newuname
 SC_TRACE_EVENT(sys_newuname,
 	TP_PROTO(struct new_utsname * name),
@@ -135,6 +144,15 @@ SC_TRACE_EVENT(sys_sysctl,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_rt_sigreturn
+SC_TRACE_EVENT(sys_rt_sigreturn,
+	TP_PROTO(struct pt_regs * regs),
+	TP_ARGS(regs),
+	TP_STRUCT__entry(__field_hex(struct pt_regs *, regs)),
+	TP_fast_assign(tp_assign(regs, regs)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_set_tid_address
 SC_TRACE_EVENT(sys_set_tid_address,
 	TP_PROTO(int * tidptr),
@@ -945,6 +963,15 @@ SC_TRACE_EVENT(sys_timer_create,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_fstatfs64
+SC_TRACE_EVENT(sys_fstatfs64,
+	TP_PROTO(unsigned int fd, size_t sz, struct statfs64 * buf),
+	TP_ARGS(fd, sz, buf),
+	TP_STRUCT__entry(__field(unsigned int, fd) __field(size_t, sz) __field_hex(struct statfs64 *, buf)),
+	TP_fast_assign(tp_assign(fd, fd) tp_assign(sz, sz) tp_assign(buf, buf)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_mq_getsetattr
 SC_TRACE_EVENT(sys_mq_getsetattr,
 	TP_PROTO(mqd_t mqdes, const struct mq_attr * u_mqstat, struct mq_attr * u_omqstat),
@@ -1206,6 +1233,24 @@ SC_TRACE_EVENT(sys_rt_sigtimedwait,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_pread64
+SC_TRACE_EVENT(sys_pread64,
+	TP_PROTO(unsigned int fd, const char * buf, size_t count, loff_t pos),
+	TP_ARGS(fd, buf, count, pos),
+	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(const char *, buf) __field(size_t, count) __field(loff_t, pos)),
+	TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count, count) tp_assign(pos, pos)),
+	TP_printk()
+)
+#endif
+#ifndef OVERRIDE_32_sys_pwrite64
+SC_TRACE_EVENT(sys_pwrite64,
+	TP_PROTO(unsigned int fd, const char * buf, size_t count, loff_t pos),
+	TP_ARGS(fd, buf, count, pos),
+	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(const char *, buf) __field(size_t, count) __field(loff_t, pos)),
+	TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count, count) tp_assign(pos, pos)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_sendfile
 SC_TRACE_EVENT(sys_sendfile,
 	TP_PROTO(int out_fd, int in_fd, off_t * offset, size_t count),
@@ -1674,6 +1719,15 @@ SC_TRACE_EVENT(sys_sendto,
 	TP_printk()
 )
 #endif
+#ifndef OVERRIDE_32_sys_recv
+SC_TRACE_EVENT(sys_recv,
+	TP_PROTO(int fd, void * ubuf, size_t size, unsigned flags, struct sockaddr * addr, int * addr_len),
+	TP_ARGS(fd, ubuf, size, flags, addr, addr_len),
+	TP_STRUCT__entry(__field(int, fd) __field_hex(void *, ubuf) __field(size_t, size) __field(unsigned, flags) __field_hex(struct sockaddr *, addr) __field_hex(int *, addr_len)),
+	TP_fast_assign(tp_assign(fd, fd) tp_assign(ubuf, ubuf) tp_assign(size, size) tp_assign(flags, flags) tp_assign(addr, addr) tp_assign(addr_len, addr_len)),
+	TP_printk()
+)
+#endif
 #ifndef OVERRIDE_32_sys_recvfrom
 SC_TRACE_EVENT(sys_recvfrom,
 	TP_PROTO(int fd, void * ubuf, size_t size, unsigned flags, struct sockaddr * addr, int * addr_len),
@@ -1877,6 +1931,9 @@ TRACE_SYSCALL_TABLE(sys_swapoff, sys_swapoff, 115, 1)
 #ifndef OVERRIDE_TABLE_32_sys_sysinfo
 TRACE_SYSCALL_TABLE(sys_sysinfo, sys_sysinfo, 116, 1)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_sigreturn
+TRACE_SYSCALL_TABLE(sys_sigreturn, sys_sigreturn, 119, 1)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_setdomainname
 TRACE_SYSCALL_TABLE(sys_setdomainname, sys_setdomainname, 121, 2)
 #endif
@@ -1940,6 +1997,9 @@ TRACE_SYSCALL_TABLE(sys_poll, sys_poll, 168, 3)
 #ifndef OVERRIDE_TABLE_32_sys_getresgid16
 TRACE_SYSCALL_TABLE(sys_getresgid16, sys_getresgid16, 171, 3)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_rt_sigreturn
+TRACE_SYSCALL_TABLE(sys_rt_sigreturn, sys_rt_sigreturn, 173, 1)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_rt_sigaction
 TRACE_SYSCALL_TABLE(sys_rt_sigaction, sys_rt_sigaction, 174, 4)
 #endif
@@ -1958,6 +2018,12 @@ TRACE_SYSCALL_TABLE(sys_rt_sigqueueinfo, sys_rt_sigqueueinfo, 178, 3)
 #ifndef OVERRIDE_TABLE_32_sys_rt_sigsuspend
 TRACE_SYSCALL_TABLE(sys_rt_sigsuspend, sys_rt_sigsuspend, 179, 2)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_pread64
+TRACE_SYSCALL_TABLE(sys_pread64, sys_pread64, 180, 4)
+#endif
+#ifndef OVERRIDE_TABLE_32_sys_pwrite64
+TRACE_SYSCALL_TABLE(sys_pwrite64, sys_pwrite64, 181, 4)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_chown16
 TRACE_SYSCALL_TABLE(sys_chown16, sys_chown16, 182, 3)
 #endif
@@ -2096,6 +2162,9 @@ TRACE_SYSCALL_TABLE(sys_clock_getres, sys_clock_getres, 264, 2)
 #ifndef OVERRIDE_TABLE_32_sys_clock_nanosleep
 TRACE_SYSCALL_TABLE(sys_clock_nanosleep, sys_clock_nanosleep, 265, 4)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_fstatfs64
+TRACE_SYSCALL_TABLE(sys_fstatfs64, sys_fstatfs64, 267, 3)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_utimes
 TRACE_SYSCALL_TABLE(sys_utimes, sys_utimes, 269, 2)
 #endif
@@ -2144,6 +2213,9 @@ TRACE_SYSCALL_TABLE(sys_send, sys_send, 289, 4)
 #ifndef OVERRIDE_TABLE_32_sys_sendto
 TRACE_SYSCALL_TABLE(sys_sendto, sys_sendto, 290, 6)
 #endif
+#ifndef OVERRIDE_TABLE_32_sys_recv
+TRACE_SYSCALL_TABLE(sys_recv, sys_recv, 291, 6)
+#endif
 #ifndef OVERRIDE_TABLE_32_sys_recvfrom
 TRACE_SYSCALL_TABLE(sys_recvfrom, sys_recvfrom, 292, 6)
 #endif
-- 
1.7.9.5
