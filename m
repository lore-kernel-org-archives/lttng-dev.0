From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: LTTng user mode performance observation
Date: Thu, 2 Jun 2016 09:10:33 -0400 (EDT)
Message-ID: <52005383.41674507.1464873033520.JavaMail.zimbra__24415.3436426588$1464873071$gmane$org@polymtl.ca>
References: <D6EA0E80-F341-43D1-9C4B-780366947A19@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7093984971634275841=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6310FA3786
 for <lttng-dev@lists.lttng.org>; Thu,  2 Jun 2016 13:10:36 +0000 (UTC)
In-Reply-To: <D6EA0E80-F341-43D1-9C4B-780366947A19@nxp.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Richard Schmitt <richard.schmitt@nxp.com>
Cc: lttng-dev@lists.lttng.org, "Nghia (Tommy) Huynh" <nghia.huynh@utexas.edu>
List-Id: lttng-dev@lists.lttng.org

--===============7093984971634275841==
Content-Type: multipart/alternative;
	boundary="----=_Part_41674506_301931092.1464873033519"

------=_Part_41674506_301931092.1464873033519
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Here is a short answer to start. Others will have more precise suggestions.=
=20

Something that can seriously affect the performance is what is used to obta=
in information such as the timestamp and possibly the CPU id. More details =
on your platform would help in that respect. The second thing is that UST i=
s flexible (many parameters can be changed / activated at run time) and rob=
ust (reentrant, can be used from within signals) which adds a cost in terms=
 of structure and memory barriers. A high performance mode with restriction=
s on its use has been discussed in the past but the speed difference is not=
 necessarily that great, typically much lower than the impact of selecting =
an efficient source for timestamps.=20

----- Mail original -----

> We are trying to use user space LTTng to perform some performance analysi=
s of
> fast-path layer 3 forwarding. We have seen that with the tracepoints
> enabled, we experience about a 30% increase in service time. This is spre=
ad
> out over two tracepoints so each one is still contributing a good amount.

> This fast path is fast, about 300 cycles so we are asking a lot of effici=
ency
> of the tracepoint but for comparison, we implemented a simple ring buffer=
.
> When we run with this type of capture, we only experience a 5% increase i=
n
> service time.

> I=E2=80=99m looking for pointers. We=E2=80=99d rather use LTTng. Are ther=
e ways to tune LTTng
> ust for ultra high performance requirements. Perhaps there is a way we co=
uld
> write directly to ust=E2=80=99s ring buffers, or perhaps preallocate the =
buffers?

> Rich

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_41674506_301931092.1464873033519
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Here is a short answer to start.=
 Others will have more precise suggestions. </div><div><br></div><div>Somet=
hing that can seriously affect the performance is what is used to obtain in=
formation such as the timestamp and possibly the CPU id. More details on yo=
ur platform would help in that respect. The second thing is that UST is fle=
xible (many parameters can be changed / activated at run time) and robust (=
reentrant, can be used from within signals) which adds a cost in terms of s=
tructure and memory barriers. A high performance mode with restrictions on =
its use has been discussed in the past but the speed difference is not nece=
ssarily that great, typically much lower than the impact of selecting an ef=
ficient source for timestamps.</div><div><br></div><hr id=3D"zwchr"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;" data-mce-style=3D"borde=
r-left: 2px solid #1010FF; margin-left: 5px; padding-left: 5px; color: #000=
; font-weight: normal; font-style: normal; text-decoration: none; font-fami=
ly: Helvetica,Arial,sans-serif; font-size: 12pt;"><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:Calibri;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:Calibri;
=09color:windowtext;}
span.msoIns
=09{mso-style-type:export-only;
=09mso-style-name:"";
=09text-decoration:underline;
=09color:teal;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:Calibri;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt" data-mce-style=3D"font-size: 11.0pt;">We are trying t=
o use user space LTTng to perform some performance analysis of fast-path la=
yer 3 forwarding.&nbsp; We have seen that with the tracepoints enabled, we =
experience about a 30% increase in service time.&nbsp; This is spread out o=
ver two tracepoints so each one is still contributing a good amount.</span>=
</p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt" data-mce-style=
=3D"font-size: 11.0pt;">&nbsp;</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt" data-mce-style=3D"font-size: 11.0pt;">This fast path =
is fast, about 300 cycles so we are asking a lot of efficiency of the trace=
point but for comparison, we implemented a simple ring buffer.&nbsp; When w=
e run with this type of capture, we only experience a 5% increase in servic=
e time.</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt" d=
ata-mce-style=3D"font-size: 11.0pt;">&nbsp;</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:11.0pt" data-mce-style=3D"font-size: 11.0pt;">I=
=E2=80=99m looking for pointers.&nbsp; We=E2=80=99d rather use LTTng.&nbsp;=
 Are there ways to tune LTTng ust for ultra high performance requirements.&=
nbsp; Perhaps there is &nbsp;a way we could write directly to ust=E2=80=99s=
 ring buffers, or perhaps preallocate the buffers?</span></p><p class=3D"Ms=
oNormal"><span style=3D"font-size:11.0pt" data-mce-style=3D"font-size: 11.0=
pt;">&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0p=
t" data-mce-style=3D"font-size: 11.0pt;">Rich</span></p></div><br>_________=
______________________________________<br>lttng-dev mailing list<br>lttng-d=
ev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttn=
g-dev<br></blockquote><div><br></div></div></body></html>
------=_Part_41674506_301931092.1464873033519--

--===============7093984971634275841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7093984971634275841==--
