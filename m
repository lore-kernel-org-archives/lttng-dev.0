From: pedro pinto <pedro.e.pinto@gmail.com>
Subject: statically linking liblttng
Date: Mon, 29 Jan 2018 08:56:42 -0500
Message-ID: <CAKOJUhQSk9YZsSvUiGV_u0C0YT43KvFVTBNwAR861m4-=LWa9Q__20440.6942161315$1517239885$gmane$org@mail.gmail.com>
Reply-To: pedro.e.pinto@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5492853176055246480=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x231.google.com (mail-qt0-x231.google.com
 [IPv6:2607:f8b0:400d:c0d::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3zVWKC6pTmzD6w
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jan 2018 13:57:03 +0000 (UTC)
Received: by mail-qt0-x231.google.com with SMTP id i1so12711767qtj.8
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jan 2018 05:57:03 -0800 (PST)
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

--===============5492853176055246480==
Content-Type: multipart/alternative; boundary="94eb2c03598ae214ae0563ea9ed3"

--94eb2c03598ae214ae0563ea9ed3
Content-Type: text/plain; charset="UTF-8"

Hi there. I would like to instrument a C++ statically linked application
using the lttng static libraries (i.e. libllttng-ust.a, etc). To try to get
this working I took the quick start example and changed it to use the
following link command line:

gcc -o hello hello.o hello-tp.o -Wl,-Bstatic -llttng-ust
-llttng-ust-tracepoint -lurcu-bp -lurcu-cds -Wl,-Bdynamic -lrt -ldl
-pthread

This does not return any errors but the resulting trace is empty. I was
able to get a trace using the liblttng shared object though.

Is it possible to statically link liblttng ? I am using v2.9.5 of lttng

Thanks in advance!

-pp

--94eb2c03598ae214ae0563ea9ed3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi there. I would like to instrument a C++ statically=
 linked application using the lttng static libraries (i.e. libllttng-ust.a,=
 etc). To try to get this working I took the quick start example and change=
d it to use the following link command line:=C2=A0</div><div><br></div><div=
>gcc -o hello hello.o hello-tp.o -Wl,-Bstatic -llttng-ust -llttng-ust-trace=
point -lurcu-bp -lurcu-cds -Wl,-Bdynamic -lrt -ldl -pthread=C2=A0</div><div=
><br></div><div><div>This does not return any errors but the resulting trac=
e is empty. I was able to get a trace using the liblttng shared object thou=
gh.<br></div></div><div><br></div><div>Is it possible to statically link li=
blttng ? I am using v2.9.5 of lttng</div><div><br></div><div>Thanks in adva=
nce!</div><div><br></div><div>-pp</div><div><br></div><div><br></div><div><=
br></div><div><br></div></div>

--94eb2c03598ae214ae0563ea9ed3--

--===============5492853176055246480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5492853176055246480==--
