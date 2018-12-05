From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Cost of enabling context field procname
Date: Wed, 5 Dec 2018 12:01:32 -0500 (EST)
Message-ID: <45864977.19456.1544029292113.JavaMail.zimbra__44500.1585329466$1544029184$gmane$org@efficios.com>
References: <AM6PR07MB4868FE662DA42A674E2A6091C1A80@AM6PR07MB4868.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8639744785549718353=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4394l815zczy7J
 for <lttng-dev@lists.lttng.org>; Wed,  5 Dec 2018 12:01:39 -0500 (EST)
In-Reply-To: <AM6PR07MB4868FE662DA42A674E2A6091C1A80@AM6PR07MB4868.eurprd07.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonas Andersson L <jonas.l.andersson@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8639744785549718353==
Content-Type: multipart/alternative;
	boundary="=_fa0aa9f4-ef53-4c16-bacb-ed9d183c8212"

--=_fa0aa9f4-ef53-4c16-bacb-ed9d183c8212
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 5, 2018, at 7:21 AM, Jonas Andersson L <jonas.l.andersson@eric=
sson.com> wrote:=20

> Hi

> I=E2=80=99m interested in information regarding the cost of enabling proc=
name context
> field. Is this field cached and read only at initialization or is the thr=
ead
> name fetched at each trace point? Thanks!

It is cached.=20

Thanks,=20

Mathieu=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_fa0aa9f4-ef53-4c16-bacb-ed9d183c8212
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

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
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
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style></div><div><br></div><div><br></div><div><span id=3D"zwchr" data=
-marker=3D"__DIVIDER__">----- On Dec 5, 2018, at 7:21 AM, Jonas Andersson L=
 &lt;jonas.l.andersson@ericsson.com&gt; wrote:<br></span></div><div data-ma=
rker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I=E2=80=99m interested in infor=
mation regarding the cost of enabling procname context field. Is this field=
 cached and read only at initialization or is the thread name fetched at ea=
ch trace point? Thanks!</span></p>
</div></blockquote><div>It is cached.<br></div><div><br data-mce-bogus=3D"1=
"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div></div><div data-marker=
=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>h=
ttp://www.efficios.com</div></div></body></html>
--=_fa0aa9f4-ef53-4c16-bacb-ed9d183c8212--

--===============8639744785549718353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8639744785549718353==--
