From: John Smith <whalajam@gmail.com>
Subject: lttng view => [error] at line 1269: token "(": syntax
 error, unexpected LPAREN, expecting SEMICOLON or COMMA
Date: Tue, 1 Dec 2015 18:19:10 -0800
Message-ID: <CANgVouUOGyQ5vvn9g-4fa5_ADU4yYcSiiUOezr-aJn2+yG8iDw__14128.6044534811$1449082621$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1233571307=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f178.google.com ([209.85.223.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1a3x0m-0000JV-F4
 for lttng-dev@lists.lttng.org; Tue, 01 Dec 2015 21:19:17 -0500
Received: by ioc74 with SMTP id 74so30936510ioc.2
 for <lttng-dev@lists.lttng.org>; Tue, 01 Dec 2015 18:19:11 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1233571307==
Content-Type: multipart/alternative; boundary=001a1140efb65764600525e0e6a7

--001a1140efb65764600525e0e6a7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

issued the regular following lttng commands:
[
lttng create
lttng enable-event -u -a
lttng start
<run-my-app>
lttng stop
lttng view
]

"lttng view" command fails with the following:

[error] at line 1269: token "(": syntax error, unexpected LPAREN, expecting
SEMICOLON or COMMA
Environment info:
[
$ uname -a
Linux slab134 3.19.0-30-generic #34~14.04.1-Ubuntu SMP Fri Oct 2 22:09:39
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
$ lttng --version
lttng (LTTng Trace Control) 2.4.0 - =C3=89poque Opaque
]

I used also:
lttng view -e "babeltrace -n all -v -d"

but the output is not revealing any comprehensible details.

What mistake could lead to such a disastrous failure?

thanks, John

--001a1140efb65764600525e0e6a7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>issued the regular follo=
wing lttng commands:<br>[<br>lttng create<br>lttng enable-event -u -a<br>lt=
tng start</div><div>&lt;run-my-app&gt;</div><div>lttng stop<br>lttng view<b=
r>]</div><p>&quot;lttng view&quot; command fails with the following:</p><p>=
[error] at line 1269: token &quot;(&quot;: syntax error, unexpected LPAREN,=
 expecting SEMICOLON or COMMA</p><div>Environment info:</div><div>[</div><d=
iv>$ uname -a<br>Linux slab134 3.19.0-30-generic #34~14.04.1-Ubuntu SMP Fri=
 Oct 2 22:09:39 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux</div><div>$ lttng -=
-version<br>lttng (LTTng Trace Control) 2.4.0 - =C3=89poque Opaque</div><di=
v>]</div><div><br></div><div>I used also:</div><div>lttng view -e &quot;bab=
eltrace -n all -v -d&quot;</div><div><br></div><div>but the output is not r=
evealing any comprehensible details.</div><div><br></div><div>What mistake =
could lead to such a disastrous failure?</div><div><br></div><div>thanks, J=
ohn</div></div>

--001a1140efb65764600525e0e6a7--


--===============1233571307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1233571307==--
