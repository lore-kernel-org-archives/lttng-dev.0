From: Aleksander Aleksandrov via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Babeltrace 2.0.2 performance issue
Date: Thu, 2 Apr 2020 16:30:25 +0000
Message-ID: <ae52dda9bc3b4e54ba097209180e1ac9@yadro.com>
References: <76e78e538b804aa2b78f320510e8c10d@yadro.com>
Reply-To: Aleksander Aleksandrov <a.aleksandrov@yadro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7822043123732131005=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
 by lists.lttng.org (Postfix) with ESMTPS id 48tTGz6vkCz1bYw
 for <lttng-dev@lists.lttng.org>; Thu,  2 Apr 2020 12:36:43 -0400 (EDT)
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 6A26141252
 for <lttng-dev@lists.lttng.org>; Thu,  2 Apr 2020 16:30:26 +0000 (UTC)
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DL_YD6TRiuVX for <lttng-dev@lists.lttng.org>;
 Thu,  2 Apr 2020 19:30:25 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 0D41141251
 for <lttng-dev@lists.lttng.org>; Thu,  2 Apr 2020 19:30:24 +0300 (MSK)
In-Reply-To: <76e78e538b804aa2b78f320510e8c10d@yadro.com>
Content-Language: ru-RU
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7822043123732131005==
Content-Language: ru-RU
Content-Type: multipart/alternative;
	boundary="_000_ae52dda9bc3b4e54ba097209180e1ac9yadrocom_"

--_000_ae52dda9bc3b4e54ba097209180e1ac9yadrocom_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

=EF=D4: Aleksander Aleksandrov

=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 12 =CD=C1=D2=D4=C1 2020 =C7. 14:36
=EB=CF=CD=D5: jeremie.galarneau@efficios.com
=EB=CF=D0=C9=D1: simon.marchi@efficios.com; francis.deslauriers@efficios.co=
m
=F4=C5=CD=C1: Babeltrace 2.0.2 performance issue


Hello Jeremie,


My name is Aleksandr, I had a pleasure to write a plugin for babeltrace2 an=
d I faced some performance issue (bt2 vs bt1).

I attached the simple LTTng user-space log which is used to show my issue. =
As far as I understand Babeltrace2's performance is comparable to Babeltrac=
e1's.

  *   Babeltrace 2:

tag: v2.0.2

BABELTRACE_MINIMAL_LOG_LEVEL=3DINFO ./configure --disable-man-pages --disab=
le-debug-info CFLAGS=3D'-O3 -DNDEBUG -Wno-error'

LD_LIBRARY_PATH=3D./src/lib/.libs ./src/cli/.libs/babeltrace2 my-lttng-trac=
e -o dummy  12,70s user 0,03s system 99% cpu 12,745 total

  *   Babeltrace 1:

tag: v1.5.8

./configure CFLAGS=3D'-O3 -DNDEBUG -Wno-error'

./converter/babeltrace my-lttng-trace -o dummy  8,30s user 0,03s system 100=
% cpu 8,334 total


Babeltrace v2.0.2 is slower (~50%, processing time: 12,745 s vs 8,334 s) th=
an Babeltrace v1.5.8 with a dummy output according to my measurements.


I would be happy to receive any help or clarification from you.

Thank you for your time!


Best regards,

Aleksandr

--_000_ae52dda9bc3b4e54ba097209180e1ac9yadrocom_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dkoi8-r">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p><b style=3D"font-size: 11pt; font-family: Calibri, sans-serif;">=EF=D4:<=
/b><span style=3D"font-size: 11pt; font-family: Calibri, sans-serif;"> Alek=
sander Aleksandrov</span><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:=
</b> 12 =CD=C1=D2=D4=C1 2020 =C7. 14:36<br>
<b>=EB=CF=CD=D5:</b> jeremie.galarneau@efficios.com<br>
<b>=EB=CF=D0=C9=D1:</b> simon.marchi@efficios.com; francis.deslauriers@effi=
cios.com<br>
<b>=F4=C5=CD=C1:</b> Babeltrace 2.0.2 performance issue</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
Hello J&eacute;r&eacute;mie,</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;; min-height:14px">
<br>
</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
My name is Aleksandr, I had a pleasure to write a plugin for babeltrace2 an=
d I faced some performance issue (bt2 vs bt1).</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
I attached the&nbsp;simple LTTng user-space log which is used to show my is=
sue. As far as I understand Babeltrace2&#8217;s performance is comparable t=
o Babeltrace1&#8217;s.</p>
<ul>
<li style=3D"margin:0px; font-size:12px; line-height:normal; font-family:&q=
uot;Helvetica Neue&quot;">
Babeltrace 2: </li></ul>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
tag: v2.0.2</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
BABELTRACE_MINIMAL_LOG_LEVEL=3DINFO ./configure --disable-man-pages --disab=
le-debug-info CFLAGS=3D'-O3 -DNDEBUG -Wno-error'</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
LD_LIBRARY_PATH=3D./src/lib/.libs ./src/cli/.libs/babeltrace2 my-lttng-trac=
e -o dummy&nbsp; 12,70s user 0,03s system 99% cpu 12,745 total</p>
<ul>
<li style=3D"margin:0px; font-size:12px; line-height:normal; font-family:&q=
uot;Helvetica Neue&quot;">
Babeltrace 1: </li></ul>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
tag: v1.5.8</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
./configure&nbsp;CFLAGS=3D'-O3 -DNDEBUG -Wno-error'</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
./converter/babeltrace my-lttng-trace -o dummy&nbsp; 8,30s user 0,03s syste=
m 100% cpu 8,334 total</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
<br>
</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;; min-height:14px">
Babeltrace v2.0.2 is slower (~50%, processing time: 12,745&nbsp;s vs 8,334 =
s) than Babeltrace v1.5.8 with a dummy output according to my measurements.=
</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;; min-height:14px">
<br>
</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;; min-height:14px">
I would be happy to receive any help or clarification from you.<br>
</p>
<p></p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
Thank you for your time!</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
<br>
</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
Best regards,</p>
<p style=3D"margin-right:0px; margin-left:0px; font-size:12px; line-height:=
normal; font-family:&quot;Helvetica Neue&quot;">
Aleksandr</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_ae52dda9bc3b4e54ba097209180e1ac9yadrocom_--

--===============7822043123732131005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7822043123732131005==--
