From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 18/18] Integrate serialized
 communication in lttng-ctl and sessiond
Date: Thu, 18 Apr 2019 15:58:04 -0400 (EDT)
Message-ID: <1723495213.1659.1555617484478.JavaMail.zimbra__21810.83049379$1555617703$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-19-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lVJt0pmQz1KXf
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:58:05 -0400 (EDT)
In-Reply-To: <20190418161850.1536-19-ylamarre@efficios.com>
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

Comment about your patch titles: this one should describe that it
targets the snapshot output commands.

Currently, title-wise, it is the same as patch 15/18, which really does not
convey enough info.

Please review all patches from this patchset to ensure they each have a unique
title that clearly identifies what they target.

> lttng-ctl and lttng-sessiond use serialized communication for
> messages using lttng_snapshot_out.

out -> output

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> src/bin/lttng-sessiond/client.c          | 27 ++++++++++++++++++++++-----
> src/common/sessiond-comm/sessiond-comm.h |  4 ++--
> src/lib/lttng-ctl/snapshot.c             | 24 ++++++++++++++++--------
> 3 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
> index aed415ee..43f17e56 100644
> --- a/src/bin/lttng-sessiond/client.c
> +++ b/src/bin/lttng-sessiond/client.c
> @@ -1760,9 +1760,12 @@ error_add_context:
> 	case LTTNG_SNAPSHOT_ADD_OUTPUT:
> 	{
> 		struct lttcomm_lttng_output_id reply;
> +		struct lttng_snapshot_output snapshot_output;
> +
> +		lttng_snapshot_output_deserialize(&snapshot_output,
> &cmd_ctx->lsm->u.snapshot_output.output);
> 
> 		ret = cmd_snapshot_add_output(cmd_ctx->session,
> -				&cmd_ctx->lsm->u.snapshot_output.output, &reply.id);
> +				&snapshot_output, &reply.id);
> 		if (ret != LTTNG_OK) {
> 			goto error;
> 		}
> @@ -1779,14 +1782,19 @@ error_add_context:
> 	}
> 	case LTTNG_SNAPSHOT_DEL_OUTPUT:
> 	{
> +		struct lttng_snapshot_output snapshot_output;
> +
> +		lttng_snapshot_output_deserialize(&snapshot_output,
> &cmd_ctx->lsm->u.snapshot_output.output);
> +
> 		ret = cmd_snapshot_del_output(cmd_ctx->session,
> -				&cmd_ctx->lsm->u.snapshot_output.output);
> +				&snapshot_output);
> 		break;
> 	}
> 	case LTTNG_SNAPSHOT_LIST_OUTPUT:
> 	{
> 		ssize_t nb_output;
> 		struct lttng_snapshot_output *outputs = NULL;
> +		struct lttng_snapshot_output_serialized *serialized_outputs;
> 
> 		nb_output = cmd_snapshot_list_outputs(cmd_ctx->session, &outputs);
> 		if (nb_output < 0) {
> @@ -1795,9 +1803,14 @@ error_add_context:
> 		}
> 
> 		assert((nb_output > 0 && outputs) || nb_output == 0);
> -		ret = setup_lttng_msg_no_cmd_header(cmd_ctx, outputs,
> -				nb_output * sizeof(struct lttng_snapshot_output));
> +		serialized_outputs = malloc(sizeof(struct lttng_snapshot_output_serialized) *
> nb_output);
> +		for (int i = 0; i < nb_output; i++) {

We don't use for (int i = ... in our coding style. Please define int i in the scope containing
the for ().

> +			lttng_snapshot_output_serialize(&serialized_outputs[i], &outputs[i]);
> +		}
> 		free(outputs);
> +		ret = setup_lttng_msg_no_cmd_header(cmd_ctx, serialized_outputs,
> +				nb_output * sizeof(struct lttng_snapshot_output_serialized));
> +		free(serialized_outputs);
> 
> 		if (ret < 0) {
> 			goto setup_error;
> @@ -1808,8 +1821,12 @@ error_add_context:
> 	}
> 	case LTTNG_SNAPSHOT_RECORD:
> 	{
> +		struct lttng_snapshot_output snapshot_output;
> +
> +		lttng_snapshot_output_deserialize(&snapshot_output,
> &cmd_ctx->lsm->u.snapshot_output.output);
> +
> 		ret = cmd_snapshot_record(cmd_ctx->session,
> -				&cmd_ctx->lsm->u.snapshot_record.output,
> +				&snapshot_output,
> 				cmd_ctx->lsm->u.snapshot_record.wait);
> 		break;
> 	}
> diff --git a/src/common/sessiond-comm/sessiond-comm.h
> b/src/common/sessiond-comm/sessiond-comm.h
> index 4c2240a0..a21510de 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -428,11 +428,11 @@ struct lttcomm_session_msg {
> 			uint32_t size;
> 		} LTTNG_PACKED uri;
> 		struct {
> -			struct lttng_snapshot_output output LTTNG_PACKED;
> +			struct lttng_snapshot_output_serialized output;
> 		} LTTNG_PACKED snapshot_output;
> 		struct {
> 			uint32_t wait;
> -			struct lttng_snapshot_output output LTTNG_PACKED;
> +			struct lttng_snapshot_output_serialized output;
> 		} LTTNG_PACKED snapshot_record;
> 		struct {
> 			uint32_t nb_uri;
> diff --git a/src/lib/lttng-ctl/snapshot.c b/src/lib/lttng-ctl/snapshot.c
> index b30c4706..9c015bc2 100644
> --- a/src/lib/lttng-ctl/snapshot.c
> +++ b/src/lib/lttng-ctl/snapshot.c
> @@ -47,8 +47,7 @@ int lttng_snapshot_add_output(const char *session_name,
> 
> 	lttng_ctl_copy_string(lsm.session.name, session_name,
> 			sizeof(lsm.session.name));
> -	memcpy(&lsm.u.snapshot_output.output, output,
> -			sizeof(lsm.u.snapshot_output.output));
> +	lttng_snapshot_output_serialize(&lsm.u.snapshot_output.output, output);
> 
> 	ret = lttng_ctl_ask_sessiond(&lsm, (void **) &reply);
> 	if (ret < 0) {
> @@ -80,8 +79,7 @@ int lttng_snapshot_del_output(const char *session_name,
> 
> 	lttng_ctl_copy_string(lsm.session.name, session_name,
> 			sizeof(lsm.session.name));
> -	memcpy(&lsm.u.snapshot_output.output, output,
> -			sizeof(lsm.u.snapshot_output.output));
> +	lttng_snapshot_output_serialize(&lsm.u.snapshot_output.output, output);
> 
> 	return lttng_ctl_ask_sessiond(&lsm, NULL);
> }
> @@ -99,6 +97,7 @@ int lttng_snapshot_list_output(const char *session_name,
> 	int ret;
> 	struct lttcomm_session_msg lsm;
> 	struct lttng_snapshot_output_list *new_list = NULL;
> +	struct lttng_snapshot_output_serialized *serialized_array;
> 
> 	if (!session_name || !list) {
> 		ret = -LTTNG_ERR_INVALID;
> @@ -117,12 +116,22 @@ int lttng_snapshot_list_output(const char *session_name,
> 		goto error;
> 	}
> 
> -	ret = lttng_ctl_ask_sessiond(&lsm, (void **) &new_list->array);
> +	ret = lttng_ctl_ask_sessiond(&lsm, (void **) &serialized_array);
> 	if (ret < 0) {
> 		goto free_error;
> 	}
> 
> -	new_list->count = ret / sizeof(struct lttng_snapshot_output);
> +	new_list->count = ret / sizeof(struct lttng_snapshot_output_serialized);
> +	new_list->array = zmalloc(sizeof(struct lttng_snapshot_output) *
> new_list->count);
> +	if (!new_list) {
> +		ret = -LTTNG_ERR_NOMEM;
> +		goto free_error;
> +	}
> +	for (int i = 0; i < new_list->count; i++) {

likewise for "int i".

Also, since we are here: it's a bonus point if we assign
new_list->count to a local variable and use it as end of loop
comparison rather than dereferencing the new_list-> pointer
for each loop.

Thanks,

Mathieu

> +		lttng_snapshot_output_deserialize(&new_list->array[i], &serialized_array[i]);
> +	}
> +	free(serialized_array);
> +
> 	*list = new_list;
> 	return 0;
> 
> @@ -207,8 +216,7 @@ int lttng_snapshot_record(const char *session_name,
> 	 * record.
> 	 */
> 	if (output) {
> -		memcpy(&lsm.u.snapshot_record.output, output,
> -				sizeof(lsm.u.snapshot_record.output));
> +		lttng_snapshot_output_serialize(&lsm.u.snapshot_record.output, output);
> 	}
> 
> 	/* The wait param is ignored. */
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
