From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
	realloc.
Date: Mon, 29 Jul 2013 19:19:41 -0400
Message-ID: <CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw__24834.3311869123$1375140053$gmane$org@mail.gmail.com>
References: <51F3585E.20705@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f173.google.com ([74.125.82.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V3wjD-0001Hh-Up
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 19:19:54 -0400
Received: by mail-we0-f173.google.com with SMTP id x55so4572423wes.32
	for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2013 16:19:41 -0700 (PDT)
In-Reply-To: <51F3585E.20705@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Stefan,

I'm inlining your patch to make the review easier, see the following remark=
s.

> From 78696689a46c13cdd2625c59348cbb1c03a32b0e Mon Sep 17 00:00:00 2001
> From: Stefan Seefeld <stefan_seefeld@mentor.com>
> Date: Sat, 27 Jul 2013 01:10:23 -0400
> Subject: [PATCH] Add trace support for calloc and realloc.
>
> Signed-off-by: Stefan Seefeld <stefan_seefeld@mentor.com>
> ---
>  liblttng-ust-libc-wrapper/lttng-ust-malloc.c | 68 ++++++++++++++++++++++=
++++++
>  liblttng-ust-libc-wrapper/ust_libc.h         | 18 ++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c b/liblttng-ust-=
libc-wrapper/lttng-ust-malloc.c
> index 3212ff0..772663a 100644
> --- a/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> +++ b/liblttng-ust-libc-wrapper/lttng-ust-malloc.c
> @@ -57,3 +57,71 @@ void free(void *ptr)
>  	tracepoint(ust_libc, free, ptr);
>  	plibc_free(ptr);
>  }
> +
> +/*
> +   The following 'dummy' variables and functions are needed
> +   to break out of an endless recursion:
> +   dlsym itself appears to call calloc, so we need to provide
> +   an implementation for the very first call to calloc to use.
> +*/

Use a "*" on each line of the comment block; see the licence header
for reference.

> +
> +#define DUMMY_HEAP_SIZE 1024
> +static char dummy_heap[DUMMY_HEAP_SIZE] =3D {0};
> +static int dummy_end_of_heap =3D 0;

No need to initialize these static variables to zero, it's already
guaranteed by the C standard. These variables and definition should be
placed after the includes and before any function.

> +
> +static void *dummy_malloc(size_t size)
> +{
> +    if(size =3D=3D 0)
> +	return NULL;
> +
> +    size_t dummy_end_of_heap_reserved =3D dummy_end_of_heap + size;
> +    if(dummy_end_of_heap_reserved >=3D DUMMY_HEAP_SIZE)
> +	return NULL;
> +

Applies to the whole patch: put braces around conditional blocks, even
if they only contain one statement. Also, please indent with tabs and
not spaces.

> +    void *loc =3D (void*) &dummy_heap[dummy_end_of_heap];
> +    dummy_end_of_heap =3D dummy_end_of_heap_reserved;
> +    return loc;
> +};
> +
> +static void *dummy_calloc(size_t nmemb, size_t size)
> +{
> +  return dummy_malloc(nmemb * size);
> +}
> +
> +void *calloc(size_t nmemb, size_t size)
> +{
> +        static void *(* volatile plibc_calloc)(size_t nmemb, size_t size=
) =3D NULL;
> +	void *retval;
> +
> +	if (plibc_calloc =3D=3D NULL) {
> +	        /* Temporarily redirect to dummy_calloc,
> +		   until the dlsym lookup has completed. */
> +                plibc_calloc =3D dummy_calloc;

I'm not a fan of this approach although it was recommended on the
libc-help mailing list.
http://sourceware.org/ml/libc-help/2008-11/msg00000.html

Looking at the Glibc code, it appears dlsym() will cause the
allocation of a dl_action_result structure for each calling thread,
which will then be free'd when these threads terminate. I'm afraid
your dummy_calloc() may cause a crash on exit when free() is called on
the pointer to a static buffer it returns.

I may be missing something, but since this structure is allocated only
once per thread, subsequent calls from the same thread to dlsym()
should not result in another call to calloc(). That should make it
possible to call malloc() in dummy_calloc() without causing the
recursion.

Perhaps we could also forego this mechanism completely and initialize
the symbols from a constructor since this library is meant to be
LD_PRELOAD-ed?

Regards,
J=E9r=E9mie

> +		plibc_calloc =3D dlsym(RTLD_NEXT, "calloc");
> +		if (plibc_calloc =3D=3D NULL) {
> +			fprintf(stderr, "callocwrap: unable to find calloc\n");
> +			return NULL;
> +		}
> +	}
> +	retval =3D plibc_calloc(nmemb, size);
> +	tracepoint(ust_libc, calloc, nmemb, size, retval);
> +	return retval;
> +}
> +
> +void *realloc(void *ptr, size_t size)
> +{
> +        static void *(*plibc_realloc)(void *ptr, size_t size) =3D NULL;
> +	void *retval;
> +
> +	if (plibc_realloc =3D=3D NULL) {
> +		plibc_realloc =3D dlsym(RTLD_NEXT, "realloc");
> +		if (plibc_realloc =3D=3D NULL) {
> +			fprintf(stderr, "reallocwrap: unable to find realloc\n");
> +			return NULL;
> +		}
> +	}
> +	retval =3D plibc_realloc(ptr, size);
> +	tracepoint(ust_libc, realloc, ptr, size, retval);
> +	return retval;
> +}
> +
> diff --git a/liblttng-ust-libc-wrapper/ust_libc.h b/liblttng-ust-libc-wra=
pper/ust_libc.h
> index af705aa..6b03a4d 100644
> --- a/liblttng-ust-libc-wrapper/ust_libc.h
> +++ b/liblttng-ust-libc-wrapper/ust_libc.h
> @@ -47,6 +47,24 @@ TRACEPOINT_EVENT(ust_libc, free,
>  	)
>  )
>
> +TRACEPOINT_EVENT(ust_libc, calloc,
> +	TP_ARGS(size_t, nmemb, size_t, size, void *, ptr),
> +	TP_FIELDS(
> +		ctf_integer(size_t, nmemb, nmemb)
> +		ctf_integer(size_t, size, size)
> +		ctf_integer_hex(unsigned long, ptr, (unsigned long) ptr)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_libc, realloc,
> +	TP_ARGS(void *, in_ptr, size_t, size, void *, ptr),
> +	TP_FIELDS(
> +		ctf_integer_hex(unsigned long, in_ptr, (unsigned long) in_ptr)
> +		ctf_integer(size_t, size, size)
> +		ctf_integer_hex(unsigned long, ptr, (unsigned long) ptr)
> +	)
> +)
> +
>  #endif /* _TRACEPOINT_UST_LIBC_H */
>
>  #undef TRACEPOINT_INCLUDE
> --
> 1.8.3.1
>


On Sat, Jul 27, 2013 at 1:19 AM, Stefan Seefeld
<stefan_seefeld@mentor.com> wrote:
> The attached patch adds support for calloc and realloc to the
> lttng-ust-libc-wrapper library.
>
> The implementation for calloc is slightly tricky, as dlsym calls calloc
> internally, so the library needs to provide a 'dummy' implementation for
> calloc to avoid an endless recursion. Testing has shown however that the
> object(s) allocated at that point are small, so a dummy static 'heap'
> suffices as a workaround.
>
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
