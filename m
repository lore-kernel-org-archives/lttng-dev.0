From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Automatically load kvm-x86 and
 kvm-x86-mmu probes.
Date: Mon, 08 Jul 2013 15:47:54 -0400
Message-ID: <51DB176A.6010700__46398.486235603$1373312913$gmane$org@efficios.com>
References: <1373311587-11538-1-git-send-email-mohamad.gebai@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UwHPl-0008Ir-Hk
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 15:48:01 -0400
In-Reply-To: <1373311587-11538-1-git-send-email-mohamad.gebai@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mohamad Gebai <mohamad.gebai@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Mohamad Gebai:
> Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>
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
