Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE959EB64DD
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Jul 2023 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689712081;
	bh=2MTx1mNAE61RJIsudGyC483Y8RZR9QZ90eSF3oJ4afo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=QalhzOU3u9GY54lg5800t/TDN+NJUsrEwh0Hknil5nYdW+i4j/Bi8knZnYW/Tip1y
	 K+Zf6NapG7hHYIMsCtRxVndWmWZgz5iuHPJuy6ByR+KuV4tLHgSKEpIZVXb1o2Ns03
	 SP4klobCEkqpS59SWR5/V0swK/2S1TmFZEeNQ2p07POxKnE00ipiu56UGwLsvfoFbJ
	 JZ6CH2QqwFknD2U1jQV9bw/7qDv7gRV2gqXyz7pZtBPzeW+7JNMy4YnRXaUL3BYfGW
	 KV/Bk35yRyNXmzbBrmChgO3Vr/RnN6efB54Er/aoqpucxa9qFtkTbdfzFkPIlckg35
	 mY1dCXiqOQn+Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R59W45nS0z2C5Z;
	Tue, 18 Jul 2023 16:28:00 -0400 (EDT)
Received: from mx0e-0014fe02.gpphosted.com (mx0e-0014fe02.gpphosted.com
 [67.231.147.114])
 by lists.lttng.org (Postfix) with ESMTPS id 4R58T81npgz2C2y
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jul 2023 15:41:16 -0400 (EDT)
Received: from pps.filterd (m0210942.ppops.net [127.0.0.1])
 by mx0e-0014fe02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36IIBcG4031704
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jul 2023 19:27:34 GMT
Received: from usg02-cy1-obe.outbound.protection.office365.us
 (mail-cy1usg02lp0176.outbound.protection.office365.us [23.103.199.176])
 by mx0e-0014fe02.pphosted.com (PPS) with ESMTPS id 3rumrka0r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 18 Jul 2023 19:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=vJGS5p1UIQlJPihny/l/VPJitGSsbLJCxvVvNWE+ha81sn7rbj10IWOSpEP9UPeJ+NEM5iQjjw2ooQTKXo2tdblBcDIrxMQai/BwFkkf5EQkt+nBC/7yMeeLdtfl1yLaZjn1v9t8WrkiGJARElMZ22WEUWIb+K2R4ZMeGtjt7F0SKOEQg0YOWSdQIt4DiP1gRz/ZnnHuksiXAH2zmaJxcvIKYfKnq069d6StKbdi+LuH5wflCxiStQJ6tk9ghICgUicu8BDmWcdazmhgdz3eLMxuEcoxY30y9zN2ur1K8mlCiJP/L4RE6dkDW98FuIMxyMpm/CDewIQwrs3VdkVrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9iOUjBDqohjD7mnTzsG887Eedcj/x1QmjNRemwH9l4=;
 b=rCoXS4m6TqXWEzMWwJ/ZV08aSszGIkd0QQgwezlDAi+hxxnlrsqxKZEZb/mwMOauWgsBtB4jhw74+VtTA9DjfyT996dRRtljkFqXxz4RBdD6uDRfIFa2RK0pQAI68/MNipI1oMzIhSFix6COzFxHWKgyDzLmjjq7x4nkUo373crZ6Y/7MoWj8UZRR2AKzeoRWlLrT3hE5fTC5uijPW4tOEXoYyfRwxwNneCXvCM5/ijin890/xlSK5pIRUnEZet6U7bpm077TdUO61LwkOv6QXelSEL8UhThRiZPGGzEvL0McsGr/PMwWKBXsv7rP16+blu0wZWpT+8ZsP1uOsCTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ballaerospace.com; dmarc=pass action=none
 header.from=ballaerospace.com; dkim=pass header.d=ballaerospace.com; arc=none
Received: from BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:16f::10)
 by BN0P110MB1307.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 19:27:32 +0000
Received: from BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM
 ([fe80::22b2:294f:654e:2e4b]) by BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM
 ([fe80::22b2:294f:654e:2e4b%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 19:27:32 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Status of LTTng-scope and Lttng-analyses
Thread-Index: AQHZua2X0FVnjl5QPUmhulwhRf7CPQ==
Date: Tue, 18 Jul 2023 19:27:32 +0000
Message-ID: <BN0P110MB0967334AFD6A7CF8DDD3BFBC9238A@BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0P110MB0967:EE_|BN0P110MB1307:EE_
x-ms-office365-filtering-correlation-id: f733e7a0-8408-4149-e09e-08db87c508be
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmgQ+47sHsdyxmVePRgGOkMJPYODRxNkYBUfxz4ZkfyzW5hnPmtb5+jeV5UI1t7PMMJsIQcdm2khnwzEvQfJLGuNYcazAmWJjik2bzUlLzseogdFeYg1c64V+HxSwb6itDQ02dkjMjf3sdT4j16j+lbvQtKljs7qU+8XFCVrxTa2do7Oee1L8puYe6SDl3UBI73Ly3XbfUb+jRlTTrNWMXTyHyLH1hcm4Qpz5u2KIp0dF0vxiUtw/bJekj3AsS28PcZPYvll2P/WyV2qfXSb3KVRMzyFIyKljBj/BZPIZMQUicSwkeyM+QJIY+3AltlvCJsEVh8hWpPwklnLiLlWEu+Udv2vpujaXYe7Rf5DuScnAgsc+qyiZ2jlOt4dgalAHLO3Mi7yurFPq3U0neuOcsOI4AFIcUhsmVHTUyXrPvQ6qyXWKNlPsHmgdokzxIrLf5D8qSKVVytYZNBojq8n06BtzGjm1MWUYnh5beRpoaREHE/sHj7InTcVl0jlpBgZ0f7GCpYBfKxCETKe/JPDv2qb4M/mEf0bkXwSdGupI82MTGLfdTIq6JYQgGMfjRFAngr21V0vJ2A8jVvkoRmXUMGqbR48qgaVdbcM4BNnivNq/228YBcTQPTApi247PQ4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(39830400003)(451199021)(9686003)(7696005)(186003)(55016003)(26005)(6506007)(558084003)(71200400001)(66556008)(6916009)(66446008)(64756008)(66476007)(66946007)(76116006)(38100700002)(122000001)(33656002)(41300700001)(86362001)(41320700001)(38070700005)(5660300002)(52536014)(8676002)(8936002)(19627405001)(508600001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: wBBM/BuzRVXBeDNKqg2OoaM7kT9xFJNsTmivbd4DDr2/1OjtuUgR35p4OjWbPZZAx3qpps/V0/VhLnfZAC4otmWzfb0dv/29hlAig95EXiKYc4Wdp5xsrdKLZ4KTiGqgp7GjxDMXXX1EdTvoXCHgCTzWHgKj249nkZz/nS5NCm6tyD33c3qhL1enSvlRomnGsX9YfIm2e5msdjTeT8NI5YuHD3HVmWZIwQyHCCte0qess7LeaFSDepAerzIOUbzu9dYDFrNGFSNGhBd1Pw4hoIxJNrmqJE8yYGBspRSx1gBGFMtBTdGo+qkCfRw1rMle5/lYr2qN7AxM+V8ju3smvmpwJD5231+Vf3nu/FCRDi/xHXHamLCzc2SMqEwYOaZDNuzgwyfPwOxTxkm/ovwJd7ikkH7WlL2plMnxrBLptlE=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sxzgEYZD5KYUradt+Z6o3/pLIrEg6ULE89ywP9fyS8I3y3SSLD44pwwRF83bmRhAk+rU4Z8fDiNqo8nCKnbuebSneVOCblM3rMlHohzNWDvrYYZvwuKEmpIiQM2zSAX3ZtgkqXtsdvEAD80vw+3SXHEI3aDCEl0u7GAzOKaOi/d1rpG9fIpdJsKea6Mk72ltGQqb2Dqy8+qp42gWKw241YLJ4ZbRFch8/aUNdi+a4EWH3+JbZE1roBcnddangy6QrXDwLMM37HQGPzmI74DMnrS6DdWUWktVSHLbfFiAS4sJVAkCX3JB9sunAfDdT1Vg0o+KHwYsUuKNsxd0AAhTsrxfmeJQCvkeMpMlBjZMttO59ZNRLSCagvDS+w2c7jIdP4Y2/PCWvCnUfXKrm3XmkPPq5UHqaiR9oaNAFY/YoCvTE2zFNnSMvPafhijpAkZzbEFH2yY94teiBkwiuOQDspshkGeNmln4JVFxt/fzNsJiZp8OxF+3kpcQVVXOQlpnz82iupO2unAp2H8e+sG3+Xdj/zMtyGRP9Ry/iCZ4CN/3uZZCzIQTabsjdks7riYeZPMYZ7P0qwk+57RvefchGP7H9LwTFVaPSchWB+NIO4/sKqUgpmU6pR7U4bbJN0+WPlIeCPP5WdajFWRHDXOB4NqNmtlOrjyiN7rQeSqL6zW6nxToHHSiRHJE6JPfojy4UJKCDKNJVxwpNvXxVTSDWKkZdQkR4+hW08WkKSyCUvpfv+hIf8e2gzkFIVeLt/uMyBgrtOBaNyAl/nO3IjN4x4Hk+yGfLvF9JlkMOCm3JVc=
X-OriginatorOrg: Ballaerospace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0P110MB0967.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f733e7a0-8408-4149-e09e-08db87c508be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 19:27:32.8073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cb0751b7-e940-4c3b-b051-95460db7f4d7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0P110MB1307
X-Proofpoint-ORIG-GUID: gu-eOkUtpT5GYNIwFkuZ4mhUPrPwE6FM
X-Proofpoint-GUID: gu-eOkUtpT5GYNIwFkuZ4mhUPrPwE6FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_15,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=outbound score=0 clxscore=1011
 impostorscore=0
 mlxlogscore=619 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180177
X-Mailman-Approved-At: Tue, 18 Jul 2023 16:27:59 -0400
Subject: [lttng-dev] Status of LTTng-scope and Lttng-analyses
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
From: "Cook, Layne via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Cook, Layne" <Layne.Cook@ballaerospace.com>
Content-Type: multipart/mixed; boundary="===============1957672880470547054=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1957672880470547054==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN0P110MB0967334AFD6A7CF8DDD3BFBC9238ABN0P110MB0967NAMP_"

--_000_BN0P110MB0967334AFD6A7CF8DDD3BFBC9238ABN0P110MB0967NAMP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Can you tell me the status of the beta projects listed on the web site?

LTTng scope
LTTng analyses

The github projects haven't had an activity for quite a while. Have these p=
rojects been abandoned, or superceded by something else?

Thanks,

LC

--_000_BN0P110MB0967334AFD6A7CF8DDD3BFBC9238ABN0P110MB0967NAMP_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Can you tell me the status of the beta projects listed on the web site?</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
LTTng scope</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
LTTng analyses</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The github projects haven't had an activity for quite a while. Have these p=
rojects been abandoned, or superceded by something else?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
LC</div>
</body>
</html>

--_000_BN0P110MB0967334AFD6A7CF8DDD3BFBC9238ABN0P110MB0967NAMP_--

--===============1957672880470547054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1957672880470547054==--
