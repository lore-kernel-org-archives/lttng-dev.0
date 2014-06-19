From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Add vpid,
 vppid and vtid explanation in add-context help menu
Date: Thu, 19 Jun 2014 12:36:19 +0000 (UTC)
Message-ID: <516547238.2329.1403181379160.JavaMail.zimbra__1115.74490224502$1403181431$gmane$org@efficios.com>
References: <1403144380-26702-1-git-send-email-francis.deslauriers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WxbZl-0007nl-JS
 for lttng-dev@lists.lttng.org; Thu, 19 Jun 2014 08:36:26 -0400
In-Reply-To: <1403144380-26702-1-git-send-email-francis.deslauriers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: francis deslauriers <francis.deslauriers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "francis deslauriers" <francis.deslauriers@efficios.com>
> To: lttng-dev@lists.lttng.org, "francis deslauriers" <francis.deslauriers@efficios.com>
> Sent: Wednesday, June 18, 2014 10:19:40 PM
> Subject: [lttng-dev] [PATCH lttng-tools] Add vpid,	vppid and vtid explanation in add-context help menu
> 
> From: Francis Deslauriers <francis.deslauriers@efficios.com>
> 
> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> ---
>  src/bin/lttng/commands/add_context.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/bin/lttng/commands/add_context.c
> b/src/bin/lttng/commands/add_context.c
> index 405b782..52d0db4 100644
> --- a/src/bin/lttng/commands/add_context.c
> +++ b/src/bin/lttng/commands/add_context.c
> @@ -514,6 +514,9 @@ static void usage(FILE *ofp)
>  	fprintf(ofp, "                           TYPE can be one of the strings
>  	below:\n");
>  	print_ctx_type(ofp);
>  	fprintf(ofp, "\n");
> +	fprintf(ofp, "Note that the vpid, vppid and vtid context types represent
> the virtual process id,\n"
> +			"virtual parent process id and virtual thread id as seen from the current
> execution context\n"
> +			"as oppose to the pid, ppid and tid that are kernel internal data
> structures.\n\n");

oppose -> opposed

that are -> which are

Other than that,

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


>  	fprintf(ofp, "Example:\n");
>  	fprintf(ofp, "This command will add the context information 'prio' and two
>  	per-cpu\n"
>  			"perf counters (hardware branch misses and cache misses), to all
>  			channels\n"
> --
> 1.8.3.2
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
