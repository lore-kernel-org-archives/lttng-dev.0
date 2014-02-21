From: "Suresh P. C" <pcsuresh@gmail.com>
Subject: Routing LTTng Trace data to a character driver
Date: Fri, 21 Feb 2014 16:16:56 +0530
Message-ID: <CAKCo3fjm-J4U5CL5PUV0Pw7oNvLBNC35YQjkAAD+exfuDeJh=g__5066.72345004535$1392989379$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1926939426=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <pcsuresh@gmail.com>) id 1WGndG-0004NL-GF
	for lttng-dev@lists.lttng.org; Fri, 21 Feb 2014 05:47:05 -0500
Received: by mail-bk0-f51.google.com with SMTP id w10so975606bkz.24
	for <lttng-dev@lists.lttng.org>; Fri, 21 Feb 2014 02:46:56 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1926939426==
Content-Type: multipart/alternative; boundary=089e013c676c33a72004f2e8574e

--089e013c676c33a72004f2e8574e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,



We are trying to redirect the LTTng Trace data to a STM driver (as opposed
to the target file-system) without changing or rewriting the LTTng code,
i.e.



$ lttng create =E2=80=93U file://dev/stm1

However, this always seems to fail as lttng expects expects a location as
directory path.



Any ideas as to how we might do this ?



Regards,

Suresh

--089e013c676c33a72004f2e8574e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black" lang=3D"EN-GB">Hi,</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black" lang=3D"EN-GB">=C2=A0</span><=
/p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black" lang=3D"EN-GB">We are trying =
to redirect the LTTng Trace
data to a STM driver (as opposed to the target file-system) without changin=
g or rewriting
the LTTng code, i.e.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black" lang=3D"EN-GB">=C2=A0</span><=
/p>

<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><span style=3D"font-siz=
e:11pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">=
$ lttng create =E2=80=93U file://dev/stm1</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black" lang=3D"EN-GB"></span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black" lang=3D"EN-GB">However, this =
always seems to fail as
lttng expects </span><span style=3D"font-size:11pt;font-family:&quot;Calibr=
i&quot;,&quot;sans-serif&quot;;color:black">expects a location as directory=
 path.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black">Any ideas as to how we might =
do this ?</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;">=C2=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;">Regards,</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;">Suresh</span></p>

<div><br></div>
</div>

--089e013c676c33a72004f2e8574e--


--===============1926939426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1926939426==--
