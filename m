From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 2/5] Dont link pthread on Android
Date: Fri, 29 Nov 2013 06:01:28 +0000 (UTC)
Message-ID: <479853854.77497.1385704888472.JavaMail.zimbra__35005.6151314222$1385704941$gmane$org@efficios.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-2-git-send-email-charlesbriere.flatzo@gmail.com>
	<20131128103024.3341ccc8@skate>
	<CACnpWGTmYwjtmUCsiGHyS=nqSoQrO+_TMifPMvkwhYjxTOU06w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0684654155=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VmH8u-00011T-UA
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 01:01:36 -0500
In-Reply-To: <CACnpWGTmYwjtmUCsiGHyS=nqSoQrO+_TMifPMvkwhYjxTOU06w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles =?utf-8?Q?Bri=C3=A8re?= <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0684654155==
Content-Type: multipart/alternative;
	boundary="----=_Part_77496_1356340737.1385704888471"

------=_Part_77496_1356340737.1385704888471
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- Original Message -----

> From: "Charles Bri=C3=A8re" <charlesbriere.flatzo@gmail.com>
> To: "Thomas Petazzoni" <thomas.petazzoni@free-electrons.com>, "Mathieu
> Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Friday, November 29, 2013 1:10:53 AM
> Subject: Re: [lttng-dev] [PATCH liburcu 2/5] Dont link pthread on Android

> Dear Thomas,

> To be honest, I haven't even though about other libc. But you are right, =
that
> is probably a better idea.

> What about adding those lines to configure.ac ( modified from configure.a=
c
> found in lttng-tools )

> # Check for pthread
> AC_CHECK_LIB([pthread], [pthread_create],
> [AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, false)],
> [AC_CHECK_LIB([c], [pthread_create],
> [AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, true)],
> [AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=3D-Ldir to specify i=
ts
> location.])]
> )]
> )

> and changing the if in the patch to "if !LIBC_INCLUDES_PTHREAD"

> Thanks for the comment,
> Charles

> Mathieu,

> if I am to submit a patch for that, should it be intended to replace this
> one, or on top of HEAD as a Fix ?

Please submit against HEAD, as a fix, since the patch discussed here was al=
ready merged.=20

Thanks,=20

Mathieu=20

> Thanks,
> Charles

> On Thu, Nov 28, 2013 at 1:30 AM, Thomas Petazzoni <
> thomas.petazzoni@free-electrons.com > wrote:

> > Dear Charles Briere,
>=20

> > On Wed, 27 Nov 2013 07:48:30 -0800, Charles Briere wrote:
>=20

> > > #Add the -version-info directly here since we are only building
>=20
> > > # library that use the version-info
>=20
> > > -AM_LDFLAGS=3D-lpthread -version-info $(URCU_LIBRARY_VERSION)
>=20
> > > +AM_LDFLAGS=3D-version-info $(URCU_LIBRARY_VERSION)
>=20
> > > +if !TARGET_IS_ANDROID
>=20
> > > +AM_LDFLAGS +=3D -lpthread
>=20
> > > +endif
>=20

> > Instead of making that conditional on Android, wouldn't it make more
>=20
> > sense to make it conditional on whether linking with pthread is
>=20
> > necessary or not?
>=20

> > I can at least think of one other C library than Bionic that has
>=20
> > everything in libc instead of things split in several libraries: the
>=20
> > Musl C library ( http://www.musl-libc.org ).
>=20

> > Best regards,
>=20

> > Thomas
>=20
> > --
>=20
> > Thomas Petazzoni, CTO, Free Electrons
>=20
> > Embedded Linux, Kernel and Android engineering
>=20
> > http://free-electrons.com
>=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_77496_1356340737.1385704888471
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"border-left: 2px s=
olid #1010FF; margin-left: 5px; padding-left: 5px; color: #000; font-weight=
: normal; font-style: normal; text-decoration: none; font-family: Helvetica=
,Arial,sans-serif; font-size: 12pt;"><b>From: </b>"Charles Bri=C3=A8re" &lt=
;charlesbriere.flatzo@gmail.com&gt;<br><b>To: </b>"Thomas Petazzoni" &lt;th=
omas.petazzoni@free-electrons.com&gt;, "Mathieu Desnoyers" &lt;mathieu.desn=
oyers@efficios.com&gt;<br><b>Cc: </b>lttng-dev@lists.lttng.org<br><b>Sent: =
</b>Friday, November 29, 2013 1:10:53 AM<br><b>Subject: </b>Re: [lttng-dev]=
 [PATCH liburcu 2/5] Dont link pthread on Android<br><div><br></div><div di=
r=3D"ltr">Dear Thomas,&nbsp;<div><br></div><div>To be honest, I haven't eve=
n though about other libc. But you are right, that is probably a better ide=
a.&nbsp;</div><div><br></div><div>What about adding those lines to <a href=
=3D"http://configure.ac" target=3D"_blank" data-mce-href=3D"http://configur=
e.ac">configure.ac</a> ( modified from <a href=3D"http://configure.ac" targ=
et=3D"_blank" data-mce-href=3D"http://configure.ac">configure.ac</a> found =
in lttng-tools )&nbsp;</div><div><br></div><div># Check for pthread</div><d=
iv>AC_CHECK_LIB([pthread], [pthread_create],</div><div><span style=3D"white=
-space:pre-wrap" data-mce-style=3D"white-space: pre-wrap;"> </span>[AM_COND=
ITIONAL(LIBC_INCLUDES_PTHREAD, false)],</div><div><span style=3D"white-spac=
e:pre-wrap" data-mce-style=3D"white-space: pre-wrap;"> </span>[AC_CHECK_LIB=
([c], [pthread_create],</div><div><span style=3D"white-space:pre-wrap" data=
-mce-style=3D"white-space: pre-wrap;"> </span>[AM_CONDITIONAL(LIBC_INCLUDES=
_PTHREAD, true)],</div><div><span style=3D"white-space:pre-wrap" data-mce-s=
tyle=3D"white-space: pre-wrap;"> </span>[AC_MSG_ERROR([Cannot find libpthre=
ad. Use [LDFLAGS]=3D-Ldir to specify its location.])]</div><div><span style=
=3D"white-space:pre-wrap" data-mce-style=3D"white-space: pre-wrap;"> </span=
>)]</div><div>)</div><div><br></div><div>and changing the if in the patch t=
o "if !LIBC_INCLUDES_PTHREAD"</div><div><br></div><div><br></div><div>Thank=
s for the comment,</div><div>Charles</div><div><br></div><div><br></div><di=
v><br></div><div>Mathieu,&nbsp;</div><div><br></div><div>&nbsp; &nbsp;if I =
am to submit a patch for that, should it be intended to replace this one, o=
r on top of HEAD as a Fix ?</div></div></blockquote><div><br></div><div>Ple=
ase submit against HEAD, as a fix, since the patch discussed here was alrea=
dy merged.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><di=
v>Mathieu<br></div><div><br></div><blockquote style=3D"border-left:2px soli=
d #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fo=
nt-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif=
;font-size:12pt;" data-mce-style=3D"border-left: 2px solid #1010FF; margin-=
left: 5px; padding-left: 5px; color: #000; font-weight: normal; font-style:=
 normal; text-decoration: none; font-family: Helvetica,Arial,sans-serif; fo=
nt-size: 12pt;"><div dir=3D"ltr"><div><br></div><div><br></div><div>Thanks,=
</div><div>Charles</div></div><div class=3D"gmail_extra"><br><div><br></div=
><div class=3D"gmail_quote">On Thu, Nov 28, 2013 at 1:30 AM, Thomas Petazzo=
ni <span dir=3D"ltr">&lt;<a href=3D"mailto:thomas.petazzoni@free-electrons.=
com" target=3D"_blank" data-mce-href=3D"mailto:thomas.petazzoni@free-electr=
ons.com">thomas.petazzoni@free-electrons.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex" data-mce-style=3D"margin: 0 0 0 .8ex; border-left=
: 1px #ccc solid; padding-left: 1ex;">Dear Charles Briere,<br><div class=3D=
"im"><br> On Wed, 27 Nov 2013 07:48:30 -0800, Charles Briere wrote:<br><br>=
 &gt; &nbsp;#Add the -version-info directly here since we are only building=
<br> &gt; &nbsp;# library that use the version-info<br> &gt; -AM_LDFLAGS=3D=
-lpthread -version-info $(URCU_LIBRARY_VERSION)<br> &gt; +AM_LDFLAGS=3D-ver=
sion-info $(URCU_LIBRARY_VERSION)<br> &gt; +if !TARGET_IS_ANDROID<br> &gt; =
+AM_LDFLAGS +=3D -lpthread<br> &gt; +endif<br><br></div>Instead of making t=
hat conditional on Android, wouldn't it make more<br> sense to make it cond=
itional on whether linking with pthread is<br> necessary or not?<br><br> I =
can at least think of one other C library than Bionic that has<br> everythi=
ng in libc instead of things split in several libraries: the<br> Musl C lib=
rary (<a href=3D"http://www.musl-libc.org" target=3D"_blank" data-mce-href=
=3D"http://www.musl-libc.org">http://www.musl-libc.org</a>).<br><br> Best r=
egards,<br><br> Thomas<br><span class=3D"HOEnZb"><span style=3D"color: #888=
888;" data-mce-style=3D"color: #888888;" color=3D"#888888">--<br> Thomas Pe=
tazzoni, CTO, Free Electrons<br> Embedded Linux, Kernel and Android enginee=
ring<br> <a href=3D"http://free-electrons.com" target=3D"_blank" data-mce-h=
ref=3D"http://free-electrons.com">http://free-electrons.com</a><br> </span>=
</span></blockquote></div><br></div></blockquote><div><br><br></div><div><b=
r></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br=
>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></div>=
</div></body></html>
------=_Part_77496_1356340737.1385704888471--


--===============0684654155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0684654155==--
