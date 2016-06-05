From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-ust PATCH v4] Add -ust to the name of UST
 threads of the application
Date: Sun, 5 Jun 2016 23:04:45 +0000 (UTC)
Message-ID: <1602515471.28739.1465167885039.JavaMail.zimbra__31844.3672419109$1465167915$gmane$org@efficios.com>
References: <935459994.28660.1465154391749.JavaMail.zimbra@efficios.com>
 <2f60eb1746f5f9806494598e421e9e835bf28a63.1465163994.git.raphael.beamonte@gmail.com>
 <1253360340.28704.1465166784927.JavaMail.zimbra@efficios.com>
 <CAE_Gge1pLSncZZhGNxEQ11RutcT_fK_Q-odmJHWzCLgtjV5J8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2541809848488833603=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B904EA3581
 for <lttng-dev@lists.lttng.org>; Sun,  5 Jun 2016 23:04:49 +0000 (UTC)
In-Reply-To: <CAE_Gge1pLSncZZhGNxEQ11RutcT_fK_Q-odmJHWzCLgtjV5J8g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?Q?Rapha=C3=ABl?= Beamonte <raphael.beamonte@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2541809848488833603==
Content-Type: multipart/alternative;
	boundary="----=_Part_28738_1017522518.1465167885038"

------=_Part_28738_1017522518.1465167885038
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

merged with small modifications,=20

Thanks!=20

Mathieu=20

----- On Jun 5, 2016, at 6:56 PM, Rapha=C3=ABl Beamonte <raphael.beamonte@g=
mail.com> wrote:=20

> On Jun 5, 2016 6:46 PM, "Mathieu Desnoyers" < mathieu.desnoyers@efficios.=
com >
> wrote:

>> ----- On Jun 5, 2016, at 6:00 PM, Rapha=C3=ABl Beamonte raphael.beamonte=
@gmail.com
> > wrote:

> > > Add the required functions to change the thread name of the UST
> > > threads and add the -ust string at its end. This will help to
> > > identify LTTng-UST processes when analyzing the trace of a process.

> > > Signed-off-by: Rapha=C3=ABl Beamonte < raphael.beamonte@gmail.com >
> > > ---
> > > configure.ac | 5 ++++
> > > liblttng-ust/Makefile.am | 1 +
> > > liblttng-ust/compat.h | 67 ++++++++++++++++++++++++++++++++++++++++++=
-
> > > liblttng-ust/lttng-ust-comm.c | 9 ++++++
> > > 4 files changed, 81 insertions(+), 1 deletion(-)

> > > diff --git a/ configure.ac b/ configure.ac
> > > index 5692553..de462ff 100644
> > > --- a/ configure.ac
> > > +++ b/ configure.ac
> > > @@ -135,6 +135,11 @@ AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBDL], [te=
st
> > > "x$have_libdl" =3D "xyes"])
> > > AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBC_DL], [test "x$have_libc_dl"=
 =3D "xyes"])

> > > AC_CHECK_LIB([pthread], [pthread_create])
> > > +AC_CHECK_LIB([pthread], [pthread_setname_np],
> > > + AC_DEFINE([HAVE_PTHREAD_SETNAME_NP], [1], [Define to 1 if pthread_s=
etname_np
> > > is available.]),
> > > + AC_CHECK_LIB([pthread], [pthread_set_name_np],
> > > + AC_DEFINE([HAVE_PTHREAD_SET_NAME_NP], [1], [Define to 1 if
> > > pthread_set_name_np is available.]),
> > > + AC_MSG_RESULT([pthread setname/set_name not found.])))

> > > # Check for dlfcn.h
> > > AC_CHECK_HEADER([dlfcn.h])
> > > diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> > > index f1801cf..05929be 100644
> > > --- a/liblttng-ust/Makefile.am
> > > +++ b/liblttng-ust/Makefile.am
> > > @@ -14,6 +14,7 @@ liblttng_ust_tracepoint_la_SOURCES =3D \
> > > error.h
> > > liblttng_ust_tracepoint_la_LIBADD =3D \
> > > -lurcu-bp \
> > > + -lpthread \
> > > $(top_builddir)/snprintf/ libustsnprintf.la
> > > liblttng_ust_tracepoint_la_LDFLAGS =3D -no-undefined -version-info
> > > $(LTTNG_UST_LIBRARY_VERSION)
> > > liblttng_ust_tracepoint_la_CFLAGS =3D -DUST_COMPONENT=3D"liblttng_ust=
_tracepoint"
> > > -fno-strict-aliasing
> > > diff --git a/liblttng-ust/compat.h b/liblttng-ust/compat.h
> > > index 43b2223..fff668b 100644
> > > --- a/liblttng-ust/compat.h
> > > +++ b/liblttng-ust/compat.h
> > > @@ -3,6 +3,7 @@

> > > /*
> > > * Copyright (C) 2011 Mathieu Desnoyers < mathieu.desnoyers@efficios.c=
om >
> > > + * Copyright (C) 2016 Rapha=C3=ABl Beamonte < raphael.beamonte@gmail=
.com >
> > > *
> > > * This library is free software; you can redistribute it and/or
> > > * modify it under the terms of the GNU Lesser General Public
> > > @@ -23,7 +24,6 @@
> > > * lttng_ust_getprocname.
> > > */
> > > #ifdef __linux__
> > > -

> > Why remove this newline ?

> Mistake that comes from the first version of the patch (I was including p=
thread
> there). I must have replicated the spacing of the FreeBSD elif when updat=
ing
> the patch and didn't see that mistake!


> > > #include <sys/prctl.h>

> > > #define LTTNG_UST_PROCNAME_LEN 17
> > > @@ -34,6 +34,17 @@ void lttng_ust_getprocname(char *name)
> > > (void) prctl(PR_GET_NAME, (unsigned long) name, 0, 0, 0);
> > > }

> > > +/*
> > > + * if pthread_setname_np is available.

> > Comments should be complete sentences, starting with a capital letter,
> > ending with a dot.

> > I'll fix those on my end.

> Ok, thanks!
> I'll remember that for next time!

> Rapha=C3=ABl


> > Thanks,

> > Mathieu

> > > + */
> > > +#ifdef HAVE_PTHREAD_SETNAME_NP
> > > +static inline
> > > +int lttng_pthread_setname_np(pthread_t thread, const char *name)
> > > +{
> > > + return pthread_setname_np(thread, name);
> > > +}
> > > +#endif
> > > +
> > > #elif defined(__FreeBSD__)
> > > #include <stdlib.h>
> > > #include <string.h>
> > > @@ -59,6 +70,60 @@ void lttng_ust_getprocname(char *name)
> > > strncpy(name, bsd_name, LTTNG_UST_PROCNAME_LEN - 1);
> > > }

> > > +/*
> > > + * if pthread_set_name_np is available.
> > > + */
> > > +#ifdef HAVE_PTHREAD_SET_NAME_NP
> > > +static inline
> > > +int lttng_pthread_setname_np(pthread_t thread, const char *name)
> > > +{
> > > + return pthread_set_name_np(thread, name);
> > > +}
> > > +#endif
> > > +
> > > +#endif
> > > +
> > > +/*
> > > + * If a pthread setname/set_name function is available, declare
> > > + * the setustprocname() function that will add '-ust' to the end
> > > + * of the current process name, while truncating it if needed.
> > > + */
> > > +#if defined(HAVE_PTHREAD_SETNAME_NP) || defined(HAVE_PTHREAD_SETNAME=
_NP)
> > > +#define LTTNG_UST_PROCNAME_SUFFIX "-ust"
> > > +
> > > +#include <pthread.h>
> > > +
> > > +static inline
> > > +int lttng_ust_setustprocname(void)
> > > +{
> > > + int ret =3D 0;
> > > + char name[LTTNG_UST_PROCNAME_LEN];
> > > + int limit =3D LTTNG_UST_PROCNAME_LEN - strlen(LTTNG_UST_PROCNAME_SU=
FFIX);
> > > + int len;
> > > +
> > > + lttng_ust_getprocname(name);
> > > +
> > > + len =3D strlen(name);
> > > + if (len > limit) {
> > > + len =3D limit;
> > > + }
> > > +
> > > + ret =3D sprintf(name + len, LTTNG_UST_PROCNAME_SUFFIX);
> > > + if (ret) {
> > > + goto error;
> > > + }
> > > +
> > > + ret =3D lttng_pthread_setname_np(pthread_self(), name);
> > > +
> > > +error:
> > > + return ret;
> > > +}
> > > +#else
> > > +static inline
> > > +int lttng_ust_setustprocname(void)
> > > +{
> > > + return 0;
> > > +}
> > > #endif

> > > #include <errno.h>
> > > diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-c=
omm.c
> > > index e00a22c..6105403 100644
> > > --- a/liblttng-ust/lttng-ust-comm.c
> > > +++ b/liblttng-ust/lttng-ust-comm.c
> > > @@ -1295,6 +1295,15 @@ void *ust_listener_thread(void *arg)
> > > int sock, ret, prev_connect_failed =3D 0, has_waited =3D 0;
> > > long timeout;

> > > + /*
> > > + * If available, add '-ust' to the end of this thread's
> > > + * process name
> > > + */
> > > + ret =3D lttng_ust_setustprocname();
> > > + if (ret) {
> > > + ERR("Unable to set UST process name");
> > > + }
> > > +
> > > /* Restart trying to connect to the session daemon */
> > > restart:
> > > if (prev_connect_failed) {
> > > --
> > > 2.8.1

> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_28738_1017522518.1465167885038
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>merged with small modifications,<br></div><=
div><br data-mce-bogus=3D"1"></div><div>Thanks!<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"=
></div><div><br></div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- =
On Jun 5, 2016, at 6:56 PM, Rapha=C3=ABl Beamonte &lt;raphael.beamonte@gmai=
l.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT__"><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><p dir=3D"ltr">On Jun 5, 20=
16 6:46 PM, "Mathieu Desnoyers" &lt;<a href=3D"mailto:mathieu.desnoyers@eff=
icios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:<=
br>
&gt;<br>
&gt; ----- On Jun 5, 2016, at 6:00 PM, Rapha=C3=ABl Beamonte <a href=3D"mai=
lto:raphael.beamonte@gmail.com" target=3D"_blank">raphael.beamonte@gmail.co=
m</a> wrote:<br>
&gt;<br>
&gt; &gt; Add the required functions to change the thread name of the UST<b=
r>
&gt; &gt; threads and add the -ust string at its end. This will help to<br>
&gt; &gt; identify LTTng-UST processes when analyzing the trace of a proces=
s.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Rapha=C3=ABl Beamonte &lt;<a href=3D"mailto:raphae=
l.beamonte@gmail.com" target=3D"_blank">raphael.beamonte@gmail.com</a>&gt;<=
br>
&gt; &gt; ---<br>
&gt; &gt; <a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a=
>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; 5 +=
+++<br>
&gt; &gt; liblttng-ust/Makefile.am&nbsp; &nbsp; &nbsp; |&nbsp; 1 +<br>
&gt; &gt; liblttng-ust/compat.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 67 +++++=
+++++++++++++++++++++++++++++++++++++-<br>
&gt; &gt; liblttng-ust/lttng-ust-comm.c |&nbsp; 9 ++++++<br>
&gt; &gt; 4 files changed, 81 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/<a href=3D"http://configure.ac" target=3D"_blank">co=
nfigure.ac</a> b/<a href=3D"http://configure.ac" target=3D"_blank">configur=
e.ac</a><br>
&gt; &gt; index 5692553..de462ff 100644<br>
&gt; &gt; --- a/<a href=3D"http://configure.ac" target=3D"_blank">configure=
.ac</a><br>
&gt; &gt; +++ b/<a href=3D"http://configure.ac" target=3D"_blank">configure=
.ac</a><br>
&gt; &gt; @@ -135,6 +135,11 @@ AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBDL],=
 [test<br>
&gt; &gt; "x$have_libdl" =3D "xyes"])<br>
&gt; &gt; AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBC_DL], [test "x$have_libc=
_dl" =3D "xyes"])<br>
&gt; &gt;<br>
&gt; &gt; AC_CHECK_LIB([pthread], [pthread_create])<br>
&gt; &gt; +AC_CHECK_LIB([pthread], [pthread_setname_np],<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;AC_DEFINE([HAVE_PTHREAD_SETNAME_NP], [1], [D=
efine to 1 if pthread_setname_np<br>
&gt; &gt; is available.]),<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;AC_CHECK_LIB([pthread], [pthread_set_name_np=
],<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AC_DEFINE([HAVE_=
PTHREAD_SET_NAME_NP], [1], [Define to 1 if<br>
&gt; &gt; pthread_set_name_np is available.]),<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;AC_MSG_RESULT([p=
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
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;error.h<br>
&gt; &gt; liblttng_ust_tracepoint_la_LIBADD =3D \<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;-lurcu-bp \<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;-lpthread \<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;$(top_builddir)/snprintf/<a href=3D"htt=
p://libustsnprintf.la" target=3D"_blank">libustsnprintf.la</a><br>
&gt; &gt; liblttng_ust_tracepoint_la_LDFLAGS =3D -no-undefined -version-inf=
o<br>
&gt; &gt; $(LTTNG_UST_LIBRARY_VERSION)<br>
&gt; &gt; liblttng_ust_tracepoint_la_CFLAGS =3D -DUST_COMPONENT=3D"liblttng=
_ust_tracepoint"<br>
&gt; &gt; -fno-strict-aliasing<br>
&gt; &gt; diff --git a/liblttng-ust/compat.h b/liblttng-ust/compat.h<br>
&gt; &gt; index 43b2223..fff668b 100644<br>
&gt; &gt; --- a/liblttng-ust/compat.h<br>
&gt; &gt; +++ b/liblttng-ust/compat.h<br>
&gt; &gt; @@ -3,6 +3,7 @@<br>
&gt; &gt;<br>
&gt; &gt; /*<br>
&gt; &gt;&nbsp; * Copyright (C) 2011 Mathieu Desnoyers &lt;<a href=3D"mailt=
o:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@effic=
ios.com</a>&gt;<br>
&gt; &gt; + * Copyright (C) 2016 Rapha=C3=ABl Beamonte &lt;<a href=3D"mailt=
o:raphael.beamonte@gmail.com" target=3D"_blank">raphael.beamonte@gmail.com<=
/a>&gt;<br>
&gt; &gt;&nbsp; *<br>
&gt; &gt;&nbsp; * This library is free software; you can redistribute it an=
d/or<br>
&gt; &gt;&nbsp; * modify it under the terms of the GNU Lesser General Publi=
c<br>
&gt; &gt; @@ -23,7 +24,6 @@<br>
&gt; &gt;&nbsp; * lttng_ust_getprocname.<br>
&gt; &gt;&nbsp; */<br>
&gt; &gt; #ifdef __linux__<br>
&gt; &gt; -<br>
&gt;<br>
&gt; Why remove this newline ?</p>
<p dir=3D"ltr">Mistake that comes from the first version of the patch (I wa=
s including pthread there). I must have replicated the spacing of the FreeB=
SD elif when updating the patch and didn't see that mistake!</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt; #include &lt;sys/prctl.h&gt;<br>
&gt; &gt;<br>
&gt; &gt; #define LTTNG_UST_PROCNAME_LEN 17<br>
&gt; &gt; @@ -34,6 +34,17 @@ void lttng_ust_getprocname(char *name)<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;(void) prctl(PR_GET_NAME, (unsigned lon=
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
&gt; I'll fix those on my end.</p>
<p dir=3D"ltr">Ok, thanks!<br>
I'll remember that for next time! </p>
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
&gt; &gt; +&nbsp; &nbsp; &nbsp;return pthread_setname_np(thread, name);<br>
&gt; &gt; +}<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; #elif defined(__FreeBSD__)<br>
&gt; &gt; #include &lt;stdlib.h&gt;<br>
&gt; &gt; #include &lt;string.h&gt;<br>
&gt; &gt; @@ -59,6 +70,60 @@ void lttng_ust_getprocname(char *name)<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;strncpy(nam=
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
&gt; &gt; +&nbsp; &nbsp; &nbsp;return pthread_set_name_np(thread, name);<br=
>
&gt; &gt; +}<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; +/*<br>
&gt; &gt; + * If a pthread setname/set_name function is available, declare<=
br>
&gt; &gt; + * the setustprocname() function that will add '-ust' to the end=
<br>
&gt; &gt; + * of the current process name, while truncating it if needed.<b=
r>
&gt; &gt; + */<br>
&gt; &gt; +#if defined(HAVE_PTHREAD_SETNAME_NP) || defined(HAVE_PTHREAD_SET=
NAME_NP)<br>
&gt; &gt; +#define LTTNG_UST_PROCNAME_SUFFIX "-ust"<br>
&gt; &gt; +<br>
&gt; &gt; +#include &lt;pthread.h&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +static inline<br>
&gt; &gt; +int lttng_ust_setustprocname(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;int ret =3D 0;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;char name[LTTNG_UST_PROCNAME_LEN];<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;int limit =3D LTTNG_UST_PROCNAME_LEN - strle=
n(LTTNG_UST_PROCNAME_SUFFIX);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;int len;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;lttng_ust_getprocname(name);<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;len =3D strlen(name);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;if (len &gt; limit) {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;len =3D limit;<b=
r>
&gt; &gt; +&nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;ret =3D sprintf(name + len, LTTNG_UST_PROCNA=
ME_SUFFIX);<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;if (ret) {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;ret =3D lttng_pthread_setname_np(pthread_sel=
f(), name);<br>
&gt; &gt; +<br>
&gt; &gt; +error:<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +#else<br>
&gt; &gt; +static inline<br>
&gt; &gt; +int lttng_ust_setustprocname(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;return 0;<br>
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
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;int sock, ret, prev_connect_failed =3D =
0, has_waited =3D 0;<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;long timeout;<br>
&gt; &gt;<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;/*<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; * If available, add '-ust' to the end of th=
is thread's<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; * process name<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; */<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;ret =3D lttng_ust_setustprocname();<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;if (ret) {<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ERR("Unable to s=
et UST process name");<br>
&gt; &gt; +&nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;/* Restart trying to connect to the ses=
sion daemon */<br>
&gt; &gt; restart:<br>
&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp;if (prev_connect_failed) {<br>
&gt; &gt; --<br>
&gt; &gt; 2.8.1<br>
&gt;<br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.effic=
ios.com</a><br>
</p><br></blockquote></div><br><div data-marker=3D"__SIG_POST__">-- <br></d=
iv><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div>=
</div></body></html>
------=_Part_28738_1017522518.1465167885038--

--===============2541809848488833603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2541809848488833603==--
