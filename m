From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Unit tests: don't rebuild
 units under test
Date: Thu, 02 May 2013 11:25:08 -0400
Message-ID: <51828554.1080001__30260.4561126374$1367508352$gmane$org@efficios.com>
References: <1365434404-11002-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UXvNk-00043h-23
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 11:25:16 -0400
In-Reply-To: <1365434404-11002-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks!

Simon Marchi:
> Only the tests themselves are built in the unit test folder. They reuse
> the object files that are already built during the main compilation
> pass. This would fix the conflicts between object names.
> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  tests/unit/Makefile.am |   55 +++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
> index c9e1bfc..67e7fe4 100644
> --- a/tests/unit/Makefile.am
> +++ b/tests/unit/Makefile.am
> @@ -25,44 +25,47 @@ test_uri_SOURCES = test_uri.c
>  test_uri_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBHASHTABLE)
>  
>  # Session unit test
> -SESSIONS=$(top_srcdir)/src/bin/lttng-sessiond/session.c	\
> -	 $(top_srcdir)/src/bin/lttng-sessiond/consumer.c \
> -	 $(top_srcdir)/src/bin/lttng-sessiond/health.c \
> -	 $(top_srcdir)/src/common/uri.c \
> -	 $(top_srcdir)/src/common/utils.c \
> -	 $(top_srcdir)/src/common/error.c
> +SESSIONS=$(top_srcdir)/src/bin/lttng-sessiond/session.o	\
> +	 $(top_srcdir)/src/bin/lttng-sessiond/consumer.o \
> +	 $(top_srcdir)/src/bin/lttng-sessiond/health.o \
> +	 $(top_srcdir)/src/common/uri.o \
> +	 $(top_srcdir)/src/common/utils.o \
> +	 $(top_srcdir)/src/common/error.o
>  
> -test_session_SOURCES = test_session.c $(SESSIONS)
> +test_session_SOURCES = test_session.c
>  test_session_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
>  					 -lrt
> +test_session_LDADD += $(SESSIONS)
>  
>  # UST data structures unit test
>  if HAVE_LIBLTTNG_UST_CTL
> -UST_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-ust.c \
> -	       $(top_srcdir)/src/bin/lttng-sessiond/consumer.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/buffer-registry.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/ust-registry.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/ust-metadata.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/ust-app.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/ust-consumer.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/fd-limit.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/health.c \
> -		   $(top_srcdir)/src/bin/lttng-sessiond/session.c \
> -		   $(top_srcdir)/src/common/uri.c \
> -		   $(top_srcdir)/src/common/utils.c
> +UST_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-ust.o \
> +	       $(top_srcdir)/src/bin/lttng-sessiond/consumer.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/buffer-registry.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/ust-registry.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/ust-metadata.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/ust-app.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/ust-consumer.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/fd-limit.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/health.o \
> +		   $(top_srcdir)/src/bin/lttng-sessiond/session.o \
> +		   $(top_srcdir)/src/common/uri.o \
> +		   $(top_srcdir)/src/common/utils.o
>  
> -test_ust_data_SOURCES = test_ust_data.c $(UST_DATA_TRACE)
> +test_ust_data_SOURCES = test_ust_data.c
>  test_ust_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
>  					  -lrt -llttng-ust-ctl
> +test_ust_data_LDADD += $(UST_DATA_TRACE)
>  endif
>  
>  # Kernel data structures unit test
> -KERN_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-kernel.c	\
> -		$(top_srcdir)/src/bin/lttng-sessiond/consumer.c	\
> -		$(top_srcdir)/src/bin/lttng-sessiond/health.c \
> -		$(top_srcdir)/src/common/uri.c \
> -		$(top_srcdir)/src/common/utils.c
> +KERN_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-kernel.o	\
> +		$(top_srcdir)/src/bin/lttng-sessiond/consumer.o	\
> +		$(top_srcdir)/src/bin/lttng-sessiond/health.o \
> +		$(top_srcdir)/src/common/uri.o \
> +		$(top_srcdir)/src/common/utils.o
>  
> -test_kernel_data_SOURCES = test_kernel_data.c $(KERN_DATA_TRACE)
> +test_kernel_data_SOURCES = test_kernel_data.c
>  test_kernel_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
>  						 -lrt
> +test_kernel_data_LDADD += $(KERN_DATA_TRACE)
