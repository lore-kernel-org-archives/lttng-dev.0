From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Missing NULL pointer init in
	tap.c
Date: Fri, 12 Jul 2013 14:13:54 -0400
Message-ID: <51E04762.9070102__21993.5620938942$1373652875$gmane$org@efficios.com>
References: <20130712154108.GA16307@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Uxhr0-0003mw-Aq
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 14:14:02 -0400
In-Reply-To: <20130712154108.GA16307@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Mathieu Desnoyers:
> Could lead to free() of unitialized pointer.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/tests/utils/tap/tap.c b/tests/utils/tap/tap.c
> index a430951..86c89a2 100644
> --- a/tests/utils/tap/tap.c
> +++ b/tests/utils/tap/tap.c
> @@ -294,7 +294,7 @@ int
>  skip(unsigned int n, char *fmt, ...)
>  {
>  	va_list ap;
> -	char *skip_msg;
> +	char *skip_msg = NULL;
>  
>  	LOCK;
>  
