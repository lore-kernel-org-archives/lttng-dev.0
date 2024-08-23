Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA68C5321E
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Aug 2024 21:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1724447686;
	bh=XRtnXumJtCtx7qkcMlkrPn+lyBdK4ikf4K4HC3R9BGY=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=T4J446FSfI5TAcwyTg78ZziQybb33nWZhdGJXyp17iZ+ALjII29TS3ZtldJhP+D1r
	 +G2zAac22HCds8PN4Uf44fK/gKGkjgWSyMl8XyL2XeRIsc7sCy/q+Ofn+zib8oxxo6
	 dVKG2tLmvqD2CNmJrsXnbgOvcV5qrNsHNg6BMwKVSm7837XkP7hd04mcBrDvycxzW+
	 B8Vun4noT/NukDYyH9sfAy2hDdMVgUNliuDE0nJ3Z6karWGGi6jWuZfm4nLaIcANqy
	 eAumWCZtqUjI9TnrvC/sZqbXqSx4r4DYMPSTN1w2srMFd7ER1froxpAAtnZoSml7L4
	 ap4B6knM2XxCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WrCWV4Vm6z1BqD;
	Fri, 23 Aug 2024 17:14:46 -0400 (EDT)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazon11020119.outbound.protection.outlook.com
 [52.101.191.119])
 by lists.lttng.org (Postfix) with ESMTPS id 4WrCWT0q7xz1BqB
 for <lttng-dev@lists.lttng.org>; Fri, 23 Aug 2024 17:14:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLnB8eCj6BBZF0AXZKyN/gsp6WU8RSCzfFV+D31u3ENQVVoeYFct/8mdspzEXhIxaeZK5hvrvSd4VWfaFoLpsArZ+NiccJm0e4Fy6zW+UObRlX/oTFA93tVAtqqsgSqQ3cv25d6iSas1NNBL9gRe9MwnyctxIhr47KM8DeXsitxOSRvXSDvIcXmZcmYUrX1XAVGS6cSLKOUPCCqJFXFdaGqDncN/IWLs7hvCEY/zcvg60a4RERwYoXZKVvCE/f4VwESHFMbDkd1vfDIjvSSiRLPsbGoiKB8kLxihwUlxE668q5Oj1WCHLPPORfAyhd/qHETWXZHb9eWtiv0JjW5iaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTnB+/l0xPTSFXKlR3fWUPWxdZKrQKP+mVrQpwOdBl8=;
 b=p4Rj2OpfUZx3TSG+PzB0elH5S3f0ooYOnNgk8JVdWLnNsbL4/MpnXrrBH0lVKPy9uThNkbt4hU7xsrdNa41TmDMm/L4Ejsrx7g7RMUBo10QxB6EGqdwBwBLovw8ge8ap5CszF08gEFYI1hq2GrzyqUqM/qQooTcA9+XK0FtqE0MWugXFVOSf0s4h8yyz5dx2HDsgVYX7PubdXlCVXEEBdqad6ydh+eUAbMFGCRzm5+7Lqftf4LhlpZ27hHjIdNPyNRhsnTZcujh43puZw4WFICJaY6dqFlyZ2opRUkA/Nj6of73G3NiOjzNonjSDNmyOvYHGlKMq9of20fq957BI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YQBPR0101MB5720.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:38::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 21:14:43 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5de4:ebdb:2bf6:ee1%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 21:14:43 +0000
Date: Fri, 23 Aug 2024 17:14:42 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <Zsj7wm1hsCmPU-9i@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::17) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YQBPR0101MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 52dd4dc9-226e-4df0-8625-08dcc3b89bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XgY/ZCvgcEROZkWMEyvSFI17ukaSZP4b9S93ZZLltQXWKsjQEZgDqaWABb3J?=
 =?us-ascii?Q?5XZanCAggxGG7Ubbb7Es6Yy9CewRQ9yzBnIl9TfTimMydn52AOIgTNKt+7Ac?=
 =?us-ascii?Q?ZS77T2L34D2X13vclfu52kbL5vECEgpWZ/r52CNEyMgNIB/7H3IC7/AY/MZW?=
 =?us-ascii?Q?bmA+8SujxUqrrA/RewYDVxFzQhpd3CCI3odqhb7YxqDZeVL+TER8BeWF3/nN?=
 =?us-ascii?Q?e4+8faKCRqT6KNRBCcZi7Xa5Dc5bXuW46DMEsIVpRH+6FoqoccOkO62oeQhB?=
 =?us-ascii?Q?aMEazLA55M1xZxPA1hsfnspEFj2AWAmc1kvpOerqn7/YAsC2MgbqVu5ofKcY?=
 =?us-ascii?Q?rjwV+619K2CiPw8PLu98MHcrK/HZ9sHmSPSEBD7qOIDQb6wazjZZoRFOlLy5?=
 =?us-ascii?Q?H2eLR4j97gvhOMX2/E2U4yb0z5IWHmkPuTh3oT7YOrJ6Y8Z6omcYV4vVxS9C?=
 =?us-ascii?Q?LJUeTx5CPZwkpQ2TLl0OjHErnbl2jGkWGx+4bdbWKTaDijJT/Oz4MgiGyyah?=
 =?us-ascii?Q?cLb8WKD0VoBAAvWE8pfaV+ajD6oMZbJrYpVqYRjprmfAzL+yH6pqMt2ejzPy?=
 =?us-ascii?Q?OtxPNUHNRrFGN9q3XpzH1UKsObrNYsSr3HDnH16RJGcevcYFMzmqYqoHdXCH?=
 =?us-ascii?Q?vQ0WXAuuO6UBrJXqemrzIV/HJYPAd0LV729WtC9B0M4EtJv/68AAO0PyiwEx?=
 =?us-ascii?Q?WOsBAbaEfIkGRJytTy+sVdAPzBYuamk7a6+XFxmM77K1EO123jDBMSyKyK23?=
 =?us-ascii?Q?g1dhl4Uc8PAiktoBPQidMK9Fy5Fsz5NIkZ1xaWqq/+l7nG5sf5PsIoRDOVPC?=
 =?us-ascii?Q?0PUoGnnKVzPjtWBDbipScFia98CcReD2DuxdwrL/G+iHojeVLuP3/ms+xkyL?=
 =?us-ascii?Q?UyfscuB5NIBXgr5zQ4DMYV1vsHosXLDmcprj9ryS0EHdUw8YfS7mfewFqYiZ?=
 =?us-ascii?Q?bQyHNjwXwf8izUrz9wq13zmaC3j29Zb9zJg6/upMa4AsQ+KXuB/6L/is73BY?=
 =?us-ascii?Q?VFgFL9hS2jwYX12vUuR/x/h80kEW2B3tUiqDh/cTWRKnm9kKSiMQyRT3AyRo?=
 =?us-ascii?Q?UuJ3FQ7nhn59QguAmDm73nNIJUVzHVgzWpVe9cfK+rNRicdxFa6H5EQWxqTz?=
 =?us-ascii?Q?AB1YAjFHKbFp5CwTee3Eaj0OkRnqQ8jaKKVw/MWVsddpicVNagxNOEHjG2KM?=
 =?us-ascii?Q?8SN8y0o0qwDZNx8l3S5yssUfyoS1RGR+SKvx3QM0lHODPf9Pq2S6MNDkRqjA?=
 =?us-ascii?Q?vh5YmwB35ZMhFCmqBAVM6lcMTXF0iLR3J/fCHNbJzQQ5LhXWv0aObq5S3AiC?=
 =?us-ascii?Q?LUU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73qtYGjXsBwgTyoaIA0O5Y6O5j2nM+tAuEvDPcHdJZoC3cZ5tOgNnAf5SwzU?=
 =?us-ascii?Q?2D5a7qot/l2ID6OjwVr/7FG+B8tI+DrErei9pwymubRUbYZak5AZlgw4/O56?=
 =?us-ascii?Q?JV6OhyYa1QWZ5QdxRef6q/NHjCgjE5fPGjHf6YGovAQOZO4dxTHDDROmBKHd?=
 =?us-ascii?Q?Y37ui6l6Ok0aRDcCmuVN9GwJLo9aKnchGFh9UPzZOLrpxPbKs5S1W45+KVXA?=
 =?us-ascii?Q?/LKcntby+fskFkCN82W4fgfZYJiB2/G66LfvDiAhZyJw938CB5OGtRpu2yQK?=
 =?us-ascii?Q?+IWbUdXzRsJ9SbmZ/NsuMqhObjIbpVeV2KybXnro11esQZ/+ppg0yCcro8g+?=
 =?us-ascii?Q?A2yK3oq/vOmpfev2+NSBw+9HAn0asMBAG3y01QK9Dym3Iy7pduoCh+Oaj9FF?=
 =?us-ascii?Q?m2/HqF0JEeXs5Xwi0gTbQuqOTUrC79OEURiNOcUOEWgcWgkwyJJNFh+4jWpZ?=
 =?us-ascii?Q?Te3UPhx2JvmT30L4b8LRkgxUnWYb6In/HjUC5fk1/aeZTckosGuK4v2FdY44?=
 =?us-ascii?Q?160+DLZBRS2NQlIwbT/M+RlK4z64Tr7wA4fgj/Qd/xWSdPynIf6e0b0BPElA?=
 =?us-ascii?Q?EI48+0x5NW3IsMkcnqezHV6Ptor5U+eXf7ZnvXthfqeIrryCu9+zQfALulCr?=
 =?us-ascii?Q?ypB8jZPmqLmxDBVA5AhUIhmPFcOMeFvzaLfDMlhgj6e9cWaFrp1fyOoda128?=
 =?us-ascii?Q?4+DWaj0cc2vOE7ufDuIf4lNlvs90zWqP3YqhADkWRzDc5uGb2h+vUbebMDvd?=
 =?us-ascii?Q?QxlFb4cBxgDCPlL7Lbu52KeFJbniF4IGux9zGc1bu4XgDbNCd9nQuJBfiMbv?=
 =?us-ascii?Q?kqvhv6Zuzag1yN+JwlJabQpjcPyROHQ8vdKUqApb9CUg7mGUR3RwDHTwDTlw?=
 =?us-ascii?Q?q99FdobJCtDto/YKy5RJRUxHG+zP/aNU3krVoJeEV7vyxTLVpJoo+EBd2jbC?=
 =?us-ascii?Q?7OZpOvV0w5WyIwpzh55j76iwEW84iZ9HyhMCSHmKHuWUC2An1AxL7K3HBxhs?=
 =?us-ascii?Q?MMvbomGVzAhyg0psclNEfHDXAzeVT+SerqZs6QunuXiMqx/KVlTCq7ibcJ2w?=
 =?us-ascii?Q?cz7Gf/ps7u+BcWGVcnA63udAfF/VOLj2HtxkJEF0FnR3zTTS78KSM6i7a3D1?=
 =?us-ascii?Q?eqQAlF+SU3M+qkR0We7ZIcoCT9tmyft9REGgXSC/soQrEbuWML3OavBoCfgE?=
 =?us-ascii?Q?tbjdsXAxad+V5x9Ds8LcoYTBCZGV5xx69KqJkUtfIbm4JcSjePRQ7pQtajcr?=
 =?us-ascii?Q?5lLo/b/7Qd36ywMl6yIBbKM8uEY3GPvIl0KP8+fqiNxylqBOe89Y98m3T+LN?=
 =?us-ascii?Q?4wKebR0hU2bN23Ti26php9IeO3QR7k7O/rbQY5V1kybtI5ulNUofKCJP/vPj?=
 =?us-ascii?Q?Vs94/pgHDeZbC24X7nylvdf2opCVjQyIl7L0yx7z2ZPTk5BjE4vmy1YxtuaI?=
 =?us-ascii?Q?VajkehbvnPyq9Wnohm9vUXoSc85H+QkO7dmEXhhqzeMydXj/NjjAcgFAckxG?=
 =?us-ascii?Q?odWgoO0IsR0G3MZJxGsC5RetHsxFaxQFnzSyJM1Llr2mFP8h+bTejVXTRsPm?=
 =?us-ascii?Q?IC4ek/2rRSdqakXB49qB+5qu8ykXDeL6+gkYW+62?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd4dc9-226e-4df0-8625-08dcc3b89bd0
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 21:14:43.6045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5GDhCXDJ03GjjChSPZNtE8iU3+e3D11W0I+YiXSb5Hcvm/un2UaWafe4MgvBl9nYlLVJQ5LO7drBeok4Rs3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5720
Subject: [lttng-dev] [RELEASE] LTTng 2.12.16 - (Ta) Meilleure
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

We have just released the sixteenth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2024-08-22 lttng-tools 2.12.16 (National Take Your Cat to the Vet Day)
	* Fix: Do not null out lttng_consumer_stream channel on deletion
	* Fix: Crash when unregistering UST apps during shutdown
	* lttng-ctl: Hide symbol introduced by fix
	* Fix: consumerd: wrong timer mentioned in error logging
	* Fix: consumerd: type confusion in lttng_consumer_send_error

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.16.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.16.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
