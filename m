From: Anand Neeli <anand.neeli@gmail.com>
Subject: babeltrace lttng-live format option
Date: Tue, 3 Mar 2015 01:21:15 +0530
Message-ID: <CAM5kDqziReFDadtgHC76OfEgwtD7VFRh8y1Q6CCF4OYKOdHu6A__4401.05412058092$1425325938$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0783739842=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f176.google.com ([74.125.82.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YSWN6-0000NW-Sz
 for lttng-dev@lists.lttng.org; Mon, 02 Mar 2015 14:51:25 -0500
Received: by wesw62 with SMTP id w62so35541813wes.9
 for <lttng-dev@lists.lttng.org>; Mon, 02 Mar 2015 11:51:15 -0800 (PST)
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

--===============0783739842==
Content-Type: multipart/alternative; boundary=047d7b86d6ca7ad87f0510538a72

--047d7b86d6ca7ad87f0510538a72
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm using BabelTrace Trace Viewer and Converter 1.2.4
and i see the available formats are ctf, text.

node-a # babeltrace -l
Formats available: ctf, text.

How do i get lttng-live support? i read somewhere that "babeltrace -i
lttng-live"  can be used to read live tracing data, but looks like this
option is not available in 1.2.4
am i missing anything here?

Thanks,
Anand Neeli

--047d7b86d6ca7ad87f0510538a72
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi All,</div><div><div>I&#39;m using BabelTrace Trace=
 Viewer and Converter 1.2.4</div></div><div>and i see the available formats=
 are ctf, text.</div><div><br></div><div><div>node-a # babeltrace -l =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</div><div>Formats available: ctf, text.<=
br></div></div><div><br></div><div>How do i get lttng-live support? i read =
somewhere that &quot;babeltrace -i lttng-live&quot; =C2=A0can be used to re=
ad live tracing data, but looks like this option is not available in 1.2.4<=
/div><div>am i missing anything here?</div><div><br></div><div>Thanks,</div=
><div>Anand Neeli</div><div><br></div></div>

--047d7b86d6ca7ad87f0510538a72--


--===============0783739842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0783739842==--
