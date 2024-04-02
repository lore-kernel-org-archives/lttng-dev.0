Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46591CD1284
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Apr 2024 18:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712083076;
	bh=8Kq5UE2KFABScb32ymvlwlpkugWuC0OkjGqfftAuToI=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=OSumUO4K3ZV81deZurgf+Fj6r3EgpI0tpdKXsw199JtHFKOqzy6Tlzk7S3UKQ/X4w
	 GpeGRMqAUuxkg1JEoYpJYQV1UJ2UOJPxBHjrx1rxw+OFInlV/OPM/g4RfvnIuqaRRY
	 eqvd1X4OstPuFUXYvwBxjX+WC8sOsWWoaUn8GLFaudU8SuFgQIdEdpiE4dsDEgdcKR
	 hVRmUkEdxkyntneBznGPVmwKcLmq2erJaUVsvI+dHDVamF2DYt7JZSLP8CZ4m8oGJf
	 dzbgo1UNn6L57e7UFN6sqnp0Yj8XnWyR3yEbjnrZTS2yWVkjp1TWoy8vtdI+lUGDG5
	 guveBslALHFpQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V8GpW2jwKz2ZZg;
	Tue,  2 Apr 2024 14:37:55 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2095.outbound.protection.outlook.com [40.107.115.95])
 by lists.lttng.org (Postfix) with ESMTPS id 4V8GpT5lGXz2ZZd
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2024 14:37:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwHTtxC/2armFrNRw5rXoMPWzvVqv7+0aWvNDUCCuIDyFXBCI/6KUl0OUpDGzGoL/9cvjOMhMoGM9K89xx4PzrIvELVmXjA5jCa8QTL9EmwDupDYmZ03UmrH6GqqcD8Qyp1eie5kzyH0g8r/Xf29snz36zirs7HDMJZTF1kO30W+f/jKcLU84NThFjYQAhkNRoBKLsImTGCHo9KjE72uwcKTEbD6oD1LHS9WI/LUYlAC1e9CdoIKvwqOkMAbGzKUuO9wowrBfECtA8onhTCWT0TZqykhvFH2z+tTCB629zLyzoJOh0zTUZRn0ncc/9mJligZSnGFp2/OHE3UGwd8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFri25uQiQQIdwzjE0V4toX8juDbr8b4ks4niY/Lm74=;
 b=ihLS8D8rH1Vyr/HH/vyClNG9N5Qch738Io2IXh+JLzTF21OZg/DH9ftLLDYaUMNltVNiLJm0qJUA+ETBIdwvektBN3JLlZX672YIOpU0tCqxrDkMXyIFNES+cGYjFgs4jlJHALDbIFTSNyGYj0pnCOJQ7lcZNjML0DovfmMiTRAFQhb9i89qFmxz+EM4Rco5vN1FH4MwqEgwhTb7WpbnW1yq5f3sS49cndwXN5NFdxlQtNnXwiIXSU8jZfKg+sYg0J8kjm+kLwIqXjf1XfvKZ0GZaDIhAjViQRuGDfHeDfWqspB++h3liTO/EIIVQGMs9mk+H5MAwLj5SfVQYY0+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YQBPR0101MB9694.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 18:37:51 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 18:37:51 +0000
Date: Tue, 2 Apr 2024 14:37:48 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <ZgxQfOwkgLXG9oMN@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0413.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::28) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YQBPR0101MB9694:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8HSc/oSS9EMfUMDNnZTFNvZZjjAC4CJD/COTRu4UobVzHkDaqxZs425n5ziGF3RBQ5NW7pzYLEoZGU+epLNT3QFt4fuMpoyzbW6IybJjOEYAUyQHm5X35LggBh+5CjsEcb3TotKQJ8F20CMUG4h7Vd1jNoZjLPtHH3EubDAwTbHG0Bdtw2j7F71XPdOS8TIU6Dg2VQAy8pObE8Qr20bpZ2C2LEGc+1sABKQVYNftGu7vvHHIevdHaVtT8dn2wPxnQrICVDCSz59DTQe7XoxnOHJ82e6nebUq238qtuVvqJRbuPXLK+JGGr2SDhk7KSdULsFaLbfwDI6QDTATSWgokBlE53IELG6zPSGLthXp1pr7T6fGeFCaDIJlOvySCG16qIvjNC4zXkPfG1Hhh/oWi4MClKJi7NWkeiUe72LSIZ/UM9t78Flx9+rlVArt51pd17aq8iu0Gl4D35PMrpgarV61Mvt7Dc2GQofjgKZAqkRDEiI70UrRN6biGkcUY6hCk9cMPAOCLnqSrrCGo2CEWUYRpzjwSwE2uxHvQM7/UgwVIkJtFAPprPFn2m1zec+vdqFZ2sddyTrj+/W95SIpkDm1O0JAlv/a8VlgWxcXaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?uCDgaJ2K90ffdIVFPEL3bIkWDje0T/zaR66Y3UPQgH1LDV6M102KONXwlw?=
 =?iso-8859-1?Q?uHqq0R8pzvQJHqFFnprUe8V51V510XPmwyGXNFYbkp6Js3Q2yavrJI2Nvh?=
 =?iso-8859-1?Q?1jfUS6eyvF7TTCalVm/SMn5Hwyx9Ny+12IeN+zc09NpBNrRYLNnv3EhB74?=
 =?iso-8859-1?Q?O2xjn0mfRBbrTxB+i4OTre1UKyBKybESJeJpb0GOVSaxmJQ/bbMJT+hbEl?=
 =?iso-8859-1?Q?ImKc/l+EbyeKBobzzgN+R78LnFuPpBJDyYP4LzrLcwqt0xk3qDOWY/n5LD?=
 =?iso-8859-1?Q?Q8QvJqoxIbjmrFgpKXXrUMgi5c6kYdsIYNUI+5P3y6xrYv+9dstXOtiemx?=
 =?iso-8859-1?Q?ivzhPjfMfuW5R4T5/2Nl5UOGD27INMym13NWnzgXfalGck0NDilAc9Iyqg?=
 =?iso-8859-1?Q?Urq+HmgaCyaUFQy3NjQ3nUOIS82UuBWTcnp+sYRRUDXQlfKjhOkEQMJovg?=
 =?iso-8859-1?Q?I9IXZ+/lRXO9t+Gkm9VtQXw9uMdCs2EjyM/Qx1HQKu/3FRTdszvSbcMppF?=
 =?iso-8859-1?Q?FNy5+ehuqMrwDP2aiziOHTM18emPbPW9pBtQrJofg1yzQew+qkLkXNs9cR?=
 =?iso-8859-1?Q?Ko0OrfXD3XaVL2z6eU6FcVu8q85zqe5vGDzROO4FyB+NRN+F6v7rD8wL7R?=
 =?iso-8859-1?Q?C+k7++IZvMpH1IiI27feW8FiES/VhWrK2A9LYTqPyPuUk96zwzQ1OkJyBe?=
 =?iso-8859-1?Q?zuSY1U9IkzjVa2VHOwx/T45ReTjAd7/LhWmXwWeT/g+2IZcKtX1n33TSFY?=
 =?iso-8859-1?Q?wkMa4X1C7AeVRXuywRc0dvMbRWfHrm/Jv7+EW8oT4C42yn3LwlUOm+fjAl?=
 =?iso-8859-1?Q?0zYiCcaH/TSF5ZTydnhE8M/zdyl2LmZT5RVlNIx6yIzWTW7NToSYw6+UDm?=
 =?iso-8859-1?Q?E5ZuOAM5DuD7LMvVfSytteFT6jqtD5dTOGPK047O6AO9ZGMXq+tV3n2kv8?=
 =?iso-8859-1?Q?BgDDc0x5K4hPBRsNaCK/XlMgX+muPIDzA2eZYVORU31/w7fP0PoeaL5PU+?=
 =?iso-8859-1?Q?lfDG3evFAx8invXXx1yh7UJ51ADmwNPB7rSWtuDPwJyIbrQ0ujtQ8d+K9/?=
 =?iso-8859-1?Q?USXumM8cttLDxJlbzGhAhnH3YD2gDzg2U4yOmCLFyEp4Y2Zm4w821zSH1w?=
 =?iso-8859-1?Q?gBqiH2v2rSt/rNmA5RZ2QTkZKlyo0GlGAxtFSUwDUtP9jmlyQAF7BlZxFJ?=
 =?iso-8859-1?Q?hqaVbtzvV4i4KyD7Tt3VC8zv1qJksgb7QhBhOoSK6OzPkzh6z+A6+1YanV?=
 =?iso-8859-1?Q?Yzzbs2w2ahVFLePfgdPLrNbwdHvpGM5krRNuk8znHTcWG1YvwjvkSnDZ/b?=
 =?iso-8859-1?Q?lVwqSrxo0Lkm7tGSWwMbrQNuB7HxWALzZP6zVVsPVNLKCxj64c6dxbahFy?=
 =?iso-8859-1?Q?Cu5QS4Nv0IrtwPfdCi0msgVXR37ZulSTnS1XJxSzhUJfq57ULNAoA/gXCt?=
 =?iso-8859-1?Q?e7Z3oACA6XMi/xCQAXRnPeLTMBzOUl7Upe1oWC3cfWzSLbjXYiTWQ5rIu+?=
 =?iso-8859-1?Q?qLtFZWvr1wyW8yascer198nVSV8vpf1qYPyKCNagXLqc9PxiE4AEL/pHO/?=
 =?iso-8859-1?Q?6cBnZljPv/1AJ0FtVqeeZaAySyrM6C9r67O3PR+EAVqrgsnWQgAn8jHh/Z?=
 =?iso-8859-1?Q?Aks5IgFh1qjByEmgXmYhC9S4uY+7cmP2s7?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0891def-2519-43f1-5859-08dc53440050
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:37:50.9371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NiPQwXe3OBy/s68rGLy/iG88/E6+XCJIVGWa30AoMmwHxTB8oj4HsYJNKPTupePSiGpSx9dgdfDlSLI4Zw2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9694
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E12?=
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

We have released the twelfth bug-fix release of LTTng-tools 2.13 - Nordicit=
=E9.
This release addresses a number of issues listed below.

2024-03-28 lttng-tools 2.13.12 (Respect Your Cat Day)
	* Fix: baddr-statedump: use $(LIBTOOL) --mode=3Dexecute
	* Fix: relayd: live client not notified of inactive streams
	* Fix: relayd: live: dispose of zombie viewer metadata stream
	* tests: Fix typo in tests/regression/kernel/test_ns_contexts
	* Fix: sessiond: freeze on channel creation on restart
	* common: move utils_create_lock_file to its own file
	* tests: tools/clear/test_ust wait for specific test app pid
	* Fix: sessiond: crash when sending data_pending to an active session
	* Tests: fix: list_triggers_cli: kallsyms contains prefixed symbols
	* License: common: error_query: fix typo in SPDX specifier

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.12.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.12.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
