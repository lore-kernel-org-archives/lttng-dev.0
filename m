From: whalajam--- via lttng-dev <lttng-dev@lists.lttng.org>
Subject: running lttng 2.10 on Docker 1.13.1
Date: Sat, 27 Apr 2019 01:36:18 +0000 (UTC)
Message-ID: <97612750.1097694.1556328978552__10785.1806956873$1556329123$gmane$org@mail.yahoo.com>
References: <97612750.1097694.1556328978552.ref@mail.yahoo.com>
Reply-To: "whalajam@yahoo.com" <whalajam@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4758356952289953365=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic301-29.consmr.mail.bf2.yahoo.com
 (sonic301-29.consmr.mail.bf2.yahoo.com [74.6.129.228])
 by lists.lttng.org (Postfix) with ESMTPS id 44rYTt0Llyz1KH1
 for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2019 21:38:25 -0400 (EDT)
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

--===============4758356952289953365==
Content-Type: multipart/alternative;
	boundary="----=_Part_1097693_833880582.1556328978551"

------=_Part_1097693_833880582.1556328978551
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,I have one docker container on which I installed LTTng version 2.10.I us=
e the same Docker container to build and run the application.=C2=A0The prob=
lem I have is that there are no traces in the path specified when doing "lt=
tng create". "lttng view"fails complaining about files not found, the trace=
 directories are sometimes added to the path but the /root/lttng../../../ch=
annel0_* files are empty.=3DC2=3DA0I've followed the installation instructi=
ons from=3DC2=3DA0http://frederic-wou.net/lttng/and docs on=3DC2=3DA0https:=
//lttng.org/docs/v2.10/=3DC2=3DA0These are the commands: "lttng enable -u a=
:b", "lttng start", <excercise-the-tracepoints>,"lttng stop" and "lttng vie=
w". lttng-consumerd is running. Running 'lttng-sessiond --vvv' returns DEBU=
G info and an error about server already runningWhat could be the reason fo=
r the failure, how can I debug it?John



------=_Part_1097693_833880582.1556328978551
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"yahoo-style-wrap" style=3D"font-fami=
ly:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;"><div><span=
><div dir=3D"ltr" style=3D"font-family: &quot;Helvetica Neue&quot;, Helveti=
ca, Arial, sans-serif;">Hi,</div><div dir=3D"ltr" style=3D"font-family: &qu=
ot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;">I have one docker c=
ontainer on which I installed LTTng version 2.10.I use the same Docker cont=
ainer to build and run the application.&nbsp;</div><div dir=3D"ltr" style=
=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;"=
>The problem I have is that there are no traces in the path specified when =
doing "lttng create". "lttng view"fails complaining about files not found, =
the trace directories are sometimes added to the path but the /root/lttng..=
/../../channel0_* files are empty.=3DC2=3DA0I've followed the installation =
instructions from=3DC2=3DA0http://frederic-wou.net/lttng/and docs on=3DC2=
=3DA0https://lttng.org/docs/v2.10/=3DC2=3DA0These are the commands: "lttng =
enable -u a:b", "lttng start", &lt;excercise-the-tracepoints&gt;,"lttng sto=
p" and "lttng view". lttng-consumerd is running. Running 'lttng-sessiond --=
vvv' returns DEBUG info and an error about server already runningWhat could=
 be the reason for the failure, how can I debug it?</div><div dir=3D"ltr" s=
tyle=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-ser=
if;">John<br></div><div><br></div></span><br></div></div></body></html>
------=_Part_1097693_833880582.1556328978551--

--===============4758356952289953365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4758356952289953365==--
