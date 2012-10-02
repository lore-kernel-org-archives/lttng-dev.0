From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Build out of src tree.
Date: Tue, 2 Oct 2012 12:47:33 -0400
Message-ID: <20121002164733.GA5877__24218.643437098$1349196511$gmane$org@Krystal>
References: <1551710.192371349163427925.JavaMail.www@wsfrf1114>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TJ5dB-0003IB-F8
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 12:47:37 -0400
Content-Disposition: inline
In-Reply-To: <1551710.192371349163427925.JavaMail.www@wsfrf1114>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: paul.chavent@fnac.net, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* paul.chavent@fnac.net (paul.chavent@fnac.net) wrote:
> I used to build my packages out of src tree. As it's not
> straightforward for lttng-tools and lttng-ust, i would like to submit
> those two patches.

I just merged your UST patch into master and stable-2.0.

David, I recommend you do the same for the lttng-tools. (please consider
this as my acked-by).

Thanks!

Mathieu

> 
> Regards.
> 
> Paul.
> 

> From dbcdad58a675fb19125411f713700ce633919173 Mon Sep 17 00:00:00 2001
> From: Paul Chavent <paul.chavent@onera.fr>
> Date: Tue, 2 Oct 2012 09:30:31 +0200
> Subject: [PATCH] Build out of src tree.
> 
> ---
>  liblttng-ust-ctl/Makefile.am          |    2 +-
>  liblttng-ust-libc-wrapper/Makefile.am |    2 +-
>  liblttng-ust/Makefile.am              |    2 +-
>  libringbuffer/Makefile.am             |    4 ++--
>  tests/demo/Makefile.am                |    2 +-
>  tests/fork/Makefile.am                |    2 +-
>  tests/hello-static-lib/Makefile.am    |    2 +-
>  tests/hello.cxx/Makefile.am           |    2 +-
>  tests/hello/Makefile.am               |    2 +-
>  tests/ust-basic-tracing/Makefile.am   |    2 +-
>  tests/ust-multi-test/Makefile.am      |    2 +-
>  11 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/liblttng-ust-ctl/Makefile.am b/liblttng-ust-ctl/Makefile.am
> index 4e341be..1a57fef 100644
> --- a/liblttng-ust-ctl/Makefile.am
> +++ b/liblttng-ust-ctl/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/liblttng-ust-comm
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/liblttng-ust-comm -I$(top_builddir)/include
>  AM_CFLAGS = -fno-strict-aliasing
>  
>  lib_LTLIBRARIES = liblttng-ust-ctl.la
> diff --git a/liblttng-ust-libc-wrapper/Makefile.am b/liblttng-ust-libc-wrapper/Makefile.am
> index 5b3f7f0..4fdcedb 100644
> --- a/liblttng-ust-libc-wrapper/Makefile.am
> +++ b/liblttng-ust-libc-wrapper/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
>  AM_CFLAGS = -fno-strict-aliasing
>  
>  lib_LTLIBRARIES = liblttng-ust-libc-wrapper.la
> diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> index aeb5092..dff8b6e 100644
> --- a/liblttng-ust/Makefile.am
> +++ b/liblttng-ust/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
>  AM_CFLAGS = -fno-strict-aliasing
>  
>  noinst_LTLIBRARIES = liblttng-ust-runtime.la liblttng-ust-support.la
> diff --git a/libringbuffer/Makefile.am b/libringbuffer/Makefile.am
> index b5b0ebd..271c8be 100644
> --- a/libringbuffer/Makefile.am
> +++ b/libringbuffer/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
>  AM_CFLAGS = -fno-strict-aliasing
>  
>  noinst_LTLIBRARIES = libringbuffer.la
> @@ -12,7 +12,7 @@ libringbuffer_la_SOURCES = \
>  	backend.h backend_internal.h backend_types.h \
>  	frontend_api.h frontend.h frontend_internal.h frontend_types.h \
>  	nohz.h vatomic.h tlsfixup.h
> -	
> +
>  libringbuffer_la_LIBADD = \
>  	-lpthread \
>  	-lrt
> diff --git a/tests/demo/Makefile.am b/tests/demo/Makefile.am
> index e4570ff..0e43255 100644
> --- a/tests/demo/Makefile.am
> +++ b/tests/demo/Makefile.am
> @@ -1,6 +1,6 @@
>  # -Wsystem-headers is needed to print warnings in the tracepoint
>  # description file.
> -AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  
>  # Set LIBS to nothing so the application does not link on useless
>  # libraries.
> diff --git a/tests/fork/Makefile.am b/tests/fork/Makefile.am
> index 0a649c7..a893366 100644
> --- a/tests/fork/Makefile.am
> +++ b/tests/fork/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = fork fork2
>  fork_SOURCES = fork.c ust_tests_fork.h
> diff --git a/tests/hello-static-lib/Makefile.am b/tests/hello-static-lib/Makefile.am
> index 6633489..6ae9463 100644
> --- a/tests/hello-static-lib/Makefile.am
> +++ b/tests/hello-static-lib/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  
>  noinst_LTLIBRARIES = liblttng-ust-provider-ust-test-hello.la
>  liblttng_ust_provider_ust_test_hello_la_SOURCES = \
> diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefile.am
> index f56f431..4eace0e 100644
> --- a/tests/hello.cxx/Makefile.am
> +++ b/tests/hello.cxx/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = hello
>  hello_SOURCES = hello.cpp tp.c ust_tests_hello.h
> diff --git a/tests/hello/Makefile.am b/tests/hello/Makefile.am
> index 0c4c311..1ee7f8d 100644
> --- a/tests/hello/Makefile.am
> +++ b/tests/hello/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = hello
>  hello_SOURCES = hello.c tp.c ust_tests_hello.h
> diff --git a/tests/ust-basic-tracing/Makefile.am b/tests/ust-basic-tracing/Makefile.am
> index 0a0a2f0..175adc8 100644
> --- a/tests/ust-basic-tracing/Makefile.am
> +++ b/tests/ust-basic-tracing/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/libust
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/libust 
>  
>  noinst_PROGRAMS = ust-basic-tracing
>  ust_basic_tracing_SOURCES = ust-basic-tracing.c
> diff --git a/tests/ust-multi-test/Makefile.am b/tests/ust-multi-test/Makefile.am
> index c1d39d9..69c7cc9 100644
> --- a/tests/ust-multi-test/Makefile.am
> +++ b/tests/ust-multi-test/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/libust
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include -I$(top_srcdir)/libust
>  
>  noinst_PROGRAMS = ust-multi-test
>  ust_multi_test_SOURCES = ust-multi-test.c
> -- 
> 1.7.9.5
> 

> From 3425bde2827d245cb427c989786fdc10bb235b9f Mon Sep 17 00:00:00 2001
> From: Paul Chavent <paul.chavent@onera.fr>
> Date: Tue, 2 Oct 2012 09:30:02 +0200
> Subject: [PATCH] Build out of src tree.
> 
> ---
>  src/bin/lttng-consumerd/Makefile.am    |    2 +-
>  src/bin/lttng-relayd/Makefile.am       |    3 ++-
>  src/bin/lttng-sessiond/Makefile.am     |    5 +++--
>  src/bin/lttng/Makefile.am              |    3 ++-
>  src/common/Makefile.am                 |    2 +-
>  src/common/compat/Makefile.am          |    2 +-
>  src/common/hashtable/Makefile.am       |    2 +-
>  src/common/kernel-consumer/Makefile.am |    2 ++
>  src/common/kernel-ctl/Makefile.am      |    2 +-
>  src/common/relayd/Makefile.am          |    2 ++
>  src/common/sessiond-comm/Makefile.am   |    2 ++
>  src/common/ust-consumer/Makefile.am    |    3 +++
>  src/lib/lttng-ctl/Makefile.am          |    2 ++
>  src/lib/lttng-ctl/filter/Makefile.am   |    2 ++
>  tests/kernel/Makefile.am               |    2 +-
>  tests/tools/Makefile.am                |    2 +-
>  tests/tools/streaming/Makefile.am      |    2 +-
>  tests/ust/Makefile.am                  |    2 +-
>  tests/ust/before-after/Makefile.am     |    2 +-
>  tests/ust/high-throughput/Makefile.am  |    2 +-
>  tests/ust/low-throughput/Makefile.am   |    2 +-
>  tests/ust/multi-session/Makefile.am    |    2 +-
>  tests/ust/nprocesses/Makefile.am       |    2 +-
>  23 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/src/bin/lttng-consumerd/Makefile.am b/src/bin/lttng-consumerd/Makefile.am
> index 89ae059..a395c0b 100644
> --- a/src/bin/lttng-consumerd/Makefile.am
> +++ b/src/bin/lttng-consumerd/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS =
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
>  
>  lttnglibexec_PROGRAMS = lttng-consumerd
>  
> diff --git a/src/bin/lttng-relayd/Makefile.am b/src/bin/lttng-relayd/Makefile.am
> index cb625e5..1f3cde4 100644
> --- a/src/bin/lttng-relayd/Makefile.am
> +++ b/src/bin/lttng-relayd/Makefile.am
> @@ -1,4 +1,5 @@
> -AM_CPPFLAGS = -DINSTALL_BIN_PATH=\""$(lttnglibexecdir)"\" \
> +AM_CPPFLAGS =   -I$(top_srcdir)/include -I$(top_srcdir)/src \
> +		-DINSTALL_BIN_PATH=\""$(lttnglibexecdir)"\" \
>  			  -DINSTALL_LIB_PATH=\""$(libdir)"\"
>  
>  AM_CFLAGS = -fno-strict-aliasing
> diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
> index 73be023..b1859d6 100644
> --- a/src/bin/lttng-sessiond/Makefile.am
> +++ b/src/bin/lttng-sessiond/Makefile.am
> @@ -1,5 +1,6 @@
> -AM_CPPFLAGS = -DINSTALL_BIN_PATH=\""$(lttnglibexecdir)"\" \
> -			  -DINSTALL_LIB_PATH=\""$(libdir)"\"
> +AM_CPPFLAGS =   -I$(top_srcdir)/include -I$(top_srcdir)/src \
> +		-DINSTALL_BIN_PATH=\""$(lttnglibexecdir)"\" \
> +		-DINSTALL_LIB_PATH=\""$(libdir)"\"
>  
>  AM_CFLAGS = -fno-strict-aliasing
>  
> diff --git a/src/bin/lttng/Makefile.am b/src/bin/lttng/Makefile.am
> index 0381aa6..fe7991b 100644
> --- a/src/bin/lttng/Makefile.am
> +++ b/src/bin/lttng/Makefile.am
> @@ -1,4 +1,5 @@
> -AM_CPPFLAGS = -DINSTALL_BIN_PATH=\""$(bindir)"\"
> +AM_CPPFLAGS =     -I$(top_srcdir)/include -I$(top_srcdir)/src \
> +	  	  -DINSTALL_BIN_PATH=\""$(bindir)"\"
>  
>  bin_PROGRAMS = lttng
>  
> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> index ca48153..5850041 100644
> --- a/src/common/Makefile.am
> +++ b/src/common/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS =
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
>  
>  SUBDIRS = compat hashtable kernel-ctl sessiond-comm relayd kernel-consumer ust-consumer
>  
> diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
> index 91cd3bd..2d83282 100644
> --- a/src/common/compat/Makefile.am
> +++ b/src/common/compat/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
>  
>  noinst_LTLIBRARIES = libcompat.la
>  
> diff --git a/src/common/hashtable/Makefile.am b/src/common/hashtable/Makefile.am
> index 7a2b835..62e22c1 100644
> --- a/src/common/hashtable/Makefile.am
> +++ b/src/common/hashtable/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
>  
>  noinst_LTLIBRARIES = libhashtable.la
>  
> diff --git a/src/common/kernel-consumer/Makefile.am b/src/common/kernel-consumer/Makefile.am
> index 008041e..ed5462a 100644
> --- a/src/common/kernel-consumer/Makefile.am
> +++ b/src/common/kernel-consumer/Makefile.am
> @@ -1,3 +1,5 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
> +
>  # Kernel consumer library
>  noinst_LTLIBRARIES = libkernel-consumer.la
>  
> diff --git a/src/common/kernel-ctl/Makefile.am b/src/common/kernel-ctl/Makefile.am
> index a56a021..ab057dd 100644
> --- a/src/common/kernel-ctl/Makefile.am
> +++ b/src/common/kernel-ctl/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
>  
>  noinst_LTLIBRARIES = libkernel-ctl.la
>  
> diff --git a/src/common/relayd/Makefile.am b/src/common/relayd/Makefile.am
> index 84eee1b..274da87 100644
> --- a/src/common/relayd/Makefile.am
> +++ b/src/common/relayd/Makefile.am
> @@ -1,3 +1,5 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
> +
>  # Relayd library
>  noinst_LTLIBRARIES = librelayd.la
>  
> diff --git a/src/common/sessiond-comm/Makefile.am b/src/common/sessiond-comm/Makefile.am
> index 2a70d54..24063f8 100644
> --- a/src/common/sessiond-comm/Makefile.am
> +++ b/src/common/sessiond-comm/Makefile.am
> @@ -1,3 +1,5 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
> +
>  # Session daemon communication lib
>  noinst_LTLIBRARIES = libsessiond-comm.la
>  
> diff --git a/src/common/ust-consumer/Makefile.am b/src/common/ust-consumer/Makefile.am
> index c79c4a5..ab8d38a 100644
> --- a/src/common/ust-consumer/Makefile.am
> +++ b/src/common/ust-consumer/Makefile.am
> @@ -1,4 +1,7 @@
>  if HAVE_LIBLTTNG_UST_CTL
> +
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src
> +
>  noinst_LTLIBRARIES = libust-consumer.la
>  
>  libust_consumer_la_SOURCES = ust-consumer.c ust-consumer.h
> diff --git a/src/lib/lttng-ctl/Makefile.am b/src/lib/lttng-ctl/Makefile.am
> index f1b4b50..2681bdd 100644
> --- a/src/lib/lttng-ctl/Makefile.am
> +++ b/src/lib/lttng-ctl/Makefile.am
> @@ -1,3 +1,5 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(builddir)
> +
>  SUBDIRS = filter
>  
>  lib_LTLIBRARIES = liblttng-ctl.la
> diff --git a/src/lib/lttng-ctl/filter/Makefile.am b/src/lib/lttng-ctl/filter/Makefile.am
> index 45ed418..28ff90a 100644
> --- a/src/lib/lttng-ctl/filter/Makefile.am
> +++ b/src/lib/lttng-ctl/filter/Makefile.am
> @@ -1,3 +1,5 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(srcdir) -I$(builddir) 
> +
>  noinst_PROGRAMS = filter-grammar-test
>  noinst_LTLIBRARIES = libfilter.la
>  noinst_HEADERS = filter-ast.h
> diff --git a/tests/kernel/Makefile.am b/tests/kernel/Makefile.am
> index 2992afb..8872af4 100644
> --- a/tests/kernel/Makefile.am
> +++ b/tests/kernel/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -g -Wall -I../
> +AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -g -Wall
>  AM_LDFLAGS = -lurcu -lurcu-cds
>  
>  EXTRA_DIST = runall.sh run-kernel-tests.sh
> diff --git a/tests/tools/Makefile.am b/tests/tools/Makefile.am
> index 3d25900..c0477e5 100644
> --- a/tests/tools/Makefile.am
> +++ b/tests/tools/Makefile.am
> @@ -1,6 +1,6 @@
>  SUBDIRS = streaming
>  
> -AM_CFLAGS = -g -Wall -I../
> +AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -g -Wall
>  AM_LDFLAGS = -lurcu -lurcu-cds
>  
>  EXTRA_DIST = runall.sh
> diff --git a/tests/tools/streaming/Makefile.am b/tests/tools/streaming/Makefile.am
> index f7a3c9d..3ff8ef0 100644
> --- a/tests/tools/streaming/Makefile.am
> +++ b/tests/tools/streaming/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -I. -O2 -g -I../../
> +AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(top_srcdir)/tests -I$(srcdir) -O2 -g
>  AM_LDFLAGS =
>  
>  if LTTNG_TOOLS_BUILD_WITH_LIBDL
> diff --git a/tests/ust/Makefile.am b/tests/ust/Makefile.am
> index 146bff2..387842d 100644
> --- a/tests/ust/Makefile.am
> +++ b/tests/ust/Makefile.am
> @@ -1,7 +1,7 @@
>  if HAVE_LIBLTTNG_UST_CTL
>  SUBDIRS = nprocesses high-throughput low-throughput before-after multi-session
>  
> -AM_CFLAGS = -g -Wall -I../
> +AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/tests -I$(top_srcdir)/src -g -Wall 
>  AM_LDFLAGS = -lurcu -lurcu-cds
>  
>  EXTRA_DIST = runall.sh run-ust-global-tests.sh
> diff --git a/tests/ust/before-after/Makefile.am b/tests/ust/before-after/Makefile.am
> index 29652dc..d197d72 100644
> --- a/tests/ust/before-after/Makefile.am
> +++ b/tests/ust/before-after/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -I. -O2
> +AM_CFLAGS = -I$(srcdir) -O2
>  AM_LDFLAGS = -llttng-ust
>  
>  if LTTNG_TOOLS_BUILD_WITH_LIBDL
> diff --git a/tests/ust/high-throughput/Makefile.am b/tests/ust/high-throughput/Makefile.am
> index 01d5ad2..cff8fe4 100644
> --- a/tests/ust/high-throughput/Makefile.am
> +++ b/tests/ust/high-throughput/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -I. -O2
> +AM_CFLAGS = -I$(srcdir) -O2
>  AM_LDFLAGS = -llttng-ust
>  
>  if LTTNG_TOOLS_BUILD_WITH_LIBDL
> diff --git a/tests/ust/low-throughput/Makefile.am b/tests/ust/low-throughput/Makefile.am
> index aefdf53..a1df9f5 100644
> --- a/tests/ust/low-throughput/Makefile.am
> +++ b/tests/ust/low-throughput/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -I. -O2
> +AM_CFLAGS = -I$(srcdir) -O2
>  AM_LDFLAGS = -llttng-ust
>  
>  if LTTNG_TOOLS_BUILD_WITH_LIBDL
> diff --git a/tests/ust/multi-session/Makefile.am b/tests/ust/multi-session/Makefile.am
> index 29652dc..d197d72 100644
> --- a/tests/ust/multi-session/Makefile.am
> +++ b/tests/ust/multi-session/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -I. -O2
> +AM_CFLAGS = -I$(srcdir) -O2
>  AM_LDFLAGS = -llttng-ust
>  
>  if LTTNG_TOOLS_BUILD_WITH_LIBDL
> diff --git a/tests/ust/nprocesses/Makefile.am b/tests/ust/nprocesses/Makefile.am
> index d3fdcbd..20beea0 100644
> --- a/tests/ust/nprocesses/Makefile.am
> +++ b/tests/ust/nprocesses/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = -I. -O2
> +AM_CFLAGS = -I$(srcdir) -O2
>  AM_LDFLAGS = -llttng-ust
>  
>  if LTTNG_TOOLS_BUILD_WITH_LIBDL
> -- 
> 1.7.9.5
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
