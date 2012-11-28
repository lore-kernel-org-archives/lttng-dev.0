From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix a typo
	in	lttng-probe-module name
Date: Wed, 28 Nov 2012 10:51:21 -0500
Message-ID: <20121128155121.GB9266__17512.0172360495$1354117938$gmane$org@Krystal>
References: <1354113806-19089-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tdjv0-00037H-84
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 10:51:22 -0500
Content-Disposition: inline
In-Reply-To: <1354113806-19089-1-git-send-email-andrew_gabbasov@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  src/bin/lttng-sessiond/modprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
> index f38d393..8e5cc94 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -54,7 +54,7 @@ const struct kern_modules_param kern_modules_list[] = {
>  	{ "lttng-probe-kmem", 0 },
>  	{ "lttng-probe-kvm", 0 },
>  	{ "lttng-probe-lock", 0 },
> -	{ "lttng-probe-modules", 0 },
> +	{ "lttng-probe-module", 0 },
>  	{ "lttng-probe-napi", 0 },
>  	{ "lttng-probe-net", 0 },
>  	{ "lttng-probe-power", 0 },
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
