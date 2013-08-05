From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Bump relayd protocol version
Date: Mon, 5 Aug 2013 15:08:50 -0400
Message-ID: <20130805190850.GA19424__18325.5901713439$1375729875$gmane$org@Krystal>
References: <1375728777-684-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6Q9D-0003rN-Gh
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:08:56 -0400
Content-Disposition: inline
In-Reply-To: <1375728777-684-1-git-send-email-jdesfossez@efficios.com>
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
> This should have been done for 2.3-rc1.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/common/sessiond-comm/relayd.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
> index aa99248..efbfdab 100644
> --- a/src/common/sessiond-comm/relayd.h
> +++ b/src/common/sessiond-comm/relayd.h
> @@ -28,7 +28,7 @@
>  #include <common/defaults.h>
>  
>  #define RELAYD_VERSION_COMM_MAJOR             2
> -#define RELAYD_VERSION_COMM_MINOR             2
> +#define RELAYD_VERSION_COMM_MINOR             3

since we want this version number to follow the package version number,
please use the package version instead.

Thanks,

Mathieu

>  
>  /*
>   * lttng-relayd communication header.
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
