From: Tony Jones <tonyj@suse.de>
Subject: Re: [RFC lttng-tools] Do not list or allow unsupported
 perf events
Date: Thu, 10 Sep 2015 17:15:01 -0700
Message-ID: <55F21D05.1080002__6555.05683175779$1441930940$gmane$org@suse.de>
References: <1441912892-30236-1-git-send-email-tonyj@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx2.suse.de ([195.135.220.15])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <tonyj@suse.de>) id 1ZaC5X-0008F0-1K
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 20:21:16 -0400
In-Reply-To: <1441912892-30236-1-git-send-email-tonyj@suse.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 09/10/2015 12:21 PM, Tony Jones wrote:

> +static int is_event_supported(const struct ctx_opts *ctx)
> +{
> +	int fd;
> +	struct perf_event_attr attr = {
> +		.type = ctx->u.perf.type,
> +		.config = ctx->u.perf.config,
> +		.disabled = 1
> +	};
> +
> +	if (ctx->ctx_type == CONTEXT_PERF_CPU_COUNTER ||
> +	    ctx->ctx_type == CONTEXT_PERF_THREAD_COUNTER) {

obviously CONTEXT_PERF_THREAD_COUNTER is UST.  Regardless, there are  some obvious usability issues (below).  I need to look at the code some more.

# lttng add-context -u -t perf:thread:alignment-faults
UST context perf:thread:alignment-faults added to all channels

(invalid, better error needed, also sometimes -k -t perf:thread:* succeeds which seems broken)
# lttng add-context -k -t perf:thread:alignment-faults
Error: perf:thread:alignment-faults: Add kernel context failed
Warning: Some command(s) went wrong
