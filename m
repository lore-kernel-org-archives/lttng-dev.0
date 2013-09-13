From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Declare enum type to use from C++
Date: Fri, 13 Sep 2013 16:57:39 -0400
Message-ID: <20130913205739.GA9387__27625.0614239418$1379105920$gmane$org@Krystal>
References: <1379103560-4269-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VKaQw-0001c9-Bj
	for lttng-dev@lists.lttng.org; Fri, 13 Sep 2013 16:57:48 -0400
Content-Disposition: inline
In-Reply-To: <1379103560-4269-1-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Anonymous enum can't be referenced from C++. to fix this issue, declare enum
> bt_iter_pos_type and use this type in struct bt_iter_pos.
> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  include/babeltrace/iterator.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/babeltrace/iterator.h b/include/babeltrace/iterator.h
> index 360a9c7..50232a9 100644
> --- a/include/babeltrace/iterator.h
> +++ b/include/babeltrace/iterator.h
> @@ -65,14 +65,16 @@ struct bt_saved_pos;
>   * only use BT_SEEK_LAST to get the timestamp of the last event(s) in
>   * the trace.
>   */
> +enum bt_iter_pos_type {
> +	BT_SEEK_TIME,		/* uses u.seek_time */
> +	BT_SEEK_RESTORE,	/* uses u.restore */
> +	BT_SEEK_CUR,
> +	BT_SEEK_BEGIN,
> +	BT_SEEK_LAST,
> +};
> +
>  struct bt_iter_pos {
> -	enum {
> -		BT_SEEK_TIME,		/* uses u.seek_time */
> -		BT_SEEK_RESTORE,	/* uses u.restore */
> -		BT_SEEK_CUR,
> -		BT_SEEK_BEGIN,
> -		BT_SEEK_LAST,
> -	} type;
> +	enum bt_iter_pos_type type;
>  	union {
>  		uint64_t seek_time;
>  		struct bt_saved_pos *restore;
> -- 
> 1.8.1.2
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
