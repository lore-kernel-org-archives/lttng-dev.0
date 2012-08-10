From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [babeltrace PATCH] Remove trace-collection.h
	from	include_headers
Date: Fri, 10 Aug 2012 17:34:24 -0400
Message-ID: <20120810213424.GA601__25782.6836118058$1344634502$gmane$org@Krystal>
References: <1344537779-19779-1-git-send-email-danny.serres@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Szwqg-0000Cv-0c
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 17:34:26 -0400
Content-Disposition: inline
In-Reply-To: <1344537779-19779-1-git-send-email-danny.serres@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <danny.serres@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

* Danny Serres (danny.serres@efficios.com) wrote:
> Signed-off-by: Danny Serres <danny.serres@efficios.com>
> ---
>  include/Makefile.am |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/Makefile.am b/include/Makefile.am
> index f7488da..79247a0 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -3,7 +3,6 @@ babeltraceinclude_HEADERS = \
>  	babeltrace/format.h \
>  	babeltrace/context.h \
>  	babeltrace/iterator.h \
> -	babeltrace/trace-collection.h \
>  	babeltrace/trace-handle.h \
>  	babeltrace/list.h \
>  	babeltrace/clock-types.h
> @@ -21,6 +20,7 @@ noinst_HEADERS = \
>  	babeltrace/context-internal.h \
>  	babeltrace/iterator-internal.h \
>  	babeltrace/prio_heap.h \
> +	babeltrace/trace-collection.h \
>  	babeltrace/types.h \
>  	babeltrace/ctf-ir/metadata.h \
>  	babeltrace/ctf/events-internal.h \
> -- 
> 1.7.9.5
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
