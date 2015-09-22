From: Glenn Elliott <glelliott@teslamotors.com>
Subject: Shared memory support?
Date: Tue, 22 Sep 2015 04:16:43 +0000
Message-ID: <D2262439.5A98%glelliott__33135.3226480589$1442905573$gmane$org@teslamotors.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1642426610=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.98])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <glelliott@teslamotors.com>) id 1ZeF0X-0005HQ-Qk
 for lttng-dev@lists.lttng.org; Tue, 22 Sep 2015 00:16:48 -0400
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

--===============1642426610==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D22624395A98glelliottteslamotorscom_"

--_000_D22624395A98glelliottteslamotorscom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello urcu devs,

I am interested in using urcu for a project where interprocess communicatio=
n occurs through shared memory.  Can I use urcu to synchronize access acces=
s to data structures stored in shared memory?  Has the situation changed si=
nce this question was asked several years ago (http://lists.lttng.org/piper=
mail/lttng-dev/2013-September/021415.html)?  If shared memory is now suppor=
ted, would there be issues if readers map the shared memory regions that co=
ntain shared data structures as read-only?

Thanks,
Glenn


--_000_D22624395A98glelliottteslamotorscom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <39C8011E1C0605479DD3C1F473BADB9B@teslamotors.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif;">
<div>Hello urcu devs,</div>
<div><br>
</div>
<div>I am interested in using urcu for a project where interprocess communi=
cation occurs through shared memory. &nbsp;Can I use urcu to synchronize ac=
cess access to data structures stored in shared memory? &nbsp;Has the situa=
tion changed since this question was asked
 several years ago (<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2=
013-September/021415.html">http://lists.lttng.org/pipermail/lttng-dev/2013-=
September/021415.html</a>)? &nbsp;If shared memory is now supported, would =
there be issues if readers map the shared
 memory regions that contain shared data structures as read-only?</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Glenn</div>
<br>
</body>
</html>

--_000_D22624395A98glelliottteslamotorscom_--


--===============1642426610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1642426610==--
