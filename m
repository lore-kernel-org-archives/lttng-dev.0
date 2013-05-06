From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v2] Add system
	calls	definitions for the tilegx architecture
Date: Mon, 6 May 2013 09:09:51 -0400
Message-ID: <20130506130951.GF12699__282.836557789956$1367845857$gmane$org@Krystal>
References: <1360178075-17364-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZLBD-0005uE-Jy
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 09:10:11 -0400
Content-Disposition: inline
In-Reply-To: <1360178075-17364-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Simon,

Sorry for the late reply,

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> The definitions were extracted using the lttng-syscalls-extractor
> module. The overrides were added for the system calls that appeared as
> sys_unknown in the trace (they don't appear in the generated list).
> 
> New in v2:
> * Fixed override defines (I understood there is one for the event
>   definition and one for the table entry).
> * Added ifdefs for __tilegx__.

Comments below,

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  .../syscalls/headers/syscalls_integers.h           |    6 +
>  .../syscalls/headers/syscalls_pointers.h           |    6 +
>  ...-syscalls-2.6.40.38-MDE-4.1.2.149467_integers.h |  971 ++++++++++
>  ...-2.6.40.38-MDE-4.1.2.149467_integers_override.h |   52 +
>  ...-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers.h | 1872 ++++++++++++++++++++
>  ...-2.6.40.38-MDE-4.1.2.149467_pointers_override.h |   14 +
>  6 files changed, 2921 insertions(+), 0 deletions(-)
>  create mode 100644 instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers.h
>  create mode 100644 instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers_override.h
>  create mode 100644 instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers.h
>  create mode 100644 instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers_override.h
> 
> diff --git a/instrumentation/syscalls/headers/syscalls_integers.h b/instrumentation/syscalls/headers/syscalls_integers.h
> index 002130a..c14da57 100644
> --- a/instrumentation/syscalls/headers/syscalls_integers.h
> +++ b/instrumentation/syscalls/headers/syscalls_integers.h
> @@ -9,3 +9,9 @@
>  #ifdef CONFIG_ARM
>  #include "arm-32-syscalls-2.6.38_integers.h"
>  #endif
> +
> +#ifdef CONFIG_TILE
> +#ifdef __tilegx__

#if defined(CONFIG_TILE) && defined(__tilegx__)

(for each)

Please resubmit this patch after 2.2.0 final is out, else I may forget
about this patch (and I cannot merge new features into master at this
point of the release cycle).

Thanks,

Mathieu

> +#include "tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers.h"
> +#endif
> +#endif
> diff --git a/instrumentation/syscalls/headers/syscalls_pointers.h b/instrumentation/syscalls/headers/syscalls_pointers.h
> index 11b4979..a93bd0d 100644
> --- a/instrumentation/syscalls/headers/syscalls_pointers.h
> +++ b/instrumentation/syscalls/headers/syscalls_pointers.h
> @@ -9,3 +9,9 @@
>  #ifdef CONFIG_ARM
>  #include "arm-32-syscalls-2.6.38_pointers.h"
>  #endif
> +
> +#ifdef CONFIG_TILE
> +#ifdef __tilegx__
> +#include "tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers.h"
> +#endif
> +#endif
> diff --git a/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers.h b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers.h
> new file mode 100644
> index 0000000..8703471
> --- /dev/null
> +++ b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers.h
> @@ -0,0 +1,971 @@
> +/* THIS FILE IS AUTO-GENERATED. DO NOT EDIT */
> +#ifndef CREATE_SYSCALL_TABLE
> +
> +#if !defined(_TRACE_SYSCALLS_INTEGERS_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SYSCALLS_INTEGERS_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/syscalls.h>
> +#include "tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers_override.h"
> +#include "syscalls_integers_override.h"
> +
> +SC_DECLARE_EVENT_CLASS_NOARGS(syscalls_noargs,
> +	TP_STRUCT__entry(),
> +	TP_fast_assign(),
> +	TP_printk()
> +)
> +#ifndef OVERRIDE_64_sys_vhangup
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_vhangup)
> +#endif
> +#ifndef OVERRIDE_64_sys_sync
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_sync)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_yield
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_sched_yield)
> +#endif
> +#ifndef OVERRIDE_64_sys_restart_syscall
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_restart_syscall)
> +#endif
> +#ifndef OVERRIDE_64_sys_setsid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_setsid)
> +#endif
> +#ifndef OVERRIDE_64_sys_getpid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_getpid)
> +#endif
> +#ifndef OVERRIDE_64_sys_getppid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_getppid)
> +#endif
> +#ifndef OVERRIDE_64_sys_getuid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_getuid)
> +#endif
> +#ifndef OVERRIDE_64_sys_geteuid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_geteuid)
> +#endif
> +#ifndef OVERRIDE_64_sys_getgid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_getgid)
> +#endif
> +#ifndef OVERRIDE_64_sys_getegid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_getegid)
> +#endif
> +#ifndef OVERRIDE_64_sys_gettid
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_gettid)
> +#endif
> +#ifndef OVERRIDE_64_sys_munlockall
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_munlockall)
> +#endif
> +#ifndef OVERRIDE_64_sys_io_destroy
> +SC_TRACE_EVENT(sys_io_destroy,
> +	TP_PROTO(aio_context_t ctx),
> +	TP_ARGS(ctx),
> +	TP_STRUCT__entry(__field(aio_context_t, ctx)),
> +	TP_fast_assign(tp_assign(ctx, ctx)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_epoll_create1
> +SC_TRACE_EVENT(sys_epoll_create1,
> +	TP_PROTO(int flags),
> +	TP_ARGS(flags),
> +	TP_STRUCT__entry(__field(int, flags)),
> +	TP_fast_assign(tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_dup
> +SC_TRACE_EVENT(sys_dup,
> +	TP_PROTO(unsigned int fildes),
> +	TP_ARGS(fildes),
> +	TP_STRUCT__entry(__field(unsigned int, fildes)),
> +	TP_fast_assign(tp_assign(fildes, fildes)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_inotify_init1
> +SC_TRACE_EVENT(sys_inotify_init1,
> +	TP_PROTO(int flags),
> +	TP_ARGS(flags),
> +	TP_STRUCT__entry(__field(int, flags)),
> +	TP_fast_assign(tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fchdir
> +SC_TRACE_EVENT(sys_fchdir,
> +	TP_PROTO(unsigned int fd),
> +	TP_ARGS(fd),
> +	TP_STRUCT__entry(__field(unsigned int, fd)),
> +	TP_fast_assign(tp_assign(fd, fd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_close
> +SC_TRACE_EVENT(sys_close,
> +	TP_PROTO(unsigned int fd),
> +	TP_ARGS(fd),
> +	TP_STRUCT__entry(__field(unsigned int, fd)),
> +	TP_fast_assign(tp_assign(fd, fd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fsync
> +SC_TRACE_EVENT(sys_fsync,
> +	TP_PROTO(unsigned int fd),
> +	TP_ARGS(fd),
> +	TP_STRUCT__entry(__field(unsigned int, fd)),
> +	TP_fast_assign(tp_assign(fd, fd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fdatasync
> +SC_TRACE_EVENT(sys_fdatasync,
> +	TP_PROTO(unsigned int fd),
> +	TP_ARGS(fd),
> +	TP_STRUCT__entry(__field(unsigned int, fd)),
> +	TP_fast_assign(tp_assign(fd, fd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_personality
> +SC_TRACE_EVENT(sys_personality,
> +	TP_PROTO(unsigned int personality),
> +	TP_ARGS(personality),
> +	TP_STRUCT__entry(__field(unsigned int, personality)),
> +	TP_fast_assign(tp_assign(personality, personality)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_exit
> +SC_TRACE_EVENT(sys_exit,
> +	TP_PROTO(int error_code),
> +	TP_ARGS(error_code),
> +	TP_STRUCT__entry(__field(int, error_code)),
> +	TP_fast_assign(tp_assign(error_code, error_code)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_exit_group
> +SC_TRACE_EVENT(sys_exit_group,
> +	TP_PROTO(int error_code),
> +	TP_ARGS(error_code),
> +	TP_STRUCT__entry(__field(int, error_code)),
> +	TP_fast_assign(tp_assign(error_code, error_code)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_unshare
> +SC_TRACE_EVENT(sys_unshare,
> +	TP_PROTO(unsigned long unshare_flags),
> +	TP_ARGS(unshare_flags),
> +	TP_STRUCT__entry(__field(unsigned long, unshare_flags)),
> +	TP_fast_assign(tp_assign(unshare_flags, unshare_flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timer_getoverrun
> +SC_TRACE_EVENT(sys_timer_getoverrun,
> +	TP_PROTO(timer_t timer_id),
> +	TP_ARGS(timer_id),
> +	TP_STRUCT__entry(__field(timer_t, timer_id)),
> +	TP_fast_assign(tp_assign(timer_id, timer_id)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timer_delete
> +SC_TRACE_EVENT(sys_timer_delete,
> +	TP_PROTO(timer_t timer_id),
> +	TP_ARGS(timer_id),
> +	TP_STRUCT__entry(__field(timer_t, timer_id)),
> +	TP_fast_assign(tp_assign(timer_id, timer_id)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_getscheduler
> +SC_TRACE_EVENT(sys_sched_getscheduler,
> +	TP_PROTO(pid_t pid),
> +	TP_ARGS(pid),
> +	TP_STRUCT__entry(__field(pid_t, pid)),
> +	TP_fast_assign(tp_assign(pid, pid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_get_priority_max
> +SC_TRACE_EVENT(sys_sched_get_priority_max,
> +	TP_PROTO(int policy),
> +	TP_ARGS(policy),
> +	TP_STRUCT__entry(__field(int, policy)),
> +	TP_fast_assign(tp_assign(policy, policy)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_get_priority_min
> +SC_TRACE_EVENT(sys_sched_get_priority_min,
> +	TP_PROTO(int policy),
> +	TP_ARGS(policy),
> +	TP_STRUCT__entry(__field(int, policy)),
> +	TP_fast_assign(tp_assign(policy, policy)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setgid
> +SC_TRACE_EVENT(sys_setgid,
> +	TP_PROTO(gid_t gid),
> +	TP_ARGS(gid),
> +	TP_STRUCT__entry(__field(gid_t, gid)),
> +	TP_fast_assign(tp_assign(gid, gid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setuid
> +SC_TRACE_EVENT(sys_setuid,
> +	TP_PROTO(uid_t uid),
> +	TP_ARGS(uid),
> +	TP_STRUCT__entry(__field(uid_t, uid)),
> +	TP_fast_assign(tp_assign(uid, uid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setfsuid
> +SC_TRACE_EVENT(sys_setfsuid,
> +	TP_PROTO(uid_t uid),
> +	TP_ARGS(uid),
> +	TP_STRUCT__entry(__field(uid_t, uid)),
> +	TP_fast_assign(tp_assign(uid, uid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setfsgid
> +SC_TRACE_EVENT(sys_setfsgid,
> +	TP_PROTO(gid_t gid),
> +	TP_ARGS(gid),
> +	TP_STRUCT__entry(__field(gid_t, gid)),
> +	TP_fast_assign(tp_assign(gid, gid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getpgid
> +SC_TRACE_EVENT(sys_getpgid,
> +	TP_PROTO(pid_t pid),
> +	TP_ARGS(pid),
> +	TP_STRUCT__entry(__field(pid_t, pid)),
> +	TP_fast_assign(tp_assign(pid, pid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getsid
> +SC_TRACE_EVENT(sys_getsid,
> +	TP_PROTO(pid_t pid),
> +	TP_ARGS(pid),
> +	TP_STRUCT__entry(__field(pid_t, pid)),
> +	TP_fast_assign(tp_assign(pid, pid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_umask
> +SC_TRACE_EVENT(sys_umask,
> +	TP_PROTO(int mask),
> +	TP_ARGS(mask),
> +	TP_STRUCT__entry(__field(int, mask)),
> +	TP_fast_assign(tp_assign(mask, mask)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_brk
> +SC_TRACE_EVENT(sys_brk,
> +	TP_PROTO(unsigned long brk),
> +	TP_ARGS(brk),
> +	TP_STRUCT__entry(__field(unsigned long, brk)),
> +	TP_fast_assign(tp_assign(brk, brk)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mlockall
> +SC_TRACE_EVENT(sys_mlockall,
> +	TP_PROTO(int flags),
> +	TP_ARGS(flags),
> +	TP_STRUCT__entry(__field(int, flags)),
> +	TP_fast_assign(tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_set_dataplane
> +SC_TRACE_EVENT(sys_set_dataplane,
> +	TP_PROTO(int flags),
> +	TP_ARGS(flags),
> +	TP_STRUCT__entry(__field(int, flags)),
> +	TP_fast_assign(tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_syncfs
> +SC_TRACE_EVENT(sys_syncfs,
> +	TP_PROTO(int fd),
> +	TP_ARGS(fd),
> +	TP_STRUCT__entry(__field(int, fd)),
> +	TP_fast_assign(tp_assign(fd, fd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_eventfd2
> +SC_TRACE_EVENT(sys_eventfd2,
> +	TP_PROTO(unsigned int count, int flags),
> +	TP_ARGS(count, flags),
> +	TP_STRUCT__entry(__field(unsigned int, count) __field(int, flags)),
> +	TP_fast_assign(tp_assign(count, count) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_inotify_rm_watch
> +SC_TRACE_EVENT(sys_inotify_rm_watch,
> +	TP_PROTO(int fd, __s32 wd),
> +	TP_ARGS(fd, wd),
> +	TP_STRUCT__entry(__field(int, fd) __field(__s32, wd)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(wd, wd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_ioprio_get
> +SC_TRACE_EVENT(sys_ioprio_get,
> +	TP_PROTO(int which, int who),
> +	TP_ARGS(which, who),
> +	TP_STRUCT__entry(__field(int, which) __field(int, who)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(who, who)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_flock
> +SC_TRACE_EVENT(sys_flock,
> +	TP_PROTO(unsigned int fd, unsigned int cmd),
> +	TP_ARGS(fd, cmd),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(unsigned int, cmd)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(cmd, cmd)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_ftruncate
> +SC_TRACE_EVENT(sys_ftruncate,
> +	TP_PROTO(unsigned int fd, unsigned long length),
> +	TP_ARGS(fd, length),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(unsigned long, length)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(length, length)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fchmod
> +SC_TRACE_EVENT(sys_fchmod,
> +	TP_PROTO(unsigned int fd, mode_t mode),
> +	TP_ARGS(fd, mode),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(mode_t, mode)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(mode, mode)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timerfd_create
> +SC_TRACE_EVENT(sys_timerfd_create,
> +	TP_PROTO(int clockid, int flags),
> +	TP_ARGS(clockid, flags),
> +	TP_STRUCT__entry(__field(int, clockid) __field(int, flags)),
> +	TP_fast_assign(tp_assign(clockid, clockid) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_kill
> +SC_TRACE_EVENT(sys_kill,
> +	TP_PROTO(pid_t pid, int sig),
> +	TP_ARGS(pid, sig),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(int, sig)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(sig, sig)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_tkill
> +SC_TRACE_EVENT(sys_tkill,
> +	TP_PROTO(pid_t pid, int sig),
> +	TP_ARGS(pid, sig),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(int, sig)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(sig, sig)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getpriority
> +SC_TRACE_EVENT(sys_getpriority,
> +	TP_PROTO(int which, int who),
> +	TP_ARGS(which, who),
> +	TP_STRUCT__entry(__field(int, which) __field(int, who)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(who, who)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setregid
> +SC_TRACE_EVENT(sys_setregid,
> +	TP_PROTO(gid_t rgid, gid_t egid),
> +	TP_ARGS(rgid, egid),
> +	TP_STRUCT__entry(__field(gid_t, rgid) __field(gid_t, egid)),
> +	TP_fast_assign(tp_assign(rgid, rgid) tp_assign(egid, egid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setreuid
> +SC_TRACE_EVENT(sys_setreuid,
> +	TP_PROTO(uid_t ruid, uid_t euid),
> +	TP_ARGS(ruid, euid),
> +	TP_STRUCT__entry(__field(uid_t, ruid) __field(uid_t, euid)),
> +	TP_fast_assign(tp_assign(ruid, ruid) tp_assign(euid, euid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setpgid
> +SC_TRACE_EVENT(sys_setpgid,
> +	TP_PROTO(pid_t pid, pid_t pgid),
> +	TP_ARGS(pid, pgid),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(pid_t, pgid)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(pgid, pgid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_msgget
> +SC_TRACE_EVENT(sys_msgget,
> +	TP_PROTO(key_t key, int msgflg),
> +	TP_ARGS(key, msgflg),
> +	TP_STRUCT__entry(__field(key_t, key) __field(int, msgflg)),
> +	TP_fast_assign(tp_assign(key, key) tp_assign(msgflg, msgflg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_listen
> +SC_TRACE_EVENT(sys_listen,
> +	TP_PROTO(int fd, int backlog),
> +	TP_ARGS(fd, backlog),
> +	TP_STRUCT__entry(__field(int, fd) __field(int, backlog)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(backlog, backlog)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_shutdown
> +SC_TRACE_EVENT(sys_shutdown,
> +	TP_PROTO(int fd, int how),
> +	TP_ARGS(fd, how),
> +	TP_STRUCT__entry(__field(int, fd) __field(int, how)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(how, how)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_munmap
> +SC_TRACE_EVENT(sys_munmap,
> +	TP_PROTO(unsigned long addr, size_t len),
> +	TP_ARGS(addr, len),
> +	TP_STRUCT__entry(__field_hex(unsigned long, addr) __field(size_t, len)),
> +	TP_fast_assign(tp_assign(addr, addr) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mlock
> +SC_TRACE_EVENT(sys_mlock,
> +	TP_PROTO(unsigned long start, size_t len),
> +	TP_ARGS(start, len),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(size_t, len)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_munlock
> +SC_TRACE_EVENT(sys_munlock,
> +	TP_PROTO(unsigned long start, size_t len),
> +	TP_ARGS(start, len),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(size_t, len)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setns
> +SC_TRACE_EVENT(sys_setns,
> +	TP_PROTO(int fd, int nstype),
> +	TP_ARGS(fd, nstype),
> +	TP_STRUCT__entry(__field(int, fd) __field(int, nstype)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(nstype, nstype)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_dup3
> +SC_TRACE_EVENT(sys_dup3,
> +	TP_PROTO(unsigned int oldfd, unsigned int newfd, int flags),
> +	TP_ARGS(oldfd, newfd, flags),
> +	TP_STRUCT__entry(__field(unsigned int, oldfd) __field(unsigned int, newfd) __field(int, flags)),
> +	TP_fast_assign(tp_assign(oldfd, oldfd) tp_assign(newfd, newfd) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fcntl
> +SC_TRACE_EVENT(sys_fcntl,
> +	TP_PROTO(unsigned int fd, unsigned int cmd, unsigned long arg),
> +	TP_ARGS(fd, cmd, arg),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(unsigned int, cmd) __field(unsigned long, arg)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(cmd, cmd) tp_assign(arg, arg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_ioctl
> +SC_TRACE_EVENT(sys_ioctl,
> +	TP_PROTO(unsigned int fd, unsigned int cmd, unsigned long arg),
> +	TP_ARGS(fd, cmd, arg),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(unsigned int, cmd) __field(unsigned long, arg)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(cmd, cmd) tp_assign(arg, arg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_ioprio_set
> +SC_TRACE_EVENT(sys_ioprio_set,
> +	TP_PROTO(int which, int who, int ioprio),
> +	TP_ARGS(which, who, ioprio),
> +	TP_STRUCT__entry(__field(int, which) __field(int, who) __field(int, ioprio)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(who, who) tp_assign(ioprio, ioprio)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fchown
> +SC_TRACE_EVENT(sys_fchown,
> +	TP_PROTO(unsigned int fd, uid_t user, gid_t group),
> +	TP_ARGS(fd, user, group),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(uid_t, user) __field(gid_t, group)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(user, user) tp_assign(group, group)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_lseek
> +SC_TRACE_EVENT(sys_lseek,
> +	TP_PROTO(unsigned int fd, off_t offset, unsigned int origin),
> +	TP_ARGS(fd, offset, origin),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field(off_t, offset) __field(unsigned int, origin)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(offset, offset) tp_assign(origin, origin)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_tgkill
> +SC_TRACE_EVENT(sys_tgkill,
> +	TP_PROTO(pid_t tgid, pid_t pid, int sig),
> +	TP_ARGS(tgid, pid, sig),
> +	TP_STRUCT__entry(__field(pid_t, tgid) __field(pid_t, pid) __field(int, sig)),
> +	TP_fast_assign(tp_assign(tgid, tgid) tp_assign(pid, pid) tp_assign(sig, sig)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setpriority
> +SC_TRACE_EVENT(sys_setpriority,
> +	TP_PROTO(int which, int who, int niceval),
> +	TP_ARGS(which, who, niceval),
> +	TP_STRUCT__entry(__field(int, which) __field(int, who) __field(int, niceval)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(who, who) tp_assign(niceval, niceval)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setresuid
> +SC_TRACE_EVENT(sys_setresuid,
> +	TP_PROTO(uid_t ruid, uid_t euid, uid_t suid),
> +	TP_ARGS(ruid, euid, suid),
> +	TP_STRUCT__entry(__field(uid_t, ruid) __field(uid_t, euid) __field(uid_t, suid)),
> +	TP_fast_assign(tp_assign(ruid, ruid) tp_assign(euid, euid) tp_assign(suid, suid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setresgid
> +SC_TRACE_EVENT(sys_setresgid,
> +	TP_PROTO(gid_t rgid, gid_t egid, gid_t sgid),
> +	TP_ARGS(rgid, egid, sgid),
> +	TP_STRUCT__entry(__field(gid_t, rgid) __field(gid_t, egid) __field(gid_t, sgid)),
> +	TP_fast_assign(tp_assign(rgid, rgid) tp_assign(egid, egid) tp_assign(sgid, sgid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_semget
> +SC_TRACE_EVENT(sys_semget,
> +	TP_PROTO(key_t key, int nsems, int semflg),
> +	TP_ARGS(key, nsems, semflg),
> +	TP_STRUCT__entry(__field(key_t, key) __field(int, nsems) __field(int, semflg)),
> +	TP_fast_assign(tp_assign(key, key) tp_assign(nsems, nsems) tp_assign(semflg, semflg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_shmget
> +SC_TRACE_EVENT(sys_shmget,
> +	TP_PROTO(key_t key, size_t size, int shmflg),
> +	TP_ARGS(key, size, shmflg),
> +	TP_STRUCT__entry(__field(key_t, key) __field(size_t, size) __field(int, shmflg)),
> +	TP_fast_assign(tp_assign(key, key) tp_assign(size, size) tp_assign(shmflg, shmflg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_socket
> +SC_TRACE_EVENT(sys_socket,
> +	TP_PROTO(int family, int type, int protocol),
> +	TP_ARGS(family, type, protocol),
> +	TP_STRUCT__entry(__field(int, family) __field(int, type) __field(int, protocol)),
> +	TP_fast_assign(tp_assign(family, family) tp_assign(type, type) tp_assign(protocol, protocol)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mprotect
> +SC_TRACE_EVENT(sys_mprotect,
> +	TP_PROTO(unsigned long start, size_t len, unsigned long prot),
> +	TP_ARGS(start, len, prot),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(size_t, len) __field(unsigned long, prot)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len, len) tp_assign(prot, prot)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_msync
> +SC_TRACE_EVENT(sys_msync,
> +	TP_PROTO(unsigned long start, size_t len, int flags),
> +	TP_ARGS(start, len, flags),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(size_t, len) __field(int, flags)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len, len) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_madvise
> +SC_TRACE_EVENT(sys_madvise,
> +	TP_PROTO(unsigned long start, size_t len_in, int behavior),
> +	TP_ARGS(start, len_in, behavior),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(size_t, len_in) __field(int, behavior)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len_in, len_in) tp_assign(behavior, behavior)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_cacheflush
> +SC_TRACE_EVENT(sys_cacheflush,
> +	TP_PROTO(unsigned long addr, unsigned long len, unsigned long flags),
> +	TP_ARGS(addr, len, flags),
> +	TP_STRUCT__entry(__field_hex(unsigned long, addr) __field(unsigned long, len) __field(unsigned long, flags)),
> +	TP_fast_assign(tp_assign(addr, addr) tp_assign(len, len) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_tee
> +SC_TRACE_EVENT(sys_tee,
> +	TP_PROTO(int fdin, int fdout, size_t len, unsigned int flags),
> +	TP_ARGS(fdin, fdout, len, flags),
> +	TP_STRUCT__entry(__field(int, fdin) __field(int, fdout) __field(size_t, len) __field(unsigned int, flags)),
> +	TP_fast_assign(tp_assign(fdin, fdin) tp_assign(fdout, fdout) tp_assign(len, len) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_ptrace
> +SC_TRACE_EVENT(sys_ptrace,
> +	TP_PROTO(long request, long pid, unsigned long addr, unsigned long data),
> +	TP_ARGS(request, pid, addr, data),
> +	TP_STRUCT__entry(__field(long, request) __field(long, pid) __field_hex(unsigned long, addr) __field(unsigned long, data)),
> +	TP_fast_assign(tp_assign(request, request) tp_assign(pid, pid) tp_assign(addr, addr) tp_assign(data, data)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_prctl
> +SC_TRACE_EVENT(sys_prctl,
> +	TP_PROTO(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5),
> +	TP_ARGS(option, arg2, arg3, arg4, arg5),
> +	TP_STRUCT__entry(__field(int, option) __field(unsigned long, arg2) __field(unsigned long, arg3) __field(unsigned long, arg4) __field(unsigned long, arg5)),
> +	TP_fast_assign(tp_assign(option, option) tp_assign(arg2, arg2) tp_assign(arg3, arg3) tp_assign(arg4, arg4) tp_assign(arg5, arg5)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mremap
> +SC_TRACE_EVENT(sys_mremap,
> +	TP_PROTO(unsigned long addr, unsigned long old_len, unsigned long new_len, unsigned long flags, unsigned long new_addr),
> +	TP_ARGS(addr, old_len, new_len, flags, new_addr),
> +	TP_STRUCT__entry(__field_hex(unsigned long, addr) __field(unsigned long, old_len) __field(unsigned long, new_len) __field(unsigned long, flags) __field_hex(unsigned long, new_addr)),
> +	TP_fast_assign(tp_assign(addr, addr) tp_assign(old_len, old_len) tp_assign(new_len, new_len) tp_assign(flags, flags) tp_assign(new_addr, new_addr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_keyctl
> +SC_TRACE_EVENT(sys_keyctl,
> +	TP_PROTO(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5),
> +	TP_ARGS(option, arg2, arg3, arg4, arg5),
> +	TP_STRUCT__entry(__field(int, option) __field(unsigned long, arg2) __field(unsigned long, arg3) __field(unsigned long, arg4) __field(unsigned long, arg5)),
> +	TP_fast_assign(tp_assign(option, option) tp_assign(arg2, arg2) tp_assign(arg3, arg3) tp_assign(arg4, arg4) tp_assign(arg5, arg5)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_remap_file_pages
> +SC_TRACE_EVENT(sys_remap_file_pages,
> +	TP_PROTO(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long flags),
> +	TP_ARGS(start, size, prot, pgoff, flags),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(unsigned long, size) __field(unsigned long, prot) __field(unsigned long, pgoff) __field(unsigned long, flags)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(size, size) tp_assign(prot, prot) tp_assign(pgoff, pgoff) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mmap
> +SC_TRACE_EVENT(sys_mmap,
> +	TP_PROTO(unsigned long addr, unsigned long len, unsigned long prot, unsigned long flags, unsigned long fd, off_t offset),
> +	TP_ARGS(addr, len, prot, flags, fd, offset),
> +	TP_STRUCT__entry(__field_hex(unsigned long, addr) __field(unsigned long, len) __field(unsigned long, prot) __field(unsigned long, flags) __field(unsigned long, fd) __field(off_t, offset)),
> +	TP_fast_assign(tp_assign(addr, addr) tp_assign(len, len) tp_assign(prot, prot) tp_assign(flags, flags) tp_assign(fd, fd) tp_assign(offset, offset)),
> +	TP_printk()
> +)
> +#endif
> +
> +#endif /*  _TRACE_SYSCALLS_INTEGERS_H */
> +
> +/* This part must be outside protection */
> +#include "../../../probes/define_trace.h"
> +
> +#else /* CREATE_SYSCALL_TABLE */
> +
> +#include "tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers_override.h"
> +#include "syscalls_integers_override.h"
> +
> +#ifndef OVERRIDE_TABLE_64_sys_vhangup
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_vhangup, 58, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sync
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_sync, 81, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_yield
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_sched_yield, 124, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_restart_syscall
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_restart_syscall, 128, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setsid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_setsid, 157, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getpid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_getpid, 172, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getppid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_getppid, 173, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getuid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_getuid, 174, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_geteuid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_geteuid, 175, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getgid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_getgid, 176, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getegid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_getegid, 177, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_gettid
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_gettid, 178, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_munlockall
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_munlockall, 231, 0)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_io_destroy
> +TRACE_SYSCALL_TABLE(sys_io_destroy, sys_io_destroy, 1, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_eventfd2
> +TRACE_SYSCALL_TABLE(sys_eventfd2, sys_eventfd2, 19, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_epoll_create1
> +TRACE_SYSCALL_TABLE(sys_epoll_create1, sys_epoll_create1, 20, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_dup
> +TRACE_SYSCALL_TABLE(sys_dup, sys_dup, 23, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_dup3
> +TRACE_SYSCALL_TABLE(sys_dup3, sys_dup3, 24, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fcntl
> +TRACE_SYSCALL_TABLE(sys_fcntl, sys_fcntl, 25, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_inotify_init1
> +TRACE_SYSCALL_TABLE(sys_inotify_init1, sys_inotify_init1, 26, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_inotify_rm_watch
> +TRACE_SYSCALL_TABLE(sys_inotify_rm_watch, sys_inotify_rm_watch, 28, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_ioctl
> +TRACE_SYSCALL_TABLE(sys_ioctl, sys_ioctl, 29, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_ioprio_set
> +TRACE_SYSCALL_TABLE(sys_ioprio_set, sys_ioprio_set, 30, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_ioprio_get
> +TRACE_SYSCALL_TABLE(sys_ioprio_get, sys_ioprio_get, 31, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_flock
> +TRACE_SYSCALL_TABLE(sys_flock, sys_flock, 32, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_ftruncate
> +TRACE_SYSCALL_TABLE(sys_ftruncate, sys_ftruncate, 46, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fchdir
> +TRACE_SYSCALL_TABLE(sys_fchdir, sys_fchdir, 50, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fchmod
> +TRACE_SYSCALL_TABLE(sys_fchmod, sys_fchmod, 52, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fchown
> +TRACE_SYSCALL_TABLE(sys_fchown, sys_fchown, 55, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_close
> +TRACE_SYSCALL_TABLE(sys_close, sys_close, 57, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_lseek
> +TRACE_SYSCALL_TABLE(sys_lseek, sys_lseek, 62, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_tee
> +TRACE_SYSCALL_TABLE(sys_tee, sys_tee, 77, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fsync
> +TRACE_SYSCALL_TABLE(sys_fsync, sys_fsync, 82, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fdatasync
> +TRACE_SYSCALL_TABLE(sys_fdatasync, sys_fdatasync, 83, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timerfd_create
> +TRACE_SYSCALL_TABLE(sys_timerfd_create, sys_timerfd_create, 85, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_personality
> +TRACE_SYSCALL_TABLE(sys_personality, sys_personality, 92, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_exit
> +TRACE_SYSCALL_TABLE(sys_exit, sys_exit, 93, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_exit_group
> +TRACE_SYSCALL_TABLE(sys_exit_group, sys_exit_group, 94, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_unshare
> +TRACE_SYSCALL_TABLE(sys_unshare, sys_unshare, 97, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timer_getoverrun
> +TRACE_SYSCALL_TABLE(sys_timer_getoverrun, sys_timer_getoverrun, 109, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timer_delete
> +TRACE_SYSCALL_TABLE(sys_timer_delete, sys_timer_delete, 111, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_ptrace
> +TRACE_SYSCALL_TABLE(sys_ptrace, sys_ptrace, 117, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_getscheduler
> +TRACE_SYSCALL_TABLE(sys_sched_getscheduler, sys_sched_getscheduler, 120, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_get_priority_max
> +TRACE_SYSCALL_TABLE(sys_sched_get_priority_max, sys_sched_get_priority_max, 125, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_get_priority_min
> +TRACE_SYSCALL_TABLE(sys_sched_get_priority_min, sys_sched_get_priority_min, 126, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_kill
> +TRACE_SYSCALL_TABLE(sys_kill, sys_kill, 129, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_tkill
> +TRACE_SYSCALL_TABLE(sys_tkill, sys_tkill, 130, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_tgkill
> +TRACE_SYSCALL_TABLE(sys_tgkill, sys_tgkill, 131, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setpriority
> +TRACE_SYSCALL_TABLE(sys_setpriority, sys_setpriority, 140, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getpriority
> +TRACE_SYSCALL_TABLE(sys_getpriority, sys_getpriority, 141, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setregid
> +TRACE_SYSCALL_TABLE(sys_setregid, sys_setregid, 143, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setgid
> +TRACE_SYSCALL_TABLE(sys_setgid, sys_setgid, 144, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setreuid
> +TRACE_SYSCALL_TABLE(sys_setreuid, sys_setreuid, 145, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setuid
> +TRACE_SYSCALL_TABLE(sys_setuid, sys_setuid, 146, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setresuid
> +TRACE_SYSCALL_TABLE(sys_setresuid, sys_setresuid, 147, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setresgid
> +TRACE_SYSCALL_TABLE(sys_setresgid, sys_setresgid, 149, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setfsuid
> +TRACE_SYSCALL_TABLE(sys_setfsuid, sys_setfsuid, 151, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setfsgid
> +TRACE_SYSCALL_TABLE(sys_setfsgid, sys_setfsgid, 152, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setpgid
> +TRACE_SYSCALL_TABLE(sys_setpgid, sys_setpgid, 154, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getpgid
> +TRACE_SYSCALL_TABLE(sys_getpgid, sys_getpgid, 155, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getsid
> +TRACE_SYSCALL_TABLE(sys_getsid, sys_getsid, 156, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_umask
> +TRACE_SYSCALL_TABLE(sys_umask, sys_umask, 166, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_prctl
> +TRACE_SYSCALL_TABLE(sys_prctl, sys_prctl, 167, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_msgget
> +TRACE_SYSCALL_TABLE(sys_msgget, sys_msgget, 186, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_semget
> +TRACE_SYSCALL_TABLE(sys_semget, sys_semget, 190, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_shmget
> +TRACE_SYSCALL_TABLE(sys_shmget, sys_shmget, 194, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_socket
> +TRACE_SYSCALL_TABLE(sys_socket, sys_socket, 198, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_listen
> +TRACE_SYSCALL_TABLE(sys_listen, sys_listen, 201, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_shutdown
> +TRACE_SYSCALL_TABLE(sys_shutdown, sys_shutdown, 210, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_brk
> +TRACE_SYSCALL_TABLE(sys_brk, sys_brk, 214, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_munmap
> +TRACE_SYSCALL_TABLE(sys_munmap, sys_munmap, 215, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mremap
> +TRACE_SYSCALL_TABLE(sys_mremap, sys_mremap, 216, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_keyctl
> +TRACE_SYSCALL_TABLE(sys_keyctl, sys_keyctl, 219, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mmap
> +TRACE_SYSCALL_TABLE(sys_mmap, sys_mmap, 222, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mprotect
> +TRACE_SYSCALL_TABLE(sys_mprotect, sys_mprotect, 226, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_msync
> +TRACE_SYSCALL_TABLE(sys_msync, sys_msync, 227, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mlock
> +TRACE_SYSCALL_TABLE(sys_mlock, sys_mlock, 228, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_munlock
> +TRACE_SYSCALL_TABLE(sys_munlock, sys_munlock, 229, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mlockall
> +TRACE_SYSCALL_TABLE(sys_mlockall, sys_mlockall, 230, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_madvise
> +TRACE_SYSCALL_TABLE(sys_madvise, sys_madvise, 233, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_remap_file_pages
> +TRACE_SYSCALL_TABLE(sys_remap_file_pages, sys_remap_file_pages, 234, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_cacheflush
> +TRACE_SYSCALL_TABLE(sys_cacheflush, sys_cacheflush, 245, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_set_dataplane
> +TRACE_SYSCALL_TABLE(sys_set_dataplane, sys_set_dataplane, 246, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_syncfs
> +TRACE_SYSCALL_TABLE(sys_syncfs, sys_syncfs, 267, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setns
> +TRACE_SYSCALL_TABLE(sys_setns, sys_setns, 268, 2)
> +#endif
> +
> +#endif /* CREATE_SYSCALL_TABLE */
> diff --git a/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers_override.h b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers_override.h
> new file mode 100644
> index 0000000..013be72
> --- /dev/null
> +++ b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_integers_override.h
> @@ -0,0 +1,52 @@
> +#ifndef CREATE_SYSCALL_TABLE
> +
> +#define OVERRIDE_64_sys_sync_file_range
> +SC_TRACE_EVENT(sys_sync_file_range,
> +	TP_PROTO(int fd, loff_t offset, loff_t nbytes, unsigned int flags),
> +	TP_ARGS(fd, offset, nbytes, flags),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__field(loff_t, offset)
> +		__field(loff_t, nbytes)
> +		__field_hex(unsigned int, flags)),
> +	TP_fast_assign(
> +		tp_assign(fd, fd)
> +		tp_assign(offset, offset)
> +		tp_assign(nbytes, nbytes)
> +		tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +
> +#define OVERRIDE_64_sys_fadvise64_64
> +SC_TRACE_EVENT(sys_fadvise64_64,
> +	TP_PROTO(int fd, loff_t offset, loff_t len, int advice),
> +	TP_ARGS(fd, offset, len, advice),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__field(loff_t, offset)
> +		__field(loff_t, len)
> +		__field_hex(int, advice)),
> +	TP_fast_assign(
> +		tp_assign(fd, fd)
> +		tp_assign(offset, offset)
> +		tp_assign(len, len)
> +		tp_assign(advice, advice)),
> +	TP_printk()
> +)
> +
> +SC_DEFINE_EVENT_NOARGS(syscalls_noargs, sys_rt_sigreturn)
> +
> +#else	/* CREATE_SYSCALL_TABLE */
> +
> +#define OVERRIDE_TABLE_64_sys_sync_file_range
> +TRACE_SYSCALL_TABLE(sys_sync_file_range, sys_sync_file_range, 84, 4)
> +
> +#define OVERRIDE_TABLE_64_sys_fadvise64_64
> +TRACE_SYSCALL_TABLE(sys_fadvise64_64, sys_fadvise64_64, 223, 4)
> +
> +#define OVERRIDE_TABLE_64_sys_rt_sigreturn
> +TRACE_SYSCALL_TABLE(syscalls_noargs, sys_rt_sigreturn, 139, 0)
> +
> +#endif /* CREATE_SYSCALL_TABLE */
> +
> +
> diff --git a/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers.h b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers.h
> new file mode 100644
> index 0000000..89d8b60
> --- /dev/null
> +++ b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers.h
> @@ -0,0 +1,1872 @@
> +/* THIS FILE IS AUTO-GENERATED. DO NOT EDIT */
> +#ifndef CREATE_SYSCALL_TABLE
> +
> +#if !defined(_TRACE_SYSCALLS_POINTERS_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SYSCALLS_POINTERS_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/syscalls.h>
> +#include "tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers_override.h"
> +#include "syscalls_pointers_override.h"
> +
> +#ifndef OVERRIDE_64_sys_chdir
> +SC_TRACE_EVENT(sys_chdir,
> +	TP_PROTO(const char * filename),
> +	TP_ARGS(filename),
> +	TP_STRUCT__entry(__string_from_user(filename, filename)),
> +	TP_fast_assign(tp_copy_string_from_user(filename, filename)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_chroot
> +SC_TRACE_EVENT(sys_chroot,
> +	TP_PROTO(const char * filename),
> +	TP_ARGS(filename),
> +	TP_STRUCT__entry(__string_from_user(filename, filename)),
> +	TP_fast_assign(tp_copy_string_from_user(filename, filename)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_acct
> +SC_TRACE_EVENT(sys_acct,
> +	TP_PROTO(const char * name),
> +	TP_ARGS(name),
> +	TP_STRUCT__entry(__string_from_user(name, name)),
> +	TP_fast_assign(tp_copy_string_from_user(name, name)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_set_tid_address
> +SC_TRACE_EVENT(sys_set_tid_address,
> +	TP_PROTO(int * tidptr),
> +	TP_ARGS(tidptr),
> +	TP_STRUCT__entry(__field_hex(int *, tidptr)),
> +	TP_fast_assign(tp_assign(tidptr, tidptr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_times
> +SC_TRACE_EVENT(sys_times,
> +	TP_PROTO(struct tms * tbuf),
> +	TP_ARGS(tbuf),
> +	TP_STRUCT__entry(__field_hex(struct tms *, tbuf)),
> +	TP_fast_assign(tp_assign(tbuf, tbuf)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_newuname
> +SC_TRACE_EVENT(sys_newuname,
> +	TP_PROTO(struct new_utsname * name),
> +	TP_ARGS(name),
> +	TP_STRUCT__entry(__field_hex(struct new_utsname *, name)),
> +	TP_fast_assign(tp_assign(name, name)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_adjtimex
> +SC_TRACE_EVENT(sys_adjtimex,
> +	TP_PROTO(struct timex * txc_p),
> +	TP_ARGS(txc_p),
> +	TP_STRUCT__entry(__field_hex(struct timex *, txc_p)),
> +	TP_fast_assign(tp_assign(txc_p, txc_p)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sysinfo
> +SC_TRACE_EVENT(sys_sysinfo,
> +	TP_PROTO(struct sysinfo * info),
> +	TP_ARGS(info),
> +	TP_STRUCT__entry(__field_hex(struct sysinfo *, info)),
> +	TP_fast_assign(tp_assign(info, info)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mq_unlink
> +SC_TRACE_EVENT(sys_mq_unlink,
> +	TP_PROTO(const char * u_name),
> +	TP_ARGS(u_name),
> +	TP_STRUCT__entry(__string_from_user(u_name, u_name)),
> +	TP_fast_assign(tp_copy_string_from_user(u_name, u_name)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_shmdt
> +SC_TRACE_EVENT(sys_shmdt,
> +	TP_PROTO(char * shmaddr),
> +	TP_ARGS(shmaddr),
> +	TP_STRUCT__entry(__field_hex(char *, shmaddr)),
> +	TP_fast_assign(tp_assign(shmaddr, shmaddr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_swapoff
> +SC_TRACE_EVENT(sys_swapoff,
> +	TP_PROTO(const char * specialfile),
> +	TP_ARGS(specialfile),
> +	TP_STRUCT__entry(__string_from_user(specialfile, specialfile)),
> +	TP_fast_assign(tp_copy_string_from_user(specialfile, specialfile)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_io_setup
> +SC_TRACE_EVENT(sys_io_setup,
> +	TP_PROTO(unsigned nr_events, aio_context_t * ctxp),
> +	TP_ARGS(nr_events, ctxp),
> +	TP_STRUCT__entry(__field(unsigned, nr_events) __field_hex(aio_context_t *, ctxp)),
> +	TP_fast_assign(tp_assign(nr_events, nr_events) tp_assign(ctxp, ctxp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_removexattr
> +SC_TRACE_EVENT(sys_removexattr,
> +	TP_PROTO(const char * pathname, const char * name),
> +	TP_ARGS(pathname, name),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __string_from_user(name, name)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_copy_string_from_user(name, name)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_lremovexattr
> +SC_TRACE_EVENT(sys_lremovexattr,
> +	TP_PROTO(const char * pathname, const char * name),
> +	TP_ARGS(pathname, name),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __string_from_user(name, name)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_copy_string_from_user(name, name)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fremovexattr
> +SC_TRACE_EVENT(sys_fremovexattr,
> +	TP_PROTO(int fd, const char * name),
> +	TP_ARGS(fd, name),
> +	TP_STRUCT__entry(__field(int, fd) __string_from_user(name, name)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_copy_string_from_user(name, name)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getcwd
> +SC_TRACE_EVENT(sys_getcwd,
> +	TP_PROTO(char * buf, unsigned long size),
> +	TP_ARGS(buf, size),
> +	TP_STRUCT__entry(__field_hex(char *, buf) __field(unsigned long, size)),
> +	TP_fast_assign(tp_assign(buf, buf) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_umount
> +SC_TRACE_EVENT(sys_umount,
> +	TP_PROTO(char * name, int flags),
> +	TP_ARGS(name, flags),
> +	TP_STRUCT__entry(__string_from_user(name, name) __field(int, flags)),
> +	TP_fast_assign(tp_copy_string_from_user(name, name) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_pivot_root
> +SC_TRACE_EVENT(sys_pivot_root,
> +	TP_PROTO(const char * new_root, const char * put_old),
> +	TP_ARGS(new_root, put_old),
> +	TP_STRUCT__entry(__string_from_user(new_root, new_root) __string_from_user(put_old, put_old)),
> +	TP_fast_assign(tp_copy_string_from_user(new_root, new_root) tp_copy_string_from_user(put_old, put_old)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_statfs
> +SC_TRACE_EVENT(sys_statfs,
> +	TP_PROTO(const char * pathname, struct statfs * buf),
> +	TP_ARGS(pathname, buf),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __field_hex(struct statfs *, buf)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_assign(buf, buf)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fstatfs
> +SC_TRACE_EVENT(sys_fstatfs,
> +	TP_PROTO(unsigned int fd, struct statfs * buf),
> +	TP_ARGS(fd, buf),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(struct statfs *, buf)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_truncate
> +SC_TRACE_EVENT(sys_truncate,
> +	TP_PROTO(const char * path, long length),
> +	TP_ARGS(path, length),
> +	TP_STRUCT__entry(__string_from_user(path, path) __field(long, length)),
> +	TP_fast_assign(tp_copy_string_from_user(path, path) tp_assign(length, length)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_pipe2
> +SC_TRACE_EVENT(sys_pipe2,
> +	TP_PROTO(int * fildes, int flags),
> +	TP_ARGS(fildes, flags),
> +	TP_STRUCT__entry(__field_hex(int *, fildes) __field(int, flags)),
> +	TP_fast_assign(tp_assign(fildes, fildes) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_newfstat
> +SC_TRACE_EVENT(sys_newfstat,
> +	TP_PROTO(unsigned int fd, struct stat * statbuf),
> +	TP_ARGS(fd, statbuf),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(struct stat *, statbuf)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(statbuf, statbuf)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timerfd_gettime
> +SC_TRACE_EVENT(sys_timerfd_gettime,
> +	TP_PROTO(int ufd, struct itimerspec * otmr),
> +	TP_ARGS(ufd, otmr),
> +	TP_STRUCT__entry(__field(int, ufd) __field_hex(struct itimerspec *, otmr)),
> +	TP_fast_assign(tp_assign(ufd, ufd) tp_assign(otmr, otmr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_set_robust_list
> +SC_TRACE_EVENT(sys_set_robust_list,
> +	TP_PROTO(struct robust_list_head * head, size_t len),
> +	TP_ARGS(head, len),
> +	TP_STRUCT__entry(__field_hex(struct robust_list_head *, head) __field(size_t, len)),
> +	TP_fast_assign(tp_assign(head, head) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_nanosleep
> +SC_TRACE_EVENT(sys_nanosleep,
> +	TP_PROTO(struct timespec * rqtp, struct timespec * rmtp),
> +	TP_ARGS(rqtp, rmtp),
> +	TP_STRUCT__entry(__field_hex(struct timespec *, rqtp) __field_hex(struct timespec *, rmtp)),
> +	TP_fast_assign(tp_assign(rqtp, rqtp) tp_assign(rmtp, rmtp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getitimer
> +SC_TRACE_EVENT(sys_getitimer,
> +	TP_PROTO(int which, struct itimerval * value),
> +	TP_ARGS(which, value),
> +	TP_STRUCT__entry(__field(int, which) __field_hex(struct itimerval *, value)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(value, value)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_delete_module
> +SC_TRACE_EVENT(sys_delete_module,
> +	TP_PROTO(const char * name_user, unsigned int flags),
> +	TP_ARGS(name_user, flags),
> +	TP_STRUCT__entry(__string_from_user(name_user, name_user) __field(unsigned int, flags)),
> +	TP_fast_assign(tp_copy_string_from_user(name_user, name_user) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timer_gettime
> +SC_TRACE_EVENT(sys_timer_gettime,
> +	TP_PROTO(timer_t timer_id, struct itimerspec * setting),
> +	TP_ARGS(timer_id, setting),
> +	TP_STRUCT__entry(__field(timer_t, timer_id) __field_hex(struct itimerspec *, setting)),
> +	TP_fast_assign(tp_assign(timer_id, timer_id) tp_assign(setting, setting)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_clock_settime
> +SC_TRACE_EVENT(sys_clock_settime,
> +	TP_PROTO(const clockid_t which_clock, const struct timespec * tp),
> +	TP_ARGS(which_clock, tp),
> +	TP_STRUCT__entry(__field(const clockid_t, which_clock) __field_hex(const struct timespec *, tp)),
> +	TP_fast_assign(tp_assign(which_clock, which_clock) tp_assign(tp, tp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_clock_gettime
> +SC_TRACE_EVENT(sys_clock_gettime,
> +	TP_PROTO(const clockid_t which_clock, struct timespec * tp),
> +	TP_ARGS(which_clock, tp),
> +	TP_STRUCT__entry(__field(const clockid_t, which_clock) __field_hex(struct timespec *, tp)),
> +	TP_fast_assign(tp_assign(which_clock, which_clock) tp_assign(tp, tp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_clock_getres
> +SC_TRACE_EVENT(sys_clock_getres,
> +	TP_PROTO(const clockid_t which_clock, struct timespec * tp),
> +	TP_ARGS(which_clock, tp),
> +	TP_STRUCT__entry(__field(const clockid_t, which_clock) __field_hex(struct timespec *, tp)),
> +	TP_fast_assign(tp_assign(which_clock, which_clock) tp_assign(tp, tp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_setparam
> +SC_TRACE_EVENT(sys_sched_setparam,
> +	TP_PROTO(pid_t pid, struct sched_param * param),
> +	TP_ARGS(pid, param),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field_hex(struct sched_param *, param)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(param, param)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_getparam
> +SC_TRACE_EVENT(sys_sched_getparam,
> +	TP_PROTO(pid_t pid, struct sched_param * param),
> +	TP_ARGS(pid, param),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field_hex(struct sched_param *, param)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(param, param)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_rr_get_interval
> +SC_TRACE_EVENT(sys_sched_rr_get_interval,
> +	TP_PROTO(pid_t pid, struct timespec * interval),
> +	TP_ARGS(pid, interval),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field_hex(struct timespec *, interval)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(interval, interval)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_sigsuspend
> +SC_TRACE_EVENT(sys_rt_sigsuspend,
> +	TP_PROTO(sigset_t * unewset, size_t sigsetsize),
> +	TP_ARGS(unewset, sigsetsize),
> +	TP_STRUCT__entry(__field_hex(sigset_t *, unewset) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(unewset, unewset) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_sigpending
> +SC_TRACE_EVENT(sys_rt_sigpending,
> +	TP_PROTO(sigset_t * set, size_t sigsetsize),
> +	TP_ARGS(set, sigsetsize),
> +	TP_STRUCT__entry(__field_hex(sigset_t *, set) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(set, set) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getgroups
> +SC_TRACE_EVENT(sys_getgroups,
> +	TP_PROTO(int gidsetsize, gid_t * grouplist),
> +	TP_ARGS(gidsetsize, grouplist),
> +	TP_STRUCT__entry(__field(int, gidsetsize) __field_hex(gid_t *, grouplist)),
> +	TP_fast_assign(tp_assign(gidsetsize, gidsetsize) tp_assign(grouplist, grouplist)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setgroups
> +SC_TRACE_EVENT(sys_setgroups,
> +	TP_PROTO(int gidsetsize, gid_t * grouplist),
> +	TP_ARGS(gidsetsize, grouplist),
> +	TP_STRUCT__entry(__field(int, gidsetsize) __field_hex(gid_t *, grouplist)),
> +	TP_fast_assign(tp_assign(gidsetsize, gidsetsize) tp_assign(grouplist, grouplist)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sethostname
> +SC_TRACE_EVENT(sys_sethostname,
> +	TP_PROTO(char * name, int len),
> +	TP_ARGS(name, len),
> +	TP_STRUCT__entry(__string_from_user(name, name) __field(int, len)),
> +	TP_fast_assign(tp_copy_string_from_user(name, name) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setdomainname
> +SC_TRACE_EVENT(sys_setdomainname,
> +	TP_PROTO(char * name, int len),
> +	TP_ARGS(name, len),
> +	TP_STRUCT__entry(__string_from_user(name, name) __field(int, len)),
> +	TP_fast_assign(tp_copy_string_from_user(name, name) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getrlimit
> +SC_TRACE_EVENT(sys_getrlimit,
> +	TP_PROTO(unsigned int resource, struct rlimit * rlim),
> +	TP_ARGS(resource, rlim),
> +	TP_STRUCT__entry(__field(unsigned int, resource) __field_hex(struct rlimit *, rlim)),
> +	TP_fast_assign(tp_assign(resource, resource) tp_assign(rlim, rlim)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setrlimit
> +SC_TRACE_EVENT(sys_setrlimit,
> +	TP_PROTO(unsigned int resource, struct rlimit * rlim),
> +	TP_ARGS(resource, rlim),
> +	TP_STRUCT__entry(__field(unsigned int, resource) __field_hex(struct rlimit *, rlim)),
> +	TP_fast_assign(tp_assign(resource, resource) tp_assign(rlim, rlim)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getrusage
> +SC_TRACE_EVENT(sys_getrusage,
> +	TP_PROTO(int who, struct rusage * ru),
> +	TP_ARGS(who, ru),
> +	TP_STRUCT__entry(__field(int, who) __field_hex(struct rusage *, ru)),
> +	TP_fast_assign(tp_assign(who, who) tp_assign(ru, ru)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_gettimeofday
> +SC_TRACE_EVENT(sys_gettimeofday,
> +	TP_PROTO(struct timeval * tv, struct timezone * tz),
> +	TP_ARGS(tv, tz),
> +	TP_STRUCT__entry(__field_hex(struct timeval *, tv) __field_hex(struct timezone *, tz)),
> +	TP_fast_assign(tp_assign(tv, tv) tp_assign(tz, tz)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_settimeofday
> +SC_TRACE_EVENT(sys_settimeofday,
> +	TP_PROTO(struct timeval * tv, struct timezone * tz),
> +	TP_ARGS(tv, tz),
> +	TP_STRUCT__entry(__field_hex(struct timeval *, tv) __field_hex(struct timezone *, tz)),
> +	TP_fast_assign(tp_assign(tv, tv) tp_assign(tz, tz)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mq_notify
> +SC_TRACE_EVENT(sys_mq_notify,
> +	TP_PROTO(mqd_t mqdes, const struct sigevent * u_notification),
> +	TP_ARGS(mqdes, u_notification),
> +	TP_STRUCT__entry(__field(mqd_t, mqdes) __field_hex(const struct sigevent *, u_notification)),
> +	TP_fast_assign(tp_assign(mqdes, mqdes) tp_assign(u_notification, u_notification)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_swapon
> +SC_TRACE_EVENT(sys_swapon,
> +	TP_PROTO(const char * specialfile, int swap_flags),
> +	TP_ARGS(specialfile, swap_flags),
> +	TP_STRUCT__entry(__string_from_user(specialfile, specialfile) __field(int, swap_flags)),
> +	TP_fast_assign(tp_copy_string_from_user(specialfile, specialfile) tp_assign(swap_flags, swap_flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_clock_adjtime
> +SC_TRACE_EVENT(sys_clock_adjtime,
> +	TP_PROTO(const clockid_t which_clock, struct timex * utx),
> +	TP_ARGS(which_clock, utx),
> +	TP_STRUCT__entry(__field(const clockid_t, which_clock) __field_hex(struct timex *, utx)),
> +	TP_fast_assign(tp_assign(which_clock, which_clock) tp_assign(utx, utx)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_io_submit
> +SC_TRACE_EVENT(sys_io_submit,
> +	TP_PROTO(aio_context_t ctx_id, long nr, struct iocb * * iocbpp),
> +	TP_ARGS(ctx_id, nr, iocbpp),
> +	TP_STRUCT__entry(__field(aio_context_t, ctx_id) __field(long, nr) __field_hex(struct iocb * *, iocbpp)),
> +	TP_fast_assign(tp_assign(ctx_id, ctx_id) tp_assign(nr, nr) tp_assign(iocbpp, iocbpp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_io_cancel
> +SC_TRACE_EVENT(sys_io_cancel,
> +	TP_PROTO(aio_context_t ctx_id, struct iocb * iocb, struct io_event * result),
> +	TP_ARGS(ctx_id, iocb, result),
> +	TP_STRUCT__entry(__field(aio_context_t, ctx_id) __field_hex(struct iocb *, iocb) __field_hex(struct io_event *, result)),
> +	TP_fast_assign(tp_assign(ctx_id, ctx_id) tp_assign(iocb, iocb) tp_assign(result, result)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_listxattr
> +SC_TRACE_EVENT(sys_listxattr,
> +	TP_PROTO(const char * pathname, char * list, size_t size),
> +	TP_ARGS(pathname, list, size),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __field_hex(char *, list) __field(size_t, size)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_assign(list, list) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_llistxattr
> +SC_TRACE_EVENT(sys_llistxattr,
> +	TP_PROTO(const char * pathname, char * list, size_t size),
> +	TP_ARGS(pathname, list, size),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __field_hex(char *, list) __field(size_t, size)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_assign(list, list) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_flistxattr
> +SC_TRACE_EVENT(sys_flistxattr,
> +	TP_PROTO(int fd, char * list, size_t size),
> +	TP_ARGS(fd, list, size),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(char *, list) __field(size_t, size)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(list, list) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_inotify_add_watch
> +SC_TRACE_EVENT(sys_inotify_add_watch,
> +	TP_PROTO(int fd, const char * pathname, u32 mask),
> +	TP_ARGS(fd, pathname, mask),
> +	TP_STRUCT__entry(__field(int, fd) __string_from_user(pathname, pathname) __field(u32, mask)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_copy_string_from_user(pathname, pathname) tp_assign(mask, mask)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mkdirat
> +SC_TRACE_EVENT(sys_mkdirat,
> +	TP_PROTO(int dfd, const char * pathname, int mode),
> +	TP_ARGS(dfd, pathname, mode),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(pathname, pathname) __field(int, mode)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(pathname, pathname) tp_assign(mode, mode)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_unlinkat
> +SC_TRACE_EVENT(sys_unlinkat,
> +	TP_PROTO(int dfd, const char * pathname, int flag),
> +	TP_ARGS(dfd, pathname, flag),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(pathname, pathname) __field(int, flag)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(pathname, pathname) tp_assign(flag, flag)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_symlinkat
> +SC_TRACE_EVENT(sys_symlinkat,
> +	TP_PROTO(const char * oldname, int newdfd, const char * newname),
> +	TP_ARGS(oldname, newdfd, newname),
> +	TP_STRUCT__entry(__string_from_user(oldname, oldname) __field(int, newdfd) __string_from_user(newname, newname)),
> +	TP_fast_assign(tp_copy_string_from_user(oldname, oldname) tp_assign(newdfd, newdfd) tp_copy_string_from_user(newname, newname)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_nfsservctl
> +SC_TRACE_EVENT(sys_nfsservctl,
> +	TP_PROTO(int cmd, struct nfsctl_arg * arg, void * res),
> +	TP_ARGS(cmd, arg, res),
> +	TP_STRUCT__entry(__field(int, cmd) __field_hex(struct nfsctl_arg *, arg) __field_hex(void *, res)),
> +	TP_fast_assign(tp_assign(cmd, cmd) tp_assign(arg, arg) tp_assign(res, res)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_faccessat
> +SC_TRACE_EVENT(sys_faccessat,
> +	TP_PROTO(int dfd, const char * filename, int mode),
> +	TP_ARGS(dfd, filename, mode),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field(int, mode)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(mode, mode)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fchmodat
> +SC_TRACE_EVENT(sys_fchmodat,
> +	TP_PROTO(int dfd, const char * filename, mode_t mode),
> +	TP_ARGS(dfd, filename, mode),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field(mode_t, mode)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(mode, mode)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getdents64
> +SC_TRACE_EVENT(sys_getdents64,
> +	TP_PROTO(unsigned int fd, struct linux_dirent64 * dirent, unsigned int count),
> +	TP_ARGS(fd, dirent, count),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(struct linux_dirent64 *, dirent) __field(unsigned int, count)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(dirent, dirent) tp_assign(count, count)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_read
> +SC_TRACE_EVENT(sys_read,
> +	TP_PROTO(unsigned int fd, char * buf, size_t count),
> +	TP_ARGS(fd, buf, count),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(char *, buf) __field(size_t, count)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count, count)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_write
> +SC_TRACE_EVENT(sys_write,
> +	TP_PROTO(unsigned int fd, const char * buf, size_t count),
> +	TP_ARGS(fd, buf, count),
> +	TP_STRUCT__entry(__field(unsigned int, fd) __field_hex(const char *, buf) __field(size_t, count)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(buf, buf) tp_assign(count, count)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_readv
> +SC_TRACE_EVENT(sys_readv,
> +	TP_PROTO(unsigned long fd, const struct iovec * vec, unsigned long vlen),
> +	TP_ARGS(fd, vec, vlen),
> +	TP_STRUCT__entry(__field(unsigned long, fd) __field_hex(const struct iovec *, vec) __field(unsigned long, vlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(vec, vec) tp_assign(vlen, vlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_writev
> +SC_TRACE_EVENT(sys_writev,
> +	TP_PROTO(unsigned long fd, const struct iovec * vec, unsigned long vlen),
> +	TP_ARGS(fd, vec, vlen),
> +	TP_STRUCT__entry(__field(unsigned long, fd) __field_hex(const struct iovec *, vec) __field(unsigned long, vlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(vec, vec) tp_assign(vlen, vlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_get_robust_list
> +SC_TRACE_EVENT(sys_get_robust_list,
> +	TP_PROTO(int pid, struct robust_list_head * * head_ptr, size_t * len_ptr),
> +	TP_ARGS(pid, head_ptr, len_ptr),
> +	TP_STRUCT__entry(__field(int, pid) __field_hex(struct robust_list_head * *, head_ptr) __field_hex(size_t *, len_ptr)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(head_ptr, head_ptr) tp_assign(len_ptr, len_ptr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setitimer
> +SC_TRACE_EVENT(sys_setitimer,
> +	TP_PROTO(int which, struct itimerval * value, struct itimerval * ovalue),
> +	TP_ARGS(which, value, ovalue),
> +	TP_STRUCT__entry(__field(int, which) __field_hex(struct itimerval *, value) __field_hex(struct itimerval *, ovalue)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(value, value) tp_assign(ovalue, ovalue)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_init_module
> +SC_TRACE_EVENT(sys_init_module,
> +	TP_PROTO(void * umod, unsigned long len, const char * uargs),
> +	TP_ARGS(umod, len, uargs),
> +	TP_STRUCT__entry(__field_hex(void *, umod) __field(unsigned long, len) __field_hex(const char *, uargs)),
> +	TP_fast_assign(tp_assign(umod, umod) tp_assign(len, len) tp_assign(uargs, uargs)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timer_create
> +SC_TRACE_EVENT(sys_timer_create,
> +	TP_PROTO(const clockid_t which_clock, struct sigevent * timer_event_spec, timer_t * created_timer_id),
> +	TP_ARGS(which_clock, timer_event_spec, created_timer_id),
> +	TP_STRUCT__entry(__field(const clockid_t, which_clock) __field_hex(struct sigevent *, timer_event_spec) __field_hex(timer_t *, created_timer_id)),
> +	TP_fast_assign(tp_assign(which_clock, which_clock) tp_assign(timer_event_spec, timer_event_spec) tp_assign(created_timer_id, created_timer_id)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_syslog
> +SC_TRACE_EVENT(sys_syslog,
> +	TP_PROTO(int type, char * buf, int len),
> +	TP_ARGS(type, buf, len),
> +	TP_STRUCT__entry(__field(int, type) __field_hex(char *, buf) __field(int, len)),
> +	TP_fast_assign(tp_assign(type, type) tp_assign(buf, buf) tp_assign(len, len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_setscheduler
> +SC_TRACE_EVENT(sys_sched_setscheduler,
> +	TP_PROTO(pid_t pid, int policy, struct sched_param * param),
> +	TP_ARGS(pid, policy, param),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(int, policy) __field_hex(struct sched_param *, param)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(policy, policy) tp_assign(param, param)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_setaffinity
> +SC_TRACE_EVENT(sys_sched_setaffinity,
> +	TP_PROTO(pid_t pid, unsigned int len, unsigned long * user_mask_ptr),
> +	TP_ARGS(pid, len, user_mask_ptr),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(unsigned int, len) __field_hex(unsigned long *, user_mask_ptr)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(len, len) tp_assign(user_mask_ptr, user_mask_ptr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sched_getaffinity
> +SC_TRACE_EVENT(sys_sched_getaffinity,
> +	TP_PROTO(pid_t pid, unsigned int len, unsigned long * user_mask_ptr),
> +	TP_ARGS(pid, len, user_mask_ptr),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(unsigned int, len) __field_hex(unsigned long *, user_mask_ptr)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(len, len) tp_assign(user_mask_ptr, user_mask_ptr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_sigqueueinfo
> +SC_TRACE_EVENT(sys_rt_sigqueueinfo,
> +	TP_PROTO(pid_t pid, int sig, siginfo_t * uinfo),
> +	TP_ARGS(pid, sig, uinfo),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(int, sig) __field_hex(siginfo_t *, uinfo)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(sig, sig) tp_assign(uinfo, uinfo)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getresuid
> +SC_TRACE_EVENT(sys_getresuid,
> +	TP_PROTO(uid_t * ruid, uid_t * euid, uid_t * suid),
> +	TP_ARGS(ruid, euid, suid),
> +	TP_STRUCT__entry(__field_hex(uid_t *, ruid) __field_hex(uid_t *, euid) __field_hex(uid_t *, suid)),
> +	TP_fast_assign(tp_assign(ruid, ruid) tp_assign(euid, euid) tp_assign(suid, suid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getresgid
> +SC_TRACE_EVENT(sys_getresgid,
> +	TP_PROTO(gid_t * rgid, gid_t * egid, gid_t * sgid),
> +	TP_ARGS(rgid, egid, sgid),
> +	TP_STRUCT__entry(__field_hex(gid_t *, rgid) __field_hex(gid_t *, egid) __field_hex(gid_t *, sgid)),
> +	TP_fast_assign(tp_assign(rgid, rgid) tp_assign(egid, egid) tp_assign(sgid, sgid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getcpu
> +SC_TRACE_EVENT(sys_getcpu,
> +	TP_PROTO(unsigned * cpup, unsigned * nodep, struct getcpu_cache * unused),
> +	TP_ARGS(cpup, nodep, unused),
> +	TP_STRUCT__entry(__field_hex(unsigned *, cpup) __field_hex(unsigned *, nodep) __field_hex(struct getcpu_cache *, unused)),
> +	TP_fast_assign(tp_assign(cpup, cpup) tp_assign(nodep, nodep) tp_assign(unused, unused)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mq_getsetattr
> +SC_TRACE_EVENT(sys_mq_getsetattr,
> +	TP_PROTO(mqd_t mqdes, const struct mq_attr * u_mqstat, struct mq_attr * u_omqstat),
> +	TP_ARGS(mqdes, u_mqstat, u_omqstat),
> +	TP_STRUCT__entry(__field(mqd_t, mqdes) __field_hex(const struct mq_attr *, u_mqstat) __field_hex(struct mq_attr *, u_omqstat)),
> +	TP_fast_assign(tp_assign(mqdes, mqdes) tp_assign(u_mqstat, u_mqstat) tp_assign(u_omqstat, u_omqstat)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_msgctl
> +SC_TRACE_EVENT(sys_msgctl,
> +	TP_PROTO(int msqid, int cmd, struct msqid_ds * buf),
> +	TP_ARGS(msqid, cmd, buf),
> +	TP_STRUCT__entry(__field(int, msqid) __field(int, cmd) __field_hex(struct msqid_ds *, buf)),
> +	TP_fast_assign(tp_assign(msqid, msqid) tp_assign(cmd, cmd) tp_assign(buf, buf)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_semop
> +SC_TRACE_EVENT(sys_semop,
> +	TP_PROTO(int semid, struct sembuf * tsops, unsigned nsops),
> +	TP_ARGS(semid, tsops, nsops),
> +	TP_STRUCT__entry(__field(int, semid) __field_hex(struct sembuf *, tsops) __field(unsigned, nsops)),
> +	TP_fast_assign(tp_assign(semid, semid) tp_assign(tsops, tsops) tp_assign(nsops, nsops)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_shmctl
> +SC_TRACE_EVENT(sys_shmctl,
> +	TP_PROTO(int shmid, int cmd, struct shmid_ds * buf),
> +	TP_ARGS(shmid, cmd, buf),
> +	TP_STRUCT__entry(__field(int, shmid) __field(int, cmd) __field_hex(struct shmid_ds *, buf)),
> +	TP_fast_assign(tp_assign(shmid, shmid) tp_assign(cmd, cmd) tp_assign(buf, buf)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_shmat
> +SC_TRACE_EVENT(sys_shmat,
> +	TP_PROTO(int shmid, char * shmaddr, int shmflg),
> +	TP_ARGS(shmid, shmaddr, shmflg),
> +	TP_STRUCT__entry(__field(int, shmid) __field_hex(char *, shmaddr) __field(int, shmflg)),
> +	TP_fast_assign(tp_assign(shmid, shmid) tp_assign(shmaddr, shmaddr) tp_assign(shmflg, shmflg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_bind
> +SC_TRACE_EVENT(sys_bind,
> +	TP_PROTO(int fd, struct sockaddr * umyaddr, int addrlen),
> +	TP_ARGS(fd, umyaddr, addrlen),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct sockaddr *, umyaddr) __field_hex(int, addrlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(umyaddr, umyaddr) tp_assign(addrlen, addrlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_accept
> +SC_TRACE_EVENT(sys_accept,
> +	TP_PROTO(int fd, struct sockaddr * upeer_sockaddr, int * upeer_addrlen),
> +	TP_ARGS(fd, upeer_sockaddr, upeer_addrlen),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct sockaddr *, upeer_sockaddr) __field_hex(int *, upeer_addrlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(upeer_sockaddr, upeer_sockaddr) tp_assign(upeer_addrlen, upeer_addrlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_connect
> +SC_TRACE_EVENT(sys_connect,
> +	TP_PROTO(int fd, struct sockaddr * uservaddr, int addrlen),
> +	TP_ARGS(fd, uservaddr, addrlen),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct sockaddr *, uservaddr) __field_hex(int, addrlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(uservaddr, uservaddr) tp_assign(addrlen, addrlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getsockname
> +SC_TRACE_EVENT(sys_getsockname,
> +	TP_PROTO(int fd, struct sockaddr * usockaddr, int * usockaddr_len),
> +	TP_ARGS(fd, usockaddr, usockaddr_len),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct sockaddr *, usockaddr) __field_hex(int *, usockaddr_len)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(usockaddr, usockaddr) tp_assign(usockaddr_len, usockaddr_len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getpeername
> +SC_TRACE_EVENT(sys_getpeername,
> +	TP_PROTO(int fd, struct sockaddr * usockaddr, int * usockaddr_len),
> +	TP_ARGS(fd, usockaddr, usockaddr_len),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct sockaddr *, usockaddr) __field_hex(int *, usockaddr_len)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(usockaddr, usockaddr) tp_assign(usockaddr_len, usockaddr_len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sendmsg
> +SC_TRACE_EVENT(sys_sendmsg,
> +	TP_PROTO(int fd, struct msghdr * msg, unsigned flags),
> +	TP_ARGS(fd, msg, flags),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct msghdr *, msg) __field(unsigned, flags)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(msg, msg) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_recvmsg
> +SC_TRACE_EVENT(sys_recvmsg,
> +	TP_PROTO(int fd, struct msghdr * msg, unsigned int flags),
> +	TP_ARGS(fd, msg, flags),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct msghdr *, msg) __field(unsigned int, flags)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(msg, msg) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mincore
> +SC_TRACE_EVENT(sys_mincore,
> +	TP_PROTO(unsigned long start, size_t len, unsigned char * vec),
> +	TP_ARGS(start, len, vec),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(size_t, len) __field_hex(unsigned char *, vec)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len, len) tp_assign(vec, vec)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_set_mempolicy
> +SC_TRACE_EVENT(sys_set_mempolicy,
> +	TP_PROTO(int mode, unsigned long * nmask, unsigned long maxnode),
> +	TP_ARGS(mode, nmask, maxnode),
> +	TP_STRUCT__entry(__field(int, mode) __field_hex(unsigned long *, nmask) __field(unsigned long, maxnode)),
> +	TP_fast_assign(tp_assign(mode, mode) tp_assign(nmask, nmask) tp_assign(maxnode, maxnode)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_open_by_handle_at
> +SC_TRACE_EVENT(sys_open_by_handle_at,
> +	TP_PROTO(int mountdirfd, struct file_handle * handle, int flags),
> +	TP_ARGS(mountdirfd, handle, flags),
> +	TP_STRUCT__entry(__field(int, mountdirfd) __field_hex(struct file_handle *, handle) __field(int, flags)),
> +	TP_fast_assign(tp_assign(mountdirfd, mountdirfd) tp_assign(handle, handle) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getxattr
> +SC_TRACE_EVENT(sys_getxattr,
> +	TP_PROTO(const char * pathname, const char * name, void * value, size_t size),
> +	TP_ARGS(pathname, name, value, size),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __string_from_user(name, name) __field_hex(void *, value) __field(size_t, size)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_copy_string_from_user(name, name) tp_assign(value, value) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_lgetxattr
> +SC_TRACE_EVENT(sys_lgetxattr,
> +	TP_PROTO(const char * pathname, const char * name, void * value, size_t size),
> +	TP_ARGS(pathname, name, value, size),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __string_from_user(name, name) __field_hex(void *, value) __field(size_t, size)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_copy_string_from_user(name, name) tp_assign(value, value) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fgetxattr
> +SC_TRACE_EVENT(sys_fgetxattr,
> +	TP_PROTO(int fd, const char * name, void * value, size_t size),
> +	TP_ARGS(fd, name, value, size),
> +	TP_STRUCT__entry(__field(int, fd) __string_from_user(name, name) __field_hex(void *, value) __field(size_t, size)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_copy_string_from_user(name, name) tp_assign(value, value) tp_assign(size, size)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_epoll_ctl
> +SC_TRACE_EVENT(sys_epoll_ctl,
> +	TP_PROTO(int epfd, int op, int fd, struct epoll_event * event),
> +	TP_ARGS(epfd, op, fd, event),
> +	TP_STRUCT__entry(__field(int, epfd) __field(int, op) __field(int, fd) __field_hex(struct epoll_event *, event)),
> +	TP_fast_assign(tp_assign(epfd, epfd) tp_assign(op, op) tp_assign(fd, fd) tp_assign(event, event)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mknodat
> +SC_TRACE_EVENT(sys_mknodat,
> +	TP_PROTO(int dfd, const char * filename, int mode, unsigned dev),
> +	TP_ARGS(dfd, filename, mode, dev),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field(int, mode) __field(unsigned, dev)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(mode, mode) tp_assign(dev, dev)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_renameat
> +SC_TRACE_EVENT(sys_renameat,
> +	TP_PROTO(int olddfd, const char * oldname, int newdfd, const char * newname),
> +	TP_ARGS(olddfd, oldname, newdfd, newname),
> +	TP_STRUCT__entry(__field(int, olddfd) __string_from_user(oldname, oldname) __field(int, newdfd) __string_from_user(newname, newname)),
> +	TP_fast_assign(tp_assign(olddfd, olddfd) tp_copy_string_from_user(oldname, oldname) tp_assign(newdfd, newdfd) tp_copy_string_from_user(newname, newname)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_openat
> +SC_TRACE_EVENT(sys_openat,
> +	TP_PROTO(int dfd, const char * filename, int flags, int mode),
> +	TP_ARGS(dfd, filename, flags, mode),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field(int, flags) __field(int, mode)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(flags, flags) tp_assign(mode, mode)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_quotactl
> +SC_TRACE_EVENT(sys_quotactl,
> +	TP_PROTO(unsigned int cmd, const char * special, qid_t id, void * addr),
> +	TP_ARGS(cmd, special, id, addr),
> +	TP_STRUCT__entry(__field(unsigned int, cmd) __field_hex(const char *, special) __field(qid_t, id) __field_hex(void *, addr)),
> +	TP_fast_assign(tp_assign(cmd, cmd) tp_assign(special, special) tp_assign(id, id) tp_assign(addr, addr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sendfile64
> +SC_TRACE_EVENT(sys_sendfile64,
> +	TP_PROTO(int out_fd, int in_fd, loff_t * offset, size_t count),
> +	TP_ARGS(out_fd, in_fd, offset, count),
> +	TP_STRUCT__entry(__field(int, out_fd) __field(int, in_fd) __field_hex(loff_t *, offset) __field(size_t, count)),
> +	TP_fast_assign(tp_assign(out_fd, out_fd) tp_assign(in_fd, in_fd) tp_assign(offset, offset) tp_assign(count, count)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_signalfd4
> +SC_TRACE_EVENT(sys_signalfd4,
> +	TP_PROTO(int ufd, sigset_t * user_mask, size_t sizemask, int flags),
> +	TP_ARGS(ufd, user_mask, sizemask, flags),
> +	TP_STRUCT__entry(__field(int, ufd) __field_hex(sigset_t *, user_mask) __field(size_t, sizemask) __field(int, flags)),
> +	TP_fast_assign(tp_assign(ufd, ufd) tp_assign(user_mask, user_mask) tp_assign(sizemask, sizemask) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_vmsplice
> +SC_TRACE_EVENT(sys_vmsplice,
> +	TP_PROTO(int fd, const struct iovec * iov, unsigned long nr_segs, unsigned int flags),
> +	TP_ARGS(fd, iov, nr_segs, flags),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(const struct iovec *, iov) __field(unsigned long, nr_segs) __field(unsigned int, flags)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(iov, iov) tp_assign(nr_segs, nr_segs) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_readlinkat
> +SC_TRACE_EVENT(sys_readlinkat,
> +	TP_PROTO(int dfd, const char * pathname, char * buf, int bufsiz),
> +	TP_ARGS(dfd, pathname, buf, bufsiz),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(pathname, pathname) __field_hex(char *, buf) __field(int, bufsiz)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(pathname, pathname) tp_assign(buf, buf) tp_assign(bufsiz, bufsiz)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_newfstatat
> +SC_TRACE_EVENT(sys_newfstatat,
> +	TP_PROTO(int dfd, const char * filename, struct stat * statbuf, int flag),
> +	TP_ARGS(dfd, filename, statbuf, flag),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field_hex(struct stat *, statbuf) __field(int, flag)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(statbuf, statbuf) tp_assign(flag, flag)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timerfd_settime
> +SC_TRACE_EVENT(sys_timerfd_settime,
> +	TP_PROTO(int ufd, int flags, const struct itimerspec * utmr, struct itimerspec * otmr),
> +	TP_ARGS(ufd, flags, utmr, otmr),
> +	TP_STRUCT__entry(__field(int, ufd) __field(int, flags) __field_hex(const struct itimerspec *, utmr) __field_hex(struct itimerspec *, otmr)),
> +	TP_fast_assign(tp_assign(ufd, ufd) tp_assign(flags, flags) tp_assign(utmr, utmr) tp_assign(otmr, otmr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_utimensat
> +SC_TRACE_EVENT(sys_utimensat,
> +	TP_PROTO(int dfd, const char * filename, struct timespec * utimes, int flags),
> +	TP_ARGS(dfd, filename, utimes, flags),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field_hex(struct timespec *, utimes) __field(int, flags)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(utimes, utimes) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_timer_settime
> +SC_TRACE_EVENT(sys_timer_settime,
> +	TP_PROTO(timer_t timer_id, int flags, const struct itimerspec * new_setting, struct itimerspec * old_setting),
> +	TP_ARGS(timer_id, flags, new_setting, old_setting),
> +	TP_STRUCT__entry(__field(timer_t, timer_id) __field(int, flags) __field_hex(const struct itimerspec *, new_setting) __field_hex(struct itimerspec *, old_setting)),
> +	TP_fast_assign(tp_assign(timer_id, timer_id) tp_assign(flags, flags) tp_assign(new_setting, new_setting) tp_assign(old_setting, old_setting)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_clock_nanosleep
> +SC_TRACE_EVENT(sys_clock_nanosleep,
> +	TP_PROTO(const clockid_t which_clock, int flags, const struct timespec * rqtp, struct timespec * rmtp),
> +	TP_ARGS(which_clock, flags, rqtp, rmtp),
> +	TP_STRUCT__entry(__field(const clockid_t, which_clock) __field(int, flags) __field_hex(const struct timespec *, rqtp) __field_hex(struct timespec *, rmtp)),
> +	TP_fast_assign(tp_assign(which_clock, which_clock) tp_assign(flags, flags) tp_assign(rqtp, rqtp) tp_assign(rmtp, rmtp)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_sigaction
> +SC_TRACE_EVENT(sys_rt_sigaction,
> +	TP_PROTO(int sig, const struct sigaction * act, struct sigaction * oact, size_t sigsetsize),
> +	TP_ARGS(sig, act, oact, sigsetsize),
> +	TP_STRUCT__entry(__field(int, sig) __field_hex(const struct sigaction *, act) __field_hex(struct sigaction *, oact) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(sig, sig) tp_assign(act, act) tp_assign(oact, oact) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_sigprocmask
> +SC_TRACE_EVENT(sys_rt_sigprocmask,
> +	TP_PROTO(int how, sigset_t * nset, sigset_t * oset, size_t sigsetsize),
> +	TP_ARGS(how, nset, oset, sigsetsize),
> +	TP_STRUCT__entry(__field(int, how) __field_hex(sigset_t *, nset) __field_hex(sigset_t *, oset) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(how, how) tp_assign(nset, nset) tp_assign(oset, oset) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_sigtimedwait
> +SC_TRACE_EVENT(sys_rt_sigtimedwait,
> +	TP_PROTO(const sigset_t * uthese, siginfo_t * uinfo, const struct timespec * uts, size_t sigsetsize),
> +	TP_ARGS(uthese, uinfo, uts, sigsetsize),
> +	TP_STRUCT__entry(__field_hex(const sigset_t *, uthese) __field_hex(siginfo_t *, uinfo) __field_hex(const struct timespec *, uts) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(uthese, uthese) tp_assign(uinfo, uinfo) tp_assign(uts, uts) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_reboot
> +SC_TRACE_EVENT(sys_reboot,
> +	TP_PROTO(int magic1, int magic2, unsigned int cmd, void * arg),
> +	TP_ARGS(magic1, magic2, cmd, arg),
> +	TP_STRUCT__entry(__field(int, magic1) __field(int, magic2) __field(unsigned int, cmd) __field_hex(void *, arg)),
> +	TP_fast_assign(tp_assign(magic1, magic1) tp_assign(magic2, magic2) tp_assign(cmd, cmd) tp_assign(arg, arg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mq_open
> +SC_TRACE_EVENT(sys_mq_open,
> +	TP_PROTO(const char * u_name, int oflag, mode_t mode, struct mq_attr * u_attr),
> +	TP_ARGS(u_name, oflag, mode, u_attr),
> +	TP_STRUCT__entry(__string_from_user(u_name, u_name) __field(int, oflag) __field(mode_t, mode) __field_hex(struct mq_attr *, u_attr)),
> +	TP_fast_assign(tp_copy_string_from_user(u_name, u_name) tp_assign(oflag, oflag) tp_assign(mode, mode) tp_assign(u_attr, u_attr)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_msgsnd
> +SC_TRACE_EVENT(sys_msgsnd,
> +	TP_PROTO(int msqid, struct msgbuf * msgp, size_t msgsz, int msgflg),
> +	TP_ARGS(msqid, msgp, msgsz, msgflg),
> +	TP_STRUCT__entry(__field(int, msqid) __field_hex(struct msgbuf *, msgp) __field(size_t, msgsz) __field(int, msgflg)),
> +	TP_fast_assign(tp_assign(msqid, msqid) tp_assign(msgp, msgp) tp_assign(msgsz, msgsz) tp_assign(msgflg, msgflg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_semtimedop
> +SC_TRACE_EVENT(sys_semtimedop,
> +	TP_PROTO(int semid, struct sembuf * tsops, unsigned nsops, const struct timespec * timeout),
> +	TP_ARGS(semid, tsops, nsops, timeout),
> +	TP_STRUCT__entry(__field(int, semid) __field_hex(struct sembuf *, tsops) __field(unsigned, nsops) __field_hex(const struct timespec *, timeout)),
> +	TP_fast_assign(tp_assign(semid, semid) tp_assign(tsops, tsops) tp_assign(nsops, nsops) tp_assign(timeout, timeout)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_socketpair
> +SC_TRACE_EVENT(sys_socketpair,
> +	TP_PROTO(int family, int type, int protocol, int * usockvec),
> +	TP_ARGS(family, type, protocol, usockvec),
> +	TP_STRUCT__entry(__field(int, family) __field(int, type) __field(int, protocol) __field_hex(int *, usockvec)),
> +	TP_fast_assign(tp_assign(family, family) tp_assign(type, type) tp_assign(protocol, protocol) tp_assign(usockvec, usockvec)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_request_key
> +SC_TRACE_EVENT(sys_request_key,
> +	TP_PROTO(const char * _type, const char * _description, const char * _callout_info, key_serial_t destringid),
> +	TP_ARGS(_type, _description, _callout_info, destringid),
> +	TP_STRUCT__entry(__string_from_user(_type, _type) __field_hex(const char *, _description) __field_hex(const char *, _callout_info) __field(key_serial_t, destringid)),
> +	TP_fast_assign(tp_copy_string_from_user(_type, _type) tp_assign(_description, _description) tp_assign(_callout_info, _callout_info) tp_assign(destringid, destringid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_migrate_pages
> +SC_TRACE_EVENT(sys_migrate_pages,
> +	TP_PROTO(pid_t pid, unsigned long maxnode, const unsigned long * old_nodes, const unsigned long * new_nodes),
> +	TP_ARGS(pid, maxnode, old_nodes, new_nodes),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(unsigned long, maxnode) __field_hex(const unsigned long *, old_nodes) __field_hex(const unsigned long *, new_nodes)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(maxnode, maxnode) tp_assign(old_nodes, old_nodes) tp_assign(new_nodes, new_nodes)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_rt_tgsigqueueinfo
> +SC_TRACE_EVENT(sys_rt_tgsigqueueinfo,
> +	TP_PROTO(pid_t tgid, pid_t pid, int sig, siginfo_t * uinfo),
> +	TP_ARGS(tgid, pid, sig, uinfo),
> +	TP_STRUCT__entry(__field(pid_t, tgid) __field(pid_t, pid) __field(int, sig) __field_hex(siginfo_t *, uinfo)),
> +	TP_fast_assign(tp_assign(tgid, tgid) tp_assign(pid, pid) tp_assign(sig, sig) tp_assign(uinfo, uinfo)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_accept4
> +SC_TRACE_EVENT(sys_accept4,
> +	TP_PROTO(int fd, struct sockaddr * upeer_sockaddr, int * upeer_addrlen, int flags),
> +	TP_ARGS(fd, upeer_sockaddr, upeer_addrlen, flags),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct sockaddr *, upeer_sockaddr) __field_hex(int *, upeer_addrlen) __field(int, flags)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(upeer_sockaddr, upeer_sockaddr) tp_assign(upeer_addrlen, upeer_addrlen) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_wait4
> +SC_TRACE_EVENT(sys_wait4,
> +	TP_PROTO(pid_t upid, int * stat_addr, int options, struct rusage * ru),
> +	TP_ARGS(upid, stat_addr, options, ru),
> +	TP_STRUCT__entry(__field(pid_t, upid) __field_hex(int *, stat_addr) __field(int, options) __field_hex(struct rusage *, ru)),
> +	TP_fast_assign(tp_assign(upid, upid) tp_assign(stat_addr, stat_addr) tp_assign(options, options) tp_assign(ru, ru)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_prlimit64
> +SC_TRACE_EVENT(sys_prlimit64,
> +	TP_PROTO(pid_t pid, unsigned int resource, const struct rlimit64 * new_rlim, struct rlimit64 * old_rlim),
> +	TP_ARGS(pid, resource, new_rlim, old_rlim),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(unsigned int, resource) __field_hex(const struct rlimit64 *, new_rlim) __field_hex(struct rlimit64 *, old_rlim)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(resource, resource) tp_assign(new_rlim, new_rlim) tp_assign(old_rlim, old_rlim)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sendmmsg
> +SC_TRACE_EVENT(sys_sendmmsg,
> +	TP_PROTO(int fd, struct mmsghdr * mmsg, unsigned int vlen, unsigned int flags),
> +	TP_ARGS(fd, mmsg, vlen, flags),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct mmsghdr *, mmsg) __field(unsigned int, vlen) __field(unsigned int, flags)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(mmsg, mmsg) tp_assign(vlen, vlen) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_io_getevents
> +SC_TRACE_EVENT(sys_io_getevents,
> +	TP_PROTO(aio_context_t ctx_id, long min_nr, long nr, struct io_event * events, struct timespec * timeout),
> +	TP_ARGS(ctx_id, min_nr, nr, events, timeout),
> +	TP_STRUCT__entry(__field(aio_context_t, ctx_id) __field(long, min_nr) __field(long, nr) __field_hex(struct io_event *, events) __field_hex(struct timespec *, timeout)),
> +	TP_fast_assign(tp_assign(ctx_id, ctx_id) tp_assign(min_nr, min_nr) tp_assign(nr, nr) tp_assign(events, events) tp_assign(timeout, timeout)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setxattr
> +SC_TRACE_EVENT(sys_setxattr,
> +	TP_PROTO(const char * pathname, const char * name, const void * value, size_t size, int flags),
> +	TP_ARGS(pathname, name, value, size, flags),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __string_from_user(name, name) __field_hex(const void *, value) __field(size_t, size) __field(int, flags)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_copy_string_from_user(name, name) tp_assign(value, value) tp_assign(size, size) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_lsetxattr
> +SC_TRACE_EVENT(sys_lsetxattr,
> +	TP_PROTO(const char * pathname, const char * name, const void * value, size_t size, int flags),
> +	TP_ARGS(pathname, name, value, size, flags),
> +	TP_STRUCT__entry(__string_from_user(pathname, pathname) __string_from_user(name, name) __field_hex(const void *, value) __field(size_t, size) __field(int, flags)),
> +	TP_fast_assign(tp_copy_string_from_user(pathname, pathname) tp_copy_string_from_user(name, name) tp_assign(value, value) tp_assign(size, size) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fsetxattr
> +SC_TRACE_EVENT(sys_fsetxattr,
> +	TP_PROTO(int fd, const char * name, const void * value, size_t size, int flags),
> +	TP_ARGS(fd, name, value, size, flags),
> +	TP_STRUCT__entry(__field(int, fd) __string_from_user(name, name) __field_hex(const void *, value) __field(size_t, size) __field(int, flags)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_copy_string_from_user(name, name) tp_assign(value, value) tp_assign(size, size) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_linkat
> +SC_TRACE_EVENT(sys_linkat,
> +	TP_PROTO(int olddfd, const char * oldname, int newdfd, const char * newname, int flags),
> +	TP_ARGS(olddfd, oldname, newdfd, newname, flags),
> +	TP_STRUCT__entry(__field(int, olddfd) __string_from_user(oldname, oldname) __field(int, newdfd) __string_from_user(newname, newname) __field(int, flags)),
> +	TP_fast_assign(tp_assign(olddfd, olddfd) tp_copy_string_from_user(oldname, oldname) tp_assign(newdfd, newdfd) tp_copy_string_from_user(newname, newname) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mount
> +SC_TRACE_EVENT(sys_mount,
> +	TP_PROTO(char * dev_name, char * dir_name, char * type, unsigned long flags, void * data),
> +	TP_ARGS(dev_name, dir_name, type, flags, data),
> +	TP_STRUCT__entry(__string_from_user(dev_name, dev_name) __string_from_user(dir_name, dir_name) __string_from_user(type, type) __field(unsigned long, flags) __field_hex(void *, data)),
> +	TP_fast_assign(tp_copy_string_from_user(dev_name, dev_name) tp_copy_string_from_user(dir_name, dir_name) tp_copy_string_from_user(type, type) tp_assign(flags, flags) tp_assign(data, data)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_fchownat
> +SC_TRACE_EVENT(sys_fchownat,
> +	TP_PROTO(int dfd, const char * filename, uid_t user, gid_t group, int flag),
> +	TP_ARGS(dfd, filename, user, group, flag),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(filename, filename) __field(uid_t, user) __field(gid_t, group) __field(int, flag)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(filename, filename) tp_assign(user, user) tp_assign(group, group) tp_assign(flag, flag)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_preadv
> +SC_TRACE_EVENT(sys_preadv,
> +	TP_PROTO(unsigned long fd, const struct iovec * vec, unsigned long vlen, unsigned long pos_l, unsigned long pos_h),
> +	TP_ARGS(fd, vec, vlen, pos_l, pos_h),
> +	TP_STRUCT__entry(__field(unsigned long, fd) __field_hex(const struct iovec *, vec) __field(unsigned long, vlen) __field(unsigned long, pos_l) __field(unsigned long, pos_h)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(vec, vec) tp_assign(vlen, vlen) tp_assign(pos_l, pos_l) tp_assign(pos_h, pos_h)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_pwritev
> +SC_TRACE_EVENT(sys_pwritev,
> +	TP_PROTO(unsigned long fd, const struct iovec * vec, unsigned long vlen, unsigned long pos_l, unsigned long pos_h),
> +	TP_ARGS(fd, vec, vlen, pos_l, pos_h),
> +	TP_STRUCT__entry(__field(unsigned long, fd) __field_hex(const struct iovec *, vec) __field(unsigned long, vlen) __field(unsigned long, pos_l) __field(unsigned long, pos_h)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(vec, vec) tp_assign(vlen, vlen) tp_assign(pos_l, pos_l) tp_assign(pos_h, pos_h)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_ppoll
> +SC_TRACE_EVENT(sys_ppoll,
> +	TP_PROTO(struct pollfd * ufds, unsigned int nfds, struct timespec * tsp, const sigset_t * sigmask, size_t sigsetsize),
> +	TP_ARGS(ufds, nfds, tsp, sigmask, sigsetsize),
> +	TP_STRUCT__entry(__field_hex(struct pollfd *, ufds) __field(unsigned int, nfds) __field_hex(struct timespec *, tsp) __field_hex(const sigset_t *, sigmask) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(ufds, ufds) tp_assign(nfds, nfds) tp_assign(tsp, tsp) tp_assign(sigmask, sigmask) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_waitid
> +SC_TRACE_EVENT(sys_waitid,
> +	TP_PROTO(int which, pid_t upid, struct siginfo * infop, int options, struct rusage * ru),
> +	TP_ARGS(which, upid, infop, options, ru),
> +	TP_STRUCT__entry(__field(int, which) __field(pid_t, upid) __field_hex(struct siginfo *, infop) __field(int, options) __field_hex(struct rusage *, ru)),
> +	TP_fast_assign(tp_assign(which, which) tp_assign(upid, upid) tp_assign(infop, infop) tp_assign(options, options) tp_assign(ru, ru)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mq_timedsend
> +SC_TRACE_EVENT(sys_mq_timedsend,
> +	TP_PROTO(mqd_t mqdes, const char * u_msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec * u_abs_timeout),
> +	TP_ARGS(mqdes, u_msg_ptr, msg_len, msg_prio, u_abs_timeout),
> +	TP_STRUCT__entry(__field(mqd_t, mqdes) __field_hex(const char *, u_msg_ptr) __field(size_t, msg_len) __field(unsigned int, msg_prio) __field_hex(const struct timespec *, u_abs_timeout)),
> +	TP_fast_assign(tp_assign(mqdes, mqdes) tp_assign(u_msg_ptr, u_msg_ptr) tp_assign(msg_len, msg_len) tp_assign(msg_prio, msg_prio) tp_assign(u_abs_timeout, u_abs_timeout)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mq_timedreceive
> +SC_TRACE_EVENT(sys_mq_timedreceive,
> +	TP_PROTO(mqd_t mqdes, char * u_msg_ptr, size_t msg_len, unsigned int * u_msg_prio, const struct timespec * u_abs_timeout),
> +	TP_ARGS(mqdes, u_msg_ptr, msg_len, u_msg_prio, u_abs_timeout),
> +	TP_STRUCT__entry(__field(mqd_t, mqdes) __field_hex(char *, u_msg_ptr) __field(size_t, msg_len) __field_hex(unsigned int *, u_msg_prio) __field_hex(const struct timespec *, u_abs_timeout)),
> +	TP_fast_assign(tp_assign(mqdes, mqdes) tp_assign(u_msg_ptr, u_msg_ptr) tp_assign(msg_len, msg_len) tp_assign(u_msg_prio, u_msg_prio) tp_assign(u_abs_timeout, u_abs_timeout)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_msgrcv
> +SC_TRACE_EVENT(sys_msgrcv,
> +	TP_PROTO(int msqid, struct msgbuf * msgp, size_t msgsz, long msgtyp, int msgflg),
> +	TP_ARGS(msqid, msgp, msgsz, msgtyp, msgflg),
> +	TP_STRUCT__entry(__field(int, msqid) __field_hex(struct msgbuf *, msgp) __field(size_t, msgsz) __field(long, msgtyp) __field(int, msgflg)),
> +	TP_fast_assign(tp_assign(msqid, msqid) tp_assign(msgp, msgp) tp_assign(msgsz, msgsz) tp_assign(msgtyp, msgtyp) tp_assign(msgflg, msgflg)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_setsockopt
> +SC_TRACE_EVENT(sys_setsockopt,
> +	TP_PROTO(int fd, int level, int optname, char * optval, int optlen),
> +	TP_ARGS(fd, level, optname, optval, optlen),
> +	TP_STRUCT__entry(__field(int, fd) __field(int, level) __field(int, optname) __field_hex(char *, optval) __field(int, optlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(level, level) tp_assign(optname, optname) tp_assign(optval, optval) tp_assign(optlen, optlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_getsockopt
> +SC_TRACE_EVENT(sys_getsockopt,
> +	TP_PROTO(int fd, int level, int optname, char * optval, int * optlen),
> +	TP_ARGS(fd, level, optname, optval, optlen),
> +	TP_STRUCT__entry(__field(int, fd) __field(int, level) __field(int, optname) __field_hex(char *, optval) __field_hex(int *, optlen)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(level, level) tp_assign(optname, optname) tp_assign(optval, optval) tp_assign(optlen, optlen)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_add_key
> +SC_TRACE_EVENT(sys_add_key,
> +	TP_PROTO(const char * _type, const char * _description, const void * _payload, size_t plen, key_serial_t ringid),
> +	TP_ARGS(_type, _description, _payload, plen, ringid),
> +	TP_STRUCT__entry(__string_from_user(_type, _type) __field_hex(const char *, _description) __field_hex(const void *, _payload) __field(size_t, plen) __field(key_serial_t, ringid)),
> +	TP_fast_assign(tp_copy_string_from_user(_type, _type) tp_assign(_description, _description) tp_assign(_payload, _payload) tp_assign(plen, plen) tp_assign(ringid, ringid)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_get_mempolicy
> +SC_TRACE_EVENT(sys_get_mempolicy,
> +	TP_PROTO(int * policy, unsigned long * nmask, unsigned long maxnode, unsigned long addr, unsigned long flags),
> +	TP_ARGS(policy, nmask, maxnode, addr, flags),
> +	TP_STRUCT__entry(__field_hex(int *, policy) __field_hex(unsigned long *, nmask) __field(unsigned long, maxnode) __field_hex(unsigned long, addr) __field(unsigned long, flags)),
> +	TP_fast_assign(tp_assign(policy, policy) tp_assign(nmask, nmask) tp_assign(maxnode, maxnode) tp_assign(addr, addr) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_perf_event_open
> +SC_TRACE_EVENT(sys_perf_event_open,
> +	TP_PROTO(struct perf_event_attr * attr_uptr, pid_t pid, int cpu, int group_fd, unsigned long flags),
> +	TP_ARGS(attr_uptr, pid, cpu, group_fd, flags),
> +	TP_STRUCT__entry(__field_hex(struct perf_event_attr *, attr_uptr) __field(pid_t, pid) __field(int, cpu) __field(int, group_fd) __field(unsigned long, flags)),
> +	TP_fast_assign(tp_assign(attr_uptr, attr_uptr) tp_assign(pid, pid) tp_assign(cpu, cpu) tp_assign(group_fd, group_fd) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_recvmmsg
> +SC_TRACE_EVENT(sys_recvmmsg,
> +	TP_PROTO(int fd, struct mmsghdr * mmsg, unsigned int vlen, unsigned int flags, struct timespec * timeout),
> +	TP_ARGS(fd, mmsg, vlen, flags, timeout),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(struct mmsghdr *, mmsg) __field(unsigned int, vlen) __field(unsigned int, flags) __field_hex(struct timespec *, timeout)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(mmsg, mmsg) tp_assign(vlen, vlen) tp_assign(flags, flags) tp_assign(timeout, timeout)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_name_to_handle_at
> +SC_TRACE_EVENT(sys_name_to_handle_at,
> +	TP_PROTO(int dfd, const char * name, struct file_handle * handle, int * mnt_id, int flag),
> +	TP_ARGS(dfd, name, handle, mnt_id, flag),
> +	TP_STRUCT__entry(__field(int, dfd) __string_from_user(name, name) __field_hex(struct file_handle *, handle) __field_hex(int *, mnt_id) __field(int, flag)),
> +	TP_fast_assign(tp_assign(dfd, dfd) tp_copy_string_from_user(name, name) tp_assign(handle, handle) tp_assign(mnt_id, mnt_id) tp_assign(flag, flag)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_epoll_pwait
> +SC_TRACE_EVENT(sys_epoll_pwait,
> +	TP_PROTO(int epfd, struct epoll_event * events, int maxevents, int timeout, const sigset_t * sigmask, size_t sigsetsize),
> +	TP_ARGS(epfd, events, maxevents, timeout, sigmask, sigsetsize),
> +	TP_STRUCT__entry(__field(int, epfd) __field_hex(struct epoll_event *, events) __field(int, maxevents) __field(int, timeout) __field_hex(const sigset_t *, sigmask) __field(size_t, sigsetsize)),
> +	TP_fast_assign(tp_assign(epfd, epfd) tp_assign(events, events) tp_assign(maxevents, maxevents) tp_assign(timeout, timeout) tp_assign(sigmask, sigmask) tp_assign(sigsetsize, sigsetsize)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_pselect6
> +SC_TRACE_EVENT(sys_pselect6,
> +	TP_PROTO(int n, fd_set * inp, fd_set * outp, fd_set * exp, struct timespec * tsp, void * sig),
> +	TP_ARGS(n, inp, outp, exp, tsp, sig),
> +	TP_STRUCT__entry(__field(int, n) __field_hex(fd_set *, inp) __field_hex(fd_set *, outp) __field_hex(fd_set *, exp) __field_hex(struct timespec *, tsp) __field_hex(void *, sig)),
> +	TP_fast_assign(tp_assign(n, n) tp_assign(inp, inp) tp_assign(outp, outp) tp_assign(exp, exp) tp_assign(tsp, tsp) tp_assign(sig, sig)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_splice
> +SC_TRACE_EVENT(sys_splice,
> +	TP_PROTO(int fd_in, loff_t * off_in, int fd_out, loff_t * off_out, size_t len, unsigned int flags),
> +	TP_ARGS(fd_in, off_in, fd_out, off_out, len, flags),
> +	TP_STRUCT__entry(__field(int, fd_in) __field_hex(loff_t *, off_in) __field(int, fd_out) __field_hex(loff_t *, off_out) __field(size_t, len) __field(unsigned int, flags)),
> +	TP_fast_assign(tp_assign(fd_in, fd_in) tp_assign(off_in, off_in) tp_assign(fd_out, fd_out) tp_assign(off_out, off_out) tp_assign(len, len) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_futex
> +SC_TRACE_EVENT(sys_futex,
> +	TP_PROTO(u32 * uaddr, int op, u32 val, struct timespec * utime, u32 * uaddr2, u32 val3),
> +	TP_ARGS(uaddr, op, val, utime, uaddr2, val3),
> +	TP_STRUCT__entry(__field_hex(u32 *, uaddr) __field(int, op) __field(u32, val) __field_hex(struct timespec *, utime) __field_hex(u32 *, uaddr2) __field(u32, val3)),
> +	TP_fast_assign(tp_assign(uaddr, uaddr) tp_assign(op, op) tp_assign(val, val) tp_assign(utime, utime) tp_assign(uaddr2, uaddr2) tp_assign(val3, val3)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_sendto
> +SC_TRACE_EVENT(sys_sendto,
> +	TP_PROTO(int fd, void * buff, size_t len, unsigned flags, struct sockaddr * addr, int addr_len),
> +	TP_ARGS(fd, buff, len, flags, addr, addr_len),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(void *, buff) __field(size_t, len) __field(unsigned, flags) __field_hex(struct sockaddr *, addr) __field_hex(int, addr_len)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(buff, buff) tp_assign(len, len) tp_assign(flags, flags) tp_assign(addr, addr) tp_assign(addr_len, addr_len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_recvfrom
> +SC_TRACE_EVENT(sys_recvfrom,
> +	TP_PROTO(int fd, void * ubuf, size_t size, unsigned flags, struct sockaddr * addr, int * addr_len),
> +	TP_ARGS(fd, ubuf, size, flags, addr, addr_len),
> +	TP_STRUCT__entry(__field(int, fd) __field_hex(void *, ubuf) __field(size_t, size) __field(unsigned, flags) __field_hex(struct sockaddr *, addr) __field_hex(int *, addr_len)),
> +	TP_fast_assign(tp_assign(fd, fd) tp_assign(ubuf, ubuf) tp_assign(size, size) tp_assign(flags, flags) tp_assign(addr, addr) tp_assign(addr_len, addr_len)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_mbind
> +SC_TRACE_EVENT(sys_mbind,
> +	TP_PROTO(unsigned long start, unsigned long len, unsigned long mode, unsigned long * nmask, unsigned long maxnode, unsigned flags),
> +	TP_ARGS(start, len, mode, nmask, maxnode, flags),
> +	TP_STRUCT__entry(__field(unsigned long, start) __field(unsigned long, len) __field(unsigned long, mode) __field_hex(unsigned long *, nmask) __field(unsigned long, maxnode) __field(unsigned, flags)),
> +	TP_fast_assign(tp_assign(start, start) tp_assign(len, len) tp_assign(mode, mode) tp_assign(nmask, nmask) tp_assign(maxnode, maxnode) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +#ifndef OVERRIDE_64_sys_move_pages
> +SC_TRACE_EVENT(sys_move_pages,
> +	TP_PROTO(pid_t pid, unsigned long nr_pages, const void * * pages, const int * nodes, int * status, int flags),
> +	TP_ARGS(pid, nr_pages, pages, nodes, status, flags),
> +	TP_STRUCT__entry(__field(pid_t, pid) __field(unsigned long, nr_pages) __field_hex(const void * *, pages) __field_hex(const int *, nodes) __field_hex(int *, status) __field(int, flags)),
> +	TP_fast_assign(tp_assign(pid, pid) tp_assign(nr_pages, nr_pages) tp_assign(pages, pages) tp_assign(nodes, nodes) tp_assign(status, status) tp_assign(flags, flags)),
> +	TP_printk()
> +)
> +#endif
> +
> +#endif /*  _TRACE_SYSCALLS_POINTERS_H */
> +
> +/* This part must be outside protection */
> +#include "../../../probes/define_trace.h"
> +
> +#else /* CREATE_SYSCALL_TABLE */
> +
> +#include "tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers_override.h"
> +#include "syscalls_pointers_override.h"
> +
> +#ifndef OVERRIDE_TABLE_64_sys_io_setup
> +TRACE_SYSCALL_TABLE(sys_io_setup, sys_io_setup, 0, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_io_submit
> +TRACE_SYSCALL_TABLE(sys_io_submit, sys_io_submit, 2, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_io_cancel
> +TRACE_SYSCALL_TABLE(sys_io_cancel, sys_io_cancel, 3, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_io_getevents
> +TRACE_SYSCALL_TABLE(sys_io_getevents, sys_io_getevents, 4, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setxattr
> +TRACE_SYSCALL_TABLE(sys_setxattr, sys_setxattr, 5, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_lsetxattr
> +TRACE_SYSCALL_TABLE(sys_lsetxattr, sys_lsetxattr, 6, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fsetxattr
> +TRACE_SYSCALL_TABLE(sys_fsetxattr, sys_fsetxattr, 7, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getxattr
> +TRACE_SYSCALL_TABLE(sys_getxattr, sys_getxattr, 8, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_lgetxattr
> +TRACE_SYSCALL_TABLE(sys_lgetxattr, sys_lgetxattr, 9, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fgetxattr
> +TRACE_SYSCALL_TABLE(sys_fgetxattr, sys_fgetxattr, 10, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_listxattr
> +TRACE_SYSCALL_TABLE(sys_listxattr, sys_listxattr, 11, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_llistxattr
> +TRACE_SYSCALL_TABLE(sys_llistxattr, sys_llistxattr, 12, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_flistxattr
> +TRACE_SYSCALL_TABLE(sys_flistxattr, sys_flistxattr, 13, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_removexattr
> +TRACE_SYSCALL_TABLE(sys_removexattr, sys_removexattr, 14, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_lremovexattr
> +TRACE_SYSCALL_TABLE(sys_lremovexattr, sys_lremovexattr, 15, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fremovexattr
> +TRACE_SYSCALL_TABLE(sys_fremovexattr, sys_fremovexattr, 16, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getcwd
> +TRACE_SYSCALL_TABLE(sys_getcwd, sys_getcwd, 17, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_epoll_ctl
> +TRACE_SYSCALL_TABLE(sys_epoll_ctl, sys_epoll_ctl, 21, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_epoll_pwait
> +TRACE_SYSCALL_TABLE(sys_epoll_pwait, sys_epoll_pwait, 22, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_inotify_add_watch
> +TRACE_SYSCALL_TABLE(sys_inotify_add_watch, sys_inotify_add_watch, 27, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mknodat
> +TRACE_SYSCALL_TABLE(sys_mknodat, sys_mknodat, 33, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mkdirat
> +TRACE_SYSCALL_TABLE(sys_mkdirat, sys_mkdirat, 34, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_unlinkat
> +TRACE_SYSCALL_TABLE(sys_unlinkat, sys_unlinkat, 35, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_symlinkat
> +TRACE_SYSCALL_TABLE(sys_symlinkat, sys_symlinkat, 36, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_linkat
> +TRACE_SYSCALL_TABLE(sys_linkat, sys_linkat, 37, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_renameat
> +TRACE_SYSCALL_TABLE(sys_renameat, sys_renameat, 38, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_umount
> +TRACE_SYSCALL_TABLE(sys_umount, sys_umount, 39, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mount
> +TRACE_SYSCALL_TABLE(sys_mount, sys_mount, 40, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_pivot_root
> +TRACE_SYSCALL_TABLE(sys_pivot_root, sys_pivot_root, 41, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_nfsservctl
> +TRACE_SYSCALL_TABLE(sys_nfsservctl, sys_nfsservctl, 42, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_statfs
> +TRACE_SYSCALL_TABLE(sys_statfs, sys_statfs, 43, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fstatfs
> +TRACE_SYSCALL_TABLE(sys_fstatfs, sys_fstatfs, 44, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_truncate
> +TRACE_SYSCALL_TABLE(sys_truncate, sys_truncate, 45, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_faccessat
> +TRACE_SYSCALL_TABLE(sys_faccessat, sys_faccessat, 48, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_chdir
> +TRACE_SYSCALL_TABLE(sys_chdir, sys_chdir, 49, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_chroot
> +TRACE_SYSCALL_TABLE(sys_chroot, sys_chroot, 51, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fchmodat
> +TRACE_SYSCALL_TABLE(sys_fchmodat, sys_fchmodat, 53, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_fchownat
> +TRACE_SYSCALL_TABLE(sys_fchownat, sys_fchownat, 54, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_openat
> +TRACE_SYSCALL_TABLE(sys_openat, sys_openat, 56, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_pipe2
> +TRACE_SYSCALL_TABLE(sys_pipe2, sys_pipe2, 59, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_quotactl
> +TRACE_SYSCALL_TABLE(sys_quotactl, sys_quotactl, 60, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getdents64
> +TRACE_SYSCALL_TABLE(sys_getdents64, sys_getdents64, 61, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_read
> +TRACE_SYSCALL_TABLE(sys_read, sys_read, 63, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_write
> +TRACE_SYSCALL_TABLE(sys_write, sys_write, 64, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_readv
> +TRACE_SYSCALL_TABLE(sys_readv, sys_readv, 65, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_writev
> +TRACE_SYSCALL_TABLE(sys_writev, sys_writev, 66, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_preadv
> +TRACE_SYSCALL_TABLE(sys_preadv, sys_preadv, 69, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_pwritev
> +TRACE_SYSCALL_TABLE(sys_pwritev, sys_pwritev, 70, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sendfile64
> +TRACE_SYSCALL_TABLE(sys_sendfile64, sys_sendfile64, 71, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_pselect6
> +TRACE_SYSCALL_TABLE(sys_pselect6, sys_pselect6, 72, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_ppoll
> +TRACE_SYSCALL_TABLE(sys_ppoll, sys_ppoll, 73, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_signalfd4
> +TRACE_SYSCALL_TABLE(sys_signalfd4, sys_signalfd4, 74, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_vmsplice
> +TRACE_SYSCALL_TABLE(sys_vmsplice, sys_vmsplice, 75, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_splice
> +TRACE_SYSCALL_TABLE(sys_splice, sys_splice, 76, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_readlinkat
> +TRACE_SYSCALL_TABLE(sys_readlinkat, sys_readlinkat, 78, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_newfstatat
> +TRACE_SYSCALL_TABLE(sys_newfstatat, sys_newfstatat, 79, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_newfstat
> +TRACE_SYSCALL_TABLE(sys_newfstat, sys_newfstat, 80, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timerfd_settime
> +TRACE_SYSCALL_TABLE(sys_timerfd_settime, sys_timerfd_settime, 86, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timerfd_gettime
> +TRACE_SYSCALL_TABLE(sys_timerfd_gettime, sys_timerfd_gettime, 87, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_utimensat
> +TRACE_SYSCALL_TABLE(sys_utimensat, sys_utimensat, 88, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_acct
> +TRACE_SYSCALL_TABLE(sys_acct, sys_acct, 89, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_waitid
> +TRACE_SYSCALL_TABLE(sys_waitid, sys_waitid, 95, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_set_tid_address
> +TRACE_SYSCALL_TABLE(sys_set_tid_address, sys_set_tid_address, 96, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_futex
> +TRACE_SYSCALL_TABLE(sys_futex, sys_futex, 98, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_set_robust_list
> +TRACE_SYSCALL_TABLE(sys_set_robust_list, sys_set_robust_list, 99, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_get_robust_list
> +TRACE_SYSCALL_TABLE(sys_get_robust_list, sys_get_robust_list, 100, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_nanosleep
> +TRACE_SYSCALL_TABLE(sys_nanosleep, sys_nanosleep, 101, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getitimer
> +TRACE_SYSCALL_TABLE(sys_getitimer, sys_getitimer, 102, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setitimer
> +TRACE_SYSCALL_TABLE(sys_setitimer, sys_setitimer, 103, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_init_module
> +TRACE_SYSCALL_TABLE(sys_init_module, sys_init_module, 105, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_delete_module
> +TRACE_SYSCALL_TABLE(sys_delete_module, sys_delete_module, 106, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timer_create
> +TRACE_SYSCALL_TABLE(sys_timer_create, sys_timer_create, 107, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timer_gettime
> +TRACE_SYSCALL_TABLE(sys_timer_gettime, sys_timer_gettime, 108, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_timer_settime
> +TRACE_SYSCALL_TABLE(sys_timer_settime, sys_timer_settime, 110, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_clock_settime
> +TRACE_SYSCALL_TABLE(sys_clock_settime, sys_clock_settime, 112, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_clock_gettime
> +TRACE_SYSCALL_TABLE(sys_clock_gettime, sys_clock_gettime, 113, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_clock_getres
> +TRACE_SYSCALL_TABLE(sys_clock_getres, sys_clock_getres, 114, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_clock_nanosleep
> +TRACE_SYSCALL_TABLE(sys_clock_nanosleep, sys_clock_nanosleep, 115, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_syslog
> +TRACE_SYSCALL_TABLE(sys_syslog, sys_syslog, 116, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_setparam
> +TRACE_SYSCALL_TABLE(sys_sched_setparam, sys_sched_setparam, 118, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_setscheduler
> +TRACE_SYSCALL_TABLE(sys_sched_setscheduler, sys_sched_setscheduler, 119, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_getparam
> +TRACE_SYSCALL_TABLE(sys_sched_getparam, sys_sched_getparam, 121, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_setaffinity
> +TRACE_SYSCALL_TABLE(sys_sched_setaffinity, sys_sched_setaffinity, 122, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_getaffinity
> +TRACE_SYSCALL_TABLE(sys_sched_getaffinity, sys_sched_getaffinity, 123, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sched_rr_get_interval
> +TRACE_SYSCALL_TABLE(sys_sched_rr_get_interval, sys_sched_rr_get_interval, 127, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_sigsuspend
> +TRACE_SYSCALL_TABLE(sys_rt_sigsuspend, sys_rt_sigsuspend, 133, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_sigaction
> +TRACE_SYSCALL_TABLE(sys_rt_sigaction, sys_rt_sigaction, 134, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_sigprocmask
> +TRACE_SYSCALL_TABLE(sys_rt_sigprocmask, sys_rt_sigprocmask, 135, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_sigpending
> +TRACE_SYSCALL_TABLE(sys_rt_sigpending, sys_rt_sigpending, 136, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_sigtimedwait
> +TRACE_SYSCALL_TABLE(sys_rt_sigtimedwait, sys_rt_sigtimedwait, 137, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_sigqueueinfo
> +TRACE_SYSCALL_TABLE(sys_rt_sigqueueinfo, sys_rt_sigqueueinfo, 138, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_reboot
> +TRACE_SYSCALL_TABLE(sys_reboot, sys_reboot, 142, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getresuid
> +TRACE_SYSCALL_TABLE(sys_getresuid, sys_getresuid, 148, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getresgid
> +TRACE_SYSCALL_TABLE(sys_getresgid, sys_getresgid, 150, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_times
> +TRACE_SYSCALL_TABLE(sys_times, sys_times, 153, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getgroups
> +TRACE_SYSCALL_TABLE(sys_getgroups, sys_getgroups, 158, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setgroups
> +TRACE_SYSCALL_TABLE(sys_setgroups, sys_setgroups, 159, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_newuname
> +TRACE_SYSCALL_TABLE(sys_newuname, sys_newuname, 160, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sethostname
> +TRACE_SYSCALL_TABLE(sys_sethostname, sys_sethostname, 161, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setdomainname
> +TRACE_SYSCALL_TABLE(sys_setdomainname, sys_setdomainname, 162, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getrlimit
> +TRACE_SYSCALL_TABLE(sys_getrlimit, sys_getrlimit, 163, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setrlimit
> +TRACE_SYSCALL_TABLE(sys_setrlimit, sys_setrlimit, 164, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getrusage
> +TRACE_SYSCALL_TABLE(sys_getrusage, sys_getrusage, 165, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getcpu
> +TRACE_SYSCALL_TABLE(sys_getcpu, sys_getcpu, 168, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_gettimeofday
> +TRACE_SYSCALL_TABLE(sys_gettimeofday, sys_gettimeofday, 169, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_settimeofday
> +TRACE_SYSCALL_TABLE(sys_settimeofday, sys_settimeofday, 170, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_adjtimex
> +TRACE_SYSCALL_TABLE(sys_adjtimex, sys_adjtimex, 171, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sysinfo
> +TRACE_SYSCALL_TABLE(sys_sysinfo, sys_sysinfo, 179, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mq_open
> +TRACE_SYSCALL_TABLE(sys_mq_open, sys_mq_open, 180, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mq_unlink
> +TRACE_SYSCALL_TABLE(sys_mq_unlink, sys_mq_unlink, 181, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mq_timedsend
> +TRACE_SYSCALL_TABLE(sys_mq_timedsend, sys_mq_timedsend, 182, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mq_timedreceive
> +TRACE_SYSCALL_TABLE(sys_mq_timedreceive, sys_mq_timedreceive, 183, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mq_notify
> +TRACE_SYSCALL_TABLE(sys_mq_notify, sys_mq_notify, 184, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mq_getsetattr
> +TRACE_SYSCALL_TABLE(sys_mq_getsetattr, sys_mq_getsetattr, 185, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_msgctl
> +TRACE_SYSCALL_TABLE(sys_msgctl, sys_msgctl, 187, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_msgrcv
> +TRACE_SYSCALL_TABLE(sys_msgrcv, sys_msgrcv, 188, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_msgsnd
> +TRACE_SYSCALL_TABLE(sys_msgsnd, sys_msgsnd, 189, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_semtimedop
> +TRACE_SYSCALL_TABLE(sys_semtimedop, sys_semtimedop, 192, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_semop
> +TRACE_SYSCALL_TABLE(sys_semop, sys_semop, 193, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_shmctl
> +TRACE_SYSCALL_TABLE(sys_shmctl, sys_shmctl, 195, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_shmat
> +TRACE_SYSCALL_TABLE(sys_shmat, sys_shmat, 196, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_shmdt
> +TRACE_SYSCALL_TABLE(sys_shmdt, sys_shmdt, 197, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_socketpair
> +TRACE_SYSCALL_TABLE(sys_socketpair, sys_socketpair, 199, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_bind
> +TRACE_SYSCALL_TABLE(sys_bind, sys_bind, 200, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_accept
> +TRACE_SYSCALL_TABLE(sys_accept, sys_accept, 202, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_connect
> +TRACE_SYSCALL_TABLE(sys_connect, sys_connect, 203, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getsockname
> +TRACE_SYSCALL_TABLE(sys_getsockname, sys_getsockname, 204, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getpeername
> +TRACE_SYSCALL_TABLE(sys_getpeername, sys_getpeername, 205, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sendto
> +TRACE_SYSCALL_TABLE(sys_sendto, sys_sendto, 206, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_recvfrom
> +TRACE_SYSCALL_TABLE(sys_recvfrom, sys_recvfrom, 207, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_setsockopt
> +TRACE_SYSCALL_TABLE(sys_setsockopt, sys_setsockopt, 208, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_getsockopt
> +TRACE_SYSCALL_TABLE(sys_getsockopt, sys_getsockopt, 209, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sendmsg
> +TRACE_SYSCALL_TABLE(sys_sendmsg, sys_sendmsg, 211, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_recvmsg
> +TRACE_SYSCALL_TABLE(sys_recvmsg, sys_recvmsg, 212, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_add_key
> +TRACE_SYSCALL_TABLE(sys_add_key, sys_add_key, 217, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_request_key
> +TRACE_SYSCALL_TABLE(sys_request_key, sys_request_key, 218, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_swapon
> +TRACE_SYSCALL_TABLE(sys_swapon, sys_swapon, 224, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_swapoff
> +TRACE_SYSCALL_TABLE(sys_swapoff, sys_swapoff, 225, 1)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mincore
> +TRACE_SYSCALL_TABLE(sys_mincore, sys_mincore, 232, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_mbind
> +TRACE_SYSCALL_TABLE(sys_mbind, sys_mbind, 235, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_get_mempolicy
> +TRACE_SYSCALL_TABLE(sys_get_mempolicy, sys_get_mempolicy, 236, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_set_mempolicy
> +TRACE_SYSCALL_TABLE(sys_set_mempolicy, sys_set_mempolicy, 237, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_migrate_pages
> +TRACE_SYSCALL_TABLE(sys_migrate_pages, sys_migrate_pages, 238, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_move_pages
> +TRACE_SYSCALL_TABLE(sys_move_pages, sys_move_pages, 239, 6)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_rt_tgsigqueueinfo
> +TRACE_SYSCALL_TABLE(sys_rt_tgsigqueueinfo, sys_rt_tgsigqueueinfo, 240, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_perf_event_open
> +TRACE_SYSCALL_TABLE(sys_perf_event_open, sys_perf_event_open, 241, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_accept4
> +TRACE_SYSCALL_TABLE(sys_accept4, sys_accept4, 242, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_recvmmsg
> +TRACE_SYSCALL_TABLE(sys_recvmmsg, sys_recvmmsg, 243, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_wait4
> +TRACE_SYSCALL_TABLE(sys_wait4, sys_wait4, 260, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_prlimit64
> +TRACE_SYSCALL_TABLE(sys_prlimit64, sys_prlimit64, 261, 4)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_name_to_handle_at
> +TRACE_SYSCALL_TABLE(sys_name_to_handle_at, sys_name_to_handle_at, 264, 5)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_open_by_handle_at
> +TRACE_SYSCALL_TABLE(sys_open_by_handle_at, sys_open_by_handle_at, 265, 3)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_clock_adjtime
> +TRACE_SYSCALL_TABLE(sys_clock_adjtime, sys_clock_adjtime, 266, 2)
> +#endif
> +#ifndef OVERRIDE_TABLE_64_sys_sendmmsg
> +TRACE_SYSCALL_TABLE(sys_sendmmsg, sys_sendmmsg, 269, 4)
> +#endif
> +
> +#endif /* CREATE_SYSCALL_TABLE */
> diff --git a/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers_override.h b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers_override.h
> new file mode 100644
> index 0000000..e5f402c
> --- /dev/null
> +++ b/instrumentation/syscalls/headers/tile-64-syscalls-2.6.40.38-MDE-4.1.2.149467_pointers_override.h
> @@ -0,0 +1,14 @@
> +#define OVERRIDE_TABLE_64_sys_execve
> +#define OVERRIDE_TABLE_64_sys_clone
> +
> +#ifndef CREATE_SYSCALL_TABLE
> +
> +#else	/* CREATE_SYSCALL_TABLE */
> +
> +#define OVERRIDE_TABLE_64_sys_execve
> +TRACE_SYSCALL_TABLE(sys_execve, sys_execve, 221, 3)
> +
> +#define OVERRIDE_TABLE_64_sys_clone
> +TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 220, 4)
> +
> +#endif /* CREATE_SYSCALL_TABLE */
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
