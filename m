From: Shieryn Tjandra <shieryntjandra@gmail.com>
Subject: [LTTNG] Empty traces output file
Date: Fri, 9 Feb 2018 23:07:47 -0500
Message-ID: <CALX4544xOYVTvNReG81s-DVmEC8mARm8kJpUWAyOT9M8D4TT+w__45589.3510290936$1518235570$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4866440616843708435=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x231.google.com (mail-yw0-x231.google.com
 [IPv6:2607:f8b0:4002:c05::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3zddgm4mHqz11Yj
 for <lttng-dev@lists.lttng.org>; Sat, 10 Feb 2018 04:07:48 +0000 (UTC)
Received: by mail-yw0-x231.google.com with SMTP id z82so123782ywb.1
 for <lttng-dev@lists.lttng.org>; Fri, 09 Feb 2018 20:07:48 -0800 (PST)
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

--===============4866440616843708435==
Content-Type: multipart/alternative; boundary="001a114f3652a5af920564d3c9e9"

--001a114f3652a5af920564d3c9e9
Content-Type: text/plain; charset="UTF-8"

Good Evening,

Hi There,

I have inquiries regarding LTTNG, I followed the tutorial in this link :

http://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application

However, after executing the c application, when I checked whether the
process was in the userspace event (UST), the process was not there. Next,
I tried to record the  traces, as I thought, my traces output file does not
contain any traces. I also have make sure that liblttng-ust has been
installed. I really appreciate if you can help me to overcome this problem,
if you need additional file, let me know.

I am using centos 7 by the way.

Here is my command line
[root@localhost tracepractice]# gcc -c -I. app_tp.c
[root@localhost tracepractice]# gcc -c app.c -lpthread
[root@localhost tracepractice]# gcc -o try app.o app_tp.o -lpthread
-llttng-ust -ldl
[root@localhost tracepractice]# ./try and beyond
Main thread:     : pid = 17231 lwp = 17231 priority = 0
Thread 4:     : pid = 17231 lwp = 17234 priority = 0
Thread 2:     : pid = 17231 lwp = 17236 priority = 8
Thread 1:     : pid = 17231 lwp = 17237 priority = 12
Thread 1: Hello! I am thread 4 and I more important than 1, 2 and 3.     My
count is now 0
Thread 3:     : pid = 17231 lwp = 17235 priority = 4
Thread 4: Hello! I am thread 1 and I not very important.         My count
is now 1
Thread 2: Hello! I am thread 3 and I more important than 1 and 2.     My
count is now 0
Thread 3: Hello! I am thread 2 and I more important than 1.         My
count is now 1
Thread 2: Hello! I am thread 3 and I more important than 1 and 2.     My
count is now 262144
Thread 3: Hello! I am thread 2 and I more important than 1.         My
count is now 262145
sig_ala [cound down=1]
sig_ala [cound down=0]
[root@localhost tracepractice]# lttng-sessiond --daemonize
[root@localhost tracepractice]# lttng list --userspace
UST events:
-------------
None

[root@localhost tracepractice]# lttng create mytrace
Session mytrace created.
Traces will be written in /root/lttng-traces/mytrace-20180209-013417
[root@localhost tracepractice]# lttng enable-event --userspace
app_tp:first_tracepoint
UST event app_tp:first_tracepoint created in channel channel0
[root@localhost tracepractice]# lttng start
Tracing started for session mytrace
[root@localhost tracepractice]# ./try
Main thread:     : pid = 17301 lwp = 17301 priority = 0
Thread 4:     : pid = 17301 lwp = 17304 priority = 0
Thread 2:     : pid = 17301 lwp = 17306 priority = 8
Thread 1:     : pid = 17301 lwp = 17307 priority = 12
Thread 1: Hello! I am thread 4 and I more important than 1, 2 and 3.     My
count is now 0
Thread 4: Hello! I am thread 1 and I not very important.         My count
is now 1
Thread 3:     : pid = 17301 lwp = 17305 priority = 4
Thread 2: Hello! I am thread 3 and I more important than 1 and 2.     My
count is now 0
Thread 3: Hello! I am thread 2 and I more important than 1.         My
count is now 1
Thread 2: Hello! I am thread 3 and I more important than 1 and 2.     My
count is now 262144
Thread 3: Hello! I am thread 2 and I more important than 1.         My
count is now 262145
sig_ala [cound down=1]
Thread 2: Hello! I am thread 3 and I more important than 1 and 2.     My
count is now 524288
Thread 3: Hello! I am thread 2 and I more important than 1.         My
count is now 524289
sig_ala [cound down=0]
[root@localhost tracepractice]# lttng stop
Waiting for data availability
Tracing stopped for session mytrace
[root@localhost tracepractice]# babeltrace ~/lttng-traces/mytrace*
[root@localhost tracepractice]# ls ~/lttng-traces/mytrace* -l
total 0
drwxrwx---. 3 root root 17 Feb  9 01:35 ust


Thank you.


-- 


Best Regards,

*Shieryn Tjandra*











-- 


Best Regards,

*Shieryn Tjandra*
*+1 613 501 0606*

--001a114f3652a5af920564d3c9e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><br><div dir=3D"ltr"><div><div>=
<div><div><div>Good Evening, <br><br></div>Hi There, <br><br></div>I have i=
nquiries regarding LTTNG, I followed the tutorial in this link :<br><br><a =
href=3D"http://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application"=
 target=3D"_blank">http://lttng.org/docs/v2.10/#<wbr>doc-tracing-your-own-u=
ser-<wbr>application</a><br><br></div>However, after executing the c applic=
ation, when I checked whether the process was in the userspace event (UST),=
 the process was not there. Next, I tried to record the=C2=A0 traces, as I =
thought, my traces output file does not contain any traces. I also have mak=
e sure that liblttng-ust has been installed. I really appreciate if you can=
 help me to overcome this problem, if you need additional file, let me know=
. <br><br>I am using centos 7 by the way. <br><br></div>Here is my command =
line <br>[root@localhost tracepractice]# gcc -c -I. app_tp.c<br>[root@local=
host tracepractice]# gcc -c app.c -lpthread<br>[root@localhost tracepractic=
e]# gcc -o try app.o app_tp.o -lpthread -llttng-ust -ldl<br>[root@localhost=
 tracepractice]# ./try and beyond<br>Main thread: =C2=A0=C2=A0=C2=A0 : pid =
=3D 17231 lwp =3D 17231 priority =3D 0<br>Thread 4: =C2=A0=C2=A0=C2=A0 : pi=
d =3D 17231 lwp =3D 17234 priority =3D 0<br>Thread 2: =C2=A0=C2=A0=C2=A0 : =
pid =3D 17231 lwp =3D 17236 priority =3D 8<br>Thread 1: =C2=A0=C2=A0=C2=A0 =
: pid =3D 17231 lwp =3D 17237 priority =3D 12<br>Thread 1: Hello! I am thre=
ad 4 and I more important than 1, 2 and 3. =C2=A0=C2=A0=C2=A0 My count is n=
ow 0<br>Thread 3: =C2=A0=C2=A0=C2=A0 : pid =3D 17231 lwp =3D 17235 priority=
 =3D 4<br>Thread 4: Hello! I am thread 1 and I not very important. =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 My count is now 1<br>Thread 2: Hello! I am =
thread 3 and I more important than 1 and 2. =C2=A0=C2=A0=C2=A0 My count is =
now 0<br>Thread 3: Hello! I am thread 2 and I more important than 1. =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 My count is now 1<br>Thread 2: Hello! I am =
thread 3 and I more important than 1 and 2. =C2=A0=C2=A0=C2=A0 My count is =
now 262144<br>Thread 3: Hello! I am thread 2 and I more important than 1. =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 My count is now 262145<br>sig_ala [co=
und down=3D1]<br>sig_ala [cound down=3D0]<br>[root@localhost tracepractice]=
# lttng-sessiond --daemonize<br>[root@localhost tracepractice]# lttng list =
--userspace<br>UST events:<br>-------------<br>None<br><br>[root@localhost =
tracepractice]# lttng create mytrace<br>Session mytrace created.<br>Traces =
will be written in /root/lttng-traces/mytrace-<wbr>20180209-013417<br>[root=
@localhost tracepractice]# lttng enable-event --userspace app_tp:first_trac=
epoint<br>UST event app_tp:first_tracepoint created in channel channel0<br>=
[root@localhost tracepractice]# lttng start<br>Tracing started for session =
mytrace<br>[root@localhost tracepractice]# ./try<br>Main thread: =C2=A0=C2=
=A0=C2=A0 : pid =3D 17301 lwp =3D 17301 priority =3D 0<br>Thread 4: =C2=A0=
=C2=A0=C2=A0 : pid =3D 17301 lwp =3D 17304 priority =3D 0<br>Thread 2: =C2=
=A0=C2=A0=C2=A0 : pid =3D 17301 lwp =3D 17306 priority =3D 8<br>Thread 1: =
=C2=A0=C2=A0=C2=A0 : pid =3D 17301 lwp =3D 17307 priority =3D 12<br>Thread =
1: Hello! I am thread 4 and I more important than 1, 2 and 3. =C2=A0=C2=A0=
=C2=A0 My count is now 0<br>Thread 4: Hello! I am thread 1 and I not very i=
mportant. =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 My count is now 1<br>Thread=
 3: =C2=A0=C2=A0=C2=A0 : pid =3D 17301 lwp =3D 17305 priority =3D 4<br>Thre=
ad 2: Hello! I am thread 3 and I more important than 1 and 2. =C2=A0=C2=A0=
=C2=A0 My count is now 0<br>Thread 3: Hello! I am thread 2 and I more impor=
tant than 1. =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 My count is now 1<br>Thr=
ead 2: Hello! I am thread 3 and I more important than 1 and 2. =C2=A0=C2=A0=
=C2=A0 My count is now 262144<br>Thread 3: Hello! I am thread 2 and I more =
important than 1. =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 My count is now 262=
145<br>sig_ala [cound down=3D1]<br>Thread 2: Hello! I am thread 3 and I mor=
e important than 1 and 2. =C2=A0=C2=A0=C2=A0 My count is now 524288<br>Thre=
ad 3: Hello! I am thread 2 and I more important than 1. =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 My count is now 524289<br>sig_ala [cound down=3D0]<br>[r=
oot@localhost tracepractice]# lttng stop<br>Waiting for data availability<b=
r>Tracing stopped for session mytrace<br>[root@localhost tracepractice]# ba=
beltrace ~/lttng-traces/mytrace*<br>[root@localhost tracepractice]# ls ~/lt=
tng-traces/mytrace* -l<br>total 0<br>drwxrwx---. 3 root root 17 Feb=C2=A0 9=
 01:35 ust<br><br><br></div>Thank you. <br><span class=3D"HOEnZb"><font col=
or=3D"#888888"><div><br clear=3D"all"><div><div><div><div><div><br>-- <br><=
div class=3D"m_-1298659101138999654gmail_signature"><div dir=3D"ltr"><div><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div><br><=
div>Best Regards,</div><div><br></div><blockquote style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div styl=
e=3D"text-align:left"><b style=3D"font-size:12.8px"><i><font color=3D"#0000=
00" face=3D"garamond, serif" size=3D"4">Shieryn Tjandra</font></i></b></div=
></blockquote><div style=3D"text-align:center"><br></div><div style=3D"font=
-size:12.8px"><br></div><div><b><br></b></div><div><br></div><div><b style=
=3D"font-size:12.8px"><br></b></div><div><br></div><div><br></div></div></d=
iv></div></div></div></div></div>
</div></div></div></div></div></div></font></span></div>
</div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_signature" data-=
smartmail=3D"gmail_signature"><div dir=3D"ltr"><div class=3D"gmail_signatur=
e" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div><br><div>Best Regar=
ds,</div><div><br></div><blockquote style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204)=
;padding-left:1ex"><div style=3D"text-align:left"><b style=3D"font-size:12.=
8px"><i><font color=3D"#000000" face=3D"garamond, serif" size=3D"4">Shieryn=
 Tjandra</font></i></b></div><b><div style=3D"text-align:left"><b style=3D"=
font-size:12.8px"><font color=3D"#000000" face=3D"georgia, serif" size=3D"2=
">+1 613 501 0606</font></b></div></b></blockquote><div style=3D"text-align=
:center"><br></div><div style=3D"font-size:12.8px"><br></div><div><b><br></=
b></div><div><br></div><div><b style=3D"font-size:12.8px"><br></b></div><di=
v><br></div><div><br></div></div></div></div></div></div></div></div></div>=
</div>
</div>

--001a114f3652a5af920564d3c9e9--

--===============4866440616843708435==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4866440616843708435==--
