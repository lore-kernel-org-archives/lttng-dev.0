From: "Corbin, Craig" <ccorbi02@harris.com>
Subject: Lttng not producing trace files
Date: Tue, 9 Aug 2016 16:24:07 +0000
Message-ID: <1af4c52ad1c24d9d98c4d021bc369b64__16383.1635415137$1470770979$gmane$org@ROCXCH14.cs.myharris.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3184553945608591537=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from rocxsmtp1.harris.com (rocxsmtpout1.harris.com [192.158.6.51])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id DC570A0A5D
 for <lttng-dev@lists.lttng.org>; Tue,  9 Aug 2016 16:24:10 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3184553945608591537==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1af4c52ad1c24d9d98c4d021bc369b64ROCXCH14csmyharrisnet_"

--_000_1af4c52ad1c24d9d98c4d021bc369b64ROCXCH14csmyharrisnet_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am running lttng on an arm board. I am having an issue when tracing the k=
ernel, i don't have any trace file. I do notice i have a bunch of Unknown s=
ymbol outputs when spawning the session deamon. But if i run lttng create a=
gain i don't see these messages pop up. But the main issue is that if i do
#lttng create
#lttng enable-event --kernel --syscall --all
#lttng start
#lttng stop
I don't have anything in my trace session folder. I expected to see the tra=
ce file being dumped here after lttng stop.
Below is what i get the first time i run lttng create
# lttng create
Spawning a session daemon
[   74.874182] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_bu=
ffer_release_read (err 0)
[   74.883131] lttng_ring_buffer_client_discard: Unknown symbol channel_get=
_ring_buffer (err 0)
[   74.891602] lttng_ring_buffer_client_discard: Unknown symbol lttng_trans=
port_unregister (err 0)
[   74.900336] lttng_ring_buffer_client_discard: Unknown symbol channel_des=
troy (err 0)
[   74.908116] lttng_ring_buffer_client_discard: Unknown symbol _lib_ring_b=
uffer_memset (err 0)
[   74.916584] lttng_ring_buffer_client_discard: Unknown symbol _lib_ring_b=
uffer_write (err 0)
[   74.924967] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_bu=
ffer_offset_address (err 0)
[   74.934049] lttng_ring_buffer_client_discard: Unknown symbol _lib_ring_b=
uffer_strcpy_from_user_inatomic (err 0)
[   74.944188] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_bu=
ffer_reserve_slow (err 0)
[   74.953104] lttng_ring_buffer_client_discard: Unknown symbol lttng_last_=
tsc (err 0)
[   74.960790] lttng_ring_buffer_client_discard: Unknown symbol _lib_ring_b=
uffer_strcpy (err 0)
[   74.969261] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_bu=
ffer_read_offset_address (err 0)
[   74.978773] lttng_ring_buffer_client_discard: Unknown symbol _lib_ring_b=
uffer_copy_from_user_inatomic (err 0)
[   74.988724] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_bu=
ffer_nesting (err 0)
[   74.997202] lttng_ring_buffer_client_discard: Unknown symbol lttng_trans=
port_register (err 0)
[   75.005761] lttng_ring_buffer_client_discard: Unknown symbol lttng_trace=
_clock (err 0)
[   75.013709] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_bu=
ffer_open_read (err 0)
[   75.022343] lttng_ring_buffer_client_discard: Unknown symbol channel_cre=
ate (err 0)
Session auto-19700101-000114 created.
Traces will be written in //lttng-traces/auto-19700101-000114


--_000_1af4c52ad1c24d9d98c4d021bc369b64ROCXCH14csmyharrisnet_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
code
	{mso-style-priority:99;
	font-family:"Courier New";}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;line-height:14.65pt;ba=
ckground:#F4EAEA">
<span style=3D"font-size:11.5pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#242729">I am running lttng on an arm board. I am having an issue when =
tracing the kernel, i don't have any trace file. I do notice i have a bunch=
 of Unknown symbol outputs when spawning the
 session deamon. But if i run lttng create again i don't see these messages=
 pop up. But the main issue is that if i do<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">#lttng create<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">#lttng enable-event --kernel --syscall --all<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">#lttng start<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">#lttng stop<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;line-height:14.65pt;ba=
ckground:#F4EAEA">
<span style=3D"font-size:11.5pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#242729">I don't have anything in my trace session folder. I expected t=
o see the trace file being dumped here after lttng stop.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;line-height:14.65pt;ba=
ckground:#F4EAEA">
<span style=3D"font-size:11.5pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#242729">Below is what i get the first time i run lttng create<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in"># lttng create<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">Spawning a session daemon<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.874182] lttng_ring_buffer_client_discard: Unkno=
wn symbol lib_ring_buffer_release_read (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.883131] lttng_ring_buffer_client_discard: Unkno=
wn symbol channel_get_ring_buffer (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.891602] lttng_ring_buffer_client_discard: Unkno=
wn symbol lttng_transport_unregister (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.900336] lttng_ring_buffer_client_discard: Unkno=
wn symbol channel_destroy (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.908116] lttng_ring_buffer_client_discard: Unkno=
wn symbol _lib_ring_buffer_memset (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.916584] lttng_ring_buffer_client_discard: Unkno=
wn symbol _lib_ring_buffer_write (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.924967] lttng_ring_buffer_client_discard: Unkno=
wn symbol lib_ring_buffer_offset_address (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.934049] lttng_ring_buffer_client_discard: Unkno=
wn symbol _lib_ring_buffer_strcpy_from_user_inatomic
 (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.944188] lttng_ring_buffer_client_discard: Unkno=
wn symbol lib_ring_buffer_reserve_slow (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.953104] lttng_ring_buffer_client_discard: Unkno=
wn symbol lttng_last_tsc (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.960790] lttng_ring_buffer_client_discard: Unkno=
wn symbol _lib_ring_buffer_strcpy (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.969261] lttng_ring_buffer_client_discard: Unkno=
wn symbol lib_ring_buffer_read_offset_address (err
 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.978773] lttng_ring_buffer_client_discard: Unkno=
wn symbol _lib_ring_buffer_copy_from_user_inatomic
 (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.988724] lttng_ring_buffer_client_discard: Unkno=
wn symbol lib_ring_buffer_nesting (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 74.997202] lttng_ring_buffer_client_discard: Unkno=
wn symbol lttng_transport_register (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 75.005761] lttng_ring_buffer_client_discard: Unkno=
wn symbol lttng_trace_clock (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 75.013709] lttng_ring_buffer_client_discard: Unkno=
wn symbol lib_ring_buffer_open_read (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">[&nbsp;&nbsp; 75.022343] lttng_ring_buffer_client_discard: Unkno=
wn symbol channel_create (err 0)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">Session auto-19700101-000114 created.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-siz=
e:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pa=
dding:0in">Traces will be written in //lttng-traces/auto-19700101-000114</s=
pan><span style=3D"font-size:10.0pt;font-family:Consolas;color:#242729"><o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_1af4c52ad1c24d9d98c4d021bc369b64ROCXCH14csmyharrisnet_--

--===============3184553945608591537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3184553945608591537==--
