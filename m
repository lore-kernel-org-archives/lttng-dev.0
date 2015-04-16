From: Robert Daniels <robert.daniels@vantagecontrols.com>
Subject: ARM C++ segfaulting
Date: Thu, 16 Apr 2015 16:02:52 +0000
Message-ID: <1429200170794.74854__39200.6390415647$1429201435$gmane$org@vantagecontrols.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0731388435=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-am1on0121.outbound.protection.outlook.com
 ([157.56.112.121] helo=emea01-am1-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <robert.daniels@vantagecontrols.com>)
 id 1YimFp-0007Sp-0D
 for lttng-dev@lists.lttng.org; Thu, 16 Apr 2015 12:03:02 -0400
Content-Language: en-US
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

--===============0731388435==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_142920017079474854vantagecontrolscom_"

--_000_142920017079474854vantagecontrolscom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm attempting to use lttng userspace tracing with a C++ application on an =
ARM platform.  I'm using GCC 4.8.4 on Linux 3.14 with the 2.6 release of lt=
tng.  I've compiled lttng-modules, lttng-ust, and lttng-tools and have been=
 able to get a simple test working with C code.  When I attempt to run the =
hello.cxx test on my target it will segfault.


From my initial investigation it appears to die when executing macro genera=
ted code from tracepoint.h line 172 where it's trying to call a function on=
 a function pointer.


Any ideas on what I might have missed?


Thanks,


Robert Daniels

________________________________

Ce message, ainsi que tous les fichiers joints =E0 ce message, peuvent cont=
enir des informations sensibles et/ ou confidentielles ne devant pas =EAtre=
 divulgu=E9es. Si vous n'=EAtes pas le destinataire de ce message (ou que v=
ous recevez ce message par erreur), nous vous remercions de le notifier imm=
=E9diatement =E0 son exp=E9diteur, et de d=E9truire ce message. Toute copie=
, divulgation, modification, utilisation ou diffusion, non autoris=E9e, dir=
ecte ou indirecte, de tout ou partie de ce message, est strictement interdi=
te.
Se d=E9sabonner: Si vous souhaitez =EAtre retir=E9 de notre liste de diffus=
ion, s'il vous pla=EEt envoyer vos coordonn=E9es =E0 CASL.unsubscribe@legra=
nd.ca<mailto:casl.unsubscribe@legrand.ca> et indiquer quels sont les messag=
es que vous ne souhaitez plus recevoir.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.
Unsubscribe: If you would like to be removed from our mailing list, please =
send your contact information to CASL.unsubscribe@legrand.ca<mailto:casl.un=
subscribe@legrand.ca> and indicate what messages you no longer wish to rece=
ive.

--_000_142920017079474854vantagecontrolscom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>I'm attempting to use lttng userspace tracing with a C&#43;&#43; applica=
tion on an ARM platform. &nbsp;I'm using GCC 4.8.4 on Linux 3.14 with the 2=
.6 release of lttng.&nbsp; I've compiled lttng-modules, lttng-ust, and lttn=
g-tools and have been able to get a simple test working
 with C code. &nbsp;When I attempt to run the hello.cxx test on my target i=
t will segfault.<br>
</p>
<p><br>
</p>
<p>From my initial investigation it appears to die when executing macro gen=
erated code from tracepoint.h line 172 where it's trying to call a function=
 on a function pointer.<br>
</p>
<p><br>
</p>
<p>Any ideas on what I might have missed?<br>
</p>
<p><br>
</p>
<p>Thanks,<br>
</p>
<p><br>
</p>
<p>Robert Daniels<br>
</p>
</div>
<br>
<hr>
<font face=3D"Tahoma" size=3D"2">
<p>Ce message, ainsi que tous les fichiers joints =E0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =EA=
tre divulgu=E9es. Si vous n'=EAtes pas le destinataire de ce message (ou qu=
e vous recevez ce message par erreur), nous
 vous remercions de le notifier imm=E9diatement =E0 son exp=E9diteur, et de=
 d=E9truire ce message. Toute copie, divulgation, modification, utilisation=
 ou diffusion, non autoris=E9e, directe ou indirecte, de tout ou partie de =
ce message, est strictement interdite.
<br>
<b>Se d=E9sabonner: </b>Si vous souhaitez =EAtre retir=E9 de notre liste de=
 diffusion, s'il vous pla=EEt envoyer vos coordonn=E9es =E0
<a href=3D"mailto:casl.unsubscribe@legrand.ca">CASL.unsubscribe@legrand.ca<=
/a> et indiquer quels sont les messages que vous ne souhaitez plus recevoir=
.</p>
<br>
<p>This e-mail, and any document attached hereby, may contain confidential =
and/or privileged information. If you are not the intended recipient (or ha=
ve received this e-mail in error) please notify the sender immediately and =
destroy this e-mail. Any unauthorized,
 direct or indirect, copying, disclosure, distribution or other use of the =
material or parts thereof is strictly forbidden.
<br>
<b>Unsubscribe:</b> If you would like to be removed from our mailing list, =
please send your contact information to
<a href=3D"mailto:casl.unsubscribe@legrand.ca">CASL.unsubscribe@legrand.ca<=
/a> and indicate what messages you no longer wish to receive.
</p>
</font>
</body>
</html>

--_000_142920017079474854vantagecontrolscom_--


--===============0731388435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0731388435==--
