From: David Goulet <dgoulet@ev0ke.net>
Subject: Re: [PATCH lttng-tools] Use parse_size_suffix in
	snapshot
Date: Fri, 23 Aug 2013 15:49:46 -0400
Message-ID: <20130823194946.GA20200__28235.1953712807$1377287455$gmane$org@ev0ke.net>
References: <1376418151-22312-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@ev0ke.net>) id 1VCxMp-0003DS-HU
	for lttng-dev@lists.lttng.org; Fri, 23 Aug 2013 15:50:01 -0400
Content-Disposition: inline
In-Reply-To: <1376418151-22312-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged with minor changes!

Thanks!
David

On 13 Aug (14:22:31), Simon Marchi wrote:
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  src/bin/lttng/commands/snapshot.c |   13 ++-----------
>  1 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
> index 56acca8..5b62fed 100644
> --- a/src/bin/lttng/commands/snapshot.c
> +++ b/src/bin/lttng/commands/snapshot.c
> @@ -58,7 +58,7 @@ static struct poptOption snapshot_opts[] = {
>  	{"ctrl-url",     'C', POPT_ARG_STRING, &opt_ctrl_url, 0, 0, 0},
>  	{"data-url",     'D', POPT_ARG_STRING, &opt_data_url, 0, 0, 0},
>  	{"name",         'n', POPT_ARG_STRING, &opt_output_name, 0, 0, 0},
> -	{"max-size",     'm', POPT_ARG_DOUBLE, 0, OPT_MAX_SIZE, 0, 0},
> +	{"max-size",     'm', POPT_ARG_STRING, 0, OPT_MAX_SIZE, 0, 0},
>  	{"list-options",   0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
>  	{0, 0, 0, 0, 0, 0, 0}
>  };
> @@ -445,21 +445,12 @@ int cmd_snapshot(int argc, const char **argv)
>  			char *endptr;
>  			const char *opt = poptGetOptArg(pc);
>  
> -			/* Documented by the man page of strtoll(3). */
> -			errno = 0;
> -			val = strtoll(opt, &endptr, 10);
> -			if ((errno == ERANGE && (val == LLONG_MAX || val == LONG_MIN))
> -					|| (errno != 0 && val == 0)) {
> +			if (utils_parse_size_suffix(opt, &val) < 0) {
>  				ERR("Unable to handle max-size value %s", opt);
>  				ret = CMD_ERROR;
>  				goto end;
>  			}
>  
> -			if (endptr == opt) {
> -				ERR("No digits were found in %s", opt);
> -				ret = CMD_ERROR;
> -				goto end;
> -			}
>  			opt_max_size = val;
>  
>  			break;
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
