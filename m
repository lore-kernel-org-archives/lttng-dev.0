From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Emitting events from shared object constructors
	is	(currently) not possible
Date: Thu, 22 Nov 2012 10:39:01 -0500
Message-ID: <20121122153901.GA14685__424.110159701918$1353598817$gmane$org@Krystal>
References: <50AE31E8.4040507@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TbYro-0005Or-Na
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 10:39:04 -0500
Content-Disposition: inline
In-Reply-To: <50AE31E8.4040507@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> I recently stumbled over the following lttng-ust limitation:
> =

> I tried to emit events from a shared objects constructor function:
> =

> __attribute__((constructor))
> void func_constructor()
> {
>    tracepoint( foo, bar ); =

> }
> =

> Unfortunately this doesn't work because the constructor functions of
> LTTng itself (__tracepoints__init and the ones from
> ust-tracepoint-event.h) are not yet run.
> =

> Trying to solve this problem with explicit constructor priority on my
> side alone doesn't work:
> =

> __attribute__((constructor (1111)))
> void func_constructor()
> {
>    tracepoint( foo, bar ); =

> }
> =

> That's because whatever I specify as priority is irrelevant. LTTng's
> constructors without priority will always come last.
> =

> After also adding priority to the lttng constructor I was able to make
> it work (see patch below):

Hi Paul,

I notice that you probably embed your probes along with your code within
the same shared object/executable, right ?

Unfortunately, this approach does not work if the probes are placed in a
different shared object than the program code. Here is an example:

a.c:

#include <stdio.h>

__attribute__((constructor(998)))
void fcta_prio1(void)
{
	fprintf(stderr, "fcta prio 998\n");
}

__attribute__((constructor))
void fcta(void)
{
	fprintf(stderr, "fcta\n");
}

__attribute__((constructor(1000)))
void fcta_prio2(void)
{
	fprintf(stderr, "fcta prio 1000\n");
}

b.c:
#include <stdio.h>

__attribute__((constructor(999)))
void fctb_prio1(void)
{
	fprintf(stderr, "fctb prio 999\n");
}

__attribute__((constructor))
void fctb(void)
{
	fprintf(stderr, "fctb\n");
}

__attribute__((constructor(1001)))
void fctb_prio2(void)
{
	fprintf(stderr, "fctb prio 1001\n");
}

main.c:

int main()
{
	return 0;
}

Makefile:
all:
	gcc -fPIC -shared -Wl,-soname,liba.so -o liba.so a.c
	gcc -fPIC -shared -Wl,-soname,libb.so -o libb.so b.c
	gcc -o test main.c -L./ -la -lb


exec with:

LD_LIBRARY_PATH=3D. ./test

result:

fctb prio 999
fctb prio 1001
fctb
fcta prio 998
fcta prio 1000
fcta

If we build test2 all within the same executable, then the order is
fine:

gcc -o test2 main.c a.c b.c
./test2
result:
fcta prio 998
fctb prio 999
fcta prio 1000
fctb prio 1001
fcta
fctb

As we can notice, the priority is effective within a shared object, but
has no ordering effect across .so. And having probes in separate .so is
a very typical use case.

One way we could envision allowing tracing of constructors in
applications is to ensure __tracepoints__init, which always resides
within the same object as the traced application code, runs with a
high constructor priorita -- low value -- (for code compiled by
compilers supporting this feature), and allow the application to invoke
the probe constructor early. So the proposed changes would be:

1 - add a constructor priority for
    __tracepoints__init/__tracepoints_destroy in tracepoint.h.
    Use macros to test for gcc version which allow this attribute.
2 - add some API that could let user code call
    __lttng_events_init__PROVIDER_NAME explicitly.
    Add an "already executed" flag to guard
    __lttng_events_init__PROVIDER_NAME.
    This API should still allow to LD_PRELOAD the probes (no dependency
    on the probe symbols, possibly by using dlsym ?)
3 - make lttng_probe_register call lttng_ust_init needed.
    Add an "already executed" flag to guard lttng_ust_init.

Thoughts ?

Thanks,

Mathieu


> =

> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index 8b08914..532f1d2 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -261,7 +261,7 @@ int __tracepoint_registered
>  struct tracepoint_dlopen tracepoint_dlopen
>         __attribute__((weak, visibility("hidden")));
>  =

> -static void lttng_ust_notrace __attribute__((constructor))
> +static void lttng_ust_notrace __attribute__((constructor (1000)))
>  __tracepoints__init(void);
>  static void
>  __tracepoints__init(void)
> @@ -300,7 +300,7 @@ __tracepoints__init(void)
>                                 __start___tracepoints_ptrs);
>  }
>  =

> -static void lttng_ust_notrace __attribute__((destructor))
> +static void lttng_ust_notrace __attribute__((destructor (1000)))
>  __tracepoints__destroy(void);
>  static void
>  __tracepoints__destroy(void)
> diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tra=
cepoint-event.h
> index 74d06e1..7ad3144 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -638,7 +638,7 @@ static struct lttng_probe_desc _TP_COMBINE_TOKENS(__p=
robe_desc___, TRACEPOINT_PR
>  =

>  /* Reset all macros within TRACEPOINT_EVENT */
>  #include <lttng/ust-tracepoint-event-reset.h>
> -static void lttng_ust_notrace __attribute__((constructor))
> +static void lttng_ust_notrace __attribute__((constructor (1000)))
>  _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void);
>  static void
>  _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
> @@ -649,7 +649,7 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_=
PROVIDER)(void)
>         assert(!ret);
>  }
>  =

> -static void lttng_ust_notrace __attribute__((destructor))
> +static void lttng_ust_notrace __attribute__((destructor (1000)))
>  _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void);
>  static void
>  _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)
> =

> =

> =

> -- =

> Paul Woegerer | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
> =

> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
> =

> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
