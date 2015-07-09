From: Dilong Zheng <Dilong.Zheng@mitel.com>
Subject: Enabling Syscalls LTTng v2.5.1
Date: Thu, 9 Jul 2015 13:23:09 +0000
Message-ID: <DM2PR12MB03148D7374C0C505D2D8EAB19B900__2273.6418563456$1436448265$gmane$org@DM2PR12MB0314.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0063877497=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bn1on0082.outbound.protection.outlook.com ([157.56.110.82]
 helo=na01-bn1-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Dilong.Zheng@mitel.com>) id 1ZDBnK-0004Hd-4l
 for lttng-dev@lists.lttng.org; Thu, 09 Jul 2015 09:23:24 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0063877497==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM2PR12MB03148D7374C0C505D2D8EAB19B900DM2PR12MB0314namp_"

--_000_DM2PR12MB03148D7374C0C505D2D8EAB19B900DM2PR12MB0314namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jeremie,


I am attempting to enable syscalls by doing: lttng enable-event -a -k --sys=
call but I am received a warning: "Warning: Kernel events already enabled".=
 From searching online, I read that the warning is just a UI issue and does=
n't actually affect the functionality of LTTng; that the syscalls are actua=
lly being enabled. However when viewing the kernel trace inside TraceCompas=
s or Tracealyzer I do barely ever see any system calls. The only syscalls t=
hat appear if any are almost always "clone". I am currently using Fedora 22=
, x86 architecture. Be great to get some insight regarding the warning and =
what I could be doing better to see syscalls by enabling the event. Thanks =
for your help.


Dilong Zheng

--_000_DM2PR12MB03148D7374C0C505D2D8EAB19B900DM2PR12MB0314namp_
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
<p>Hi Jeremie,</p>
<p><br>
</p>
<p>I am attempting to enable syscalls by doing: <span style=3D"font-family:=
 &quot;Cordia New&quot;,sans-serif;">
lttng enable-event -a -k --syscall</span> but I am received a warning: &quo=
t;Warning: Kernel events already enabled&quot;. From searching online, I re=
ad that the warning is just a UI issue and doesn't actually affect the func=
tionality of LTTng; that the syscalls are
 actually being enabled. However when viewing the kernel trace inside Trace=
Compass or Tracealyzer I do barely ever see any system calls. The only sysc=
alls that appear if any are almost always &quot;clone&quot;. I am currently=
 using Fedora 22, x86 architecture. Be great
 to get some insight regarding the warning and what I could be doing better=
 to see syscalls by enabling the event. Thanks for your help.</p>
<p><br>
</p>
<p>Dilong Zheng<br>
</p>
</div>
</body>
</html>

--_000_DM2PR12MB03148D7374C0C505D2D8EAB19B900DM2PR12MB0314namp_--


--===============0063877497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0063877497==--
