From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: address GCC unaligned
 pointer warnings
Date: Mon, 29 Jul 2019 10:04:01 -0400 (EDT)
Message-ID: <1204712857.1203.1564409041569.JavaMail.zimbra__28208.0635357246$1564409058$gmane$org@efficios.com>
References: <20190726220007.21275-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45y1dG5Znwz18Ff
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 10:04:02 -0400 (EDT)
In-Reply-To: <20190726220007.21275-1-gabriel.pollo-guilbert@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master, 2.11, 2.10, 2.9, thanks!

Mathieu

----- On Jul 26, 2019, at 6:00 PM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> The release of GCC 9 added the following warning:
> 
>	-Waddress-of-packed-member, enabled by default, warns about an
>	unaligned pointer value from the address of a packed member of a
>	struct or union.
> 
> The warning is triggered in some place in LTTng-UST in cases where we
> pass a pointer to get a result. Rather than passing the pointer directly
> from the struct member, we get the result into a local storage, then
> write it in the struct.
> 
> Signed-off-by: Gabriel-Andrew Pollo-Guilbert
> <gabriel.pollo-guilbert@efficios.com>
> ---
> liblttng-ust-comm/lttng-ust-comm.c | 26 +++++++++++++++++++-------
> liblttng-ust/lttng-ust-comm.c      |  6 +++++-
> 2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/liblttng-ust-comm/lttng-ust-comm.c
> b/liblttng-ust-comm/lttng-ust-comm.c
> index 679b40e6..92d86d4e 100644
> --- a/liblttng-ust-comm/lttng-ust-comm.c
> +++ b/liblttng-ust-comm/lttng-ust-comm.c
> @@ -853,12 +853,15 @@ static
> int serialize_integer_type(struct ustctl_integer_type *uit,
> 		const struct lttng_integer_type *lit)
> {
> +	int32_t encoding;
> +
> 	uit->size = lit->size;
> 	uit->signedness = lit->signedness;
> 	uit->reverse_byte_order = lit->reverse_byte_order;
> 	uit->base = lit->base;
> -	if (serialize_string_encoding(&uit->encoding, lit->encoding))
> +	if (serialize_string_encoding(&encoding, lit->encoding))
> 		return -EINVAL;
> +	uit->encoding = encoding;
> 	uit->alignment = lit->alignment;
> 	return 0;
> }
> @@ -880,9 +883,11 @@ int serialize_basic_type(struct lttng_session *session,
> 	}
> 	case atype_string:
> 	{
> -		if (serialize_string_encoding(&ubt->string.encoding,
> -				lbt->string.encoding))
> +		int32_t encoding;
> +
> +		if (serialize_string_encoding(&encoding, lbt->string.encoding))
> 			return -EINVAL;
> +		ubt->string.encoding = encoding;
> 		*uatype = ustctl_atype_string;
> 		break;
> 	}
> @@ -1007,13 +1012,15 @@ int serialize_one_field(struct lttng_session *session,
> 	{
> 		struct ustctl_field *uf = &fields[*iter_output];
> 		struct ustctl_type *ut = &uf->type;
> +		enum ustctl_abstract_types atype;
> 
> 		strncpy(uf->name, lf->name, LTTNG_UST_SYM_NAME_LEN);
> 		uf->name[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
> -		ret = serialize_basic_type(session, &ut->atype, lt->atype,
> +		ret = serialize_basic_type(session, &atype, lt->atype,
> 			&ut->u.basic, &lt->u.basic);
> 		if (ret)
> 			return ret;
> +		ut->atype = atype;
> 		(*iter_output)++;
> 		break;
> 	}
> @@ -1023,6 +1030,7 @@ int serialize_one_field(struct lttng_session *session,
> 		struct ustctl_type *ut = &uf->type;
> 		struct ustctl_basic_type *ubt;
> 		const struct lttng_basic_type *lbt;
> +		enum ustctl_abstract_types atype;
> 
> 		strncpy(uf->name, lf->name, LTTNG_UST_SYM_NAME_LEN);
> 		uf->name[LTTNG_UST_SYM_NAME_LEN - 1] = '\0';
> @@ -1030,10 +1038,11 @@ int serialize_one_field(struct lttng_session *session,
> 		ubt = &ut->u.array.elem_type;
> 		lbt = &lt->u.array.elem_type;
> 		ut->u.array.length = lt->u.array.length;
> -		ret = serialize_basic_type(session, &ubt->atype, lbt->atype,
> +		ret = serialize_basic_type(session, &atype, lbt->atype,
> 			&ubt->u.basic, &lbt->u.basic);
> 		if (ret)
> 			return -EINVAL;
> +		ubt->atype = atype;
> 		ut->atype = ustctl_atype_array;
> 		(*iter_output)++;
> 		break;
> @@ -1044,6 +1053,7 @@ int serialize_one_field(struct lttng_session *session,
> 		struct ustctl_type *ut = &uf->type;
> 		struct ustctl_basic_type *ubt;
> 		const struct lttng_basic_type *lbt;
> +		enum ustctl_abstract_types atype;
> 		int ret;
> 
> 		strncpy(uf->name, lf->name, LTTNG_UST_SYM_NAME_LEN);
> @@ -1051,16 +1061,18 @@ int serialize_one_field(struct lttng_session *session,
> 		uf->type.atype = ustctl_atype_sequence;
> 		ubt = &ut->u.sequence.length_type;
> 		lbt = &lt->u.sequence.length_type;
> -		ret = serialize_basic_type(session, &ubt->atype, lbt->atype,
> +		ret = serialize_basic_type(session, &atype, lbt->atype,
> 			&ubt->u.basic, &lbt->u.basic);
> 		if (ret)
> 			return -EINVAL;
> +		ubt->atype = atype;
> 		ubt = &ut->u.sequence.elem_type;
> 		lbt = &lt->u.sequence.elem_type;
> -		ret = serialize_basic_type(session, &ubt->atype, lbt->atype,
> +		ret = serialize_basic_type(session, &atype, lbt->atype,
> 			&ubt->u.basic, &lbt->u.basic);
> 		if (ret)
> 			return -EINVAL;
> +		ubt->atype = atype;
> 		ut->atype = ustctl_atype_sequence;
> 		(*iter_output)++;
> 		break;
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index 61dbb41b..4bc350e2 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -875,14 +875,18 @@ int handle_message(struct sock_info *sock_info,
> 	}
> 	case LTTNG_UST_STREAM:
> 	{
> +		uint64_t memory_map_size;
> +
> 		/* Receive shm_fd, wakeup_fd */
> 		ret = ustcomm_recv_stream_from_sessiond(sock,
> -			&lum->u.stream.len,
> +			&memory_map_size,
> 			&args.stream.shm_fd,
> 			&args.stream.wakeup_fd);
> 		if (ret) {
> 			goto error;
> 		}
> +		lum->u.stream.len = memory_map_size;
> +
> 		if (ops->cmd)
> 			ret = ops->cmd(lum->handle, lum->cmd,
> 					(unsigned long) &lum->u,
> --
> 2.22.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
