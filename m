From: =?UTF-8?Q?Rapha=C3=ABl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-ust PATCH v4] Add -ust to the name of UST
	threads of the application
Date: Sun, 5 Jun 2016 18:56:37 -0400
Message-ID: <CAE_Gge1pLSncZZhGNxEQ11RutcT_fK_Q-odmJHWzCLgtjV5J8g__15819.2019247965$1465167426$gmane$org@mail.gmail.com>
References: <935459994.28660.1465154391749.JavaMail.zimbra@efficios.com>
 <2f60eb1746f5f9806494598e421e9e835bf28a63.1465163994.git.raphael.beamonte@gmail.com>
 <1253360340.28704.1465166784927.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6393353491132418205=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D0363A37BD
 for <lttng-dev@lists.lttng.org>; Sun,  5 Jun 2016 22:56:38 +0000 (UTC)
Received: by mail-qk0-f193.google.com with SMTP id l185so7352535qkc.2
 for <lttng-dev@lists.lttng.org>; Sun, 05 Jun 2016 15:56:38 -0700 (PDT)
In-Reply-To: <1253360340.28704.1465166784927.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6393353491132418205==
Content-Type: multipart/alternative; boundary=94eb2c07d55646479805348fde08

--94eb2c07d55646479805348fde08
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Jun 5, 2016 6:46 PM, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com=
>
wrote:
>
> ----- On Jun 5, 2016, at 6:00 PM, Rapha=C3=ABl Beamonte
raphael.beamonte@gmail.com wrote:
>
> > Add the required functions to change the thread name of the UST
> > threads and add the -ust string at its end. This will help to
> > identify LTTng-UST processes when analyzing the trace of a process.
> >
> > Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
> > ---
> > configure.ac                  |  5 ++++
> > liblttng-ust/Makefile.am      |  1 +
> > liblttng-ust/compat.h         | 67
++++++++++++++++++++++++++++++++++++++++++-
> > liblttng-ust/lttng-ust-comm.c |  9 ++++++
> > 4 files changed, 81 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 5692553..de462ff 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -135,6 +135,11 @@ AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBDL], [test
> > "x$have_libdl" =3D "xyes"])
> > AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBC_DL], [test "x$have_libc_dl" =
=3D
"xyes"])
> >
> > AC_CHECK_LIB([pthread], [pthread_create])
> > +AC_CHECK_LIB([pthread], [pthread_setname_np],
> > +     AC_DEFINE([HAVE_PTHREAD_SETNAME_NP], [1], [Define to 1 if
pthread_setname_np
> > is available.]),
> > +     AC_CHECK_LIB([pthread], [pthread_set_name_np],
> > +             AC_DEFINE([HAVE_PTHREAD_SET_NAME_NP], [1], [Define to 1 i=
f
> > pthread_set_name_np is available.]),
> > +             AC_MSG_RESULT([pthread setname/set_name not found.])))
> >
> > # Check for dlfcn.h
> > AC_CHECK_HEADER([dlfcn.h])
> > diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> > index f1801cf..05929be 100644
> > --- a/liblttng-ust/Makefile.am
> > +++ b/liblttng-ust/Makefile.am
> > @@ -14,6 +14,7 @@ liblttng_ust_tracepoint_la_SOURCES =3D \
> >       error.h
> > liblttng_ust_tracepoint_la_LIBADD =3D \
> >       -lurcu-bp \
> > +     -lpthread \
> >       $(top_builddir)/snprintf/libustsnprintf.la
> > liblttng_ust_tracepoint_la_LDFLAGS =3D -no-undefined -version-info
> > $(LTTNG_UST_LIBRARY_VERSION)
> > liblttng_ust_tracepoint_la_CFLAGS =3D
-DUST_COMPONENT=3D"liblttng_ust_tracepoint"
> > -fno-strict-aliasing
> > diff --git a/liblttng-ust/compat.h b/liblttng-ust/compat.h
> > index 43b2223..fff668b 100644
> > --- a/liblttng-ust/compat.h
> > +++ b/liblttng-ust/compat.h
> > @@ -3,6 +3,7 @@
> >
> > /*
> >  * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com=
>
> > + * Copyright (C) 2016 Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.co=
m>
> >  *
> >  * This library is free software; you can redistribute it and/or
> >  * modify it under the terms of the GNU Lesser General Public
> > @@ -23,7 +24,6 @@
> >  * lttng_ust_getprocname.
> >  */
> > #ifdef __linux__
> > -
>
> Why remove this newline ?

Mistake that comes from the first version of the patch (I was including
pthread there). I must have replicated the spacing of the FreeBSD elif when
updating the patch and didn't see that mistake!

>
> > #include <sys/prctl.h>
> >
> > #define LTTNG_UST_PROCNAME_LEN 17
> > @@ -34,6 +34,17 @@ void lttng_ust_getprocname(char *name)
> >       (void) prctl(PR_GET_NAME, (unsigned long) name, 0, 0, 0);
> > }
> >
> > +/*
> > + * if pthread_setname_np is available.
>
> Comments should be complete sentences, starting with a capital letter,
> ending with a dot.
>
> I'll fix those on my end.

Ok, thanks!
I'll remember that for next time!

Rapha=C3=ABl

>
> Thanks,
>
> Mathieu
>
> > + */
> > +#ifdef HAVE_PTHREAD_SETNAME_NP
> > +static inline
> > +int lttng_pthread_setname_np(pthread_t thread, const char *name)
> > +{
> > +     return pthread_setname_np(thread, name);
> > +}
> > +#endif
> > +
> > #elif defined(__FreeBSD__)
> > #include <stdlib.h>
> > #include <string.h>
> > @@ -59,6 +70,60 @@ void lttng_ust_getprocname(char *name)
> >               strncpy(name, bsd_name, LTTNG_UST_PROCNAME_LEN - 1);
> > }
> >
> > +/*
> > + * if pthread_set_name_np is available.
> > + */
> > +#ifdef HAVE_PTHREAD_SET_NAME_NP
> > +static inline
> > +int lttng_pthread_setname_np(pthread_t thread, const char *name)
> > +{
> > +     return pthread_set_name_np(thread, name);
> > +}
> > +#endif
> > +
> > +#endif
> > +
> > +/*
> > + * If a pthread setname/set_name function is available, declare
> > + * the setustprocname() function that will add '-ust' to the end
> > + * of the current process name, while truncating it if needed.
> > + */
> > +#if defined(HAVE_PTHREAD_SETNAME_NP) ||
defined(HAVE_PTHREAD_SETNAME_NP)
> > +#define LTTNG_UST_PROCNAME_SUFFIX "-ust"
> > +
> > +#include <pthread.h>
> > +
> > +static inline
> > +int lttng_ust_setustprocname(void)
> > +{
> > +     int ret =3D 0;
> > +     char name[LTTNG_UST_PROCNAME_LEN];
> > +     int limit =3D LTTNG_UST_PROCNAME_LEN -
strlen(LTTNG_UST_PROCNAME_SUFFIX);
> > +     int len;
> > +
> > +     lttng_ust_getprocname(name);
> > +
> > +     len =3D strlen(name);
> > +     if (len > limit) {
> > +             len =3D limit;
> > +     }
> > +
> > +     ret =3D sprintf(name + len, LTTNG_UST_PROCNAME_SUFFIX);
> > +     if (ret) {
> > +             goto error;
> > +     }
> > +
> > +     ret =3D lttng_pthread_setname_np(pthread_self(), name);
> > +
> > +error:
> > +     return ret;
> > +}
> > +#else
> > +static inline
> > +int lttng_ust_setustprocname(void)
> > +{
> > +     return 0;
> > +}
> > #endif
> >
> > #include <errno.h>
> > diff --git a/liblttng-ust/lttng-ust-comm.c
b/liblttng-ust/lttng-ust-comm.c
> > index e00a22c..6105403 100644
> > --- a/liblttng-ust/lttng-ust-comm.c
> > +++ b/liblttng-ust/lttng-ust-comm.c
> > @@ -1295,6 +1295,15 @@ void *ust_listener_thread(void *arg)
> >       int sock, ret, prev_connect_failed =3D 0, has_waited =3D 0;
> >       long timeout;
> >
> > +     /*
> > +      * If available, add '-ust' to the end of this thread's
> > +      * process name
> > +      */
> > +     ret =3D lttng_ust_setustprocname();
> > +     if (ret) {
> > +             ERR("Unable to set UST process name");
> > +     }
> > +
> >       /* Restart trying to connect to the session daemon */
> > restart:
> >       if (prev_connect_failed) {
> > --
> > 2.8.1
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--94eb2c07d55646479805348fde08
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On Jun 5, 2016 6:46 PM, &quot;Mathieu Desnoyers&quot; &lt;<a=
 href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; ----- On Jun 5, 2016, at 6:00 PM, Rapha=C3=ABl Beamonte <a href=3D"mai=
lto:raphael.beamonte@gmail.com">raphael.beamonte@gmail.com</a> wrote:<br>
&gt;<br>
&gt; &gt; Add the required functions to change the thread name of the UST<b=
r>
&gt; &gt; threads and add the -ust string at its end. This will help to<br>
&gt; &gt; identify LTTng-UST processes when analyzing the trace of a proces=
s.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Rapha=C3=ABl Beamonte &lt;<a href=3D"mailto:raphae=
l.beamonte@gmail.com">raphael.beamonte@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; <a href=3D"http://configure.ac">configure.ac</a>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++++<br>
&gt; &gt; liblttng-ust/Makefile.am=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; &gt; liblttng-ust/compat.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 67 +++++=
+++++++++++++++++++++++++++++++++++++-<br>
&gt; &gt; liblttng-ust/lttng-ust-comm.c |=C2=A0 9 ++++++<br>
&gt; &gt; 4 files changed, 81 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/<a href=3D"http://configure.ac">configure.ac</a> b/<=
a href=3D"http://configure.ac">configure.ac</a><br>
&gt; &gt; index 5692553..de462ff 100644<br>
&gt; &gt; --- a/<a href=3D"http://configure.ac">configure.ac</a><br>
&gt; &gt; +++ b/<a href=3D"http://configure.ac">configure.ac</a><br>
&gt; &gt; @@ -135,6 +135,11 @@ AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBDL],=
 [test<br>
&gt; &gt; &quot;x$have_libdl&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt; AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBC_DL], [test &quot;x$have=
_libc_dl&quot; =3D &quot;xyes&quot;])<br>
&gt; &gt;<br>
&gt; &gt; AC_CHECK_LIB([pthread], [pthread_create])<br>
&gt; &gt; +AC_CHECK_LIB([pthread], [pthread_setname_np],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AC_DEFINE([HAVE_PTHREAD_SETNAME_NP], [1], [D=
efine to 1 if pthread_setname_np<br>
&gt; &gt; is available.]),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0AC_CHECK_LIB([pthread], [pthread_set_name_np=
],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_DEFINE([HAVE_=
PTHREAD_SET_NAME_NP], [1], [Define to 1 if<br>
&gt; &gt; pthread_set_name_np is available.]),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_RESULT([p=
thread setname/set_name not found.])))<br>
&gt; &gt;<br>
&gt; &gt; # Check for dlfcn.h<br>
&gt; &gt; AC_CHECK_HEADER([dlfcn.h])<br>
&gt; &gt; diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am<=
br>
&gt; &gt; index f1801cf..05929be 100644<br>
&gt; &gt; --- a/liblttng-ust/Makefile.am<br>
&gt; &gt; +++ b/liblttng-ust/Makefile.am<br>
&gt; &gt; @@ -14,6 +14,7 @@ liblttng_ust_tracepoint_la_SOURCES =3D \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0error.h<br>
&gt; &gt; liblttng_ust_tracepoint_la_LIBADD =3D \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-lurcu-bp \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-lpthread \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_builddir)/snprintf/<a href=3D"htt=
p://libustsnprintf.la">libustsnprintf.la</a><br>
&gt; &gt; liblttng_ust_tracepoint_la_LDFLAGS =3D -no-undefined -version-inf=
o<br>
&gt; &gt; $(LTTNG_UST_LIBRARY_VERSION)<br>
&gt; &gt; liblttng_ust_tracepoint_la_CFLAGS =3D -DUST_COMPONENT=3D&quot;lib=
lttng_ust_tracepoint&quot;<br>
&gt; &gt; -fno-strict-aliasing<br>
&gt; &gt; diff --git a/liblttng-ust/compat.h b/liblttng-ust/compat.h<br>
&gt; &gt; index 43b2223..fff668b 100644<br>
&gt; &gt; --- a/liblttng-ust/compat.h<br>
&gt; &gt; +++ b/liblttng-ust/compat.h<br>
&gt; &gt; @@ -3,6 +3,7 @@<br>
&gt; &gt;<br>
&gt; &gt; /*<br>
&gt; &gt;=C2=A0 * Copyright (C) 2011 Mathieu Desnoyers &lt;<a href=3D"mailt=
o:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br=
>
&gt; &gt; + * Copyright (C) 2016 Rapha=C3=ABl Beamonte &lt;<a href=3D"mailt=
o:raphael.beamonte@gmail.com">raphael.beamonte@gmail.com</a>&gt;<br>
&gt; &gt;=C2=A0 *<br>
&gt; &gt;=C2=A0 * This library is free software; you can redistribute it an=
d/or<br>
&gt; &gt;=C2=A0 * modify it under the terms of the GNU Lesser General Publi=
c<br>
&gt; &gt; @@ -23,7 +24,6 @@<br>
&gt; &gt;=C2=A0 * lttng_ust_getprocname.<br>
&gt; &gt;=C2=A0 */<br>
&gt; &gt; #ifdef __linux__<br>
&gt; &gt; -<br>
&gt;<br>
&gt; Why remove this newline ?</p>
<p dir=3D"ltr">Mistake that comes from the first version of the patch (I wa=
s including pthread there). I must have replicated the spacing of the FreeB=
SD elif when updating the patch and didn&#39;t see that mistake!</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt; #include &lt;sys/prctl.h&gt;<br>
&gt; &gt;<br>
&gt; &gt; #define LTTNG_UST_PROCNAME_LEN 17<br>
&gt; &gt; @@ -34,6 +34,17 @@ void lttng_ust_getprocname(char *name)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(void) prctl(PR_GET_NAME, (unsigned lon=
g) name, 0, 0, 0);<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; +/*<br>
&gt; &gt; + * if pthread_setname_np is available.<br>
&gt;<br>
&gt; Comments should be complete sentences, starting with a capital letter,=
<br>
&gt; ending with a dot.<br>
&gt;<br>
&gt; I&#39;ll fix those on my end.</p>
<p dir=3D"ltr">Ok, thanks!<br>
I&#39;ll remember that for next time! </p>
<p dir=3D"ltr">Rapha=C3=ABl </p>
<p dir=3D"ltr">&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Mathieu<br>
&gt;<br>
&gt; &gt; + */<br>
&gt; &gt; +#ifdef HAVE_PTHREAD_SETNAME_NP<br>
&gt; &gt; +static inline<br>
&gt; &gt; +int lttng_pthread_setname_np(pthread_t thread, const char *name)=
<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return pthread_setname_np(thread, name);<br>
&gt; &gt; +}<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; #elif defined(__FreeBSD__)<br>
&gt; &gt; #include &lt;stdlib.h&gt;<br>
&gt; &gt; #include &lt;string.h&gt;<br>
&gt; &gt; @@ -59,6 +70,60 @@ void lttng_ust_getprocname(char *name)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(nam=
e, bsd_name, LTTNG_UST_PROCNAME_LEN - 1);<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; +/*<br>
&gt; &gt; + * if pthread_set_name_np is available.<br>
&gt; &gt; + */<br>
&gt; &gt; +#ifdef HAVE_PTHREAD_SET_NAME_NP<br>
&gt; &gt; +static inline<br>
&gt; &gt; +int lttng_pthread_setname_np(pthread_t thread, const char *name)=
<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return pthread_set_name_np(thread, name);<br=
>
&gt; &gt; +}<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; +/*<br>
&gt; &gt; + * If a pthread setname/set_name function is available, declare<=
br>
&gt; &gt; + * the setustprocname() function that will add &#39;-ust&#39; to=
 the end<br>
&gt; &gt; + * of the current process name, while truncating it if needed.<b=
r>
&gt; &gt; + */<br>
&gt; &gt; +#if defined(HAVE_PTHREAD_SETNAME_NP) || defined(HAVE_PTHREAD_SET=
NAME_NP)<br>
&gt; &gt; +#define LTTNG_UST_PROCNAME_SUFFIX &quot;-ust&quot;<br>
&gt; &gt; +<br>
&gt; &gt; +#include &lt;pthread.h&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +static inline<br>
&gt; &gt; +int lttng_ust_setustprocname(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0char name[LTTNG_UST_PROCNAME_LEN];<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0int limit =3D LTTNG_UST_PROCNAME_LEN - strle=
n(LTTNG_UST_PROCNAME_SUFFIX);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0int len;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0lttng_ust_getprocname(name);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0len =3D strlen(name);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (len &gt; limit) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D limit;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D sprintf(name + len, LTTNG_UST_PROCNA=
ME_SUFFIX);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D lttng_pthread_setname_np(pthread_sel=
f(), name);<br>
&gt; &gt; +<br>
&gt; &gt; +error:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +#else<br>
&gt; &gt; +static inline<br>
&gt; &gt; +int lttng_ust_setustprocname(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; +}<br>
&gt; &gt; #endif<br>
&gt; &gt;<br>
&gt; &gt; #include &lt;errno.h&gt;<br>
&gt; &gt; diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-u=
st-comm.c<br>
&gt; &gt; index e00a22c..6105403 100644<br>
&gt; &gt; --- a/liblttng-ust/lttng-ust-comm.c<br>
&gt; &gt; +++ b/liblttng-ust/lttng-ust-comm.c<br>
&gt; &gt; @@ -1295,6 +1295,15 @@ void *ust_listener_thread(void *arg)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int sock, ret, prev_connect_failed =3D =
0, has_waited =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long timeout;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * If available, add &#39;-ust&#39; to the e=
nd of this thread&#39;s<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 * process name<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0ret =3D lttng_ust_setustprocname();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERR(&quot;Unable=
 to set UST process name&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restart trying to connect to the ses=
sion daemon */<br>
&gt; &gt; restart:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (prev_connect_failed) {<br>
&gt; &gt; --<br>
&gt; &gt; 2.8.1<br>
&gt;<br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"http://www.efficios.com">http://www.efficios.com</a><br>
</p>

--94eb2c07d55646479805348fde08--

--===============6393353491132418205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6393353491132418205==--
