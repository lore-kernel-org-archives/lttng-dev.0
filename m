From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Remove bashism
	in	lttng-syscalls-generate-headers.sh
Date: Mon, 13 May 2013 11:40:03 -0400
Message-ID: <20130513154002.GA24686__14458.170234184$1368459645$gmane$org@Krystal>
References: <20130513143318.GA18192@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UburB-0007RX-Lt
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 11:40:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id 3257A14186E
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 11:40:07 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id kxyl45c8Fyy7 for <lttng-dev@lists.lttng.org>;
	Mon, 13 May 2013 11:40:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130513143318.GA18192@quintessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jon Bernard (jbernard@tuxion.com) wrote:
> Options to echo are not portable. In particular, the 'echo -e' option is
> implemented by some shells, including bash, to expand escape sequences. However,
> dash is one of the other family of shells that instead expands escape sequences
> by default.

merged into master and stable-2.2 (in preparation for 2.2 final).

Thanks!

Mathieu

> 
> The printf command is portable and much more reliable.
> ---
>  instrumentation/syscalls/lttng-syscalls-generate-headers.sh |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/instrumentation/syscalls/lttng-syscalls-generate-headers.sh b/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
> index 046dc06..1754ae8 100755
> --- a/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
> +++ b/instrumentation/syscalls/lttng-syscalls-generate-headers.sh
> @@ -59,7 +59,7 @@ if [ "$CLASS" = integers ]; then
>  
>  NRARGS=0
>  
> -echo -e \
> +printf \
>  'SC_DECLARE_EVENT_CLASS_NOARGS(syscalls_noargs,\n'\
>  '	TP_STRUCT__entry(),\n'\
>  '	TP_fast_assign(),\n'\
> -- 
> 1.7.10.4
> 
> 
> -- 
> Jon
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
