From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Fix: typo CPPLAGS in examples Makefile
Date: Mon, 22 Apr 2019 12:11:43 -0400 (EDT)
Message-ID: <1495030212.302.1555949503267.JavaMail.zimbra__12735.8088664309$1555949629$gmane$org@efficios.com>
References: <20190422160404.10274-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44ns5r3LFDz1K8K
 for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2019 12:11:44 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F19F81A278A
 for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2019 12:11:43 -0400 (EDT)
In-Reply-To: <20190422160404.10274-1-mjeanson@efficios.com>
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

Hi,

Merged into master, and backported to 0.10 and 0.9, thanks!

Mathieu

----- On Apr 22, 2019, at 12:04 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Overriding CPPFLAGS throught the environment was ignored for the
> examples.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> doc/examples/Makefile.am | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
> index 3c3d152..edf00eb 100644
> --- a/doc/examples/Makefile.am
> +++ b/doc/examples/Makefile.am
> @@ -141,7 +141,7 @@ all-local:
> 	else \
> 		rel_build_subdir="../"; \
> 	fi; \
> -	$(MAKE) -f dist-files/Makefile CC="$(CC)" CPPFLAGS="$(CPPLAGS)"
> AM_CPPFLAGS="$(AM_CPPFLAGS) -I"$${rel_src_subdir}/$(top_srcdir)/include/"
> -I"$${rel_src_subdir}/$(top_srcdir)/src/"
> -I"$${rel_build_subdir}$(top_builddir)/include/"
> -I"$${rel_build_subdir}$(top_builddir)/include/src/"" CFLAGS="$(CFLAGS)"
> AM_CFLAGS="$(AM_CFLAGS)" LDFLAGS="$(LDFLAGS)" AM_LDFLAGS="$(AM_LDFLAGS)
> -L../../../src/.libs/ -Wl,-rpath "$(PWD)/../../src/.libs/"" AM_V_P="$(AM_V_P)"
> AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all;
> +	$(MAKE) -f dist-files/Makefile CC="$(CC)" CPPFLAGS="$(CPPFLAGS)"
> AM_CPPFLAGS="$(AM_CPPFLAGS) -I"$${rel_src_subdir}/$(top_srcdir)/include/"
> -I"$${rel_src_subdir}/$(top_srcdir)/src/"
> -I"$${rel_build_subdir}$(top_builddir)/include/"
> -I"$${rel_build_subdir}$(top_builddir)/include/src/"" CFLAGS="$(CFLAGS)"
> AM_CFLAGS="$(AM_CFLAGS)" LDFLAGS="$(LDFLAGS)" AM_LDFLAGS="$(AM_LDFLAGS)
> -L../../../src/.libs/ -Wl,-rpath "$(PWD)/../../src/.libs/"" AM_V_P="$(AM_V_P)"
> AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all;
> 
> clean-local:
> 	$(AM_V_at)$(MAKE) -f dist-files/Makefile $(AM_MAKEFLAGS) clean; \
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
