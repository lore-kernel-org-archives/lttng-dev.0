From: Vijay Anand <vjanandr85@gmail.com>
Subject: scale numbers for LTTNG
Date: Tue, 24 May 2016 11:31:02 +0530
Message-ID: <CAHxF_R8QdRQjbgfE1d+Zgi=CmDiB6SEgL2Up1G-p21YdQz9pYA__13812.5978796326$1464190036$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0944993174946287188=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 836A6A2E26
 for <lttng-dev@lists.lttng.org>; Tue, 24 May 2016 06:01:02 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id 67so2765872wmg.0
 for <lttng-dev@lists.lttng.org>; Mon, 23 May 2016 23:01:02 -0700 (PDT)
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

--===============0944993174946287188==
Content-Type: multipart/alternative; boundary=089e0112bee222c7270533904823

--089e0112bee222c7270533904823
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Folks,

We have been evaluating LTTNG for use in our production systems for user
space tracing. We have evaluated most of the features supported by LTTNG
and very much see a value add LTTNG brings into our debugging
infrastructure.

   - Our current requirement is to trace Userspace programs running on
   linux.
   - Each of the linux processes define their own tracepoint providers.
   - We would like to trace event histories of each process independently.
   - We could potentially have 1000s of such processes running
   simultaneously.
   - We concluded on using a session/channel to trace one tracepoint
   provider corresponding to a unique process.
      - But I understand we could also create one system wide session and
      use channels to trace each of the providers. Either of the
approaches seems
      to work for us.
   - But upon evaluating I see that we could create only 25 active
   process-sessions and not traces from all the processes are logged.
      - Please note I have tried increasing the buffer size and the number
      of buffers. This doesn't help.
      - Each of the process trace 52 events at and interval of 1 second
      each.
   - I have evaluated this with lttng in session,live and snapshot modes
   and I have not been getting favourable.

Could you folks share the scale numbers that LTTNG supports, especially
when it comes to tracing user space programs ?

Regards,
Vijay
=E2=80=8B=E2=80=8B

--089e0112bee222c7270533904823
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:small"><font color=3D"#000000">Hello Folks,</font></di=
v><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font=
-size:small"><font color=3D"#000000"><br></font></div><div class=3D"gmail_d=
efault" style=3D"font-family:verdana,sans-serif;font-size:small"><font colo=
r=3D"#000000">We have been evaluating LTTNG for use in our production syste=
ms for user space tracing. We have evaluated most of the features supported=
 by LTTNG and very much see a value add LTTNG brings into our debugging inf=
rastructure.</font></div><div class=3D"gmail_default" style=3D""><ul style=
=3D""><li><font color=3D"#000000"><span style=3D"font-family:verdana,sans-s=
erif">Our current requirement is to trace Userspace programs running on lin=
ux.=C2=A0</span><br></font></li><li><font color=3D"#000000"><span style=3D"=
font-family:verdana,sans-serif">Each of the linux processes define their ow=
n tracepoint providers.</span><br></font></li><li><font color=3D"#000000"><=
span style=3D"font-family:verdana,sans-serif">We would like to trace event =
histories of each process independently.</span><br></font></li><li><font co=
lor=3D"#000000"><span style=3D"font-family:verdana,sans-serif">We could pot=
entially have 1000s of such processes running simultaneously.</span><br></f=
ont></li><li><span style=3D"font-family:verdana,sans-serif"><font color=3D"=
#000000">We concluded on using a session/channel to trace one tracepoint pr=
ovider corresponding to a unique process.=C2=A0</font></span></li><ul><li><=
span style=3D"font-family:verdana,sans-serif"><font color=3D"#000000">But I=
 understand we could also create one system wide session and use channels t=
o trace each of the providers. Either of the approaches seems to work for u=
s.</font></span></li></ul><li><span style=3D"font-family:verdana,sans-serif=
"><font color=3D"#000000">But upon evaluating I see that we could create on=
ly 25 active process-sessions and not traces from all the processes are log=
ged.</font></span></li><ul><li><span style=3D"font-family:verdana,sans-seri=
f"><font color=3D"#000000">Please note I have tried increasing the buffer s=
ize and the number of buffers. This doesn&#39;t help.</font></span></li><li=
><span style=3D"font-family:verdana,sans-serif"><font color=3D"#000000">Eac=
h of the process trace 52 events at and interval of 1 second each.</font></=
span></li></ul><li><font face=3D"verdana, sans-serif" color=3D"#000000">I h=
ave evaluated this with lttng in session,live and snapshot modes and I have=
 not been getting=C2=A0favourable.</font></li></ul><font color=3D"#000000">=
<span style=3D"font-family:verdana,sans-serif">Could you folks share the sc=
ale numbers that LTTNG supports, especially when it comes to tracing user s=
pace programs ?</span><br></font></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000000"=
><br></font></div><div><div class=3D"gmail_signature"><div dir=3D"ltr"><fon=
t face=3D"verdana, sans-serif" color=3D"#000000">Regards,</font><div><font =
face=3D"verdana, sans-serif" color=3D"#000000">Vijay<div class=3D"gmail_def=
ault" style=3D"font-family:verdana,sans-serif;font-size:small;display:inlin=
e">=E2=80=8B=E2=80=8B</div></font></div></div></div></div>
</div>

--089e0112bee222c7270533904823--

--===============0944993174946287188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0944993174946287188==--
