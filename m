From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: run_as gid/uid test should
 return result to parent
Date: Tue, 27 Aug 2013 17:43:10 -0400
Message-ID: <521D1D6E.7010405__14586.6692685106$1377639857$gmane$org@efficios.com>
References: <20130827202455.GA12616@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VER2k-0004Rm-HD
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 17:43:24 -0400
In-Reply-To: <20130827202455.GA12616@Krystal>
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

David

Mathieu Desnoyers:
> Failure to do so could cause the parent to hang on read() waiting for
> the return value from the child.
> 
> Targets: 2.3-rc and stable-2.2 branches.
>  
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/common/runas.c b/src/common/runas.c
> index bd51cd4..6979ad3 100644
> --- a/src/common/runas.c
> +++ b/src/common/runas.c
> @@ -130,14 +130,16 @@ int child_run_as(void *_data)
>  		ret = setegid(data->gid);
>  		if (ret < 0) {
>  			PERROR("setegid");
> -			return EXIT_FAILURE;
> +			sendret.i = -1;
> +			goto write_return;
>  		}
>  	}
>  	if (data->uid != geteuid()) {
>  		ret = seteuid(data->uid);
>  		if (ret < 0) {
>  			PERROR("seteuid");
> -			return EXIT_FAILURE;
> +			sendret.i = -1;
> +			goto write_return;
>  		}
>  	}
>  	/*
> @@ -145,6 +147,8 @@ int child_run_as(void *_data)
>  	 */
>  	umask(0);
>  	sendret.i = (*data->cmd)(data->data);
> +
> +write_return:
>  	/* send back return value */
>  	writeleft = sizeof(sendret);
>  	index = 0;
> 
