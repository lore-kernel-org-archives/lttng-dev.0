From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: out-of-tree build: missing
 xsd file for mi tests and save-load tests
Date: Thu, 29 Jan 2015 17:53:21 -0500
Message-ID: <54CAB9E1.2080508__18314.0296875083$1422572042$gmane$org@efficios.com>
References: <1422481529-5558-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <CA+jJMxtm72VU_nymzrqmr4rJ4bQ0Uc8je7KjaaTnHqbCVRXc1A@mail.gmail.com>
 <CAF4oYfEmqYYyE02d9+dZeXZkXs0j1kQBwWR8Dp8ry6GMdbuV7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1303339498=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YGxxq-0007HJ-0B
 for lttng-dev@lists.lttng.org; Thu, 29 Jan 2015 17:53:31 -0500
In-Reply-To: <CAF4oYfEmqYYyE02d9+dZeXZkXs0j1kQBwWR8Dp8ry6GMdbuV7g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1303339498==
Content-Type: multipart/alternative;
 boundary="------------070205010908010702040406"

This is a multi-part message in MIME format.
--------------070205010908010702040406
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

This patch need to be split to backport the save-load fix part up to 2.5.

Patch set incoming shortly

Cheers!


On 15-01-28 05:08 PM, Jonathan Rajotte wrote:
>
>
> On Wed, Jan 28, 2015 at 4:57 PM, J=C3=A9r=C3=A9mie Galarneau=20
> <jeremie.galarneau@efficios.com=20
> <mailto:jeremie.galarneau@efficios.com>> wrote:
>
>     On Wed, Jan 28, 2015 at 4:45 PM, Jonathan Rajotte
>     <jonathan.rajotte-julien@efficios.com
>     <mailto:jonathan.rajotte-julien@efficios.com>> wrote:
>     > Signed-off-by: Jonathan Rajotte
>     <jonathan.rajotte-julien@efficios.com
>     <mailto:jonathan.rajotte-julien@efficios.com>>
>     > ---
>     >  src/common/Makefile.am        | 14 ++++++++++++++
>     >  src/common/config/Makefile.am | 14 ++++++++++++++
>     >  2 files changed, 28 insertions(+)
>     >
>     > diff --git a/src/common/Makefile.am b/src/common/Makefile.am
>     > index 3a2f4f0..97d0ecc 100644
>     > --- a/src/common/Makefile.am
>     > +++ b/src/common/Makefile.am
>     > @@ -41,3 +41,17 @@ if HAVE_LIBLTTNG_UST_CTL
>     >  libconsumer_la_LIBADD +=3D \
>     >  $(top_builddir)/src/common/ust-consumer/libust-consumer.la
>     <http://libust-consumer.la>
>     >  endif
>     > +
>     > +all-local:
>     > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>     > +               for script in $(EXTRA_DIST); do \
>
>     Just curious, why name this variable "script"?
>
>
> Mostly to be consistent across all makefile concerning the copy of=20
> EXTRA_DIST to the $build_dir when doing out of tree build and=20
> distribution build.
>
> You can run grep -rnw ./ -e " EXTRA_DIST" in tools directory to see=20
> the current trend of using script for naming the temp file variable.
>
> I don't mind renaming it if you find it ambiguous.
>
> Cheers!
>
> Jonathan
>
>
>     J=C3=A9r=C3=A9mie
>
>     > +               cp -f $(srcdir)/$$script $(builddir); \
>     > +               done; \
>     > +       fi
>     > +
>     > +clean-local:
>     > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>     > +               for script in $(EXTRA_DIST); do \
>     > +               rm -f $(builddir)/$$script; \
>     > +               done; \
>     > +       fi
>     > diff --git a/src/common/config/Makefile.am
>     b/src/common/config/Makefile.am
>     > index 5acc89d..e36b42f 100644
>     > --- a/src/common/config/Makefile.am
>     > +++ b/src/common/config/Makefile.am
>     > @@ -9,3 +9,17 @@ libconfig_la_LIBADD =3D $(XML_LIBS)
>     >  xmldir =3D $(datadir)/xml/lttng
>     >  dist_xml_DATA =3D session.xsd
>     >  EXTRA_DIST =3D session.xsd
>     > +
>     > +all-local:
>     > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>     > +               for script in $(EXTRA_DIST); do \
>     > +               cp -f $(srcdir)/$$script $(builddir); \
>     > +               done; \
>     > +       fi
>     > +
>     > +clean-local:
>     > +       @if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
>     > +               for script in $(EXTRA_DIST); do \
>     > +               rm -f $(builddir)/$$script; \
>     > +               done; \
>     > +       fi
>     > --
>     > 1.9.1
>     >
>
>
>
>     --
>     J=C3=A9r=C3=A9mie Galarneau
>     EfficiOS Inc.
>     http://www.efficios.com
>
>     _______________________________________________
>     lttng-dev mailing list
>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>     http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--=20
Jonathan R. Julien
Efficios


--------------070205010908010702040406
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body>
    This patch need to be split to backport the save-load fix part up to
    2.5.<br>
    <br>
    Patch set incoming shortly<br>
    <br>
    Cheers!<br>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 15-01-28 05:08 PM, Jonathan Rajotte
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAF4oYfEmqYYyE02d9+dZeXZkXs0j1kQBwWR8Dp8ry6GMdbuV7g@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr"><br>
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Wed, Jan 28, 2015 at 4:57 PM,
            J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a
                moz-do-not-send=3D"true"
                href=3D"mailto:jeremie.galarneau@efficios.com"
                target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;<=
/span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex"><span class=3D"">On Wed,
                Jan 28, 2015 at 4:45 PM, Jonathan Rajotte<br>
                &lt;<a moz-do-not-send=3D"true"
                  href=3D"mailto:jonathan.rajotte-julien@efficios.com">jo=
nathan.rajotte-julien@efficios.com</a>&gt;
                wrote:<br>
                &gt; Signed-off-by: Jonathan Rajotte &lt;<a
                  moz-do-not-send=3D"true"
                  href=3D"mailto:jonathan.rajotte-julien@efficios.com">jo=
nathan.rajotte-julien@efficios.com</a>&gt;<br>
                &gt; ---<br>
                &gt;=C2=A0 src/common/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 14 ++++++++++++++<br>
                &gt;=C2=A0 src/common/config/Makefile.am | 14 +++++++++++=
+++<br>
                &gt;=C2=A0 2 files changed, 28 insertions(+)<br>
                &gt;<br>
                &gt; diff --git a/src/common/Makefile.am
                b/src/common/Makefile.am<br>
                &gt; index 3a2f4f0..97d0ecc 100644<br>
                &gt; --- a/src/common/Makefile.am<br>
                &gt; +++ b/src/common/Makefile.am<br>
                &gt; @@ -41,3 +41,17 @@ if HAVE_LIBLTTNG_UST_CTL<br>
                &gt;=C2=A0 libconsumer_la_LIBADD +=3D \<br>
                &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                =C2=A0$(top_builddir)/src/common/ust-consumer/<a
                  moz-do-not-send=3D"true"
                  href=3D"http://libust-consumer.la" target=3D"_blank">li=
bust-consumer.la</a><br>
                &gt;=C2=A0 endif<br>
                &gt; +<br>
                &gt; +all-local:<br>
                &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x"$(srcdir)" !=3D =
x"$(builddir)" ];
                then \<br>
                &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for script in $(EXTRA_DIST); do \<br>
                <br>
              </span>Just curious, why name this variable "script"?<br>
            </blockquote>
            <div><br>
            </div>
            <div>Mostly to be consistent across all makefile concerning
              the copy of EXTRA_DIST to the $build_dir when doing out of
              tree build and distribution build.<br>
              <br>
            </div>
            <div>You can run grep -rnw ./ -e " EXTRA_DIST" in tools
              directory to see the current trend of using script for=C2=A0
              naming the temp file variable.<br>
              <br>
            </div>
            <div>I don't mind renaming it if you find it ambiguous.<br>
              <br>
            </div>
            <div>Cheers!<br>
              <br>
            </div>
            <div>Jonathan<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">
              <br>
              J=C3=A9r=C3=A9mie<br>
              <div class=3D"">
                <div class=3D"h5"><br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cp -f $(srcdir)/$$script
                  $(builddir); \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0done; \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
                  &gt; +<br>
                  &gt; +clean-local:<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x"$(srcdir)" !=3D=
 x"$(builddir)" ];
                  then \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for script in $(EXTRA_DIST); do \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0rm -f $(builddir)/$$script; \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0done; \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
                  &gt; diff --git a/src/common/config/Makefile.am
                  b/src/common/config/Makefile.am<br>
                  &gt; index 5acc89d..e36b42f 100644<br>
                  &gt; --- a/src/common/config/Makefile.am<br>
                  &gt; +++ b/src/common/config/Makefile.am<br>
                  &gt; @@ -9,3 +9,17 @@ libconfig_la_LIBADD =3D
                  $(XML_LIBS)<br>
                  &gt;=C2=A0 xmldir =3D $(datadir)/xml/lttng<br>
                  &gt;=C2=A0 dist_xml_DATA =3D session.xsd<br>
                  &gt;=C2=A0 EXTRA_DIST =3D session.xsd<br>
                  &gt; +<br>
                  &gt; +all-local:<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x"$(srcdir)" !=3D=
 x"$(builddir)" ];
                  then \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for script in $(EXTRA_DIST); do \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cp -f $(srcdir)/$$script
                  $(builddir); \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0done; \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
                  &gt; +<br>
                  &gt; +clean-local:<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0@if [ x"$(srcdir)" !=3D=
 x"$(builddir)" ];
                  then \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0for script in $(EXTRA_DIST); do \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0rm -f $(builddir)/$$script; \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0done; \<br>
                  &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
                  &gt; --<br>
                  &gt; 1.9.1<br>
                  &gt;<br>
                  <br>
                  <br>
                  <br>
                </div>
              </div>
              <span class=3D""><font color=3D"#888888">--<br>
                  J=C3=A9r=C3=A9mie Galarneau<br>
                  EfficiOS Inc.<br>
                  <a moz-do-not-send=3D"true"
                    href=3D"http://www.efficios.com" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
                </font></span>
              <div class=3D"">
                <div class=3D"h5"><br>
                  _______________________________________________<br>
                  lttng-dev mailing list<br>
                  <a moz-do-not-send=3D"true"
                    href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@l=
ists.lttng.org</a><br>
                  <a moz-do-not-send=3D"true"
                    href=3D"http://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev"
                    target=3D"_blank">http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev</a><br>
                </div>
              </div>
            </blockquote>
          </div>
          <div dir=3D"ltr">
            <div>
              <div dir=3D"ltr">
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------070205010908010702040406--


--===============1303339498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1303339498==--
