From: Luis Ayuso <luis.f.ayuso@gmail.com>
Subject: unable to profile example
Date: Tue, 16 Apr 2019 17:34:38 +0200
Message-ID: <CAGkk+5Be9mMt6Nni8BdRwH4hfXG_QsKKjNPtYWm2xDtGOvNruA__3013.15843114338$1555435244$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4001736819579156497=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by lists.lttng.org (Postfix) with ESMTPS id 44k8Z42Djtz1KTq
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 11:34:52 -0400 (EDT)
Received: by mail-pg1-x52e.google.com with SMTP id k3so10520593pga.6
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 08:34:52 -0700 (PDT)
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

--===============4001736819579156497==
Content-Type: multipart/alternative; boundary="0000000000007363290586a78260"

--0000000000007363290586a78260
Content-Type: text/plain; charset="UTF-8"

Dear Lttng community.

I tried to profile the example code, as described in the documentation @
https://lttng.org/docs/v2.10
and I could not get any satisfactory result.

I am using
- lttng (LTTng Trace Control) 2.10.2 - KeKriek
- Ubuntu 18.04.2

I created the files hello-tp.c  hello-tp.h hello.c as described in the
documentation
The code succesfully compiles.
Kernel modules are loaded.
lttng-sessiond --daemonize  runs with not acknowledgement.

nevertheless, lttng create session command returns an error I am unable to
justify:
lttng create test
Session test created.
Traces will be written in /home/luis/lttng-traces/test-20190416-173219
Error: Unable to create config file
Error: Command error

- Do I need any extra setup step that is no documented in the web?
- Is the package at ubuntu repos working correctly?
- are there known conflicts with any other software?


cheers.
Luis Ayuso

--0000000000007363290586a78260
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div>Dear Lttng community.</div><div><br></div><div>I tried to profile t=
he example code, as described in the documentation @ <a href=3D"https://ltt=
ng.org/docs/v2.10">https://lttng.org/docs/v2.10</a></div><div>and I could n=
ot get any satisfactory result. <br></div><div><br></div><div>I am using <b=
r></div><div>- lttng (LTTng Trace Control) 2.10.2 - KeKriek</div><div>- Ubu=
ntu 18.04.2<br></div><div><br></div><div>I created the files hello-tp.c=C2=
=A0 hello-tp.h hello.c as described in the documentation <br></div><div>The=
 code succesfully compiles.</div><div>Kernel modules are loaded.</div><div>=
lttng-sessiond --daemonize=C2=A0 runs with not acknowledgement. <br></div><=
div><br></div><div>nevertheless, lttng create session command returns an er=
ror I am unable to justify:</div><div>lttng create test<br>Session test cre=
ated.<br>Traces will be written in /home/luis/lttng-traces/test-20190416-17=
3219<br>Error: Unable to create config file<br>Error: Command error<br></di=
v><div><br></div><div>- Do I need any extra setup step that is no documente=
d in the web?</div><div>- Is the package at ubuntu repos working correctly?=
 <br></div><div>- are there known conflicts with any other software? <br></=
div><div><br></div><div><br></div><div>cheers.</div><div>Luis Ayuso<br></di=
v><div><br></div><div><br></div><div><br></div></div></div></div></div></di=
v></div></div></div></div>

--0000000000007363290586a78260--

--===============4001736819579156497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4001736819579156497==--
