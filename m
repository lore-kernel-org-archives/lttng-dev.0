From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Fix: examples silent rules on Solaris
Date: Wed, 12 Dec 2018 20:52:42 -0500 (EST)
Message-ID: <1077255916.3540.1544665962357.JavaMail.zimbra__3626.48745435781$1544665844$gmane$org@efficios.com>
References: <20181212203059.27482-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43FcBf5g8Rz1609
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 20:52:42 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B60A6A3186
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 20:52:42 -0500 (EST)
In-Reply-To: <20181212203059.27482-1-mjeanson@efficios.com>
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

----- On Dec 12, 2018, at 3:30 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> doc/examples/Makefile.examples.template | 6 ++++--
> doc/examples/dist-files/Makefile        | 2 +-
> doc/examples/hlist/Makefile             | 2 +-
> doc/examples/wfcqueue/Makefile          | 2 +-
> 4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/examples/Makefile.examples.template
> b/doc/examples/Makefile.examples.template
> index 238a5cc..e6196f5 100644
> --- a/doc/examples/Makefile.examples.template
> +++ b/doc/examples/Makefile.examples.template
> @@ -17,12 +17,14 @@ AM_V_P := :
> all: $(BINARY)
> 
> $(BINARY): $(OBJECTS)
> -	@if $(AM_V_P); then set -x; else echo "  CCLD     $@"; fi; \
> +	@verbose="$(AM_V_P)"; if [ "x$$verbose" = "x" ]; then verbose=":"; fi; \
> +		if $$verbose; then set -x; else echo "  CCLD     $@"; fi; \
> 		$(CC) $(LOCAL_CFLAGS) $(AM_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) \
> 		-o $@ $(OBJECTS) $(LIBS)
> 
> $(OBJECTS): $(SOURCES) $(DEPS)
> -	@if $(AM_V_P); then set -x; else echo "  CC       $@"; fi; \
> +	@verbose="$(AM_V_P)"; if [ "x$$verbose" = "x" ]; then verbose=":"; fi; \
> +		if $$verbose; then set -x; else echo "  CC       $@"; fi; \
> 		$(CC) $(LOCAL_CFLAGS) $(AM_CFLAGS) $(CFLAGS) $(AM_CPPFLAGS) $(CPPFLAGS) \
> 		-c -o $@ $(SOURCES)
> 
> diff --git a/doc/examples/dist-files/Makefile b/doc/examples/dist-files/Makefile
> index 08b7dcb..08f3728 100644
> --- a/doc/examples/dist-files/Makefile
> +++ b/doc/examples/dist-files/Makefile
> @@ -1,4 +1,4 @@
> -# Copyright (C) 2013  Mathieu Desnoyers
> <mathieu.desnoyers$(AM_V_at)efficios.com>
> +# Copyright (C) 2013  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> #
> # THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
> # OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
> diff --git a/doc/examples/hlist/Makefile b/doc/examples/hlist/Makefile
> index 57197a2..4256035 100644
> --- a/doc/examples/hlist/Makefile
> +++ b/doc/examples/hlist/Makefile
> @@ -1,4 +1,4 @@
> -# Copyright (C) 2013  Mathieu Desnoyers
> <mathieu.desnoyers$(AM_V_at)efficios.com>
> +# Copyright (C) 2013  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> #
> # THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
> # OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
> diff --git a/doc/examples/wfcqueue/Makefile b/doc/examples/wfcqueue/Makefile
> index d1a5a2d..4f0338e 100644
> --- a/doc/examples/wfcqueue/Makefile
> +++ b/doc/examples/wfcqueue/Makefile
> @@ -1,4 +1,4 @@
> -# Copyright (C) 2013  Mathieu Desnoyers
> <mathieu.desnoyers$(AM_V_at)efficios.com>
> +# Copyright (C) 2013  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> #
> # THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
> # OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
