From: Michael Steppe <msteppe91@gmail.com>
Subject: CentOS 7.3 Support
Date: Tue, 6 Jun 2017 13:19:11 -0400
Message-ID: <CAN7pGtvjM37=3zVt2_NaQME0ZeYq+cCp+5Mq7Gy2TTdfjii1YA__9217.09958133778$1496769563$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5038697619519213018=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x233.google.com (mail-ua0-x233.google.com
 [IPv6:2607:f8b0:400c:c08::233])
 by lists.lttng.org (Postfix) with ESMTPS id 3whz3h4JJ6z11Pd
 for <lttng-dev@lists.lttng.org>; Tue,  6 Jun 2017 17:20:48 +0000 (UTC)
Received: by mail-ua0-x233.google.com with SMTP id h39so41554271uaa.3
 for <lttng-dev@lists.lttng.org>; Tue, 06 Jun 2017 10:19:13 -0700 (PDT)
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

--===============5038697619519213018==
Content-Type: multipart/alternative; boundary="f40304361f0279df5b05514dd177"

--f40304361f0279df5b05514dd177
Content-Type: text/plain; charset="UTF-8"

Hello!

I had previously built LTTng-modules 2.8.0 from source without issue on
CentOS 7.2 (3.10.0-327 kernel). When I tried to build on CentOS 7.3
(3.10.0-514 kernel), however, it failed with multiple "error: struct has no
member named 'id'" and "error: struct has no member named 'name'" errors. I
tried building LTTng-modules 2.9.2 from source on CentOS 7.3 and was
successful (it also built successfully on CentOS 7.2).

I was just curious at what version of LTTng-modules did the newer kernel in
CentOS 7.3 get supported. I would like to jump as small as possible, so if
there was a version of the modules between 2.8.0 and 2.9.2 that was
supported that would be great.

Thanks!
Michael Steppe

--f40304361f0279df5b05514dd177
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello!</div><div><br></div><div>I had previously buil=
t LTTng-modules 2.8.0 from source without issue on CentOS 7.2 (3.10.0-327 k=
ernel). When I tried to build on CentOS 7.3 (3.10.0-514 kernel), however, i=
t failed with multiple &quot;error: struct has no member named &#39;id&#39;=
&quot; and &quot;error: struct has no member named &#39;name&#39;&quot;=C2=
=A0errors. I tried building LTTng-modules 2.9.2 from source on CentOS 7.3 a=
nd was successful (it also built successfully on CentOS 7.2).</div><div><br=
></div><div>I was just curious at what version of LTTng-modules did the new=
er kernel in CentOS 7.3 get supported. I would like to jump as small as pos=
sible, so if there was a version of the modules=C2=A0between 2.8.0 and 2.9.=
2 that was supported that would be great.</div><div><br></div><div>Thanks!<=
/div><div>Michael Steppe<br></div></div>

--f40304361f0279df5b05514dd177--

--===============5038697619519213018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5038697619519213018==--
