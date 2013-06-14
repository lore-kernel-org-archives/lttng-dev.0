From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Add --no-as-needed to
	the	demo example's Makefile
Date: Fri, 14 Jun 2013 17:35:13 -0400
Message-ID: <20130614213513.GA32213__32045.9566115916$1371245747$gmane$org@Krystal>
References: <1371245506-4478-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UnbeP-0007W0-A9
	for lttng-dev@lists.lttng.org; Fri, 14 Jun 2013 17:35:17 -0400
Content-Disposition: inline
In-Reply-To: <1371245506-4478-1-git-send-email-jeremie.galarneau@efficios.com>
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
> Some distributions now ship with the --as-needed linker flag
> set by default (Ubuntu 13.04). This will cause the linker to
> remove the references to lttng-ust from the provider objects
> thus causing the application to fail when preloading them.

merged, thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/examples/demo/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> index 27ca92b..d55a1b1 100644
> --- a/doc/examples/demo/Makefile
> +++ b/doc/examples/demo/Makefile
> @@ -43,13 +43,13 @@ tp2.o: tp2.c ust_tests_demo2.h
>  	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  lttng-ust-provider-ust-tests-demo.so: tp.o tp2.o
> -	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
> +	$(CC) -shared -Wl,--no-as-needed -o $@ $(LDFLAGS) -llttng-ust $^
>  =

>  tp3.o: tp3.c ust_tests_demo3.h
>  	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -fpic -c -o $@ $<
>  =

>  lttng-ust-provider-ust-tests-demo3.so: tp3.o
> -	$(CC) -shared -o $@ $(LDFLAGS) -llttng-ust $^
> +	$(CC) -shared -Wl,--no-as-needed -o $@ $(LDFLAGS) -llttng-ust $^
>  =

>  demo.o: demo.c
>  	$(CC) $(CPPFLAGS) $(LOCAL_CPPFLAGS) $(CFLAGS) -c -o $@ $<
> -- =

> 1.8.3
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
