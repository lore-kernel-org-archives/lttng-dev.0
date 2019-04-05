From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Forum - Using liblttng-ctl
Date: Fri, 5 Apr 2019 12:05:57 -0400 (EDT)
Message-ID: <1835227690.3195.1554480357602.JavaMail.zimbra__13229.3830903777$1554480387$gmane$org@efficios.com>
References: <CAML1w2qLPnVcZ3=r6sKTvM3m1LaUQOBygdiSLpZnrQt1rUND5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1828480860958577595=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44bPn92WZKz1KnB
 for <lttng-dev@lists.lttng.org>; Fri,  5 Apr 2019 12:06:05 -0400 (EDT)
In-Reply-To: <CAML1w2qLPnVcZ3=r6sKTvM3m1LaUQOBygdiSLpZnrQt1rUND5A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "CaptainWonka ." <fusion1542001@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1828480860958577595==
Content-Type: multipart/alternative;
	boundary="=_0bcd180a-73e6-4d34-9ec8-ca6b072c0a60"

--=_0bcd180a-73e6-4d34-9ec8-ca6b072c0a60
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 5, 2019, at 11:59 AM, CaptainWonka . <fusion1542001@gmail.com> wrote: 

> Hi Devs,
> I am using trying to use the lttng-ctl api you guys provide. When building I get
> this error:

> undefined reference to `lttng_channel_create(&dom)'

> Other calls, like creating sessions work. Its just trying to create and destroy
> the channel which throws this error. I am using lttng-tools 2.9, is this
> perhaps deprecated?

In order to be deprecated, it would need to have existed at some point. 

Can you point at the documentation or header implementation that makes you 
assume this function ever existed at all ? 

Thanks, 

Mathieu 

> - Ryan

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_0bcd180a-73e6-4d34-9ec8-ca6b072c0a60
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Apr 5, 2019, at 11:59 AM, Captai=
nWonka . &lt;fusion1542001@gmail.com&gt; wrote:<br></span></div><div data-m=
arker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010F=
F;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt;"><div dir=3D"ltr"><div dir=3D"ltr">Hi Devs,<br><div>I am using try=
ing to use the lttng-ctl api you guys provide. When building I get this err=
or:</div><div><b><br></b></div><div><b>undefined reference to `lttng_channe=
l_create(&amp;dom)'</b><br></div><br><div>Other calls, like creating sessio=
ns work. Its just trying to create and destroy the channel which throws thi=
s error. I am using lttng-tools 2.9, is this perhaps deprecated?</div></div=
></div></blockquote><div><br></div><div>In order to be deprecated, it would=
 need to have existed at some point.<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div>Can you point at the documentation or head=
er implementation that makes you<br data-mce-bogus=3D"1"></div><div>assume =
this function ever existed at all ?<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><di=
v dir=3D"ltr"><br><div>- Ryan</div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_0bcd180a-73e6-4d34-9ec8-ca6b072c0a60--

--===============1828480860958577595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1828480860958577595==--
