From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH] Use uint32_t for
	lttng_viewer_stream.metadata_flag
Date: Fri, 17 Jan 2014 21:31:51 -0500
Message-ID: <CAFXXi0nYX8xQAvDW+uox6bfx0ODa2Rdr4ex35pP8PmXotnMjyg__1766.64494579217$1390012400$gmane$org@mail.gmail.com>
References: <1390002463-21184-1-git-send-email-marc-andre.laperle@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1799498602=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1W4Lhy-00030d-TD
	for lttng-dev@lists.lttng.org; Fri, 17 Jan 2014 21:32:29 -0500
Received: by mail-ie0-f178.google.com with SMTP id x13so6192126ief.23
	for <lttng-dev@lists.lttng.org>; Fri, 17 Jan 2014 18:32:21 -0800 (PST)
In-Reply-To: <1390002463-21184-1-git-send-email-marc-andre.laperle@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marc-Andre Laperle <marc-andre.laperle@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1799498602==
Content-Type: multipart/alternative; boundary=001a11348574d7784304f035779d

--001a11348574d7784304f035779d
Content-Type: text/plain; charset=ISO-8859-1

While you are at it, you could change the char fields as well, since char
is not exact-width either.


On 17 January 2014 18:47, Marc-Andre Laperle <
marc-andre.laperle@ericsson.com> wrote:

> This struct is meant to be sent over the network so members should be
> of exact-width.
>
> Signed-off-by: Marc-Andre Laperle <marc-andre.laperle@ericsson.com>
> ---
>  src/bin/lttng-relayd/lttng-viewer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/bin/lttng-relayd/lttng-viewer.h
> b/src/bin/lttng-relayd/lttng-viewer.h
> index 1977a43..6330270 100644
> --- a/src/bin/lttng-relayd/lttng-viewer.h
> +++ b/src/bin/lttng-relayd/lttng-viewer.h
> @@ -100,7 +100,7 @@ struct lttng_viewer_session {
>  struct lttng_viewer_stream {
>         uint64_t id;
>         uint64_t ctf_trace_id;
> -       int metadata_flag;
> +       uint32_t metadata_flag;
>         char path_name[LTTNG_VIEWER_PATH_MAX];
>         char channel_name[LTTNG_VIEWER_NAME_MAX];
>  } __attribute__((__packed__));
> --
> 1.8.3.2
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--001a11348574d7784304f035779d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">While you are at it, you could change the char fields as w=
ell, since char is not exact-width either.</div><div class=3D"gmail_extra">=
<br><br><div class=3D"gmail_quote">On 17 January 2014 18:47, Marc-Andre Lap=
erle <span dir=3D"ltr">&lt;<a href=3D"mailto:marc-andre.laperle@ericsson.co=
m" target=3D"_blank">marc-andre.laperle@ericsson.com</a>&gt;</span> wrote:<=
br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This struct is meant to be sent over the net=
work so members should be<br>
of exact-width.<br>
<br>
Signed-off-by: Marc-Andre Laperle &lt;<a href=3D"mailto:marc-andre.laperle@=
ericsson.com">marc-andre.laperle@ericsson.com</a>&gt;<br>
---<br>
=A0src/bin/lttng-relayd/lttng-viewer.h | 2 +-<br>
=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/src/bin/lttng-relayd/lttng-viewer.h b/src/bin/lttng-relayd/ltt=
ng-viewer.h<br>
index 1977a43..6330270 100644<br>
--- a/src/bin/lttng-relayd/lttng-viewer.h<br>
+++ b/src/bin/lttng-relayd/lttng-viewer.h<br>
@@ -100,7 +100,7 @@ struct lttng_viewer_session {<br>
=A0struct lttng_viewer_stream {<br>
=A0 =A0 =A0 =A0 uint64_t id;<br>
=A0 =A0 =A0 =A0 uint64_t ctf_trace_id;<br>
- =A0 =A0 =A0 int metadata_flag;<br>
+ =A0 =A0 =A0 uint32_t metadata_flag;<br>
=A0 =A0 =A0 =A0 char path_name[LTTNG_VIEWER_PATH_MAX];<br>
=A0 =A0 =A0 =A0 char channel_name[LTTNG_VIEWER_NAME_MAX];<br>
=A0} __attribute__((__packed__));<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.3.2<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br></div>

--001a11348574d7784304f035779d--


--===============1799498602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1799498602==--
