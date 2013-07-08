From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Automatically load kvm-x86
	and	kvm-x86-mmu probes.
Date: Mon, 8 Jul 2013 15:34:53 -0400
Message-ID: <20130708193453.GB32487__28056.7882735797$1373312127$gmane$org@Krystal>
References: <1373311587-11538-1-git-send-email-mohamad.gebai@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwHD6-00089q-Ko
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 15:34:56 -0400
Content-Disposition: inline
In-Reply-To: <1373311587-11538-1-git-send-email-mohamad.gebai@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mohamad Gebai <mohamad.gebai@gmail.com>, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

* Mohamad Gebai (mohamad.gebai@gmail.com) wrote:
> Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  src/bin/lttng-sessiond/modprobe.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
> index 7e06dad..a010e7c 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -55,6 +55,8 @@ const struct kern_modules_param kern_modules_list[] = {
>  	{ "lttng-probe-jbd2", 0 },
>  	{ "lttng-probe-kmem", 0 },
>  	{ "lttng-probe-kvm", 0 },
> +	{ "lttng-probe-kvm-x86", 0 },
> +	{ "lttng-probe-kvm-x86-mmu", 0 },
>  	{ "lttng-probe-lock", 0 },
>  	{ "lttng-probe-module", 0 },
>  	{ "lttng-probe-napi", 0 },
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
EfficiOS Inc.
http://www.efficios.com
