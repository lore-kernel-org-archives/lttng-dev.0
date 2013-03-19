From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Remove mention of locking
	issues	associated with dlopen usage
Date: Tue, 19 Mar 2013 16:45:13 -0400
Message-ID: <20130319204513.GA3261__33395.1025073931$1363725960$gmane$org@Krystal>
References: <1363725593-8202-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UI3PH-0000RO-7J
	for lttng-dev@lists.lttng.org; Tue, 19 Mar 2013 16:45:15 -0400
Content-Disposition: inline
In-Reply-To: <1363725593-8202-1-git-send-email-jeremie.galarneau@efficios.com>
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
> This notice has been removed from the README as part of revision b834dead.
> =

> Add a warning relating to dlclose() usage detailed in issue 447 in both t=
he
> man page and the README file.

merged into master and stable-2.1, thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  README              |  6 +++++-
>  doc/man/lttng-ust.3 | 14 +++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> =

> diff --git a/README b/README
> index 55c72df..390a719 100644
> --- a/README
> +++ b/README
> @@ -75,7 +75,7 @@ USAGE:
>      - Include the tracepoint provider header into all C files using
>        the provider.
>      - Example:
> -        tests/hello/  hello.c tp.c ust_tests_hello.h Makefile.example.*
> +      - tests/hello/  hello.c tp.c ust_tests_hello.h Makefile.example.*
>  =

>    2) Compile the Tracepoint Provider separately from the application,
>       using dynamic linking:
> @@ -97,6 +97,10 @@ USAGE:
>  =

>    - Enable instrumentation and control tracing with the "lttng" command
>      from lttng-tools. See lttng-tools doc/quickstart.txt.
> +  - Note about dlclose() usage: it is not safe to use dlclose on a
> +    provider shared object that is being actively used for tracing due
> +    to a lack of reference counting from lttng-ust to the used shared
> +    object.
>  =

>  ENVIRONMENT VARIABLES:
>  =

> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index 08927c6..7cc3bfd 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -265,7 +265,7 @@ carefully:
>      - Include the tracepoint provider header into all C files using
>        the provider.
>      - Example:
> -        tests/hello/  hello.c tp.c ust_tests_hello.h Makefile.example
> +      - tests/hello/  hello.c tp.c ust_tests_hello.h Makefile.example
>  =

>    2) Compile the Tracepoint Provider separately from the application,
>       using dynamic linking:
> @@ -280,15 +280,15 @@ carefully:
>      - Link application with "\-ldl".
>      - Set a LD_PRELOAD environment to preload the tracepoint provider
>        shared object before starting the application when tracing is
> -      needed.
> +      needed. Another way is to dlopen the tracepoint probe when needed
> +      by the application.
>      - Example:
>        - tests/demo/   demo.c  tp*.c ust_tests_demo*.h demo-trace
>  =

> -  - Note about dlopen() usage: due to locking side-effects due to the
> -    way libc lazily resolves Thread-Local Storage (TLS) symbols when a
> -    library is dlopen'd, linking the tracepoint probe or liblttng-ust
> -    with dlopen() is discouraged. They should be linked with the
> -    application using "\-llibname" or loaded with LD_PRELOAD.
> +  - Note about dlclose() usage: it is not safe to use dlclose on a
> +    provider shared object that is being actively used for tracing due
> +    to a lack of reference counting from lttng-ust to the used shared
> +    object.
>    - Enable instrumentation and control tracing with the "lttng" command
>      from lttng-tools. See lttng-tools doc/quickstart.txt.
>    - Note for C++ support: although an application instrumented with
> -- =

> 1.8.1.5
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
