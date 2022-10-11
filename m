Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C5C433F5
	for <lttng-dev@archiver.kernel.org>; Tue, 11 Oct 2022 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665521880;
	bh=TWnB8q5j0GffZSGLe5vAqm1G/C+R8MlJ4qcubp09TmY=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=hsQT+5s1thI9IELn5kwRVvH99Ke/fK/ONFFVi/rjXMVu8yNTksBARil7NPVqBbkbp
	 JDSfCndCGJkzU4a/Oq5g1LNlDADP+b1Au1s6dKvsUfMk/ZzuTO5K+41/pJCjMUGoE6
	 RpvOi2TT6dfJ4sEHx3rNrf5TJi7ebhtYftwjsFJ4SRme7igNUnc87Y0+Db2G6u2j6B
	 dcJZFkt9w6Iny8S9CkbRIfWs3VXl8zQ35OkwZ2I9Rs5IrnFfY+IBm4V6wm3Pdnko16
	 VHbKrzkKaNLMdjzYmpe0K4uviG0VYpg7mIBBEJuuDqn/PlTkjQijpcOpIKL4ZAIaA0
	 AuXg7bN9Q09Cg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Mn7Qw080Cz4RS;
	Tue, 11 Oct 2022 16:58:00 -0400 (EDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11olkn2073.outbound.protection.outlook.com [40.92.19.73])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mn7Qs64h3z4RB
 for <lttng-dev@lists.lttng.org>; Tue, 11 Oct 2022 16:57:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rac+yr/cvG/EKkh2zcUQljqf+bAzYOijmSepnDX2G8x7DBAG5VGmRfaT5J3rdVH7T+/riZd75HMMyYJ5IGxjjCP9XtCwvUDABMg0TyXuAux0jSm9+LOdBHL7dZfxrNeeW0CE2HhadtgXl8cJ/QIoiid2A2LzZiwb4kCrTpXSA4Ar2+GyRzIH4HyxPu5TXZ3MUcIq24Gu/jSBpz+HeXiKNjBi7DxtFuv+CUABtCjDOybXv2R69bwzD2IwEN2OVl463QZvD6Gj5aFlnTz+p0bN7vMsXLa1Rlks2YUbVFM5HTFvmMNIKkeVTN1ti0Wx4IXq5Er0FRLtyCrOSlr/lOX+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUhrMjmlF/wTmJg3AsdS2ctRf9zMoh0kvJi1kR+00tM=;
 b=Qfyuopkexe10c5dL66QWmHbzFeZPlXr5Fcl9VoABaXtf2HPfFUdZNX2aOMkRgPy+AW5//e/ktl0Ch01/b5p3LFMUcfaBO4x7a8TirStQmifQ2AoNQyf6qUGbfAuWiP7bjiBNpL2XUjUZU5nqLfHi9fpy5/nzsZokaLVNXQWbyb7tsHgnsyJoD95hhiyeOATBJXSkzqoer0iSjJQVCaaGAUVv5Cv4Rv/xiHIG0Z0if1EfxburF37Aypy082N+WmC1y4w1TwfV40CKr8pULnOr3ai9+ybGYcbhTCixCGwnkWO8+mgkNgRnLGhO3jZRMCT1RiNMS/G/eALxkVWOZmRoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CO1PR03MB5937.namprd03.prod.outlook.com (2603:10b6:303:6e::18)
 by PH0PR03MB6916.namprd03.prod.outlook.com (2603:10b6:510:16a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 20:57:56 +0000
Received: from CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::bc0d:7f8:a4bd:7b6c]) by CO1PR03MB5937.namprd03.prod.outlook.com
 ([fe80::bc0d:7f8:a4bd:7b6c%9]) with mapi id 15.20.5676.043; Tue, 11 Oct 2022
 20:57:56 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: lttng-ust on arm64 getting bogged down by the getcpu syscall
 (taking more than 600ns per call) 
Thread-Index: AQHY3bKHGDMyO1W790+WQyQsoRbVcg==
Date: Tue, 11 Oct 2022 20:57:56 +0000
Message-ID: <CO1PR03MB59371096D2E4AB93558EA072E5239@CO1PR03MB5937.namprd03.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [ivEAQ4gmghLcyI4DBioUr+gXQrnic2MK]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR03MB5937:EE_|PH0PR03MB6916:EE_
x-ms-office365-filtering-correlation-id: fa2a5c0b-7bd3-461a-56dc-08daabcb45a4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TNZUCcWo2KlC0EPy9hsRO7CD8u9Kyqw09abL8eDx/EO8EOdd5GEN6W3bVuGTMzdww7mBk3KVWvg+6oDsy/OP8AQTbPw2H0QzE73obJgyNvaK8oQr3HNmwKb0RWSSKZaVvn/7eplBAOdfNkqZYUvZgUlV07pR8M+JxkoRL7Pvl1XKGkR8bCI4H2xAey5PRYJRrCNVLS71afYA32P+DAALSz1Tqw5GsXxylraTmL/uZgw7B6YruGzB1VWf/I/xXnzD62bq6lrQ8TCPcGDu8NJvlCR0eUOxk8oKEmM5FkomM3Pj1JICCmlTE+zxsUN2UPPmO0QSkJIB3HL6uHv9DhV0tCzl1a2TI3lAy85bq0bOoVEADQt0netJUSn5nPE7koURERjyoTWIRtCgGGoGGXle1ybMNfUUw+NUeSK4wBhN/cXdj/czVSVrkPCMvcQTCVAtiPAdUdA3wopUjLHPtWAAw2/xFryfAeQBlPTgR19goXYbyfrV144XU2hWhlszZefLzot5prSQuE6CuECJL7BdtOilBFiQno95wqEVgMFETbHvesQDg7aF0t0H7Zn5XuFXH2OFuqPZehOeUhzQHfUXPKXxpSqR0IQk48EqjTPom79Jk9m7s7jD+7++vjCRtO4NuA4XiV3AEWOUNNqwjkNTw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KGF8Msb16DrNDyZzucQ5TJMeyE6M8p8mYJ3NPUOAzC3byRNu1sZBHwDqH6?=
 =?iso-8859-1?Q?ilg/O8QGNmzFpmztRKlcRdPGnx8xYHx3mMVtzs8lNsXR20LaExce8XIbes?=
 =?iso-8859-1?Q?E7cH5k1a1rnc+FrJerlN0kVKoBPyyptu0NdLbypxiE5cu584EK0etFlzht?=
 =?iso-8859-1?Q?mQU7Um624HjMmoLi28Skl1M1DKwT3Xd/lqvmwNxLJwAGzz7sjREbGZ8ZKC?=
 =?iso-8859-1?Q?YD3HPYMI93KsqidHa6ZlO1Pb/5Nz2IsX+vp2WJLWK2OD52Vkw7vWADYedi?=
 =?iso-8859-1?Q?N5pTZuedSvfpDCk87O0kXpHz9J/JH2hbXcASrZzEbxL+LBBitvW/fzy+eK?=
 =?iso-8859-1?Q?LTPmiefUCevmAl9e8bMSmE+TNUQyJoEqRjXRcO6yt0aRYsPvDLgQwNGIJk?=
 =?iso-8859-1?Q?MKBVEEItH6mco2NO+mtBQwQqoz2NfR2IhrlVBIJcu5W7RzKhRXd2x+NUgN?=
 =?iso-8859-1?Q?Z/s5lzrTaZC6sf1hWdrE9x1Ui1vrQ4pKhZmAWRjNkMb46hmdRTPZbBlivX?=
 =?iso-8859-1?Q?k9PtC7UDFZqQZ7GobN56sxf+ABspxmutvi31PCQj7MpVqhjqrX0KRYwnRq?=
 =?iso-8859-1?Q?bMWTi8hkGWm8IKm+cEh8Y+L6fYvuIdfRPMEMyU5QljhfxBRWsQiIegjZtH?=
 =?iso-8859-1?Q?DHw+d4Mr44ksMYIPuNzqcOvXQcA5RnxSiL93Qj905AaV1SU9tfsNDYY3+2?=
 =?iso-8859-1?Q?VY6I1sNW+Czlmd8EhToR9pqumlrcIro+CAHMaNZ23COHENTizDFSjrlFXj?=
 =?iso-8859-1?Q?J1TlebUSoLVBeOWCcyTWobnFcn5yBCSFsSeNtnMsde+zLX3LwY6GwTsRPR?=
 =?iso-8859-1?Q?hMwpXd0MvpPD15juR+j9+UfZZ6BIuotCOogOeyMD2jmChTAJKdpG5V4eXo?=
 =?iso-8859-1?Q?ZFVmfRFWJG2g3Q57edNNB+NLfaDUap/+58Hqe+HmvqJGai6ZQ0UR5IpJzD?=
 =?iso-8859-1?Q?56RrjG2W2AVUSwSFZ5f5ukPxqZdSDTN42HT/7uzGC8tfrncfreA+VFe8q1?=
 =?iso-8859-1?Q?Q0Ouza55wtqcxiGC7rkZfTUw2gW47jNecy4nw5d5C6R+eM16EH55u2dssB?=
 =?iso-8859-1?Q?ZKX040CHdBABB2ayEzzdx6ZSe5euyvuiNwJQOP16Um0OMH0fDrrJ+QVCBq?=
 =?iso-8859-1?Q?nVk3mfvlkmquF+1LDen+Id0DXCwiB61T1F/vEYx8zCyjwhyJWU9p7nCw1o?=
 =?iso-8859-1?Q?YbSgmdJzuERiKjKGACPxL1NLlTCtaY2RAHtRbVjQ1a6Zf/WRwRGpeADlaV?=
 =?iso-8859-1?Q?rvh6MB/CWXctHWkagvN81r6d3dWk7mzDoqPKSHdtvcWcCxXXxhInB+Xjpb?=
 =?iso-8859-1?Q?6hGRVWbPwYnjQEexya6Ddu2ywA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5937.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a5c0b-7bd3-461a-56dc-08daabcb45a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:57:56.1299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6916
Subject: [lttng-dev] lttng-ust on arm64 getting bogged down by the getcpu
 syscall (taking more than 600ns per call)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Akhil Veeraghanta via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Akhil Veeraghanta <akhil.veeraghanta@outlook.com>
Content-Type: multipart/mixed; boundary="===============1799756741175575242=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1799756741175575242==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_CO1PR03MB59371096D2E4AB93558EA072E5239CO1PR03MB5937namp_"

--_000_CO1PR03MB59371096D2E4AB93558EA072E5239CO1PR03MB5937namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello!

I've run into an issue with getcpu not having a vsdo implementation and tak=
ing anywhere from 600ns to 80us (avg 1 us) when using lttng-ust tracepoints=
.
I am on lttng v2.13 and kernel version 4.9.253-l4t, running on a jetson (ar=
m64). I was digging around and found that rseq might be the recommended nex=
t step

I am wondering:

  1.  Are there examples of using rseq system call to replace getcpu
  2.  Are there any existing patches that I can apply to get better getcpu =
performance

Thanks in advance,
Akhil

--_000_CO1PR03MB59371096D2E4AB93558EA072E5239CO1PR03MB5937namp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Hello!<br>
<br>
I've run into an issue with getcpu not having a vsdo implementation and tak=
ing anywhere from 600ns to 80us (avg 1 us) when using lttng-ust tracepoints=
.&nbsp;</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
I am on lttng v2.13 and kernel version&nbsp;4.9.253-l4t, running on a jetso=
n (arm64). I was digging around and found that rseq might be the recommende=
d next step<br>
<br>
I am wondering:</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<ol>
<li><span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Helvetica, sa=
ns-serif; font-size: 12pt;">Are there examples of using rseq system call to=
 replace getcpu</span><br>
</li><li>Are there any existing patches that I can apply to get better getc=
pu performance</li></ol>
<div>Thanks in&nbsp;advance,</div>
<div>Akhil</div>
</div>
</body>
</html>

--_000_CO1PR03MB59371096D2E4AB93558EA072E5239CO1PR03MB5937namp_--

--===============1799756741175575242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1799756741175575242==--
