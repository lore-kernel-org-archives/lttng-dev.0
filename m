From: Anand Neeli <anand.neeli@gmail.com>
Subject: sessiond health error
Date: Mon, 20 Apr 2015 18:53:25 +0530
Message-ID: <CAM5kDqyeS-qXUPWMTDWN_iarhV=f-jusW16PH3qt9Jn7iYphTg__7745.41745563528$1429536264$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1133832383=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YkBfe-0002Br-Li
 for lttng-dev@lists.lttng.org; Mon, 20 Apr 2015 09:23:33 -0400
Received: by wizk4 with SMTP id k4so99076020wiz.1
 for <lttng-dev@lists.lttng.org>; Mon, 20 Apr 2015 06:23:25 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1133832383==
Content-Type: multipart/alternative; boundary=f46d04428cdcb24a89051427d5b2

--f46d04428cdcb24a89051427d5b2
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm using 2.6.0
and after spawning a session, i monitor health of sessiond using the test
app at lttng-tools-2.6.0/tests/regression/tools/health/ every 5-seconds.

I'm getting following error:

 ERROR:  Component "sessiond" is in error.
 ERROR:  Thread "Session daemon consumer manager" is not responding in
component "sessiond".

And after that i'm not able to spawn and new sessions, although existing
session continue to work.

Can anyone Please help.
Is this a known issue?
Does anyone know the problem i'm facing here?

Thanks,
Anand Neeli

--f46d04428cdcb24a89051427d5b2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m using 2.6.0</div><div>and after spawni=
ng a session, i monitor health of sessiond using the test app at=C2=A0lttng=
-tools-2.6.0/tests/regression/tools/health/ every 5-seconds.</div><div><br>=
</div><div>I&#39;m getting following error:</div><div><br></div><div><div>=
=C2=A0ERROR: =C2=A0Component &quot;sessiond&quot; is in error.</div><div>=
=C2=A0ERROR: =C2=A0Thread &quot;Session daemon consumer manager&quot; is no=
t responding in component &quot;sessiond&quot;.</div></div><div><br></div><=
div>And after that i&#39;m not able to spawn and new sessions, although exi=
sting session continue to work.</div><div><br></div><div>Can anyone Please =
help.</div><div>Is this a known issue?</div><div>Does anyone know the probl=
em i&#39;m facing here?</div><div><br></div><div>Thanks,</div><div>Anand Ne=
eli</div></div>

--f46d04428cdcb24a89051427d5b2--


--===============1133832383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1133832383==--
