Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471A3EB64D8
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jun 2023 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687294335;
	bh=tto/BT1rQYfZH03+Lc/uEXtcHqgJtUIljXHbj+y7Ll8=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=lBEO+FD++ltMzH6W2P+Y/6zBwDugRGDY3Ov5KahTDtiaGp+invsC84ZGBe/GRBlcU
	 47NWQUEaia/swDsmTrX4Vo+u4IfCkWoaW4Jkz3bI7QJkuUBySwpLENNz+0RHSLkWxF
	 440x9IiiLSWy+WYfrJZ/hJMqRrJkHOKju7ue2KMG6lLdTg3BCrabkSWMwZLx9klzs7
	 vXcy/Ul6DXf8Am+7K8vMXIzp+JYc302oRRIIySODnNnTkBnNDTdu6jGQZAYCylHeAl
	 GDvfQsWOk/yyMtf02ytMF9EXE8Ru/2B+OvBE3W1fRPOt/ASlKWackwYEQ8XDlId9nG
	 dGx5o1lFgfU9w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QlzMy1QV0z1yHf;
	Tue, 20 Jun 2023 16:52:14 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2048.outbound.protection.outlook.com [40.107.115.48])
 by lists.lttng.org (Postfix) with ESMTPS id 4QlzMw55Xrz1yR8
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jun 2023 16:52:12 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHORGHgsMIIEpGpDSrzP2XDmuhwyHDe9Sv3MdnMOBGe+Vwqi4OIWptuctiprDi6UbrTR1QJdLvGQmYe/WwY1cWnPyuAEi3Mf6ru5qeaancomYvxNR0aecLXIY7rGHOjWVqbW/3cN8P8xpIJB+EcUPpXdSUHzOkqDB93MVQKmq09eDx1gGgvefl+JZs+GW4U2XaSfRNwxAWyrfu44zI1hoFVH85QTbjD9RoqPluYDpV64jkpieh0eiL+sveLjWnSfGq8EdBODFUh5v1Gd47hP4Kzx33D5apN2rNDfH21uv3ya8Gt0Mg7MaCGUJaecTzhIktT0kC5HgGVZq+X6rkQ1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/IJxnNc5g/ogBrcniOVuUFTPdjs6HFRAC7X1IliTww=;
 b=kgUe2UMzZA0ey4q+hk+el0Jj1dA9thGwkwn7YycmvwK8cj3/X5rExbnLXqEPAux9ehU31B11ikXeTrqmj5u71QQDmMgQ4wjtDi65frr8ohocp+k5m/WwLqTcAyLm1Vn7aoH/yXlzDF3u++zGqYO58k5uFz1nnBI+r5C/XrB/jMAZhpg8l6qOLXjXqFyozOSarrdjQy/TPhx22+nyCNWIZ9o/S+HIk3XX9EnfBF5eaidP/vahuw2AHZi2iFc4jHAVWsyEOJ/RGw4mqQSk9VwGrZ9dx/3p470sRvionI+7tnnYNCelzoUspuuyCtlRXZxreY2iLU8laVUgIlzpY3VG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB8419.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:78::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:52:10 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::11ac:bd53:ce:1004]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::11ac:bd53:ce:1004%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:52:10 +0000
Date: Tue, 20 Jun 2023 16:52:09 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <ZJIReRDDg-ULZDFJ@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQZPR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::16) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT3PR01MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: e324a6e2-302c-4173-6064-08db71d0379c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nvh7XdoY+w7vphmAXC3xeJSVeBMMQxlhN1dq8Lt+JbP93AEbJcJuZA7IEZ3fJsuuISX2rWD/ArsarhyNX+zZ37z1LJp1ZM0w0X32+jFZkroniHbQgZVxmFf9T9XzggME6WfABlrBVqZM1ZxULjowVgd8VTrmkAsPzbtJSDcb0QoaWyJ9q9YZDJ1oiFXj0+wgMMYe9c2b3KHbp1nk9/rj3kCh7hTjaD48Yi56yMjx4v9+Oz9tRasdd43veKqemMcJB8+N/emNkhlJC8+7y5BtEfUhOrILDACI969UcqWjyCDrmmMAMDDhph/TcK/jUym81Y5UvjvrQL5mfr3FMZ5Y5f0eJ8IVF6VOlemKvOtfzzduMd0u+lKYSfD+t1oWZuYGXglII0PwtZ+96f+zNTMUH3aVrlMf/rqURMTyBI/ehI+/0Rmw3uqtYqBVdhgLQLspKqiQWonmpsV3MOod5/hKmRDi9L8hHZtFDjRHBgZuhwc/2mEjNASgfz48yz6pLLJeItNPMRXqcxza6Z7nOCmTLsNUgVOKJ1IWphGTeoRkqDdLbao6VywtuX1h5levHl+4+BqXBlv4oCqPZYZqma9f1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(376002)(366004)(39830400003)(346002)(451199021)(478600001)(66476007)(66946007)(36756003)(6916009)(4326008)(41300700001)(66556008)(2616005)(38100700002)(83380400001)(6486002)(966005)(2906002)(5660300002)(54906003)(316002)(8936002)(224303003)(6512007)(26005)(186003)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6J4ofyjaSArrHFDPZ3OzxmEol9AWif1DCpT402EdGyp8D2rvPQBoDsCvlh?=
 =?iso-8859-1?Q?ThPAaRSBSDggu4+rEN3YFROBBbx7no+3KDXTC2ra8hh0e55tpDTtj0FCy6?=
 =?iso-8859-1?Q?Q4yY5SFKaD0HYNyJ8F9vsd+ggnnWCPnNqBF68FPLIfiuQUzHNSGu/cIUl0?=
 =?iso-8859-1?Q?40qLxrg9+zskNU1TcdJlcpZXSxYabrzYSBZRHCMuvLjvkTJi+uN2OR0aP3?=
 =?iso-8859-1?Q?gPL//h/denoa4LCC3VYAD9+mgiUncPPJ8lgp0n+YYCXaG1jM6huiJ2QdA3?=
 =?iso-8859-1?Q?w+jwHyhqDIMX93eJPn/1S2U41JNVIHkzgI9LKB4B0/Lt3n4Uc4Yg1Hw8DM?=
 =?iso-8859-1?Q?bKuks2f5AsrHCqgb4gAwXgcrvt9joSI02XSsD7cUJwiQk1ZqrtDGIfX7d0?=
 =?iso-8859-1?Q?/rBEbf+nWT0wuOlHS7D4G+G/3RLANWWYWkVyR54kB7uKa5OoVx5wHZcyIe?=
 =?iso-8859-1?Q?C9cPU4qHK7R2YH3c9a5Z4ixxItJNDRhXoYtS4E/onvG2pbrvTPpUx/10n5?=
 =?iso-8859-1?Q?7tine/OTJ+NoFlftCe/edGQmgrU/lE4WOzZkUIrujNtUOv6LOpt/ajZZRr?=
 =?iso-8859-1?Q?euN7tOulO07gv06apoPpkk6ZG2IqnLL/AvSawM7l8D/HdqfrU8aYsIB7CS?=
 =?iso-8859-1?Q?Fbrfb1X5xaQ+WMC2V1Rc9/9U/sFdvL8tNADW/TVwgCdy0ygu5cPjOM1V8H?=
 =?iso-8859-1?Q?2JBJ1yeR5ZRNvTJyTiHaqNvG+EsL8C8BMvEejyLC20NuCjs/QRsnXkte3E?=
 =?iso-8859-1?Q?6sthGemEwJoS+M6IQNn/fyyc6pzzxy4qQnA8QBWlRXqQFo8q3g8MTXGKpj?=
 =?iso-8859-1?Q?o5Oj0EA4TrfwBel+NmWS5s9+yg5pGDWyw31XxIu7zO0ruSNGERX0RR3GOp?=
 =?iso-8859-1?Q?bHgksfxbykq+mlPfNSeBAbz0TySvmZlvBi8LEpBItOy2HvrEpMAHJjsctG?=
 =?iso-8859-1?Q?xlKr9jwtN3lZzwu4e24EulGJ8fm7hg6FK2Iw6Qd8bNWiuJKbXd0ScpNvRR?=
 =?iso-8859-1?Q?BvJ+Bt6X8laYVF29HXKh6qbjBbLfHT4nCPu0anJ1KElYJQukxSFYnnNQQP?=
 =?iso-8859-1?Q?eAuxdJFI9J77CdiQr40MwC1DnhKHY1bgHjep/p8acMlxTx/1CcfWZ/n8ti?=
 =?iso-8859-1?Q?/fr9MFBmcVUeXO/eHIR7FULuWD6iG5kdp1gtHFQIuDzbFCG9c/cU/86L+z?=
 =?iso-8859-1?Q?pB4c57US4M6Z52xPxPygn5O3/hvYy1jDVE6ivWIB3703YE48z42jgFIyJj?=
 =?iso-8859-1?Q?5MSvuLQcN1ZgQktaSEJ9acXh38wmhncBUQP7BTqh+lqRY7Gf/cuWriL5QB?=
 =?iso-8859-1?Q?QAATzOiUkOhfXJQuIHm+kB9ajiiqVb2ue81KKVppchIiosxfBqrYZUOc+h?=
 =?iso-8859-1?Q?IxVy76fDjLOH/PjWaEjbCqDWBwU6w8unH7EPxfK31ONplTuKsaogLtAG/I?=
 =?iso-8859-1?Q?yzMugr3B8xKAxjgkfvvup2uwV9lx4v4dftTTmijHi67TAqhZwEaez1Yhtk?=
 =?iso-8859-1?Q?jhkI1brWpJmKzM2lmNlJDiYJn/xsMGRQXhTiwgv2Uiuo2zhyG3fMlvS7hP?=
 =?iso-8859-1?Q?z+hOFRj0N8ICcX+Sl7UUAtk0DUqqEgoDi18jZZxJ290f7lO3k7ATYyQ6qe?=
 =?iso-8859-1?Q?fe2Ltylr/Ple3KW2GmaMDUGMI7CITYsUTi?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e324a6e2-302c-4173-6064-08db71d0379c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:52:10.4559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knzg0rAZUWnywrHerMIuh5RPso+5NO1ZU3lWITc8mL5YRWlcgw5WY511jc4FSqqXzXem0bxsBbHwcShsmmuwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8419
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E10?=
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

We have just released the tenth bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2023-06-20 lttng-tools 2.13.10 (National Ice Cream Soda Day)
	* Fix: sessiond: incorrect use of exclusions array leads to crash
	* Tests fix: test_callstack: output of addr2line incorrectly parsed
	* Fix: sessiond: silent kernel notifier registration error
	* Fix: sessiond: size-based notification occasionally not triggered
	* Fix: adding a user space probe fails on thumb functions
	* Fix: Tests that assume CPU 0 is present
	* Fix: Wrong assumption about possible CPUs
	* Tests: fix: parse-callback reports missing addr2line
	* Fix: lttng remove-trigger -h fails
	* Tests: snapshot tests complain that nothing is output
	* Tests: Test snapshot maximum size correctly
	* Tests: Add get_possible_cpus_count utility
	* Fix: ini parser: truncation of value name
	* Fix: truncated len in lttng_event_rule_user_tracepoint_serialize()
	* Tests: remove leftover debug printing in test_add_trigger_cli

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.10.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.10.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
