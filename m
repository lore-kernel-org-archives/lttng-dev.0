From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix typo in run script
Date: Sat, 11 May 2013 22:59:54 -0400
Message-ID: <20130512025954.GC405__34100.1505069018$1368327629$gmane$org@Krystal>
References: <1368318712-31852-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UbMVv-0006kj-Vv
	for lttng-dev@lists.lttng.org; Sat, 11 May 2013 22:59:56 -0400
Content-Disposition: inline
In-Reply-To: <1368318712-31852-1-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> The actual library is liblttng-ust-libc-wrapper.so

merged, thanks!

Mathieu

> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  liblttng-ust-libc-wrapper/run | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-libc-wrapper/run b/liblttng-ust-libc-wrapper/run
> index 2583d23..80d4175 100755
> --- a/liblttng-ust-libc-wrapper/run
> +++ b/liblttng-ust-libc-wrapper/run
> @@ -1,3 +1,3 @@
>  #!/bin/sh
>  
> -LD_VERBOSE=1 LD_PRELOAD=.libs/liblttng-ust-libc.so ${*}
> +LD_VERBOSE=1 LD_PRELOAD=.libs/liblttng-ust-libc-wrapper.so ${*}
> -- 
> 1.8.1.2
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
