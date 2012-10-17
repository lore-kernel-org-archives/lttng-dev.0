From: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Subject: Re: are LTTng-2.0 packages available on Fedora 16 via
 yum?
Date: Wed, 17 Oct 2012 17:28:12 +0000
Message-ID: <7F632A9222059A42AF70FCB7965774AA2063E902__35722.1339400441$1350494953$gmane$org@ALA-MBB.corp.ad.wrs.com>
References: <7F632A9222059A42AF70FCB7965774AA2063D880@ALA-MBB.corp.ad.wrs.com>
	<507EDE5B.8090102@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1722477515=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew.McDermott@windriver.com>) id 1TOXPn-0000Qg-5K
	for lttng-dev@lists.lttng.org; Wed, 17 Oct 2012 13:28:19 -0400
In-Reply-To: <507EDE5B.8090102@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Josh Stone <jistone@redhat.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1722477515==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7F632A9222059A42AF70FCB7965774AA2063E902ALAMBBcorpadwrs_"

--_000_7F632A9222059A42AF70FCB7965774AA2063E902ALAMBBcorpadwrs_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

(resending, as I neglected to CC the list...)

On 10/17/2012 04:32 AM, McDermott, Andrew wrote:
I'm happily using LTTng-2.0 on Ubuntu-12.04 but I was wondering if
Fedora 16 is supported via a yum install.  I see quite a few references
to 17 but not necessarily 16.  Is this correct or am I simply not
searching hard enough.

You can see which packages are available anywhere in Fedora here:
https://apps.fedoraproject.org/packages/lttng-tools
https://apps.fedoraproject.org/packages/lttng-ust

They were just added to Fedora in July, and at that time Yannick only
requested to add f17, so that's why f16 doesn't have them.
https://bugzilla.redhat.com/show_bug.cgi?id=3D717748#c20
https://bugzilla.redhat.com/show_bug.cgi?id=3D834481#c4

Thanks; that helps clear things up.

--
andy



--_000_7F632A9222059A42AF70FCB7965774AA2063E902ALAMBBcorpadwrs_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <6C7C6AE8B27C6C48AE42B763EDCEF25C@local>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; ">
Hi,
<div>
<div><br class=3D"Apple-interchange-newline">
<blockquote type=3D"cite">(resending, as I neglected to CC the list...)<br>
<br>
On 10/17/2012 04:32 AM, McDermott, Andrew wrote:<br>
<blockquote type=3D"cite">I'm happily using LTTng-2.0 on Ubuntu-12.04 but I=
 was wondering if<br>
Fedora 16 is supported via a yum install. &nbsp;I see quite a few reference=
s<br>
to 17 but not necessarily 16. &nbsp;Is this correct or am I simply not<br>
searching hard enough.<br>
</blockquote>
<br>
You can see which packages are available anywhere in Fedora here:<br>
<a href=3D"https://apps.fedoraproject.org/packages/lttng-tools">https://app=
s.fedoraproject.org/packages/lttng-tools</a><br>
https://apps.fedoraproject.org/packages/lttng-ust<br>
<br>
They were just added to Fedora in July, and at that time Yannick only<br>
requested to add f17, so that's why f16 doesn't have them.<br>
https://bugzilla.redhat.com/show_bug.cgi?id=3D717748#c20<br>
https://bugzilla.redhat.com/show_bug.cgi?id=3D834481#c4<br>
</blockquote>
<div><br>
</div>
Thanks; that helps clear things up.</div>
<div><br>
</div>
<div>--&nbsp;</div>
<div>andy</div>
<div><br>
</div>
<br>
</div>
</body>
</html>

--_000_7F632A9222059A42AF70FCB7965774AA2063E902ALAMBBcorpadwrs_--


--===============1722477515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1722477515==--
