Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD61C5321D
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Aug 2024 21:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1724447518;
	bh=UhquntefWNzeRyHeqP+TjQcPzydCXKIlbknx9/caXe4=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bo5qEY97iF8O3FZxI/p1S0uYBP1NmsEgEkg7jBRLmgt9LX+gIK/zpdoKAQ8v3g4w9
	 g9f7zJ59nAHvEqeCTqUUCo2ZgdYb2iwGVzyq7wSmltS8HS3Vq6WvoWn7i2Hi89odtn
	 uG9qaGOFlws8reioGpWOfucQQl45clLMaEVU7LOsCJa2MRiBOCJkQS4YV+D+fSM+l2
	 No6QF+XotieT9MpKuQyDUZ9oq2mJA8biYnkChkEVBmySKX0XYjGpZC3Nl1Ib0V5oNp
	 aJNKjzA8482rCh6LIlDMrswJoOVKNbtvKG7Fk/t7/+agsdSwlZrjcsYqkbFEqyTMHj
	 0QEZaKhXLF9+Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WrCSF75YQz1CZm;
	Fri, 23 Aug 2024 17:11:57 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020092.outbound.protection.outlook.com [52.101.191.92])
 by lists.lttng.org (Postfix) with ESMTPS id 4WrCSD2GCSz1CdX
 for <lttng-dev@lists.lttng.org>; Fri, 23 Aug 2024 17:11:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPuN+n0/Wk49eV3Vlk+JOwzgJr/xpNVSvJ1Hyrpyih9C1/H2EdDJdEJpUAyxVR8zWgVEBiBGkLG2ozZEUDCXIxECS2WKq9I4biOQuhBaFJ1P9r5Fmz6EOXaVznRQ//xqynibqTr22Dcw1TAPUjWjNFr+CcmmGmPgi40KVKdp1XO4fPpiHXZrw01WU5IKRLm5Wg9EiJKEYH8SFgIm/fbOi0FyeNIwlU0uXl++ux1mdAbaKmShnTJHvgL5dgH3HxHj82rvqgUkbzXAoJpIZAvmYnRUN08Z+3+exqZv5Rghk+c418C25x5BFuPgyGMkSybBlrdBRXM2/6Hm+4OJvBGqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICLNNzBN1GQOFGu4UgRoAQ5fdrtmtSXpSBVr1Wj39U8=;
 b=CP87xiSGRi8V+TeL0bxOF2b/JRqgf5BE7if0BORTvEa1Ij9bwtyo1dP85tHAFawk+JlS2dpmkMk0X9gfSm7PkIEF27nIXB/Ln1WGWBs06+H5NAlqOySZZD/lmLN2CbpuYDlad9YEjjv22hvafa5yeactSid5LzJRMBmEUCHwG9lAeAFPp2QXr2QNaBlRu9Uk/gN+LDxCW3mnnxph4KHOpbEGyVIXoAYf5tz8A4VryihwKVDL9evu5dpKp2iK34fDFh3evdyDsxfrY2fGmMpYxNYAL7eS3sbfVgMalsNxJRQ/IK3k9ZPfYxft3j2ky5AY5H1aUFR8IVZ2LbCR9cvUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YQBPR0101MB5720.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:38::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 21:11:53 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 21:11:53 +0000
Date: Fri, 23 Aug 2024 17:11:48 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <Zsj654DUhAs4wcwF@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBP288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::8) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YQBPR0101MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd9a11c-40da-48bd-f49a-08dcc3b83636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?IOD0LcCGSlEPAJgDwb9kVpP0JnOVs9U3KYIjPzJTlX22AKGuVrmely4G+M?=
 =?iso-8859-1?Q?6MhA3358pf6iz+QwzyWzufKNczaRAI9b+VdJ0mqFk8a3nSkJVlsnZj5kOj?=
 =?iso-8859-1?Q?9rG3x4gkTunNvvIeQT6HCQ1hm+mD5By8mLkw64rMLIs8wgYb1pcucfuuCK?=
 =?iso-8859-1?Q?yxZAJWcx2H2c0I/nV/vECLmzSzhfd1OC7Rp3Lxx3lZV17vr48EeK3RVhBx?=
 =?iso-8859-1?Q?H+4W1b4msVwq6cemZGVhZHlNhmKbPrPfhDI8uEwjIHoSNQtiYah+GRiSKy?=
 =?iso-8859-1?Q?tn+/yiwjEiyzPSV9KSosz44Jv+K/bpWuNUNQ36u6Ig38c1PKQwtfFXcq1F?=
 =?iso-8859-1?Q?g2bBgulh/GYCj6yzvtQHHwVddu3rCHXSA0e4FuhSMJXkcBZsOFEXJk5vk0?=
 =?iso-8859-1?Q?H82OVRhFhF/vCpeJefVpA31Oh7sdSQ00cCoyAt59qQyfOBjDHAwnbyV7gg?=
 =?iso-8859-1?Q?9HEvNPXXwHm0sW8TQAwgJVHO5i7z0qLx/IPV0x1ikuPpvyXy798kSHQbU/?=
 =?iso-8859-1?Q?wqrTZrV5+8/3TLd4q9pqB+3RqyjDPRmEN3pqWc9bpJjMkc87CMAoSJeSxd?=
 =?iso-8859-1?Q?w8MPE6bQSRUFWBJ5gsyPsNUvvloMAMpy6AYwzf8iD4GAD93O3Z0nxurYeC?=
 =?iso-8859-1?Q?ZK2hfJQPiv70ci1gQS+VFYQ9nJlapemeR0DkUpa0wVDHk6IKqwaCwrPyjo?=
 =?iso-8859-1?Q?+E8t7LF25qWCSbTp3C/DEQLBZ2fe6VARz6tFWk0JazQWudWgkRxsFHO1ZZ?=
 =?iso-8859-1?Q?hkbtRKmN5RJrumhNoNjOkpP/F6HJnkI7ZyRmWQFJ1IZGAWq0/Xrj79vH5h?=
 =?iso-8859-1?Q?JMOFDTmPZNucplCqHjBHhdNOKDxCiyamqcu8it0AzU5yjVLCqS8dJQ23Pu?=
 =?iso-8859-1?Q?Yz7gtrUe4MDiyrX+gmCZmpcODyT1O7uukXylpbRBf9JSPwPGnzblz601LT?=
 =?iso-8859-1?Q?olc6xVYiDEiIvC6FRCzRFsvThZ7anr1oK7xz4277t4mK8di/bWuWbCEmXL?=
 =?iso-8859-1?Q?Qx0/S/arPpq2AHSJ20DM6NYIKWgNptKVkGhHGDsNY9lvjTBQYcFnWkxTtn?=
 =?iso-8859-1?Q?RUmu6KJL9iy3O0s2XJGVoRmqhaK/eAs1Cj902+7yfPWEKaRkpe7BvCb/0y?=
 =?iso-8859-1?Q?HIehD9RXAB7biFIA8ZzooRDWE45Q1RxS7/43PYyopoGHUC8BMk4CvWNuXT?=
 =?iso-8859-1?Q?4he4ej2v9vHwmcJta2aIn+3ifhrlC44mD+y9f1eDDXdorCPFEisLUntwdF?=
 =?iso-8859-1?Q?5WPLlZvGSVgW+LLIIqYMzNBSl9p/PuDzW07L5ONFNn7kzJGlmC0OfMeiU5?=
 =?iso-8859-1?Q?qkFbjS2Yw0q0UeA2lrs3xl7zlseLLhHbLrP5IPUVWWsdgQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TSuUzbSKnP8UJoPskAQdie3PATNP5ZS9JT/rW8rcRIig7Zf1Jk5flmRgzz?=
 =?iso-8859-1?Q?5c4qAz03aoZVTmCROCBjOpJ40VVWBk5Jwa+V3GNoYT1o0tKpqOdmdSwgI/?=
 =?iso-8859-1?Q?eFyIjOAmKGXJz4h8Ka8wYaN1nQcgBvfbcoEUpH2xUB2xTY2vA6Rcs/po4u?=
 =?iso-8859-1?Q?0FZITi7U/c1TwooSUioLX+49btRh4VPaLIMphUjK0Eep2JuMcdPCl3nx/m?=
 =?iso-8859-1?Q?WcDLivdpUYbyrp1UpCxQTM+PGxaSO9YyOkzLMnzqP70vfPwQNWMWHSAMSI?=
 =?iso-8859-1?Q?ZKPp6UzNHZERHKkXUqfTkSHRaY9fnN40o40pCK3jQKoJU5Wtv/M82CaDy0?=
 =?iso-8859-1?Q?WGb71lOonY49LLtOJzHKwLRj232LOgyI3Hc8eYsw3TahGCg4BN9IDNudHf?=
 =?iso-8859-1?Q?3RnrDbFtAhGranZlvN4yhGRv8KSSNkSi7qXc01asslvhCYYdvt+51OvOMH?=
 =?iso-8859-1?Q?AICvd08dQkgXCavZ826/p3UD13odx/tyHcJsaWCJ98qcZQC5mHIp6JjrKf?=
 =?iso-8859-1?Q?IbjUFwTM/4ZLPcsAhqBxXlZguYnBRgpfKfrvGn/RwqjNJzub17Sf/8lW4M?=
 =?iso-8859-1?Q?FIofV0DMP0vGxVwvrfaeO9LXhq/8r3uCuM+bhwg42/h6KjOgPaCU5nynBu?=
 =?iso-8859-1?Q?ZtJVvu1eCZf/R+uxZvrOba5TA+uAsOy7yrNPw9iPjjLRruW0qkDDroYbFu?=
 =?iso-8859-1?Q?hftFs45FoEcdxC0ufMPQXx3S150WLA7l0/IG0Doog0g8lwGhB8R7QKBaF0?=
 =?iso-8859-1?Q?P3T2ozBRuDaCjFq1Ncgcv/wDZPg5SO5rOakooBkiIniV+GoWkc1jMbE+zy?=
 =?iso-8859-1?Q?SH3gwGjjcUvPSYBM9CBUlVbX8Nn7YfuHWF2vFHpMXPuZWfSvWhJtpKGMq6?=
 =?iso-8859-1?Q?pkY7g1c+7GDbxe65SZ7KZaQp2T49grbKuWA5ZkYNJxHsRw+iieOLrh831o?=
 =?iso-8859-1?Q?89eOcl63XVw+pfWpDIqjCio/SkMakg2XqEzkB+x4XaVooAcwLSZYlGHioW?=
 =?iso-8859-1?Q?weNeVy75p5xJg5QMaVlYdCI2S+0eV8lvKnBSNs1yracdGJxuutDK53KvyO?=
 =?iso-8859-1?Q?ENF7HVapqqET5gaawNauWFlmq+VUIYfK2pUHKMZj++Q0aJUQtf84p/+C+s?=
 =?iso-8859-1?Q?Msduzqsi2zOp/55RsDLNLihLtyKVM1dQ35LzxweHla+0eDuFJ/93+HQbKE?=
 =?iso-8859-1?Q?cux0TzwM6pJJDUhiZSTmnU1sr5iCyQoxJUSaM1uZ553pQycuGmadbYZd1G?=
 =?iso-8859-1?Q?cG+f5jbVzW9w05Jg8M3wjM9xiNCJYmRabwE8/UdcJYQQnXZwmeEBblo93k?=
 =?iso-8859-1?Q?kTpahOQSQubH8sgxpBitWQ7CymJT0ECTO5o8VEKsCUb04bsydlwrG/G0E0?=
 =?iso-8859-1?Q?QhsXt/JaaW+bUzC6GnZLON4F+1c5OKfDagk25UHxWio13hDaUMY0qlW1Hx?=
 =?iso-8859-1?Q?xO96ORc0yBw2c0gs1VyJJMVE58rZSeR2t4V5peMxJ/4s5Obe4TuG7KaJf9?=
 =?iso-8859-1?Q?NvBccUza3SN1dYCeq4QH190kk5n5eyb47wNmwRtuuaD85XERLGXiMGYiHQ?=
 =?iso-8859-1?Q?J01eAFAx0IIjk6csXLXixxlVYV5suvzTwtQTTSHPlOSskRh3g/tOVQP7Yw?=
 =?iso-8859-1?Q?UN/JLYNoDFa9db1de1I1UrPc2ueq9rqP4A?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd9a11c-40da-48bd-f49a-08dcc3b83636
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 21:11:53.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md4DXP05tDkOqGV33axoHqzG0uT9BXPLAUY7874XN8c1wIW93QGKRje1gOxHXSpCvJo3+MrGzLOeTiN2r1/gOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5720
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E14?=
 =?iso-8859-1?q?_-_Nordicit=E9E?=
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

We have just released the fourteenth bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2024-08-22 lttng-tools 2.13.14 (National Take Your Cat to the Vet Day)
	* Fix: Do not null out lttng_consumer_stream channel on deletion
	* Fix: Crash when unregistering UST apps during shutdown
	* lttng-ctl: Hide symbol introduced by fix

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.14.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.14.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
