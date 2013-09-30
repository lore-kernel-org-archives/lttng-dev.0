From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Add new option --seek
Date: Mon, 30 Sep 2013 20:51:28 +0000 (UTC)
Message-ID: <765709073.26241.1380574288812.JavaMail.zimbra__1486.8147708059$1380574351$gmane$org@efficios.com>
References: <1380313864-1496-1-git-send-email-bernat@luffy.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VQkRK-0000BP-T3
	for lttng-dev@lists.lttng.org; Mon, 30 Sep 2013 16:51:40 -0400
In-Reply-To: <1380313864-1496-1-git-send-email-bernat@luffy.cx>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Vincent Bernat <bernat@luffy.cx>
Cc: lttng-dev@lists.lttng.org, Vincent Bernat <vincent.bernat@dailymotion.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Vincent Bernat" <bernat@luffy.cx>
> To: lttng-dev@lists.lttng.org
> Cc: "Vincent Bernat" <vincent.bernat@dailymotion.com>
> Sent: Friday, September 27, 2013 4:31:04 PM
> Subject: [lttng-dev] [PATCH] Add new option --seek
> 
> From: Vincent Bernat <vincent.bernat@dailymotion.com>
> 
> Add a new option --seek. It requires a parameter that specifies the
> offset in seconds to seek from the beginning of the trace. This allows
> a user to skip the beginning of a trace or to produce a smaller trace
> to be used by other tools.

An offset in seconds seems to be somewhat arbitrary.

Could we instead have a s.ns (seconds.nanoseconds) offset ?

> 
> Signed-off-by: Vincent Bernat <vincent.bernat@dailymotion.com>
> ---
>  converter/babeltrace.c                   | 49
>  ++++++++++++++++++++++++++++++++
>  doc/babeltrace.1                         |  3 ++
>  formats/ctf/ctf.c                        |  1 +
>  include/babeltrace/babeltrace-internal.h |  1 +
>  4 files changed, 54 insertions(+)
> 
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index d5a7040..0ac7312 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -99,6 +99,7 @@ enum {
>  	OPT_CLOCK_DATE,
>  	OPT_CLOCK_GMT,
>  	OPT_CLOCK_FORCE_CORRELATE,
> +	OPT_SEEK,
>  };
>  
>  /*
> @@ -128,6 +129,7 @@ static struct poptOption long_options[] = {
>  	{ "clock-date", 0, POPT_ARG_NONE, NULL, OPT_CLOCK_DATE, NULL, NULL },
>  	{ "clock-gmt", 0, POPT_ARG_NONE, NULL, OPT_CLOCK_GMT, NULL, NULL },
>  	{ "clock-force-correlate", 0, POPT_ARG_NONE, NULL,
>  	OPT_CLOCK_FORCE_CORRELATE, NULL, NULL },
> +	{ "seek", 0, POPT_ARG_STRING, NULL, OPT_SEEK, NULL, NULL },
>  	{ NULL, 0, 0, NULL, 0, NULL, NULL },
>  };
>  
> @@ -173,6 +175,8 @@ static void usage(FILE *fp)
>  	fprintf(fp, "      --clock-gmt                Print clock in GMT time zone
>  	(default: local time zone)\n");
>  	fprintf(fp, "      --clock-force-correlate    Assume that clocks are
>  	inherently correlated\n");
>  	fprintf(fp, "                                 across traces.\n");
> +	fprintf(fp, "      --seek                     Seek to the given position in
> seconds,\n");
> +	fprintf(fp, "                                 relative to the beginning of
> the trace.\n");
>  	list_formats(fp);
>  	fprintf(fp, "\n");
>  }
> @@ -393,6 +397,29 @@ static int parse_options(int argc, char **argv)
>  			opt_clock_force_correlate = 1;
>  			break;
>  
> +		case OPT_SEEK:
> +		{
> +			char *str;
> +			char *endptr;
> +
> +			str = (char *) poptGetOptArg(pc);
> +			if (!str) {
> +				fprintf(stderr, "[error] Missing --seek argument\n");
> +				ret = -EINVAL;
> +				goto end;
> +			}
> +			errno = 0;
> +			opt_seek = strtoull(str, &endptr, 0);
> +			if (*endptr != '\0' || str == endptr || errno != 0) {
> +				fprintf(stderr, "[error] Incorrect --seek argument: %s\n", str);
> +				ret = -EINVAL;
> +				free(str);
> +				goto end;
> +			}
> +			free(str);
> +			break;
> +		}
> +
>  		default:
>  			ret = -EINVAL;
>  			goto end;
> @@ -609,6 +636,7 @@ int convert_trace(struct bt_trace_descriptor *td_write,
>  	struct bt_ctf_iter *iter;
>  	struct ctf_text_stream_pos *sout;
>  	struct bt_iter_pos begin_pos;
> +	struct bt_iter_pos seek_pos;
>  	struct bt_ctf_event *ctf_event;
>  	int ret;
>  
> @@ -624,6 +652,27 @@ int convert_trace(struct bt_trace_descriptor *td_write,
>  		ret = -1;
>  		goto error_iter;
>  	}
> +	if (opt_seek > 0) {
> +		/* Read the first event to be able to seek. */
> +		ctf_event = bt_ctf_iter_read_event(iter);
> +		if (!ctf_event) {
> +			ret = -1;
> +			goto error_iter;
> +		}
> +		if (!ctf_event->parent->stream->has_timestamp) {
> +			fprintf(stderr, "[error] Unable to seek to %" PRIu64 ". No timestamp.\n",
> +				opt_seek);
> +			goto end;
> +		}
> +		seek_pos.type = BT_SEEK_TIME;
> +		seek_pos.u.seek_time = opt_seek*1000*1000*1000 +

Please don't hardcode _any_ numerical values in the code. At the very least use a define, and check if this is already defined somewhere.

Thanks,

Mathieu

> bt_ctf_get_timestamp(ctf_event);
> +		ret = bt_iter_set_pos(bt_ctf_get_iter(iter), &seek_pos);
> +		if (ret) {
> +			fprintf(stderr, "[error] Unable to seek to %" PRIu64 ".\n",
> +				opt_seek);
> +			goto end;
> +		}
> +	}
>  	while ((ctf_event = bt_ctf_iter_read_event(iter))) {
>  		ret = sout->parent.event_cb(&sout->parent, ctf_event->parent->stream);
>  		if (ret) {
> diff --git a/doc/babeltrace.1 b/doc/babeltrace.1
> index 929c563..d775fd8 100644
> --- a/doc/babeltrace.1
> +++ b/doc/babeltrace.1
> @@ -71,6 +71,9 @@ Print clock date
>  .TP
>  .BR "--clock-gmt"
>  Print clock in GMT time zone (default: local time zone)
> +.BR "--seek"
> +Seek to the given position in seconds, relative to the beginning of
> +the trace
>  .TP
>  
>  .fi
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 947b439..078b630 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -78,6 +78,7 @@ int opt_clock_cycles,
>  
>  uint64_t opt_clock_offset;
>  uint64_t opt_clock_offset_ns;
> +uint64_t opt_seek;
>  
>  extern int yydebug;
>  
> diff --git a/include/babeltrace/babeltrace-internal.h
> b/include/babeltrace/babeltrace-internal.h
> index 1f379ee..86eb356 100644
> --- a/include/babeltrace/babeltrace-internal.h
> +++ b/include/babeltrace/babeltrace-internal.h
> @@ -195,5 +195,6 @@ extern int opt_all_field_names,
>  
>  extern uint64_t opt_clock_offset;
>  extern uint64_t opt_clock_offset_ns;
> +extern uint64_t opt_seek;
>  
>  #endif
> --
> 1.8.4.rc3
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
