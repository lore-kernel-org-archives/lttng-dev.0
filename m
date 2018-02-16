From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Problem saving session in custom LTTNG_HOME
Date: Fri, 16 Feb 2018 18:10:02 -0500
Message-ID: <CAC-H6tsYi4VGfOj6U2swnVU7mWb23_2NBAtdHgpUTfTSMwNL9w__7231.02038396082$1518824507$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9168707864979781907=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x22b.google.com (mail-lf0-x22b.google.com
 [IPv6:2a00:1450:4010:c07::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3zjpl14RGpzqVt
 for <lttng-dev@lists.lttng.org>; Fri, 16 Feb 2018 18:10:05 -0500 (EST)
Received: by mail-lf0-x22b.google.com with SMTP id g72so6091601lfg.5
 for <lttng-dev@lists.lttng.org>; Fri, 16 Feb 2018 15:10:05 -0800 (PST)
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

--===============9168707864979781907==
Content-Type: multipart/alternative; boundary="001a114b8b08b7b26d05655c71fa"

--001a114b8b08b7b26d05655c71fa
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am running into a problem when setting LTTNG_HOME and trying to save a
session. When I do so, it always ends up saving the session to
$HOME/.lttng/sessions instead of $LTTNG_HOME/.lttng/sessions.

I looked at tools/src/bin/lttng-sessiond/save.c and in the save_session
function it executes this line when there is no provided path

char *home_dir = utils_get_user_home_dir ....

Shouldn't it be calling utils_get_home_dir instead?

When I do change the function, "lttng save" always ends up in an error
of invalid pointer.

Any idea why this might be happening?

Thanks,

Shehab Elsayed

--001a114b8b08b7b26d05655c71fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><font color=3D"#000000">Hi All,<br><br></font></=
div><font color=3D"#000000">I am running into a problem when setting LTTNG_=
HOME and trying to save a session. When I do so, it always ends up saving t=
he session to $HOME/.lttng/sessions instead of $LTTNG_HOME/.lttng/sessions.=
<br><br></font></div><font color=3D"#000000">I looked at tools/src/bin/lttn=
g-sessiond/save.<font size=3D"2">c and in the save_session function it exec=
utes this line when there is no provided path<br></font><pre><span class=3D=
"gmail-kt">char</span> <span class=3D"gmail-o">*</span><span class=3D"gmail=
-n">home_dir</span> <span class=3D"gmail-o">=3D</span> <span class=3D"gmail=
-n">utils_get_user_home_dir ....<br><font size=3D"2"><span style=3D"font-fa=
mily:arial,helvetica,sans-serif"><br></span></font></span></pre><pre><font =
size=3D"2"><span style=3D"font-family:arial,helvetica,sans-serif"><span cla=
ss=3D"gmail-n">Shouldn&#39;t it be calling utils_get_home_dir instead?<br><=
br></span></span></font></pre><pre><font size=3D"2"><span style=3D"font-fam=
ily:arial,helvetica,sans-serif"><span class=3D"gmail-n">When I do change th=
e function, &quot;lttng save&quot; always ends up in an error of invalid po=
inter.<br><br></span></span></font></pre><pre><font size=3D"2"><span style=
=3D"font-family:arial,helvetica,sans-serif"><span class=3D"gmail-n">Any ide=
a why this might be happening?<br><br></span></span></font></pre><pre><font=
 size=3D"2"><span style=3D"font-family:arial,helvetica,sans-serif"><span cl=
ass=3D"gmail-n">Thanks,<br></span></span></font></pre><pre><font size=3D"2"=
><span style=3D"font-family:arial,helvetica,sans-serif"><span class=3D"gmai=
l-n">Shehab Elsayed<br></span></span></font></pre><br></font>
</div>

--001a114b8b08b7b26d05655c71fa--

--===============9168707864979781907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9168707864979781907==--
