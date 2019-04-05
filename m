From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Forum - Using liblttng-ctl
Date: Fri, 5 Apr 2019 12:16:45 -0400 (EDT)
Message-ID: <1305559971.3387.1554481005204.JavaMail.zimbra__17354.7164233$1554481022$gmane$org@efficios.com>
References: <CAML1w2qLPnVcZ3=r6sKTvM3m1LaUQOBygdiSLpZnrQt1rUND5A@mail.gmail.com>
 <1360056369.3262.1554480682602.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8953530376380741150=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44bQ1V4hzdz1KqF
 for <lttng-dev@lists.lttng.org>; Fri,  5 Apr 2019 12:16:46 -0400 (EDT)
In-Reply-To: <1360056369.3262.1554480682602.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: CaptainWonka <fusion1542001@gmail.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8953530376380741150==
Content-Type: multipart/alternative;
	boundary="=_b3d728d8-e6ac-4b98-af1d-07ac18320939"

--=_b3d728d8-e6ac-4b98-af1d-07ac18320939
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Yannick, 

Good point about it being part of 2.11. I looked at 2.9 (as stated in the original email) and missed it. 

A correction to your statement: It is however part of the liblttng-ctl library, which is not internal at all. So it's OK 
to use it, but it's was not present in 2.9, which is what was reported to be linked against. 

Thanks, 

Mathieu 

----- On Apr 5, 2019, at 12:11 PM, Yannick Lamarre <ylamarre@efficios.com> wrote: 

> Hi Ryan
> While this function "exists" in 2.11, it's part of the internal librairy and
> shouldn't be used. lttng_enable_channel does exactly what you want and is part
> of the exposed API both in 2.9n and 2.11.
> Regards,
> YL

> From: "CaptainWonka ." <fusion1542001@gmail.com>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Friday, April 5, 2019 11:59:06 AM
> Subject: [lttng-dev] Forum - Using liblttng-ctl

> Hi Devs,
> I am using trying to use the lttng-ctl api you guys provide. When building I get
> this error:

> undefined reference to `lttng_channel_create(&dom)'

> Other calls, like creating sessions work. Its just trying to create and destroy
> the channel which throws this error. I am using lttng-tools 2.9, is this
> perhaps deprecated?

> - Ryan

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_b3d728d8-e6ac-4b98-af1d-07ac18320939
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Yannick,<br></div><div><br data-mce-bogu=
s=3D"1"></div><div>Good point about it being part of 2.11. I looked at 2.9 =
(as stated in the original email) and missed it.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>A correction to your statement=
: It is however part of the liblttng-ctl library, which is not internal at =
all. So it's OK<br data-mce-bogus=3D"1"></div><div>to use it, but it's was =
not present in 2.9, which is what was reported to be linked against.<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathie=
u<br data-mce-bogus=3D"1"></div><div><br></div><div><span id=3D"zwchr" data=
-marker=3D"__DIVIDER__">----- On Apr 5, 2019, at 12:11 PM, Yannick Lamarre =
&lt;ylamarre@efficios.com&gt; wrote:<br></span></div><div data-marker=3D"__=
QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div style=3D"font-family: arial, helvetica, sans-serif; font-size: 12pt; co=
lor: #000000"><div><div style=3D"font-family: arial, helvetica, sans-serif;=
 font-size: 12pt; color: #000000"><div>Hi Ryan<br></div>While this function=
 "exists" in 2.11, it's part of the internal librairy and shouldn't be used=
. lttng_enable_channel does exactly what you want and is part of the expose=
d API both in 2.9n and 2.11.</div><div style=3D"font-family: arial, helveti=
ca, sans-serif; font-size: 12pt; color: #000000">Regards,</div><div style=
=3D"font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000=
000">YL<br><br><hr id=3D"zwchr"><div><b>From: </b>"CaptainWonka ." &lt;fusi=
on1542001@gmail.com&gt;<br><b>To: </b>"lttng-dev" &lt;lttng-dev@lists.lttng=
.org&gt;<br><b>Sent: </b>Friday, April 5, 2019 11:59:06 AM<br><b>Subject: <=
/b>[lttng-dev] Forum - Using liblttng-ctl<br></div><br><div><div dir=3D"ltr=
"><div dir=3D"ltr">Hi Devs,<br><div>I am using trying to use the lttng-ctl =
api you guys provide. When building I get this error:</div><div><b><br></b>=
</div><div><b>undefined reference to `lttng_channel_create(&amp;dom)'</b><b=
r></div><br><div>Other calls, like creating sessions work. Its just trying =
to create and destroy the channel which throws this error. I am using lttng=
-tools 2.9, is this perhaps deprecated?</div><br><div>- Ryan</div></div></d=
iv>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev</div></div><br></div></div><br>_________________________=
______________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.o=
rg<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></block=
quote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><=
div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></di=
v></body></html>
--=_b3d728d8-e6ac-4b98-af1d-07ac18320939--

--===============8953530376380741150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8953530376380741150==--
