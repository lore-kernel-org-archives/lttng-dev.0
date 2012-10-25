From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Possible memory leaks when
 creating filter IR root node
Date: Thu, 25 Oct 2012 15:56:30 -0400
Message-ID: <5089996E.80201__39632.6127033264$1351195031$gmane$org@efficios.com>
References: <1351020977-18412-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TRTXd-000648-4X
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 15:56:33 -0400
In-Reply-To: <1351020977-18412-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Christian Babeux:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c
> index eec78fc..84122c9 100644
> --- a/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c
> +++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c
> @@ -46,9 +46,11 @@ struct ir_op *make_op_root(struct ir_op *child, enum ir_side side)
>  	case IR_DATA_UNKNOWN:
>  	default:
>  		fprintf(stderr, "[error] Unknown root child data type\n");
> +		free(op);
>  		return NULL;
>  	case IR_DATA_STRING:
>  		fprintf(stderr, "[error] String cannot be root data type\n");
> +		free(op);
>  		return NULL;
>  	case IR_DATA_NUMERIC:
>  	case IR_DATA_FIELD_REF:
