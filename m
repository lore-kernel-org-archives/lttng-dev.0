From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 3/8] Change LTTNG_POLL_GETNB
 behaviour for poll flavor
Date: Wed, 20 Mar 2019 15:22:37 -0400 (EDT)
Message-ID: <1637986872.4562.1553109757478.JavaMail.zimbra__6232.8321671643$1553109773$gmane$org@efficios.com>
References: <20190319211735.7187-1-ylamarre@efficios.com>
 <20190319211735.7187-4-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44PfvL24hCz17jg
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 15:22:38 -0400 (EDT)
In-Reply-To: <20190319211735.7187-4-ylamarre@efficios.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org



----- On Mar 19, 2019, at 5:17 PM, Yannick Lamarre ylamarre@efficios.com wrote:

> LTTNG_POLL_GETNB was modified to provide compatibility with the epoll

LTTNG_POLL_GETNB was modified -> Modify LTTNG_POLL_GETNB...

(use present, not past)

> flavor. Since it is only used after a lttng_poll_wait call with no
> modification (add, del, mod) between, this change does not modify the
> behaviour in its current usage while still providing test compatibility.

still providing test compatibility -> ensuring similar API behavior between
compatibility layer implementations.

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> src/common/compat/poll.h | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index fde54ddb..7dd8741b 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -315,10 +315,14 @@ static inline int __lttng_poll_get_prev_fd(struct
> lttng_poll_event *events,
> /*
>  * For the following calls, consider 'e' to be a lttng_poll_event pointer and i
>  * being the index of the events array.
> + * LTTNG_POLL_GETNB was modified to provide compatibility with the epoll

No reason to describe the evolution of the code in a comment. We document
what is there now.

Thanks,

Mathieu

> + * flavor. Since it is only used after a lttng_poll_wait call with no
> + * modification (add, del, mod) between, this change does not modify the
> + * behaviour in its current usage while still providing test compatibility.
>  */
> #define LTTNG_POLL_GETFD(e, i) LTTNG_REF(e)->wait.events[i].fd
> #define LTTNG_POLL_GETEV(e, i) LTTNG_REF(e)->wait.events[i].revents
> -#define LTTNG_POLL_GETNB(e) LTTNG_REF(e)->wait.nb_fd
> +#define LTTNG_POLL_GETNB(e) LTTNG_REF(e)->current.nb_fd
> #define LTTNG_POLL_GETSZ(e) LTTNG_REF(e)->wait.events_size
> #define LTTNG_POLL_GET_PREV_FD(e, i, nb_fd) \
> 	__lttng_poll_get_prev_fd(LTTNG_REF(e), i, nb_fd)
> --
> 2.11.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
