From: "Jones, Tim" <tim.jones4@hpe.com>
Subject: Tracing a userspace app from startup
Date: Wed, 15 May 2019 10:16:40 +0000
Message-ID: <DF4PR8401MB0939224BB5C202B61D624D3BDF090__28505.8271883585$1557929980$gmane$org@DF4PR8401MB0939.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7309950831503369129=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com
 [148.163.143.35])
 by lists.lttng.org (Postfix) with ESMTPS id 453tPr6p8gz115c
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 07:59:12 -0400 (EDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4FA6Jng026857
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 10:16:47 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
 by mx0b-002e3701.pphosted.com with ESMTP id 2sge4g1bvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 10:16:47 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com
 [16.193.72.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by g2t2353.austin.hpe.com (Postfix) with ESMTPS id D8DE382
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 10:16:46 +0000 (UTC)
Content-Language: en-GB
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7309950831503369129==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_DF4PR8401MB0939224BB5C202B61D624D3BDF090DF4PR8401MB0939_"

--_000_DF4PR8401MB0939224BB5C202B61D624D3BDF090DF4PR8401MB0939_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I've been attempting to use LTTng to trace some apps but need to trace from=
 their startup to shutdown. Is this possible with LTTng?

For example, I'd like to be able to run something along the lines of this:

lttng start -- <command> <args>

I've searched the docs and Google, but I can't find anything regarding this=
 way of using LTTng!?

Cheers,

Tim

--_000_DF4PR8401MB0939224BB5C202B61D624D3BDF090DF4PR8401MB0939_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">Hi,</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt"><br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">I've been attempting to use LTTng to trace s=
ome apps but need to trace from their startup to shutdown. Is this possible=
 with LTTng?<br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt"><br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">For example, I'd like to be able to run some=
thing along the lines of this:</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt"><br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">lttng start -- &lt;command&gt; &lt;args&gt;<=
br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt"><br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">I've searched the docs and Google, but I can=
't find anything regarding this way of using LTTng!?</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt"><br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">Cheers,</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt"><br>
</span></div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 10pt; co=
lor: rgb(0, 0, 0);">
<span style=3D"font-size:10pt">Tim<br style=3D"font-family:Verdana,Geneva,s=
ans-serif">
</span></div>
<span style=3D"font-size:10pt"><span style=3D"font-family:Verdana,Geneva,sa=
ns-serif"></span></span>
<div id=3D"Signature">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:10pt; color=
:rgb(0,0,0); background-color:rgb(255,255,255); font-family:Verdana,Geneva,=
sans-serif,&quot;EmojiFont&quot;,&quot;Apple Color Emoji&quot;,&quot;Segoe =
UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emo=
ji&quot;,EmojiSymbols">
</div>
</div>
</body>
</html>

--_000_DF4PR8401MB0939224BB5C202B61D624D3BDF090DF4PR8401MB0939_--

--===============7309950831503369129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7309950831503369129==--
