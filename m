From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust v2] Move include directive
	from	CFLAGS to LOCAL_CPPFLAGS in examples' Makefiles
Date: Thu, 30 May 2013 10:33:47 -0400
Message-ID: <20130530143347.GA23831__43244.912804994$1369924462$gmane$org@Krystal>
References: <1369771309-1773-1-git-send-email-jeremie.galarneau@efficios.com>
	<1369779558-20747-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ui3vJ-0003tu-Hs
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 10:33:49 -0400
Content-Disposition: inline
In-Reply-To: <1369779558-20747-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> The use of LOCAL_* flags and override directives ensures that the build
> succeeds even if the user explicitly overrides CFLAGS/CPPFLAGS/LDFLAGS.

merged into master and stable-2.2.

Thanks!

Mathieu

> =

> Fixes #537
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/examples/demo/Makefile             | 14 +++++++-------
>  doc/examples/easy-ust/Makefile         | 10 +++++-----
>  doc/examples/hello-static-lib/Makefile | 10 +++++-----
>  3 files changed, 17 insertions(+), 17 deletions(-)
> =

> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> index bbc8ccb..27ca92b 100644
> --- a/doc/examples/demo/Makefile
> +++ b/doc/examples/demo/Makefile
> @@ -15,14 +15,14 @@
>  CC =3D gcc
>  LIBS =3D -ldl	# On Linux
>  #LIBS =3D -lc	# On BSD
> -CFLAGS +=3D -I.
> +LOCAL_CPPFLAGS +=3D -I.
>  =

>  # Only necessary when building from the source tree and lttng-ust is not
>  # installed
>  ifdef BUILD_EXAMPLES_FROM_TREE
> -CFLAGS +=3D -I../../../include/
> +LOCAL_CPPFLAGS +=3D -I../../../include/
>  LIBLTTNG_UST_PATH =3D ../../../liblttng-ust/.libs/
> -LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LIBLTTNG_US=
T_PATH)'
> +override LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LI=
BLTTNG_UST_PATH)'
>  =

>  # Third-party Makefiles have to define these targets to integrate with an
>  # automake project
> @@ -37,22 +37,22 @@ endif
>  all: demo lttng-ust-provider-ust-tests-demo.so lttng-ust-provider-ust-te=
sts-demo3.so
>  =

>  tp.o: tp.c ust_tests_demo.h
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  tp2.o: tp2.c ust_tests_demo2.h
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  lttng-ust-provider-ust-tests-demo.so: tp.o tp2.o
>  	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
>  =

>  tp3.o: tp3.c ust_tests_demo3.h
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  lttng-ust-provider-ust-tests-demo3.so: tp3.o
>  	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
>  =

>  demo.o: demo.c
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -c -o $@ $<
>  =

>  demo: demo.o
>  	$(CC) -o $@ $^ $(LIBS)
> diff --git a/doc/examples/easy-ust/Makefile b/doc/examples/easy-ust/Makef=
ile
> index e20e53a..e3546e1 100644
> --- a/doc/examples/easy-ust/Makefile
> +++ b/doc/examples/easy-ust/Makefile
> @@ -17,14 +17,14 @@
>  CC =3D gcc
>  LIBS =3D -ldl -llttng-ust		# On Linux
>  #LIBS =3D -lc -llttng-ust		# On BSD
> -CFLAGS +=3D -I.
> +LOCAL_CPPFLAGS +=3D -I.
>  =

>  # Only necessary when building from the source tree and lttng-ust is not
>  # installed
>  ifdef BUILD_EXAMPLES_FROM_TREE
> -CFLAGS +=3D -I../../../include/
> +LOCAL_CPPFLAGS +=3D -I../../../include/
>  LIBLTTNG_UST_PATH =3D ../../../liblttng-ust/.libs/
> -LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LIBLTTNG_US=
T_PATH)'
> +override LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LI=
BLTTNG_UST_PATH)'
>  =

>  # Third-party Makefiles have to define these targets to integrate with an
>  # automake project
> @@ -42,10 +42,10 @@ sample: sample.o tp.o
>  	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)
>  =

>  sample.o: sample.c sample_component_provider.h
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -c -o $@ $<
>  =

>  tp.o: tp.c sample_component_provider.h
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -c -o $@ $<
>  =

>  html: sample_component_provider.html sample.html tp.html
>  =

> diff --git a/doc/examples/hello-static-lib/Makefile b/doc/examples/hello-=
static-lib/Makefile
> index dd246f7..85c64c1 100644
> --- a/doc/examples/hello-static-lib/Makefile
> +++ b/doc/examples/hello-static-lib/Makefile
> @@ -13,16 +13,16 @@
>  # a program with tracepoint provider probes compiled as static libraries.
>  =

>  CC =3D gcc
> -CFLAGS +=3D -I.
> +LOCAL_CPPFLAGS +=3D -I.
>  LIBS =3D -ldl -llttng-ust	# On Linux
>  #LIBS =3D -lc -llttng-ust	# On BSD
>  =

>  # Only necessary when building from the source tree and lttng-ust is not
>  # installed
>  ifdef BUILD_EXAMPLES_FROM_TREE
> -CFLAGS +=3D -I../../../include/
> +LOCAL_CPPFLAGS +=3D -I../../../include/
>  LIBLTTNG_UST_PATH =3D ../../../liblttng-ust/.libs/
> -LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LIBLTTNG_US=
T_PATH)'
> +override LDFLAGS +=3D -L$(LIBLTTNG_UST_PATH) -Wl,-rpath=3D'$$ORIGIN/$(LI=
BLTTNG_UST_PATH)'
>  =

>  # Third-party Makefiles have to define these targets to integrate with an
>  # automake project
> @@ -37,13 +37,13 @@ endif
>  all: hello
>  =

>  lttng-ust-provider-hello.o: tp.c ust_tests_hello.h
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -c -o $@ $<
>  =

>  lttng-ust-provider-hello.a: lttng-ust-provider-hello.o
>  	ar -rc $@ $^
>  =

>  hello.o: hello.c
> -	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> +	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -c -o $@ $<
>  =

>  hello: hello.o lttng-ust-provider-hello.a
>  	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
> -- =

> 1.8.2.3
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
