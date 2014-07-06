From: Shariyar <syed.shariyar@gmail.com>
Subject: LTTng not generating trace contents
Date: Sun, 6 Jul 2014 18:49:51 -0400
Message-ID: <CAKQh6pi4+cbUi0p7P899aF3QvRs0nBMAEYsnFGaqzGn617r3Jw__26746.4218698025$1404687049$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2029767972=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1X3vFt-0002cp-9B
 for lttng-dev@lists.lttng.org; Sun, 06 Jul 2014 18:49:58 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so4371295pad.21
 for <lttng-dev@lists.lttng.org>; Sun, 06 Jul 2014 15:49:51 -0700 (PDT)
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

--===============2029767972==
Content-Type: multipart/alternative; boundary=047d7b67691823cd3704fd8e2d50

--047d7b67691823cd3704fd8e2d50
Content-Type: text/plain; charset=UTF-8

Hi,

I am having a problem in generating a kernel trace using the latest LTTng
on Ubuntu 12.04. It was working fine previously but when I updated LTTng it
stopped generating the trace contents. I did an uninstall and reinstall but
it didn't work either.

In particular, I am able to create a session, list all kernel events, start
a trace and stop a trace. My user is also in the tracing group. However,
there are no contents in the trace files generated for every CPU in the
system. Initially, the Babeltrace and the TMF both gave errors and when I
explored the trace folder I found out that they are empty files.The
metadata and index files do show some contents; however, nothing exists in
the channelx_x files.

What would be wrong? Please let me know.

Regards,
Shariyar

--047d7b67691823cd3704fd8e2d50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am having a problem in generating=
 a kernel trace using the latest LTTng on Ubuntu 12.04. It was working fine=
 previously but when I updated LTTng it stopped generating the trace conten=
ts. I did an uninstall and reinstall but it didn&#39;t work either.=C2=A0</=
div>
<div><br></div><div>In particular, I am able to create a session, list all =
kernel events, start a trace and stop a trace. My user is also in the traci=
ng group. However, there are no contents in the trace files generated for e=
very CPU in the system. Initially, the Babeltrace and the TMF both gave err=
ors and when I explored the trace folder I found out that they are empty fi=
les.The metadata and index files do show some contents; however, nothing ex=
ists in the channelx_x files.</div>
<div><br></div><div>What would be wrong? Please let me know.</div><div><br>=
</div><div>Regards,</div><div>Shariyar</div></div>

--047d7b67691823cd3704fd8e2d50--


--===============2029767972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2029767972==--
