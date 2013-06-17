From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] lttng-modules: fix build
	and	load against linux-2.6.33.x
Date: Mon, 17 Jun 2013 10:32:47 -0400
Message-ID: <20130617143247.GA6645__29761.6338161335$1371479711$gmane$org@Krystal>
References: <1371478597-11938-1-git-send-email-smartin@aldebaran-robotics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UoaUC-0001NV-DJ
	for lttng-dev@lists.lttng.org; Mon, 17 Jun 2013 10:32:48 -0400
Content-Disposition: inline
In-Reply-To: <1371478597-11938-1-git-send-email-smartin@aldebaran-robotics.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Samuel Martin <smartin@aldebaran-robotics.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Samuel Martin (smartin@aldebaran-robotics.com) wrote:
> * lttng-event.h declared but did not implement lttng_add_perf_counter_to_ctx
>   on kernel >=2.6.33, the implementation was in lttng-context-perf-counters.c,
>   which was only included for kernel >=2.6.34.
>   This prevented the module from being loaded.
> 
> * on kernel 2.6.33.x, lttng-context-perf-counters.c complains about implicit
>   declaration for {get,put}_online_cpus and {,un}register_cpu_notifier; so
>   fix header inclusion.

merged into master, stable-2.2, stable-2.1, stable-2.0 branches, thanks!

Mathieu

> 
> Signed-off-by: Samuel Martin <smartin@aldebaran-robotics.com>
> ---
>  Makefile                      | 2 +-
>  lttng-context-perf-counters.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 2da7298..66d94bc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -33,7 +33,7 @@ endif
>  ifneq ($(CONFIG_PERF_EVENTS),)
>  lttng-tracer-objs += $(shell \
>  	if [ $(VERSION) -ge 3 \
> -		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 34 \) ] ; then \
> +		-o \( $(VERSION) -eq 2 -a $(PATCHLEVEL) -ge 6 -a $(SUBLEVEL) -ge 33 \) ] ; then \
>  		echo "lttng-context-perf-counters.o" ; fi;)
>  endif
>  
> diff --git a/lttng-context-perf-counters.c b/lttng-context-perf-counters.c
> index b97b40b..8c4a48a 100644
> --- a/lttng-context-perf-counters.c
> +++ b/lttng-context-perf-counters.c
> @@ -25,6 +25,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/list.h>
>  #include <linux/string.h>
> +#include <linux/cpu.h>
>  #include "lttng-events.h"
>  #include "wrapper/ringbuffer/frontend_types.h"
>  #include "wrapper/vmalloc.h"
> -- 
> 1.8.3.1
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
