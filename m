From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] tap-driver.sh: flush stdout after each
 test result
Date: Thu, 14 Mar 2019 11:39:05 -0400 (EDT)
Message-ID: <1355050691.6400.1552577945088.JavaMail.zimbra__16221.1733799026$1552577962$gmane$org@efficios.com>
References: <20190314153539.1196-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44KtDB14YWz15pF
 for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2019 11:39:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B09BEBA6B4
 for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2019 11:39:05 -0400 (EDT)
In-Reply-To: <20190314153539.1196-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into liburcu master branch (only), thanks!

Mathieu

----- On Mar 14, 2019, at 11:35 AM, Michael Jeanson mjeanson@efficios.com wrote:

> This is useful in a CI system where stdout is fully buffered and you
> look at the console output to see which test is hanging.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> config/tap-driver.sh | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/config/tap-driver.sh b/config/tap-driver.sh
> index 4254e2b..12742ca 100755
> --- a/config/tap-driver.sh
> +++ b/config/tap-driver.sh
> @@ -273,6 +273,9 @@ function report(result, details)
>     msg = msg " " details
>   # Output on console might be colorized.
>   print decorate_result(result) msg
> +  # Flush stdout after each test result, this is useful when stdout
> +  # is buffered, for example in a CI system.
> +  fflush()
>   # Log the result in the log file too, to help debugging (this is
>   # especially true when said result is a TAP error or "Bail out!").
>   print result msg | "cat >&3";
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
