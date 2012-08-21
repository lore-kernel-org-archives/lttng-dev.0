From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Fix: check return value of
	bt_context_create
Date: Tue, 21 Aug 2012 10:45:33 -0400
Message-ID: <20120821144533.GB16246__24404.6664135114$1345560371$gmane$org@Krystal>
References: <20120821120531.GA13784@Krystal>
	<1345556615-8109-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T3pi2-0005s3-CK
	for lttng-dev@lists.lttng.org; Tue, 21 Aug 2012 10:45:34 -0400
Content-Disposition: inline
In-Reply-To: <1345556615-8109-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>

Merged, thanks!

Mathieu

> ---
>  converter/babeltrace.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index f5541d2..c9007c3 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -549,6 +549,9 @@ int main(int argc, char **argv)
>  	}
>  
>  	ctx = bt_context_create();
> +	if (!ctx) {
> +		goto error_td_read;
> +	}
>  
>  	ret = bt_context_add_traces_recursive(ctx, opt_input_path,
>  			opt_input_format, NULL);
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
