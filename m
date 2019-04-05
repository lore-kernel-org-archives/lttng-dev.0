From: Yannick Lamarre <ylamarre@efficios.com>
Subject: Re: Forum - Using liblttng-ctl
Date: Fri, 5 Apr 2019 12:11:22 -0400 (EDT)
Message-ID: <1360056369.3262.1554480682602.JavaMail.zimbra__4782.87339662842$1554480702$gmane$org@efficios.com>
References: <CAML1w2qLPnVcZ3=r6sKTvM3m1LaUQOBygdiSLpZnrQt1rUND5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7890494453641439606=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44bPvK3Cghz1KpY
 for <lttng-dev@lists.lttng.org>; Fri,  5 Apr 2019 12:11:25 -0400 (EDT)
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

--===============7890494453641439606==
Content-Type: multipart/alternative;
	boundary="=_b759f509-c5b1-4a24-a994-50f09c9c1ee1"

--=_b759f509-c5b1-4a24-a994-50f09c9c1ee1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Ryan 
While this function "exists" in 2.11, it's part of the internal librairy and shouldn't be used. lttng_enable_channel does exactly what you want and is part of the exposed API both in 2.9n and 2.11. 
Regards, 
YL 


From: "CaptainWonka ." <fusion1542001@gmail.com> 
To: "lttng-dev" <lttng-dev@lists.lttng.org> 
Sent: Friday, April 5, 2019 11:59:06 AM 
Subject: [lttng-dev] Forum - Using liblttng-ctl 

Hi Devs, 
I am using trying to use the lttng-ctl api you guys provide. When building I get this error: 

undefined reference to `lttng_channel_create(&dom)' 

Other calls, like creating sessions work. Its just trying to create and destroy the channel which throws this error. I am using lttng-tools 2.9, is this perhaps deprecated? 

- Ryan 

_______________________________________________ 
lttng-dev mailing list 
lttng-dev@lists.lttng.org 
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev 


--=_b759f509-c5b1-4a24-a994-50f09c9c1ee1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div data-marker=3D"__QUOTED_TEXT__"><div style=
=3D"font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000=
000"><div>Hi Ryan<br></div>While this function "exists" in 2.11, it's part =
of the internal librairy and shouldn't be used. lttng_enable_channel does e=
xactly what you want and is part of the exposed API both in 2.9n and 2.11.<=
/div><div style=3D"font-family: arial, helvetica, sans-serif; font-size: 12=
pt; color: #000000">Regards,</div><div style=3D"font-family: arial, helveti=
ca, sans-serif; font-size: 12pt; color: #000000">YL<br><br><hr id=3D"zwchr"=
><div><b>From: </b>"CaptainWonka ." &lt;fusion1542001@gmail.com&gt;<br><b>T=
o: </b>"lttng-dev" &lt;lttng-dev@lists.lttng.org&gt;<br><b>Sent: </b>Friday=
, April 5, 2019 11:59:06 AM<br><b>Subject: </b>[lttng-dev] Forum - Using li=
blttng-ctl<br></div><br><div><div dir=3D"ltr"><div dir=3D"ltr">Hi Devs,<br>=
<div>I am using trying to use the lttng-ctl api you guys provide. When buil=
ding I get this error:</div><div><b><br></b></div><div><b>undefined referen=
ce to `lttng_channel_create(&amp;dom)'</b><br></div><br><div>Other calls, l=
ike creating sessions work. Its just trying to create and destroy the chann=
el which throws this error. I am using lttng-tools 2.9, is this perhaps dep=
recated?</div><br><div>- Ryan</div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev</div></div><br></div></div></body></html>
--=_b759f509-c5b1-4a24-a994-50f09c9c1ee1--

--===============7890494453641439606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7890494453641439606==--
