From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Dead code when
	checking	return value from (ust_app|kernel)_snapshot_record
Date: Mon, 5 Aug 2013 15:12:39 -0400
Message-ID: <20130805191239.GB19424__7327.63294731757$1375730074$gmane$org@Krystal>
References: <1375132851-2751-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6QCu-00042R-Lw
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:12:46 -0400
Content-Disposition: inline
In-Reply-To: <1375132851-2751-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

* Christian Babeux (christian.babeux@efficios.com) wrote:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  src/bin/lttng-sessiond/cmd.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index 84594ad..e9fa3b4 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -2590,10 +2590,12 @@ static int record_kernel_snapshot(struct ltt_kernel_session *ksess,
>  
>  	ret = kernel_snapshot_record(ksess, output, wait, nb_streams);
>  	if (ret < 0) {
> -		ret = LTTNG_ERR_SNAPSHOT_FAIL;
>  		if (ret == -EINVAL) {
>  			ret = LTTNG_ERR_INVALID;
> +			goto error_snapshot;
>  		}
> +
> +		ret = LTTNG_ERR_SNAPSHOT_FAIL;
>  		goto error_snapshot;
>  	}
>  
> @@ -2646,10 +2648,12 @@ static int record_ust_snapshot(struct ltt_ust_session *usess,
>  
>  	ret = ust_app_snapshot_record(usess, output, wait, nb_streams);
>  	if (ret < 0) {
> -		ret = LTTNG_ERR_SNAPSHOT_FAIL;
>  		if (ret == -EINVAL) {
>  			ret = LTTNG_ERR_INVALID;
> +			goto error_snapshot;
>  		}
> +
> +		ret = LTTNG_ERR_SNAPSHOT_FAIL;
>  		goto error_snapshot;
>  	}
>  
> -- 
> 1.8.3.3
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
