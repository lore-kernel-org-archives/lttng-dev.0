From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] Correct LTTng version
Date: Tue, 12 Mar 2013 17:34:57 -0400
Message-ID: <513F9F81.9040909__7176.47059723294$1363124156$gmane$org@gmail.com>
References: <14dbf3b61272282c1f4163c8a1a2f2b681f3989c.1363123481.git.raphael.beamonte@gmail.com>
	<513F9DF1.9030909@efficios.com>
	<CAE_Gge0+ympRPULDhugMjFCxDrs49t3wJy9BRbOUYNkyfCoU_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0116816931=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UFWqg-0003UM-5i
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 17:35:06 -0400
Received: by mail-vc0-f177.google.com with SMTP id m18so177436vcm.8
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 14:35:00 -0700 (PDT)
In-Reply-To: <CAE_Gge0+ympRPULDhugMjFCxDrs49t3wJy9BRbOUYNkyfCoU_A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0116816931==
Content-Type: multipart/alternative;
 boundary="------------050803010509080305000108"

This is a multi-part message in MIME format.
--------------050803010509080305000108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r2CLZ8eb022579

Maybe we should find a way to add the git commit id and maybe other git
info to the version display when we build it from git.

On 2013-03-12 17:31, Rapha=EBl Beamonte wrote:
> Hi David,
>
> The tag version changed in LTTng but not the displayed version, and it
> made me remove the whole LTTng tools from my computer and reinstall
> them as I didn't understand why the version number displayed wasn't
> the one from the version I was installing. It's not a very important
> bug, but it could be a time consumer one...
>
> Rapha=EBl
>
> 2013/3/12 David Goulet <dgoulet@efficios.com
> <mailto:dgoulet@efficios.com>>
>
>     Hi Rapha=EBl,
>
>     This is not very relevant because we branch at each release so the
>     master version is a bit useless.
>
>     Do you have a need for that?
>
>     Thanks
>     David
>
>     Rapha=EBl Beamonte:
>     > Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com
>     <mailto:raphael.beamonte@gmail.com>>
>     > ---
>     >  configure.ac <http://configure.ac> |    2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/configure.ac <http://configure.ac> b/configure.ac
>     <http://configure.ac>
>     > index 7e35c06..c8aa034 100644
>     > --- a/configure.ac <http://configure.ac>
>     > +++ b/configure.ac <http://configure.ac>
>     > @@ -1,4 +1,4 @@
>     > -AC_INIT([lttng-tools],[2.1.0],[dgoulet@efficios.com
>     <mailto:dgoulet@efficios.com>],[],[http://lttng.org])
>     > +AC_INIT([lttng-tools],[2.1.1],[dgoulet@efficios.com
>     <mailto:dgoulet@efficios.com>],[],[http://lttng.org])
>     >  AC_CONFIG_AUX_DIR([config])
>     >  AC_CANONICAL_TARGET
>     >  AC_CANONICAL_HOST
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------050803010509080305000108
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Maybe we should find a way to add the git commit id and maybe other
    git info to the version display when we build it from git. <br>
    <br>
    On 2013-03-12 17:31, Rapha&euml;l Beamonte wrote:
    <blockquote
cite="mid:CAE_Gge0+ympRPULDhugMjFCxDrs49t3wJy9BRbOUYNkyfCoU_A@mail.gmail.com"
      type="cite">Hi David,<br>
      <br>
      The tag version changed in LTTng but not the displayed version,
      and it made me remove the whole LTTng tools from my computer and
      reinstall them as I didn't understand why the version number
      displayed wasn't the one from the version I was installing. It's
      not a very important bug, but it could be a time consumer one...<br>
      <br>
      Rapha&euml;l<br>
      <br>
      <div class="gmail_quote">2013/3/12 David Goulet <span dir="ltr">&lt;<a
            moz-do-not-send="true" href="mailto:dgoulet@efficios.com"
            target="_blank">dgoulet@efficios.com</a>&gt;</span><br>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          Hi Rapha&euml;l,<br>
          <br>
          This is not very relevant because we branch at each release so
          the<br>
          master version is a bit useless.<br>
          <br>
          Do you have a need for that?<br>
          <br>
          Thanks<br>
          David<br>
          <br>
          Rapha&euml;l Beamonte:<br>
          <div class="HOEnZb">
            <div class="h5">&gt; Signed-off-by: Rapha&euml;l Beamonte &lt;<a
                moz-do-not-send="true"
                href="mailto:raphael.beamonte@gmail.com">raphael.beamonte@gmail.com</a>&gt;<br>
              &gt; ---<br>
              &gt; &nbsp;<a moz-do-not-send="true" href="http://configure.ac"
                target="_blank">configure.ac</a> | &nbsp; &nbsp;2 +-<br>
              &gt; &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
              &gt;<br>
              &gt; diff --git a/<a moz-do-not-send="true"
                href="http://configure.ac" target="_blank">configure.ac</a>
              b/<a moz-do-not-send="true" href="http://configure.ac"
                target="_blank">configure.ac</a><br>
              &gt; index 7e35c06..c8aa034 100644<br>
              &gt; --- a/<a moz-do-not-send="true"
                href="http://configure.ac" target="_blank">configure.ac</a><br>
              &gt; +++ b/<a moz-do-not-send="true"
                href="http://configure.ac" target="_blank">configure.ac</a><br>
              &gt; @@ -1,4 +1,4 @@<br>
              &gt; -AC_INIT([lttng-tools],[2.1.0],[<a
                moz-do-not-send="true"
                href="mailto:dgoulet@efficios.com">dgoulet@efficios.com</a>],[],[<a
                moz-do-not-send="true" href="http://lttng.org"
                target="_blank">http://lttng.org</a>])<br>
              &gt; +AC_INIT([lttng-tools],[2.1.1],[<a
                moz-do-not-send="true"
                href="mailto:dgoulet@efficios.com">dgoulet@efficios.com</a>],[],[<a
                moz-do-not-send="true" href="http://lttng.org"
                target="_blank">http://lttng.org</a>])<br>
              &gt; &nbsp;AC_CONFIG_AUX_DIR([config])<br>
              &gt; &nbsp;AC_CANONICAL_TARGET<br>
              &gt; &nbsp;AC_CANONICAL_HOST<br>
            </div>
          </div>
        </blockquote>
      </div>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------050803010509080305000108--


--===============0116816931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0116816931==--
