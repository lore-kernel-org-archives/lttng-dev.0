From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Enable additional kernel probes
Date: Wed, 14 Nov 2012 11:26:38 -0500
Message-ID: <50A3C63E.5020307__8725.38645421646$1352910437$gmane$org@efficios.com>
References: <50A394DF.70607@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TYfnZ-00028p-G3
	for lttng-dev@lists.lttng.org; Wed, 14 Nov 2012 11:26:45 -0500
In-Reply-To: <50A394DF.70607@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks
David

Woegerer, Paul:
> To enable the extra kernel probes (see related thread: http://lists.lttng.org/pipermail/lttng-dev/2012-November/019046.html) the following patch is required for lttng-tools:
> 
> From fbf7bdae4af6d082ce71bc0976628e5d24a515fc Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Wed, 14 Nov 2012 13:49:45 +0100
> Subject: [PATCH] Add additional kernel probes to module list.
> 
> ---
>  src/bin/lttng-sessiond/modprobe.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
> index b3f2e57..f38d393 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -44,13 +44,30 @@ const struct kern_modules_param kern_modules_list[] = {
>  	{ "lttng-ring-buffer-metadata-mmap-client", 1 },
>  	{ "lttng-probe-lttng", 1 },
>  	{ "lttng-types", 0 },
> +	{ "lttng-probe-asoc", 0 },
>  	{ "lttng-probe-block", 0 },
> +	{ "lttng-probe-ext3", 0 },
> +	{ "lttng-probe-gpio", 0 },
>  	{ "lttng-probe-irq", 0 },
> +	{ "lttng-probe-jbd", 0 },
> +	{ "lttng-probe-jbd2", 0 },
> +	{ "lttng-probe-kmem", 0 },
>  	{ "lttng-probe-kvm", 0 },
> +	{ "lttng-probe-lock", 0 },
> +	{ "lttng-probe-modules", 0 },
> +	{ "lttng-probe-napi", 0 },
> +	{ "lttng-probe-net", 0 },
> +	{ "lttng-probe-power", 0 },
> +	{ "lttng-probe-regulator", 0 },
>  	{ "lttng-probe-sched", 0 },
> +	{ "lttng-probe-scsi", 0 },
>  	{ "lttng-probe-signal", 0 },
> +	{ "lttng-probe-skb", 0 },
> +	{ "lttng-probe-sock", 0 },
>  	{ "lttng-probe-statedump", 0 },
>  	{ "lttng-probe-timer", 0 },
> +	{ "lttng-probe-udp", 0 },
> +	{ "lttng-probe-vmscan", 0 },
>  };
>  
>  /*
