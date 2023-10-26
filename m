Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7FDC25B48
	for <lttng-dev@archiver.kernel.org>; Thu, 26 Oct 2023 10:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698315722;
	bh=/7AWVZmjkMQNRZQMH/d3UT7kVwMIkTh99rn0zFHVpkc=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ThZtf0WgL9AFs21XRLEcv4WcxDEqDEk3A14JmGXQp4r/0/b1XdP1xeiR97pRbBeSw
	 ijpomlzRKX2oFWPu3PGP1gwYt8Kog2OdETc64SbUerCWMZt12hgsKAV7X5jifg/MpI
	 UWI6OfvOFrosYaWpn+o/+YMUbZ9L7SMksXmuza65m9w0F5NN3S4qdPXdYeWymYu4en
	 niunif1XRzbT+aXr20iEJRqrrnOZhJGAspN/q0WHo63A8Q6BxQZZBpUtWuRZCQ5oD9
	 EguBPzloVBHUARaXortzvN/50OGj6DEswpmUhyEcINNzS98n4rbNUN0iu3Hck2FHMt
	 al4RhneR9e4Sg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SGMKk1QYmz8d9;
	Thu, 26 Oct 2023 06:22:02 -0400 (EDT)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::704])
 by lists.lttng.org (Postfix) with ESMTPS id 4SGMKh3mXlz8X0
 for <lttng-dev@lists.lttng.org>; Thu, 26 Oct 2023 06:22:00 -0400 (EDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=SExjuhF46847JDt2DaR/W8bDaRM4LL3a+IImZwtxJPmmAaPKyrh9pogp23pstYJQq2WhLMY3iM7KpqBGhvAMr0BIgq89tf8JqPU9v0XEjXGQfRdyQnr3m6z5jzFJwu67bRappgmCAeWpZdn9wq0oOOAP2g2rgSX6ZC1o4LYqE0KadrKHaITSWJcuoPUxxX/7CEzj5ONoUSVjoLl0C14hC5FFrOnQJwtziU8Bb3BglFVEIygyav0apTaqkiIb0VCE4ckwCRhvoJCO7MgAR53V06/41KoPhtZ5BlfMWKZztIToehIMTe1GXnW3Ssd+OGJtLOisuZo/+c2xVSb3A9Sh8A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t+thf6hIZwaIuPcNg59u7hqczucblrvPfPfLbHtDBs=;
 b=J5D7xot7wvB8xgkM5e97OlgeBDNZRvHbVwWbQkhT7M4bvVDv//O/knZtCi5dzQCdbTJNpu2+inNbZd7MatJgUhYCTFgj3LOBu1eXi+VDkLNCNhwwPboAtjzD8ag1ZNsRBsod45j7C0y7gKoK1A03y86oXZ2LdJA0JblUPBDckQevh8mvnKQc5XGO1iYsmG4o+Bj3GJK83/vTIdanwthS8v9NGMGiJwBRccOW5npWSkEgjx1qdkf4oApEivNpjRQF6M+HS6BCprwoTdd94b0BJmTSDNghJZkLYhSxEq4Q2gjrnPjvSDTOOFr6Vu0syfNh+lAxMnAFaXyH45OfgSdHyA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.14.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=zeiss.com; dmarc=pass
 (p=quarantine sp=quarantine pct=25) action=none header.from=zeiss.com;
 dkim=pass (signature was verified) header.d=zeiss.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=zeiss.com]
 dkim=[1,1,header.d=zeiss.com] dmarc=[1,1,header.from=zeiss.com])
Received: from DU2P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::21)
 by AM9P190MB1267.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:264::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 10:21:58 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::87) by DU2P250CA0016.outlook.office365.com
 (2603:10a6:10:231::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 10:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.14.50)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Pass (protection.outlook.com: domain of zeiss.com designates
 104.47.14.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.14.50; helo=EUR04-VI1-obe.outbound.protection.outlook.com;
 pr=C
Received: from jegw2.zeiss.com (3.126.247.145) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24 via Frontend Transport; Thu, 26 Oct 2023 10:21:57 +0000
Received: from ip-10-25-10-142 (localhost [127.0.0.1])
 by jegw2.zeiss.com (Postfix) with UTF8SMTP id 6F7A61B58C6;
 Thu, 26 Oct 2023 12:21:57 +0200 (CEST)
Received: from kag06088vm017.zeiss.com (kag06088vm017 [10.25.10.199])
 by kag06088vm012.zeiss.org (Postfix) with UTF8SMTPS id 54B581B583F;
 Thu, 26 Oct 2023 12:21:57 +0200 (CEST)
Received: from ip-10-25-10-199 (localhost [127.0.0.1])
 by kag06088vm017.zeiss.com (Postfix) with UTF8SMTP id 4F3E432DBD9;
 Thu, 26 Oct 2023 12:21:57 +0200 (CEST)
Received: from kag06088vm014.zeiss.com (kag06088vm014.zeiss.com [10.25.10.164])
 by kag06088vm017.zeiss.com (Postfix) with ESMTPS id 4222E32D76A;
 Thu, 26 Oct 2023 12:21:57 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50])
 by kag06088vm014.zeiss.com (Postfix) with ESMTPS id 2482E3E9A1;
 Thu, 26 Oct 2023 12:21:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXKMR7PSvBoAUpPFxzHbSy36UcvnuAWaBjqaTmC6sLiSP0JDjiELFv2ebKD1Dfz8sE0TI4tArP7ERIcjTr34iWbfl3Zj75KHMIXVOdy5oFtZafBYReBSjFiSIcPlKar5iq/mm8BOfHvLaOMkGcQSkP4plqg1jyUAXNbqaneA4h7u3FCYAI00a2ApgBB2nzx55ldo8YjzXBQGcFIRczFowlCROVHjMIX2Bbw5iWNv858g3UGMFxArN6C9d6JRVkuBr8F1Y6wUh3LoKEHgTpXgHIuk3Us6VWvPVvk/Ic5qDKiUXQr0/sKutldBYDCzfECrCHzCfY0O5+yDJ7hSPbh5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t+thf6hIZwaIuPcNg59u7hqczucblrvPfPfLbHtDBs=;
 b=ghZ87L5dZZPk90Y6VVras29oXsxAz5BeXn7PJllO7AdUNG2HrKLgdsjrNFk6uHYd4BvEib3OOlyIB2n5KAuEETLQObPZb1kgAsO45Xjhwe/pJwegzDRGbHPYz4C0nswjCMuW0akNqtY4QgbY87NQZx2nDw0PEBoGduv2Obl4kvY93zf8ddVVO4AnADvWOKecSTfOavJsPl5ADDq6GZJKGD81xtA1ynfc0Cak214eNT6P0fDRHSh29khhrLT9fgI5xT1ABSDVtruX8Qn034KMV5izhJmhNZOWO3FtBRNUuXN9CTbiF4m7uNkpyWnBKcKS3TJfYazUC6BDiXqMb/pBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:265::21)
 by AM7P190MB0632.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:11e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 10:21:55 +0000
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::9f17:efb:5e43:a093]) by AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::9f17:efb:5e43:a093%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:21:55 +0000
To: Philippe Proulx <eeppeliteloop@gmail.com>
CC: Simon Marchi <simark@simark.ca>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Debugging Libaries in Babeltrace 2
Thread-Index: AdoGkgHE+igf3/rqSLKp4/pt3elO9QAGR3QAABp26bAAD2sSAAAoxqUg
Date: Thu, 26 Oct 2023 10:21:55 +0000
Message-ID: <AM9P190MB1075B725C4647F4C97BDCD3888DDA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB107537176AB808CA2F55AA2488DFA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
 <f0ca6352-ee2e-4943-8375-a228557eb49c@simark.ca>
 <AM9P190MB1075EE7CA033D45006FCDB0D88DEA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
 <CAB4xu_3rBu0ROuypyQ6WEa_GdCYdUxvpHOzPNteAU6=TTA0B2w@mail.gmail.com>
In-Reply-To: <CAB4xu_3rBu0ROuypyQ6WEa_GdCYdUxvpHOzPNteAU6=TTA0B2w@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeiss.com;
x-ms-traffictypediagnostic: AM9P190MB1075:EE_|AM7P190MB0632:EE_|DU2PEPF0001E9C3:EE_|AM9P190MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: 758a6da9-6e16-46c4-840a-08dbd60d627f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JWgsSbisNKgO4h/qKe3VeXpOz4RH/J72fr5brMMeljs1zZVrBQFGIQKTMOI+CJABfDHYG4kySnjVUCxzKJrfcNqFBaEo+I65s5iJOr9attomW5MQhqlR/RylSD7AcyyE+WnlXDyKIcy/ifaiPPF+kBu+lkhgICwExxD/VUDDzuzyWOCOznF41fiZCcCeDvHjTK/7RniOHI0THhZplQVUXTAz4TvhfhOgVySbhT5mGKV3zE8YRYbcIe3YrS2OVbfCMG1EY7Jz3fSh/ilKZoueMq6lGZxcXTR6iom0c09D5UmBZG8tH/+5nAgq/K7rEVt0Z1WdehmbiVq+g9K+lk4d4sDXgKemD6ahexsxtNRebEyhfir9XuMymvd5cPolzVr9ouEKnyxpb9Du/aisvgA/5kZMwNvmaTW/wgyRjJ1DtyvXuT4Cto920lMvR0r/qG+6ev4IopYpHXPE5SeimE3xU5oTW4lGdiJu21oR12SNpae50Utlbd8GdyGu2qWx9/tJjjCLFGH2HbLYpiyrFXZpWFuRaqczOvPYh+1ud8+JAFsmUqqLXhjKjanwYp9vXq1xWZ8cbW4Ii7jZiLM5B5QxvD0tdMpz9Hnwlq1RUU0Km/g=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9P190MB1075.EURP190.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(38070700009)(2906002)(41300700001)(8936002)(5660300002)(8676002)(66574015)(966005)(316002)(4326008)(6916009)(54906003)(82960400001)(66476007)(66446008)(66556008)(33656002)(86362001)(64756008)(66946007)(9686003)(478600001)(38100700002)(7696005)(53546011)(52536014)(15974865002)(83380400001)(45080400002)(76116006)(26005)(122000001)(6506007)(71200400001);
 DIR:OUT; SFP:1102; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0632
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.14.50];
 domain=EUR04-VI1-obe.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[104.47.14.50];
 domain=EUR04-VI1-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6b86e8d7-1c6f-4a52-ec57-08dbd60d6121
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muXuh7Bl7I7Kd6owVDa+oPTNuCBieKCCnB5A3WfmUWSEjvAh7HLM7SjTv9+F0Il/1eh5JQYJjbD0NhUcXIrzRodmRWV42hQQGDzsTxgdo3Vi5v3fr/8bpct6Nfel21Z2eRuZq9hdDHIW/1ryiByJmZEon5n2zkRbA2GSRS6hslkxl9PJeJPJKPu/2KYvjUCjw4Lr4BDxnDDjRjzQXX5BXkyk0eWQ/Gl/qBuKiInrD1wRhOYvUeEFGYdv2IpDVXqshty2QzlWdfj/LCst943ubWKDizpp6Cu1U3sG1yzqHNup3EaxQXDaEJSBV1ksP8UJNiK4nU1ELVyP5/5VrIePqq/L8ITjJdzBRfUfEI6NqgpWPWzdwjGQ2goQpzmdyCDivIfJ7/XfsXoDPw540ovR/zUlbXQWSFMj2ne6Voq0eYTLWYKC31d4R4MO/vb+jeRmZmT0nvbEK0UP7sIiRsRxsbYYSu4hyGRxZLRoRf5CKJVhFn5Ucut+/CGwYN+xSrI85668eIG225+LETUPLldnwULwSb2s39zIXT98vH+GURcE9eKCxjYwIxm3el4FU3bZfw8v72U2xGGeT2TVFN5fEkY7nC2BB/Jkb94Ll3fuf6ky+QVnh+Ll9zEmFsUVNadwUlrk+FKzJ8JJaNO8vaMsTeb+7uGEoAOZ+qUui67ta8AdTsdCvzLb7e3a5jfSTLvA1F15tO4OwJaAWlUYhReuEZgea4pdCxO848OOsAmCbiTo779VSecUMXjD4A9AlL5Di+7Ou4ertSOcCtKBiwKiy4Am1vQG245yp+OOh3wDtT9rMKgLlySDL+OX0LK/4m7rNiJDyeMYdhsJTAgfVVYAkfWcLb9B6NMBzwRr6d+c0t0cwA50LTZMIb9F+Qp7uyLNCANTZnzcv429wqsduTBWS1b7eD6v8wjEzdk9osJaJRU=
X-Forefront-Antispam-Report: CIP:3.126.247.145; CTRY:AT; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EUR04-VI1-obe.outbound.protection.outlook.com;
 PTR:mail-vi1eur04lp2050.outbound.protection.outlook.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(7636003)(26005)(2906002)(41300700001)(36860700001)(86362001)(40460700003)(4326008)(6916009)(8936002)(478600001)(8676002)(33656002)(70586007)(6506007)(156005)(82960400001)(7696005)(32850700003)(54906003)(52536014)(70206006)(82740400003)(316002)(83380400001)(5660300002)(9686003)(47076005)(336012)(53546011)(55016003)(66574015)(966005)(40480700001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:21:57.7718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 758a6da9-6e16-46c4-840a-08dbd60d627f
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8; Ip=[3.126.247.145];
 Helo=[jegw2.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1267
Subject: Re: [lttng-dev] Debugging Libaries in Babeltrace 2
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
From: "Seidl, Aron via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Seidl, Aron" <aron.seidl@zeiss.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

VGhhbmsgeW91IGd1eXMhISEhDQoNCllvdSBoZWxwZWQgbWUgYSBsb3QsIEl0IHdvcmtzIG5vdy4g
WW91IGd1eXMgYXJlIHRoZSBiZXN0IQ0KDQpJIHdpc2ggeW91IGEgZ3JlYXQgZGF5IQ0KDQpUaGFu
a3MgYWdhaW4hDQoNClNpbmNlcmVseSwNCkFyb24NCg0KX19fX19fX19fXw0KQXJvbiBTZWlkbA0K
REgtU3R1ZGVudCBJVCBFZHVjYXRpb24NCg0KQ2FybCBaZWlzcyBBRw0KQ2FybC1aZWlzcy1TdHJh
c3NlIDIyDQo3MzQ0NyBPYmVya29jaGVuLCBEZXV0c2NobGFuZA0KDQphcm9uLnNlaWRsQHplaXNz
LmNvbQ0KaHR0cDovL3d3dy56ZWlzcy5kZS8NCl9fX19fX19fX18NCkNhcmwgWmVpc3MgQUcNClNp
dHogZGVyIEdlc2VsbHNjaGFmdDogT2JlcmtvY2hlbiwgRGV1dHNjaGxhbmQNClZvcnNpdHplbmRl
ciBkZXMgQXVmc2ljaHRzcmF0ZXM6IERyLiBNaWNoYWVsIEJvbGxlDQpWb3JzdGFuZDogRHIuIEth
cmwgTGFtcHJlY2h0IChWb3JzaXR6ZW5kZXIpLA0KU3VzYW4tU3RlZmFuaWUgQnJlaXRrb3BmLCBT
dmVuIEhlcm1hbm4sIERyLiBDaHJpc3RpYW4gTcO8bGxlciwNCkFuZHJlYXMgUGVjaGVyLCBEci4g
Sm9jaGVuIFBldGVyLCBEci4gTWFya3VzIFdlYmVyDQpBbXRzZ2VyaWNodCBVbG0sIEhSQiA1MDEg
NTU1LCBVU3QtSWROcjogREUgODExIDExOSA5NDANCg0KDQoNCg0KLS0tLS1VcnNwcsO8bmdsaWNo
ZSBOYWNocmljaHQtLS0tLQ0KVm9uOiBQaGlsaXBwZSBQcm91bHggPGVlcHBlbGl0ZWxvb3BAZ21h
aWwuY29tPg0KR2VzZW5kZXQ6IE1pdHR3b2NoLCAyNS4gT2t0b2JlciAyMDIzIDE2OjUxDQpBbjog
U2VpZGwsIEFyb24gPGFyb24uc2VpZGxAemVpc3MuY29tPg0KQ2M6IFNpbW9uIE1hcmNoaSA8c2lt
YXJrQHNpbWFyay5jYT47IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcNCkJldHJlZmY6IFJlOiBb
bHR0bmctZGV2XSBEZWJ1Z2dpbmcgTGliYXJpZXMgaW4gQmFiZWx0cmFjZSAyDQoNCk9uIFdlZCwg
T2N0IDI1LCAyMDIzIGF0IDM6MjnigK9BTSBTZWlkbCwgQXJvbiB2aWEgbHR0bmctZGV2IDxsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnPiB3cm90ZToNCj4NCj4gSGkgU2ltb24sDQo+IFRoYW5rcyBm
b3IgeW91ciBxdWljayBhbnN3ZXIhDQo+IEkgcnVuIEdEQiBsaWtlIHRoaXM6DQo+IGdkYiAtLWFy
Z3MgLi9iYWJlbHRyYWNlMiAvaG9tZS9hcm9uL1NjaHJlaWJ0aXNjaC9rZXJuZWw0IC1vIHRleHQg
KEknbQ0KPiBpbiBzcmMvY2xpLy5saWJzKQ0KPg0KPiBJIGRvbid0IHRoaW5rIEkndmUgZXZlciBp
bnN0YWxsZWQgYSBTeXN0ZW0gVmVyc2lvbiBvZiBiYWJlbHRyYWNlMiwgc28gaXQgaXMgcmVhbGx5
IHdlaXJkIHRoYXQgR0RCIHVzZXMgZm9sbG93aW5nIGxpYnJhcnk6DQo+DQo+IDB4MDAwMDdmZmZm
N2YzNmYwMCAgMHgwMDAwN2ZmZmY3Zjg5NzQ5ICBZZXMgKCopICAgICAvbGliL3g4Nl82NC1saW51
eC1nbnUvbGliYmFiZWx0cmFjZTIuc28uMA0KPiAoKik6IFNoYXJlZCBsaWJyYXJ5IGlzIG1pc3Np
bmcgZGVidWdnaW5nIGluZm9ybWF0aW9uLg0KPg0KPiBBbmQgeW91J3JlIGFic29sdXRlbHkgcmln
aHQhIFRoYXQgaXMgdGhlIHJlYXNvbiB3aHkgSSBjYW4ndCBkZWJ1ZyBpdC4NCg0KTm90ZSB0aGF0
IHlvdSBjYW4gYWxzbyBpbnN0YWxsIHRoZSBwcm9qZWN0IGxvY2FsbHk6DQoNCiAgICAkIEJBQkVM
VFJBQ0VfREVWX01PREU9MSBCQUJFTFRSQUNFX01JTklNQUxfTE9HX0xFVkVMPVRSQUNFIFwNCiAg
ICAgIEJBQkVMVFJBQ0VfREVCVUdfTU9ERT0xIENGTEFHUz0nLWcgLU8wJyBDUFBGTEFHUz0nLWcg
LU8wJyBcDQogICAgICAuL2NvbmZpZ3VyZSAtLXByZWZpeD0kUFdEL2luc3RhbGwNCg0KTWFrZSBz
dXJlIHRvIHJ1biBgbWFrZSBpbnN0YWxsYC4NCg0KVGhlbiBgJFBXRC9pbnN0YWxsL2Jpbi9iYWJl
bHRyYWNlMmAgaXMgZnVsbHkgaW5zdGFsbGVkIGFuZCBpbmRlcGVuZGVudCBhbmQgd2lsbCBsb2Fk
IHRoZSBjb3JyZWN0IGxpYmJhYmVsdHJhY2UyIGJlY2F1c2UgaXQgaGFzIGAkUFdEL2luc3RhbGwv
bGliYCBhcyBpdHMgcnVucGF0aC4NCg0KWW91IG1heSBkZWJ1ZyBhcyB1c3VhbDoNCg0KICAgICQg
Z2RiIC0tYXJncyAuL2luc3RhbGwvYmluL2JhYmVsdHJhY2UyIFsuLi5dDQoNClBoaWxpcHBlDQoN
Cj4gSXMgdGhlcmUgYSB3YXkgdG8gc3BlY2lmeSB0aGUgbGlicmFyeSBwYXRoPyBCZWNhdXNlIGV2
ZW4gd2l0aCB0aGUgbGlidG9vbCB3cmFwcGVyLCBHREIgdXNlcyB0aGUgcmVsZWFzZSB2ZXJzaW9u
IG9mIGxpYmJhYmVsdHJhY2UyLnNvLjAuDQo+DQo+IFlvdSdyZSBoZWxwaW5nIG1lIGEgbG90LCB0
aGFuayB5b3UhIDopIEkgaG9wZSB5b3UgaGF2ZSBhIGdyZWF0IGRheSENCj4NCj4gS2luZCByZWdh
cmRzLA0KPiBBcm9uDQo+IF9fX19fX19fX18NCj4gQXJvbiBTZWlkbA0KPiBESC1TdHVkZW50IElU
IEVkdWNhdGlvbg0KPg0KPiBDYXJsIFplaXNzIEFHDQo+IENhcmwtWmVpc3MtU3RyYXNzZSAyMg0K
PiA3MzQ0NyBPYmVya29jaGVuLCBEZXV0c2NobGFuZA0KPg0KPiBhcm9uLnNlaWRsQHplaXNzLmNv
bQ0KPiBodHRwOi8vd3d3LnovDQo+IGVpc3MuZGUlMkYmZGF0YT0wNSU3QzAxJTdDJTdDNDNmNzI0
N2E0OTJlNDlmMjA0NGUwOGRiZDU2OWYzNDglN0MyODA0MjINCj4gNDRiYjUxNGNkNjgwMzQ3Nzc2
ZmEzNzAzZTglN0MwJTdDMCU3QzYzODMzODQyMzI2Mzg2NzAyOSU3Q1Vua25vd24lN0NUVw0KPiBG
cGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFo
YVd3aUxDSlhWQ0k2DQo+IE1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2RhdGE9TUxuJTJGWiUyQkN5
VXFsUCUyQjFwMk0wUDRxVGtDODNGQ1YwRWhxU3QNCj4gZ1V6SWw2T2slM0QmcmVzZXJ2ZWQ9MA0K
PiBfX19fX19fX19fDQo+IENhcmwgWmVpc3MgQUcNCj4gU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBP
YmVya29jaGVuLCBEZXV0c2NobGFuZCBWb3JzaXR6ZW5kZXIgZGVzDQo+IEF1ZnNpY2h0c3JhdGVz
OiBEci4gTWljaGFlbCBCb2xsZQ0KPiBWb3JzdGFuZDogRHIuIEthcmwgTGFtcHJlY2h0IChWb3Jz
aXR6ZW5kZXIpLCBTdXNhbi1TdGVmYW5pZSBCcmVpdGtvcGYsDQo+IFN2ZW4gSGVybWFubiwgRHIu
IENocmlzdGlhbiBNw7xsbGVyLCBBbmRyZWFzIFBlY2hlciwgRHIuIEpvY2hlbiBQZXRlciwNCj4g
RHIuIE1hcmt1cyBXZWJlciBBbXRzZ2VyaWNodCBVbG0sIEhSQiA1MDEgNTU1LCBVU3QtSWROcjog
REUgODExIDExOQ0KPiA5NDANCj4NCj4NCj4NCj4NCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNo
cmljaHQtLS0tLQ0KPiBWb246IFNpbW9uIE1hcmNoaSA8c2ltYXJrQHNpbWFyay5jYT4NCj4gR2Vz
ZW5kZXQ6IERpZW5zdGFnLCAyNC4gT2t0b2JlciAyMDIzIDIwOjUyDQo+IEFuOiBTZWlkbCwgQXJv
biA8YXJvbi5zZWlkbEB6ZWlzcy5jb20+OyBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnDQo+IEJl
dHJlZmY6IFJlOiBbbHR0bmctZGV2XSBEZWJ1Z2dpbmcgTGliYXJpZXMgaW4gQmFiZWx0cmFjZSAy
DQo+DQo+IE9uIDEwLzI0LzIzIDExOjUyLCBTZWlkbCwgQXJvbiB2aWEgbHR0bmctZGV2IHdyb3Rl
Og0KPiA+IEhlbGxvIGd1eXMsDQo+ID4gSSdtIGN1cnJlbnRseSBhIHN0dWRlbnQgYXQgdGhlIGNv
bXBhbnkgQ2FybCBaZWlzcyBpbiBPYmVya29jaGVuIEdlcm1hbnkuIEknZCBsaWtlIHRvIHRyYWNl
IHRoZSBLZXJuZWwgZnJvbSBvdXIgQ01NLUNvbnRyb2xsZXIgd2l0aCBDVEYgYW5kIGNvbnZlcnQg
aXQgdG8gcGxhaW4gdGV4dCwgbGlrZSBCYWJlbHRyYWNlIDIgZG9lcy4gVG8gdW5kZXJzdGFuZCBo
b3cgQmFiZWx0cmFjZSAyIHdvcmtzIHdpdGggQ1RGLCBJIGRlYnVnIHRoZSBjb2RlLg0KPg0KPiBI
aSBBcm9uLA0KPiA6dw0KPg0KPiA+DQo+ID4NCj4gPiBIb3dldmVyIHdoZW4gSSB0cnkgdG8gc3Rl
cCBpbnRvIGEgZnVuY3Rpb24gd2hpY2ggaXMgaW5jbHVkZWQgdmlhIHRoZSBleHRlcm4gQmFiZWx0
cmFjZSAyIGxpYnJhcnkgKGUuZy4gKmJ0X2dyYXBoX3J1bihjdHguZ3JhcGgpKiBpbiBncmFwaC5j
KSwgdGhlIEdOVSBDb21waWxlciBzdGVwcyBvdmVyIHRoZSBmdW5jdGlvbiBhbmQgSSdtIHVuYWJs
ZSB0byBsb29rIGludG8gdGhpcyBmdW5jdGlvbi4NCj4gPg0KPiA+DQo+ID4NCj4gPiBJIGZpZ3Vy
ZWQsIGl0IGlzIGJlY2F1c2UgdGhlIERlYnVnZ2VyIGNhbm5vdCBmaW5kIHRoZSBEZWJ1ZyBTeW1i
b2xzIGV2ZW4gdGhvdWdoIEkgY29tcGlsZSBldmVyeXRoaW5nIHdpdGggRGVidWctU3ltYm9scyBh
bmQgbm8gY29tcGlsZXIgb3B0aW1pemF0aW9uLg0KPiA+DQo+ID4gSSBjb25maWd1cmUgdGhlIE1h
a2VmaWxlIGFzIGZvbGxvd3M6DQo+ID4NCj4gPg0KPiA+DQo+ID4gQkFCRUxUUkFDRV9ERVZfTU9E
RT0xIEJBQkVMVFJBQ0VfTUlOSU1BTF9MT0dfTEVWRUw9VFJBQ0UNCj4gPiBCQUJFTFRSQUNFX0RF
QlVHX01PREU9MSBDRkxBR1M9Jy1nIC1PMCcgQ1BQRkxBR1M9Jy1nIC1PMCcNCj4gPiBMREZMQUdT
PSctZyAtTzAnIC4vY29uZmlndXJlDQo+DQo+IFlvdSBwcm9iYWJseSBtZWFuIENYWEZMQUdTLCBu
b3QgQ1BQRkxBR1MuICBDWFhGTEFHUyBhcmUgZmxhZ3MgdG8gYmUgcGFzc2VkIHRvIHRoZSBDKysg
Y29tcGlsZXIsIENQUEZMQUdTIGFyZSBmbGFncyB0byBiZSBwYXNzZWQgdG8gdGhlIHByZXByb2Nl
c3Nvci4gIEl0J3MgcHJvYmFibHkgZ29pbmcgdG8gd29yayBhbnl3YXksIHNpbmNlIHByZXByb2Nl
c3NvciBmbGFncyBhcmUgcGFzc2VkIHdoZW4gY29tcGlsaW5nLCBidXQgSSB3YW50ZWQgdG8gcG9p
bnQgaXQgb3V0IGJlY2F1c2UgaXQgbG9va3MgbGlrZSBhIG1pc3Rha2UuDQo+DQo+ID4NCj4gPg0K
PiA+DQo+ID4gRm9yIHRlc3QgcHVycG9zZXMsIEkgaW1wbGVtZW50ZWQgdGhlIGZ1bmN0aW9uICpi
dF9ncmFwaF9ydW4oTlVMTCkgKmluc2lkZSBhIG5ldyBwcm9qZWN0IHRvIGNoZWNrLCBpZiBJIGNv
dWxkIHN0ZXAgaW50byB0aGUgZnVuY3Rpb24gd2l0aCBteSBkZWJ1Z2dlciwgb3Igd2hldGhlciBp
dCBpcyBhIGdlbmVyYWwgcHJvYmxlbSB3aXRoIG15IG1hY2hpbmUuDQo+ID4NCj4gPiBUaGF0IGFj
dHVhbGx5IHdvcmtlZCBhbmQgSSB3YXMgYWJsZSB0byBzdGVwIGludG8gdGhlIGZ1bmN0aW9uLCBi
dXQgbm90IHdpdGggdGhlIG5vcm1hbCBCYWJlbHRyYWNlIDIgcHJvamVjdC4NCj4gPg0KPiA+IE5v
bmUgb2YgbXkgY29sbGVhZ3VlcyBjb3VsZCBleHBsYWluIHRoaXMgYmVoYXZpb3IsIHNvIG15IHF1
ZXN0aW9uIG5vdyBpcywgaG93IGRvIHlvdSBndXlzIGRlYnVnIHRoZSBjb2RlPyBJcyB0aGVyZSBh
IGRpZmZlcmVudCB3YXkgeW91IGRlYnVnIHRoZXNlIGZ1bmN0aW9ucywgb3IgZG8gSSBjb25maWd1
cmUgbXkgcHJvamVjdCB0aGUgd3Jvbmcgd2F5Pw0KPiA+DQo+ID4NCj4gPg0KPiA+IEkgYXBwcmVj
aWF0ZSBpdCBpZiBzb21lb25lIGNhbiBoZWxwIG1lIGFuZCB0ZWxsIG1lIGhvdyB0byBjb25maWd1
cmUgdGhlIHByb2plY3Qgc28gdGhhdCB0aGUgY29kZSBpcyBkZWJ1Z2FibGUuDQo+DQo+IENhbiB5
b3UgcGxlYXNlIHNob3cgaG93IHlvdSBzdGFydCBhbmQgcnVuIGJhYmVsdHJhY2UyIHVuZGVyIEdE
Qj8NCj4NCj4gTXkgZ3Vlc3MgaXMgdGhhdCB5b3UgZW5kIHVwIHVzaW5nIGEgc3lzdGVtIHZlcnNp
b24gb2YgbGliYmFiZWx0cmFjZTIuc28gZnJvbSBhIHBhY2thZ2UgeW91IGluc3RhbGxlZCBvciBz
b21ldGhpbmcuICBJbiBHREIsIGRvICJpbmZvIHNoYXJlZCIgYW5kIHNlZSB3aGF0IHRoZSBsaWJi
YWJlbHRyYWNlMi5zbyBsaW5lIGxvb2tzIGxpa2UuICBJdCBzaG91bGQgYmUgbGlrZSB0aGlzLCB3
aXRoIGEgcGF0aCBpbiB5b3VyIGJ1aWxkIGRpcmVjdG9yeS4gIFRoZXJlIHNob3VsZCBiZSBubyBh
c3RlcmlzayBpbmRpY2F0aW5nIHRoYXQgdGhlIGRlYnVnIGluZm8gaXMgbWlzc2luZy4NCj4NCj4g
ICAgIDB4MDAwMDdmZmZmNzVhODdmMCAgMHgwMDAwN2ZmZmY3NmY1OTkwICBZZXMgICAgICAgICAv
aG9tZS9zbWFyY2hpL2J1aWxkL2JhYmVsdHJhY2Uvc3JjL2xpYi8ubGlicy9saWJiYWJlbHRyYWNl
Mi5zby4wDQo+DQo+IFNpbmNlIHdlIGFyZSB1c2luZyBsaWJ0b29sLCB0aGUgc3JjL2NsaS9iYWJl
bHRyYWNlMiBmaWxlIGlzIGFjdHVhbGx5IGENCj4gbGlidG9vbCBzY3JpcHQgdGhhdCBzZXRzIHVw
IHRoZSByaWdodCBlbnZpcm9ubWVudCAoTERfTElCUkFSWV9QQVRIIGFuZA0KPiBzdHVmZikgZm9y
IHJ1bm5pbmcgdGhlIHJlYWwgYmFiZWx0cmFjZTIgYmluYXJ5IChmb3VuZCBhdA0KPiBzcmMvY2xp
Ly5saWJzL2JhYmVsdHJhY2UyKSBkaXJlY3RseSBpbiB0aGUgYnVpbGQgdHJlZS4gIFRoZSBwcm9w
ZXIgd2F5IHRvIGRlYnVnIGl0IGlzIHdpdGggdGhlIGxpYnRvb2wgd3JhcHBlcjoNCj4NCj4gICAg
ICQgbGlidG9vbCAtLW1vZGU9ZXhlY3V0ZSBnZGIgLXEgLS1hcmdzIHNyYy9jbGkvYmFiZWx0cmFj
ZTIgL2hvbWUvc21hcmNoaS9zcmMvYmFiZWx0cmFjZS90ZXN0cy9kYXRhL2N0Zi10cmFjZXMvMS9z
dWNjZWVkL3NlcXVlbmNlDQo+ICAgICBSZWFkaW5nIHN5bWJvbHMgZnJvbSAvaG9tZS9zbWFyY2hp
L2J1aWxkL2JhYmVsdHJhY2Uvc3JjL2NsaS8ubGlicy9iYWJlbHRyYWNlMi4uLg0KPiAgICAgKGdk
YikgYiBidF9ncmFwaF9ydW4NCj4gICAgIEZ1bmN0aW9uICJidF9ncmFwaF9ydW4iIG5vdCBkZWZp
bmVkLg0KPiAgICAgTWFrZSBicmVha3BvaW50IHBlbmRpbmcgb24gZnV0dXJlIHNoYXJlZCBsaWJy
YXJ5IGxvYWQ/ICh5IG9yIFtuXSkgeQ0KPiAgICAgQnJlYWtwb2ludCAxIChidF9ncmFwaF9ydW4p
IHBlbmRpbmcuDQo+ICAgICAoZ2RiKSByDQo+ICAgICBTdGFydGluZyBwcm9ncmFtOiAvaG9tZS9z
bWFyY2hpL2J1aWxkL2JhYmVsdHJhY2Uvc3JjL2NsaS8ubGlicy9iYWJlbHRyYWNlMiAvaG9tZS9z
bWFyY2hpL3NyYy9iYWJlbHRyYWNlL3Rlc3RzL2RhdGEvY3RmLXRyYWNlcy8xL3N1Y2NlZWQvc2Vx
dWVuY2UNCj4gICAgIFtUaHJlYWQgZGVidWdnaW5nIHVzaW5nIGxpYnRocmVhZF9kYiBlbmFibGVk
XQ0KPiAgICAgVXNpbmcgaG9zdCBsaWJ0aHJlYWRfZGIgbGlicmFyeSAiL2xpYi94ODZfNjQtbGlu
dXgtZ251L2xpYnRocmVhZF9kYi5zby4xIi4NCj4NCj4gICAgIEJyZWFrcG9pbnQgMSwgYnRfZ3Jh
cGhfcnVuIChncmFwaD0weDYxMjAwMDAwMjVjMCkgYXQgL2hvbWUvc21hcmNoaS9zcmMvYmFiZWx0
cmFjZS9zcmMvbGliL2dyYXBoL2dyYXBoLmM6NjgzDQo+ICAgICA2ODMgICAgICAgICAgICAgQlRf
QVNTRVJUX1BSRV9OT19FUlJPUigpOw0KPg0KPiBTZWU6DQo+IGh0dHBzOi8vd3d3Ly4NCj4gZ251
Lm9yZyUyRnNvZnR3YXJlJTJGbGlidG9vbCUyRm1hbnVhbCUyRmh0bWxfbm9kZSUyRkRlYnVnZ2lu
Zy1leGVjdXRhYg0KPiBsZXMuaHRtbCZkYXRhPTA1JTdDMDElN0MlN0M0M2Y3MjQ3YTQ5MmU0OWYy
MDQ0ZTA4ZGJkNTY5ZjM0OCU3QzI4MDQyMjQ0DQo+IGJiNTE0Y2Q2ODAzNDc3NzZmYTM3MDNlOCU3
QzAlN0MwJTdDNjM4MzM4NDIzMjYzODY3MDI5JTdDVW5rbm93biU3Q1RXRnANCj4gYkdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbg0KPiAwJTNEJTdDMzAwMCU3QyU3QyU3QyZzZGF0YT1tTHFuWGE2MEVKWnU5VFRXaWxnc1N3
bUxkTHlHa3ZsWWU2RkJ5QTZ4VWtvDQo+ICUzRCZyZXNlcnZlZD0wDQo+DQo+IFNpbW9uDQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGx0dG5nLWRl
diBtYWlsaW5nIGxpc3QNCj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZw0KPiBodHRwczovL2xp
c3QvDQo+IHMubHR0bmcub3JnJTJGY2dpLWJpbiUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmx0dG5n
LWRldiZkYXRhPTA1JTdDMDElN0MNCj4gJTdDNDNmNzI0N2E0OTJlNDlmMjA0NGUwOGRiZDU2OWYz
NDglN0MyODA0MjI0NGJiNTE0Y2Q2ODAzNDc3NzZmYTM3MDNlOA0KPiAlN0MwJTdDMCU3QzYzODMz
ODQyMzI2Mzg2NzAyOSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3DQo+
IE1EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAw
MCU3QyU3QyU3QyZzZGENCj4gdGE9NHlST0JobFBtaEpuUk1OMzBOcFVoSzNhN21MSWJrJTJCJTJC
blBIaW5oRUY4N1UlM0QmcmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMu
bHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5m
by9sdHRuZy1kZXYK
