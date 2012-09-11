From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH/babeltrace] Fix babeltrace-log get big
	line	when the input file last line don't have enter
Date: Tue, 11 Sep 2012 09:29:54 -0400
Message-ID: <20120911132954.GA4710__38212.0154834867$1347370221$gmane$org@Krystal>
References: <CANFwon2S_FHYGeTJ7jS1iHhdiofPEEQihBanAsHGW0d1Tv+sfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBQXL-0008UK-R7
	for lttng-dev@lists.lttng.org; Tue, 11 Sep 2012 09:29:55 -0400
Content-Disposition: inline
In-Reply-To: <CANFwon2S_FHYGeTJ7jS1iHhdiofPEEQihBanAsHGW0d1Tv+sfg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hui Zhu <teawater@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Hui Zhu (teawater@gmail.com) wrote:
> Hi,
> 
> I got:
> [Error] Line too large for packet size (32kB) (discarded)
> When I input a file to babeltrace-log.
> That is because the last line of the input file doesn't have enter and
> "babeltrace-log" have bug with the line that doesn't have enter.
> So I post a patch for it.

Merged, thanks!

Mathieu

> 
> Thanks,
> Hui
> 
> --- a/converter/babeltrace-log.c
> +++ b/converter/babeltrace-log.c
> @@ -240,9 +240,11 @@ void trace_text(FILE *input, int output)
>  		if (len < 0)
>  			break;
>  		nl = strrchr(line, '\n');
> -		if (nl)
> +		if (nl) {
>  			*nl = '\0';
> -		trace_string(line, &pos, nl - line + 1);
> +			trace_string(line, &pos, nl - line + 1);
> +		} else
> +			trace_string(line, &pos, strlen(line) + 1);
>  	}
>  	ctf_fini_pos(&pos);
>  }
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
