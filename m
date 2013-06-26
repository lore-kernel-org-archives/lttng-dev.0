From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng-modules PATCH] Add header to fix compilation
	of	syscalls-extractor on 3.9 kernel
Date: Wed, 26 Jun 2013 15:19:56 -0400
Message-ID: <20130626191956.GA3904__4068.1165447042$1372274982$gmane$org@Krystal>
References: <1372273769-10331-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UrvOn-0000zH-8g
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 15:29:01 -0400
Content-Disposition: inline
In-Reply-To: <1372273769-10331-1-git-send-email-yannick.brosseau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged into master,

Thanks,

Mathieu

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  .../syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c      |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c b/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
> index a1d3085..7119746 100644
> --- a/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
> +++ b/instrumentation/syscalls/lttng-syscalls-extractor/lttng-syscalls-extractor.c
> @@ -31,6 +31,7 @@
>  #include <linux/dcache.h>
>  #include <linux/ftrace_event.h>
>  #include <trace/syscall.h>
> +#include <asm/syscall.h>
>  
>  #ifndef CONFIG_FTRACE_SYSCALLS
>  #error "You need to set CONFIG_FTRACE_SYSCALLS=y"
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
