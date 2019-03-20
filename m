From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] fix: tests: link
 libpause_consumer on liblttng-ctl
Date: Wed, 20 Mar 2019 11:01:04 -0400
Message-ID: <20190320150104.GA8086__29649.1798640758$1553094097$gmane$org@joraj-alpa>
References: <20190319205603.15707-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44PY5n12nhz17Lk
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 11:01:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190319205603.15707-1-mjeanson@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 19, 2019 at 04:56:03PM -0400, Michael Jeanson wrote:
> This preload test library uses symbols from liblttng-ctl which are
> resolved when preloaded by GLIBC but not by MUSL.
> 

Tested-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  tests/regression/tools/notification/Makefile.am | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/regression/tools/notification/Makefile.am b/tests/regression/tools/notification/Makefile.am
> index 33e95886..b869bdb1 100644
> --- a/tests/regression/tools/notification/Makefile.am
> +++ b/tests/regression/tools/notification/Makefile.am
> @@ -20,7 +20,10 @@ FORCE_SHARED_LIB_OPTIONS = -module -shared -avoid-version \
>  			   -rpath $(abs_builddir)
>  
>  libpause_consumer_la_SOURCES = consumer_testpoints.c
> -libpause_consumer_la_LIBADD = $(top_builddir)/src/common/libcommon.la $(DL_LIBS)
> +libpause_consumer_la_LIBADD = \
> +	$(top_builddir)/src/common/libcommon.la \
> +	$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
> +	$(DL_LIBS)
>  libpause_consumer_la_LDFLAGS = $(FORCE_SHARED_LIB_OPTIONS)
>  noinst_LTLIBRARIES = libpause_consumer.la
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan Rajotte-Julien
EfficiOS
