Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7328AC54EBD
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Jan 2023 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673032333;
	bh=bojlbTqHjrtdciUpw63rnORIV9XJwTWoUJv2C4JXp8Q=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=W2R3v0Z6M7h1ueDevTat8/+zDIjRmYmVawOmRrxfHMSvGSnArtM5XH5DIrvMi8Etz
	 AY5mh4eO1I73R18MxdgdUdxMBwbffyzGSUGwi32Q66MGPlfjytxyD5LupGp6JzLr6V
	 WHI2d+Tm/oBeDzd97OCBN2iShNEKJ82G+Z51y1x+7zngEGde76hddfqiwR4H8rnK2h
	 y7KTApFXD5Ka6D4hZmc6x3zo/13kkM46z7xiKggJtsYMW8SnNS4qQyvFidvxTwEip8
	 AyV3twywn9ps5gDjYxRzMiluwvMmtbP3nyD/KQ4AS1+sVqPSrZR4rgepbeTdk8ny8F
	 II/ICdTNhoZpw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NpXyh6krmz1NLS;
	Fri,  6 Jan 2023 14:12:12 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2077.outbound.protection.outlook.com [40.107.116.77])
 by lists.lttng.org (Postfix) with ESMTPS id 4NpXyd4ZP0z1Mw4
 for <lttng-dev@lists.lttng.org>; Fri,  6 Jan 2023 14:12:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieRr6lgdA7WWGo1iNbmMi14aM2ByMH59DMuXeIK7gfHfPiG6tutWhGNm5gtQB3eQLXokLa4vWZg/K8EdgyqvRFe1rqz2if5b4pjEyrxY2FnWOloORSqyTZUmXjtEh6/5nTOSSLhQPvI5rSh1fu6Y5YOV/qXnQo8fu/saeZ1+CoQgf7mXnDqBdyQRInEfaitFlW+s+bUnRezUEywQq45S8qh85gyLUFkrx0R2AeVWIE9JGeijp2MMlWCxSleO6P4dqgM7y/aFkm8iDuCWp8r/KHTVAwmU1qzlQCv9Rt1xCrSzh9Sii8eoLQ45+4l6wFIxd+Rq6mtrmwaFrhC+BTI5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPCY83rYE0NC7Bn8skpxNxm2GC01UvkC/YnRz/EormQ=;
 b=Vsu1LTBTE1qnaExzoo0uw+Mj7JVfEjRjGn473nripe06PZ3R3pw7mMzhwx463C1i4z0eM3Kc8zFKeUn2ECtJETVe67fR4mWxDTKcCsfBHN98UafSIwXOGIdabsZo58DbkG6zqPMv5YzU6KMKmn4AOLFRQ43TruLtXd8gQM03uH96lQLjx+KK3Vd4zEkbkjOE1PoDT2oAIM7IHq5ADtmCQC3C1lxsub3bhagD6G8ix0LtTJQC5Goga4h6FKZJSodTOMzag4daiQxvqCmoV5hOFWH1mHgLJJXQ0CcBM5MGzQHC8NoeFWHIiIhFBNihquS8bGCEZPybQbgf1Gp3iia4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB8195.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 19:12:08 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eed5:b4fc:c863:b2a]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eed5:b4fc:c863:b2a%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 19:12:08 +0000
Date: Fri, 6 Jan 2023 14:12:07 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <Y7hyhz9SsRZidNbg@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT3PR01MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: aa839cfe-bae2-4afd-adab-08daf019e819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AzOY3qX5/LrQHl4yxtDA5X2U79yXpzqMgGFvzjK+PtimsJgqGPwWnSNAotYROHnrbfUc+xn/4f/AFrJkYTiwd0mxgcPX43WuW1t0QR1raHNX5Xhehg0eqIJhFHs6B9E+09gvx0jMocxNxUnUfeHLPS8ZkrW2L26n/hCfeQDfPjOqUGMOnyznFS4yIb1UUww0IqVWD9FFNcqM54VCj5DVLEXBqAxfJBDRcgnqoFlQjr48X/jYxH6z/DMsEbnuyMwj0jM4Q5O6hoKqd46/ixUa3Dr2XAH7nAOSWIW0xrOfUzaCwWVNzSCYYi08XTXLyLaUHF1/OvYVM7o9j+sfYs4SIa4IVoHMq9aypxTzDcVFRTpmF+bx53kv33/H/T9SV+uVVmaMIJx/ySvTyzhDQDb44jzt5Owxa75Yt6vxTcWaJDfpwq83dLsTiVC3Mihryz4SNMmWqkkrsbSF+YxxxBJSohJwVpS7AzLtuDwV4C25espSfqVCDhoIyKSshDwpgh0QG66hyVS+WxHPFzv68f35Hd0xrRY2IltXE2tdNjqRq/fq7WhT47e3jx6KzqoIItEjgUthOM58wJJ/NicFJ/L6FziTLoqhu0Pz9qZH5wcdRHfxvsgXdKrWHZtcroUCHugwriQLFCBn6xwo0uYLLsHqU8PUy+DlCeRNMA5YofKaK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(376002)(136003)(39830400003)(396003)(366004)(451199015)(316002)(4744005)(5660300002)(2906002)(41300700001)(54906003)(66556008)(6916009)(8676002)(66476007)(4326008)(8936002)(66946007)(83380400001)(478600001)(6506007)(36756003)(966005)(186003)(2616005)(6512007)(6486002)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfWBI1OXGnrMxId40nEho6gw9fK2rQAuMoh9T4YV40YyfSwa8S5yhx2N9g1K?=
 =?us-ascii?Q?KNU87nSnoV25S3X//49xSRxy2Z7fJkVBrbInWn9sheeDe4QG6wKJGIBqgJkX?=
 =?us-ascii?Q?Us0TRHMGbY5AqxQGPBocHFBHbdnR5sMZ50FZn0wTdslj4y0TpVw+SwWOReLL?=
 =?us-ascii?Q?8p4HaEDOJcKt8xcCAUKNXGuX0yvNLgMkBmow1xYIWaucyf5kmr8fhXppqKS/?=
 =?us-ascii?Q?pNKuSaH1uaFA/UnjoD0xXuZX1wAF4Vhi6XSE0nG6uTx27pJ1hoo25vun/ND+?=
 =?us-ascii?Q?LskK9ZsToAiQUDUelG4UdoXGU/SHzMQU/cVEjD7zvjiqVmRrjUa8lchP4Wqb?=
 =?us-ascii?Q?r/bLuRW4jcxO+8Z4xtMLuZl7eEP1Zbc6a6fwkxAlVsAEJ7U2wB0lOTWqj8xW?=
 =?us-ascii?Q?E/gtAlGEywu13QOsb0X3iXOVJX58RM7PmZnX3/raL/H4W9zYGh2T5DExzX4s?=
 =?us-ascii?Q?ZzRrHltlRsGlMRkg/k95P8eCg/rN5SMy916JIg/dfv0RR6Iz0fP9Pd8S/etB?=
 =?us-ascii?Q?1sU0aZ2lkys0rFxsH2s3soySdGsIhMLY8Jn9Ck5wGh3wK7yuTSWLH+ls3il1?=
 =?us-ascii?Q?KY/YWuoNHDlop4f4LbiY1Adgwu+0UBc7WQ3DBXeZnigkUTqR/L0QeDaA2xPl?=
 =?us-ascii?Q?AvdP7qsxJ8BCzozsLnLmOZdPQQPD30t9lkp681ZcZ9cIozjyYqZ6bbB3ncbi?=
 =?us-ascii?Q?D0bQ+iNr8z0K9dMvNseOQUul7elwPVoyq0SzLadRY6Cub4h4MIDr1JkLY1Hg?=
 =?us-ascii?Q?y4qAJ8wBhrTcPeAeLA/x/0Dy8GJz5IgrlydTF8xSN17/nIRLjUlaPStSVNKG?=
 =?us-ascii?Q?RQwlLWAuJlnSQqmGTLkfxRd5XVN2g6faY4G1gfIgdLpFEOvIlX5lFTIhgwUK?=
 =?us-ascii?Q?EPM4m8h7/e5/7UthYOcs2/+xJJV4B3O2BVY6/S9eNOkOFIDGFo1Bk7Ru/lm/?=
 =?us-ascii?Q?x0HfnVbCih5srbXxZdZ4rgRveaHtF1iBjZD4BwgPh/f61/mfcyHaYZqz3LO6?=
 =?us-ascii?Q?jUusez1qPA3MyBAqCMLTr1I1Ly6jHdTApE0A+wlkasLzhpJ/awkf/C0IKk54?=
 =?us-ascii?Q?S9TrovS4UMCRGEd5YanDqzGzFfMbkaOXT1GwhQXizaJN8DF/5LUt4gcs8zlT?=
 =?us-ascii?Q?1QSlILE1W+uMBMmTdDROQvIBu5FIA2/AmKkGeVg3DuSKdzPCmSSUQ5cA2Uhb?=
 =?us-ascii?Q?WBHIQR/zazKInqi+yLVJlkJh16iiTzKIxOVDUz8SHfdodBTq+u2tb79oYIlK?=
 =?us-ascii?Q?rkjdaNPOaEUmyz/2mBCOMKDmBhSur9ZbAEUt+0IAOX2w0U7AfZ0rTzjJVIn7?=
 =?us-ascii?Q?o4v6pAgEjXzduSOTV3T/eQTEjU1ma5Q0HhhNFunsK+9LsSm7GsxE7W4gzITZ?=
 =?us-ascii?Q?YFyjV0xAaPhsF9E9uxdpvm6Rb82kDL4ZhA4DazOcj16TGoS5+H7zpPwJBrAI?=
 =?us-ascii?Q?X5c/KlSYtHPMtDN52jm8J2zL30Uwbz74DpWmA5v9UXfi52ZybCsTDEKx6e4d?=
 =?us-ascii?Q?iwPw7OnHtNIHGD3gdvdqy8iU2AlKLGH14iFUlUcqwudUpXWxjOaylt82u3tK?=
 =?us-ascii?Q?qFMkkUILAF7fpsPe2XZtwpha66b4KUhTxBZyoX4I?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa839cfe-bae2-4afd-adab-08daf019e819
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 19:12:08.5973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUbdfx6v3zDjV8/JWlZqJEPbw9x2T7JNpduDDtIb+6ImgGk3cTdjUvugxdQL6Hm3sVPoHKYuZmLKYfaRCJcKVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8195
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.13 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the thirteenth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2023-01-05 lttng-tools 2.12.13 (National Whipped Cream Day)
	* Fix: lttng: poptGetArg doesn't provide string ownership
	* Fix: relayd: missing space in trace creation logging statement
	* Fix: never use 'no' in a command variable
	* Fix: consumer: snapshot: assertion on subsequent snapshot
	* Fix: sessiond: instance uuid is not sufficiently unique

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.13.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.13.tar.bz2.asc
o
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
