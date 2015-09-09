From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Move pipe override to the
 arch	specific pointers_override.h
Date: Wed, 9 Sep 2015 16:18:56 +0000 (UTC)
Message-ID: <1072770657.1937.1441815536508.JavaMail.zimbra__115.003882865672$1441815636$gmane$org@efficios.com>
References: <1441718415-23808-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZZi5Z-0006pB-Ci
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 12:19:16 -0400
In-Reply-To: <1441718415-23808-1-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

merged into master and stable-2.7, thanks!

Mathieu

----- On Sep 8, 2015, at 9:20 AM, Lars Persson lars.persson@axis.com wrote:

> The MIPS architecture has a non-standard calling convention for pipe()
> and cannot use the provided override for the pipe event.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
> .../headers/arm-32-syscalls-3.4.25_pointers_override.h         |  9 +++++++++
> .../headers/powerpc-32-syscalls-3.0.34_pointers_override.h     |  9 +++++++++
> instrumentation/syscalls/headers/syscalls_pointers_override.h  | 10 ----------
> .../headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h      | 10 ++++++++++
> .../headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h     |  9 +++++++++
> 5 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> index d515e1d..b27eedb 100644
> ---
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_pointers_override.h
> @@ -18,6 +18,15 @@ SC_LTTNG_TRACEPOINT_EVENT(mmap2,
> 	)
> )
> 
> +#define OVERRIDE_32_pipe
> +SC_LTTNG_TRACEPOINT_EVENT(pipe,
> +	TP_PROTO(sc_exit(long ret,) int * fildes),
> +	TP_ARGS(sc_exit(ret,) fildes),
> +	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
> +		sc_out(ctf_user_array(int, fildes, fildes, 2))
> +	)
> +)
> +
> #else	/* CREATE_SYSCALL_TABLE */
> 
> #define OVERRIDE_TABLE_32_execve
> diff --git
> a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> index b9e83bc..1fd3ec4 100644
> ---
> a/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/powerpc-32-syscalls-3.0.34_pointers_override.h
> @@ -16,6 +16,15 @@ SC_LTTNG_TRACEPOINT_EVENT(mmap2,
> 	)
> )
> 
> +#define OVERRIDE_32_pipe
> +SC_LTTNG_TRACEPOINT_EVENT(pipe,
> +	TP_PROTO(sc_exit(long ret,) int * fildes),
> +	TP_ARGS(sc_exit(ret,) fildes),
> +	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
> +		sc_out(ctf_user_array(int, fildes, fildes, 2))
> +	)
> +)
> +
> #else	/* CREATE_SYSCALL_TABLE */
> 
> #define OVERRIDE_TABLE_32_execve
> diff --git a/instrumentation/syscalls/headers/syscalls_pointers_override.h
> b/instrumentation/syscalls/headers/syscalls_pointers_override.h
> index a552908..c9478f4 100644
> --- a/instrumentation/syscalls/headers/syscalls_pointers_override.h
> +++ b/instrumentation/syscalls/headers/syscalls_pointers_override.h
> @@ -41,16 +41,6 @@ SC_LTTNG_TRACEPOINT_EVENT(getcpu,
> 	)
> )
> 
> -#define OVERRIDE_32_pipe
> -#define OVERRIDE_64_pipe
> -SC_LTTNG_TRACEPOINT_EVENT(pipe,
> -	TP_PROTO(sc_exit(long ret,) int * fildes),
> -	TP_ARGS(sc_exit(ret,) fildes),
> -	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
> -		sc_out(ctf_user_array(int, fildes, fildes, 2))
> -	)
> -)
> -
> #define OVERRIDE_32_pipe2
> #define OVERRIDE_64_pipe2
> SC_LTTNG_TRACEPOINT_EVENT(pipe2,
> diff --git
> a/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
> b/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
> index 05c8e21..7c804a6 100644
> ---
> a/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/x86-32-syscalls-3.1.0-rc6_pointers_override.h
> @@ -10,6 +10,16 @@
> #  define OVERRIDE_32_chown16
> # endif
> 
> +#define OVERRIDE_32_pipe
> +#define OVERRIDE_64_pipe
> +SC_LTTNG_TRACEPOINT_EVENT(pipe,
> +    TP_PROTO(sc_exit(long ret,) int * fildes),
> +    TP_ARGS(sc_exit(ret,) fildes),
> +    TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
> +        sc_out(ctf_user_array(int, fildes, fildes, 2))
> +    )
> +)
> +
> #else	/* CREATE_SYSCALL_TABLE */
> 
> # ifndef CONFIG_UID16
> diff --git
> a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> index af519cd..702cfb5 100644
> ---
> a/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> +++
> b/instrumentation/syscalls/headers/x86-64-syscalls-3.10.0-rc7_pointers_override.h
> @@ -106,6 +106,15 @@ SC_LTTNG_TRACEPOINT_EVENT_CODE(accept,
> 	)
> )
> 
> +#define OVERRIDE_64_pipe
> +SC_LTTNG_TRACEPOINT_EVENT(pipe,
> +	TP_PROTO(sc_exit(long ret,) int * fildes),
> +	TP_ARGS(sc_exit(ret,) fildes),
> +	TP_FIELDS(sc_exit(ctf_integer(long, ret, ret))
> +		sc_out(ctf_user_array(int, fildes, fildes, 2))
> +	)
> +)
> +
> #else	/* CREATE_SYSCALL_TABLE */
> 
> #define OVERRIDE_TABLE_64_clone
> --
> 2.1.4
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
