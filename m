From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: memleak in liblttng-ctl
	visit_node_load()
Date: Fri, 14 Jun 2013 16:37:13 -0400
Message-ID: <51BB7EF9.6040806__23702.8821291917$1371242273$gmane$org@efficios.com>
References: <20130614203456.GA31559@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UnakJ-00070p-SY
	for lttng-dev@lists.lttng.org; Fri, 14 Jun 2013 16:37:20 -0400
In-Reply-To: <20130614203456.GA31559@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Mathieu Desnoyers:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> index 785c113..762d604 100644
> --- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> +++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> @@ -263,6 +263,7 @@ int visit_node_load(struct filter_parser_ctx *ctx, struct ir_op *node)
>  			insn->op = FILTER_OP_GET_CONTEXT_REF;
>  			break;
>  		default:
> +			free(insn);
>  			return -EINVAL;
>  		}
>  		ref_offset.offset = (uint16_t) -1U;
> 
