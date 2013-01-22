From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/4] tile: Add definition of NR_syscalls
Date: Mon, 21 Jan 2013 20:06:53 -0500
Message-ID: <20130122010653.GA27148__31446.2986811579$1358816861$gmane$org@Krystal>
References: <1358816098-13070-1-git-send-email-simon.marchi@polymtl.ca>
	<1358816098-13070-2-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxSKH-0007wk-CI
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 20:06:57 -0500
Content-Disposition: inline
In-Reply-To: <1358816098-13070-2-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org, cmetcalf@tilera.com
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> It is required by the syscall tracepoint mechanism.
> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  arch/tile/include/uapi/asm/unistd.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/tile/include/uapi/asm/unistd.h b/arch/tile/include/uapi/asm/unistd.h
> index cd7b6dd..c763c86 100644
> --- a/arch/tile/include/uapi/asm/unistd.h
> +++ b/arch/tile/include/uapi/asm/unistd.h
> @@ -20,6 +20,8 @@
>  /* Use the standard ABI for syscalls. */
>  #include <asm-generic/unistd.h>
>  
> +#define NR_syscalls (__NR_syscalls)

The parenthesis around __NR_syscalls seems unnecessary. (unless
parenthesis would happen to be missing around a __NR_syscalls definition
with multiple identifiers, but clearly, the parenthesis don't belong
here).

Thanks,

Mathieu

> +
>  /* Additional Tilera-specific syscalls. */
>  #define __NR_cacheflush	(__NR_arch_specific_syscall + 1)
>  __SYSCALL(__NR_cacheflush, sys_cacheflush)
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
