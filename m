From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v3 1/3] Do not override the
 pipe	syscall on MIPS.
Date: Tue, 11 Aug 2015 16:33:59 +0000 (UTC)
Message-ID: <353319887.18464.1439310839404.JavaMail.zimbra__36829.6002656736$1439310942$gmane$org@efficios.com>
References: <1438164299-11526-1-git-send-email-larper@axis.com>
 <1438164299-11526-2-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZPCVE-00088B-48
 for lttng-dev@lists.lttng.org; Tue, 11 Aug 2015 12:34:27 -0400
In-Reply-To: <1438164299-11526-2-git-send-email-larper@axis.com>
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

----- On Jul 29, 2015, at 6:04 AM, Lars Persson lars.persson@axis.com wrote:

> MIPS has a non-standard calling convention for pipe.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
> instrumentation/syscalls/headers/syscalls_pointers_override.h | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/instrumentation/syscalls/headers/syscalls_pointers_override.h
> b/instrumentation/syscalls/headers/syscalls_pointers_override.h
> index a552908..85cb2e8 100644
> --- a/instrumentation/syscalls/headers/syscalls_pointers_override.h
> +++ b/instrumentation/syscalls/headers/syscalls_pointers_override.h
> @@ -41,6 +41,7 @@ SC_LTTNG_TRACEPOINT_EVENT(getcpu,
> 	)
> )
> 
> +#ifndef CONFIG_CPU_MIPS32
> #define OVERRIDE_32_pipe
> #define OVERRIDE_64_pipe
> SC_LTTNG_TRACEPOINT_EVENT(pipe,
> @@ -50,6 +51,7 @@ SC_LTTNG_TRACEPOINT_EVENT(pipe,
> 		sc_out(ctf_user_array(int, fildes, fildes, 2))
> 	)
> )
> +#endif

Instead of multiplying the number of ifdefs for each architecture
in the generic file, we instead move the pipe definition to arch-specific
files ?

Thanks,

Mathieu

> 
> #define OVERRIDE_32_pipe2
> #define OVERRIDE_64_pipe2
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
