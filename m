Return-Path: <SRS0=Xw8Q=K6=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37122C4708F
	for <lttng-dev@archiver.kernel.org>; Fri,  4 Jun 2021 13:10:02 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF01F61242
	for <lttng-dev@archiver.kernel.org>; Fri,  4 Jun 2021 13:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF01F61242
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FxNQv0NC8z6nk;
	Fri,  4 Jun 2021 09:09:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622812199;
	bh=rCmjVvNfAxStiAgHGGM0BGhiKg47E7s0qYlleyGf3nA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=I+qyRTOLFFaEKgnztVpDPl2qXfxN+akTWdGyUlcnD74q41EPgGKJMICbMZkJhPHur
	 VVweGEuOHkM+LSZg2Sc1F8VWaB86cHIVIu8fQiEarsgW1oA+LN8sjdUC37XqPbTCsg
	 Bm6Pxl0QkD5gBl/lUb+Ll1G9wn/uYUTVaq2joPma1Ub+yGkE2LBVdGbY0cbo6EEccX
	 gGKBV26NEB3DGwIH1C6xVZPR7+5b9NDEL9Z9H0MmHK7dkjV1LJvtNR/qodz7Nr8700
	 49MYuBqEB5x7Xy028FU6beabfyAdXRLm1QzqTZRSVk6zlF9eFJg9/ztc4qELuLvPUh
	 P+6nKT13NX0eA==
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
 by lists.lttng.org (Postfix) with ESMTPS id 4FxNQr54mqz6lW
 for <lttng-dev@lists.lttng.org>; Fri,  4 Jun 2021 09:09:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baRwe3dQdgLhi2VGE7PnoPOg0qYUYIkl3qyu3nR/BUgVT1SzDaKtztHYPdvAlMcjCYl7mPNzJeBVPnly697XBge0KZMgnDzIVUJRdHjKGiDsd9DjUrbDKgoIyog55TH823YD0P9n5e+CITztzMWqZv0CRmhahxQTdO6tCzlQErMswmvy7T0s1qiF+bjt4G/sbl6EW3WHsmVPd9Fyuh3iNv7EcDDkXeHQXHUgU9nxstHuh6JecYJbskQELiVa5el4BuMW3rYk5H17xnVbSOIjd872fH8Bsj/J1MsN/Cls4jkXkk9tMv0iT3jUNOoAoeMeFD/q3PhbYBcSwV96mtiT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiPFVlOMXvUIo920cJl+iHNfbxuw9KHmqH9tFpjWcyg=;
 b=dk2UglJoDEr9oQFDk0tvi+Og6gYZZHvkhRWdf2nhqd5w4+dCUrTIyBDZZOXO34VyjyKiAM50jhNkCkUUtX22C9Q0b/8k3My8LbM6jLDG2ZG87NgXDEIkTegqpIybCYkhWWKK0t2x+8a62etImFCbBO6aK8CPF7GwzLQJN/EfDfSisQYMGcSo45TR90+Z5bO3gMSH8heyQMGssxKMN3FZ3CUoUEoY9HVsEZSUTJBaDSo8MpO48U71KqhU9/4fyoVbTYI6I/GnUzlaMvPQvzthvpwfPbYTFj+SAJ4L3zb1vUvpF+o8pwKjdgTrLCw5/J7aR1wDPdVMPde96Y0S/fGUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR3PR02MB6027.eurprd02.prod.outlook.com (2603:10a6:102:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Fri, 4 Jun
 2021 13:09:53 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::c029:efdd:c220:3b82]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::c029:efdd:c220:3b82%7]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 13:09:53 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTng 32 bits on 64 bits systems - kernel events... but no
 user-event
Thread-Index: AQHXWTyXrFTi8gSpG0+XSeNSyXv/wA==
Date: Fri, 4 Jun 2021 13:09:53 +0000
Message-ID: <PR3PR02MB6202F326FC88DD8F3EF90596D13B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9529271d-4df5-4049-cac5-08d9275a0b2a
x-ms-traffictypediagnostic: PR3PR02MB6027:
x-microsoft-antispam-prvs: <PR3PR02MB6027A083FFA8C075B8702B11D13B9@PR3PR02MB6027.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGcxTopl/Mh1DCFJMzJzz0ANXeHQUEWxGHJdMW3gdYOPlrgvOFaLyrEWKpIuh3giZQI2qccQd/+x3bpkp8SLZ4oWEGxkNfmwRAcUohcwZrrxI1b6Sveq0X9m22YFzuJQ8QykbGTGcepyiVriZmCjYTQnKU12FsJc+GgptJj9UZmhBr8pg1WCV79JvpP60cY8y8TLXM6s3UXxtf0/lOVCOu5NaVDy5b1hbMdmBI1JdZOgrM9hC+dyKVrnEKyhJivkf4punk/Nwmc0MppRMAWUxVgqKXMMQaXU71XtdNn5tvV8dTcx3x7J/pQkvxX3JpddczneNNoMYtAUpw6pew3+oin+GuAx8qHVgJts7tqHAhbJmQ/fn/HMsnqM23pNY1F77s11J+31aDO7MXlnq2qmUw19ho4WxOegzpjZSHm72UBuirMcTOUp7COi1wjBm86ZzWWKJi4MoPYbHC0g23vmeUGvtIvTjZpqDFT3i1nahBM+cg3c1wma4jK69w58O0bFim2ePBBJviDf1OFhBI/vvfqrtP8vc3KjFzxyqP1uESNJstVMLBKfQH6NzcxYFrJFjTOlFduLZ9f1qTJxH98NIlv8nlOHroiw3Cdi9nw2fSEJgo3cBwcGhuxHClgFu2KS26uJYwAglxoj9sDtFO8I/fkrWIQ5kvdIIO88Qdl3RN3Cgr/sUdVrYRc7heo3Mxh7zYeM/rtRoIKAf0tFdviQnSKeKvEbjD8SDxcqyvu2y4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(376002)(136003)(396003)(346002)(966005)(478600001)(38100700002)(122000001)(66446008)(26005)(64756008)(66556008)(66476007)(66946007)(186003)(7696005)(6506007)(8676002)(76116006)(5660300002)(52536014)(786003)(316002)(33656002)(8936002)(55236004)(9686003)(86362001)(2906002)(19627405001)(166002)(71200400001)(6916009)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: T9/RBb/3PW8otcBol1/hX/el/cPKd49mfWkq+sgCeM0ptUBwCPiD07AHHV0GYhvjZ9KHT8vS7ngj36nRG2Bya/2eWjkpL0iXkUL1VEd8bSsh1rDmALRYj37TTetkMzg83iXEe2ULIF9r7DEd6OXsuTXjxRU3Wf6XGWBOMPAq4Vl3U7Vl9L5+KpCZitT9idqA5/TJDbk7EXdT8dokafJ8YqJKiyiFZZcBoFg0FXngoNDz8Nrh9roN1xVqgp66hZanY6b1V/KlKbjpTVMs7vlqt4fGENJWFou4+4q0OMg9XZShOoRdxrMyCH6I0v5WRuCHf8m+6B453WDvl1QPmh3HPPDlnwE7KzBCu74eX1G1xPg4WHX4RHiMR+jd4CnY6MJGMMmuq+NG6lo5/qBzCj1cHiQBYhFZBnQ+0z+mFFEYd+nqu+wxWNfW7GGRHDQ2uOWfFnqR3lffnpgaokAxFrFRbrK6mVJDSMAVMolMBc7+1ng11hyAWwEjWypPyNO8DYGV+jaAStBk6mUxIITBsarcm26vxeGlEepOoKXHD3YhrWkq0nUY3DM5WV+MlEtjHD4jgmj3VZUY5mgDeoZbvH8tmb1mGs6CJ/tpIoSH5jZws24YHGXBtkSr8SMV9bPiDXYE1hVM07OwxJdfE+81l0UXq9D2rGBZvXcs3KA8yDeNhSEvIFC7JDYVtP00UXVxi18zxzvcJL/VOsg7hSh2ujFZF/NrqmeUDOfN4NZK8aUvsC4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9529271d-4df5-4049-cac5-08d9275a0b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 13:09:53.6225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G54fH1qUB3AshqjbQUMe93ssQ+N3B9OraJMuRurLC9u0PNPD2l8fPeBcG86U1flrA2ZbaWtiM5Ka2KeO+/wEoNZGNaki+u/7u4G6buqabHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6027
Subject: [lttng-dev] LTTng 32 bits on 64 bits systems - kernel events... but
 no user-event
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: MONTET Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: multipart/mixed; boundary="===============3877669247970736445=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3877669247970736445==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB6202F326FC88DD8F3EF90596D13B9PR3PR02MB6202eurp_"

--_000_PR3PR02MB6202F326FC88DD8F3EF90596D13B9PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi LTTng team,

I am currently trying to add lttng 32bits on a 64bits system with a custom =
kernel 4.19.177+ x86_64 (Debian 10.9)
My former attempt only with only a 100% arm32 bits was successful (raspberr=
y).
I am facing now a strange issue : I can record kernel event but not userspa=
ce event... but I can see these user-event (see below)!
(tuto : https://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-syst=
em)


I followed two times the tutorial : on lttng 2.12 and lttng 2.10.
I am on lttng (LTTng Trace Control) 2.10.11 - KeKriek now
All installation seemed to install without any error.
The only thing I added is at the very end where I did a : ln -s /usr/local/=
bin/lttng /usr/bin/lttng (to directly call commands like "lttng start")

Here some interesting outputs, I am using this projet as an example : https=
://lttng.org/docs/#doc-tracing-your-own-user-application
lttng list -u : OK Ubuntu Pastebin<https://paste.ubuntu.com/p/hZptnNzySw/>
LTTNG_UST_DEBUG=3D1 ./hello : seems OK : Ubuntu Pastebin<https://paste.ubun=
tu.com/p/w6xHrJsWJ9/>
kernel-event output : Ubuntu Pastebin<https://paste.ubuntu.com/p/5KfyS8wVdb=
/>
user-event ouput : none - the output folder stated with lttng create my-use=
r-session --output=3D/tmp/my-user-session doesn't even appear
apt-file search lttng : Ubuntu Pastebin<https://paste.ubuntu.com/p/xMcCc7bq=
wk/>
lsmod | grep lttng : Ubuntu Pastebin<https://paste.ubuntu.com/p/7YNkNsh9Fr/=
>


Note : file /usr/local/bin/lttng (the exe I am using) gives :
/usr/local/bin/lttng: ELF 64-bit LSB pie executable, x86-64, version 1 (SYS=
V), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Li=
nux 3.2.0, BuildID[sha1]=3D542a108c40e386c17027c2c8f8fcb30e278b7748, with d=
ebug_info, not stripped

I am wondering if the installation didn't pick a 64bits RCU and analyses pr=
ogramms only on this.
However, I have currently absolutely no idea how to debug this.

Could you advise me some methods ?

Regards,

--_000_PR3PR02MB6202F326FC88DD8F3EF90596D13B9PR3PR02MB6202eurp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">Hi LTTng team,</span><br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I am currently trying to add lttng 32bits on a 64bits system with a custom =
kernel 4.19.177+ x86_64 (Debian 10.9)</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
My former attempt only with only a 100% arm32 bits was successful (raspberr=
y).</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I am facing now a strange issue : I can record kernel event but not userspa=
ce event... but I can see these user-event (see below)!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
(tuto :&nbsp;<a href=3D"https://lttng.org/docs/#doc-instrumenting-32-bit-ap=
p-on-64-bit-system" id=3D"LPlnk">https://lttng.org/docs/#doc-instrumenting-=
32-bit-app-on-64-bit-system</a>)</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</div>
<div>I followed two times the tutorial : on lttng 2.12 and lttng 2.10.&nbsp=
;</div>
<div>I am on&nbsp;lttng (LTTng Trace Control) 2.10.11 - KeKriek now</div>
<div>All installation seemed to install without any error.</div>
<div>The only thing I added is at the very end where I did a : ln -s /usr/l=
ocal/bin/lttng /usr/bin/lttng (to directly call commands like &quot;lttng s=
tart&quot;)</div>
<div><br>
</div>
<div>Here some interesting outputs, I am using this projet as an example :&=
nbsp;<a href=3D"https://lttng.org/docs/#doc-tracing-your-own-user-applicati=
on" id=3D"LPlnk836931">https://lttng.org/docs/#doc-tracing-your-own-user-ap=
plication</a></div>
<div>lttng list -u : OK&nbsp;<a href=3D"https://paste.ubuntu.com/p/hZptnNzy=
Sw/" id=3D"LPlnk287961">Ubuntu Pastebin</a></div>
<div>LTTNG_UST_DEBUG=3D1 ./hello : seems OK :&nbsp;<a href=3D"https://paste=
.ubuntu.com/p/w6xHrJsWJ9/" id=3D"LPlnk773270">Ubuntu Pastebin</a></div>
<div>kernel-event output :&nbsp;<a href=3D"https://paste.ubuntu.com/p/5KfyS=
8wVdb/" id=3D"LPlnk662191">Ubuntu Pastebin</a></div>
<div>user-event ouput : none - the output folder stated with&nbsp;lttng cre=
ate my-user-session --output=3D/tmp/my-user-session doesn't even appear</di=
v>
<div>apt-file search lttng :&nbsp;<a href=3D"https://paste.ubuntu.com/p/xMc=
Cc7bqwk/" id=3D"LPlnk971362">Ubuntu Pastebin</a></div>
<div>lsmod | grep lttng :&nbsp;<a href=3D"https://paste.ubuntu.com/p/7YNkNs=
h9Fr/" id=3D"LPlnk686522">Ubuntu Pastebin</a></div>
<div><br>
</div>
<div><br>
</div>
<div>Note :&nbsp;file /usr/local/bin/lttng (the exe I am using) gives :</di=
v>
<div>/usr/local/bin/lttng: ELF 64-bit LSB pie executable, x86-64, version 1=
 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for G=
NU/Linux 3.2.0, BuildID[sha1]=3D542a108c40e386c17027c2c8f8fcb30e278b7748, w=
ith debug_info, not stripped<br>
</div>
<div><br>
</div>
<div>I am wondering if the installation didn't pick a 64bits RCU and analys=
es programms only on this.</div>
<div>However, I have currently absolutely no idea how to debug this.</div>
<div><br>
</div>
<div>Could you advise me some methods ?</div>
<div><br>
</div>
<div>Regards,</div>
</body>
</html>

--_000_PR3PR02MB6202F326FC88DD8F3EF90596D13B9PR3PR02MB6202eurp_--

--===============3877669247970736445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3877669247970736445==--
