Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84BCC54EED
	for <lttng-dev@archiver.kernel.org>; Mon, 30 Jan 2023 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675094484;
	bh=fd2DoP8n5FyQHst8CrTsmRZAsa1LleLKTIkkzIMNteU=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Ml67M6wDrmjtQ3H63b1mLBvVSef1oYnTSLbLcrXcYR9zM4oB7HPduGi3e+MN8BcUY
	 iJYTO2eXR6VU4R9sLsa6fs3p3faLbyKhOSrP+btJ5fUFmcFkQeV5qFP72WWRUBT4S1
	 vYv0K1koajKS5Q3VJ8eq1YjW9YDEQI5PLkkVud+RpU7i0+VeRlTSZEQFYzYildcxQZ
	 R+d6oTvB4Ga+1+NHWAbbpp02OzSwvxA3QxlTG5bcvGmEuuVyaWX8qUFcrK2zFfVAIA
	 1gqPi/ifKE6B8xLwjwgbmr2f1V0NjBMnhtHLcUbd8KcE8M2hzGWITb4dbTLPUfk1ei
	 Lne22ad8E6s7w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P5CbS0mGbz1Wc9;
	Mon, 30 Jan 2023 11:01:24 -0500 (EST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTP id 4P4zYJ2lxcz1Wbf
 for <lttng-dev@lists.lttng.org>; Mon, 30 Jan 2023 01:58:44 -0500 (EST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30U6KAUg005905
 for <lttng-dev@lists.lttng.org>; Mon, 30 Jan 2023 06:50:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ncrx39yu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 30 Jan 2023 06:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh+r3GK8PyYpHO/jIWSvmRKdhpVWHdUqqu584k3YWmmZX7hiBSHxq3bhqSeeJk8ZTqIE61n43+aO7r+5msmvxg2oZhPATQmwO/9266RBrV0rTe/YTI1x44FlAnAcJ2NbNXaovCfQ7n4ZTC0xEJ9+xE3LxVCNkh4+bqGHriYP7C3EcHuVdR6P/qz6bs7jlZ6TojQNK3zv3tStUS0z9SjlwFLsO1IjMo7UAncHt8EdiKInPKptU1Fw5lHKX462uwRTa66SN2d80YxRGyC1UWFm/9wPW0NnACpHHosi5SjfCPKVOCdg7MRGqNcmCyz64jH5M9XnRREkXz2IM5rS17ryxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DQjs+xcMKXdH+aqjZGeq+mWXR7jLoU0G5+V6zBIVkU=;
 b=C/COCkJM1YNuW1bWCRw7FGV70WJNhbKghL787ovlHtHfsBRZrs0n695Kl0+Cm/yxhEETswL06PxG31h0GqwmixeZgNU/e9QQk1/n3zjfICHAXw+IMvkozfJqnIA/lJ5ZbVHG1Y71jq9vK1+rI853lMvSgwdNH38ZHA6uljc8tytzYA8wANMhqGSD3r/7w75lwDY1PJBZ8BKxGwhxSc/7lzEWkiszYkA44HLBLdz9oPaZsmP8s45p98h7MwEA1F7qCDsmBgrxgclr+hvD5ob+/nx1/Lu1SeIOqCI2iwVQtsTYDHuAxYoTfpvudzMerjKaYy6Qhux3sTQeY1320ASbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by CH0PR11MB5561.namprd11.prod.outlook.com (2603:10b6:610:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Mon, 30 Jan
 2023 06:50:06 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::f00d:1df7:18cd:2194]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::f00d:1df7:18cd:2194%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:50:05 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
Thread-Index: Adk0amQiA2+1QqC4T4iIW924Yg0huw==
Date: Mon, 30 Jan 2023 06:50:05 +0000
Message-ID: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|CH0PR11MB5561:EE_
x-ms-office365-filtering-correlation-id: 09a5b5c5-6bb7-477b-2fb9-08db028e382f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBqIKgPY4JRFqEMtQUaZYhEh+nLjsSV+I/ENH+ZQCAGq6VmI76voDHvdpW8WJHap5wUX/3/Z+uO8Lv94iRIhpORlnBl+2HgLcP4E0Bn32peuVWxXvfB3HB+3RAQK3j+P8za9Aus/1B+CZMZyfI7J4x9U1KskSnolyrH/v0PJlPceULg4xhgmeN2m6A+kL/sC6wIMvFz8VBk1aF7VSQziL28M94huROKuRrbz5eSpemgMsB21onuPK/tzjIBKIhTeUHQkmpqj+po1RSDsPry3PAJ+LWfH0AyCjaoEnt9qAHFBt2Qm9wYismJLDihho3b+n/0PV3yThJl/fF5QaWgnQb2GIRjDWqNp8RbKQoC2D3ZZXe7KMyK/M6RiOMm0EWgy60fnP4ITX1zz42f/U5WLpSbEu8L0YpcKnfPomre9Rh7Mv8c2CBvXq8Ak65N+KZMBTi0kwTwLEjj9O7KkD7vIP2DGLrzClUXMOCn2ACJ9ClH2B+vEah+sHuEbN6M9L5/YCgoiRm72HUR4f6SsV1a/7hM1cJqLuLMyYUsF0mrJv78wDpbCSHKvJRSfiQTqPw+dHJXctaDDbo8CQyFBxRTX06vFp7yiSGLefupVCyFEGK9druYMSkXy7Ib64/lyaaxC3G56gIhiOhYOZ5yJhmbqMDT5r2s1yECJH7NZP02j9dQ+aq1RHL1UKXnXW43MDYp9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(451199018)(316002)(8936002)(52536014)(6506007)(7696005)(86362001)(71200400001)(478600001)(38070700005)(38100700002)(26005)(122000001)(9686003)(186003)(4744005)(5660300002)(55016003)(33656002)(2906002)(83380400001)(66556008)(66446008)(66476007)(76116006)(66946007)(64756008)(6916009)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jOrSR3cUttt2wA26XJvbRWIGcp8zOhTq5BGeHJyE+kL3NOj3cN3NJTk7fCGf?=
 =?us-ascii?Q?GlwXNAdpZJQdMPEXQ3oqfp85DaCVtfwOcevU3Ml6Bg6Vmyg1RK5OyT4G/N30?=
 =?us-ascii?Q?YN5ILkkvgReZZzLIeGsmIEhiupJgDvDhKS8C9hmYqlrIFA3B87QL75mbiB7l?=
 =?us-ascii?Q?MvDnmfKB0JKTqmk3KHloylQTySgB+0XRNx8x7bHsweYJ3SfZaMaX+y0z6rlg?=
 =?us-ascii?Q?Qa2qkjV7D4w3Oj7F3Y+ja+thqnyLPVVy0Ll4jmBCwPAs/wo4aUgpUaHzlf2S?=
 =?us-ascii?Q?Z6uMM2cpxRED2VmJK9WDhHtdcR76h5dFVAfqMh4mlt/ZTGg2r8MdNvjR9S+6?=
 =?us-ascii?Q?iHW35EVlFMA0kEyhttU6D+0OliPnIiZzbW20sGWLcCv9nhl+xS5bZpbC5XNd?=
 =?us-ascii?Q?+uXFpnvSG+c/BONs2ca6Qqrrkjm75LNph9Ut/Y5em+Gq1qcBK1iQ03Z80VgA?=
 =?us-ascii?Q?gaGpzsqFy+/A9yy7ahZ7BvouPPy0VCLEaF+iC8CqXl4NeEapsUc7PqzmcKSO?=
 =?us-ascii?Q?WCicKuan2nTMcLRkYDyqLWhVmvngIHW7qekaD5XxxKUHnqLHejqmlsd73WrY?=
 =?us-ascii?Q?WM/sUIcbva6SzHksIDCQY/syTAjZYN9EOLswnz1CC3nboHAqXBmcDyzB2cOt?=
 =?us-ascii?Q?2IFZUmU0O6rKSy5iHLKNJVSHPLt0O0qryI/FoHCLNHVhT0mYc4Hw9zfuc7Mr?=
 =?us-ascii?Q?69FtpFWTjpaEsNd04NbCy1qDg+UPGBAHdZth0K0B1I9Sr/T7vqyZlfADRcKH?=
 =?us-ascii?Q?xPHkNi5vU50m89DHm+HPXZegUEANKUbeIZECmE7arzJsC9hGF4HENeUs9uUU?=
 =?us-ascii?Q?4R3nCVuf1kM6ILuBpQ/gziQgRqV+UyPbXwRMj2tDAdecb+NcXp1QoSyKEuSf?=
 =?us-ascii?Q?7Gl3z091NjPKTWX1ttDefkFDADualGSXE7QnQhFxCMJliNmqFlxXiam3CjHK?=
 =?us-ascii?Q?bUXlbz0TWHorSP0U8ezur8T6JMEtHyl950vPIIUkm6gfjN5s1UEH0565c4uQ?=
 =?us-ascii?Q?ilpXWROIktfkmfbdSPqu+XE4gwlflzXtOYrqCH+wfNDuArQ1wfQ7pflAWU28?=
 =?us-ascii?Q?+bkDCeXeL51H7ERWMANkxD4O9EHdpY5eIqNEJQR2mul0hnji3l66vS0tcV+b?=
 =?us-ascii?Q?nFCJGpv/Ug+4FetYs0Pzc4tE5migivtAhNjDI6f6oUoss3QoDDwEePuD6S3F?=
 =?us-ascii?Q?szoQ6Z6Plw+1Bwj0NPrEkfynJhJ9vvDyfR62ezQ0+KIHwXhTWQKZZqwNqB+n?=
 =?us-ascii?Q?ztomQIRY7tYj542IJFaSEy/khujM9E/YAXB3+aiuJogs8BezWJZgWBDhGfGv?=
 =?us-ascii?Q?P3hbW7nww7wB1tEGyDYENk9gshgOC4PgDNySO66tnTAOAYdgo757BYiX66nj?=
 =?us-ascii?Q?LcQ3LBVmBzHBt/e7iy6an551RcB97uKVKIcqxc2SOPoMZDzR+sNcPZPjOt9I?=
 =?us-ascii?Q?z0aFJwK2FXkUSHeL7RXUYsfP/qai/Mux5mVlqM7IroydeduopWpt25/KT2k2?=
 =?us-ascii?Q?DVnXQNidT54rYOEv8MSzYlSrkUPCJqqitvCV+q3GkWijeTUysVhq4c2feO2Z?=
 =?us-ascii?Q?x0PtnD4pMm8D0ME9pBGFKPeMsAFXYXSIR47Y4WFz?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a5b5c5-6bb7-477b-2fb9-08db028e382f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 06:50:05.3816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zq2JBp/l54RxX7Fde0s2UD0l1rDGoeVtL1Je0SBlagAZz5KcalL4ZK8ZoMEf2Vd5xToAVdNqc2NI7ZXiO50SO8yEuNcvWahFmsTvPmMFEwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5561
X-Proofpoint-GUID: UPdKpI9_NeHrcbOkOYQ5zroiag4Hf5uH
X-Proofpoint-ORIG-GUID: UPdKpI9_NeHrcbOkOYQ5zroiag4Hf5uH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 clxscore=1011 mlxlogscore=452 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300065
X-Mailman-Approved-At: Mon, 30 Jan 2023 11:01:23 -0500
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

Hello Matthieu!

I have looked at this in place of Anders and as far as I can tell this is not an arm64 issue but an arm issue. And even on arm __ARM_FEATURE_UNALIGNED is 1 so it seems the problem only occurs if size equals 8.

In addition I did some performance testing of lttng_inline_memcpy by extracting it and adding it to a simple test program. It appears that the general performance increases on arm, arm64, arm on arm64 hardware and x86-64. But it also appears that on arm if you end up in memcpy the old code where you call memcpy directly is actually slightly faster.

Skipping the memcpy fallback on arm for unaligned copies of sizes 2 and 4 further improves the performance and setting LTTNG_UST_ARCH_HAS_EFFICIENT_UNALIGNED_ACCESS 1 yields the best performance on arm64.

Micke
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
