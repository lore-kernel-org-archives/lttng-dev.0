From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] fix: tests: link
 libpause_consumer on liblttng-ctl
Date: Fri, 29 Mar 2019 14:18:18 -0400
Message-ID: <20190329181817.GC28162__22011.8295912229$1553883516$gmane$org@gmail.com>
References: <20190319205603.15707-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44W9324SMKz1KYQ
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 14:18:22 -0400 (EDT)
Received: by mail-qk1-f196.google.com with SMTP id g1so1936593qki.5
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:18:22 -0700 (PDT)
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

Merged in master, stable-2.11, and stable-2.10.

Thanks!
J=E9r=E9mie

On Tue, Mar 19, 2019 at 04:56:03PM -0400, Michael Jeanson wrote:
> This preload test library uses symbols from liblttng-ctl which are
> resolved when preloaded by GLIBC but not by MUSL.
> =

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  tests/regression/tools/notification/Makefile.am | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/tests/regression/tools/notification/Makefile.am b/tests/regr=
ession/tools/notification/Makefile.am
> index 33e95886..b869bdb1 100644
> --- a/tests/regression/tools/notification/Makefile.am
> +++ b/tests/regression/tools/notification/Makefile.am
> @@ -20,7 +20,10 @@ FORCE_SHARED_LIB_OPTIONS =3D -module -shared -avoid-ve=
rsion \
>  			   -rpath $(abs_builddir)
>  =

>  libpause_consumer_la_SOURCES =3D consumer_testpoints.c
> -libpause_consumer_la_LIBADD =3D $(top_builddir)/src/common/libcommon.la =
$(DL_LIBS)
> +libpause_consumer_la_LIBADD =3D \
> +	$(top_builddir)/src/common/libcommon.la \
> +	$(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
> +	$(DL_LIBS)
>  libpause_consumer_la_LDFLAGS =3D $(FORCE_SHARED_LIB_OPTIONS)
>  noinst_LTLIBRARIES =3D libpause_consumer.la
>  =

> -- =

> 2.17.1
> =
