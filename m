From: abhishekk@uurmi.com
Subject: Lttng trace showing empty result while doing lttng view
Date: Mon, 03 Apr 2017 11:56:57 +0530
Message-ID: <7422d8db81750ce11ed6fe0e87bba3d9de20cfa9__19180.4281356328$1491202956$gmane$org@mail.uurmi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4214654899417230058=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpout1.netcore.co.in (smout-245164.nsmailserv.com
 [202.162.245.164])
 by lists.lttng.org (Postfix) with ESMTP id 3vxNMx1GGZzvQ4
 for <lttng-dev@lists.lttng.org>; Mon,  3 Apr 2017 07:02:36 +0000 (UTC)
Received: from localhost (localdomain [127.0.0.1])
 by pop6.netcore.co.in (Postfix) with ESMTP id 8121263666BC3
 for <lttng-dev@lists.lttng.org>; Mon,  3 Apr 2017 11:56:57 +0530 (IST)
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

--===============4214654899417230058==
Content-Type: multipart/alternative;
 boundary="=_a524542e2ca6f2eaa5733c7ee75d3377"

--=_a524542e2ca6f2eaa5733c7ee75d3377
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 =0A=0A=09I am trying to trace raspberry (I am using raspberry 3 B ) Lin=
ux=0Akernel by using lttng. The problem i am facing is after the success=
ful=0Acompletion of running following commands i am not able to see trac=
ing=0Aresult. It seems tracing file is empty. 1. lltng create mysession=
=0A=0A=09 2. lttng enable-event -a -k =0A=0A=093. lttng start =0A=0A=094=
 lttng stop 5=0A=0A=09. lttng view=0A=0A=09 Note:- I am not facing any=
 error while running above command and=0Akernel tracing file is generate=
d at proper path. And I am not facing=0Athis problem when i am tracing f=
or user space application.  =0A=0A=09I am using version 2.9 of kernel mo=
dules and version 2.5 of lttng=0Amodules.Kernel modules are loaded i can=
 see using lsmod.  =0AThanks & Regards=0AAbhishek Kumar=0A7801078513 =0A=
=0A-------------------------=0AEmail sent using E-interact Webmail

--=_a524542e2ca6f2eaa5733c7ee75d3377
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-=
serif; font-size: 12px;"><div class=3D"post-text">=0A=0A<p>I am trying t=
o trace raspberry (I am using raspberry 3 B ) Linux =0Akernel by using l=
ttng.=0AThe problem i am facing is after the successful completion of ru=
nning  =0Afollowing commands i am not able to see tracing result. It see=
ms tracing=0A file is empty.=0A1. lltng create mysession</p><p>=0A2. ltt=
ng enable-event -a -k <br /></p><p>3. lttng start <br /></p><p>4. lttng=
 stop=0A5</p><p>. lttng view</p><p>=0ANote:- I am not facing any error w=
hile running above command and kernel =0Atracing file is generated at pr=
oper path. And I am not facing this =0Aproblem when i am tracing for use=
r space application. </p>=0A=0A<p>I am using version 2.9 of kernel modul=
es and version 2.5 of lttng modules.Kernel modules are loaded i can see=
 using lsmod. </p>=0A    </div><br />Thanks &amp; Regards<br />Abhishek=
 Kumar<br />7801078513 <br /><br /><hr>Email sent using E-interact Webma=
il</body></html>

--=_a524542e2ca6f2eaa5733c7ee75d3377--


--===============4214654899417230058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4214654899417230058==--
