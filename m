From: Zvi Vered <veredz72@gmail.com>
Subject: Monitor threads with lttng
Date: Wed, 15 May 2019 19:42:09 +0300
Message-ID: <CABRndgyfAyQ=t1==vPY9UHv8wZjMhrsu9bOtnwLu6f=ARjEj4w__31511.7275387578$1557938912$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530746035396231903=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by lists.lttng.org (Postfix) with ESMTPS id 4540n02pKJz12DS
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 12:46:12 -0400 (EDT)
Received: by mail-yb1-xb34.google.com with SMTP id v78so106677ybv.1
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 09:46:12 -0700 (PDT)
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

--===============0530746035396231903==
Content-Type: multipart/alternative; boundary="0000000000000a364c0588efe36b"

--0000000000000a364c0588efe36b
Content-Type: text/plain; charset="UTF-8"

Hello,

Can I use lttng to monitor threads in my process ?
For example, I want to see when a thread is active and when it is blocked
(waiting for a signal or an IOCL to complete).

Is it possible doing it without linking the application with libust and
calling UST API ?

Thank you,
Zvika

--0000000000000a364c0588efe36b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Can I use lttng to monitor threa=
ds in my process ?</div><div>For example, I want to see when a thread is ac=
tive and when it is blocked (waiting for a signal or an IOCL to complete).=
=C2=A0</div><div><br></div><div>Is it possible doing it without linking the=
 application with libust and calling UST API ?</div><div><br></div><div>Tha=
nk you,</div><div>Zvika=C2=A0</div></div>

--0000000000000a364c0588efe36b--

--===============0530746035396231903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0530746035396231903==--
