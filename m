Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDD1EB64DA
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Jul 2023 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1689187515;
	bh=mzqwrLShZiQG8qGRBkec0/Kolm1bH78ksysGzklS98Q=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=n2MZ9AuQAcf9/HmU47p/g4d9ZEWOlRKzC/aojsQ3f1qtMfCIv1d3B4936l/1S3z5+
	 /lvTOm3nnrpBvrg4zU/cE1CiUJp5Ga9twHqxM0KAWkKFZp8Xrc60LRRqFA/R/9IeZ5
	 mB7vl6TS2BZ2WdOBWbiswvDPGoXAbB90q7GOe1JDnJpU3F/Xj16I3yEj++DpneVzs+
	 nOjAjekTIwAGvGmyBx3LF2kmGBRZwg1oSm6cPyoDeENhQSxRdnxE8/a6lbuoQZ6Ykc
	 Ep2pVRvr8cidQSCKCBFYqYi1CKk9n1orT2Rn5H7Mgnjv+820bmK58Kw3yQXp2AjKkD
	 bGt3gnUBX/JWA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4R1RWH0GQvz29DN;
	Wed, 12 Jul 2023 14:45:15 -0400 (EDT)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 by lists.lttng.org (Postfix) with ESMTP id 4R1RWF44jdz29DL
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 14:45:13 -0400 (EDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36CFSKWD025124
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 18:45:12 GMT
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rsxuj9d7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 18:45:12 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EA1AC8047AC
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jul 2023 18:45:11 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 12 Jul 2023 06:45:00 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 12 Jul 2023 06:45:00 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 12 Jul 2023 06:45:00 -1200
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 12 Jul 2023 06:44:59 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq+1+AN+zTtqZEAyhYI0IZrmuYoOqy4rSE9c67G90oOe7VSyPYtAc3/uLk6GOWgGZOKr2aDQ5HxWfYj2w8UjL/WJpNX6tWJmIGuABnUs+gTjMEbGvhs8X1tye7tyzrryhGtC7clgBrGkQC87ggpqOu9DOA286r8nR++QbONfrsUkmyTH6+2TZpwydj1HrHTXXe+DToFTQzTS36H31ba/3p2vxX4MMhWq/Wb4BzkEVRhiYQGjbarzmdfigop9Oql6VjE50qd6/P9KidIYfUOB/un5i/TfKwuNs7th170KEBQU1/DblvPS5KXYjwZJ1J33gm0Sx1sbU9GPQ8HYDe4H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf9pt4U7DtQ98naRQcj8FmmcPsBBg7v9C8XHowitu6A=;
 b=I1dbGRp6y9COAjNVW6sw3LIVVDmbFee0oa3est/Gz1tuSj+O/8oI7QoNJgS1LeqWX8t0e7OPxyREbP4RK7kE/4wmp0wP1KrBL++aKwewJJPWpV53/wwyNibCniGBuIgVY8Z/r+btCxdsN3HqjzQ337Du5QgmqmW356Y483x6Jys1RUWz1vkX9UJMcpxyOaafQaoGw1TwZKXOcgFKgLFDEf0tmYHGtDh/Wa75t+Qb8fQoSJ1z2CUMa5hQrTWJzCXZVF3Y50KR7BukYZ2TN302PPItBadX7bJoXzuMivhgSZ2gOIp1COf4+vPg1/3kb1a8faMQ5Vha3UuHl++/EfX3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:433::14)
 by MW4PR84MB1370.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 18:44:57 +0000
Received: from SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e042:49f0:12a2:e11e]) by SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e042:49f0:12a2:e11e%5]) with mapi id 15.20.6565.026; Wed, 12 Jul 2023
 18:44:57 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Status of the RCU Red Black Tree
Thread-Index: Adm08JIi0Av1eGocTseODRJv20ADBw==
Date: Wed, 12 Jul 2023 18:44:56 +0000
Message-ID: <SJ0PR84MB2037002FA2B1C3C0C093E6959136A@SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2037:EE_|MW4PR84MB1370:EE_
x-ms-office365-filtering-correlation-id: 6cef5640-1825-46c3-3a18-08db830816b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /4MdUnMNmmCjpA+oFCbbVmyH66RtEKCzqnOj2j5EmXApv4XLcaF7oDIbCN00Yukb2ixDQGO7ePySDC2NWHM0Ta7tqdMfR9UDPF6na8FHXVxGir/GjjtmEs/4eysnmpXZ9nkPF6+Lhi7odAv9SWezPX58YWWXTC2y+oqXyvBypQZ4+Meh48mgcuth5yOCzvX09AOho6prA0slU+TMgcElI65xGew6M5k7893Lg0Mc6xIB/jHOCe6RYH67VBUq38+aNMxFsuEZSseOa4GJRguKARcXr8VEu8XpPK7+s+odru8yXpBJeVEIXz/JjwApsMia4FxtaUaZcrcfoQzVP+uthmYr6Rggc98d2nM5eMKh83BYuSVXB2gEPfnbOTOCr5HKYUjKk4yWvXnps6+y8Gc39ZrDOF475ZuRfxiiqTsUq3l6gGMxuHSkrvGgzCpoLbzgy3b9d5Bv1Ycgazbpdq14siiZXaC0DMsU0QofEt16CT65NgBziB7j6VjmB8Ks8+m9x+V4G/jeCxpJfIU5O+K+z5Z0g0Mh9WTjBsOOAxgw27XitErGunh1MG5mPXDx1BYpkhZDX3moH6+z3RAsFRW1QbWAfON7BAnxjVb9zgEiaRT3NDnl1XBY9DB4FKAzQ/dK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(26005)(7696005)(76116006)(71200400001)(478600001)(186003)(9686003)(6506007)(2906002)(55236004)(66946007)(41300700001)(66556008)(6916009)(316002)(5660300002)(64756008)(66476007)(8676002)(66446008)(122000001)(8936002)(52536014)(82960400001)(38070700005)(86362001)(33656002)(558084003)(55016003)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QeVSiDZIakC0Vy9f5FKGBJGCkBuxFezqQBHDbclouIQrOGSYfPR+v5sbLT4p?=
 =?us-ascii?Q?F6JE1h1a+unOOd8+5l2PLYRwlKz5sPKb7L4OhIbgE7u0vTDYh610aMyFGNPB?=
 =?us-ascii?Q?NJslJRYodQU6+vLaRnvz8oyQFc80tNkhmPjDwa0v1QU/VaWiir62EH+oXqVD?=
 =?us-ascii?Q?CNlsXQjuQED6mMDi02TfhuXSkI5llLH1zJro3GrF2xcVjUIQjp9rxEn4rGP+?=
 =?us-ascii?Q?xbYt9bZHGIxOWdxZ9r60kLwuxERmJL55yae7wTDWmNvCMVH+NFMbOiw5ggO3?=
 =?us-ascii?Q?51cRcSd6zWD/0oaUp1Rj913LOAval7XigL8CJcZMt8QyPhK13E+yJcinDICN?=
 =?us-ascii?Q?JPTXVJKeOVo/nLi1cWmEOna3SyPEcTQaaJecilwwZHpftckXW3qByFpxFYtR?=
 =?us-ascii?Q?LjkNM9kNoPmTrfaIGoy5+EajX6rvZ2H+cEjZ2ZwWTySsU63xvoiYdgKvr5PW?=
 =?us-ascii?Q?uYPA7O94zyr+WBOa5pbZZS9qQiFfiImUhftcCO4tw7jTS005KM7dO0/vDyS/?=
 =?us-ascii?Q?6mG9sw1B05BoKb8E7iW/X5u0D1tQG2lEFLO+NBH5t/29eNZ4d6+STTvPUFG6?=
 =?us-ascii?Q?48yWSXioXX1R9jN1esw8hICDt5iULq9T7MZOGKRwd0dxpEWgnkcfwPJ9IsCX?=
 =?us-ascii?Q?7uKFID3MrgPtSwgN3rEPflRJpfrVoOzGf1xiIHeRtuSr4PTaeyLyaaYInFCv?=
 =?us-ascii?Q?qxgdg/C8nsx4JVmxVYqrXG6yfztMI4mBOiDt/PlLp51aq3sMcfg0X5wvPutZ?=
 =?us-ascii?Q?B5Tvxz0AwFrm5gRwxtvuD9lr3tBHcVq88xD52pZPd7YLRs0oY9AufEWdjgKN?=
 =?us-ascii?Q?x1nSM7K6F4UM8+x6qD9sgaNb6QLHhNBrKzUrGMwsvTzulbYI+5n9tOON8hee?=
 =?us-ascii?Q?F0Z34d0Ox+coWE2vim+44wLq0gqj9cBsQ+SDhPBC8/S2W6aIGvcRQjca0PGo?=
 =?us-ascii?Q?x/MNW4ekY8gxNsl4RA5SZE5CJm587k1ZdkYj1S1swz1wFenGTO5S8tgAqzVP?=
 =?us-ascii?Q?TwjZuxwwxSrdD5GoXdI/MI8MfWUNwXHDxqk0+Z+bXs2yU/cpz8YCwHmDGzOo?=
 =?us-ascii?Q?gacL8bMVFK5DeEvwJpy/5ci61Me5yel6351uAEMhi0VaFs8WmvhVBTsyphWS?=
 =?us-ascii?Q?ciAqlovHzdAOokfHd92e5rvDMYegQsyTZKgKj/Al+/RPnu46vPAcq3gbdGTq?=
 =?us-ascii?Q?iV2im50GyXw+k9bFvsqqs6lsCkdcIJezuGRzSMNxCob6s/zvltYpF/J/VaZ1?=
 =?us-ascii?Q?M29jd6Vq5hxjQCgWJv13s51EiivxT9Xu8SRc7Vbz2aEWcFExgBeDG6sgCK1v?=
 =?us-ascii?Q?J3mdyGmQCOPn9LE3tcaTX29GVG+GX2uPc4hgRR09aLsE0HfxUZach/uaJ/XI?=
 =?us-ascii?Q?BlTd2SJIeTtIAp3Z/JZyEPWvS/0CHVSDp/X4opsiATzw/1GOk3QVtKCB0UjL?=
 =?us-ascii?Q?O6yMe6telIa2En6O43vUfFEL+6ZjfKYt/VaxDsahuFozsJzJfm/NHdW0IjUP?=
 =?us-ascii?Q?pyskO1FLtjMUBJuoc8fF1CiFWqrwxPD2lfaL8rI2tPCAfrWY3Fpl5ezznct1?=
 =?us-ascii?Q?r+gl59pvxa5aVit14Xp9oqrrvhHE2KNEKae5xyFd?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2037.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cef5640-1825-46c3-3a18-08db830816b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 18:44:56.7049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZbJ9pkk2GW8dggKao6cDi1Ww1Kvgt/B6/0q2dTfWRuAKiB8Efd/A2xyif7LiCCXDueC5CqWOkSnkDtBcC3bxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1370
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: TZN2zV2GexWH4upXN872HljF9864fUaK
X-Proofpoint-ORIG-GUID: TZN2zV2GexWH4upXN872HljF9864fUaK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_13,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 mlxlogscore=453 suspectscore=0 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120169
Subject: [lttng-dev] Status of the RCU Red Black Tree
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
From: "Uttormark, Mike via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Uttormark, Mike" <mike.uttormark@hpe.com>
Content-Type: multipart/mixed; boundary="===============5962175762722536888=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5962175762722536888==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR84MB2037002FA2B1C3C0C093E6959136ASJ0PR84MB2037NAMP_"

--_000_SJ0PR84MB2037002FA2B1C3C0C093E6959136ASJ0PR84MB2037NAMP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

What became of the red-black tree effort?  I see it in the git repo, 10 yea=
rs old.  It never made it onto master.

What would it take to get it onto master and into a release branch?

--_000_SJ0PR84MB2037002FA2B1C3C0C093E6959136ASJ0PR84MB2037NAMP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">What became of the red-black tree effort?&nbsp; I se=
e it in the git repo, 10 years old.&nbsp; It never made it onto master.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What would it take to get it onto master and into a =
release branch?<o:p></o:p></p>
</div>
</body>
</html>

--_000_SJ0PR84MB2037002FA2B1C3C0C093E6959136ASJ0PR84MB2037NAMP_--

--===============5962175762722536888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5962175762722536888==--
