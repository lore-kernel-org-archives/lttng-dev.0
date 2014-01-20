From: =?iso-8859-1?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Subject: Re: [PATCH] Use uint32_t for
 lttng_viewer_stream.metadata_flag
Date: Mon, 20 Jan 2014 20:25:07 +0000
Message-ID: <D381217948BF4C45AF756AFC995BEB9F1C1A2A4D__16871.1262442686$1390249583$gmane$org@eusaamb103.ericsson.se>
References: <1390002463-21184-1-git-send-email-marc-andre.laperle@ericsson.com>,
	<CAFXXi0nYX8xQAvDW+uox6bfx0ODa2Rdr4ex35pP8PmXotnMjyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1285905083=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <marc-andre.laperle@ericsson.com>) id 1W5LPG-0008Em-2N
	for lttng-dev@lists.lttng.org; Mon, 20 Jan 2014 15:25:19 -0500
In-Reply-To: <CAFXXi0nYX8xQAvDW+uox6bfx0ODa2Rdr4ex35pP8PmXotnMjyg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1285905083==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D381217948BF4C45AF756AFC995BEB9F1C1A2A4Deusaamb103erics_"

--_000_D381217948BF4C45AF756AFC995BEB9F1C1A2A4Deusaamb103erics_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm not sure that's possible. Whether I change them to uint8_t or int8_t, I=
 get warnings because they get used with strncpy which wants char. Any idea=
 how to solve this?

Marc-Andr=E9

________________________________
From: thundersim@gmail.com [thundersim@gmail.com] on behalf of Simon Marchi=
 [simon.marchi@polymtl.ca]
Sent: Friday, 17 January 2014 9:31 PM
To: Marc-Andr=E9 Laperle
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH] Use uint32_t for lttng_viewer_stream.metad=
ata_flag

While you are at it, you could change the char fields as well, since char i=
s not exact-width either.


On 17 January 2014 18:47, Marc-Andre Laperle <marc-andre.laperle@ericsson.c=
om<mailto:marc-andre.laperle@ericsson.com>> wrote:
This struct is meant to be sent over the network so members should be
of exact-width.

Signed-off-by: Marc-Andre Laperle <marc-andre.laperle@ericsson.com<mailto:m=
arc-andre.laperle@ericsson.com>>
---
 src/bin/lttng-relayd/lttng-viewer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/lttng-viewer.h b/src/bin/lttng-relayd/ltt=
ng-viewer.h
index 1977a43..6330270 100644
--- a/src/bin/lttng-relayd/lttng-viewer.h
+++ b/src/bin/lttng-relayd/lttng-viewer.h
@@ -100,7 +100,7 @@ struct lttng_viewer_session {
 struct lttng_viewer_stream {
        uint64_t id;
        uint64_t ctf_trace_id;
-       int metadata_flag;
+       uint32_t metadata_flag;
        char path_name[LTTNG_VIEWER_PATH_MAX];
        char channel_name[LTTNG_VIEWER_NAME_MAX];
 } __attribute__((__packed__));
--
1.8.3.2


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--_000_D381217948BF4C45AF756AFC995BEB9F1C1A2A4Deusaamb103erics_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">I'm not sure that's possible. Whether I change them to uint8_t or in=
t8_t, I get warnings because they get used with strncpy which wants char. A=
ny idea how to solve this?<br>
<br>
Marc-Andr=E9<br>
<br>
<div style=3D"font-family: Times New Roman; color: #000000; font-size: 16px=
">
<hr tabindex=3D"-1">
<div style=3D"direction: ltr;" id=3D"divRpF924636"><font size=3D"2" color=
=3D"#000000" face=3D"Tahoma"><b>From:</b> thundersim@gmail.com [thundersim@=
gmail.com] on behalf of Simon Marchi [simon.marchi@polymtl.ca]<br>
<b>Sent:</b> Friday, 17 January 2014 9:31 PM<br>
<b>To:</b> Marc-Andr=E9 Laperle<br>
<b>Cc:</b> lttng-dev@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] [PATCH] Use uint32_t for lttng_viewer_strea=
m.metadata_flag<br>
</font><br>
</div>
<div></div>
<div>
<div dir=3D"ltr">While you are at it, you could change the char fields as w=
ell, since char is not exact-width either.</div>
<div class=3D"gmail_extra"><br>
<br>
<div class=3D"gmail_quote">On 17 January 2014 18:47, Marc-Andre Laperle <sp=
an dir=3D"ltr">
&lt;<a href=3D"mailto:marc-andre.laperle@ericsson.com" target=3D"_blank">ma=
rc-andre.laperle@ericsson.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
This struct is meant to be sent over the network so members should be<br>
of exact-width.<br>
<br>
Signed-off-by: Marc-Andre Laperle &lt;<a href=3D"mailto:marc-andre.laperle@=
ericsson.com" target=3D"_blank">marc-andre.laperle@ericsson.com</a>&gt;<br>
---<br>
&nbsp;src/bin/lttng-relayd/lttng-viewer.h | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/src/bin/lttng-relayd/lttng-viewer.h b/src/bin/lttng-relayd/ltt=
ng-viewer.h<br>
index 1977a43..6330270 100644<br>
--- a/src/bin/lttng-relayd/lttng-viewer.h<br>
&#43;&#43;&#43; b/src/bin/lttng-relayd/lttng-viewer.h<br>
@@ -100,7 &#43;100,7 @@ struct lttng_viewer_session {<br>
&nbsp;struct lttng_viewer_stream {<br>
&nbsp; &nbsp; &nbsp; &nbsp; uint64_t id;<br>
&nbsp; &nbsp; &nbsp; &nbsp; uint64_t ctf_trace_id;<br>
- &nbsp; &nbsp; &nbsp; int metadata_flag;<br>
&#43; &nbsp; &nbsp; &nbsp; uint32_t metadata_flag;<br>
&nbsp; &nbsp; &nbsp; &nbsp; char path_name[LTTNG_VIEWER_PATH_MAX];<br>
&nbsp; &nbsp; &nbsp; &nbsp; char channel_name[LTTNG_VIEWER_NAME_MAX];<br>
&nbsp;} __attribute__((__packed__));<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.3.2<br>
<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_D381217948BF4C45AF756AFC995BEB9F1C1A2A4Deusaamb103erics_--


--===============1285905083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1285905083==--
