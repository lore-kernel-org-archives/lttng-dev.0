From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring_buffer_frontend.c:
	include	lttng-tracer-core.h
Date: Thu, 20 Sep 2012 09:54:16 -0400
Message-ID: <20120920135416.GB11608__45900.2507538118$1348149294$gmane$org@Krystal>
References: <505A21A8.4080900@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TEhCs-0000xW-FW
	for lttng-dev@lists.lttng.org; Thu, 20 Sep 2012 09:54:18 -0400
Content-Disposition: inline
In-Reply-To: <505A21A8.4080900@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wade Farnsworth <wade_farnsworth@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Wade Farnsworth (wade_farnsworth@mentor.com) wrote:
> In lib/ringbuffer/ring_buffer_frontend.c, RING_BUFFER_ALIGN is undefined,
> leading to no alignment offset being recorded after the call to
> config->cb.record_header_size() in lib_ring_buffer_try_reserve_slow().
> 
> However, lttng-ring-buffer-client.h does define RING_BUFFER_ALIGN, so
> the alignment offset will be produced when the packet header is written
> in lttng_write_event_header().
> 
> This discrepancy may be observed on architectures that don't set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, such as ARM, with a babeltrace
> error such as:
> 
> babeltrace: ../../include/babeltrace/ctf/types.h:206: ctf_pos_get_event:
> Assertion `pos->offset <= pos->content_size' failed.
> Aborted
> 
> indicating that the actual content size differs from the calculated one
> due to the difference in alignment.  Including the appropriate header
> file in ring_buffer_frontend.c solves the problem.

Good catch!

Merged into master and stable-2.0 branches.

Thanks!

Mathieu

> 
> Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
> ---
>  lib/ringbuffer/ring_buffer_frontend.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/ringbuffer/ring_buffer_frontend.c b/lib/ringbuffer/ring_buffer_frontend.c
> index dc0357f..a04333a 100644
> --- a/lib/ringbuffer/ring_buffer_frontend.c
> +++ b/lib/ringbuffer/ring_buffer_frontend.c
> @@ -55,6 +55,7 @@
>  #include <linux/module.h>
>  #include <linux/percpu.h>
>  
> +#include "../../lttng-tracer-core.h"
>  #include "../../wrapper/ringbuffer/config.h"
>  #include "../../wrapper/ringbuffer/backend.h"
>  #include "../../wrapper/ringbuffer/frontend.h"
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
