From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-modules: fix build for non-x86
Date: Mon, 20 Oct 2014 19:15:27 +0000 (UTC)
Message-ID: <1906109421.12357.1413832527159.JavaMail.zimbra__12758.7912408218$1413832630$gmane$org@efficios.com>
References: <1413658823-25373-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XgIQd-0005v2-0c
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 15:15:48 -0400
In-Reply-To: <1413658823-25373-1-git-send-email-nathan_lynch@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <nathan_lynch@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks a lot !!

Mathieu

----- Original Message -----
> From: "Nathan Lynch" <nathan_lynch@mentor.com>
> To: lttng-dev@lists.lttng.org
> Sent: Saturday, October 18, 2014 3:00:23 PM
> Subject: [lttng-dev] [PATCH] lttng-modules: fix build for non-x86
> 
> Since commit 644d6e9c2807041db2b4fd9c3350d4fa243060b1 "Remove sys_
> prefix from syscall names" the build has been broken for non-x86
> architectures.
> 
> Remove the sys_ prefix from syscall names and related macros as has
> already been done for x86.
> 
> Correct "OVVERRIDE" typo in arm and powerpc headers while we're at it.
> 
> Successfully built against v3.17 for 32- and 64-bit mips and powerpc;
> runtime tested on arm, verifying that mmap2, execve, and clone syscall
> events are captured.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  .../arm-32-syscalls-3.4.25_integers_override.h       | 20
>  ++++++++++----------
>  .../arm-32-syscalls-3.4.25_pointers_override.h       | 16 ++++++++--------
>  .../mips-32-syscalls-3.13.0_pointers_override.h      |  4 ++--
>  .../mips-64-syscalls-3.5.0_pointers_override.h       |  2 +-
>  .../powerpc-32-syscalls-3.0.34_integers_override.h   |  4 ++--
>  .../powerpc-32-syscalls-3.0.34_pointers_override.h   | 16 ++++++++--------
>  6 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> index e575f6e03e7e..d5af6d028813 100644
> ---
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> +++
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> @@ -1,11 +1,11 @@
>  
>  
> -#define OVERRIDE_TABLE_32_sys_arm_fadvise64_64
> -#define OVERRIDE_TABLE_32_sys_sync_file_range2
> +#define OVERRIDE_TABLE_32_arm_fadvise64_64
> +#define OVERRIDE_TABLE_32_sync_file_range2
>  
>  #ifndef CREATE_SYSCALL_TABLE
>  
> -SC_LTTNG_TRACEPOINT_EVENT(sys_arm_fadvise64_64,
> +SC_LTTNG_TRACEPOINT_EVENT(arm_fadvise64_64,
>  	TP_PROTO(int fd, int advice, loff_t offset, loff_t len),
>  	TP_ARGS(fd, advice, offset, len),
>  	TP_STRUCT__entry(
> @@ -21,7 +21,7 @@ SC_LTTNG_TRACEPOINT_EVENT(sys_arm_fadvise64_64,
>  	TP_printk()
>  )
>  
> -SC_LTTNG_TRACEPOINT_EVENT(sys_sync_file_range2,
> +SC_LTTNG_TRACEPOINT_EVENT(sync_file_range2,
>  	TP_PROTO(int fd, loff_t offset, loff_t nbytes, unsigned int flags),
>  	TP_ARGS(fd, offset, nbytes, flags),
>  	TP_STRUCT__entry(
> @@ -39,13 +39,13 @@ SC_LTTNG_TRACEPOINT_EVENT(sys_sync_file_range2,
>  
>  #else	/* CREATE_SYSCALL_TABLE */
>  
> -#define OVVERRIDE_TABLE_32_sys_mmap
> -TRACE_SYSCALL_TABLE(sys_mmap, sys_mmap, 90, 6)
> +#define OVERRIDE_TABLE_32_mmap
> +TRACE_SYSCALL_TABLE(mmap, mmap, 90, 6)
>  
> -#define OVERRIDE_TABLE_32_sys_arm_fadvise64_64
> -TRACE_SYSCALL_TABLE(sys_arm_fadvise64_64, sys_arm_fadvise64_64, 270, 4)
> -#define OVERRIDE_TABLE_32_sys_sync_file_range2
> -TRACE_SYSCALL_TABLE(sys_sync_file_range2, sys_sync_file_range2, 341, 4)
> +#define OVERRIDE_TABLE_32_arm_fadvise64_64
> +TRACE_SYSCALL_TABLE(arm_fadvise64_64, arm_fadvise64_64, 270, 4)
> +#define OVERRIDE_TABLE_32_sync_file_range2
> +TRACE_SYSCALL_TABLE(sync_file_range2, sync_file_range2, 341, 4)
>  
>  #endif /* CREATE_SYSCALL_TABLE */
>  
> diff --git
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> index e5846df88dae..c01d355948c8 100644
> ---
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> @@ -1,10 +1,10 @@
>  
> -#define OVERRIDE_TABLE_32_sys_mmap2
> +#define OVERRIDE_TABLE_32_mmap2
>  
>  
>  #ifndef CREATE_SYSCALL_TABLE
>  
> -SC_LTTNG_TRACEPOINT_EVENT(sys_mmap2,
> +SC_LTTNG_TRACEPOINT_EVENT(mmap2,
>  	TP_PROTO(void *addr, size_t len, int prot,
>                   int flags, int fd, off_t pgoff),
>  	TP_ARGS(addr, len, prot, flags, fd, pgoff),
> @@ -27,12 +27,12 @@ SC_LTTNG_TRACEPOINT_EVENT(sys_mmap2,
>  
>  #else	/* CREATE_SYSCALL_TABLE */
>  
> -#define OVERRIDE_TABLE_32_sys_execve
> -TRACE_SYSCALL_TABLE(sys_execve, sys_execve, 11, 3)
> -#define OVERRIDE_TABLE_32_sys_clone
> -TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 120, 5)
> -#define OVERRIDE_TABLE_32_sys_mmap2
> -TRACE_SYSCALL_TABLE(sys_mmap2, sys_mmap2, 192, 6)
> +#define OVERRIDE_TABLE_32_execve
> +TRACE_SYSCALL_TABLE(execve, execve, 11, 3)
> +#define OVERRIDE_TABLE_32_clone
> +TRACE_SYSCALL_TABLE(clone, clone, 120, 5)
> +#define OVERRIDE_TABLE_32_mmap2
> +TRACE_SYSCALL_TABLE(mmap2, mmap2, 192, 6)
>  
>  #endif /* CREATE_SYSCALL_TABLE */
>  
> diff --git
> a/instrumentation/syscalls/headers/mips-32-syscalls-3.13.0_pointers_override.h
> b/instrumentation/syscalls/headers/mips-32-syscalls-3.13.0_pointers_override.h
> index 596104d9772b..bcf5662f3a90 100644
> ---
> a/instrumentation/syscalls/headers/mips-32-syscalls-3.13.0_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/mips-32-syscalls-3.13.0_pointers_override.h
> @@ -2,7 +2,7 @@
>  
>  #else	/* CREATE_SYSCALL_TABLE */
>  
> -#define OVERRIDE_TABLE_32_sys_clone
> -TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 4120, 0)
> +#define OVERRIDE_TABLE_32_clone
> +TRACE_SYSCALL_TABLE(clone, clone, 4120, 0)
>  
>  #endif /* CREATE_SYSCALL_TABLE */
> diff --git
> a/instrumentation/syscalls/headers/mips-64-syscalls-3.5.0_pointers_override.h
> b/instrumentation/syscalls/headers/mips-64-syscalls-3.5.0_pointers_override.h
> index 53f92dbf446c..f4c35c7e702d 100644
> ---
> a/instrumentation/syscalls/headers/mips-64-syscalls-3.5.0_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/mips-64-syscalls-3.5.0_pointers_override.h
> @@ -3,6 +3,6 @@
>  #else	/* CREATE_SYSCALL_TABLE */
>  
>  #define OVERRIDE_TABLE_64_sys_clone
> -TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 5055, 0)
> +TRACE_SYSCALL_TABLE(clone, clone, 5055, 0)
>  
>  #endif /* CREATE_SYSCALL_TABLE */
> diff --git
> a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_integers_override.h
> b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_integers_override.h
> index 6696f43b4364..c0aabbbc0ecd 100644
> ---
> a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_integers_override.h
> +++
> b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_integers_override.h
> @@ -2,8 +2,8 @@
>  
>  #else	/* CREATE_SYSCALL_TABLE */
>  
> -#define OVVERRIDE_TABLE_32_sys_mmap
> -TRACE_SYSCALL_TABLE(sys_mmap, sys_mmap, 90, 6)
> +#define OVERRIDE_TABLE_32_mmap
> +TRACE_SYSCALL_TABLE(mmap, mmap, 90, 6)
>  
>  #endif /* CREATE_SYSCALL_TABLE */
>  
> diff --git
> a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> index fdff68e9d93a..94b22fb3bc0b 100644
> ---
> a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> @@ -1,8 +1,8 @@
> -#define OVERRIDE_TABLE_32_sys_mmap2
> +#define OVERRIDE_TABLE_32_mmap2
>  
>  #ifndef CREATE_SYSCALL_TABLE
>  
> -SC_LTTNG_TRACEPOINT_EVENT(sys_mmap2,
> +SC_LTTNG_TRACEPOINT_EVENT(mmap2,
>  	TP_PROTO(void *addr, size_t len, int prot,
>                   int flags, int fd, off_t pgoff),
>  	TP_ARGS(addr, len, prot, flags, fd, pgoff),
> @@ -25,12 +25,12 @@ SC_LTTNG_TRACEPOINT_EVENT(sys_mmap2,
>  
>  #else	/* CREATE_SYSCALL_TABLE */
>  
> -#define OVERRIDE_TABLE_32_sys_execve
> -TRACE_SYSCALL_TABLE(sys_execve, sys_execve, 11, 3)
> -#define OVERRIDE_TABLE_32_sys_clone
> -TRACE_SYSCALL_TABLE(sys_clone, sys_clone, 120, 5)
> -#define OVERRIDE_TABLE_32_sys_mmap2
> -TRACE_SYSCALL_TABLE(sys_mmap2, sys_mmap2, 192, 6)
> +#define OVERRIDE_TABLE_32_execve
> +TRACE_SYSCALL_TABLE(execve, execve, 11, 3)
> +#define OVERRIDE_TABLE_32_clone
> +TRACE_SYSCALL_TABLE(clone, clone, 120, 5)
> +#define OVERRIDE_TABLE_32_mmap2
> +TRACE_SYSCALL_TABLE(mmap2, mmap2, 192, 6)
>  
>  #endif /* CREATE_SYSCALL_TABLE */
>  
> --
> 1.9.3
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
