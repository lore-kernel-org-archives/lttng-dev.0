From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Undefined behavior of
	double free on	strlist in get_names_args
Date: Thu, 28 Feb 2013 21:27:53 -0500
Message-ID: <20130301022753.GA3321__3158.29501855678$1362104928$gmane$org@Krystal>
References: <20130228225429.GA915@Krystal>
	<1362093206-12791-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UBFhU-0004ZP-NR
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 21:27:56 -0500
Content-Disposition: inline
In-Reply-To: <1362093206-12791-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>

Merged, thanks!

Mathieu

> ---
>  converter/babeltrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 20ded00..ed19fa8 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -204,7 +204,6 @@ static int get_names_args(poptContext *pc)
>  			opt_payload_field_names = 0;
>  		} else {
>  			fprintf(stderr, "[error] unknown field name type %s\n", str);
> -			free(strlist);
>  			ret = -EINVAL;
>  			goto end;
>  		}
> -- 
> 1.8.1.3
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
