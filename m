Return-Path: <SRS0=Alfd=H2=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1AAC433E0
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Feb 2021 14:46:25 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9178A64E7A
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Feb 2021 14:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9178A64E7A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DlzJG3TrMz6xr;
	Wed, 24 Feb 2021 09:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614177983;
	bh=2YS22ySbq56Q700BKydiSvvE3Qb/pHROzk7GcxkCCEo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=XaRKoYtVB1sOHyrm6I6/9ZzhqCyxwfqU5iRqx1q8rVX4M5jBBkVYbWPhcaK8BazgD
	 wy70ywPFKVSDwC41Oc38kVVMojZ5YEdcolHqEB8PST5jzGGFvNofHOSWte15XDs6cv
	 wFcg0acY7Mw/uacx9C1mMNTeUmoGMb1Y0D7RvMtOBW1rWaeG1xyze96eRDmAwsxaLU
	 YNBv2+/NiOYdzYsNZaLiV4ifPtvm9MU2Qtaqvu9zz1wtiORW5YKgAtC1cQbwSViKnu
	 OkZNN+n+jGMhlPnqQC28HuwJHr7M7Ye546I01PutuuOQyDPtKv/lDq639yb75BjVkf
	 vZj6QbE98P3zw==
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760059.outbound.protection.outlook.com [40.107.76.59])
 by lists.lttng.org (Postfix) with ESMTPS id 4DlzJD5jl5z6vZ
 for <lttng-dev@lists.lttng.org>; Wed, 24 Feb 2021 09:46:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ludtcLx+pOXP3prgtfzdc0c2RvoJmhNykDub+BSIxK4YISykJ0zbH0PdSXnGCfRbjBIKWyUPYCRkRBV+WVK2IrLPC8DhdhMnAk1CUp/vxrt5jH7c0IE4UmHuHaP4eAk3tEuU1X+xgOwM3CGkUzXE9SGY/yAaTBzGtYcFXlD1QhY1LyIleJAb4PY9vsqv4f0sHLlnuyKLvElBdfq2DUzDRuX0xWIXIfFRzSGQY938fg9hbWPJXug7lBQAjBbfHTOxs+Zdw31J5supJ5LA61NR2geHx8C+op94x20iDBUU2rtNJbEeSG7X0tVL8MeU7UzMAOhwUuxpUMI+6l1cz6TCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LShDrqR3e/X5lv0DkBE53BGASw/ssIbkYohoQ0jAXU8=;
 b=LB8xz4xRvUv2JpPN3zUN+/ZBMJdiBv6ByFSNailiChMGG5bQg+wLF0X/OsuVY9IabJLg02QpHJzptJPE17nAZLoRDx/rodLn81vHHiZQXiUkdq9ix/GUydid9KTUsYApqbb/XrBnki8Zu/j5YoaG8NFVpu95/BlRzfkkbDlxDqGgTVi1yzxF/pNj+v53mSZcBDy6DMyJ6lPclr6TXkOscWVtI4qQqlcec3+Wi+6fLA7sqGYWO2f4MA2uJCWwd7Dn6vf7XEpF8te8hkYieiSA3KN05VcPZNkeweupnmH9WqReI1ITLPbJ7tWe15HNiM1t4SvrPh0pxoj9bOVHaY8FHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SA1PR15MB4355.namprd15.prod.outlook.com (2603:10b6:806:1ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 14:30:23 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2%6]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 14:30:23 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: CTF 2.0 suggestion
Thread-Index: AQHXCrlrsnB8nDbKK0a4b9XEEKXVUg==
Date: Wed, 24 Feb 2021 14:30:23 +0000
Message-ID: <SA0PR15MB38397500035E01813D3065499E9F9@SA0PR15MB3839.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.24.6.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04f13ffa-7db9-4eac-8ffd-08d8d8d0b8b9
x-ms-traffictypediagnostic: SA1PR15MB4355:
x-microsoft-antispam-prvs: <SA1PR15MB4355EB3C18C45B237C1E98069E9F9@SA1PR15MB4355.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uLFYn+UF4cSoYBL+vKOFw/TV71njZSUUtjji/HiI6ioFJ1aHBhSFG0BDOe8g4OS/2V5eQ+f746okaw6slGBRuaRJHDOUVQlPNuTlmOxzfdLo7xMuwwuKcVXw6eZRMF00qIiqItsVI9e9nsNQk7jHqnFhxr4xVU+r0VROJ04CC/4YlJoT2ZH7HFyLNDKekinAzunstNWEL0K2X5Z+wicxUGIiemQ1DQ3Od/slNNGWZ5I1dyC75ddpU2jUJq2JEfcpJayShm4xasQMOtdt9mCXVz8nv+slyWjjAygKGmK037e+nzCiuiCxr/DAIrlzpKdJJcQ4OdfiGu3gPfKy3VNyFam3NHGxoK01L/dpthbymXT6UoXBetUYKcSGrCfW8MSvc/azCQccM5lGp5yhnqB/xnt089Y+R0T/GHkK7+2aw309qos2LdmB+QMyytEy5m9zUQniwkl6QEgPC/irRzyTzPUJSWPf7OO/zWrDTB6alDR/I+mCCWhDOKPGQNJuEzjL3cOmrilrFFAibs7zxcUy/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR15MB3839.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(5660300002)(8936002)(186003)(26005)(8676002)(86362001)(316002)(44832011)(33656002)(19627405001)(52536014)(7116003)(66476007)(6916009)(558084003)(2906002)(64756008)(66446008)(66556008)(76116006)(66946007)(478600001)(7696005)(6506007)(9686003)(55016002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RdcR3Yy88gR0rZUoVo3ZCKQSqNgW87KeumSTMoAn3StmegcFBtJAz/Jp2r?=
 =?iso-8859-1?Q?ZHRVwdiTCEuwmRqVkmP3z9M6nK7qeTUXCJHo/RckDdwueGSiEUosILex/V?=
 =?iso-8859-1?Q?cEowDLkqvyp6LjuLvD/n2L1E0laqaztzV4xBL5Djz3x7xy7sNf6xvqKx9f?=
 =?iso-8859-1?Q?PA5iUsbsdx0bA112tdeCmc9OPSMlFSZvbaOxbq4zc7g3LrurWS3PwLG2im?=
 =?iso-8859-1?Q?iJ9JnAUT40ofJnwS6NSM0KKjY5gm+X4c9ZCYl2BneBxiIhUdWVjokp56vd?=
 =?iso-8859-1?Q?SifXmJdcD0fgZLJDlLJi76D+stCJNgeIoSN+PVcfiplRxJHolja6mCkavS?=
 =?iso-8859-1?Q?SFGMqeBvzMvyjLOBJtVf/P/4EwhVMGqWXAQciurgZLPA0hUnZdI4iY3Drp?=
 =?iso-8859-1?Q?hHSJ9rKWPn6h4tZvmAG0nYg1uhxGUqG+wNW1YvsjSTUOwaxI3rcbKCqEk/?=
 =?iso-8859-1?Q?WWHoBzHtnSitkG25N8PrAqclmrrSOYmDPD0Q2BGFHcMxxHKM8V2okB5ASn?=
 =?iso-8859-1?Q?m1FgERxmllxV1mkpAo9/YESlNbRdimCg+rJSrV/TEAHpDd5YJX2UK7gVPV?=
 =?iso-8859-1?Q?NUi5KwfCHUVh2vhltNrWIzwrRkTgEP1/tFdAW2ImUjUlD+cOX27mGfBsBY?=
 =?iso-8859-1?Q?/wvwlWtGJZ/MhGM8g+CVwg0vnHgqat0JDE/vMcB8JHxp0ssYKDCUxR4yld?=
 =?iso-8859-1?Q?XkJoTxabeNDNXGuMycqru9w0XPjsto3TJnRfFwQzZdWDXEdP6ac4ELpc8o?=
 =?iso-8859-1?Q?83uLOn8rEsZnSdOjCl+tiYkFryFDS19/vI+MzCNimjn7WEA6w9U+0ou5ZT?=
 =?iso-8859-1?Q?tmFuzB5ndPdB4eWquKfkrneg6HPowg6KhVeU3W1T2GpXiNtxAmqgSLnkZN?=
 =?iso-8859-1?Q?ixm1W0IXEx8ACIdIfP0PjtB+Qj8Fe3sPO/7JqbGhYA3JYf304Kf50/d1RU?=
 =?iso-8859-1?Q?Fi5WB/mbm7X8O1LS2y4D9Z9vUzFs4LdydRN61lxl+wS5bwnOiIOpFEk/je?=
 =?iso-8859-1?Q?5aFyi7iGEGHq4hrIBdxUSBM2ZoC5Irs3vm2C+YVULIo80YMCY2gp3jKSO9?=
 =?iso-8859-1?Q?PumX85mumbAONjSj284R/lrNE9bX4EqNS6JiVkpfIsuUDeEmOIz2jJb31A?=
 =?iso-8859-1?Q?qFRS7iFtI63fW1iIVGkAp+4Z/IWS3xlHHSUjVvYy5JLeS1lzyL5EFYx6Fj?=
 =?iso-8859-1?Q?/TiTras5uLsxbAbTi+ujh1vepZrT7uaNLrZciCpbcwxoGJDd6Z1dvFdSye?=
 =?iso-8859-1?Q?FHCpxcUyBhD08KNTOqYONEpXZAsXuvKqMZuqWSXk/LjDrlS8g+YkKMsN1y?=
 =?iso-8859-1?Q?F8Agd5Nc4lcqCVGDOQbQk4BhENcL3/Bnu11vib0nxvxbujU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f13ffa-7db9-4eac-8ffd-08d8d8d0b8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 14:30:23.5188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SVBPvNdqF+634FcjnBru8DmzeYBpxIfvGzECT8W6ow53SVP6oG/ZqoDU393a1RhW836hjDv+ALvZ/+zcSYZMEpE0w5Lt2TH72v9pfHZHgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4355
Subject: [lttng-dev] CTF 2.0 suggestion
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
From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Content-Type: multipart/mixed; boundary="===============5919878077768344873=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5919878077768344873==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA0PR15MB38397500035E01813D3065499E9F9SA0PR15MB3839namp_"

--_000_SA0PR15MB38397500035E01813D3065499E9F9SA0PR15MB3839namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I would like to suggest adding an extention to the metadata file. Any exten=
tion that's not commonly used. E.g. metadata.ctf. This will allow mimetypes=
 to be used and viewers to automatically open the files by double clicking =
on them from their GUI file explorers.

Matthew Khouzam
Ericsson


--_000_SA0PR15MB38397500035E01813D3065499E9F9SA0PR15MB3839namp_
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
Hi all,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I would like to suggest adding an extention to the metadata file. Any exten=
tion that's not commonly used. E.g. metadata.ctf. This will allow mimetypes=
 to be used and viewers to automatically open the files by double clicking =
on them from their GUI file explorers.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Matthew Khouzam<br>
</div>
<div id=3D"Signature">
<div>
<meta content=3D"text/html; charset=3DUTF-8">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<span id=3D"ms-rterangepaste-start"></span>
<div>Ericsson<br>
&nbsp; <br>
</div>
<span id=3D"ms-rterangepaste-end"></span></div>
</div>
</div>
</div>
</body>
</html>

--_000_SA0PR15MB38397500035E01813D3065499E9F9SA0PR15MB3839namp_--

--===============5919878077768344873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5919878077768344873==--
