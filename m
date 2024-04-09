Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B1EC67861
	for <lttng-dev@archiver.kernel.org>; Tue,  9 Apr 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712683631;
	bh=YvHwYJPVz9F1b1TPaZigBS5nBwCUFLD7etKVr0CVp94=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=BYNSFnu45REJtaoXkf4WvyZKmzbdtIfG7seBLiLaDkjs+CsEMvj/bkgb90tyD1Vx9
	 aiZ/m4TvNDsTa9WzCP1wKv+RCPwO4cJpw5bozBYGFyZjuQe4N7YeJQE9f71UKh6i/r
	 Q7YIjrzMOaWYprfWs2F2nVyBst4TMlrYj2trLPskid9iXwswZhv/usbVlop2BPoN4e
	 eXjXiqh1uF9WmbTBsrN6KCIq9jGh9fxGtz31AMLp1EDyunnJa1ukwI3MPIuzf16a+4
	 IEABDuiXE6sx+uMV1R6vV5Bsoi0xg59qZThx55E4rvgnXTBM5C+Sy+h4nwqB4CqMrX
	 xZrTn1JPXcdXA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VDXvf38rdz2c7Z;
	Tue,  9 Apr 2024 13:27:10 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2115.outbound.protection.outlook.com [40.107.115.115])
 by lists.lttng.org (Postfix) with ESMTPS id 4VDXvZ5rz6z2c7X
 for <lttng-dev@lists.lttng.org>; Tue,  9 Apr 2024 13:27:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0qEKUqg+DeF72Swz4mpzoKQyydUGZbsGmnZlKz2meCvn5PWUOBale1/IisFINT8EoKtCiui0aKBQZAY64rCxi4+45zSepMfDNgz4pd48rDZo1CcQKxh+UoEEbROCCjNtvdGXXIdPOs+kZEErqTkuSir8C33Lq4GB3zzzRtIPso9QcuPTZgZDUiZu+eWjQsaVKrDRWH3La4w7lu0fhA7Y3I0Iwrm9b+RoVT9FfyOOOK0QH22WgBKdvHJ5Pwy0G/w84mCoqOnysXUfQj496bLrNK3oam03pocWb+Izek0TbGJKS53TeKNHvLD1OGrsMm6mjYlJNWpBz6NI2KaCwFLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKezckPMDZIapW6SQjFGGO5D4Whg2xB4lyanaRJvZNY=;
 b=cmAIJ0wxinhTJgzBpLlUfdLAxOVz/fCiIT5R0/qlA/JPDoDZsyZW4Sa22YscFbc7urq+Eh8i43W7FuHeXK/dWZovRvNxu6Uo+6WgwiZdW/TbPhdR3u5Lep/AhwSRn8p80Uj4s95jxr9MkRpmWWaCgIerzto+NMLji0EE1ymJoW6ozPo6IJGj1EZ6CvmIxyNXPYzeYTF8qygP98TBM6BSC6u3kIHU/PUBzbBZRR6f9ZLxlIJL6SUDbOJLfUCw7Ljfycpq4pzxkQX6Kwf/mDDWrVQKZ4/5swwpjxB22xronOrvzDSdodzQGBxqPuC9tnkHf9pRGAIQhyYZfTGUEMohuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT2PR01MB10291.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:af::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 17:27:04 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3%3]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 17:27:04 +0000
Date: Tue, 9 Apr 2024 13:27:02 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <ZhV6Zm4b_8mFS9qA@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::22) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT2PR01MB10291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJbwhMTPkqX0D7LazeMC2D0LNd5RcJ12VoC2Oi0z/bosLssTG6PiFUEl1cE3l68I8YAcHCQQh81VxgrlGjbwKj4akTa3LYhSvN87IJNHni+k/SURxP4XHH2JmQaVXUFFwoutgVquEfHICxhfDt8wqCZsNLk6K151fuddC3uNR1iAcVQOW8tdNmyO2TVwGZLB9hOu84zxPkltdsEZwrDp4Qk+fW0rZKHHaMddPDOdbYPX1k8l+qQMndRoCkRuyc/GrdRIaqoWPw3ZdA3GfwPzwYiVmkj4U5C4L8ZA24y32t3AEu1dbIKS3OMh3G1FvHuRbfJPiKLHFRTdqE0wRsYsEn5/reg4xQI1cJ3Hp/enC4R+WQBmvuK1pgeTL+L9PCW0SR8KtWytnsCu6eottSL/v/AX7f/kkcLFma+IC2Ogtv162tfWoztyXDMn4HYolAF7RZFVWZfAU/KZL0u1kCDBHoDKin6FlybjA9llBKNl1GDTQr295wARvE/EvmgxYfrC8p3uUcBSj/TVVd5Tg1VI4vz0+H4DmycAH8RkFVcTeTOlfCcFVIsOaWYd7PxVMVGqfpUaKyNAWB4OmPWqGNB9kXTMvEuA9UHUa13PASrKvWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?u7Fk9N3EIErHbpUr/4iv6viVDpjn0U+cyiXf+7IdYvEjIAhrT7UaDO1uef?=
 =?iso-8859-1?Q?fKC4jhhCDkXpCC5u37ZKKs/XSTfDwYw2amgG3D0k9s83yVUd99qu2tbnC/?=
 =?iso-8859-1?Q?6ZBUiYy+ABA8M8zQKNBk54A57xbEFD590G2XwDRJW9jlzAOszuzb1NOJcD?=
 =?iso-8859-1?Q?KKnaQCg/wqrrna0PpNAqKi6ty92ouB4CuQNp67huCNwSFveeL9kXHSja6+?=
 =?iso-8859-1?Q?KR3gOTBCGDZzwrse5v44aP7oRP4h9cfCFFdSpRBPMXImYDIH5PK1a1s/C8?=
 =?iso-8859-1?Q?EIv2Nsj++bkvXkAm3YF+TtcWUhRyw3H86CSnXKcAi1uM55bwvac4B7uTOE?=
 =?iso-8859-1?Q?cG0jgFXsRKPRBMeTNPbtHN/2zGLezSeAfJ5p1lov5K2ki2g3hy6Plv1N2V?=
 =?iso-8859-1?Q?ltGGL9A5G3ukAWlG4Q1nAPhZ4KXHigD6JwwYFKU/vUjJ5as1UqjsIn88yN?=
 =?iso-8859-1?Q?wbV4qdIhyYDps+z2MJmCqnGaF+qIADluqANJVfEhHAsHjel4FpiHb8XaCJ?=
 =?iso-8859-1?Q?qDlSmh3yJbKyqcHl/WoeIzrf2EvBCvENaPTmrbCym7T41BCMlBsP3qGUPi?=
 =?iso-8859-1?Q?4Gg4YZmBduh5zYpdESzfbC7qJLawvwRMoBcoerd+aS8OuoWi3PUh0UTo1F?=
 =?iso-8859-1?Q?JcXl/QCXheh1pL750lkM8Pj2LzjceWk/tlc7f/Tk4OTcPlyDEyXeXyB5Ka?=
 =?iso-8859-1?Q?pBALGcqT11dx5gBSgKTRsOH/fA75pE2CPzTMOZVZBvjJzw/mbIrzsEBUAy?=
 =?iso-8859-1?Q?0wcvGJlkqcsHrdzjq3iZ1FF96MqOYWe4qQc02mg1dNU6rOaseP0m7d/Z7V?=
 =?iso-8859-1?Q?D5S8neuRKFJu1e/pPux1PpjfIE7/lo2vymCmzl+8rlF0NO86nFggeDwrsw?=
 =?iso-8859-1?Q?bJXe3ton2Jj3FIXvLxoulZVT26fHmmn1Ip/G4QieI8VncyEawWPPjJfpq2?=
 =?iso-8859-1?Q?vU2UJ2VGE72CuWKZEWe6CN5HIZMdhhrnF5EI+d6wcS5xcJ6tG6RV2wBeu/?=
 =?iso-8859-1?Q?TK0vpwwyXCXE/+cbCQo3yEFLqBWELgRP11WC8mzfWH6YAbAv+D6NfnibGu?=
 =?iso-8859-1?Q?UftbTfR1EAtwcohrbPcg/0RbceNKyDDioQ91RBih1/mI5/MrM05ghh81nS?=
 =?iso-8859-1?Q?VVa874ImVMddLZNhLn0LYRb+DthhrUo3jkHfnUrORl5PA4RNY17O//e0ig?=
 =?iso-8859-1?Q?Hft4FeOPSiimdZk3x4gjOjpMLMPR2XhQbi3QNzviVvUYuWy4GEjGGFF2d4?=
 =?iso-8859-1?Q?c0m+5+6nJjk3HLAQ6RhlyH9ne+UEBhR3yLX2j1MCgCp7jsPo8pj4yTBTWL?=
 =?iso-8859-1?Q?bpcpJAfsR5tijdW7n3P/T/yNGQWuWbewX4t3hO7+m+2WZ7BRFnOxeDCZvn?=
 =?iso-8859-1?Q?lqRg5ZIZ0du7XSeJ18aCHh3udIQjkYObRHdFO1kYVwy8oA7fVcWfNN4w0J?=
 =?iso-8859-1?Q?UPy6iPSn7j1xspDUnEUf8fgq2wKN9t5M8o/4eJseqULy6uapjoRHRbM0ZJ?=
 =?iso-8859-1?Q?0rE43e9Uuzz25vpbwwSYMWMV5X2l+SfCYnIZuLoxxK2x+f+UZeS9gYzd3n?=
 =?iso-8859-1?Q?ZqzIa3z3QgggNg879mh484IKi6HkJsOQ6j0scC/1nBoOA7+zICIbXI9X2T?=
 =?iso-8859-1?Q?xgd7R6HJORGY+gKh8QwqMCJKIz/YAdQ9MW?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e47c4d-562f-49e2-389e-08dc58ba45f4
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 17:27:04.2073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKHm8kg/qJHzsjR3nYvNvUktzewg15NlVgrGDOv8BFiq2EJb0QczanYqQd9KXllxpSvJqEPSZ/LpwDl1XsKl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10291
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E13?=
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

We have just released the thirteenth bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2024-04-05 lttng-tools 2.13.13 (National Deep Dish Pizza Day)
	* Fix: consumerd: leak of tracing buffers on relayd connectivity issue
	* Fix: consumerd: wrong timer mentioned in error logging
	* Fix: consumerd: type confusion in lttng_consumer_send_error

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.13.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.13.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
