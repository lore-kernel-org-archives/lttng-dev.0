From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Properly sanitize input
 parameter
Date: Tue, 26 Mar 2019 14:31:49 -0400 (EDT)
Message-ID: <622363503.9689.1553625109604.JavaMail.zimbra__44046.3030173973$1553625126$gmane$org@efficios.com>
References: <20190326182123.6889-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44TKTy69X3z17tn
 for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2019 14:31:50 -0400 (EDT)
In-Reply-To: <20190326182123.6889-1-ylamarre@efficios.com>
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

----- On Mar 26, 2019, at 2:21 PM, Yannick Lamarre ylamarre@efficios.com wrote:

> The lttng client uses the sizeof the containing buffer for input string
> sanitation instead of libc defined macro.

The missing part of this changelog is the "why ?". Why is this change needed ?
What is wrong with the code ?

Just describing the code is of limited value. We can get that information from
reading the source.

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> lttng-enable_channel was improperly verifying user input and wrongly rejected
> valid input.

This part should have been in the changelog, not after "---". Also, we are missing
examples of the problems this causes.

Thanks,

Mathieu

> 
> src/bin/lttng/commands/enable_channels.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/bin/lttng/commands/enable_channels.c
> b/src/bin/lttng/commands/enable_channels.c
> index b4e2942c..5e314d9b 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -244,7 +244,7 @@ static int enable_channel(char *session_name)
> 		void *extended_ptr;
> 
> 		/* Validate channel name's length */
> -		if (strlen(channel_name) >= NAME_MAX) {
> +		if (strlen(channel_name) > sizeof(chan_opts.name) - 1) {
> 			ERR("Channel name is too long (max. %zu characters)",
> 					sizeof(chan_opts.name) - 1);
> 			error = 1;
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
