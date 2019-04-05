From: "CaptainWonka ." <fusion1542001@gmail.com>
Subject: Forum - Using liblttng-ctl
Date: Fri, 5 Apr 2019 11:59:06 -0400
Message-ID: <CAML1w2qLPnVcZ3=r6sKTvM3m1LaUQOBygdiSLpZnrQt1rUND5A__14434.085814149$1554480038$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5829219888059236944=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by lists.lttng.org (Postfix) with ESMTPS id 44bPdK6q9Sz1Klc
 for <lttng-dev@lists.lttng.org>; Fri,  5 Apr 2019 11:59:17 -0400 (EDT)
Received: by mail-ot1-x332.google.com with SMTP id u15so6047850otq.10
 for <lttng-dev@lists.lttng.org>; Fri, 05 Apr 2019 08:59:17 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5829219888059236944==
Content-Type: multipart/alternative; boundary="000000000000a118e70585ca9110"

--000000000000a118e70585ca9110
Content-Type: text/plain; charset="UTF-8"

Hi Devs,

I am using trying to use the lttng-ctl api you guys provide. When building
I get this error:

*undefined reference to `lttng_channel_create(&dom)'*

Other calls, like creating sessions work. Its just trying to create and
destroy the channel which throws this error. I am using lttng-tools 2.9, is
this perhaps deprecated?

- Ryan

--000000000000a118e70585ca9110
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Devs,<div><br></div><div>I am using tr=
ying to use the lttng-ctl api you guys provide. When building I get this er=
ror:</div><div><b><br></b></div><div><b>undefined reference to `lttng_chann=
el_create(&amp;dom)&#39;</b><br></div><div><br></div><div>Other calls, like=
 creating sessions work. Its just trying to create and destroy the channel =
which throws this error. I am using lttng-tools 2.9, is this perhaps deprec=
ated?</div><div><br></div><div>- Ryan</div></div></div>

--000000000000a118e70585ca9110--

--===============5829219888059236944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5829219888059236944==--
