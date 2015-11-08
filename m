From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Compat syscall instrumentation and return from execve issue
Date: Sun, 8 Nov 2015 19:37:37 +0000 (UTC)
Message-ID: <2095400880.57684.1447011457513.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Anvin, H. Peter" <hpa@zytor.com>, lttng-dev <lttng-dev@lists.lttng.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I've hit an issue when tracing system calls on Linux. I
know that perf and ftrace ignore compat syscalls on x86
(see comment above kernel/trace/trace_syscalls.c:trace_get_syscall_nr()).

 * Some architectures that allow for 32bit applications
 * to run on a 64bit kernel, do not map the syscalls for
 * the 32bit tasks the same as they do for 64bit tasks.
 *
 *     *cough*x86*cough*
 *
 * In such a case, instead of reporting the wrong syscalls,
 * simply ignore them.

Even though this comment states that those compat system calls
are ignored, there is a corner case with return from execve which
does not seem to be correctly handled when the task TS_COMPAT
mode is flipped by execve.

I suspect that ftrace and perf suffer from this issue when
32-bit compat program running a 64-bit program: when returning
from execve, is_compat_task() returns false, but the system call
number executed is that of the 32-bit execve, which may map to
whatever system call it is associated to on the 64-bit arch.

This issue also affects LTTng.

In LTTng, rather than ignoring compat syscalls, we take a
different approach: we keep two syscall tables within the tracer:
one for syscalls, one for compat_syscalls. Whenever a syscall
tracing instrumentation is hit, we use is_compat_task() to map
to the correct syscall table.

We trace syscall entry and exit events into a different event
for each syscall, because we fetch input/output parameters
specific to each system call (e.g. strings) from user-space
before/after the system call. We also filter on a per-syscall
basis.

Unfortunately, there is an issue with the specific case
of execve: whenever a 64-bit execve syscall loads a 32-bit
compat executable, or when a 32-bit compat execve loads a
64-bit executable, the TS_COMPAT status is changed before
execve returns to userspace. However, the system call number
in the pt_regs stays the same. Unfortunately, this mixes up
the mapping between the syscall number and the syscall table
in the tracer.

I have a few ideas on how to overcome this, and would like your
feedback on the matter:

1) One possible approach would be to reserve an extra status flag
   in struct thread_info to get the TS_COMPAT status at syscall
   entry. It would _not_ be updated when the executable is loaded,
   so the state at return from execve would match the state when
   entering execve. This is a simple approach, but requires kernel
   changes.

2) Keep the compat state at system call entry in a data structure
   (e.g. hash table) indexed by thread number within each tracer.
   This could work around this issue within each tracer.

3) Change the syscall number in the struct pt_regs whenever we
   change the compat mode of a process. A 64-bit execve system
   call number would be mapped to a 32-bit compat execve number,
   or the opposite. This requires a kernel change, and seems to be
   rather intrusive.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
