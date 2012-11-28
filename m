From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix a typo in
 lttng-probe-module name
Date: Wed, 28 Nov 2012 12:16:59 -0500
Message-ID: <50B6470B.6010108__18533.3352456384$1354123072$gmane$org@efficios.com>
References: <1354113806-19089-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TdlFu-0003yi-LG
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 12:17:02 -0500
In-Reply-To: <1354113806-19089-1-git-send-email-andrew_gabbasov@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks!

Andrew Gabbasov:
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> ---
>  src/bin/lttng-sessiond/modprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/modprobe.c
> index f38d393..8e5cc94 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -54,7 +54,7 @@ const struct kern_modules_param kern_modules_list[] = {
>  	{ "lttng-probe-kmem", 0 },
>  	{ "lttng-probe-kvm", 0 },
>  	{ "lttng-probe-lock", 0 },
> -	{ "lttng-probe-modules", 0 },
> +	{ "lttng-probe-module", 0 },
>  	{ "lttng-probe-napi", 0 },
>  	{ "lttng-probe-net", 0 },
>  	{ "lttng-probe-power", 0 },
