From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: remove uninitialised value
Date: Mon, 29 Jul 2019 11:20:15 -0400 (EDT)
Message-ID: <1704199888.1739.1564413615618.JavaMail.zimbra__33691.1873238691$1564413633$gmane$org@efficios.com>
References: <20190729151426.15105-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45y3KK0LK7z18ZL
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 11:20:20 -0400 (EDT)
In-Reply-To: <20190729151426.15105-1-gabriel.pollo-guilbert@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master, 2.11, 2.10, 2.9, thanks!

Mathieu

----- On Jul 29, 2019, at 11:14 AM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> Commit 973eac638e4fd introduces an uninitialised value that may prevent
> shared memory from being allocated. The compiler didn't give any warning
> because the pointer to the value is sent to a function that don't do anything
> with it. We simply pass NULL to that function.
> ---
> liblttng-ust/lttng-ust-comm.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index 4bc350e2..a299ba84 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -875,17 +875,14 @@ int handle_message(struct sock_info *sock_info,
> 	}
> 	case LTTNG_UST_STREAM:
> 	{
> -		uint64_t memory_map_size;
> -
> 		/* Receive shm_fd, wakeup_fd */
> 		ret = ustcomm_recv_stream_from_sessiond(sock,
> -			&memory_map_size,
> +			NULL,
> 			&args.stream.shm_fd,
> 			&args.stream.wakeup_fd);
> 		if (ret) {
> 			goto error;
> 		}
> -		lum->u.stream.len = memory_map_size;
> 
> 		if (ops->cmd)
> 			ret = ops->cmd(lum->handle, lum->cmd,
> --
> 2.22.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
