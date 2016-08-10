From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng not producing trace files
Date: Wed, 10 Aug 2016 15:11:09 +0000 (UTC)
Message-ID: <1157074173.7177.1470841869819.JavaMail.zimbra__41206.0875831687$1470841888$gmane$org@efficios.com>
References: <1af4c52ad1c24d9d98c4d021bc369b64@ROCXCH14.cs.myharris.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5936928993850252535=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9E2A4A03A3
 for <lttng-dev@lists.lttng.org>; Wed, 10 Aug 2016 15:11:15 +0000 (UTC)
In-Reply-To: <1af4c52ad1c24d9d98c4d021bc369b64@ROCXCH14.cs.myharris.net>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Corbin, Craig" <ccorbi02@harris.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5936928993850252535==
Content-Type: multipart/alternative;
	boundary="=_8f38d8c6-fc60-4a45-bc49-1c393fea25b4"

--=_8f38d8c6-fc60-4a45-bc49-1c393fea25b4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Aug 9, 2016, at 12:24 PM, Corbin, Craig <ccorbi02@harris.com> wrote: 

> I am running lttng on an arm board. I am having an issue when tracing the
> kernel, i don't have any trace file. I do notice i have a bunch of Unknown
> symbol outputs when spawning the session deamon. But if i run lttng create
> again i don't see these messages pop up. But the main issue is that if i do

> #lttng create

> #lttng enable-event --kernel --syscall --all

> #lttng start

> #lttng stop

> I don't have anything in my trace session folder. I expected to see the trace
> file being dumped here after lttng stop.

> Below is what i get the first time i run lttng create

> # lttng create

> Spawning a session daemon

> [ 74.874182] lttng_ring_buffer_client_discard: Unknown symbol
> lib_ring_buffer_release_read (err 0)

> [ 74.883131] lttng_ring_buffer_client_discard: Unknown symbol
> channel_get_ring_buffer (err 0)

> [ 74.891602] lttng_ring_buffer_client_discard: Unknown symbol
> lttng_transport_unregister (err 0)

> [ 74.900336] lttng_ring_buffer_client_discard: Unknown symbol channel_destroy
> (err 0)

> [ 74.908116] lttng_ring_buffer_client_discard: Unknown symbol
> _lib_ring_buffer_memset (err 0)

> [ 74.916584] lttng_ring_buffer_client_discard: Unknown symbol
> _lib_ring_buffer_write (err 0)

> [ 74.924967] lttng_ring_buffer_client_discard: Unknown symbol
> lib_ring_buffer_offset_address (err 0)

> [ 74.934049] lttng_ring_buffer_client_discard: Unknown symbol
> _lib_ring_buffer_strcpy_from_user_inatomic (err 0)

> [ 74.944188] lttng_ring_buffer_client_discard: Unknown symbol
> lib_ring_buffer_reserve_slow (err 0)

> [ 74.953104] lttng_ring_buffer_client_discard: Unknown symbol lttng_last_tsc
> (err 0)

> [ 74.960790] lttng_ring_buffer_client_discard: Unknown symbol
> _lib_ring_buffer_strcpy (err 0)

> [ 74.969261] lttng_ring_buffer_client_discard: Unknown symbol
> lib_ring_buffer_read_offset_address (err 0)

> [ 74.978773] lttng_ring_buffer_client_discard: Unknown symbol
> _lib_ring_buffer_copy_from_user_inatomic (err 0)

> [ 74.988724] lttng_ring_buffer_client_discard: Unknown symbol
> lib_ring_buffer_nesting (err 0)

> [ 74.997202] lttng_ring_buffer_client_discard: Unknown symbol
> lttng_transport_register (err 0)

> [ 75.005761] lttng_ring_buffer_client_discard: Unknown symbol lttng_trace_clock
> (err 0)

> [ 75.013709] lttng_ring_buffer_client_discard: Unknown symbol
> lib_ring_buffer_open_read (err 0)

> [ 75.022343] lttng_ring_buffer_client_discard: Unknown symbol channel_create
> (err 0)

The warnings above should not be there. Make sure your kernel meets the lttng-modules 
README file requirements, and that you issued depmod -a. 

Perhaps try to rebuild/re-install lttng-modules. 

Thanks, 

Mathieu 

> Session auto-19700101-000114 created.

> Traces will be written in //lttng-traces/auto-19700101-000114

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_8f38d8c6-fc60-4a45-bc49-1c393fea25b4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Consolas;
=09panose-1:2 11 6 9 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
p
=09{mso-style-priority:99;
=09mso-margin-top-alt:auto;
=09margin-right:0in;
=09mso-margin-bottom-alt:auto;
=09margin-left:0in;
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
code
=09{mso-style-priority:99;
=09font-family:"Courier New";}
pre
=09{mso-style-priority:99;
=09mso-style-link:"HTML Preformatted Char";
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:10.0pt;
=09font-family:"Courier New";}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
span.HTMLPreformattedChar
=09{mso-style-name:"HTML Preformatted Char";
=09mso-style-priority:99;
=09mso-style-link:"HTML Preformatted";
=09font-family:"Courier New";}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DI=
VIDER__">----- On Aug 9, 2016, at 12:24 PM, Corbin, Craig &lt;ccorbi02@harr=
is.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSe=
ction1"><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;line-height:14=
.65pt;background:#F4EAEA"><span style=3D"font-size:11.5pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#242729">I am running lttng on an arm board. =
I am having an issue when tracing the kernel, i don't have any trace file. =
I do notice i have a bunch of Unknown symbol outputs when spawning the
 session deamon. But if i run lttng create again i don't see these messages=
 pop up. But the main issue is that if i do</span></p><p class=3D"MsoNormal=
" style=3D"background:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:=
Consolas;color:#242729;border:none windowtext 1.0pt;padding:0in">#lttng cre=
ate</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span sty=
le=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none windo=
wtext 1.0pt;padding:0in">#lttng enable-event --kernel --syscall --all</span=
></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"fon=
t-size:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0=
pt;padding:0in">#lttng start</span></p><p class=3D"MsoNormal" style=3D"back=
ground:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Consolas;color:=
#242729;border:none windowtext 1.0pt;padding:0in">#lttng stop</span></p><p =
class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;line-height:14.65pt;backg=
round:#F4EAEA"><span style=3D"font-size:11.5pt;font-family:&quot;Arial&quot=
;,sans-serif;color:#242729">I don't have anything in my trace session folde=
r. I expected to see the trace file being dumped here after lttng stop.</sp=
an></p><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;line-height:14.=
65pt;background:#F4EAEA"><span style=3D"font-size:11.5pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#242729">Below is what i get the first time i =
run lttng create</span></p><p class=3D"MsoNormal" style=3D"background:#F4EA=
EA"><span style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;bord=
er:none windowtext 1.0pt;padding:0in"># lttng create</span></p><p class=3D"=
MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-size:10.0pt;fon=
t-family:Consolas;color:#242729;border:none windowtext 1.0pt;padding:0in">S=
pawning a session daemon</span></p><p class=3D"MsoNormal" style=3D"backgrou=
nd:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Consolas;color:#242=
729;border:none windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.874182] lttn=
g_ring_buffer_client_discard: Unknown symbol lib_ring_buffer_release_read (=
err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span =
style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none wi=
ndowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.883131] lttng_ring_buffer_clie=
nt_discard: Unknown symbol channel_get_ring_buffer (err 0)</span></p><p cla=
ss=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-size:10.0=
pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;padding:=
0in">[&nbsp;&nbsp; 74.891602] lttng_ring_buffer_client_discard: Unknown sym=
bol lttng_transport_unregister (err 0)</span></p><p class=3D"MsoNormal" sty=
le=3D"background:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Conso=
las;color:#242729;border:none windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 7=
4.900336] lttng_ring_buffer_client_discard: Unknown symbol channel_destroy =
(err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span=
 style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none w=
indowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.908116] lttng_ring_buffer_cli=
ent_discard: Unknown symbol _lib_ring_buffer_memset (err 0)</span></p><p cl=
ass=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-size:10.=
0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;padding=
:0in">[&nbsp;&nbsp; 74.916584] lttng_ring_buffer_client_discard: Unknown sy=
mbol _lib_ring_buffer_write (err 0)</span></p><p class=3D"MsoNormal" style=
=3D"background:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Consola=
s;color:#242729;border:none windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.=
924967] lttng_ring_buffer_client_discard: Unknown symbol lib_ring_buffer_of=
fset_address (err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#=
F4EAEA"><span style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;=
border:none windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.934049] lttng_ri=
ng_buffer_client_discard: Unknown symbol _lib_ring_buffer_strcpy_from_user_=
inatomic
 (err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><spa=
n style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none =
windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.944188] lttng_ring_buffer_cl=
ient_discard: Unknown symbol lib_ring_buffer_reserve_slow (err 0)</span></p=
><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-si=
ze:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;p=
adding:0in">[&nbsp;&nbsp; 74.953104] lttng_ring_buffer_client_discard: Unkn=
own symbol lttng_last_tsc (err 0)</span></p><p class=3D"MsoNormal" style=3D=
"background:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Consolas;c=
olor:#242729;border:none windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.960=
790] lttng_ring_buffer_client_discard: Unknown symbol _lib_ring_buffer_strc=
py (err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><s=
pan style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:non=
e windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.969261] lttng_ring_buffer_=
client_discard: Unknown symbol lib_ring_buffer_read_offset_address (err
 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span sty=
le=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none windo=
wtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.978773] lttng_ring_buffer_client_=
discard: Unknown symbol _lib_ring_buffer_copy_from_user_inatomic
 (err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><spa=
n style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none =
windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 74.988724] lttng_ring_buffer_cl=
ient_discard: Unknown symbol lib_ring_buffer_nesting (err 0)</span></p><p c=
lass=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-size:10=
.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;paddin=
g:0in">[&nbsp;&nbsp; 74.997202] lttng_ring_buffer_client_discard: Unknown s=
ymbol lttng_transport_register (err 0)</span></p><p class=3D"MsoNormal" sty=
le=3D"background:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Conso=
las;color:#242729;border:none windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 7=
5.005761] lttng_ring_buffer_client_discard: Unknown symbol lttng_trace_cloc=
k (err 0)</span></p><p class=3D"MsoNormal" style=3D"background:#F4EAEA"><sp=
an style=3D"font-size:10.0pt;font-family:Consolas;color:#242729;border:none=
 windowtext 1.0pt;padding:0in">[&nbsp;&nbsp; 75.013709] lttng_ring_buffer_c=
lient_discard: Unknown symbol lib_ring_buffer_open_read (err 0)</span></p><=
p class=3D"MsoNormal" style=3D"background:#F4EAEA"><span style=3D"font-size=
:10.0pt;font-family:Consolas;color:#242729;border:none windowtext 1.0pt;pad=
ding:0in">[&nbsp;&nbsp; 75.022343] lttng_ring_buffer_client_discard: Unknow=
n symbol channel_create (err 0)</span></p></div></blockquote><div><br></div=
><div>The warnings above should not be there. Make sure your kernel meets t=
he lttng-modules<br data-mce-bogus=3D"1"></div><div>README file requirement=
s, and that you issued depmod -a.<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div>Perhaps try to rebuild/re-install lttng-modul=
es.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>=
Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px=
 solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norm=
al;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-=
serif;font-size:12pt;"><div class=3D"WordSection1"><p class=3D"MsoNormal" s=
tyle=3D"background:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Con=
solas;color:#242729;border:none windowtext 1.0pt;padding:0in">Session auto-=
19700101-000114 created.</span></p><p class=3D"MsoNormal" style=3D"backgrou=
nd:#F4EAEA"><span style=3D"font-size:10.0pt;font-family:Consolas;color:#242=
729;border:none windowtext 1.0pt;padding:0in">Traces will be written in //l=
ttng-traces/auto-19700101-000114</span></p></div><br>______________________=
_________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttn=
g.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></bl=
ockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></di=
v><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div><=
/div></body></html>
--=_8f38d8c6-fc60-4a45-bc49-1c393fea25b4--

--===============5936928993850252535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5936928993850252535==--
