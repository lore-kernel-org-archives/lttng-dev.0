From: Yang Wang <yangw.wang5@unb.ca>
Subject: How to debug the CTF struct problem?
Date: Fri, 25 Jan 2013 00:48:08 +0000
Message-ID: <8E0A14A4C9B95B459AE214584119C1EB3BC90A1E__15289.8098495372$1359074940$gmane$org@Hal.ad.unb.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0562449608=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from tempo.its.unb.ca ([131.202.1.21])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yangw.wang5@unb.ca>) id 1TyXSp-0001qX-AG
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 19:48:15 -0500
Received: from joshua.ad.unb.ca (joshua.ad.unb.ca [131.202.6.82])
	by tempo.its.unb.ca (8.13.8/8.13.8) with ESMTP id r0P0m9s8024398
	for <lttng-dev@lists.lttng.org>; Thu, 24 Jan 2013 20:48:09 -0400
Content-Language: en-US
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

--===============0562449608==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8E0A14A4C9B95B459AE214584119C1EB3BC90A1EHaladunbca_"

--_000_8E0A14A4C9B95B459AE214584119C1EB3BC90A1EHaladunbca_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello

Could anybody know what causes the following problem? How to debug it?
I guess somewhere a tracepoint is wrong, but I don't know which one
as I have tons of tracepoints automatically generated and scattered in all =
the system
files.

yang@yang-OptiPlex-990:~/j9home/home/yangwang/benchmarks$ lttng view
Trace directory: /home/yang/lttng-traces/auto-20130124-190929

[error] ctf_struct_type_declarators_visit: duplicate field _string in struc=
t
[error] ctf_visitor_construct_metadata: event declaration error
[error] Error in CTF metadata constructor -1
[warning] Unable to open trace metadata for path "/home/yang/lttng-traces/a=
uto-20130124-190929/ust/java-7907-20130124-190951".
[warning] [Context] Cannot open_trace of the format /home/yang/lttng-traces=
/auto-20130124-190929/ust/java-7907-20130124-190951 .

Thanks in advance

Yang


--_000_8E0A14A4C9B95B459AE214584119C1EB3BC90A1EHaladunbca_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hello
<br>
<br>
Could anybody know what causes the following problem? How to debug it?<br>
I guess somewhere a tracepoint is wrong, but I don't know which one<br>
as I have tons of tracepoints automatically generated and scattered in all =
the system<br>
files.<br>
<br>
yang@yang-OptiPlex-990:~/j9home/home/yangwang/benchmarks$ lttng view<br>
Trace directory: /home/yang/lttng-traces/auto-20130124-190929<br>
<br>
[error] ctf_struct_type_declarators_visit: duplicate field _string in struc=
t<br>
[error] ctf_visitor_construct_metadata: event declaration error<br>
[error] Error in CTF metadata constructor -1<br>
[warning] Unable to open trace metadata for path &quot;/home/yang/lttng-tra=
ces/auto-20130124-190929/ust/java-7907-20130124-190951&quot;.<br>
[warning] [Context] Cannot open_trace of the format /home/yang/lttng-traces=
/auto-20130124-190929/ust/java-7907-20130124-190951 .<br>
<br>
Thanks in advance<br>
<br>
Yang<br>
<br>
</div>
</body>
</html>

--_000_8E0A14A4C9B95B459AE214584119C1EB3BC90A1EHaladunbca_--


--===============0562449608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0562449608==--
