From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH 3/3] Handle empty streams on
	iterator init
Date: Wed, 27 Nov 2013 17:41:25 +0000 (UTC)
Message-ID: <24722733.76810.1385574085881.JavaMail.zimbra__17096.3717661381$1385574148$gmane$org@efficios.com>
References: <1385570412-31370-1-git-send-email-jdesfossez@efficios.com>
	<1385570412-31370-3-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vlj79-0003rm-9W
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 12:41:33 -0500
In-Reply-To: <1385570412-31370-3-git-send-email-jdesfossez@efficios.com>
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

All 3 patches merged, thanks!

Mathieu

----- Original Message -----
> From: "Julien Desfossez" <jdesfossez@efficios.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez" <jdesfossez@efficios.com>
> Sent: Wednesday, November 27, 2013 11:40:12 AM
> Subject: [BABELTRACE PATCH 3/3] Handle empty streams on iterator init
> 
> In live trace streaming, we can create an iterator with inactive
> streams. This patch allows inactive streams to be considered as valid.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  lib/iterator.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iterator.c b/lib/iterator.c
> index 155fcbe..3280f4a 100644
> --- a/lib/iterator.c
> +++ b/lib/iterator.c
> @@ -725,7 +725,7 @@ int bt_iter_init(struct bt_iter *iter,
>  				if (ret == EOF) {
>  					ret = 0;
>  					continue;
> -				} else if (ret) {
> +				} else if (ret != 0 && ret != EAGAIN) {
>  					goto error;
>  				}
>  				/* Add to heap */
> @@ -821,6 +821,13 @@ reinsert:
>  	removed = bt_heap_replace_max(iter->stream_heap, file_stream);
>  	assert(removed == file_stream);
>  
> +	file_stream = bt_heap_maximum(iter->stream_heap);
> +	if (file_stream->pos.content_size == 0) {
> +		ret = EAGAIN;
> +	} else {
> +		ret = 0;
> +	}
> +
>  end:
>  	return ret;
>  }
> --
> 1.8.3.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
