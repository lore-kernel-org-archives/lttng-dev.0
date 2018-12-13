From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add hello-many to gitignore
Date: Wed, 12 Dec 2018 20:53:56 -0500 (EST)
Message-ID: <1326793239.3555.1544666036023.JavaMail.zimbra__37921.7615271502$1544665918$gmane$org@efficios.com>
References: <20181212214128.31193-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43FcD44kQMz1614
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 20:53:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 676EEA3240
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 20:53:56 -0500 (EST)
In-Reply-To: <20181212214128.31193-1-mjeanson@efficios.com>
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

Merged, thanks!

Mathieu

----- On Dec 12, 2018, at 4:41 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> .gitignore | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 11cf3343..482c6520 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -66,6 +66,7 @@ doc/man/tracef.3
> doc/man/tracelog.3
> 
> tests/hello/hello
> +tests/hello-many/hello-many
> tests/hello.cxx/hello
> tests/same_line_tracepoint/same_line_tracepoint
> tests/ust-basic-tracing/ust-basic-tracing
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
