From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix linking warning.
Date: Mon, 30 Sep 2013 20:49:09 +0000 (UTC)
Message-ID: <529361201.26240.1380574149537.JavaMail.zimbra__44267.2029407278$1380574219$gmane$org@efficios.com>
References: <1380311048-2013-1-git-send-email-mohamad.gebai@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VQkP7-00007o-97
	for lttng-dev@lists.lttng.org; Mon, 30 Sep 2013 16:49:22 -0400
In-Reply-To: <1380311048-2013-1-git-send-email-mohamad.gebai@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mohamad Gebai <mohamad.gebai@gmail.com>
Cc: lttng-dev@lists.lttng.org, Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

merged into master, stable-2.2 and stable-2.3. Thanks!

Mathieu

----- Original Message -----
> From: "Mohamad Gebai" <mohamad.gebai@gmail.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Mohamad Gebai" <mohamad.gebai@polymtl.ca>
> Sent: Friday, September 27, 2013 3:44:08 PM
> Subject: [lttng-dev] [PATCH lttng-ust] Fix linking warning.
> 
> lttng_static_ctx should be extern in this header to avoid getting a
> warning when --warn-common is used.
> 
> PS: Thanks to Yannick Brosseau for his help.
> 
> Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>
> ---
>  include/lttng/ust-events.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
> index 74a3bc6..c563511 100644
> --- a/include/lttng/ust-events.h
> +++ b/include/lttng/ust-events.h
> @@ -543,7 +543,7 @@ int lttng_attach_context(struct lttng_ust_context
> *context_param,
>  		struct lttng_ctx **ctx, struct lttng_session *session);
>  void lttng_context_init(void);
>  void lttng_context_exit(void);
> -struct lttng_ctx *lttng_static_ctx;	/* Used by filtering */
> +extern struct lttng_ctx *lttng_static_ctx;	/* Used by filtering */
>  
>  void lttng_transport_register(struct lttng_transport *transport);
>  void lttng_transport_unregister(struct lttng_transport *transport);
> --
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
