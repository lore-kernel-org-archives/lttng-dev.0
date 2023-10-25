Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C3C0032E
	for <lttng-dev@archiver.kernel.org>; Wed, 25 Oct 2023 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698218972;
	bh=opKoOcGHUdGcFI6l2Bz1pj9hp+1r6XmGLgtZe9L2UyQ=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=G85UIVkViID8qh/403ie3kH2Jwzow3HHmv9u6LFUruBidobioeyYVBB0QiXO2n483
	 Br5o0dCfVDO3RbO36uJ+pNdchuqTU9y4mHWy0JvWlPgWhUl1XXUg4clHcrZNS+dxnu
	 1F/1cnTkdR26ll5bHV4pCSB4sPYTmlcCaoA2rIt9LEE5SCBcOq5VpuSH54HmUrkPU3
	 KOLJoLO3xiI9ICsmcT19ROWcuVrbnxWVxFl3xLElVE9TznOuyxWuGvEk8Vm5fdleYD
	 lA6h4j0M7H3i4z+UwMfkFMmmcPsdrcHGE5K4Yf0Z9K9YeGf+8JUewcpPtX7C+AbNAT
	 obKaj3j//CZ7w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SFgY76pPCz8W9;
	Wed, 25 Oct 2023 03:29:31 -0400 (EDT)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on2116.outbound.protection.outlook.com [40.107.6.116])
 by lists.lttng.org (Postfix) with ESMTPS id 4SFgY64trtz8FC
 for <lttng-dev@lists.lttng.org>; Wed, 25 Oct 2023 03:29:30 -0400 (EDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dghn08lXT7/2wd0ZibPvwd8hbPHZpxW7h9fq3auDmRGPRcLNyiwtmySMMCaxVkJylladni+kg3gB2uDwBhd3JNgE+oy1cpOug0nY+NtfDBoiy7o/C/SwDYzbmBy5CWypuau+gBSB2W8J8OU6KGSqUviFmg2YI6n562OEJCwEEUBSKgFK+CPFlwTX6zYNN10O5+fZ1kb4IjKUcdpxw6HxYYJHzioadjmeNJ8TjoSXynexfMEr8JYG4dyP8vBs7VzZq91UVwvDzu9G+3AdNKVsfvrHfoAQu4H+nVzM71w8JaW8CUhek3QNWfaDuAVmkmJkhqUeLwnz77z0sivV0VcwsA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S07r20jCIaNlhC3pb7BsED9f3raAhmLDWHYQgoi+js0=;
 b=S4bAbTf5ffCXHYiBYcC/90Lga5ZaIkyXzMfCO6H7aSTqH1xNbAH6LhxcFbSdAQ4DpgyW6pgTnJd2oLeGa6NHB7YCqyqq3tryhTU97k5q0zzPeFTKw0anKJMpu4hKuADEGJQ7hOiVSaRLAeBB9qepHzBQgav/6JfQlnla8PupoeSbvF9aD6FrOajDohswLcOcfWhDnPKDaoFbRgWPHLopw2jvCXhC84VPWd+VvDfW1FiroKWrnfB83dJdKp6WijAF0kS4xto72TxlKjHfC4OIfRafOLkEWiWy47oilwp9w2I34qUcvnPOdFBL6EnqG0fcUE0RfoR7g42bthzGVvnKQA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.17.168) smtp.rcpttodomain=lists.lttng.org smtp.mailfrom=zeiss.com;
 dmarc=pass (p=quarantine sp=quarantine pct=25) action=none
 header.from=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=zeiss.com] dkim=[1,1,header.d=zeiss.com]
 dmarc=[1,1,header.from=zeiss.com])
Received: from DU2PR04CA0244.eurprd04.prod.outlook.com (2603:10a6:10:28e::9)
 by DB9P190MB2010.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:29:28 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::41) by DU2PR04CA0244.outlook.office365.com
 (2603:10a6:10:28e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 07:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.17.168)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Pass (protection.outlook.com: domain of zeiss.com designates
 104.47.17.168 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.17.168; helo=EUR05-VI1-obe.outbound.protection.outlook.com;
 pr=C
Received: from jegw2.zeiss.com (3.126.247.145) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 07:29:28 +0000
Received: from ip-10-25-10-142 (localhost [127.0.0.1])
 by jegw2.zeiss.com (Postfix) with UTF8SMTP id 3FFF41B58CB;
 Wed, 25 Oct 2023 09:29:28 +0200 (CEST)
Received: from kag06088vm017.zeiss.com (kag06088vm017 [10.25.10.199])
 by kag06088vm012.zeiss.org (Postfix) with UTF8SMTPS id 264461B58BC;
 Wed, 25 Oct 2023 09:29:28 +0200 (CEST)
Received: from ip-10-25-10-199 (localhost [127.0.0.1])
 by kag06088vm017.zeiss.com (Postfix) with UTF8SMTP id 20E1832DBDC;
 Wed, 25 Oct 2023 09:29:28 +0200 (CEST)
Received: from kag06088vm014.zeiss.com (kag06088vm014.zeiss.com [10.25.10.164])
 by kag06088vm017.zeiss.com (Postfix) with ESMTPS id 1497A32DB77;
 Wed, 25 Oct 2023 09:29:28 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by kag06088vm014.zeiss.com (Postfix) with ESMTPS id 0A41A3E992;
 Wed, 25 Oct 2023 09:29:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYC0X2tXxQ/iw6T2Pjc4Hvk4rZwSDDr0TiQ8+L7gzQXCOyLvp6xi3RDzIlJudZLkARB7PJP23t2vV3I8/F5+pJBpPtnelW1xOLxX3ZkbkRWfMYtl5y2hia4+qJCubY1PI+zWN4t6vXcTgykg6L6yq4V/tfUMR58/RKjeab3WgTzast2oHUxyn01Wm5ORfqNFhJUEw+dC5w3liMY/5E3uC89hvFNTdvC8tBTdUMUb0pgN4Kd8QRF8bSRLsuvARNyjG9VU+vSIEubwe1QPpXSLOQnDrMD62xjKfbeIC7oBA8JiJaPidgoGUXdt9pzqM/IYbF7t6g+e+tHdIWiFP39wJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S07r20jCIaNlhC3pb7BsED9f3raAhmLDWHYQgoi+js0=;
 b=Kh160ZsIlE52wjplYop+qckc+r9FA9Ke6RRxRxgqtm+Alq33WwCwXYXmWPF3W/mN8u7uLzuVWbI7ewslezYKgpiFywU9Fliq5U4exkj5D5iSy0vkKMLYRL1MVE9Y8r1UYkd+7DF4pXjNq/0X1cIxiauccOTBIQVEWr3E7cu+ZLf3EIPP/jNEoJnAMYkdhTy4Y8iN4ByLpkfArQ1d14aTKO+lnaXxjOe5b9HRWZdrUJKc70rjdpSSR4pXwGoMYZ3HQnduIjut834/d65FG07ZKmqGqB8wAgZc/UCm9cyMLm7YFPF6nluLplX9Vhn9I9yPXMwDTsM2si+zwqa+4aYLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:265::21)
 by AM9P190MB1524.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3eb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:29:26 +0000
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::9f17:efb:5e43:a093]) by AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::9f17:efb:5e43:a093%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 07:29:26 +0000
To: Simon Marchi <simark@simark.ca>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Debugging Libaries in Babeltrace 2
Thread-Index: AdoGkgHE+igf3/rqSLKp4/pt3elO9QAGR3QAABp26bA=
Date: Wed, 25 Oct 2023 07:29:26 +0000
Message-ID: <AM9P190MB1075EE7CA033D45006FCDB0D88DEA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
References: <AM9P190MB107537176AB808CA2F55AA2488DFA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
 <f0ca6352-ee2e-4943-8375-a228557eb49c@simark.ca>
In-Reply-To: <f0ca6352-ee2e-4943-8375-a228557eb49c@simark.ca>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeiss.com;
x-ms-traffictypediagnostic: AM9P190MB1075:EE_|AM9P190MB1524:EE_|DU6PEPF0000A7E2:EE_|DB9P190MB2010:EE_
X-MS-Office365-Filtering-Correlation-Id: f6eb0a7b-6170-4ce5-14f5-08dbd52c1f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yPw0egiqEQSMDMl1I8jWHEdSnh+zYZkHMAqPZXQHthtJnw0M/ihOZpNISdK570VL/B90iGkqQKrHXmWAIyygvox9WjATN4GGVEVAWfgJ9vkcVwapSaXH/jpZfnLLEluh9hxan0MoZipr5seZMHLvI6aXJKzeJ/tF9NLObfjGek292A2iE6OJUYC1d02AFIPmyqTdOpQWGPCuFFBrwQcXp0y8um0aoUuSjS1XbqHZBgzHue3HzO/Fu2bdmIdTnH1Eq5RmGmMG2EcC2wtgw0+hp6U69NqfZ+A0SStLz+UNIFywu6DvBmF1Oy5q4JzOpKQr1EjxO+QcqtLZAw2W+A+JV8FlXd8KrcQiXbmTSgEO4GNn2nCX3vt1i8pS0CxrFUDiHKMoqtV8K5PCYaAt0jhtDgbneni+fVbgobluGolwi6o+WhVJVwcYUb6udnaBudB5C8al0gmPn5NOGdqwn2PPkzGbEOEGZgUXgQOzmlYYqXdX579jvz9IZ+96jhsnrCnv6yQ8aOzTMLbfiseCyiKsRbIIgSLFGbDATQYrPFQRnEr0arJ1ezT9xjyUSJmsC0NbU7RneunouWqhSgbM5By0jYreY7b0OH+zSVPCNUz4FPI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9P190MB1075.EURP190.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(86362001)(2906002)(38100700002)(41300700001)(66446008)(66476007)(122000001)(316002)(76116006)(82960400001)(66946007)(66556008)(71200400001)(478600001)(110136005)(6506007)(7696005)(53546011)(966005)(45080400002)(66574015)(83380400001)(9686003)(64756008)(33656002)(5660300002)(52536014)(15974865002)(8676002)(8936002)(26005)(38070700009);
 DIR:OUT; SFP:1102; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1524
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.17.168];
 domain=EUR05-VI1-obe.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[104.47.17.168];
 domain=EUR05-VI1-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 653898a4-99fe-48aa-a9f1-08dbd52c1e69
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRJkK0zTbiXPSR1MmAn+sIeYLGxDVWnDVd8VFc14gqdJ3Ms/sT/EomvwRlyxOB1UXD4ovbNrz0dm/rzYjhE4Ev38tDkAmKVMkzffXfdi/PQ8aFavDE6uo+URQNtY7LAxm0qA3Xf76iKiCzMcvI12y5QEVtoD/WbhwBcI6RPOTmAWAltw9rqXUa5kIu4l/H43NBnwkoLYptm54WtskIYJYE1MZTvbcIpyOPUfGqp+2rrW3Pe4AKNWHX2COx4RJWZzw+o15E/TRt0xpq9mbJk5J4QY9+MKwZPU4KHi1Dj2W44Rn6GyYAz+2Ro3ukkVKnWzrPn16TCY4PY9LgYMPydArE3nkrFWvWBMr0eJ85ufORVpCgsl0KrQHpF+C4qtzic95+atkJN1xBxZyoUhmdyWie3PUDub0SiiXtHSnZYycHzN+eG9WM+TIUJhYokZ0MWhkMv4MXO2ZHF8R7gWnCl7XhoCzt0JGEXFjDTLqGZsobYMtxrNXATcn5g4nGH0OMq3OTkmyroyAFA/9vSyzn5XaB5sdXeWMX9qH1EaLT3t3QqXpy14NRoNh4QcSsINk0YyjvjDn9BCQ8aqccnJrUqL9vpFKr21sFJMvk/sbhev+pjrYq0NQRaI0u59Ve+c1u23oYHKfS6+kTaEsZUQQM/1yVArj8A9+LMCcy5f6T4jccMoFxgP8qkxWJratSN7Pwq/PoPl1LFigRhY1wFb5Acx9GyaGI8DCy52QrKH7Fp0EkFabdD7dqbjBZGpKLWLESjn7XsJpKQiRAYVqFRl+2v4+5rOXxScxMbld3gAQf1lWT7l3Sjf4qLMUf5z7sep6mk16UKqZdQMfbyn8sIYuty4qRQvqTVI9LO96vBnsfXcAToj0L6tjogaSrgxt8xk9j7EVLwdBy/WujDBlIWIS2TRAOlHx1DmMwWvzsCWevkJXV8=
X-Forefront-Antispam-Report: CIP:3.126.247.145; CTRY:AT; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EUR05-VI1-obe.outbound.protection.outlook.com;
 PTR:mail-vi1eur05lp2168.outbound.protection.outlook.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(7636003)(32850700003)(156005)(36860700001)(82740400003)(47076005)(83380400001)(82960400001)(9686003)(336012)(66574015)(26005)(6506007)(7696005)(53546011)(316002)(966005)(478600001)(110136005)(70206006)(86362001)(5660300002)(70586007)(8676002)(52536014)(8936002)(41300700001)(2906002)(33656002)(55016003)(40460700003)(40480700001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:29:28.5451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eb0a7b-6170-4ce5-14f5-08dbd52c1f77
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8; Ip=[3.126.247.145];
 Helo=[jegw2.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB2010
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Simon,
Thanks for your quick answer!
I run GDB like this:
gdb --args ./babeltrace2 /home/aron/Schreibtisch/kernel4 -o text
(I'm in src/cli/.libs)

I don't think I've ever installed a System Version of babeltrace2, so it is=
 really weird that GDB uses following library:

0x00007ffff7f36f00  0x00007ffff7f89749  Yes (*)     /lib/x86_64-linux-gnu/l=
ibbabeltrace2.so.0
(*): Shared library is missing debugging information.

And you're absolutely right! That is the reason why I can't debug it.
Is there a way to specify the library path? Because even with the libtool w=
rapper, GDB uses the release version of libbabeltrace2.so.0.

You're helping me a lot, thank you! :)
I hope you have a great day!

Kind regards,
Aron
__________
Aron Seidl
DH-Student IT Education

Carl Zeiss AG
Carl-Zeiss-Strasse 22
73447 Oberkochen, Deutschland

aron.seidl@zeiss.com
http://www.zeiss.de/
__________
Carl Zeiss AG
Sitz der Gesellschaft: Oberkochen, Deutschland
Vorsitzender des Aufsichtsrates: Dr. Michael Bolle
Vorstand: Dr. Karl Lamprecht (Vorsitzender),
Susan-Stefanie Breitkopf, Sven Hermann, Dr. Christian M=FCller,
Andreas Pecher, Dr. Jochen Peter, Dr. Markus Weber
Amtsgericht Ulm, HRB 501 555, USt-IdNr: DE 811 119 940




-----Urspr=FCngliche Nachricht-----
Von: Simon Marchi <simark@simark.ca>
Gesendet: Dienstag, 24. Oktober 2023 20:52
An: Seidl, Aron <aron.seidl@zeiss.com>; lttng-dev@lists.lttng.org
Betreff: Re: [lttng-dev] Debugging Libaries in Babeltrace 2

On 10/24/23 11:52, Seidl, Aron via lttng-dev wrote:
> Hello guys,
> I'm currently a student at the company Carl Zeiss in Oberkochen Germany. =
I'd like to trace the Kernel from our CMM-Controller with CTF and convert i=
t to plain text, like Babeltrace 2 does. To understand how Babeltrace 2 wor=
ks with CTF, I debug the code.

Hi Aron,
:w

>
>
> However when I try to step into a function which is included via the exte=
rn Babeltrace 2 library (e.g. *bt_graph_run(ctx.graph)* in graph.c), the GN=
U Compiler steps over the function and I'm unable to look into this functio=
n.
>
>
>
> I figured, it is because the Debugger cannot find the Debug Symbols even =
though I compile everything with Debug-Symbols and no compiler optimization.
>
> I configure the Makefile as follows:
>
>
>
> BABELTRACE_DEV_MODE=3D1 BABELTRACE_MINIMAL_LOG_LEVEL=3DTRACE
> BABELTRACE_DEBUG_MODE=3D1 CFLAGS=3D'-g -O0' CPPFLAGS=3D'-g -O0' LDFLAGS=
=3D'-g
> -O0' ./configure

You probably mean CXXFLAGS, not CPPFLAGS.  CXXFLAGS are flags to be passed =
to the C++ compiler, CPPFLAGS are flags to be passed to the preprocessor.  =
It's probably going to work anyway, since preprocessor flags are passed whe=
n compiling, but I wanted to point it out because it looks like a mistake.

>
>
>
> For test purposes, I implemented the function *bt_graph_run(NULL) *inside=
 a new project to check, if I could step into the function with my debugger=
, or whether it is a general problem with my machine.
>
> That actually worked and I was able to step into the function, but not wi=
th the normal Babeltrace 2 project.
>
> None of my colleagues could explain this behavior, so my question now is,=
 how do you guys debug the code? Is there a different way you debug these f=
unctions, or do I configure my project the wrong way?
>
>
>
> I appreciate it if someone can help me and tell me how to configure the p=
roject so that the code is debugable.

Can you please show how you start and run babeltrace2 under GDB?

My guess is that you end up using a system version of libbabeltrace2.so fro=
m a package you installed or something.  In GDB, do "info shared" and see w=
hat the libbabeltrace2.so line looks like.  It should be like this, with a =
path in your build directory.  There should be no asterisk indicating that =
the debug info is missing.

    0x00007ffff75a87f0  0x00007ffff76f5990  Yes         /home/smarchi/build=
/babeltrace/src/lib/.libs/libbabeltrace2.so.0

Since we are using libtool, the src/cli/babeltrace2 file is actually a libt=
ool script that sets up the right environment (LD_LIBRARY_PATH and
stuff) for running the real babeltrace2 binary (found at
src/cli/.libs/babeltrace2) directly in the build tree.  The proper way to d=
ebug it is with the libtool wrapper:

    $ libtool --mode=3Dexecute gdb -q --args src/cli/babeltrace2 /home/smar=
chi/src/babeltrace/tests/data/ctf-traces/1/succeed/sequence
    Reading symbols from /home/smarchi/build/babeltrace/src/cli/.libs/babel=
trace2...
    (gdb) b bt_graph_run
    Function "bt_graph_run" not defined.
    Make breakpoint pending on future shared library load? (y or [n]) y
    Breakpoint 1 (bt_graph_run) pending.
    (gdb) r
    Starting program: /home/smarchi/build/babeltrace/src/cli/.libs/babeltra=
ce2 /home/smarchi/src/babeltrace/tests/data/ctf-traces/1/succeed/sequence
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.=
1".

    Breakpoint 1, bt_graph_run (graph=3D0x6120000025c0) at /home/smarchi/sr=
c/babeltrace/src/lib/graph/graph.c:683
    683             BT_ASSERT_PRE_NO_ERROR();

See: https://www.gnu.org/software/libtool/manual/html_node/Debugging-execut=
ables.html

Simon
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
