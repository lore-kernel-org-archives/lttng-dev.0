From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: snapshot should fail if	no
	successful snapshot is taken
Date: Sat, 24 Aug 2013 14:55:10 -0400
Message-ID: <20130824185510.GC13216__23550.962462514$1377370589$gmane$org@Krystal>
References: <20130822204658.GA4260@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDIzP-0007YU-Hh
	for lttng-dev@lists.lttng.org; Sat, 24 Aug 2013 14:55:17 -0400
Content-Disposition: inline
In-Reply-To: <20130822204658.GA4260@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I notice this patch is merged too.

Thanks,

Mathieu

> ---
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index 64fa5c0..17dcfc4 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -2836,6 +2836,8 @@ int cmd_snapshot_record(struct ltt_session *session,
>  
>  	if (snapshot_success) {
>  		session->snapshot.nb_snapshot++;
> +	} else {
> +		ret = LTTNG_ERR_SNAPSHOT_FAIL;
>  	}
>  
>  error:
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
