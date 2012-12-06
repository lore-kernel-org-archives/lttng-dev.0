From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix erroneous
	warning/error	messages
Date: Thu, 6 Dec 2012 11:22:00 -0500
Message-ID: <20121206162200.GA17469__39796.4937300005$1354810971$gmane$org@Krystal>
References: <1354810444-21670-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TgeD4-0000BV-3K
	for lttng-dev@lists.lttng.org; Thu, 06 Dec 2012 11:22:02 -0500
Content-Disposition: inline
In-Reply-To: <1354810444-21670-1-git-send-email-simon.marchi@polymtl.ca>
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

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> This led to user confusion.

merged, thanks!

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  lib/context.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/context.c b/lib/context.c
> index 9c11598..5516e49 100644
> --- a/lib/context.c
> +++ b/lib/context.c
> @@ -90,16 +90,16 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
>  	if (path) {
>  		td = fmt->open_trace(path, O_RDONLY, packet_seek, NULL);
>  		if (!td) {
> -			fprintf(stderr, "[warning] [Context] Cannot open_trace of the format %s .\n\n",
> -					path);
> +			fprintf(stderr, "[warning] [Context] Cannot open_trace of format %s at path %s.\n\n",
> +					format_name, path);
>  			ret = -1;
>  			goto end;
>  		}
>  	} else {
>  		td = fmt->open_mmap_trace(stream_list, packet_seek, metadata);
>  		if (!td) {
> -			fprintf(stderr, "[error] [Context] Cannot open_trace of the format %s .\n\n",
> -					path);
> +			fprintf(stderr, "[error] [Context] Cannot open_mmap_trace of format %s.\n\n",
> +					format_name);
>  			ret = -1;
>  			goto end;
>  		}
> -- 
> 1.7.10.4
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
