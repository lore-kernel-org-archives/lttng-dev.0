Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EEEEE49A5
	for <lttng-dev@archiver.kernel.org>; Mon, 21 Aug 2023 20:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692649435;
	bh=SycEWd9OxC8vHGuk254fN9FeI3G1GGUDa+zxEuFIg7k=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=hROVo7EP+Q6+XsB5lB2eDKGQ/U7oDO7M0ZqorAbgiM17njgOgWSUHYpUvXjhW6jdq
	 FtTP8hqZ+HQEiqtIB3Skt847rcSlpBXMUzGPOtPw7yoLOGbtZ1GoZRRJvLfuH202Xe
	 k5zAx0s+4attket1AZnzG/ODupW69kzH6FxgzoT3NUXJxsXmGfdH7cWHESHVcckFba
	 +280zlE7XpWX7z1YPnEsVXoM7mhWlV3H4oF46k3r0tNTox6uL4s8kAwmNERv+VYaby
	 67Axh5do2gGtIOjsVkKrJ0aS3kgm8sIj1LNpXSJRUEh4YBwotPhz8T/xyyhfZhksnL
	 yQMC5wh5z4pXw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RV3pf5mQCz2PRj;
	Mon, 21 Aug 2023 16:23:54 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7053::618])
 by lists.lttng.org (Postfix) with ESMTPS id 4RV3pd2Dk7z2PqR
 for <lttng-dev@lists.lttng.org>; Mon, 21 Aug 2023 16:23:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOPzR4cebgZ8cDyYiob3uhYvJyVq+RTLJ/8Kc+Qxex9Z1OzvX/HrwYZkf288gSKdmxopdoSDfhqnJdKYDERlcQJ4w4KEQJW+HTKHIzihuzXLOdgy/oPaJHKncGnjVGMTEXlXW0RRoLDLDK01OPrV+URtSyeHL8ulEifrdC0toTU2KvWqeZHQ2rKE7lVmm03/DUF7VDyxcT3ixxYfOZG6Zwvvfe9q84YFI9j93w5+9CgepldKBqWEQ29Jgh/FVO0W6+ElOwsRASx7Ac+m+cI8JDiFuMFu+3wWW2Z/jRcCGUaQfkgi3VvTond9hW51b4q8TgLubGbBud/dstkof3d2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmb/NA+um0Tck1Zk0Xn5a6d7Kvfhml7rq4xnQqBQbnM=;
 b=Jt7aSS7XQgV+Is9qggZukNw+noQ62sUrAOnI+QncMzxTED5NNCiI4kT1CNDhfhf3Ysjna8IB8ebnSJuajPD854WcmGB0105JcmdTkWMvuWtHUgs1fN8m49SQr3jp4gxLH/OGDSOoPc4ZgRoJXZohAEJd9yIN4+nU+SHgjoPIAl8Cu9i0eD6eyNUbYqyNGVpBUTkKBot0o2/oEh0Ro3MXgNCb+FBclOXYzYgGWcN13BTPkOcMmH3KJEzCueUsZMv43nAcJycFn9kJoc72IMYscnd2GFe5zulA0APJVrcyKjfqurzdCM4Dco690CX5S71xzz+kqpWBCtssa++qPsU7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT2PR01MB9125.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:23:51 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aea6:d61f:5d6c:5f09]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aea6:d61f:5d6c:5f09%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:23:51 +0000
Date: Mon, 21 Aug 2023 16:23:50 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <ZOPH1uWsClZATvok@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT2PR01MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb3b3f9-62a8-4909-d51a-08dba2848883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mK9ExdiwsrdM90glOybWm4xtJrl11+hlUyMQY/lslYUHZB/bbqNo/CZC16+cM7lkDWr8img4zFfKCA2UUXeqMugHULy3LHD20UVwzk5aKPJVyICH8fzJKv0K52078eUbRkLVbRE3KvZEhyV9N+VGK2nuLn2MkYaumGNfBoMtR98FOQX9MjRar/CcLTydysZr4BzGCK7VAhOzg18Z+fG9qkMH/HKeEh5l7VWUCUqqH+H1W44MonCl9rVmnrO1OCVrs+gtnJh2r/U+kbWJfFFS6sHo194X4Z4May8rCX+gXRFlgpfxQG/MbXkP5vj5+KdHGxfDjxMW3hfZgavfF+7wJdsoTWX+Tds/cFx6noT+T4htMzPxnCriYE0g9irgNCZiRz+TXm40IfcQGqdpTdDV/2ji3BAhdAViSXuSEeklJWM7eUz8Lfj57gPmpCK2i0xyZ3qftGwIYXgIvYuOjDwv8BMQ2eAyr2EVEflTRvsLbL3TIPFwLGluF+TEJsBGhkGmBho2DcQnYMd2Yqll3YZhH79KpQW8+U1XOZ1Yj1Qxxz/Mq97feVFHeuvjhC2EXLYsknQb5PHJ4Qshm5KB5dk1kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39830400003)(346002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(224303003)(316002)(66946007)(6512007)(8936002)(2616005)(4326008)(36756003)(41300700001)(966005)(478600001)(38100700002)(6506007)(6486002)(83380400001)(2906002)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Q4ZD6kxBLly4uzWi06ayEGiIqqUusoUPIVpwWv4kZobDVh2/QG8bxXOt+I?=
 =?iso-8859-1?Q?Ls92dU4wlRB+namwDSHE0VmHWj2OwOgIuKnxOPtt+0pvY352guOvm7Ngw9?=
 =?iso-8859-1?Q?ZjEuzuHnCKyUwnSpsIbs56LxEmHEokWfZg8+jkhqiLgRPGwNfwZBjlmH/Z?=
 =?iso-8859-1?Q?RIOswVMkimOTrLf02Pok8SfTvwWKzHOkAKucY1NG/Y0p5dpLOw3QiTRukR?=
 =?iso-8859-1?Q?eKOJt1Kr2KwlKcQdbXJGs256Qpcz2ar7cWoJEtP8BU2VNhVBbeIHCnWHqI?=
 =?iso-8859-1?Q?2wy4aCXL3e0/qzqWohDQBl1PNRAppTmaYVbbYKCNbNy/LSPkSbfPeBRAAc?=
 =?iso-8859-1?Q?SXoyYY3KSdB+m6DWkuUNtR3jWqfuH7JtEP+dXJN2kNDY/Lg3I3ZDjSkjyn?=
 =?iso-8859-1?Q?+khGwrQuXDUeTMt/JmUSodPELR06A7dDLjBn3y/oKElw5IdXAWkbeDp5e+?=
 =?iso-8859-1?Q?GgK+J4SWyiEZADgLsWwZtKGOAK3F+Hw1/IfguL182jqI71nD0V3XygPQN7?=
 =?iso-8859-1?Q?zwXY/+GAQyD93QHuLUKs+wyIqaEVwxpw8PYYnjZmYpLZPrbdPsYs7X1axn?=
 =?iso-8859-1?Q?o/Gy542In5liiW1M8bNqUkopdodauZiOLyYm3bugD9GHQ3ko+WOgEuMQmS?=
 =?iso-8859-1?Q?+FpeDAPoCdDSUp5Sqp9q/xRHD4PlMY5oi9Feua2aeBuN/GQMB/we+YiwDZ?=
 =?iso-8859-1?Q?YcLAL6MuQrF8l8pKSzy6/Qjx3t0OhyreXhVdGnPSVhqmInLJUfJw+TJr9b?=
 =?iso-8859-1?Q?v9GJAQ7Sl+h6JJFjgE4bavaqNhrm2EOK9wqT5oAMf5FB6DIQ2Kr1gml47/?=
 =?iso-8859-1?Q?moooryQ48TaP6VMedx3cyI0JWNS73y4WgHixB0VCTKqbCeqnBiN/ns1arh?=
 =?iso-8859-1?Q?BnnzkQjmN/nRwAhwGvZS7QROkHvjIbw9RkoIJgAacnri10i6mI1KuDs0Lm?=
 =?iso-8859-1?Q?iNQP4izi6sJi6ZSY9JYe4gwwk0ppCJVep62KYHD0MAKz2Vj1FDIf0J+JrB?=
 =?iso-8859-1?Q?3hUS0vqd9Kr1uY0TMcm1SD7dANWtkd7xUxJ/MAPBLcZIHpwrrJ9BLV6q2T?=
 =?iso-8859-1?Q?R8H3HliNmeeTX//m4AZNJnIakCSlgs2TElqSIehabf+thK8QCJXzOKtd9R?=
 =?iso-8859-1?Q?rfODoPCYjKvOJi3ZJEPUfBehX03INvxEjMsY7P7JJw0evU79J+qv6OetaK?=
 =?iso-8859-1?Q?yjGeVReH9NSSXnuybmy6aFrtWLdqxtHPhdKBGqAs56JytM0xjxuxmPjvM0?=
 =?iso-8859-1?Q?L+a+HD1SOPRkUD37syNxzYOags9aQ0KrKjjEJ3Hxh/hDR0q322E4cf5emN?=
 =?iso-8859-1?Q?N5/3j3ta51CBBjlwsEZF9rCrAsYSpveLcwQ6kqEVqmqzTWfBuPvsVNDZas?=
 =?iso-8859-1?Q?X6YBD+mrRR5yGv+uZDYtyGjOKSUVifET3nGh48bnfTPfkO/+F83wCKVYV9?=
 =?iso-8859-1?Q?L/lmg8pabrQJZnzJKbNUeE1sc+W3jxFWlwc2H6VC19lOgoSHX+l02ZT8OS?=
 =?iso-8859-1?Q?eC/ajdVC0TYfU5/E7+HSmIGcsX7xVsTLSep9vpHw7hLPstiDNOQSiLYqMd?=
 =?iso-8859-1?Q?kGsfn1epWSYj2LTRCGY0Quo6aJiXifXkCss16ht5jjKKmaHSMeERXOgG1/?=
 =?iso-8859-1?Q?0bPskzbNfYuVSbzvPP/HGLU0tSM0yfCVmQ?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb3b3f9-62a8-4909-d51a-08dba2848883
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:23:51.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXB+VpZOvaZ4UVzIIMjVlGyEk7DNOTj+JlGYprI9GP//jjY/2/5yPVQg62LK4T9z5h7eo4HmaX+zWQLfL3rx6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9125
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E11?=
 =?iso-8859-1?q?_-_Nordicit=E9?=
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the eleventh bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2023-08-21 lttng-tools 2.13.11 (National Spumoni Day)
	* Tests: use CPU ids from online ranges
	* docs: fix: Match stated automake requirement
	* Docs: Fix broken reference in lttng-add-trigger
	* Docs: Fix broken reference to lttng-concepts(7) man page
	* Tests: Preemptively fail infinite blocking tests when low on disk space
	* Fix: lttng-add-context: leak of application context parameters
	* Fix: sessiond: bad fd used while rotating exiting app's buffers
	* Fix: consumerd: slow metadata push slows down application registration
	* event-rule: set event rule loglevel to domain specific value when unset
	* Fix: sessiond: preserve jul/log4j domain loglevels
	* Fix: sessiond: crash enabling event rules that differ only by loglevel t=
ype

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.11.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.11.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
