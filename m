Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9DDEB64DB
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jun 2023 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687294506;
	bh=BmhS9oW/OsdsdFHBc4nSk5byYzHx4nNJ8h/XKvcK64o=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=b4Pw7XXcLyKmT9MAHT1vs4iYxpoWVwI2bujMQhxPspvmxz2aV7MEDY9SPy/0Grm6X
	 gUVtSGkZZBSMLTnBdAuYiZg0Rdjg5sQ/Ru2ZOJ+eQZxKIl+HKizqQr076eVkG49znk
	 yxjrm0p7R3E9Xq+gxzK+EUBiwjhJhfmDZJJSb0re1xmc6rZOCnFhn5kwGSuz4DM45v
	 +XcTyBHGyRb5odMdazyVWaUoeK+PIE08rJgSppFerAQfHqlt5TMex5DORnNpmUq/SQ
	 +EuM7mtA+eNyQLpqnaFrZ48hR1C01ho1vqzi4ytuXJjISeu0Y7u8S6mkitujoIntKF
	 nPb+cY9ZfBfdg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QlzRF3tpgz1yj7;
	Tue, 20 Jun 2023 16:55:05 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2043.outbound.protection.outlook.com [40.107.115.43])
 by lists.lttng.org (Postfix) with ESMTPS id 4QlzRD1XJ0z1yCd
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 16:55:03 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEIzievJDOZm96LsYTYY7f6A7nHMHryx3HMM2dRyFhm6fS2wh1mJL32JL3jkN+b9grhIbgBZdiKH9bhVSRBC4bIQpr2MHTUW1Sa7M4BXSMBDhpdbQw8Ov0492QnSJtpVj2rukL4HWcOPOMmOT7NXsOfuas1Auf03L4z/yxHt+DcLa/SLPKSSytI4VLv8nrKVE9cLAfEmPPwUFg5NQqClcgzyh5RGPMAO12TP8ifXdqPkAJZUiOFJZpqnMxB1mb43vjPts7erF+I6FSpLMGrC7tljgfc/xpoBPkbqH2hLGpKiwIcQPGjZ97V0Lcr8A/kitlq3Q025CQfXzahERLLKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sk/Lz9OHnUqvKMu1qguFkjs8R79YkwN+AlM9ZLHyyY=;
 b=CrjOpn3x/p5YGhg317QRAWw8cI8BMhn9RLpmIb1ZlYGKfxoBriKx3qT1/945yIKAx4midCz83yrxQU2N+kTA35oIozqHXWIcoyXcmDTu+NgBXeTeKm0pRngWlbNsHDIaaxmbaSf/K0A0NlKtHBuaYCSP9M/g4fmX+jCpKkq6jY8cf0NuytoIT1FQB7C5I8q2cKX/yLYsDF+/nYf9U87cXmlEhE3HUxYe5oHu+pHK61FAQRd5J6iwOc4nz0/JtpT7pKjhlIB57yN07PstJmulW02izRITzj1MdVrIHAxs5T3o/p18cnk0BlQ7pJaM6yXqCBmvRG3yIyKnfks2B5j+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT1PR01MB8155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 20:55:01 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::11ac:bd53:ce:1004]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::11ac:bd53:ce:1004%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:55:01 +0000
Date: Tue, 20 Jun 2023 16:55:00 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <ZJISJOFmEGEJEzwj@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::26) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT1PR01MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 536b190f-fad5-4f78-c136-08db71d09d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXlG10eAFaXZ3LB72GwE19Uc7q5QgOl37dduJ+btOs8WtkI5zelSqJSiMaOzU+mXdLeN4DYfrl7QJaf6HdlztW2R9lmrTSS0GMuGIZKS6iMyHqDzSiuK7tEnQ74VuSci2f61Mix15FA0MPYZxs+3THL7jLIoad6aREqFhSk30GnQz4ccEIGAeJpoocLcdShA14O3JFfoHNH/G4MPK7H2Yf2iYuv28PX7pshd1QpQcjKTTAyt2INP5+gQWLOWs7Z/eKxf+ebekt1AJej1qUSeE5p9Rl2Xw8xueIGnwVIXNNYkRQnIhfgCgkwiTJIDcoGTt32a6Du9YYbp7JXIfA96Hi0fUTZRHpjul+nnYqRz3O40jB1i2QaXQYLa/pgI2yAh0+OncBLDPNMuDVmb77COg5bQPHrkC71lrx0Jh23KXj1c5YDWk4ptmhm1OUSGZGFiTn+A7+n/r65eJilD4OG/V//qC/ndFgwpX06NMryKunBRn/W6zjEipS5/bHBfj79RbM1RLmzbLMQxDxtp/pJBo3UnZwNNp9ppBfYYGBqghqmvse2LVGpiHmEMp5p7jQpvm8gXcJSxuQl0UVyUYCywqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(39830400003)(376002)(366004)(451199021)(38100700002)(36756003)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(186003)(26005)(54906003)(5660300002)(966005)(6486002)(8936002)(6506007)(6512007)(2616005)(4744005)(2906002)(478600001)(8676002)(41300700001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knChIZGIf5hH8TkTIVQnCbAXQ54Q2Ya/RqKelZnk2MfbZA3WwiEvvwApRI7q?=
 =?us-ascii?Q?owbzg/FU4nhPmgWF7jXMi8wi2glf9eaPUpjNFQ+qjWbHJxF/RJpFxtb28Svm?=
 =?us-ascii?Q?8QSZdv7FzgwcEe2BuVZQsg3RcBnUCscg5JnZh7RnB8Y1C+QJegHRh4ynvLF7?=
 =?us-ascii?Q?DmUkAbaxxTIYQy3wlyQFEO9MlpIQnLyshYCvPplw8YiP8SfKSWULkKrrLBUf?=
 =?us-ascii?Q?qgNDGSkESweHVaBx29enFM8nJul2vm42qwAOsqNABc9uz/V3ce9wsrBYBEpb?=
 =?us-ascii?Q?cFaPOjYGHYLfOtumY36grkZCxsvoDIbIRac2FqY9yzqoV6IaobqU3UwanPjG?=
 =?us-ascii?Q?E0D2cGn5CvX/jTTcmh6Nl+mFJPfFJpIsOwBH6rkPoqt87dmx4dQA4/CSPQNR?=
 =?us-ascii?Q?I+sOsWIIAAfgUauI6x8+25kdUeuUlKasC1wSmIF0UM/aXRE5HfOsWTQNwEAv?=
 =?us-ascii?Q?pVYGjVa8PycSNNnOr1X8Rtaje+7K/ICBZUwa3oN+I9WkPRnGe1EqC5kO5mP+?=
 =?us-ascii?Q?U+wvOyO0N2pb5FKdLQrSkj3GYKNVH7ZWAC/efVcAHthHcQAPaUw4PtraSb0D?=
 =?us-ascii?Q?XxwXcYXls3yElIxkQ1kLJIlcjfNSv8A2xOlWey6HYPSsCrrxAGU5lTmp3UrM?=
 =?us-ascii?Q?ilHM6qUZVa9hIDIUL4kBiohvxyg6SayseV/fGKrkbFp7azj0WmsZCBRiu3kh?=
 =?us-ascii?Q?BJnVIC3PyURraGU7mDEYRuyev2DA+7B6CBNwLOyIxt6mmsSdlHYePFJ+bKBG?=
 =?us-ascii?Q?cXrY10xFiVWxUFDRf0HUkC0S+A9HitNFJaTXSEzrBAJct9BxZPW4Qg6LZTdO?=
 =?us-ascii?Q?jyCunl/NK4Xb9VH0DDVfsEfAABZVb5iN0qpo+Hj7f7USl8RMGscGLCBWHi2E?=
 =?us-ascii?Q?2cc/Astiti4uuUl1h1II+lZlg6P4r2Q1pFTjvIAbx0yHdlkk6Xs2yiscoLC/?=
 =?us-ascii?Q?H+8FoMyLt5IrjK/sn9ZInBTM+lN9rmppv2jnSzud3diyI/Ao3fPZZGNSkLLq?=
 =?us-ascii?Q?6IV8EZS/dmXRMiUQURZw2hTZqVOBM/nELpKvsCVPkFeGVWUyEjbVFvfj2UYg?=
 =?us-ascii?Q?nlzKzk2FPASQ1NyksHCksM2TgGpYDsmM4OA+sRC3UHlB02hwZPNifBzyDqsk?=
 =?us-ascii?Q?vJJzCEjFnuyeLrbi9LtTQ/YO/GqZvWCVtBKWOpu2ViV4XtErP5EQYLXGG8rv?=
 =?us-ascii?Q?5udjO2q6eR8DJ/CD3XV5h1jn/w7AH8rrAP1o8ZpVDeTmEaQipgKb1F6gV6pD?=
 =?us-ascii?Q?UD0j8BAyNTde8yLliNe5FCnnlNA4F81PLO+JFOT11DpqnLxu2TdIrZaSaxzc?=
 =?us-ascii?Q?zkpmahesmN6t8pqsGlSpS6V+u/z4O6VgZBfNYAzqeW7i3+0uMpOGb9XAlDNv?=
 =?us-ascii?Q?MJgkQD7dWz7r0+bkzPQOr7kW8W4fcMEnnxjIXfiO+5x8MCkpZLekZProiGmr?=
 =?us-ascii?Q?Xq25+AbdYDIvcoqE8CDL6kyrx4syBhSJkGgHYgji4ZnCvUe8mCCsrB7P9Ggc?=
 =?us-ascii?Q?g1R5Xnw80kUVqt4LgBRYs6OnSFVZspeBb8qpw3WsQsOYSw6pMxhy0Nzu9EoD?=
 =?us-ascii?Q?tC4tDnRXRmaPsUlTZzek7BCRglS1JC/Le1NP1tYu?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536b190f-fad5-4f78-c136-08db71d09d75
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:55:01.3283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f0C72sSOQ3QdgCokdO0XMElP3bINzCzY95YSmE+IkU2a+pPhOh9Lf7CZFHo+63EXwR5IOQ+IuTFKH3BLrzDSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8155
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.14 - (Ta) Meilleure
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

We have just released the fourteenth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2023-06-20 lttng-tools 2.12.14 (National Ice Cream Soda Day)
	* Tests fix: test_callstack: output of addr2line incorrectly parsed
	* Fix: adding a user space probe fails on thumb functions
	* Fix: Tests that assume CPU 0 is present
	* Fix: Wrong assumption about possible CPUs
	* Tests: fix: parse-callback reports missing addr2line
	* Tests: snapshot tests complain that nothing is output
	* Tests: Test snapshot maximum size correctly
	* Tests: Add get_possible_cpus_count utility
	* Fix: ini parser: truncation of value name

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.14.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.14.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
