From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH] Add new option --clock-offset-ns
Date: Fri, 12 Apr 2013 09:21:58 -0400
Message-ID: <20130412132158.GA27890__14645.6037335613$1365772958$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5371E30@EU-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UQdvW-0002iB-9V
	for lttng-dev@lists.lttng.org; Fri, 12 Apr 2013 09:22:02 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5371E30@EU-MBX-03.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> 
> Add a new option --clock-offset-ns. It requires a parameter
> that specifies a clock offset (in nanoseconds) that is added
> to each timestamp.
> 
> This works exactly as the option --clock-offset, except that
> the value is given in nanoseconds instead of full seconds.
> 
> The two options --clock-offset and --clock-offset-ns are
> compatible with each other, and it's possible to give both.
> For example, having the options

Sounds like a nice feature. One comment below,

> 
> --clock-offset 2 --clock-offset-ns 1000000
> 
> means that 2.001 seconds is added to each timestamp.
> ---
>  converter/babeltrace.c                   | 26 ++++++++++++++++++++++++++
>  formats/ctf/ctf.c                        |  4 ++++
>  include/babeltrace/babeltrace-internal.h |  1 +
>  3 files changed, 31 insertions(+)
> 
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 83f300c..bfdfc47 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -92,6 +92,7 @@ enum {
>  	OPT_FIELDS,
>  	OPT_NO_DELTA,
>  	OPT_CLOCK_OFFSET,
> +	OPT_CLOCK_OFFSET_NS,
>  	OPT_CLOCK_CYCLES,
>  	OPT_CLOCK_SECONDS,
>  	OPT_CLOCK_DATE,
> @@ -120,6 +121,7 @@ static struct poptOption long_options[] = {
>  	{ "fields", 'f', POPT_ARG_STRING, NULL, OPT_FIELDS, NULL, NULL },
>  	{ "no-delta", 0, POPT_ARG_NONE, NULL, OPT_NO_DELTA, NULL, NULL },
>  	{ "clock-offset", 0, POPT_ARG_STRING, NULL, OPT_CLOCK_OFFSET, NULL, NULL },
> +	{ "clock-offset-ns", 0, POPT_ARG_STRING, NULL, OPT_CLOCK_OFFSET_NS, NULL, NULL },
>  	{ "clock-cycles", 0, POPT_ARG_NONE, NULL, OPT_CLOCK_CYCLES, NULL, NULL },
>  	{ "clock-seconds", 0, POPT_ARG_NONE, NULL, OPT_CLOCK_SECONDS, NULL, NULL },
>  	{ "clock-date", 0, POPT_ARG_NONE, NULL, OPT_CLOCK_DATE, NULL, NULL },
> @@ -163,6 +165,7 @@ static void usage(FILE *fp)
>  	fprintf(fp, "                                     (default: trace:hostname,trace:procname,trace:vpid)\n");
>  	fprintf(fp, "      --clock-cycles             Timestamp in cycles\n");
>  	fprintf(fp, "      --clock-offset seconds     Clock offset in seconds\n");
> +	fprintf(fp, "      --clock-offset-ns ns       Clock offset in nanoseconds\n");
>  	fprintf(fp, "      --clock-seconds            Print the timestamps as [sec.ns]\n");
>  	fprintf(fp, "                                 (default is: [hh:mm:ss.ns])\n");
>  	fprintf(fp, "      --clock-date               Print clock date\n");
> @@ -356,6 +359,29 @@ static int parse_options(int argc, char **argv)
>  		case OPT_CLOCK_SECONDS:
>  			opt_clock_seconds = 1;
>  			break;
> +		case OPT_CLOCK_OFFSET_NS:
> +		{
> +			char *str;
> +			char *endptr;
> +
> +			str = (char *) poptGetOptArg(pc);
> +			if (!str) {
> +				fprintf(stderr, "[error] Missing --clock-offset-ns argument\n");
> +				ret = -EINVAL;
> +				goto end;
> +			}
> +			errno = 0;
> +			opt_clock_offset_ns = strtoull(str, &endptr, 0);
> +			if (*endptr != '\0' || str == endptr || errno != 0) {

Why test *endptr != '\0' and str == endptr ?

From my understanding of strtoull(3), just:

errno = 0;
opt_clock_offset_ns = strtoull(str, NULL, 0);
if (errno != 0) {
        handle error...
}

should be enough.. ? If not, I'd really like to know what I am missing.

Thanks,

Mathieu

> +				fprintf(stderr, "[error] Incorrect --clock-offset-ns argument: %s\n", str);
> +				ret = -EINVAL;
> +				free(str);
> +				goto end;
> +			}
> +			free(str);
> +			break;
> +		}
> +
>  		case OPT_CLOCK_DATE:
>  			opt_clock_date = 1;
>  			break;
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 5a51495..4f320a6 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -72,6 +72,7 @@ int opt_clock_cycles,
>  	opt_clock_gmt;
>  
>  uint64_t opt_clock_offset;
> +uint64_t opt_clock_offset_ns;
>  
>  extern int yydebug;
>  
> @@ -316,6 +317,9 @@ void ctf_print_timestamp_real(FILE *fp,
>  
>  	ts_nsec = timestamp;
>  
> +	/* Add command-line offset in ns*/
> +        ts_nsec += opt_clock_offset_ns;
> +
>  	/* Add command-line offset */
>  	ts_sec += opt_clock_offset;
>  
> diff --git a/include/babeltrace/babeltrace-internal.h b/include/babeltrace/babeltrace-internal.h
> index 6219b3a..81ea9b9 100644
> --- a/include/babeltrace/babeltrace-internal.h
> +++ b/include/babeltrace/babeltrace-internal.h
> @@ -85,5 +85,6 @@ extern int opt_all_field_names,
>  	opt_clock_force_correlate;
>  
>  extern uint64_t opt_clock_offset;
> +extern uint64_t opt_clock_offset_ns;
>  
>  #endif
> -- 
> 1.8.1.msysgit.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
