From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] babeltrace: make '-w' actually work
Date: Thu, 14 Feb 2013 10:39:40 -0500
Message-ID: <20130214153940.GA29405__14556.0040291914$1360856442$gmane$org@Krystal>
References: <1360839138-16265-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U60uW-0008TL-5h
	for lttng-dev@lists.lttng.org; Thu, 14 Feb 2013 10:39:44 -0500
Content-Disposition: inline
In-Reply-To: <1360839138-16265-1-git-send-email-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Sebastian Andrzej Siewior (bigeasy@linutronix.de) wrote:
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Good catch !

Merged, thanks!

Mathieu

> ---
>  converter/babeltrace.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index fe7d39f..31e3d6e 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -109,7 +109,7 @@ enum {
>   */
>  static struct poptOption long_options[] = {
>  	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
> -	{ "output", 'w', POPT_ARG_STRING, NULL, OPT_NONE, NULL, NULL },
> +	{ "output", 'w', POPT_ARG_STRING, NULL, OPT_OUTPUT_PATH, NULL, NULL },
>  	{ "input-format", 'i', POPT_ARG_STRING, NULL, OPT_INPUT_FORMAT, NULL, NULL },
>  	{ "output-format", 'o', POPT_ARG_STRING, NULL, OPT_OUTPUT_FORMAT, NULL, NULL },
>  	{ "help", 'h', POPT_ARG_NONE, NULL, OPT_HELP, NULL, NULL },
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
