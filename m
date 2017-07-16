From: Nalin Pai <nalinpai@gmail.com>
Subject: lttng questions
Date: Sun, 16 Jul 2017 11:28:29 -0700
Message-ID: <CALVR4zBENdRfGxAPwTuNxUhS5CJgJ5qzzrcnx5vMGZdg7BqmDg__9693.89615715972$1500247067$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6427682888492089144=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com
 [IPv6:2607:f8b0:400c:c08::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 3x9Zjm38dpz144d
 for <lttng-dev@lists.lttng.org>; Sun, 16 Jul 2017 18:30:36 +0000 (UTC)
Received: by mail-ua0-x22d.google.com with SMTP id z22so75121511uah.1
 for <lttng-dev@lists.lttng.org>; Sun, 16 Jul 2017 11:28:31 -0700 (PDT)
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

--===============6427682888492089144==
Content-Type: multipart/alternative; boundary="94eb2c1b047af65207055473728c"

--94eb2c1b047af65207055473728c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We are looking at using lttng as a solution for all our trace and debug
requirements. We want to get away from traditional file based string format
logging and move to lttng, which then gives us the flexibility of dumping
the traces to file or the network. With this background, I have several
questions for the team.

1) CTF supports struct fields. I don=E2=80=99t see any ctf_ macros in lttng=
 that
will allow us to define tracepoints having struct fields. Is there a way to
do this that I am missing?

2) Display hints. Sometimes there is a need to display certain fields in a
particular way, e.g. IP and MAC addresses. While the tracepoint definition
for these fields are going to be integers or sequences of integers, we
would like babeltrace to display these fields in a certain format. Short of
modifying babeltrace to recognize these fields by their names and handle
them specially, is there any other way of achieving the same?

-Nalin

--94eb2c1b047af65207055473728c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
















<p class=3D"gmail-MsoPlainText">Hello,</p>

<p class=3D"gmail-MsoPlainText">We are looking at using lttng as a solution=
 for all our
trace and debug requirements. We want to get away from traditional file bas=
ed string
format logging and move to lttng, which then gives us the flexibility of
dumping the traces to file or the network. With this background, I have sev=
eral
questions for the team.</p>

<p class=3D"gmail-MsoPlainText">1) CTF supports struct fields. I don=E2=80=
=99t see any ctf_
macros in lttng that will allow us to define tracepoints having struct fiel=
ds.
Is there a way to do this that I am missing?</p>

<p class=3D"gmail-MsoPlainText">2) Display hints. Sometimes there is a need=
 to display
certain fields in a particular way, e.g. IP and MAC addresses. While the
tracepoint definition for these fields are going to be integers or sequence=
s of
integers, we would like babeltrace to display these fields in a certain for=
mat.
Short of modifying babeltrace to recognize these fields by their names and
handle them specially, is there any other way of achieving the same?<span><=
/span></p>

<p class=3D"gmail-MsoPlainText">-Nalin</p>

<p class=3D"gmail-MsoPlainText"><span>=C2=A0</span></p>

</div>

--94eb2c1b047af65207055473728c--

--===============6427682888492089144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6427682888492089144==--
