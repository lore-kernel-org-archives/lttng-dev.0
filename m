From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Handle the unary bitwise
 negation operator (~) in the XML printer
Date: Thu, 25 Oct 2012 15:56:29 -0400
Message-ID: <5089996D.9080103__35197.9771665812$1351195032$gmane$org@efficios.com>
References: <1351021001-18480-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TRTXd-000647-3l
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 15:56:33 -0400
In-Reply-To: <1351021001-18480-1-git-send-email-christian.babeux@efficios.com>
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
>  src/lib/lttng-ctl/filter/filter-visitor-xml.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/lib/lttng-ctl/filter/filter-visitor-xml.c b/src/lib/lttng-ctl/filter/filter-visitor-xml.c
> index 90a336d..1d14f2e 100644
> --- a/src/lib/lttng-ctl/filter/filter-visitor-xml.c
> +++ b/src/lib/lttng-ctl/filter/filter-visitor-xml.c
> @@ -235,6 +235,9 @@ int recursive_visit_print(struct filter_node *node, FILE *stream, int indent)
>  		case AST_UNARY_NOT:
>  			fprintf(stream, "\"!\"");
>  			break;
> +		case AST_UNARY_BIN_NOT:
> +			fprintf(stream, "\"~\"");
> +			break;
>  		}
>  		fprintf(stream, ">\n");
>  		ret = recursive_visit_print(node->u.unary_op.child,
