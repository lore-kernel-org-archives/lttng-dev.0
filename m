From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 lttng-tools] Fix: Accept bytecode of
	length 65536	bytes
Date: Thu, 6 Sep 2012 13:44:52 -0400
Message-ID: <20120906174452.GA8823__179.751232690428$1346953522$gmane$org@Krystal>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
	<1346953219-9001-1-git-send-email-christian.babeux@efficios.com>
	<1346953219-9001-2-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9g8L-0006oT-Ka
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 13:44:53 -0400
Content-Disposition: inline
In-Reply-To: <1346953219-9001-2-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> In order to support the filter bytecode maximum length (65536 bytes),
> the lttng_ust_filter_bytecode len field type must be able to
> hold more than a uint16_t. Change the field type to a uint32_t.
> 
> Also, since the relocation table is located at the end of the actual
> bytecode, the reloc_table_offset (reloc_offset in ust-abi) field must
> support offset values larger than 65535. Change the field type to a
> uint32_t. This change will allow support of relocation table appended
> to larger bytecode without breaking the ABI if the need arise in the
> future.
> 
> Both changes currently breaks the filter ABI, but this should be a
> reasonable compromise since the filtering feature has not been
> released yet.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  src/bin/lttng-sessiond/lttng-ust-abi.h                      | 6 +++---
>  src/bin/lttng-sessiond/main.c                               | 2 +-
>  src/common/sessiond-comm/sessiond-comm.h                    | 6 +++---
>  src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/lttng-ust-abi.h b/src/bin/lttng-sessiond/lttng-ust-abi.h
> index d8b10c2..504c060 100644
> --- a/src/bin/lttng-sessiond/lttng-ust-abi.h
> +++ b/src/bin/lttng-sessiond/lttng-ust-abi.h
> @@ -168,10 +168,10 @@ struct lttng_ust_calibrate {
>  	} u;
>  };
>  
> -#define FILTER_BYTECODE_MAX_LEN		65535
> +#define FILTER_BYTECODE_MAX_LEN		65536
>  struct lttng_ust_filter_bytecode {
> -	uint16_t len;
> -	uint16_t reloc_offset;
> +	uint32_t len;
> +	uint32_t reloc_offset;
>  	char data[0];
>  };
>  
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 318da74..730ac65 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -2659,7 +2659,7 @@ skip_domain:
>  	{
>  		struct lttng_filter_bytecode *bytecode;
>  
> -		if (cmd_ctx->lsm->u.filter.bytecode_len > 65336) {
> +		if (cmd_ctx->lsm->u.filter.bytecode_len > LTTNG_FILTER_MAX_LEN) {
>  			ret = LTTNG_ERR_FILTER_INVAL;
>  			goto error;
>  		}
> diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
> index 32ce384..62205f4 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -208,7 +208,7 @@ struct lttcomm_session_msg {
>  	} u;
>  };
>  
> -#define LTTNG_FILTER_MAX_LEN	65336
> +#define LTTNG_FILTER_MAX_LEN	65536
>  
>  /*
>   * Filter bytecode data. The reloc table is located at the end of the
> @@ -216,8 +216,8 @@ struct lttcomm_session_msg {
>   * starts at reloc_table_offset.
>   */
>  struct lttng_filter_bytecode {
> -	uint16_t len;	/* len of data */
> -	uint16_t reloc_table_offset;
> +	uint32_t len;	/* len of data */
> +	uint32_t reloc_table_offset;
>  	char data[0];
>  };
>  
> diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> index 98f8375..332a387 100644
> --- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> +++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> @@ -239,7 +239,7 @@ int visit_node_load(struct filter_parser_ctx *ctx, struct ir_op *node)
>  		uint32_t insn_len = sizeof(struct load_op)
>  			+ sizeof(struct field_ref);
>  		struct field_ref ref_offset;
> -		uint16_t reloc_offset;
> +		uint32_t reloc_offset;
>  
>  		insn = calloc(insn_len, 1);
>  		if (!insn)
> -- 
> 1.7.11.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
