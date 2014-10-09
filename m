From: xiaolin <ratzip@gmail.com>
Subject: The error message shows when exit a process
Date: Thu, 9 Oct 2014 15:02:13 +0200
Message-ID: <CAG4hbGAUt4AaVbxHVOWZNU6F7AFd1CM1XexGVS5E_4V0VBB_HQ__21477.9121488847$1412873078$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0563405739=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ratzip@gmail.com>) id 1XcDMJ-0006mO-DW
 for lttng-dev@lists.lttng.org; Thu, 09 Oct 2014 09:02:21 -0400
Received: by mail-ig0-f172.google.com with SMTP id r2so12566747igi.11
 for <lttng-dev@lists.lttng.org>; Thu, 09 Oct 2014 06:02:13 -0700 (PDT)
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

--===============0563405739==
Content-Type: multipart/alternative; boundary=089e0158a9a689fbc40504fd0a61

--089e0158a9a689fbc40504fd0a61
Content-Type: text/plain; charset=UTF-8

Hello,

I try to call the function exit(0) in a process to terminate it, but I got
this trace in lttng:



libust[3979/3979]: Error: Error cancelling global ust listener thread: No
such process (in lttng_ust_exit() at lttng-ust-comm.c:1517)

libust[3979/3979]: Error: Error cancelling local ust listener thread: No
such process (in lttng_ust_exit() at lttng-ust-comm.c:1526)



Do you know what is the problem and how to fix it?


BR/

Sean

--089e0158a9a689fbc40504fd0a61
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div><p class=3D"MsoNormal">I try to =
call the function exit(0) in a process to terminate
it, but I got this trace in lttng:</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">libust[3979/3979]: Error: Error cancelling global us=
t
listener thread: No such process (in lttng_ust_exit() at lttng-ust-comm.c:1=
517)</p>

<p class=3D"MsoNormal">libust[3979/3979]: Error: Error cancelling local ust
listener thread: No such process (in lttng_ust_exit() at lttng-ust-comm.c:1=
526)</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">Do you know what is the problem and how to fix it?</=
p><p class=3D"MsoNormal"><br></p><p class=3D"MsoNormal">BR/</p><p class=3D"=
MsoNormal">Sean</p></div></div>

--089e0158a9a689fbc40504fd0a61--


--===============0563405739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0563405739==--
