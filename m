Return-Path: <SRS0=8WX2=D3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90366C4363A
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:34:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E24A22251
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="vU811502"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E24A22251
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CFx3H6FHvz14pS;
	Tue, 20 Oct 2020 10:34:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1603204476;
	bh=AVYBSNkaSY9nIpmp3A8txyL180r02LBpR7ufx8GZFqo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=vU811502ibOmLo7agnC+PkFs7KooxxPd7OpMtGrPiCS4GdjHD+11ZymVSQ4C9HbLK
	 2q1IZQab2jKTW8C5CngQjAWncY9pHc674nB50Ry8e42srsXYnrpWgf1Bd78u18bDpY
	 r87/HF1/zByyE7W15ihwC3U1F1lcYGSRWodL30tcOSBRXCiZjgVnSRun2fEeiE9rMi
	 0xM1LiOu6POmXGKTm9uPi5MwIpNPtZJAEfBXaOe0DXzMKf/Bb0lw3OUpYXzX98QYTg
	 B/7IW4sugrmdtik3L2MC5JUyjL4Uxdt9YXNQKdYYPPoKpL6BoUUNlByOrFzNFHoQc1
	 zIMe9urzRqeGA==
Received: from mailrelay.anl.gov (mailrelay.anl.gov [130.202.101.22])
 by lists.lttng.org (Postfix) with ESMTPS id 4CFWTZ1fBLz13mP
 for <lttng-dev@lists.lttng.org>; Mon, 19 Oct 2020 18:22:26 -0400 (EDT)
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTPS id 987991005220
 for <lttng-dev@lists.lttng.org>; Mon, 19 Oct 2020 17:22:19 -0500 (CDT)
IronPort-SDR: nh+CyT2B61ukrGE9jyXZk6cDDWWjCuaV4BxryJ9WBRBlOicNJTXDHlRkZ0buiNOLxwdMAcvAmo
 xvio0GKFBGzviS3nCFGxD+Qk2OJ4fSdh6K0l1HknikOvYxkzqN8jgyuNmDxuKLd1DOuv6u8Ld7
 g75jx7snY0VFIdkLq8Jia7ov70CVktpoo2uIAJSX5XiwukATJrH/twG5iQ2DnPIyXl+aGe+8id
 VnOyARPZsh/sjsyry+GEqbpRFEIZgg/vqEtJYJSLy7dqcaC5VWKJHI5o986XK2l+nIm9f3PYGE
 QWo=
X-IronPort-AV: E=Sophos;i="5.77,395,1596517200"; 
 d="scan'208,217";a="119135164"
Received: from camel.anl.gov ([146.137.81.12])
 by mailgateway.anl.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 19 Oct 2020 17:22:19 -0500
Received: from Camel.anl.gov (146.137.81.12) by Camel.anl.gov (146.137.81.12)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 19 Oct 2020 17:22:18 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (104.47.64.109)
 by hybridexchange.anl.gov (146.137.81.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 19 Oct 2020 17:22:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsXM7ePsgcZ5453TuUU6HyYm5H0poIScOB3Ee04x9ilgCPd5fptSfQ97jgDAHsNedHobDC1EfrEcZBNIxPCofTak9NJeYfoe6NYIbshzUeowAMwd43fUoO53CrKrqT11pZlghsHv+1+jWg1goeYmQ72dw5fzQzu06OJSQFh8rlQ9VTJgRvvXLcPAW20Nfcp9Lw31l6cZ8GTpaAfBcxxAXBUuda6aM0Ig+pw+e0wXPtW8LVPL5E5gk3swak9QPovBi2G4FoSnNMkfgmjKjTpwJUnYiQSWu/vWDiv8xZ7n7oaWe9muH5KhqMTjmG15EX9xGTs7C1VsumYNBm/X8uKAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbbQpWhBN54ftzuAwWHSTWMwM4ZxPkUsvix8pmOaRuc=;
 b=bM3gd9LUlFMpuGp8cbWqrEDsk0UYtXAf9zpH79I2K6bktYZOUihD7j3oUHgxvYicneG1MZ13Q2zlyU450o8WpgslpeJ8+gKPhTqC6axFie13DjIkXnGxTdOZtQsc1SyvKecA6B+QMLtmK+IcBjbK22oXcN0n+rAfMF7BWLLbfM91CYA8AJYTZMjKLyfg3786t+jX6BeyEZJe9iME64Vqzo3bYmUYFFrpEzWDnD+rZ3kKfaviPl/heSkuzhW8+20Uld/NJB0oMyIxNSNPdp9qkdaoVSx88pe0FPLu+Q0kThUhGV6HEzNljefZ+DhWJtfWs2rM/PWJz+HVaA+5Ry9l3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=anl.gov; dmarc=pass action=none header.from=anl.gov; dkim=pass
 header.d=anl.gov; arc=none
Received: from SA9PR09MB5725.namprd09.prod.outlook.com (2603:10b6:806:47::24)
 by SA9PR09MB4686.namprd09.prod.outlook.com (2603:10b6:806:4b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 22:22:18 +0000
Received: from SA9PR09MB5725.namprd09.prod.outlook.com
 ([fe80::6d00:3e06:875a:9952]) by SA9PR09MB5725.namprd09.prod.outlook.com
 ([fe80::6d00:3e06:875a:9952%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 22:22:18 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: lttng-tool for configure for `liburcu` doesn't use PKG_CONFIG
Thread-Index: AQHWpmX1CLG67E+ETUuLkTMh9IIIwg==
Date: Mon, 19 Oct 2020 22:22:18 +0000
Message-ID: <SA9PR09MB57258DA2DB866F09A1950BBAC41E0@SA9PR09MB5725.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:249:300:d890:310e:269c:7652:7123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 121fb685-f309-45a8-fb18-08d8747d70d6
x-ms-traffictypediagnostic: SA9PR09MB4686:
x-microsoft-antispam-prvs: <SA9PR09MB46861CE333E3B84E71312B82C41E0@SA9PR09MB4686.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkPb90CXGQkMYNYvQke36oHe7I7t+T2ISDZqErhbyABWY+LbjHoFgA/A70PBp/qR/1Dd59c9m975IRroIN2lIvttGiA+tMZEZEyTPEH/JSwWyYOVq6GqntvsjoVd7X1OSG9Kqs4zD7KP2vTM6JSlRAzbzKzhKAzh3hKH4sXJpJTz5Oq9/TtUPGbAQEh3fe8qSzqPa4eNstGLPtXKQ47igB7eqyaqvDYBJt0j8W5rU2xxdQQms5sDrnRmkxGObYjJzf07DX5Q/C0gO2AG0qvQc1E5VZokIUACrF5cPIT6IqupxhXj861UJkMHuPIpI0r/QsUsa+g3ewfctUmPLpnrnGsNhKYPtXIbQQEd7Awh/OO2YTpEYa71+LdqpKOp3N6K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA9PR09MB5725.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(19627405001)(71200400001)(66946007)(55016002)(66446008)(7696005)(2906002)(9686003)(91956017)(76116006)(10130500003)(66556008)(66476007)(64756008)(186003)(8936002)(5660300002)(558084003)(33656002)(6916009)(316002)(52536014)(86362001)(478600001)(6506007)(8676002)(81973001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UKHGmrSMEbp4oZEPE6VPs4Rl9EQ6ALBNIZQwZdRy8o+V3oW4hjL3JPJnRIlk5iZWKnNzmAH3hl8ywKYxlzXp6NDwctVTdowU7TClaJNHQcECcFv7OMLTY8aIwXl+0YKGD9P48bUuYiO2oj/5hNlQu+6GAWPV2uGQL+1/9xoPWiadflxuHgPJQLvAEDuGtUP6wS23a1xv19au7IYSbF5mDCtm5BL8BFFNkYMshxdrEaFjLnhHFLYYfvg2V2zo0g+bDLL59G2deVYkPqm+Xz8WATRcRJ8TSzheZhANZsIDv5vxcUMvICUs0sUpmG9/KSYwfhmai8ruozY5MMOCKFQBly9sN6MsJeN+2W9ZdoX0hI1w3n7ZfkImGGR8bsVBWlqmJtmMFsH/tE8QyuT4Rh53XKZJqwP0t+yeJQcpX6mVGraj0g0McG0CbmGOeJ6Qi3fTl/jOfuVGn1w3IA4HBnP0ccLry4z7ynOs5ISa9I36flt445RnpJKWbqnhCGJwbCnTdiiBCzmmtoAvTaj+vEd17haeAN0c5aor7bQOV049htGlQK7BOOUEqEofyCTlnEoIs+GLLsLvjJnCb1cOjJPymtgZ/iOZUuQ6uzcrC9+egVCzPcYHe3Jdq9MJRK/OPWdXGCML410Os/3RKxIlmToLilv6Zb9OMGns9eBtohnppgx2+WM2tYlk8B2mkvYelViL4Rtn3KRVWkm2gvwo1x1RsA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5725.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121fb685-f309-45a8-fb18-08d8747d70d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 22:22:18.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0cfca185-25f7-49e3-8ae7-704d5326e285
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sk7WPSeM0xyRxU2zsPY6l03s1gE1hlqXTvFkR5wF9/jNbKhRSfh7CKRt81lq4qf26MM0wHvmqIN8VMTGTVmJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR09MB4686
X-Mailman-Approved-At: Tue, 20 Oct 2020 10:34:35 -0400
Subject: [lttng-dev] lttng-tool for configure for `liburcu` doesn't use
 PKG_CONFIG
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Applencourt, Thomas via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Applencourt, Thomas" <tapplencourt@anl.gov>
Content-Type: multipart/mixed; boundary="===============6913629482991251811=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6913629482991251811==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA9PR09MB57258DA2DB866F09A1950BBAC41E0SA9PR09MB5725namp_"

--_000_SA9PR09MB57258DA2DB866F09A1950BBAC41E0SA9PR09MB5725namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

When having `lurcu-cds` in the PKG_CONFIG_PATH but not in the LD_LIBRARY or=
 CPATH it's not picket up by the configure script.

Regards,
Thomas

Thomas Applencourt
Leadership Computing Facility
Argonne National Laboratory
Building 240 Office - 1.D.18
9700 S Cass Av., Lemont Il, 60439
(630) 252-0036



--_000_SA9PR09MB57258DA2DB866F09A1950BBAC41E0SA9PR09MB5725namp_
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
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi,&nbsp;</div>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
When having `lurcu-cds` in the PKG_CONFIG_PATH but not in the LD_LIBRARY or=
 CPATH it's not picket up by the configure script.<br>
<br>
Regards,<br>
Thomas<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif;">
<div style=3D"font-family:Tahoma; font-size:13px"><font face=3D"Courier New=
"><span style=3D"font-size:13.333333015441895px">Thomas Applencourt</span><=
br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">Leadership Computing Facilit=
y</span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">Argonne National Laboratory<=
/span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">Building 240 Office - 1.D.18=
</span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">9700 S Cass Av., Lemont Il, =
60439</span><br style=3D"font-size:13.333333015441895px">
<span style=3D"font-size:13.333333015441895px">(630) 252-0036</span></font>=
</div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_SA9PR09MB57258DA2DB866F09A1950BBAC41E0SA9PR09MB5725namp_--

--===============6913629482991251811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6913629482991251811==--
