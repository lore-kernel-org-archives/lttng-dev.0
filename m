From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Problem saving session in custom LTTNG_HOME
Date: Fri, 16 Feb 2018 18:11:52 -0500
Message-ID: <CAC-H6tviLrcGi3o8B76AjffGcMQ3_QXWod4_ss4anvWO1nGmJQ__8825.14490881494$1518822605$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0472906088258502960=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x229.google.com (mail-lf0-x229.google.com
 [IPv6:2a00:1450:4010:c07::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3zjpn61QmlzqWb
 for <lttng-dev@lists.lttng.org>; Fri, 16 Feb 2018 18:11:54 -0500 (EST)
Received: by mail-lf0-x229.google.com with SMTP id j193so6127945lfe.0
 for <lttng-dev@lists.lttng.org>; Fri, 16 Feb 2018 15:11:54 -0800 (PST)
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

--===============0472906088258502960==
Content-Type: multipart/alternative; boundary="001a1141291c43edaf05655c78e6"

--001a1141291c43edaf05655c78e6
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

--001a1141291c43edaf05655c78e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-gE gmail-iv gmail-gt"><table class=3D"=
gmail-cf gmail-gJ" cellpadding=3D"0"><tbody><tr class=3D"gmail-acZ gmail-xD=
"><td colspan=3D"3"><table class=3D"gmail-cf gmail-adz" cellpadding=3D"0"><=
tbody><tr><td class=3D"gmail-ady"><div class=3D"gmail-ajy" tabindex=3D"0"><=
img class=3D"gmail-ajz" id=3D"gmail-:14i" src=3D"https://mail.google.com/ma=
il/u/0/images/cleardot.gif" alt=3D""></div></td></tr></tbody></table></td><=
/tr></tbody></table></div><div id=3D"gmail-:121"><div class=3D"gmail-qQVYZb=
"></div><div class=3D"gmail-utdU2e"></div><div class=3D"gmail-btm"></div></=
div><div class=3D"gmail-aHl"></div><div id=3D"gmail-:41p" tabindex=3D"-1"><=
/div><div id=3D"gmail-:434" class=3D"gmail-ii gmail-gt"><div id=3D"gmail-:4=
33" class=3D"gmail-a3s gmail-aXjCH gmail-m161a0e1b50a68683"><div dir=3D"ltr=
"><div><div><font color=3D"#000000">Hi All,<br><br></font></div><font color=
=3D"#000000">I
 am running into a problem when setting LTTNG_HOME and trying to save a=20
session. When I do so, it always ends up saving the session to=20
$HOME/.lttng/sessions instead of $LTTNG_HOME/.lttng/sessions.<br><br></font=
></div><font color=3D"#000000">I looked at tools/src/bin/lttng-sessiond/<wb=
r>save.<font size=3D"2">c and in the save_session function it executes this=
 line when there is no provided path<br></font><pre><span class=3D"gmail-m_=
-4132707992438582927gmail-kt">char</span> <span class=3D"gmail-m_-413270799=
2438582927gmail-o">*</span><span class=3D"gmail-m_-4132707992438582927gmail=
-n">home_dir</span> <span class=3D"gmail-m_-4132707992438582927gmail-o">=3D=
</span> <span class=3D"gmail-m_-4132707992438582927gmail-n">utils_get_user_=
home_dir ....<br><font size=3D"2"><span style=3D"font-family:arial,helvetic=
a,sans-serif"><br></span></font></span></pre><pre><font size=3D"2"><span st=
yle=3D"font-family:arial,helvetica,sans-serif"><span class=3D"gmail-m_-4132=
707992438582927gmail-n">Shouldn&#39;t it be calling utils_get_home_dir inst=
ead?<br><br></span></span></font></pre><pre><font size=3D"2"><span style=3D=
"font-family:arial,helvetica,sans-serif"><span class=3D"gmail-m_-4132707992=
438582927gmail-n">When I do change the function, &quot;lttng save&quot; alw=
ays ends up in an error of invalid pointer.<br><br></span></span></font></p=
re><pre><font size=3D"2"><span style=3D"font-family:arial,helvetica,sans-se=
rif"><span class=3D"gmail-m_-4132707992438582927gmail-n">Any idea why this =
might be happening?<br><br></span></span></font></pre><pre><font size=3D"2"=
><span style=3D"font-family:arial,helvetica,sans-serif"><span class=3D"gmai=
l-m_-4132707992438582927gmail-n">Thanks,<br></span></span></font></pre><pre=
><font size=3D"2"><span style=3D"font-family:arial,helvetica,sans-serif"><s=
pan class=3D"gmail-m_-4132707992438582927gmail-n">Shehab Elsayed</span></sp=
an></font></pre></font></div></div></div></div>

--001a1141291c43edaf05655c78e6--

--===============0472906088258502960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0472906088258502960==--
