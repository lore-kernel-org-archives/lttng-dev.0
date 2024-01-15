Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EA9C3DA79
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Jan 2024 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1705333902;
	bh=jAM98AQmZRIc5DLbA9YEeyw01SRFtbfaVheThSEHIj8=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ts7sTryFlkA1tuZ5NhDY9OZt70M30jjdrXrRkCaXY/2cz1y+Fm8ybZ9cl1UXi3IKt
	 a1pLZcCX3kb7j7j51tB3qreHLu4WTA4sicYQgbNC4zsoYTOUp7ckCXRal8o8y1ebos
	 fH1fE1tUl/u1YtDFw6wPhtgnyz/yR1AiDVfih1EZmyTov+AfqAguouc2FO6PLId/xm
	 BGZONbzUF0ksHkf2Hr5SoQS/unIN1C8FZaHhqZHk5fa2Z11rlRywfC/SydPuRDalvC
	 EAHMWNjOVeVUE9TYC63FyM4HwXTE1oy7fxY/YCkyA+BDV6e2nuTeAX2cTk7tcRj2jJ
	 up1b7/C8ypVyA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TDGpj0ms3z1PN8;
	Mon, 15 Jan 2024 10:51:41 -0500 (EST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
 by lists.lttng.org (Postfix) with ESMTPS id 4TDBjF1H8xz1PL0
 for <lttng-dev@lists.lttng.org>; Mon, 15 Jan 2024 07:46:39 -0500 (EST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=F3BPnC8Bly2/lWl+Blxb008foVPUIIoc4aMmPy3IGCilicuK6sKUwzEk7lZLLAaljdhu3Ud9aAmJwjcor7pgAS79V6xMz8mDhDT7lnEn6nCBVGRbYZ+UlJyfAoy3Azy6vaQxirS13cX8eZEqKG7hbNbmwDHaJGrYYVV8+xMfsQ3FTkc5R+I1BimApxAilK1KCgORx2XJNaVZQ3wpmqavgjsYdlHOp79LsDd2l6bmox4hB4/EFKWViBN10UkipaB2oFN2BFP89X3lRTWX6IV8aL22GbZHncVf9VBceubHQtQHsfNI8K9HPzH2LhqfxSh0ZB5JK+g4ZMYYtFgFLO+Hdw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBJenNloKlkzwckILze+VH5foCZgURdf1hG0SQjj3iw=;
 b=ijz9/eBPg/ezaqxYAd6kHC30HLNZUWy6fSXnr9jVBNETa1Ir5WhcaKGIYNJtLzYlVijtnOkzcLzl2/yJky6NchCgPPGmUzR7yqeuR1ghas/x2WTR35jnSKR8sBiZlgZigs2+Ql7hP1BNZ746zA48HGsANZUMf8ZsHiWjcmkwdqE1cTpnJG2qDIC8nzOy8OtofDrkcLPkN/oqBxoF9ypGMDVBbpBv8vxmbkyUinjqOmDZ5zmuFMD3YQSEW+tjxseR1RYRdDnNCSuKKY4QDE5E1yq7D8BeOq2lfmk64M3GxSE5XPmlQNdeUfKiJ053X0Azrh4hacQQRnVh49GsAPNlKA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.lttng.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AM6P193CA0050.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::27)
 by AM9PR08MB6130.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Mon, 15 Jan
 2024 12:46:30 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:209:8e:cafe::28) by AM6P193CA0050.outlook.office365.com
 (2603:10a6:209:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Mon, 15 Jan 2024 12:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 15 Jan 2024 12:46:30 +0000
Received: ("Tessian outbound c4f080b252bb:v228");
 Mon, 15 Jan 2024 12:46:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9719bef573382f32
X-CR-MTA-TID: 64aa7808
Received: from 7c34503fa36d.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D390F6D4-9681-40C4-9E01-4909C23E4FDF.1; 
 Mon, 15 Jan 2024 12:46:23 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7c34503fa36d.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 15 Jan 2024 12:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjCIE6oGLK2LXDmbwgq5BUTNTg+C8h5f/5Pz0stv2B5h+EfG7FdEPysLIJA4fnliNF+usSJ41UG267E514PmyhXUSOdYkT4RC8+DHxFRImESUf6hOTNzquOGNvryH5MTSFHh3dTnpfM4yv8Z1IM3NM+By6A+df0w4JbX60NZvAOzYLRJ/EH/GG/r41R+I9Bo7TwAiFG/om44AZ+LYxhAHRCC8O/LTZY17xoSZ6aJ6ydqrsSch5tuF+tA/HI6AYpbf3t2kwcRAo6XyHFh5fOem+iWqNvD9/PVtFDYXhE6gNI4PfRSzEJITMy3NqehF8jUGskfIQygqQKqjEGsa5DhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBJenNloKlkzwckILze+VH5foCZgURdf1hG0SQjj3iw=;
 b=e4bp0NOEaApiOi8rQLPOpWQJkT4YxPDMohswDiPqdeIcJmhq2kSAZxjygWyGQRmF2tDBu4Oev/ulau9ElKUXrbHOL+ymNe0cac5LGAksxHO7nycTWpFaPYM+E0vELEbx+dMLMVXqBLfvfm5kcv7nz/iMBzlbdUgsqWqTT5BwA5fNxZuq4zDwdoHvVvWb1/yJgn6k1Q1pUc7WuyDxXWBN9bOAdWEZs5Y9ZeGZ8hMabUSB8jhgRFTL2/Jrs7ouk4yzrwQzq7M4CdQzgOiBSbXsOBQBwTI9Zm9oTCuAnuvn9K1jleBGXoCUhzTmZmUj2w7wtb5Wl+uB01KT1YVBuDUJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10361.eurprd08.prod.outlook.com (2603:10a6:20b:56d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 12:46:20 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::bc19:813c:34d3:758]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::bc19:813c:34d3:758%7]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 12:46:20 +0000
Date: Mon, 15 Jan 2024 12:46:05 +0000
To: Florian Weimer <fweimer@redhat.com>, gcc@gcc.gnu.org,
 libc-alpha@sourceware.org
Cc: Iain Sandoe <iain@sandoe.co.uk>, aburgess@redhat.com,
 lttng-dev@lists.lttng.org
Message-ID: <ZaUpDRmDTt8/apMh@arm.com>
References: <8734v1ieke.fsf@oldenburg.str.redhat.com>
Content-Disposition: inline
In-Reply-To: <8734v1ieke.fsf@oldenburg.str.redhat.com>
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB10361:EE_|AMS0EPF000001B4:EE_|AM9PR08MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 384b6ffc-e949-4e43-be27-08dc15c7ff0a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XhQsJjHSsvdm0cJkLI1A9K4t0Xnddeq30WECgs9aAfp9myMcc0+jEbOidDoc9PJAEkz7h13l4cj3P5xqZvIoi7u5XJySbTjTx5GsJe/zO/sgV/JmrqfDG97qHsPrSxt66ZhcFNkr3I7Vfcwr2AXzj+6qahOoCnDiFoBbThbSW66rxoIcw8uau85vCrCNWXF71nciPsU5YYdiMyRlJv2JXHa3wxadNL9cMA54EJm5bHGxLzvqOBW5NZx6Hd8TCEK2WaLit79mrjIIBgZyOIVxrlNMYk2bgdOG70ZIte2AsuR7AhKx/b/VIH2Oy84ugxGXEZ3QjoRmrqdYhGp//M4od20QRc/qik119BBstm/tkbKf3oRoZfodlw8ReNPEvsAQKmg7s2hDUXTkEwo/WvpSq2MmVBysl4Qwa3QlI3Zh6EBCmjZjXH80hUvOF3FSie3L56+qqcQGANKSWRI+J+qmDBOZG/8Pa8iecswXcK7aFkJkdTZV+gEleqKWBSnM2kX6jewSPgf6KO4HKWyXw77Z1naIf2J3LpO6hyFxgcJy6lKeAZs+eBPzmz8/bTmT8FxPgTbsIOxWf8cjTmmoG9Co/aUVESKb8JlrKhU9+2E8YBw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR08MB7179.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66899024)(2906002)(36756003)(6512007)(5660300002)(8676002)(41300700001)(6506007)(6486002)(8936002)(4326008)(478600001)(44832011)(6666004)(83380400001)(2616005)(26005)(86362001)(66946007)(66556008)(66476007)(38100700002)(316002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10361
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d72951d-bd5c-4fd8-c147-08dc15c7f900
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1GJDss7WBPjpfFrSn3fh6SWCo7T75rGMJrGGI+OZtNSJYNmNTMG/9h+Ea2Am1Sil5dCBTcAxSIbm8yzD0qxOykFrfJzt98/bfSKZVUK+O7ZObodMPB8L5dSuSlcPNGIQBzYAZaw/7deGcidx6WVMOZzBz4kB5RIGXpv1rl4cBEYdVNG21JLRVJVFnYurrCNPgQHeA9ctdMj0VRdwA8ViFdmx8Hfz313KRfmCJjBYFlHn7jK4q2e/WfViXB4868BpjXHWdP1d8koEcWzfugHnqe562oWPtrXXY3zHLpReoE9Fc73n/H4MXHT0B6ECB8mH/g46H9DMEKn6FL1OmSOTBCi5n03w8M1MzQwGwQd6RMfXTOBXh8wvTWv8ht9XQVZf+0BM8fBT4r5+eNvA6BewuOsl7Lv70LYv7F/mMeeulAf7LB5b5cYSWjWW+MVWeSOnPs6llpDJDD90WnSF7MQD28JAavuPSrCirr5nIW7Q3hu2NS4PmQ7E4wxIj94VJSotOrHwG/GMpWp+MJEA1+r8plUAiekNX7hTQtk6nAhFWjbj00XdmYFvhbHx97L0q1VFJgU0W3oIU+dZnI+GVkqpjmZgsWSk/r3sQsBHbvJ8QKUPZmvHbz+qO4c9w5boo7EIrfikJxYFahQfrl+JqEmrBfyTQd84/ThxBhMVkh+Ptikm97vnu5YjZ8fbVNrv8p00qJ1Longy64Zbgz0e4eyouvlhfu/50NF1wpJsmGmb60buMLdHjIzfzE7Q4BIJuGrnPwJWVgbC6korYfJRqTxsA==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(26005)(2616005)(336012)(6666004)(8676002)(36860700001)(44832011)(4326008)(5660300002)(8936002)(41300700001)(2906002)(478600001)(6486002)(6506007)(6512007)(70586007)(316002)(70206006)(86362001)(36756003)(81166007)(356005)(82740400003)(66899024)(40480700001)(40460700003)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 12:46:30.0555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384b6ffc-e949-4e43-be27-08dc15c7ff0a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6130
X-Mailman-Approved-At: Mon, 15 Jan 2024 10:51:39 -0500
Subject: Re: [lttng-dev] New TLS usage in libgcc_s.so.1, compatibility impact
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
From: Szabolcs Nagy via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

The 01/13/2024 13:49, Florian Weimer wrote:
> This commit
> 
> commit 8abddb187b33480d8827f44ec655f45734a1749d
> Author: Andrew Burgess <andrew.burgess@embecosm.com>
> Date:   Sat Aug 5 14:31:06 2023 +0200
> 
>     libgcc: support heap-based trampolines
>     
>     Add support for heap-based trampolines on x86_64-linux, aarch64-linux,
>     and x86_64-darwin. Implement the __builtin_nested_func_ptr_created and
>     __builtin_nested_func_ptr_deleted functions for these targets.
>     
>     Co-Authored-By: Maxim Blinov <maxim.blinov@embecosm.com>
>     Co-Authored-By: Iain Sandoe <iain@sandoe.co.uk>
>     Co-Authored-By: Francois-Xavier Coudert <fxcoudert@gcc.gnu.org>
> 
> added TLS usage to libgcc_s.so.1.  The way that libgcc_s is currently
> built, it ends up using a dynamic TLS variant on the Linux targets.
> This means that there is no up-front TLS allocation with glibc (but
> there would be one with musl).
> 
> There is still a compatibility impact because glibc assigns a TLS module
> ID upfront.  This seems to be what causes the
> ust/libc-wrapper/test_libc-wrapper test in lttng-tools to fail.  We end
> up with an infinite regress during process termination because
> libgcc_s.so.1 has been loaded, resulting in a DTV update.  When this
> happens, the bottom of the stack looks like this:
> 
> #4447 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
> #4448 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>     at ../include/rtld-malloc.h:50
> #4449 _dl_update_slotinfo (req_modid=3, new_gen=2) at ../elf/dl-tls.c:822
> #4450 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f2bfc0, 
>     gen=<optimized out>) at ../elf/dl-tls.c:916
> #4451 0x00007ffff7fddccc in __tls_get_addr ()
>     at ../sysdeps/x86_64/tls_get_addr.S:55
> #4452 0x00007ffff7f288f0 in free () from /lib64/liblttng-ust-libc-wrapper.so.1
> #4453 0x00007ffff7fdb142 in free (ptr=<optimized out>)
>     at ../include/rtld-malloc.h:50
> #4454 _dl_update_slotinfo (req_modid=2, new_gen=2) at ../elf/dl-tls.c:822
> #4455 0x00007ffff7fdb214 in update_get_addr (ti=0x7ffff7f39fa0, 
>     gen=<optimized out>) at ../elf/dl-tls.c:916
> #4456 0x00007ffff7fddccc in __tls_get_addr ()
>     at ../sysdeps/x86_64/tls_get_addr.S:55
> #4457 0x00007ffff7f36113 in lttng_ust_cancelstate_disable_push ()
>    from /lib64/liblttng-ust-common.so.1
> #4458 0x00007ffff7f4c2e8 in ust_lock_nocheck () from /lib64/liblttng-ust.so.1
> #4459 0x00007ffff7f5175a in lttng_ust_cleanup () from /lib64/liblttng-ust.so.1
> #4460 0x00007ffff7fca0f2 in _dl_call_fini (
>     closure_map=closure_map@entry=0x7ffff7fbe000) at dl-call_fini.c:43
> #4461 0x00007ffff7fce06e in _dl_fini () at dl-fini.c:114
> #4462 0x00007ffff7d82fe6 in __run_exit_handlers () from /lib64/libc.so.6
> 
> Cc:ing <lttng-dev@lists.lttng.org> for awareness.
> 
> The issue also requires a recent glibc with changes to DTV management:
> commit d2123d68275acc0f061e73d5f86ca504e0d5a344 ("elf: Fix slow tls
> access after dlopen [BZ #19924]").  If I understand things correctly,
> before this glibc change, we didn't deallocate the old DTV, so there was
> no call to the free function.

with 19924 fixed, after a dlopen or dlclose every thread updates
its dtv on the next dynamic tls access.

before that, dtv was only updated up to the generation of the
module being accessed for a particular tls access.

so hitting the free in the dtv update path is now more likely
but the free is not new, it was there before.

also note that this is unlikely to happen on aarch64 since
tlsdesc only does dynamic tls access after a 512byte static
tls reservation runs out.

> 
> On the glibc side, we should recommend that intercepting mallocs and its
> dependencies use initial-exec TLS because that kind of TLS does not use
> malloc.  If intercepting mallocs using dynamic TLS work at all, that's
> totally by accident, and was in the past helped by glibc bug 19924.  (I

right.

> don't think there is anything special about libgcc_s.so.1 that triggers
> the test failure above, it is just an object with dynamic TLS that is
> implicitly loaded via dlopen at the right stage of the test.)  In this
> particular case, we can also paper over the test failure in glibc by not
> call free at all because the argument is a null pointer:
> 
> diff --git a/elf/dl-tls.c b/elf/dl-tls.c
> index 7b3dd9ab60..14c71cbd06 100644
> --- a/elf/dl-tls.c
> +++ b/elf/dl-tls.c
> @@ -819,7 +819,8 @@ _dl_update_slotinfo (unsigned long int req_modid, size_t new_gen)
>  		 dtv entry free it.  Note: this is not AS-safe.  */
>  	      /* XXX Ideally we will at some point create a memory
>  		 pool.  */
> -	      free (dtv[modid].pointer.to_free);
> +	      if (dtv[modid].pointer.to_free != NULL)
> +		free (dtv[modid].pointer.to_free);
>  	      dtv[modid].pointer.val = TLS_DTV_UNALLOCATED;
>  	      dtv[modid].pointer.to_free = NULL;

can be done, but !=NULL is more likely since we do modid reuse
after dlclose.

there is also a realloc in dtv resizing which happens when more
than 16 modules with tls are loaded after thread creation
(DTV_SURPLUS).

i'm not sure if it's worth supporting malloc interposers that
only work sometimes.

> 
> As the comment hints, we shouldn't be using malloc for TLS memory at all
> because it is not AS-safe, but that's a long-term change.  This change
> seems rather specific to this particular test case failure because it
> relies on libgcc_s.so.1 never using TLS before it gets unloaded.
> 
> Regarding the libgcc_s side, I'm not sure if the TLS usage there should
> be considered a real problem, although I'm a bit nervous about it.
> However, the current implementation caches one page of trampolines past
> the outermost nested function pointer deallocation (otherwise creating
> one function pointer per thread in a loop would be really expensive).
> It looks to me that is never freed, so if the thread exits even with
> proper unwinding (e.g., on glibc with code compiled with -fexceptions),
> there is a memory leak.  Integration with glibc could avoid this issue,
> and also help with the longjmp problem, and fix setcontext/swapcontext,
> too.
> 
> Thanks,
> Florian
> 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
