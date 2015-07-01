From: jamie explorer <jamieexplorer@gmail.com>
Subject: Re: application changes to support lttng
Date: Tue, 30 Jun 2015 17:08:01 -0700
Message-ID: <CACh_V578QYMi8CvhmvtR+QOY33maFNB6SB-eHBVOGOoJgUZ3HA__48879.4967801825$1435855746$gmane$org@mail.gmail.com>
References: <CACh_V54iounQNr+jxP85YjPuivjMTgowOCuTaox9fMRC9=ty0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0274386344=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jamieexplorer@gmail.com>) id 1ZA5ZP-00019N-NZ
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 20:08:18 -0400
Received: by oigx81 with SMTP id x81so20193074oig.1
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 17:08:01 -0700 (PDT)
In-Reply-To: <CACh_V54iounQNr+jxP85YjPuivjMTgowOCuTaox9fMRC9=ty0w@mail.gmail.com>
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

--===============0274386344==
Content-Type: multipart/alternative; boundary=047d7b676d52bb92b90519c51d87

--047d7b676d52bb92b90519c51d87
Content-Type: text/plain; charset=UTF-8

Hi lttng-dev,

sorry for asking basic questions.
Can you guys point me to any documentation which has this info. lttng.org
documentation doesnt have info about this.

How does the app register to use lttng?
how do sessiond, app and lttng-ust interact? is there any socket from every
app to sessiond?
How is the app modified when instrumented using lttng? are there any
threads added?
Are there any powerful tools for analysis on collected traces.

/Jam


On Mon, Jun 29, 2015 at 10:03 AM, jamie explorer <jamieexplorer@gmail.com>
wrote:

> Hello,
>
> I have just started using lttng and still looking at documentation.
> Can you help me with some info.
>
> How does the app register to use lttng?
> how do sessiond, app and lttng-ust interact? is there any socket from
> every app to sessiond?
> How is the app modified when instrumented using lttng? are there any
> threads added?
> when lttng instrumentation is linked along with app
> Are there any powerful tools for analysis on collected traces.
>
> /Jam
>

--047d7b676d52bb92b90519c51d87
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi lttng-dev,<div><br></div><div>sorry for asking basic qu=
estions.</div><div>Can you guys point me to any documentation which has thi=
s info. <a href=3D"http://lttng.org">lttng.org</a> documentation doesnt hav=
e info about this.</div><div><br></div><div><div style=3D"font-size:12.8000=
001907349px">How does the app register to use lttng?</div><div style=3D"fon=
t-size:12.8000001907349px">how do sessiond, app and lttng-ust interact? is =
there any socket from every app to sessiond?</div><div style=3D"font-size:1=
2.8000001907349px">How is the app modified when instrumented using lttng? a=
re there any threads added?=C2=A0<span style=3D"font-size:12.8000001907349p=
x"></span></div><div style=3D"font-size:12.8000001907349px"><span style=3D"=
font-size:12.8000001907349px">Are there any powerful tools for analysis on =
collected traces.</span><br></div></div><div style=3D"font-size:12.80000019=
07349px"><span style=3D"font-size:12.8000001907349px"><br></span></div><div=
 style=3D"font-size:12.8000001907349px">/Jam</div><div style=3D"font-size:1=
2.8000001907349px"><span style=3D"font-size:12.8000001907349px"><br></span>=
</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mo=
n, Jun 29, 2015 at 10:03 AM, jamie explorer <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jamieexplorer@gmail.com" target=3D"_blank">jamieexplorer@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"=
>Hello,<div><br></div><div>I have just started using lttng and still lookin=
g at documentation.</div><div>Can you help me with some info.</div><div><br=
></div><div>How does the app register to use lttng?</div><div>how do sessio=
nd, app and lttng-ust interact? is there any socket from every app to sessi=
ond?</div><div>How is the app modified when instrumented using lttng? are t=
here any threads added?</div><div>when lttng instrumentation is linked alon=
g with app</div><div>Are there any powerful tools for analysis on collected=
 traces.</div><div><br></div><div>/Jam=C2=A0</div></div>
</blockquote></div><br></div>

--047d7b676d52bb92b90519c51d87--


--===============0274386344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0274386344==--
