From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] Fix: return error on ask_new_stream
 when should quit
Date: Wed, 19 Aug 2015 06:46:20 +0000 (UTC)
Message-ID: <681325935.24741.1439966780200.JavaMail.zimbra__33498.5515372411$1439966850$gmane$org@efficios.com>
References: <1439940978-3953-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZRx8q-0003hy-Gd
 for lttng-dev@lists.lttng.org; Wed, 19 Aug 2015 02:46:33 -0400
In-Reply-To: <1439940978-3953-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jgalar@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

this patch might not be needed... the second patch
of this series might be sufficient.

----- On Aug 18, 2015, at 4:36 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Otherwise, the caller will try to continue adding partially set streams
> to the trace.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> formats/lttng-live/lttng-live-comm.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/formats/lttng-live/lttng-live-comm.c
> b/formats/lttng-live/lttng-live-comm.c
> index 47ea589..8fa90cf 100644
> --- a/formats/lttng-live/lttng-live-comm.c
> +++ b/formats/lttng-live/lttng-live-comm.c
> @@ -560,10 +560,11 @@ restart:
> 		id = g_array_index(ctx->session_ids, uint64_t, i);
> 		ret = lttng_live_get_new_streams(ctx, id);
> 		printf_verbose("Asking for new streams returns %d\n", ret);
> +		if (lttng_live_should_quit()) {
> +			ret = -1;
> +			goto end;
> +		}
> 		if (ret < 0) {
> -			if (lttng_live_should_quit()) {
> -				goto end;
> -			}
> 			if (ret == -LTTNG_VIEWER_NEW_STREAMS_HUP) {
> 				printf_verbose("Session %" PRIu64 " closed\n",
> 						id);
> @@ -1699,6 +1700,7 @@ int lttng_live_read(struct lttng_live_ctx *ctx)
> 			}
> 			ret = ask_new_streams(ctx);
> 			if (ret < 0) {
> +				ret = 0;
> 				goto end_free;
> 			}
> 			if (!ctx->session->stream_count) {
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
