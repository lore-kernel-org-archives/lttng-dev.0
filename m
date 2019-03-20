From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 5/8] Fix hang in thread_rotation
 when using compat-poll
Date: Wed, 20 Mar 2019 15:28:26 -0400 (EDT)
Message-ID: <1087292640.4572.1553110106698.JavaMail.zimbra__17325.1761285186$1553110118$gmane$org@efficios.com>
References: <20190319211735.7187-1-ylamarre@efficios.com>
 <20190319211735.7187-6-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Pg236vdZz17l5
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 15:28:27 -0400 (EDT)
In-Reply-To: <20190319211735.7187-6-ylamarre@efficios.com>
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

> The poll flavor of the lttng_poll api requires the caller to verify
> which of the fd has really waken the thread from wait. This
> verification was missing and a blocking read was made on an empty fd.

Please use present tense in the changelog.

Other than that,

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> src/bin/lttng-sessiond/rotation-thread.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/src/bin/lttng-sessiond/rotation-thread.c
> b/src/bin/lttng-sessiond/rotation-thread.c
> index 6669372d..b86b1668 100644
> --- a/src/bin/lttng-sessiond/rotation-thread.c
> +++ b/src/bin/lttng-sessiond/rotation-thread.c
> @@ -974,6 +974,10 @@ void *thread_rotation(void *data)
> 			int fd = LTTNG_POLL_GETFD(&thread.events, i);
> 			uint32_t revents = LTTNG_POLL_GETEV(&thread.events, i);
> 
> +			if (!revents) {
> +				/* No activity for this FD (poll implementation). */
> +				continue;
> +			}
> 			DBG("[rotation-thread] Handling fd (%i) activity (%u)",
> 					fd, revents);
> 
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
