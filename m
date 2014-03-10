From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: mismatch between code and
	comments
Date: Mon, 10 Mar 2014 19:17:55 +0000 (UTC)
Message-ID: <157376102.34960.1394479075953.JavaMail.zimbra__26813.6653387502$1394479162$gmane$org@efficios.com>
References: <1393937414-32622-1-git-send-email-zifeitong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WN5iE-0003LC-NF
	for lttng-dev@lists.lttng.org; Mon, 10 Mar 2014 15:18:19 -0400
In-Reply-To: <1393937414-32622-1-git-send-email-zifeitong@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <zifeitong@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Zifei Tong" <zifeitong@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Zifei Tong" <zifeitong@gmail.com>
> Sent: Tuesday, March 4, 2014 7:50:14 AM
> Subject: [PATCH lttng-ust] Fix: mismatch between code and comments
> 
> Signed-off-by: Zifei Tong <zifeitong@gmail.com>
> ---
>  liblttng-ust-ctl/ustctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
> index 854d8ae..e07ec92 100644
> --- a/liblttng-ust-ctl/ustctl.c
> +++ b/liblttng-ust-ctl/ustctl.c
> @@ -294,7 +294,7 @@ int ustctl_set_exclusion(int sock, struct
> lttng_ust_event_exclusion *exclusion,
>  		return ret;
>  	}
>  
> -	/* send var len bytecode */
> +	/* send var len exclusion names */
>  	ret = ustcomm_send_unix_sock(sock,
>  			exclusion->names,
>  			exclusion->count * LTTNG_UST_SYM_NAME_LEN);
> --
> 1.9.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
