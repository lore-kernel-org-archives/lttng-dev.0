From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 17/18] Add serdes functions
 for lttng_snapshot_output
Date: Thu, 18 Apr 2019 15:52:03 -0400 (EDT)
Message-ID: <202790084.1641.1555617123626.JavaMail.zimbra__49457.2688405$1555617143$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-18-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44lV9w2HvGz1KVJ
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:52:04 -0400 (EDT)
In-Reply-To: <20190418161850.1536-18-ylamarre@efficios.com>
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

> Since those structs are only transfered across unix sockets, endianess
> is kept in host order.

transfered -> transferred (check all commit messages)
endianess -> endianness (check all commit messages)

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> include/lttng/snapshot-internal.h        |  3 +++
> src/common/sessiond-comm/sessiond-comm.c | 28 ++++++++++++++++++++++++++++
> 2 files changed, 31 insertions(+)
> 
> diff --git a/include/lttng/snapshot-internal.h
> b/include/lttng/snapshot-internal.h
> index bf9dfbe4..b269607d 100644
> --- a/include/lttng/snapshot-internal.h
> +++ b/include/lttng/snapshot-internal.h
> @@ -73,4 +73,7 @@ struct lttng_snapshot_output_list {
> 	struct lttng_snapshot_output *array;
> };
> 
> +int lttng_snapshot_output_serialize(struct lttng_snapshot_output_serialized
> *dst, const struct lttng_snapshot_output *src);
> +int lttng_snapshot_output_deserialize(struct lttng_snapshot_output *dst, const
> struct lttng_snapshot_output_serialized *src);
> +
> #endif /* LTTNG_SNAPSHOT_INTERNAL_ABI_H */
> diff --git a/src/common/sessiond-comm/sessiond-comm.c
> b/src/common/sessiond-comm/sessiond-comm.c
> index d71abe0c..863054d0 100644
> --- a/src/common/sessiond-comm/sessiond-comm.c
> +++ b/src/common/sessiond-comm/sessiond-comm.c
> @@ -77,6 +77,34 @@ static const char *lttcomm_readable_code[] = {
> static unsigned long network_timeout;
> 
> LTTNG_HIDDEN
> +int lttng_snapshot_output_serialize(struct lttng_snapshot_output_serialized
> *dst,
> +		const struct lttng_snapshot_output *src)
> +{

Why not assert(src && dst) here like other helpers ?

> +	dst->id = src->id;
> +	dst->max_size = src->max_size;
> +
> +	memcpy(dst->name, src->name, LTTNG_NAME_MAX);
> +	memcpy(dst->ctrl_url, src->ctrl_url, PATH_MAX);
> +	memcpy(dst->data_url, src->data_url, PATH_MAX);
> +
> +	return 0;
> +}
> +
> +LTTNG_HIDDEN
> +int lttng_snapshot_output_deserialize(struct lttng_snapshot_output *dst,
> +		const struct lttng_snapshot_output_serialized *src)
> +{

same.

Thanks,

Mathieu

> +	dst->id = src->id;
> +	dst->max_size = src->max_size;
> +
> +	memcpy(dst->name, src->name, LTTNG_NAME_MAX);
> +	memcpy(dst->ctrl_url, src->ctrl_url, PATH_MAX);
> +	memcpy(dst->data_url, src->data_url, PATH_MAX);
> +
> +	return 0;
> +}
> +
> +LTTNG_HIDDEN
> int lttng_event_common_serialize(struct lttng_event_serialized *dst,
> 		const struct lttng_event *src)
> {
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
