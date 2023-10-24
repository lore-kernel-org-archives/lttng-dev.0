Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB2EC07545
	for <lttng-dev@archiver.kernel.org>; Tue, 24 Oct 2023 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1698162752;
	bh=JouS7E8fiCP/naCNWjg0oScHCtRX29SsPI+WDExjUeg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=laTqgraH30MhA96zstsl/2B3W/xxJaiwww7hyR6cfKZb+j4n3fHhKqmoeeQut/sUs
	 f9O+q5vTLFiqTLq2cPh5/HtlQbf9ERwfryBec+fQBHtof4E9vIqNUELIX/Sw6H+DTV
	 pPnczZongxC3qy5snNFM2OV0RJXL9Ud5lH3C6pFd3yck3a6VtkUG6nbZGkNganY2oQ
	 lwIcIaBdmfzDrMW/tYKXfJwkaHLFbBoBuhNuv5KQUbsMTxVoWqdgH+9nEeHqNa0lgw
	 KLx+tOE7TwPQUnuOunt993Zg9T7HZO1YkzDsxMjQoRa45JtPiq4y8F8TSM4NgAAoyw
	 EJ+hCrTdhsdvw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SFGm00CVMz8Jm;
	Tue, 24 Oct 2023 11:52:32 -0400 (EDT)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
 by lists.lttng.org (Postfix) with ESMTPS id 4SFGlx5w84z8Jl
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 11:52:29 -0400 (EDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=juBaJbwH8gifKr6ouG2gXvdCwhtnFkKlfkxOH8ukgGDMqsSGW/mrdj78yiVrTQcQA6T+WFe92JDo8cpWXUt73X+5zOtCfXZ/vGXKevVhj9tQR407Q+goR92vcH+DwObsLHrrFdVp9FtZzDSJNukRP3j+SyDyPXH164L8yWSjkcvcQ6/eKnVOoC45qqyRVb2CL9ERjrpZhCuHf1dSNITCYTMmdZ9Xbrt5dUr/F4XNN14c+372nFoVi1p80NL+uLF+NU/5QwVU6xpASLuBw8SGw4RhmIIJZQztcpAuOwF9l7943fHyTo1muzhaH8onwyWbIHWUM0pAcoaAQPzujAfECQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeVqOxKqFLobumQOhH0Ih7aCRRfnv72SC8lvSbHEPB0=;
 b=VbKMH07h8zFU7wUiTsdciXjDenYdjphjSAGnhyZ2LgGSq3TtKwdlE1DB6UZQcjFKyjyndIXQOzLcstCP87TR3fdUzrgozeluAc0QLYiNsQ1MECZXbWGn75hsnCbQoNXJT7pe8Ztpqm8Dff8LS7PMcW7QsujQyKlY4Cdtn/v7pa50gBVvTj1H1FSjYnA5vk7YUl9VnI/mKTqY9ki6ftxXJS63/RFdoyVXD90yLIovAI4KVcDZh2JkEpjictG+stpjw1sT85KIsr2Y0eo51BEnX3ZIGKjjDyZblcaNmi8x6dpb5yZdHKJT2bKUHBFDblUhAIbDr4DPDi8SMkR4tgjM+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.11.233) smtp.rcpttodomain=lists.lttng.org smtp.mailfrom=zeiss.com;
 dmarc=pass (p=quarantine sp=quarantine pct=25) action=none
 header.from=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=zeiss.com] dkim=[1,1,header.d=zeiss.com]
 dmarc=[1,1,header.from=zeiss.com])
Received: from DB3PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:8::49) by
 AM0P190MB0690.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:19e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.31; Tue, 24 Oct 2023 15:52:27 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::f7) by DB3PR08CA0036.outlook.office365.com
 (2603:10a6:8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 15:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.11.233)
 smtp.mailfrom=zeiss.com; dkim=pass (signature was verified)
 header.d=zeiss.onmicrosoft.com;dmarc=pass action=none header.from=zeiss.com;
Received-SPF: Pass (protection.outlook.com: domain of zeiss.com designates
 104.47.11.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.11.233; helo=EUR02-AM0-obe.outbound.protection.outlook.com;
 pr=C
Received: from jegw1.zeiss.com (18.192.202.217) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 15:52:27 +0000
Received: from ip-10-25-10-14 (localhost [127.0.0.1])
 by jegw1.zeiss.com (Postfix) with UTF8SMTP id BFC481B5884
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 17:52:26 +0200 (CEST)
Received: from kag06088vm016.zeiss.com (kag06088vm016 [10.25.10.115])
 by kag06088vm011.zeiss.org (Postfix) with UTF8SMTPS id AD1591B5A2F
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 17:52:26 +0200 (CEST)
Received: from ip-10-25-10-115 (localhost [127.0.0.1])
 by kag06088vm016.zeiss.com (Postfix) with UTF8SMTP id AA7471B6554
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 17:52:26 +0200 (CEST)
Received: from kag06088vm013.zeiss.com (kag06088vm013.zeiss.com [10.25.10.9])
 by kag06088vm016.zeiss.com (Postfix) with ESMTPS id 9D7F31B64F8
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 17:52:26 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2233.outbound.protection.outlook.com [104.47.11.233])
 by kag06088vm013.zeiss.com (Postfix) with ESMTPS id 92BA2BBABA
 for <lttng-dev@lists.lttng.org>; Tue, 24 Oct 2023 17:52:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+KH9fM5waSlO6dD286nYH1zlt4XFwgF7MVLuKv7JinRqi8RBgryJjd/Hkm4aBOkyq+8712CQWFJqM0kGSSUQRfeTRVm5DFOODzQfT9CrRHJUpHpT65TYKMucknVqPuVzTYJnyYBluGsRE6VWD1vglyuxWj7KJ8xOMV++6PfqgU3P2xpO9L+KKiVPBDjmwSiEhiT+k8kdz201vqlwp4Nb0C7b+eMZ6vS715R00araB0l69uFGNMZPFqdd9Wu9BK8Wl6RIRRFG6cDEyBq5JtqQr0X2Z3jRhLZvLqQxliNYoPayPZZslmQIym8EACtXfwzJEMQnunL30d6oWGFOTDr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeVqOxKqFLobumQOhH0Ih7aCRRfnv72SC8lvSbHEPB0=;
 b=oGsDKTqG5ZgYQwNH/j3FblDVqwFl9FHVje742tyk41+BnuO44fRfBKKQKb2SmduXx5xXSpSWfJEZTnETIPLia6sIPcxOuLjxx4D/lLZ+HQKOK1R1NE8Hp27njJsCRoLP4T7u+mhdY5EuqOC6gc2gmbP7A1eyPG7is66JwtEmUVRtKMjrc64FiHnM17Ea76g0jW9HPS3789YVQNCuY4tEWAtWfxJn3nq7onHl8W8PWH8hudQhS7sSOJWRbGBXjXntZ+oP2AeOwPxP/ohzdHmNe8zLF8v8zbzF8ZNE+td4mNxnWi1p13CHvD3UPcqEbk2ntA/OzLj1RMluM0lLnQGyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeiss.com; dmarc=pass action=none header.from=zeiss.com;
 dkim=pass header.d=zeiss.com; arc=none
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:265::21)
 by DB9P190MB1130.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Tue, 24 Oct
 2023 15:52:25 +0000
Received: from AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::9f17:efb:5e43:a093]) by AM9P190MB1075.EURP190.PROD.OUTLOOK.COM
 ([fe80::9f17:efb:5e43:a093%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 15:52:24 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Debugging Libaries in Babeltrace 2
Thread-Index: AdoGkgHE+igf3/rqSLKp4/pt3elO9Q==
Date: Tue, 24 Oct 2023 15:52:24 +0000
Message-ID: <AM9P190MB107537176AB808CA2F55AA2488DFA@AM9P190MB1075.EURP190.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeiss.com;
x-ms-traffictypediagnostic: AM9P190MB1075:EE_|DB9P190MB1130:EE_|DU6PEPF00009527:EE_|AM0P190MB0690:EE_
X-MS-Office365-Filtering-Correlation-Id: 349fe396-9583-4870-7faa-08dbd4a938df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GVB48wJZY1zHyhMDCKyIwaoxBA6tECE7PF75ZBetHZcSYqpQndm59OSuS7P4dE0dULMtObCZkNJNU0iSPkga3kQlVhFl5Wrfl/+/9Jxx77zkPO8R1lOVKImpjwBZzzYefBGb1tF9ELU8OfPCmK05T76NZzMYgWpdSF/+LjZPq/drIfxUral/DQZDZt8dCTP7XLr5G7BwS9CWEBWUTNYKWkoKFiOBX4sPXalI/8ujBg2H0nLWQcg0XoYiEcHKQVsfYdmqRTfAyVweJkpL4SkgkROCEuC2PMUADjBVM2hlj6xbrxDXPsUrSnyxRgVtF+LDWNqQf90PtzS3AFb4LTV6PvBZmnJ9SDDBoug0/D2d6Uyn++jZtdufYvlbTRaoQGA1Tp0YccV2LygK/Pa/+YTyLmwrNOiTzELmVyUwXLba6qm7OqLGhg2RNbXYFN/go3OoMdFJpI622lQMkVyJxapLs+oBp6M9vrsLAC1eL1ah+ZnL8zUYgAmNoC201otludrQSlzjw+yJKBtlGPajd5J6soP5LPAatn0Rsw3DFRc190rUGPFdHJkP/OeeNCVR73fJaGP2IdiI7dcviT2tL+G0TANi5/KaVqSASZ5ZIV3dq4k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9P190MB1075.EURP190.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38070700009)(33656002)(55016003)(6506007)(38100700002)(64756008)(66556008)(82960400001)(86362001)(122000001)(66446008)(166002)(316002)(76116006)(9686003)(66946007)(26005)(6916009)(71200400001)(8676002)(7696005)(8936002)(66476007)(2906002)(478600001)(5660300002)(52536014)(41300700001);
 DIR:OUT; SFP:1102; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1130
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.11.233];
 domain=EUR02-AM0-obe.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender: ip=[104.47.11.233];
 domain=EUR02-AM0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b682db94-22f0-4e26-2b52-08dbd4a93784
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gyePwvaL++PUjOJTLDhAjphQr+/C+N3PSR3soiMrgmiCI6W1tJXDeNxEFm1KhAAokD29N+CKsluawny4vI8RmGuFaToweZFLUUEaJGtf/tPe9jCXUX/VT/MoJWQUrwoRAUIWvNb5aNPiOIIjyU6rUdifAdEwwiBNkF5z+QTX73hCDlG4QR321oH/eoWnYzfiYBUoiJ1AoLPcksodv5GiMXFVweRukeJBOiT7/JU+NYnwc2y74sXt04H7JFoWxul50krLB+T0ZFNNRRefo8D0F60cu/uJ0nGAN4uTclPuFIxJXT/qSelgOoKhGoZ/J3aGOinKHZd2YszduCLRN9hifICtxq4Uw7IDV0D1vKlzSAX/lZXafSkWWVYRC5pMz7wq6mroCOxlaMbR/mE4VZhljSjXrn3Q3f7FL4omj8PCluFJfmDQ94QxwJloNg+zRyM71QM2Mc0YlPImu3Ps53oevAsY8JIQy3P/UZfEaOC7kYmrteotFfnYIHq2G8YhW0uwaovcXpUDGKH3llTqQz9fvXJYr9hE8/4bJCEpF53AgCnuCE+3Zytf0G1lMt3d5EliRiTKlL97fMrcJMwuK1wAH5sco8t0KXkh09QHPk8eQdZd6gW+C3+ezYxFtuB4sVDf9aYjZL7y90LZUbVuNIQ/RrAdtkY8zvK+k8stbQsOc84Ei/aiG93gmUCiFl6gxPd0fPvRbjWAgSMoV6tjbzo+FzLC+Mt+RCuNNBxInqoTxOdOm6zgoP4iYfVjJ/CyOiXyCFzq+z1PGlIUFo/OjrBMe2oOS2DEK+hXlyh7qNGkSDZCI50O7tDzARm0BNFO4/a0gSmGt0/EPYBzcHyNRFM5siQv+4+80T7wKoYXaa7ZLxKcQRW4pA3PrjoffSxPX6MYvTlG9GcSve6BThkQvJYV7I6A+3oosOwpk/uXI37umY=
X-Forefront-Antispam-Report: CIP:18.192.202.217; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EUR02-AM0-obe.outbound.protection.outlook.com;
 PTR:mail-am0eur02lp2233.outbound.protection.outlook.com; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(55016003)(40460700003)(15974865002)(36860700001)(2906002)(8936002)(52536014)(8676002)(82740400003)(47076005)(82960400001)(7636003)(166002)(336012)(26005)(156005)(32850700003)(40480700001)(33656002)(7696005)(9686003)(5660300002)(6916009)(6506007)(316002)(478600001)(70206006)(70586007)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: zeiss.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:52:27.1008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349fe396-9583-4870-7faa-08dbd4a938df
X-MS-Exchange-CrossTenant-Id: 28042244-bb51-4cd6-8034-7776fa3703e8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28042244-bb51-4cd6-8034-7776fa3703e8; Ip=[18.192.202.217];
 Helo=[jegw1.zeiss.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0690
Subject: [lttng-dev] Debugging Libaries in Babeltrace 2
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
Content-Type: multipart/mixed; boundary="===============2560743779092673958=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2560743779092673958==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_AM9P190MB107537176AB808CA2F55AA2488DFAAM9P190MB1075EURP_"

--_000_AM9P190MB107537176AB808CA2F55AA2488DFAAM9P190MB1075EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello guys,
I'm currently a student at the company Carl Zeiss in Oberkochen Germany. I'=
d like to trace the Kernel from our CMM-Controller with CTF and convert it =
to plain text, like Babeltrace 2 does. To understand how Babeltrace 2 works=
 with CTF, I debug the code.

However when I try to step into a function which is included via the extern=
 Babeltrace 2 library (e.g. bt_graph_run(ctx.graph) in graph.c), the GNU Co=
mpiler steps over the function and I'm unable to look into this function.

I figured, it is because the Debugger cannot find the Debug Symbols even th=
ough I compile everything with Debug-Symbols and no compiler optimization.
I configure the Makefile as follows:

BABELTRACE_DEV_MODE=3D1 BABELTRACE_MINIMAL_LOG_LEVEL=3DTRACE BABELTRACE_DEB=
UG_MODE=3D1 CFLAGS=3D'-g -O0' CPPFLAGS=3D'-g -O0' LDFLAGS=3D'-g -O0' ./conf=
igure

For test purposes, I implemented the function bt_graph_run(NULL) inside a n=
ew project to check, if I could step into the function with my debugger, or=
 whether it is a general problem with my machine.
That actually worked and I was able to step into the function, but not with=
 the normal Babeltrace 2 project.
None of my colleagues could explain this behavior, so my question now is, h=
ow do you guys debug the code? Is there a different way you debug these fun=
ctions, or do I configure my project the wrong way?

I appreciate it if someone can help me and tell me how to configure the pro=
ject so that the code is debugable.

Sincerely,
Aron

__________
Aron Seidl
DH-Student IT Education

Carl Zeiss AG
Carl-Zeiss-Strasse 22
73447 Oberkochen, Deutschland

aron.seidl@zeiss.com<mailto:aron.seidl@zeiss.com>
www.zeiss.de<http://www.zeiss.de/>
__________
Carl Zeiss AG
Sitz der Gesellschaft: Oberkochen, Deutschland
Vorsitzender des Aufsichtsrates: Dr. Michael Bolle
Vorstand: Dr. Karl Lamprecht (Vorsitzender),
Susan-Stefanie Breitkopf, Sven Hermann, Dr. Christian M=FCller,
Andreas Pecher, Dr. Jochen Peter, Dr. Markus Weber
Amtsgericht Ulm, HRB 501 555, USt-IdNr: DE 811 119 940



--_000_AM9P190MB107537176AB808CA2F55AA2488DFAAM9P190MB1075EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:ArialMT;
	panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Hello guys,<br>
I&#8217;m currently a student at the company Carl Zeiss in Oberkochen Germa=
ny. I&#8217;d like to trace the Kernel from our CMM-Controller with CTF and=
 convert it to plain text, like Babeltrace 2 does. To understand how Babelt=
race 2 works with CTF, I debug the code.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">However when I try to step into a func=
tion which is included via the extern Babeltrace 2 library (e.g.
<b>bt_graph_run(ctx.graph)</b> in graph.c), the GNU Compiler steps over the=
 function and I&#8217;m unable to look into this function.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">I figured, it is because the Debugger =
cannot find the Debug Symbols even though I compile everything with Debug-S=
ymbols and no compiler optimization.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">I configure the Makefile as follows:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">BABELTRACE_DEV_MODE=3D1 BABELTRACE_MIN=
IMAL_LOG_LEVEL=3DTRACE BABELTRACE_DEBUG_MODE=3D1 CFLAGS=3D'-g -O0' CPPFLAGS=
=3D'-g -O0' LDFLAGS=3D'-g -O0' ./configure<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">For test purposes, I implemented the f=
unction
<b>bt_graph_run(NULL) </b>inside a new project to check, if I could step in=
to the function with my debugger, or whether it is a general problem with m=
y machine.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">That actually worked and I was able to=
 step into the function, but not with the normal Babeltrace 2 project.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">None of my colleagues could explain th=
is behavior, so my question now is, how do you guys debug the code? Is ther=
e a different way you debug these functions, or
 do I configure my project the wrong way?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">I appreciate it if someone can help me=
 and tell me how to configure the project so that the code is debugable.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Sincerely,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif">Aron<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;text-autospace:none"><=
span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;ArialMT&quo=
t;,serif;color:black">__________</span><span lang=3D"EN-US"><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><b><span lang=3D"EN-US=
" style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:=
black">Aron Seidl</span></b><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:bla=
ck">DH-Student IT Education</span><span lang=3D"EN-US"><o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span lang=3D"EN-US" s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:bla=
ck">&nbsp;</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Carl Zeiss =
AG</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Carl-Zeiss-=
Strasse 22</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:black">73447 Oberk=
ochen, Deutschland</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><a href=3D"mailto:aron=
.seidl@zeiss.com"><span style=3D"color:#0563C1">aron.seidl@zeiss.com</span>=
</a><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><a href=3D"http://www.z=
eiss.de/"><span style=3D"color:#0563C1">www.zeiss.de</span></a></span><o:p>=
</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt;text-autospace:none"><=
span style=3D"font-size:10.0pt;font-family:&quot;ArialMT&quot;,serif;color:=
black">__________</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Carl Zeiss AG&nbsp;<=
/span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Sitz der Gesellschaf=
t: Oberkochen, Deutschland&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Vorsitzender des Auf=
sichtsrates: Dr. Michael Bolle&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Vorstand: Dr. Karl L=
amprecht (Vorsitzender),&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Susan-Stefanie Breit=
kopf, Sven Hermann, Dr. Christian M=FCller,<br>
Andreas Pecher, Dr. Jochen Peter, Dr. Markus Weber&nbsp;</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"vertical-align:baseline"><span style=3D"fon=
t-size:8.0pt;font-family:&quot;Arial&quot;,sans-serif">Amtsgericht Ulm, HRB=
 501 555, USt-IdNr: DE 811 119 940&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:8.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#979797">&nbsp;</sp=
an><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AM9P190MB107537176AB808CA2F55AA2488DFAAM9P190MB1075EURP_--

--===============2560743779092673958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2560743779092673958==--
