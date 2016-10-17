From: Tim Tannert <tim.tannert@tu-dortmund.de>
Subject: Problem with Kernel Module
Date: Mon, 17 Oct 2016 11:30:29 +0200
Message-ID: <c0eb7c4a-e717-b76a-cfbd-96fe93f9aa7c__40809.5862636857$1476718377$gmane$org@tu-dortmund.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3204489155812454546=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de
 [129.217.128.51])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id A9468A3A18
 for <lttng-dev@lists.lttng.org>; Mon, 17 Oct 2016 09:48:20 +0000 (UTC)
Received: from ex2010cas2.tu-dortmund.de (ex2010cas2.tu-dortmund.de
 [129.217.131.98])
 by unimail.uni-dortmund.de (8.16.0.19/8.16.0.19) with ESMTPS id u9H9UTiO021686
 (version=TLSv1.2 cipher=AES128-SHA256 bits=128 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 17 Oct 2016 11:30:29 +0200 (CEST)
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

--===============3204489155812454546==
Content-Type: multipart/alternative;
	boundary="------------EC5E965D38ED65D7D5EDF8A2"

--------------EC5E965D38ED65D7D5EDF8A2
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

I hope this is the right place for my question.

I want to trace a linux kernel Module with lttng. So I created a header fil=
e in "<module path>/tracing/tracepoint.h". I filled this header with inform=
ation from http://lttng.org/docs/#doc-instrumenting-linux-kernel-itself (he=
re the file is called hello,h). Then I included

#define CREATE_TRACE_POINTS
#include <../../tracing/tracepoint.h>

...
trace_hello_world(23, "initialized module");
...

in my modules source code.
But when I try to compile my module again, I got these message: http://past=
ebin.com/hXnZhJBS


I hope its not a simple failor caused by reading the wrong part of the docu=
mentation, but I'm a little bit confused, which part I need to read.
I read http://lttng.org/docs/#doc-instrumenting-out-of-tree-linux-kernel an=
d there was a link to the above tutorial, which i used finaly.

I'm looking forward to a answer ;)

Tim



Wichtiger Hinweis: Die Information in dieser E-Mail ist vertraulich. Sie is=
t ausschlie=C3=9Flich f=C3=BCr den Adressaten bestimmt. Sollten Sie nicht d=
er f=C3=BCr diese E-Mail bestimmte Adressat sein, unterrichten Sie bitte de=
n Absender und vernichten Sie diese Mail. Vielen Dank.
Unbeschadet der Korrespondenz per E-Mail, sind unsere Erkl=C3=A4rungen auss=
chlie=C3=9Flich final rechtsverbindlich, wenn sie in herk=C3=B6mmlicher Sch=
riftform (mit eigenh=C3=A4ndiger Unterschrift) oder durch =C3=9Cbermittlung=
 eines solchen Schriftst=C3=BCcks per Telefax erfolgen.

Important note: The information included in this e-mail is confidential. It=
 is solely intended for the recipient. If you are not the intended recipien=
t of this e-mail please contact the sender and delete this message. Thank y=
ou. Without prejudice of e-mail correspondence, our statements are only leg=
ally binding when they are made in the conventional written form (with pers=
onal signature) or when such documents are sent by fax.

--------------EC5E965D38ED65D7D5EDF8A2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
</head>
<body bgcolor=3D"#FFFFFF" text=3D"#000000">
<p>Hello,</p>
<p>I hope this is the right place for my question. <br>
</p>
<p><span>I want to trace a linux kernel Module with lttng. So I created a h=
eader file in &quot;&lt;module path&gt;/tracing/tracepoint.h<span>&quot;</s=
pan>. I filled this header with information from
<a href=3D"http://lttng.org/docs/#doc-instrumenting-linux-kernel-itself" ta=
rget=3D"_blank">
http://lttng.org/docs/#doc-instrumenting-linux-kernel-itself</a> (here the =
file is called hello,h). Then I included
<br>
<br>
<b>#define CREATE_TRACE_POINTS</b><b><br>
</b><b>#include &lt;../../tracing/tracepoint.h&gt;</b></span></p>
<p><span><b>...</b><br>
<b>trace_hello_world(23, &quot;initialized module&quot;);</b><br>
<b>...<br>
</b></span></p>
<p><span>in my modules source code. <br>
But when I try to compile my module again, I got these message: </span><spa=
n><a href=3D"http://pastebin.com/hXnZhJBS" target=3D"_blank">http://pastebi=
n.com/hXnZhJBS<br>
<br>
<br>
</a>I hope its not a simple failor caused by reading the wrong part of the =
documentation, but I'm a little bit confused, which part I need to read.
<br>
I read </span><span><a href=3D"http://lttng.org/docs/#doc-instrumenting-out=
-of-tree-linux-kernel"><span>http://lttng.org/docs/#doc-instrumenting-out-o=
f-tree-linux-kernel</span></a> and there was a link to the above tutorial, =
which i used finaly.</span></p>
<p><span>I'm looking forward to a answer ;)<br>
</span></p>
<p><span><br>
Tim<br>
</span></p>
<p><span><br>
</span></p>
<p><span><br>
</span></p>
<font face=3D"Arial"><font size=3D"2"><em>Wichtiger Hinweis: Die Informatio=
n in dieser E-Mail ist vertraulich. Sie ist ausschlie=C3=9Flich f=C3=BCr de=
n Adressaten bestimmt. Sollten Sie nicht der f=C3=BCr diese E-Mail bestimmt=
e Adressat sein, unterrichten Sie bitte den Absender
 und vernichten Sie diese Mail. Vielen Dank. <br>
Unbeschadet der Korrespondenz per E-Mail, sind unsere Erkl=C3=A4rungen auss=
chlie=C3=9Flich final rechtsverbindlich, wenn sie in herk=C3=B6mmlicher Sch=
riftform (mit eigenh=C3=A4ndiger Unterschrift) oder durch =C3=9Cbermittlung=
 eines solchen Schriftst=C3=BCcks per Telefax erfolgen.
<br>
<br>
Important note: The information included in this e-mail is confidential. It=
 is solely intended for the recipient. If you are not the intended recipien=
t of this e-mail please contact the sender and delete this message. Thank y=
ou. Without prejudice of e-mail
 correspondence, our statements are only legally binding when they are made=
 in the conventional written form (with personal signature) or when such do=
cuments are sent by fax.
</em></font></font>
</body>
</html>

--------------EC5E965D38ED65D7D5EDF8A2--

--===============3204489155812454546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3204489155812454546==--
