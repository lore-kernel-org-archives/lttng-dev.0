From: bhanu kiran chaluvadi <nthdimensionalreality@gmail.com>
Subject: Measure loop rate
Date: Wed, 22 Jan 2020 18:28:14 +0100
Message-ID: <CAJYn_wgBrfB+nY8nSajyDUnj81sOr6Q9wb5MFhiW5ShC5n8Kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6416297363496699731=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by lists.lttng.org (Postfix) with ESMTPS id 482snR4rtsz1rjL
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2020 12:28:27 -0500 (EST)
Received: by mail-wm1-x335.google.com with SMTP id p17so8064238wma.1
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jan 2020 09:28:27 -0800 (PST)
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

--===============6416297363496699731==
Content-Type: multipart/alternative; boundary="00000000000017a50c059cbdda31"

--00000000000017a50c059cbdda31
Content-Type: text/plain; charset="UTF-8"

Hi ,

I am trying to observer loop rate of a while loop.  Ideally it should take
maximum of 2 ms to finish the cycle (500 Hz at least). And i would like to
trace the loop rate using LTTng user space. whats the better way of doing
it ..Just place one trace point at the start and one at the end ? or is
there any library that i can take advantage of?

while {
trace_point (loop_start,...)
// some thing
trace_point(loop_end,....)
}

what do you think?


-- 
Bhanu Kiran . Chaluvadi ,
Mechanical Engineering ,
National Institute of Technology,Warangal,
India

--00000000000017a50c059cbdda31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi ,=C2=A0<div><br></div><div>I am trying to observer loop=
 rate of a while loop.=C2=A0 Ideally it should take maximum of 2 ms to fini=
sh the cycle (500 Hz at least). And i would like to trace the loop rate usi=
ng LTTng user space. whats the better way of doing it ..Just place one trac=
e point at the start and one at the end ? or is there any library that i ca=
n take advantage of?</div><div></div><div><br></div><div>while {</div><div>=
trace_point (loop_start,...)</div><div>// some thing</div><div>trace_point(=
loop_end,....)<br>}</div><div><br></div><div>what do you think?=C2=A0<br></=
div><div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature">Bhanu Kiran . Chaluvadi=
 ,<div>Mechanical Engineering ,</div><div>National Institute of Technology,=
Warangal,</div><div>India</div></div></div></div>

--00000000000017a50c059cbdda31--

--===============6416297363496699731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6416297363496699731==--
