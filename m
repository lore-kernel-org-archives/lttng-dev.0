From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH] Remove -pie flag for shared library
Date: Tue, 14 May 2013 17:05:59 -0400
Message-ID: <CAFXXi0=oySpm0iqkVD0j05z-aFmvNDmSC3HNwBpKCPnSn_M6pw__39891.0549622544$1368565636$gmane$org@mail.gmail.com>
References: <1368562532-19566-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UcMQd-0005X0-DZ
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 17:06:35 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so2129769iec.34
	for <lttng-dev@lists.lttng.org>; Tue, 14 May 2013 14:06:29 -0700 (PDT)
In-Reply-To: <1368562532-19566-1-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thank you Francis.

I tested your patch locally and it works, so I included it in the
packaging on Launchpad so that the package builds for now. However, it
would be preferable if the problem could be addressed more gracefully
upstream.

Simon

On 14 May 2013 16:15, Francis Giraldeau <francis.giraldeau@gmail.com> wrote:
> Some build environment with hardening enabled adds -pie flags to LDFLAGS. While
> it's required for ELF binaries, it doesn't make sens for shared libraries. For
> this case, filter-out the erroneous option.
>
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  doc/examples/demo/Makefile     | 6 ++++--
>  doc/examples/easy-ust/Makefile | 4 +++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> index bbc8ccb..3145146 100644
> --- a/doc/examples/demo/Makefile
> +++ b/doc/examples/demo/Makefile
> @@ -34,6 +34,8 @@ EMPTY_AUTOMAKE_TARGETS = distdir install install-data install-exec uninstall \
>  $(EMPTY_AUTOMAKE_TARGETS):
>  endif
>
> +CLEAN_LDFLAGS = $(filter-out -pie,$(LDFLAGS))
> +
>  all: demo lttng-ust-provider-ust-tests-demo.so lttng-ust-provider-ust-tests-demo3.so
>
>  tp.o: tp.c ust_tests_demo.h
> @@ -43,13 +45,13 @@ tp2.o: tp2.c ust_tests_demo2.h
>         $(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>
>  lttng-ust-provider-ust-tests-demo.so: tp.o tp2.o
> -       $(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
> +       $(CC) -shared -o $@ $(CLEAN_LDFLAGS) -llttng-ust $^
>
>  tp3.o: tp3.c ust_tests_demo3.h
>         $(CC) $(CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>
>  lttng-ust-provider-ust-tests-demo3.so: tp3.o
> -       $(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
> +       $(CC) -shared -o $@ $(CLEAN_LDFLAGS) -llttng-ust $^
>
>  demo.o: demo.c
>         $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> diff --git a/doc/examples/easy-ust/Makefile b/doc/examples/easy-ust/Makefile
> index e20e53a..e95a2c5 100644
> --- a/doc/examples/easy-ust/Makefile
> +++ b/doc/examples/easy-ust/Makefile
> @@ -36,10 +36,12 @@ EMPTY_AUTOMAKE_TARGETS = distdir install install-data install-exec uninstall \
>  $(EMPTY_AUTOMAKE_TARGETS):
>  endif
>
> +CLEAN_LDFLAGS = $(filter-out -pie,$(LDFLAGS))
> +
>  all: sample
>
>  sample: sample.o tp.o
> -       $(CC) -o $@ $^ $(LDFLAGS) $(LIBS)
> +       $(CC) -o $@ $^ $(CLEAN_LDFLAGS) $(LIBS)
>
>  sample.o: sample.c sample_component_provider.h
>         $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> --
> 1.8.1.2
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
