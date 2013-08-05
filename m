From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: relayd protocol version
Date: Mon, 5 Aug 2013 15:49:23 -0400
Message-ID: <20130805194923.GB22120__2996.03516837141$1375732316$gmane$org@Krystal>
References: <1375729818-6183-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6QmS-0005LQ-Pz
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:49:30 -0400
Content-Disposition: inline
In-Reply-To: <1375729818-6183-1-git-send-email-jdesfossez@efficios.com>
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
> Since we heritate the relayd protocol version from the sessiond and
> relayd version, use the VERSION macro instead of additionnal fields.

I merged these instead:

commit d83a952ce0d3a03bd3d36505d665db99b2c65fa2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 5 15:26:41 2013 -0400

    relayd: use version macros from build rather than scanf
    
    Acked-by: Julien Desfossez <jdesfossez@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 6947778efd60badf06cec2bd5c39d7f96f5ba7ad
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 5 15:24:31 2013 -0400

    sessiond: use version major/minor from build for communication with relayd
    
    Acked-by: Julien Desfossez <jdesfossez@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 81265501f5370482b1ee9c24d3fa6537c5ca0389
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 5 15:23:27 2013 -0400

    build: export major/minor/patchlevel numbers
    
    Acked-by: Julien Desfossez <jdesfossez@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/bin/lttng-sessiond/cmd.c      |   11 +++++++++--
>  src/common/sessiond-comm/relayd.h |    3 ---
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index 84594ad..07366af 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -491,9 +491,16 @@ static int create_connect_relayd(struct lttng_uri *uri,
>  {
>  	int ret;
>  	struct lttcomm_relayd_sock *rsock;
> +	uint32_t major, minor;
>  
> -	rsock = lttcomm_alloc_relayd_sock(uri, RELAYD_VERSION_COMM_MAJOR,
> -			RELAYD_VERSION_COMM_MINOR);
> +	ret = sscanf(VERSION, "%10u.%10u", &major, &minor);
> +	if (ret < 2) {
> +		ERR("Error in scanning version");
> +		ret = -1;
> +		goto error;
> +	}
> +
> +	rsock = lttcomm_alloc_relayd_sock(uri, major, minor);
>  	if (!rsock) {
>  		ret = LTTNG_ERR_FATAL;
>  		goto error;
> diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
> index aa99248..836327c 100644
> --- a/src/common/sessiond-comm/relayd.h
> +++ b/src/common/sessiond-comm/relayd.h
> @@ -27,9 +27,6 @@
>  #include <lttng/lttng.h>
>  #include <common/defaults.h>
>  
> -#define RELAYD_VERSION_COMM_MAJOR             2
> -#define RELAYD_VERSION_COMM_MINOR             2
> -
>  /*
>   * lttng-relayd communication header.
>   */
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
