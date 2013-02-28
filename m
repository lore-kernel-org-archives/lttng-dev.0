From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Undefined behavior of
	double free on	strlist in get_names_args
Date: Thu, 28 Feb 2013 17:54:29 -0500
Message-ID: <20130228225429.GA915__30337.478957563$1362092119$gmane$org@Krystal>
References: <1362084708-10329-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UBCMw-0002sx-OH
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 17:54:30 -0500
Content-Disposition: inline
In-Reply-To: <1362084708-10329-1-git-send-email-christian.babeux@efficios.com>
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
> ---
>  converter/babeltrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 20ded00..28c63cb 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -205,6 +205,7 @@ static int get_names_args(poptContext *pc)
>  		} else {
>  			fprintf(stderr, "[error] unknown field name type %s\n", str);
>  			free(strlist);
> +			strlist = NULL;

could we just remove the free(strlist), and just have:

   ret = -EINVAL;
   goto end;

instead ?

Thanks,

Mathieu

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
