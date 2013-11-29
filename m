From: =?ISO-8859-1?Q?Charles_Bri=E8re?= <charlesbriere.flatzo@gmail.com>
Subject: Re: [PATCH liburcu 2/5] Dont link pthread on Android
Date: Thu, 28 Nov 2013 16:10:53 -0800
Message-ID: <CACnpWGTmYwjtmUCsiGHyS=nqSoQrO+_TMifPMvkwhYjxTOU06w__23437.0939353996$1385683921$gmane$org@mail.gmail.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-2-git-send-email-charlesbriere.flatzo@gmail.com>
	<20131128103024.3341ccc8@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0905641611=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <charlesbriere.flatzo@gmail.com>) id 1VmBff-0000LX-1I
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 19:11:05 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so8033374qeb.13
	for <lttng-dev@lists.lttng.org>; Thu, 28 Nov 2013 16:10:53 -0800 (PST)
In-Reply-To: <20131128103024.3341ccc8@skate>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0905641611==
Content-Type: multipart/alternative; boundary=001a11c2f27adc8d5804ec45a966

--001a11c2f27adc8d5804ec45a966
Content-Type: text/plain; charset=ISO-8859-1

Dear Thomas,

To be honest, I haven't even though about other libc. But you are right,
that is probably a better idea.

What about adding those lines to configure.ac ( modified from
configure.acfound in lttng-tools )

# Check for pthread
AC_CHECK_LIB([pthread], [pthread_create],
[AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, false)],
[AC_CHECK_LIB([c], [pthread_create],
 [AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, true)],
[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its
location.])]
 )]
)

and changing the if in the patch to "if !LIBC_INCLUDES_PTHREAD"


Thanks for the comment,
Charles



Mathieu,

   if I am to submit a patch for that, should it be intended to replace
this one, or on top of HEAD as a Fix ?


Thanks,
Charles



On Thu, Nov 28, 2013 at 1:30 AM, Thomas Petazzoni <
thomas.petazzoni@free-electrons.com> wrote:

> Dear Charles Briere,
>
> On Wed, 27 Nov 2013 07:48:30 -0800, Charles Briere wrote:
>
> >  #Add the -version-info directly here since we are only building
> >  # library that use the version-info
> > -AM_LDFLAGS=-lpthread -version-info $(URCU_LIBRARY_VERSION)
> > +AM_LDFLAGS=-version-info $(URCU_LIBRARY_VERSION)
> > +if !TARGET_IS_ANDROID
> > +AM_LDFLAGS += -lpthread
> > +endif
>
> Instead of making that conditional on Android, wouldn't it make more
> sense to make it conditional on whether linking with pthread is
> necessary or not?
>
> I can at least think of one other C library than Bionic that has
> everything in libc instead of things split in several libraries: the
> Musl C library (http://www.musl-libc.org).
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>

--001a11c2f27adc8d5804ec45a966
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Thomas,=A0<div><br></div><div>To be honest, I haven&#=
39;t even though about other libc. But you are right, that is probably a be=
tter idea.=A0</div><div><br></div><div>What about adding those lines to <a =
href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> ( modified =
from <a href=3D"http://configure.ac" target=3D"_blank">configure.ac</a> fou=
nd in lttng-tools )=A0</div>

<div><br></div><div># Check for pthread</div><div>AC_CHECK_LIB([pthread], [=
pthread_create],</div><div><span style=3D"white-space:pre-wrap">	</span>[AM=
_CONDITIONAL(LIBC_INCLUDES_PTHREAD, false)],</div><div><span style=3D"white=
-space:pre-wrap">	</span>[AC_CHECK_LIB([c], [pthread_create],</div>

<div><span style=3D"white-space:pre-wrap">		</span>[AM_CONDITIONAL(LIBC_INC=
LUDES_PTHREAD, true)],</div><div><span style=3D"white-space:pre-wrap">		</s=
pan>[AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=3D-Ldir to specify=
 its location.])]</div>

<div><span style=3D"white-space:pre-wrap">	</span>)]</div><div>)</div><div>=
<br></div><div>and changing the if in the patch to &quot;if !LIBC_INCLUDES_=
PTHREAD&quot;</div><div><br></div><div><br></div><div>Thanks for the commen=
t,</div>
<div>Charles</div><div><br></div><div><br></div><div><br></div><div>Mathieu=
,=A0</div><div><br></div><div>=A0 =A0if I am to submit a patch for that, sh=
ould it be intended to replace this one, or on top of HEAD as a Fix ?</div>=
<div>
<br></div><div><br></div><div>Thanks,</div><div>Charles</div><div>=A0</div>=
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu,=
 Nov 28, 2013 at 1:30 AM, Thomas Petazzoni <span dir=3D"ltr">&lt;<a href=3D=
"mailto:thomas.petazzoni@free-electrons.com" target=3D"_blank">thomas.petaz=
zoni@free-electrons.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Dear Charles Briere,<br>
<div class=3D"im"><br>
On Wed, 27 Nov 2013 07:48:30 -0800, Charles Briere wrote:<br>
<br>
&gt; =A0#Add the -version-info directly here since we are only building<br>
&gt; =A0# library that use the version-info<br>
&gt; -AM_LDFLAGS=3D-lpthread -version-info $(URCU_LIBRARY_VERSION)<br>
&gt; +AM_LDFLAGS=3D-version-info $(URCU_LIBRARY_VERSION)<br>
&gt; +if !TARGET_IS_ANDROID<br>
&gt; +AM_LDFLAGS +=3D -lpthread<br>
&gt; +endif<br>
<br>
</div>Instead of making that conditional on Android, wouldn&#39;t it make m=
ore<br>
sense to make it conditional on whether linking with pthread is<br>
necessary or not?<br>
<br>
I can at least think of one other C library than Bionic that has<br>
everything in libc instead of things split in several libraries: the<br>
Musl C library (<a href=3D"http://www.musl-libc.org" target=3D"_blank">http=
://www.musl-libc.org</a>).<br>
<br>
Best regards,<br>
<br>
Thomas<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Thomas Petazzoni, CTO, Free Electrons<br>
Embedded Linux, Kernel and Android engineering<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
</font></span></blockquote></div><br></div>

--001a11c2f27adc8d5804ec45a966--


--===============0905641611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0905641611==--
