From: Yue Liu <liuyue0310@gmail.com>
Subject: [GSoC][lttng-ust-jul]How Java tracing support Works?
Date: Mon, 17 Mar 2014 22:44:26 +0800
Message-ID: <CANK7Sy9+ytE0Mwq-kg0h=L89Fc7+U+KPkRpux8bUZswbPeisMA__18723.3205572285$1395067535$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1615977637=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <liuyue0310@gmail.com>) id 1WPYmG-0007GO-EF
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 10:44:37 -0400
Received: by mail-ie0-f177.google.com with SMTP id rl12so5503290iec.36
	for <lttng-dev@lists.lttng.org>; Mon, 17 Mar 2014 07:44:27 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1615977637==
Content-Type: multipart/alternative; boundary=001a11c2d9c0c89ff104f4ce74f0

--001a11c2d9c0c89ff104f4ce74f0
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
   I'm writing my GSoC proposal for *Python tracing support* Idea. I want
to build a preliminary framework of this project. So I read the
*"liblttng-ust-jul"
*sourcecode to get inspiration.
   I know liblttng-ust-jul is for java support, so I think that Python
tracing support should have a similar framework with Java's.
   After a few days reading the jul's code, I still confused with the
relationship of classes & methods(such as: LTTngLogHandler,
LTTngTCPSessiondClient, LTTngSessiondCmd2_4).
   Are there any* docs* for liblttng-ust-jul part, or give me some guidance?
   Thx!

Yue Liu
----------------------------------------------------------
Tsinghua University NISL-Lab(FIT-1-213)
TEL: 156-5279-8191
Mail: liuyue0310@gmail.com

<liuyue0310@gmail.com>

--001a11c2d9c0c89ff104f4ce74f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,</div><div>=A0 =A0I&#39;m writing my GSoC prop=
osal for <b>Python tracing support</b> Idea. I want to build a preliminary =
framework of this project. So I read the <b>&quot;liblttng-ust-jul&quot; </=
b>sourcecode to get inspiration.</div>
<div>=A0 =A0I know liblttng-ust-jul is for java support, so I think that Py=
thon tracing support should have a similar framework with Java&#39;s.=A0</d=
iv><div>=A0 =A0After a few days reading the jul&#39;s code, I still confuse=
d with the relationship of classes &amp; methods(such as: LTTngLogHandler, =
LTTngTCPSessiondClient, LTTngSessiondCmd2_4).</div>
<div>=A0 =A0Are there any<b> docs</b> for liblttng-ust-jul part, or give me=
 some guidance?</div><div>=A0 =A0Thx!</div><div><br></div><div><div dir=3D"=
ltr"><div>Yue Liu</div><div>-----------------------------------------------=
-----------</div>
<div>Tsinghua University NISL-Lab(FIT-1-213)</div><div>TEL: 156-5279-8191</=
div><div>Mail:=A0<a href=3D"mailto:liuyue0310@gmail.com" target=3D"_blank">=
liuyue0310@gmail.com</a></div><div><a href=3D"mailto:liuyue0310@gmail.com" =
target=3D"_blank"><br>
</a></div></div></div>
</div>

--001a11c2d9c0c89ff104f4ce74f0--


--===============1615977637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1615977637==--
