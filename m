Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC169C04A6A
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Aug 2023 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692125142;
	bh=CR6dNJieMKY+1wu189bfP0cztTczuKijW4gEnb+BZ14=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=lOb2RyH0EgY2VPuTbDwNeANHp8mOuXlE8GahEt0PHnzYrZjDe250y+lWvF3BYhCyA
	 MiQH1ya8pSYjubvgCqkR5PiM7FFXlSpp5GTLQQqpDXusxlzl1ErW4DS+zb6LRzSqvh
	 3u3Qn9yFXi35KhEmNS/MXsPscA8scku+ijCebJ+Sb5AzBbScx/EN9XCYJ+vbcBXN6D
	 eqvVlO+LKna7icKM7EPhNuWLnQngOY/xb4rfSZUVjrw4kqtb82kNr/yyPOM/+D9cY9
	 4R0gMherjncR+j1S3Jkg0Znz52pGsZg0xm01uHnZA7pnSxvgHpRixKb2okxMUP/B7a
	 lTynoUc0vzQEA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RQKw56gD7z2Msy;
	Tue, 15 Aug 2023 14:45:41 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2064.outbound.protection.outlook.com [40.107.116.64])
 by lists.lttng.org (Postfix) with ESMTPS id 4RQKw42qmcz2Msw
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2023 14:45:40 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6kbsDhFPwi3QjoMCzaUWxuxJdzSc6xULsaXXxWq2BPLJkvC5gkIRdoM/gM0AfaPwW3RC6hUvNiM2MYfWaFTEM8tV0FbVh/wI4j7zEiB9ltX8Ohu0Y2N+ekQNk9bGtmhC+rFXgzSIrYAEieqdDFZWPkNcHmuyIT0WJpA8AcO8cuaaUtpg2eqaU8lVyQ1BRmblNduOO+ozuZT9zsdpY6fIsxK0PTZMV1kyijV9Mta0uxH7+EXYIlO8Iu6/qCUvz8f3PIeVjffE01tm5aENfHDUZqNZRI81yIclh6hHxYliJaGnlINlwM2luNdlVfZ89y/05RQhhMMasOE6ySBGtybCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1++cXGn9H+Zv8A9pEMs2XHHepE/MpiEsQ12TduZ6bw=;
 b=IAAGSZLHq1Vtp6KcTuxI+SGkAy1ik+jXarbbs65ViBX6DGa6pQgeGXHbnDrriQVThuiPUKffqxDzj6F/CLLF2+g1fd/T6vXyBKXaqyNyPjgmD2vCRBrBfuFdVATizZ3spsgeyIU79ikPmxcoMr5uZg6mmCANeGUob9DHYPWuXXjXZPNQ494xLeR2Matq5K1XStNiotV6cch4ogLSBCDJQqwXHKAgoeog5PdqLpDloYaDJ9LK+CkK57suKTMT51R3KqSGw8S0MPYvY1ZkorvoB8FPwihyMKi6hGaz17AHJSdMIt8CF/NTDnsv9+xyw5X40n5Dy0aGxM2yZZzMMPWAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB10307.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:af::10)
 by YT3PR01MB8484.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:79::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:45:38 +0000
Received: from YT2PR01MB10307.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bb56:cc13:4125:a953]) by YT2PR01MB10307.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bb56:cc13:4125:a953%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:45:38 +0000
To: "diamon-discuss@lists.linuxfoundation.org"
 <diamon-discuss@lists.linuxfoundation.org>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>, "tracecompass-dev@eclipse.org"
 <tracecompass-dev@eclipse.org>
Thread-Topic: CTF2-SPECRC-8.0: Common Trace Format version 2 release candidate
Thread-Index: AQHZz6hkMGPf9X1oaUydmtdm79iL5Q==
Date: Tue, 15 Aug 2023 18:45:38 +0000
Message-ID: <YT2PR01MB10307BDA9197DAA1E161B0F3DD314A@YT2PR01MB10307.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB10307:EE_|YT3PR01MB8484:EE_
x-ms-office365-filtering-correlation-id: c2359be9-68e9-411d-c828-08db9dbfd1bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FooktvrxQ/TvNBrDmpJlLEr7ngFEWmYyVjeF7gi5Ne/36A/wRv/8tw+Be5Gy65JnqmifLuPfwgHn66zDIPpNxx/L38i/s+rljTwLin4MPvuE3QtbzLplZGMIsPtbXwRHzww6T2RV4sYKari/Ed3xpoBXLHcm9djuwh5TOsY91jWMkLaDJcuXCbMZt4Q0su3cuc6nSpbsoVMrkbYieLeNmpYchGWoWRLmV+g+KM84rv4bHktZGKMjf4am7ODHKF379scGLS7/pdOKMJatDginiXwzVkQyJ0V7iHJnYyvn1Xa5PILqsBGBQTnGxSrMx9xBbcFAQphFBSusUKz7Eh7P4Jdoj3ZsJ5WtqCnWDNoVS3ONuJ9HhNU1lnlUONSppNYiJNTyBRkJOQYjd9yZ+AwAreWXQqNzic4O3266UTcxv7uJAK7K16AY/bs4e73w5rK4osgve6GjZlJkTXXp550jDIaasEEnxGivJCEor7vHwJCxvCDLFxAxvXsJ4NpphA0zgZjoRQFAjfBsy0C3ujbqNbL7EizTi1HiMYeYW/GONf/7cBfmygjKll+7VWAeRC0VJXg/AEiLjWswk2ZkJB/BfANRUArGBK12T+LLEWaSfkA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB10307.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39830400003)(366004)(346002)(376002)(1800799009)(186009)(451199024)(9686003)(26005)(66946007)(33656002)(7696005)(71200400001)(478600001)(558084003)(86362001)(66556008)(316002)(8936002)(52536014)(55016003)(5660300002)(8676002)(91956017)(66476007)(41300700001)(122000001)(110136005)(76116006)(2906002)(83380400001)(38100700002)(6506007)(66446008)(64756008)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8eKiGsp+D/ChjfEEoe9KxESKbHlQAMglCkAN9EHeCM62OmiuESg6AZI5XG?=
 =?iso-8859-1?Q?WKZLLqmCGrVEbtEgxC5/YNYCHSBrl9IiOMBvCZsLHZUOy3DIHNjyeVyTXN?=
 =?iso-8859-1?Q?QpOHUe6/ppRUzRfQpzOWuOZ2G15V42wp0htl0HWNj9iubMBcfRWhWrNvUQ?=
 =?iso-8859-1?Q?BUT0wj/p1CNog5LTxicU/6bmzXZ8NZ4ICdhz3SdrUqSK8ExvBnGwvl99oZ?=
 =?iso-8859-1?Q?rvsd6qmg8KtFTKO9nVehG+EqdOhjWxUlcZsTN5g0eU8xCfeLcZTGc5466V?=
 =?iso-8859-1?Q?Q8nfZzcLEIHS281C7oNaYaZ1n3j4O/MxEw5ksJV4ck3jN6f9xMNaME94V7?=
 =?iso-8859-1?Q?2czys8vvsR3jlwHrXl79yVv5zATfhWipQUsj5hNlKAm0H6CYn2MbKC1zIn?=
 =?iso-8859-1?Q?2UIAMmNK8c2sWJotP5CNrrG0rG2vToQ1lnW754zzCc4M8yj7w40JaaewJQ?=
 =?iso-8859-1?Q?GH0i4dyncpP7UmgiZjWfbsmUR/0sWhDrfLhnDOY8P18Ur0uxP9wlaBnEgF?=
 =?iso-8859-1?Q?c4A3uudwpO27lF8xs44RXxidwA2wYI4Co2PAgsZlbtN6Mae/5EKkCwLTeU?=
 =?iso-8859-1?Q?Xkh2YNOM/MRW2gj24gRozmKGU0rKY+fj0ndO61bywmkJfnsed4zHR8fNqG?=
 =?iso-8859-1?Q?41Y+Q2p/wM3GUYM3Kdt5AFhYAHhytG8VxOh5XDdJZPk/EzUjc0bCv9F6FC?=
 =?iso-8859-1?Q?C2PW+ZmPx5/F/6h3xLeEYOD9eXffJzLTPGbMFQBZswiIrD5vz7o6MAOcCL?=
 =?iso-8859-1?Q?W/6CfZPTFa4HWMiYUDpw8tUId432Hh8T2MXKC4GIUJ3X7WgCcMca54QWm0?=
 =?iso-8859-1?Q?FMESni6BGmKXV8PwLafGZUvKnSHIPueL53SEjaITb2m0Zi1ht31ascmdKe?=
 =?iso-8859-1?Q?kalAt3QgX9Je74soOKcII8sjGV/4U45b99tIWsf3oaZXX/b9FUUZZw/1vV?=
 =?iso-8859-1?Q?B2EHMYFtUo9ohrIdmbnXNGqgcGfJ03prvOEPoTzFxAi83L393dbW4F6ApK?=
 =?iso-8859-1?Q?Gc8XQkzRri3jskk7JYbxgEV41z0UXm4kDSAcqdIvnHrKYjroIzTxqwkrg8?=
 =?iso-8859-1?Q?pOoRlGoPEL+0nJMlizZ+XM54ox4Xpn/DGViOqEitBChPCkHna1H00Zg6kB?=
 =?iso-8859-1?Q?4zJHtuC/MCs2Tpk7DT9c3o57uk+DdwdyaNqnNQBufwS3ELi72QEI1T/EEg?=
 =?iso-8859-1?Q?pN310m0rAips/EgnrIWbG6upkYJ53m18AQVe6Bh0l4tAYl6hh1nQ6BC9P+?=
 =?iso-8859-1?Q?I79loUW1bcnx6iYygL25cICvHEWHiyHI6FmlIFqHp4EDopI6O6ZuE7ytrd?=
 =?iso-8859-1?Q?PJAVSZXlRUmJx6VfL0PCxnKIJDmsOwwBkqnV7VSMCZtyOcRMqSUqsTNBpU?=
 =?iso-8859-1?Q?YTtXnML3aW82tmtjzFxKn+u/MkNzow2Ea+MO9wwtPs5ph5zUqInxeWADSR?=
 =?iso-8859-1?Q?oU+dPLOxNi3keEyqhu1omr/agzIcFgHISQOd6gTAnG2ChfzgK0PdJ1TG7R?=
 =?iso-8859-1?Q?0UHOafGvU8p4hW58CZ3dimMqJkQvjA9ZO5+NqKyBO/zftoxbKot3Q7tsxB?=
 =?iso-8859-1?Q?4vdrY3V/jqlm/406FcgiUAbs+uQyRlkcABImb+PbrrGfy5i0Y2LBLMKDrI?=
 =?iso-8859-1?Q?iB+QACBjF+wytX37zcZWJm4TjGhGZVXydk?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10307.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2359be9-68e9-411d-c828-08db9dbfd1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 18:45:38.6201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHF3VPKgv7uNDXyx3EkecTNPM3P2u8okswwWvTLuYIWU7hHy05sOv9kEwaZa0F5ysQDK/G+p/b0ezEdjPw+ptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8484
Subject: [lttng-dev] CTF2-SPECRC-8.0: Common Trace Format version 2 release
 candidate
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

This is an update of the CTF 2 specification release candidate from
v7.0 to v8.0.

This document, named CTF2-SPECRC-8.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-8.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
