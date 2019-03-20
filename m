From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Report perf integration status at
 configure
Date: Wed, 20 Mar 2019 17:14:52 -0400 (EDT)
Message-ID: <1037312465.4677.1553116492524.JavaMail.zimbra__37955.2694432036$1553116518$gmane$org@efficios.com>
References: <20190320210225.19141-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44PjNw0F44z181d
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 17:14:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id CC9D11CB16E
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 17:14:54 -0400 (EDT)
In-Reply-To: <20190320210225.19141-1-mjeanson@efficios.com>
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

Merged into master, thanks!

Mathieu

----- On Mar 20, 2019, at 5:02 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> configure.ac | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 9ab76501..3e443132 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -615,6 +615,9 @@ PPRINT_PROP_BOOL_CUSTOM([JNI interface (JNI)], $value, [use
> --enable-jni-interfa
> test "x$python_agent" = xyes && value=1 || value=0
> PPRINT_PROP_BOOL_CUSTOM([Python agent], $value, [use --enable-python-agent])
> 
> +test "x$have_perf_event" = "xyes" && value=1 || value=0
> +PPRINT_PROP_BOOL_CUSTOM([Perf event integration], $value)
> +
> test "x$enable_numa" = xyes && value=1 || value=0
> PPRINT_PROP_BOOL([NUMA], $value)
> 
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
