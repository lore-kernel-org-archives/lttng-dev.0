From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS 2.3 PATCH 1/2] Fix: return code of
	get_subbuff on	metadata stream
Date: Mon, 5 Aug 2013 15:06:55 -0400
Message-ID: <20130805190655.GA18891__28684.8407741219$1375729674$gmane$org@Krystal>
References: <1375716439-24407-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6Q7P-0003mS-2m
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:07:04 -0400
Content-Disposition: inline
In-Reply-To: <1375716439-24407-1-git-send-email-jdesfossez@efficios.com>
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
> On error, the ioctl kernctl_get_next_subbuf returns -1 and sets errno to
> a meaningful value but we were ignoring it. It was causing
> lttng_kconsumer_read_subbuffer to return -1 (error) instead of -EAGAIN
> (normal).

Merging an updated patch instead:

commit 56591bac20c0f3b728c95d92702d243de838bdc4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Aug 5 13:46:58 2013 -0400

    Fix: kernel ctl error codes are based on errno
    
    ioctl returns -1, and error codes are based on -errno.
    
    Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/common/kernel-consumer/kernel-consumer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index 3086abe..f8978d2 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -851,7 +851,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
>  	/* Get the next subbuffer */
>  	err = kernctl_get_next_subbuf(infd);
>  	if (err != 0) {
> -		ret = err;
> +		ret = -errno;
>  		/*
>  		 * This is a debug message even for single-threaded consumer,
>  		 * because poll() have more relaxed criterions than get subbuf,
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
