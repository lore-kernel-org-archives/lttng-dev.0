From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [PATCH lttng-tool] Fix: out-of-tree build: missing
 xsd file for mi tests and save-load tests
Date: Wed, 28 Jan 2015 17:08:08 -0500
Message-ID: <CAF4oYfEmqYYyE02d9+dZeXZkXs0j1kQBwWR8Dp8ry6GMdbuV7g__29012.5030246147$1422482926$gmane$org@mail.gmail.com>
References: <1422481529-5558-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxtm72VU_nymzrqmr4rJ4bQ0Uc8je7KjaaTnHqbCVRXc1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2062590387=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1YGamU-0008S5-EF
 for lttng-dev@lists.lttng.org; Wed, 28 Jan 2015 17:08:16 -0500
Received: by mail-yk0-f175.google.com with SMTP id 9so10382484ykp.6
 for <lttng-dev@lists.lttng.org>; Wed, 28 Jan 2015 14:08:08 -0800 (PST)
In-Reply-To: <CA+jJMxtm72VU_nymzrqmr4rJ4bQ0Uc8je7KjaaTnHqbCVRXc1A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2062590387==
Content-Type: multipart/alternative; boundary=089e016341e649bbc8050dbd9b1f

--089e016341e649bbc8050dbd9b1f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 4:57 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Wed, Jan 28, 2015 at 4:45 PM, Jonathan Rajotte
> <jonathan.rajotte-julien@efficios.com> wrote:
> > Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> > ---
> >  src/common/Makefile.am        | 14 ++++++++++++++
> >  src/common/config/Makefile.am | 14 ++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> > index 3a2f4f0..97d0ecc 100644
> > --- a/src/common/Makefile.am
> > +++ b/src/common/Makefile.am
> > @@ -41,3 +41,17 @@ if HAVE_LIBLTTNG_UST_CTL
> >  libconsumer_la_LIBADD +=3D \
> >                 $(top_builddir)/src/common/ust-consumer/
> libust-consumer.la
> >  endif
> > +
> > +all-local:
> > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> > +               for script in $(EXTRA_DIST); do \
>
> Just curious, why name this variable "script"?
>

Mostly to be consistent across all makefile concerning the copy of
EXTRA_DIST to the $build_dir when doing out of tree build and distribution
build.

You can run grep -rnw ./ -e " EXTRA_DIST" in tools directory to see the
current trend of using script for  naming the temp file variable.

I don't mind renaming it if you find it ambiguous.

Cheers!

Jonathan

>
> J=C3=A9r=C3=A9mie
>
> > +               cp -f $(srcdir)/$$script $(builddir); \
> > +               done; \
> > +       fi
> > +
> > +clean-local:
> > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> > +               for script in $(EXTRA_DIST); do \
> > +               rm -f $(builddir)/$$script; \
> > +               done; \
> > +       fi
> > diff --git a/src/common/config/Makefile.am
> b/src/common/config/Makefile.am
> > index 5acc89d..e36b42f 100644
> > --- a/src/common/config/Makefile.am
> > +++ b/src/common/config/Makefile.am
> > @@ -9,3 +9,17 @@ libconfig_la_LIBADD =3D $(XML_LIBS)
> >  xmldir =3D $(datadir)/xml/lttng
> >  dist_xml_DATA =3D session.xsd
> >  EXTRA_DIST =3D session.xsd
> > +
> > +all-local:
> > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> > +               for script in $(EXTRA_DIST); do \
> > +               cp -f $(srcdir)/$$script $(builddir); \
> > +               done; \
> > +       fi
> > +
> > +clean-local:
> > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> > +               for script in $(EXTRA_DIST); do \
> > +               rm -f $(builddir)/$$script; \
> > +               done; \
> > +       fi
> > --
> > 1.9.1
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--089e016341e649bbc8050dbd9b1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Jan 28, 2015 at 4:57 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_b=
lank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><span class=3D"">On Wed, Jan 28, 2015 =
at 4:45 PM, Jonathan Rajotte<br>
&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajott=
e-julien@efficios.com</a>&gt; wrote:<br>
&gt; Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.rajotte=
-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/common/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++++++=
+++++<br>
&gt;=C2=A0 src/common/config/Makefile.am | 14 ++++++++++++++<br>
&gt;=C2=A0 2 files changed, 28 insertions(+)<br>
&gt;<br>
&gt; diff --git a/src/common/Makefile.am b/src/common/Makefile.am<br>
&gt; index 3a2f4f0..97d0ecc 100644<br>
&gt; --- a/src/common/Makefile.am<br>
&gt; +++ b/src/common/Makefile.am<br>
&gt; @@ -41,3 +41,17 @@ if HAVE_LIBLTTNG_UST_CTL<br>
&gt;=C2=A0 libconsumer_la_LIBADD +=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_bui=
lddir)/src/common/ust-consumer/<a href=3D"http://libust-consumer.la" target=
=3D"_blank">libust-consumer.la</a><br>
&gt;=C2=A0 endif<br>
&gt; +<br>
&gt; +all-local:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x&quot;$(srcdir)&quot; !=3D x&quot;$=
(builddir)&quot; ]; then \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for script in =
$(EXTRA_DIST); do \<br>
<br>
</span>Just curious, why name this variable &quot;script&quot;?<br></blockq=
uote><div><br></div><div>Mostly to be consistent across all makefile concer=
ning the copy of EXTRA_DIST to the $build_dir when doing out of tree build =
and distribution build.<br><br></div><div>You can run grep -rnw ./ -e &quot=
; EXTRA_DIST&quot; in tools directory to see the current trend of using scr=
ipt for=C2=A0 naming the temp file variable.<br><br></div><div>I don&#39;t =
mind renaming it if you find it ambiguous.<br><br></div><div>Cheers!<br><br=
></div><div>Jonathan<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
J=C3=A9r=C3=A9mie<br>
<div class=3D""><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cp -f $(srcdir=
)/$$script $(builddir); \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +<br>
&gt; +clean-local:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x&quot;$(srcdir)&quot; !=3D x&quot;$=
(builddir)&quot; ]; then \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for script in =
$(EXTRA_DIST); do \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f $(buildd=
ir)/$$script; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt; diff --git a/src/common/config/Makefile.am b/src/common/config/Makefil=
e.am<br>
&gt; index 5acc89d..e36b42f 100644<br>
&gt; --- a/src/common/config/Makefile.am<br>
&gt; +++ b/src/common/config/Makefile.am<br>
&gt; @@ -9,3 +9,17 @@ libconfig_la_LIBADD =3D $(XML_LIBS)<br>
&gt;=C2=A0 xmldir =3D $(datadir)/xml/lttng<br>
&gt;=C2=A0 dist_xml_DATA =3D session.xsd<br>
&gt;=C2=A0 EXTRA_DIST =3D session.xsd<br>
&gt; +<br>
&gt; +all-local:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x&quot;$(srcdir)&quot; !=3D x&quot;$=
(builddir)&quot; ]; then \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for script in =
$(EXTRA_DIST); do \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cp -f $(srcdir=
)/$$script $(builddir); \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt; +<br>
&gt; +clean-local:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x&quot;$(srcdir)&quot; !=3D x&quot;$=
(builddir)&quot; ]; then \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for script in =
$(EXTRA_DIST); do \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f $(buildd=
ir)/$$script; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done; \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D""><font color=3D"#888888">--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span><div class=3D""><div class=3D"h5"><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</div></div></blockquote></div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=
<br></div></div></div></div>
</div></div>

--089e016341e649bbc8050dbd9b1f--


--===============2062590387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2062590387==--
