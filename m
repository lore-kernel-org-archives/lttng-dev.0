From: syed zaidi <zaidi1039@gmail.com>
Subject: issues converting large amount of traces using
	babeltrace
Date: Fri, 25 Mar 2016 19:08:35 -0700
Message-ID: <CAD6O9aopPSyHA4fNp2ewGZUHiuG7WZ07-ntR6Hj2gzx5Suok-Q__28140.5050344349$1458958136$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1636746658838473656=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2D225A2D4C
 for <lttng-dev@lists.lttng.org>; Sat, 26 Mar 2016 02:08:37 +0000 (UTC)
Received: by mail-ig0-f173.google.com with SMTP id cl4so21726094igb.0
 for <lttng-dev@lists.lttng.org>; Fri, 25 Mar 2016 19:08:36 -0700 (PDT)
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

--===============1636746658838473656==
Content-Type: multipart/alternative; boundary=089e011769a13dd2cd052eea2892

--089e011769a13dd2cd052eea2892
Content-Type: text/plain; charset=UTF-8

Hey guys,
I am using babeltrace to convert the traces produced by Lttng. It works
perfectly if I have small amount of data. That is if I run the session for
small amount of time.
But if the the session is ran for a long time, while converting the traces,
the babel trace process gets killed and it does not complete the conversion.
I just wanted to ask if this is a known issue. I guess the babeltrace
process getting killed depends on the memory available on the machine and
that should also define the limit for traces to be converted succesfully.
I was wondering if my assumption, that the issue is the memory available,
is true and if other people have seen this or not.

Thanks
Ammar

--089e011769a13dd2cd052eea2892
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey guys,<div>I am using babeltrace to convert the traces =
produced by Lttng. It works perfectly if I have small amount of data. That =
is if I run the session for small amount of time.</div><div>But if the the =
session is ran for a long time, while converting the traces, the babel trac=
e process gets killed and it does not complete the conversion.</div><div>I =
just wanted to ask if this is a known issue. I guess the babeltrace process=
 getting killed depends on the memory available on the machine and that sho=
uld also define the limit for traces to be converted succesfully.</div><div=
>I was wondering if my assumption, that the issue is the memory available, =
is true and if other people have seen this or not.</div><div><br></div><div=
>Thanks</div><div>Ammar</div></div>

--089e011769a13dd2cd052eea2892--

--===============1636746658838473656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1636746658838473656==--
