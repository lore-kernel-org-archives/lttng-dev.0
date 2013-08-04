From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS 2.3 PATCH 1/2] Fix: return code of
	get_subbuff on	metadata stream
Date: Sun, 4 Aug 2013 16:34:12 -0400
Message-ID: <20130804203411.GA28914__32716.6013922126$1375648508$gmane$org@Krystal>
References: <1375641986-2278-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V650H-0006WC-9b
	for lttng-dev@lists.lttng.org; Sun, 04 Aug 2013 16:34:17 -0400
Content-Disposition: inline
In-Reply-To: <1375641986-2278-1-git-send-email-jdesfossez@efficios.com>
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
> If no metadata is available on the kernel metadata stream when we
> do a get_subbuff, the kernel returns -EPERM, the consumer was not
> checking for this return code and closed the stream prematurely. It
> worked if no new metadata was added during the session.

Is the proper fix to change lttng-tools or lttng-modules ?

I would rather think that lttng-modules should return -ENODATA rather
than -EPERM in this case. It's clearly not a permission issue.

Thoughts ?

Thanks,

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/common/consumer.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 4b657f3..a070f36 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -2288,7 +2288,8 @@ restart:
>  				} while (len > 0);
>  
>  				/* It's ok to have an unavailable sub-buffer */
> -				if (len < 0 && len != -EAGAIN && len != -ENODATA) {
> +				if (len < 0 && len != -EAGAIN && len != -ENODATA &&
> +						len != -EPERM) {
>  					/* Clean up stream from consumer and free it. */
>  					lttng_poll_del(&events, stream->wait_fd);
>  					consumer_del_metadata_stream(stream, metadata_ht);
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
