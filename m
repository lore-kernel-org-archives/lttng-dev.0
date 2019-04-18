From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 15/18] Integrate serialized
 communication in lttng-ctl and sessiond
Date: Thu, 18 Apr 2019 15:49:21 -0400 (EDT)
Message-ID: <1042503258.1614.1555616961586.JavaMail.zimbra__34259.3022783817$1555616977$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-16-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lV6p3fqSz1KSr
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:49:22 -0400 (EDT)
In-Reply-To: <20190418161850.1536-16-ylamarre@efficios.com>
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

> lttng-ctl and lttng-sessiond use serialized communication for
> messages using lttng_event.
> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> src/bin/lttng-sessiond/client.c          | 23 ++++++++++++++++++++---
> src/common/sessiond-comm/sessiond-comm.h |  4 ++--
> src/lib/lttng-ctl/lttng-ctl.c            | 14 ++++++++++----
> 3 files changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
> index 24e688c5..aed415ee 100644
> --- a/src/bin/lttng-sessiond/client.c
> +++ b/src/bin/lttng-sessiond/client.c
> @@ -1150,6 +1150,7 @@ error_add_context:
> 	case LTTNG_DISABLE_EVENT:
> 	{
> 
> +		struct lttng_event event;

I think we should remove the extra newline before the struct definition above
while we are there.

> 		/*
> 		 * FIXME: handle filter; for now we just receive the filter's
> 		 * bytecode along with the filter expression which are sent by
> @@ -1176,10 +1177,17 @@ error_add_context:
> 				count -= (size_t) ret;
> 			}
> 		}
> -		/* FIXME: passing packed structure to non-packed pointer */
> +		lttng_event_no_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
> +		if (cmd_ctx->lsm->domain.type == LTTNG_DOMAIN_KERNEL) {

Those if() would be neater in a switch() case.

> +			if (event.type == LTTNG_EVENT_PROBE || event.type == LTTNG_EVENT_FUNCTION ||
> event.type == LTTNG_EVENT_USERSPACE_PROBE) {
> +				lttng_event_probe_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
> +			} else if (event.type == LTTNG_EVENT_FUNCTION_ENTRY) {
> +				lttng_event_function_attr_deserialize(&event,
> &cmd_ctx->lsm->u.disable.event);
> +			}

else what ? Error handling ?

if () else if () without a following else typically hides missing error handling.

[...]

> -		ev = lttng_event_copy(&cmd_ctx->lsm->u.enable.event);
> +		lttng_event_no_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
> +		if (cmd_ctx->lsm->domain.type == LTTNG_DOMAIN_KERNEL) {
> +			if (event.type == LTTNG_EVENT_PROBE || event.type == LTTNG_EVENT_FUNCTION ||
> event.type == LTTNG_EVENT_USERSPACE_PROBE) {
> +				lttng_event_probe_attr_deserialize(&event, &cmd_ctx->lsm->u.disable.event);
> +			} else if (event.type == LTTNG_EVENT_FUNCTION_ENTRY) {
> +				lttng_event_function_attr_deserialize(&event,
> &cmd_ctx->lsm->u.disable.event);
> +			}

same.

> +		}
> +		ev = lttng_event_copy(&event);
> 		if (!ev) {
> 			DBG("Failed to copy event: %s",
> 					cmd_ctx->lsm->u.enable.event.name);
> diff --git a/src/common/sessiond-comm/sessiond-comm.h
> b/src/common/sessiond-comm/sessiond-comm.h
> index 78b18185..4c2240a0 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -370,7 +370,7 @@ struct lttcomm_session_msg {
> 		/* Event data */
> 		struct {
> 			char channel_name[LTTNG_SYMBOL_NAME_LEN];
> -			struct lttng_event event LTTNG_PACKED;
> +			struct lttng_event_serialized event;
> 			/* Length of following filter expression. */
> 			uint32_t expression_len;
> 			/* Length of following bytecode for filter. */
> @@ -389,7 +389,7 @@ struct lttcomm_session_msg {
> 		} LTTNG_PACKED enable;
> 		struct {
> 			char channel_name[LTTNG_SYMBOL_NAME_LEN];
> -			struct lttng_event event LTTNG_PACKED;
> +			struct lttng_event_serialized event;
> 			/* Length of following filter expression. */
> 			uint32_t expression_len;
> 			/* Length of following bytecode for filter. */
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 686a98ef..a9adb5c2 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -1110,8 +1110,15 @@ int lttng_enable_event_with_exclusions(struct
> lttng_handle *handle,
> 	}
> 
> 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
> -	/* FIXME: copying non-packed struct to packed struct. */
> -	memcpy(&lsm.u.enable.event, ev, sizeof(lsm.u.enable.event));
> +
> +	lttng_event_no_attr_serialize(&lsm.u.enable.event, ev);
> +	if (handle->domain.type == LTTNG_DOMAIN_KERNEL) {
> +		if (ev->type == LTTNG_EVENT_PROBE || ev->type == LTTNG_EVENT_FUNCTION ||
> ev->type == LTTNG_EVENT_USERSPACE_PROBE) {
> +			lttng_event_probe_attr_serialize(&lsm.u.enable.event, ev);
> +		} else if (ev->type == LTTNG_EVENT_FUNCTION_ENTRY) {
> +			lttng_event_function_attr_serialize(&lsm.u.enable.event, ev);
> +		}
> +	}

same.

Thanks,

Mathieu

> 
> 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
> 			sizeof(lsm.session.name));
> @@ -1310,8 +1317,7 @@ int lttng_disable_event_ext(struct lttng_handle *handle,
> 	lsm.cmd_type = LTTNG_DISABLE_EVENT;
> 
> 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
> -	/* FIXME: copying non-packed struct to packed struct. */
> -	memcpy(&lsm.u.disable.event, ev, sizeof(lsm.u.disable.event));
> +	lttng_event_no_attr_serialize(&lsm.u.disable.event, ev);
> 
> 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
> 			sizeof(lsm.session.name));
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
