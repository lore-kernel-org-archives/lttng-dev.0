From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: use newly created event
 filter for condition check
Date: Tue, 24 Sep 2019 11:08:56 -0400 (EDT)
Message-ID: <325249304.599.1569337736318.JavaMail.zimbra__23321.3073269994$1569337751$gmane$org@efficios.com>
References: <20190924145316.21302-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46d4Ms0h6Jz1Msh
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 11:08:57 -0400 (EDT)
In-Reply-To: <20190924145316.21302-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Sep 24, 2019, at 10:53 AM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> 4c5e3185d75ffe90b04107744693964d9051fb6b introduced a regression while
> fixing the filter and filter_expression ownership.

What is this commit ? I'm having trouble finding it. Can you double-check and
provide the commit Subject as well ?

Typically:

commit 1234567890ab "Commit subject" ....

Thanks,

Mathieu

> 
> Setting the "filter" object to NULL prevents the call to
> add_filter_app_ctx when needed.
> 
> We use the filter from the newly created event to
> perform the check and the call to add_filter_app_ctx.
> 
> Fixes coverity #1399733
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> src/bin/lttng-sessiond/event.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
> index f32db4429..a8b7646da 100644
> --- a/src/bin/lttng-sessiond/event.c
> +++ b/src/bin/lttng-sessiond/event.c
> @@ -513,8 +513,9 @@ int event_agent_enable(struct ltt_ust_session *usess,
> 		created = 1;
> 	}
> 
> -	if (created && filter) {
> -		ret = add_filter_app_ctx(filter, filter_expression, agt);
> +	if (created && aevent->filter) {
> +		ret = add_filter_app_ctx(
> +				aevent->filter, aevent->filter_expression, agt);
> 		if (ret != LTTNG_OK) {
> 			goto error;
> 		}
> --
> 2.17.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
