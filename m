From: Dilong Zheng <Dilong.Zheng@mitel.com>
Subject: UST Create Channel Failed, Why?
Date: Mon, 6 Jul 2015 18:11:23 +0000
Message-ID: <SN1PR12MB0319A4CF7ED35B7D250426BC9B930__44721.2446867072$1436206429$gmane$org@SN1PR12MB0319.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1734237127=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bl2on0077.outbound.protection.outlook.com ([65.55.169.77]
 helo=na01-bl2-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Dilong.Zheng@mitel.com>) id 1ZCArc-0000ZA-9g
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 14:11:34 -0400
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

--===============1734237127==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB0319A4CF7ED35B7D250426BC9B930SN1PR12MB0319namp_"

--_000_SN1PR12MB0319A4CF7ED35B7D250426BC9B930SN1PR12MB0319namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,


While trying to enable UST events, I get the following error message:


Error: Event mitel:sem_wait_entry: UST create channel failed (channel chann=
el0, session mcdUST3)


When I type: lttng list -u I am able to see a list of all my UST tracepoint=
s.

Could someone please provide some insight as to why this error is appearing=
 and steps I could take to fix this error. Thanks.




--_000_SN1PR12MB0319A4CF7ED35B7D250426BC9B930SN1PR12MB0319namp_
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
<p>Hi all,</p>
<p><br>
</p>
<p>While trying to enable UST events, I get the following error message:</p=
>
<p><br>
</p>
<p><span style=3D"font-family: &quot;Courier New&quot;,monospace;">Error: E=
vent mitel:sem_wait_entry: UST create channel failed (channel channel0, ses=
sion mcdUST3)</span></p>
<p><br>
</p>
<p>When I type: <span style=3D"font-family: &quot;Courier New&quot;,monospa=
ce;"></span><span style=3D"font-family: &quot;Courier New&quot;,monospace;"=
>lttng list -u</span>
<span style=3D"font-family: Calibri,Arial,Helvetica,sans-serif;">I am able =
to see a list of all my UST tracepoints.</span><br>
</p>
<p>Could someone please provide some insight as to why this error is appear=
ing and steps I could take to fix this error. Thanks.</p>
<p><br>
</p>
<p><br>
<br>
</p>
</div>
</body>
</html>

--_000_SN1PR12MB0319A4CF7ED35B7D250426BC9B930SN1PR12MB0319namp_--


--===============1734237127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1734237127==--
