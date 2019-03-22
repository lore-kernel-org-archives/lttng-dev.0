From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools v3 1/8] Fix: lttng_poll_mod
 calls compat_(e)poll_add
Date: Fri, 22 Mar 2019 14:50:41 -0400
Message-ID: <20190322185041.GB10995__33844.2595720821$1553280673$gmane$org@joraj-alpa>
References: <20190322181928.6186-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Qt5b49Q4z18dr
 for <lttng-dev@lists.lttng.org>; Fri, 22 Mar 2019 14:50:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190322181928.6186-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

I do not see any information regarding what changed between each versions.

Next time, please add a "high level" delta of the change between vN and vN+1.
This also act as a check list to see if previous comments were addressed. It
should ease the review process.

On Fri, Mar 22, 2019 at 02:19:21PM -0400, Yannick Lamarre wrote:
> lttng_poll_mod should call compat_(e)poll_mod.
> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---

As mentioned in person, the "high level" delta can be added here as long as you
are before the diff start. [1]

[1] https://stackoverflow.com/questions/18979120/is-it-possible-to-add-a-comment-to-a-diff-file-unified

Normally you can simply add a "---" and compose the message between the "---".

>  src/common/compat/poll.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index d4bd87f5..fde54ddb 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -177,7 +177,7 @@ extern int compat_epoll_del(struct lttng_poll_event *events, int fd);
>  extern int compat_epoll_mod(struct lttng_poll_event *events,
>  		int fd, uint32_t req_events);
>  #define lttng_poll_mod(events, fd, req_events) \
> -	compat_epoll_add(events, fd, req_events)
> +	compat_epoll_mod(events, fd, req_events)
>  
>  /*
>   * Set up the poll set limits variable poll_max_size
> @@ -361,7 +361,7 @@ extern int compat_poll_del(struct lttng_poll_event *events, int fd);
>  extern int compat_poll_mod(struct lttng_poll_event *events,
>  		int fd, uint32_t req_events);
>  #define lttng_poll_mod(events, fd, req_events) \
> -	compat_poll_add(events, fd, req_events)
> +	compat_poll_mod(events, fd, req_events)
>  
>  /*
>   * Set up the poll set limits variable poll_max_size
> -- 
> 2.11.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan Rajotte-Julien
EfficiOS
