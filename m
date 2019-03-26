From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Creating custom application
Date: Tue, 26 Mar 2019 11:11:41 -0400
Message-ID: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w__25167.7228183084$1553613128$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5811280869572700487=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x12f.google.com (mail-it1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by lists.lttng.org (Postfix) with ESMTPS id 44TF3F2jZSz17X0
 for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2019 11:11:53 -0400 (EDT)
Received: by mail-it1-x12f.google.com with SMTP id 139so20554384ita.4
 for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2019 08:11:53 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5811280869572700487==
Content-Type: multipart/alternative; boundary="000000000000a88fa9058500bd63"

--000000000000a88fa9058500bd63
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am working with an embedded system and for security purposes I don't
necessarily want the user to have the ability to execute lttng commands
(lttng-sessiond, lttng create, etc.). In order to create a session/start I
am creating a custom application which will communicate through my
application via a socket. This way my application only control lttng
functionalities.

I was wondering if you guys can direct me to some documentation where I can
understand how I can approach creating a session and implementing the
functionalities that commands like (lttng-sessiond, lttng create and lttng
start) provide. Thank you for any information.

Regards,
Mosleh

--000000000000a88fa9058500bd63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am working with an embedded s=
ystem and for security purposes I don&#39;t necessarily want the user to ha=
ve the ability to execute lttng commands (lttng-sessiond, lttng create, etc=
.). In order to create a session/start I am creating a custom application w=
hich will communicate through my application via a socket. This way my appl=
ication only control lttng functionalities.=C2=A0</div><div><br></div><div>=
I was wondering if you guys can direct me to some documentation where I can=
 understand how I can approach creating a session and implementing the func=
tionalities that commands like (lttng-sessiond, lttng create and lttng star=
t) provide. Thank you for any information.</div><div><br></div><div>Regards=
,</div><div>Mosleh</div></div>

--000000000000a88fa9058500bd63--

--===============5811280869572700487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5811280869572700487==--
