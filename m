From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 12/18] Integrate serialized
 communication in lttng-ctl and sessiond
Date: Thu, 18 Apr 2019 15:44:12 -0400 (EDT)
Message-ID: <1862573395.1563.1555616652401.JavaMail.zimbra__46946.1842718133$1555616767$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-13-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lV0s6N6wz1KPv
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:44:13 -0400 (EDT)
In-Reply-To: <20190418161850.1536-13-ylamarre@efficios.com>
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

----- On Apr 18, 2019, at 12:18 PM, Yannick Lamarre ylamarre@efficios.com wrote:

[...]

> diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
> index 0e36e5ad..24e688c5 100644
> --- a/src/bin/lttng-sessiond/client.c
> +++ b/src/bin/lttng-sessiond/client.c
> @@ -1069,6 +1069,8 @@ skip_domain:
> 	switch (cmd_ctx->lsm->cmd_type) {
> 	case LTTNG_ADD_CONTEXT:
> 	{
> +		struct lttng_event_context evt_ctx;

coding style: add newline between variable definitions and code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
