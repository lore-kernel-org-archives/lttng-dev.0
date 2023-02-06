Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CE3C636D3
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Feb 2023 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675700803;
	bh=TimRAAeOOj1Yz3rBvcQGJYLQbEG3mwhRgsBHamiYMFc=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=p5tgcWcxf+qNI1/eNwXfReijQ+yKqftGz/Y7oEb3MtKcdlPJO4kyWxN7YmxPpihei
	 vOxPpotkwadKCP7BCdAdCtr0pdCMM+tlKuagGSbd3pAixlOPu3C9FLQQYcefsL3v8t
	 xIuLobjyXvLk8WRcrvstJQ8LZK6/MH2g2uFSHxNuWR6rXu5wiSkXGpBk6d7e9lsfP3
	 Ou0lsNDXBL7hcM4b0DR4RwIgzL9Efp7gvzdtMzXwRWdj79ys22pdMnc2qIQGniBp8k
	 ObjIrhTu3yC0B3f+hxwpc9tKoFwWOT4N6CSO9oAmTMBkf7CAh4rS6O2L8aQKDyGp67
	 plHI++pDoOu5g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P9WqR03j9z1Z3j;
	Mon,  6 Feb 2023 11:26:42 -0500 (EST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTP id 4P9VNq38wyz1ZTL
 for <lttng-dev@lists.lttng.org>; Mon,  6 Feb 2023 10:22:02 -0500 (EST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 316BuqmY013560; Mon, 6 Feb 2023 15:21:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3nhck31wp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Feb 2023 15:21:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URiK1wDyAgBKf+F2/ZnrFLznFaW6VxpbkOdnHeMDrm9YoqQtdf4fkwZmCmzdU62JDUqQmoNN9URYgVnQ/FDwGHXl1uM1dgDSPBSiXP305XVhz39p1sxnliUQ6CM6M4sUnliSRbfaqVMc8FEgy2/6vBAADjyUzkmrgA9gtrotJoSLupogjXeEHpWz6dFZ004rLa8JYXgbhK0XSZ1S04fWN3MTY/mYIfuLIOZTNehgK/hav6e3MQg+aNhNcjoJPAEC1o+uW6e41h+ES8U9WijQfevvR3w39+MKWtjAHYt3MAyvVLhk2DUpCZDmNuxoguphlzFRPxdhY5O+uta2kr0u+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj8LDzXHqkcmr3PlZLS9ZSTCM5lK4dXTKSMMo5Br2Wk=;
 b=N4aNya0RbI0wMkSkF/XPTYEOhIwSM9Qoaa2YYPmj5HNNQA58GIzPZxzxAgpjCUsfgrrtDaTbMe2PX73Zs25qWFu5LV52QOt5K4koPK3ZnaOXE4l4xw1MLB4FPeEt6mF4HBEEeavm4xaZt5aNGItxZ+Uuc1ql1s6aZUaLK+YrteSmetVaFRJOTLkgx7MTm3Pqz+lC5krVSaNyjI/s5Z+LRWwGOrPjYfYCfVIHT5BURiDShFALGiaFulWNWwiW/9cOvvGzzOVhuHg3Rcs77ZK3CwAlC3671J8BbuLFryO7DBmxtu3TnUvTvaLZvRrH/ODc6xBWHDbt15TTQ+4pfQm13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:443::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 15:21:50 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::f00d:1df7:18cd:2194]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::f00d:1df7:18cd:2194%2]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 15:21:49 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
Thread-Index: AQHZNY5Xd7zW3o4uskqmkE3H94l/2664tByAgAAD3ACAAyMcAIAF0MGQ
Date: Mon, 6 Feb 2023 15:21:49 +0000
Message-ID: <PH0PR11MB4904BF8DDA04502FFB89E35892DA9@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
 <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
 <e525c864-a2ee-ef34-b7fd-1c114e70b081@efficios.com>
 <d1eb23d9-269f-85ea-0b7a-a3b779ffa843@efficios.com>
 <ea3518a5-e539-1616-432c-b7fe7fcada2f@efficios.com>
In-Reply-To: <ea3518a5-e539-1616-432c-b7fe7fcada2f@efficios.com>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|IA0PR11MB7185:EE_
x-ms-office365-filtering-correlation-id: 09afeb0f-3fc0-4272-25fc-08db0855de26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQsSId2fPE6nIV9hPE7+FC+jKYYKicG1rcgdU8LD7og0C2UnetSpy0ONWVF5s+DCJo2uq+MrTWBwsDyjOvUgvTJ973nHU+iAzrN4PMPcsgnyrZj98fw+ALWsoIK7mfbCiw99HuSMc/AjUZcVbYtXJTBG8i8EYQy9wbc1KuUpGfZAMMVBKfk40DGC0kcrGo9G/P5jgNGmE9MxHx6+vQmOCQV7UfQzbaXgSHxHXRpBhclLnhalhM4iXZftID3kWSJXNuUiAKCQ+7iWaBN+h507gF5GYyQESevc9Lq+CMdEGGS2usU72fJeCZ8qy7o8gkPvhxE3cBOE8Z8hMhExm4gA+AD119IvYMPq3tr5VL0PRZFSxB82nq7ny8kY/6+1S7RKTA/TUQ6FUHeiUuvFU5a6TPP+BpaJohYRcd9KswXyx4Gn/Av/wJ/fIR+WE3aoukXeh2zxzXVcggk7T3jFJzpgCrvDxSZGpaTMNyrlcgW2mvmfsiyFRDvjxuezxBmO83CE97T3D7jIqkKqdztxXEapBtWvZ5Qph4Wq15pvc7NNcPGjH8oJ0YWl2aSVWs0zszs0TiAAxLzpX4SpB7lBQa5v3fGZGd9DGXyeoXBpq24yuw5zDQaKuHp4dolpHKPtD78npjvVB9+XQgVJ7lMFApsJaDy93r8x9sHyIgaiDys8FeyHdqxqZfLNMMS5/UQv3Gm+C+W1+lYOk2wzsALLqxRHk+cukDlAgl12KYvz+7V+iwI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(39850400004)(396003)(136003)(346002)(451199018)(66476007)(76116006)(83380400001)(122000001)(38070700005)(66946007)(38100700002)(5660300002)(8936002)(41300700001)(8676002)(64756008)(66446008)(2906002)(4744005)(9686003)(66556008)(6506007)(966005)(52536014)(478600001)(186003)(26005)(316002)(33656002)(110136005)(71200400001)(7696005)(55016003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0N6wtGG3zy+KDsy4By/fl7hGk+JeD8Ukl+5mhE40Hag6vLXrwmbH+8s3Hs6F?=
 =?us-ascii?Q?pdKUCz4cA0He8zKEJbf8oW/+ySjfMVAAlHCSNfAJVoaLwRhETITgjhmU1uXp?=
 =?us-ascii?Q?cI/ewzsMmJOnM840wJ8W/lTQMJV13OWaykxgvenpkGq3qx/n2UYUdRfuJaH1?=
 =?us-ascii?Q?ytKkSdv6yCpQOhFB0aqURc3aLAWSIKcBMiupvDmlim5CtGWxafz+6d4Fim59?=
 =?us-ascii?Q?Qm4X0+/hNVBcnyuam55nBwgNEqBzibAnZYD00pup8MceXPNuuAODwMEQt057?=
 =?us-ascii?Q?iF6SQOlRS2SshrId5WjUrwQGrmrkjhpmVoKL5/x3ozkIP6z1KsKuCcVciUw8?=
 =?us-ascii?Q?NZcTs9EGMchqNXMURb+UFQLsd/R/r0d7ZAzL+N0fO4tfS0Brd/lfy/zOhQOw?=
 =?us-ascii?Q?bkjIKgEhLfGJD+iMsADz/6XYiMLHZ3n5O+9uRgkB6D9c9ND0gYVeo9Hwpfkt?=
 =?us-ascii?Q?rWaQoPAjEt7ekatqG0RES5oPnheCi3u1axRAI3HrgfnOwwldZG+ppWcMcmpS?=
 =?us-ascii?Q?gysHIayHb1mtRzvKVZU++Z69m/J1cb6Y2mfZd5n4NtlRwy/8LhNYXVPKsQkl?=
 =?us-ascii?Q?826IQbH+BJ3Y6xA6m13hJhj4iw+0f+Fu1soS3jCnk6hg1iSyZkReYE2NbGDr?=
 =?us-ascii?Q?QqaBwVinF0+twCmTcKgt12PgeNh4Z6aCtMlvrRhCuD0vua/1eXLOVDgNNlWy?=
 =?us-ascii?Q?UJGPTlWBCaZ4zs1bGWIELbT3fpN/P4/4mX+cQLebonQUHQv8f4L1ZHwU/aQw?=
 =?us-ascii?Q?tHX7MbHbwtwZrH7dlbjdPYUPjY/FpUTPg4xK1kRb/ylCZI0wBrPi2251t2Qu?=
 =?us-ascii?Q?mVT2zEJU0akfPJxvfWP0KN6eqHflwKKpyUfTO2s9QZQlDMnB57MiETdIViaI?=
 =?us-ascii?Q?I+kL7IH32e0AkvMp5DJxXnfJg2tv52zEzvPZzGaPMMygORgQdXmW8dbR1dF2?=
 =?us-ascii?Q?YXZrnPLj4sRQYQXpBHTgeBCi7DENUPiiAY3SZPGFZtTILWPj4nVZX/SjrfKp?=
 =?us-ascii?Q?N3jzzcaT6Q/v0Mi4fhCKgkxK7ZGjwSW/ZpDfxtOXo+qWLwvxv6obcOx7dX/l?=
 =?us-ascii?Q?jVD6yXXToJpArTu0l5oh55SZiS5uTBIcIuvtOqFmRRdD3tjJh2qHuwDAQMvr?=
 =?us-ascii?Q?sxRNZpdycmQvlY74t/PO4IdOUeAZfHNCnY7fjFbcpxwttNGZCn2AJFgk0e8C?=
 =?us-ascii?Q?jwNyHCZxSWDGr5LpIZKIyL14r2BLBxiOsVq9F73JdGkgOouyN+LLWx3Sq2qI?=
 =?us-ascii?Q?RGis7uKmpadluvZolTd6qXndLJ/NnOWu1s/a3cwWUypYki/8aPZ68HxyZZfl?=
 =?us-ascii?Q?0OA+nK0Jk19+O2Q19Hi0hzt4NNONelMvizbMlfP8QEJWN088vx1dhsopyfaN?=
 =?us-ascii?Q?/OKGypi+EI9/TBFisOy58jcZLfwQDIuiIuByPv41USnput2ll04lTBNz0lLH?=
 =?us-ascii?Q?EnZAOdI+WsFBL+rIg9WFKJ/3fBNEWvyCX3pC1HG612rRK/bp0bh7aaTytNwN?=
 =?us-ascii?Q?ToQXE0Z/4DND3XgYOYVFtR/vdOulVmxvuDEm/BtcLNeJ1LeclQWAIEvkH2AM?=
 =?us-ascii?Q?BpJcvZH1Lx6PwABbu8Q9zIAOCFn9O4XBZuB+RXRK69R1d43i1kOCnA2SGfCe?=
 =?us-ascii?Q?Zg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09afeb0f-3fc0-4272-25fc-08db0855de26
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 15:21:49.5029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBddm5qKRsMLWO0UJm6QrSiMn4QN3oYquBsEvZVTdNGayvUX3Bt/9XMgaE3oEBGbCIZ2LrphgyXyFludZgoEeXn/QJIKLDl0x9S2Phb4NEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-Proofpoint-ORIG-GUID: ASxfI7ooBIn0K_9HIJwl3sDrM0gefOD7
X-Proofpoint-GUID: ASxfI7ooBIn0K_9HIJwl3sDrM0gefOD7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 adultscore=0 mlxlogscore=563 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060133
X-Mailman-Approved-At: Mon, 06 Feb 2023 11:26:41 -0500
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
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
From: "Beckius, Mikael via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Beckius, Mikael" <mikael.beckius@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello Mathieu!

Sorry for the late reply. I was away for a few days.

I will have a look at your updated approach and get back to you on your other replies if still relevant, but in short:
- With __ARM_FEATURE_UNALIGNED defined 32-bit arm appears to support 2 and 4 bytes unaligned access
- Regarding 8 bytes I found this wording:
   "__ARM_FEATURE_UNALIGNED is defined if the target supports unaligned access in hardware, at least to the extent of being able
   to load or store an integer word at any alignment with a single instruction. (There may be restrictions on load-multiple and
   floating-point accesses.)" on https://developer.arm.com/documentation/101028/0012/5--Feature-test-macros
   and I think all the crash reports were about 8 bytes unaligned access on arm 32-bit
- Performance seems to improve for both aligned and unaligned access compared to using memcpy but your are right that a test needs to be carefully constructed
- 64-bit arm appears to support 2, 4 and 8 bytes unaligned access

Micke
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
