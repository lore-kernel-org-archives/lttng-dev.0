Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84343C6FD1F
	for <lttng-dev@archiver.kernel.org>; Tue,  2 Apr 2024 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1712083223;
	bh=J95VJ9TTDVpwR+gGVSlYAP4EXnwtwRDfINNnYv19SbM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oooRYqM/OzXwwZSqGgUtQCPiW5Txq1kGwZuwJUClNx0GLHRcTbh8z4Cjp4RgFeb2j
	 hpLYMW9MYcKYNzoNvZH2Aeo3+j0h7z+vJj2FSjlBE1HDXdQi+Ae3BjTx4CLX0fTEAB
	 Et4UbfiDAr+6ai3ng1BzmmJ+Q6ec1BKuJpYBzLUwF0ONF5TFpTp6d3u4gyd/D/PFAk
	 Gpzi+Cqx1QEtMuySvxsYjz1DX647y0Vz0PjHxK7EOxNcRIJVz86q2ek2aLuxuLmOFk
	 kjJMF0q4S77KfciK85MSWi0Wfwz+7X5Xqi4htAPI7UNrDIirPNzTieZibhWW4TINEJ
	 wrvnPEZfp8LFA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V8GsM3nYjz2ZTK;
	Tue,  2 Apr 2024 14:40:23 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazon11022019.outbound.protection.outlook.com
 [52.101.189.19])
 by lists.lttng.org (Postfix) with ESMTPS id 4V8GsL2dDxz2ZTH
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2024 14:40:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr30eSLeiCodBoaV+/4+w4WpT353LoPPat61ThYBxd4YkrAGX6Ix7qdkfV2qwlFoqYCyXFTbZDpppORBh3tpvoCPiHMM7IQEUMIBLcmo8TLsjGJyUD1vED+Ay861aKcPTC12gEb7UTRccgrRIh5csOAKRsxvSOkgsakQLHz0s8cw3Le++6+9WHoZuj39go96m1xdbJMwpFz7DoKIeSE18h0oQJ818ZlPcRQ7Q4ScC5+VT/dTbStB2GvDfSIsMgTg+Cc9BMvzpQRw2NQqFhMBODQCJW6gjfzMekhBPU+k69eoGHuNeR5mnr3qLe3O/Q2/0zA2A4AhKyVBeSj/1cuEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKm2aS85c6oXOw2qD6ir3gG+M3XGa8UIPmkKRFBawok=;
 b=SmwUs3gbm0xNAfxwdVJNhgCi79iWaoMk3hsRWjz8H+i3hYVQN7edOlmsrtRqsC5ppaKqSLDU8LZQstKBBKRs4fi5QRDJZYJN26zGSPkSnMxRtIkjSieMgfleIQo3rfPlcr7Avaloc5TgIkBagYH+6OH2NYHfYKTUUatAt8vY0pv2W4DTxDPCWuPkkpxNiiA13J3/tw6EuG/OqQE1hu65ErknwEimn3pPMEXfooATuP8DpqGvtXm3gCbOmLJZfBtUtGmHBgQo/sfqOr3aPTsu/kP7gY8h5wvgyqC+5hzkfGl6J/ew2voXwfdKUo2tDFtgViSvCkCMb4Y/AOIfgyKOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10) by YT2PR01MB8341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 18:40:20 +0000
Received: from YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3]) by YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::54b7:87a1:7ece:6ad3%3]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 18:40:20 +0000
Date: Tue, 2 Apr 2024 14:40:18 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <ZgxREgkURC7mwXHU@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0272.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::13) To YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:104::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10709:EE_|YT2PR01MB8341:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NE6rrcfoF8htvYFOj/mHrF1KTsuUBCK+gaCt5hyyN8MrKNHmd6TKCqZ5Cy0q5NvIBoVylqx/Vr6x+JbetyTixsKf6JIkhalVcn+lT0s9rZfNH1fVtOE2r3G9AVkig4IimqddGLT4xvz33W7Psv7mASl85W1u5qoH4iW+PXIKYH+3+v8UXX51N1+R2QCatgjoqhFVAHKnWGqUQnK02Ah3VXf/QKeS3SIAK0S/reKwMZS/u5dSPnCp7/h4eWO+H2uAi695Aw2fUZTT2oEGAtBWBIT1BpxluKcfsGlUwt/zS0mQ7BQyv/gggAqzvqXzUrZa3yPbJZ8sCr58KGTygia10YQcmxP4Mben2WbJ0+jvthoGgegZVKz96QYybnRIuzx1p+KGCcN7f1aZdPdCWBm/ZeZrpyEwy2K2aKsCMp0rh6svxgr6Aqtax//xJ6fEVW8pfORJEzQG8pkLyP3BweZbVRvpEcnyhTQzXuRSOcfp8vI1TJXCiGCfv9wI3qHnKSeM+n/X45CjzF4tWVlaBLsmteWogATO2FvaTW+wSdOc3RlZJ6JW7luNX+h+4HDb7pkAQQwsDvvbD0u0gXKASKxCLdbMRIUOoj5wtY/qKN+F0YE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?45iK/jetut/bhCYGv/DFSA3iZuowdemDxxLJihXfk8l9IaMfBEoIWTEEPd5n?=
 =?us-ascii?Q?FKuiX9XpiFbhVaTSG1epebJlfF0U9IXSgxBZaWLIOrVTV+Vd97PXk/PgdxwZ?=
 =?us-ascii?Q?7CHhyN8OTciz3MhPhVdwaM5g1uwWyrlW9l0cQfQ+ZGfo49V+KIo2EnQ8xPat?=
 =?us-ascii?Q?7rrLpX6pVIwaXJ8jkbmhr7zlgUuJfT3ioammRTrDweEqCdXEgqvIP5aMGJxN?=
 =?us-ascii?Q?/HmxQ7AoRZ7ryLnPUTbuqEJgpNQ+Nr/xjmJz4lztWb1s9nEFR0uHICVhfC0Y?=
 =?us-ascii?Q?lVed9ZiTm7DKPFWwlQI6l1fj18P9Hpkynxtlcd8thKkF5D4nvFUa5AzT9uU4?=
 =?us-ascii?Q?n02uNm8krI7q5pUoZwvTM6hYr6BksSdxbRCp8CCbTRtxEEPOWHsYoWLO9kwQ?=
 =?us-ascii?Q?hIXnOm2oTT7x5yNi94AdDfKhgnkF9haslbbrPoh8zZv3g4cynCUkbAQ2wJtS?=
 =?us-ascii?Q?BVAeCLBaDdyXm+3CwDRKy0eKvBBoKy3f6LhRD7TUqJwaSehs32RhiwBvK/hh?=
 =?us-ascii?Q?OMwl07BWJAtsRmoHLGaa0zcQt/yY7pa9w+ULVTIbOGOBEeNpk07WERDQ3eLr?=
 =?us-ascii?Q?A4uJHMFkvv+L8kCTX7jHKFr/f/kZRWj+M6ZBqmhZonwZe/hQ7f4+Snqzv6hW?=
 =?us-ascii?Q?HCKD7NRaM0rJl28RC9ZWa47rG2laRCUC2YCmxhEhZO1SgaHRuK9jf96FWpVB?=
 =?us-ascii?Q?Rr8/EWq/NRxDMirRYirCIEXS4nQlXsP3FlAE/EXEqHX+g2pmM+oObGJ52ZoT?=
 =?us-ascii?Q?3nw4m9qoBT/CEevz8fwz+vjHVX8ZysKoA5458jeU2M0pNJ2vy7IuTRjZqenf?=
 =?us-ascii?Q?JQ865tt7aGk1aq/n3UTWAFBG+LqcAJM5UCnOBeGouWKkWM6i3Wv4g1cC9/2b?=
 =?us-ascii?Q?2OUob1yK4LbD/jWESmleprQTovAzFYgG9gzGS5FQXYRaARJJWp/wQT3omDbp?=
 =?us-ascii?Q?Dy51eaS2oVXWbMXxK7gng4Lz9TM9yf6fV0lgy1uxpQ9r6ndScGoEf+onknvq?=
 =?us-ascii?Q?Uj+7q3rou3Es2v34sXOSLE+Rm3wt2VhrrpoSYxV1iW5bfhXq3a/eNrVxZyae?=
 =?us-ascii?Q?5wegPwyOTvIiiCI51sOtbtBBD1yofK87TYoe6clXBWNRFmB7ozf36agc2alQ?=
 =?us-ascii?Q?uWFmShJKsMnjMJ1LtJAc5zok2kLq58dQvpeo6ynV3Tbp17Jb+hoIM74wE073?=
 =?us-ascii?Q?kaecyhH1928sFRahcRcYyV5IjezVuV+L5Mp2bi4gu2lUW76G2SVBnHXJYvRm?=
 =?us-ascii?Q?nqoMo9JDSvFvUNS2JgnOKQ3iHQJWNsiB/xawcHce7+qk7Dw3yl9spBSw2i4G?=
 =?us-ascii?Q?PAkZdPZfYSIfT+RILC8VsodkVrz36KXZqc7yMcRoe/G8L08rYSbJgnvyunpN?=
 =?us-ascii?Q?kBaXnPmn8ZXVYLvw0hbq5S0rynqw4+dyXl5SRDRUwC55iXPEPtg/cjIAkI0M?=
 =?us-ascii?Q?OZJ/lkN4J7uEFRUBtgpK1cDlTYpLiedSDDiAlRM00Lp9nRYT2CWkB+anzfY1?=
 =?us-ascii?Q?q9H1ob8YGSSaa0eN7nXSUXSjzV9tm1BSSNV9+iEvep/sMWMyYgupDXmmehgd?=
 =?us-ascii?Q?jS52rWzA/KHQszc/Xthy4xvIInduto1CzoVkR5FN?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ba4c91-dd86-4947-a2ae-08dc53445991
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10709.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:40:20.6209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ceid9iodqbRJd94YoFUlCzXcrdRtShYAcQs796C97T8TKxmEResEoKZsxG9AR9GOUf0FkN/nTYPwDrvXPvlBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8341
Subject: [lttng-dev] [RELEASE] LTTng 2.12.15 - (Ta) Meilleure
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

We have released the fifteenth bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2024-03-28 lttng-tools 2.12.15 (Respect Your Cat Day)
	* Fix: baddr-statedump: use $(LIBTOOL) --mode=execute
	* Fix: relayd: live client not notified of inactive streams
	* Fix: relayd: live: dispose of zombie viewer metadata stream
	* Fix: sessiond: freeze on channel creation on restart
	* common: move utils_create_lock_file to its own file
	* tests: tools/clear/test_ust wait for specific test app pid
	* Tests: use CPU ids from online ranges
	* Tests: Preemptively fail infinite blocking tests when low on disk space
	* Fix: lttng-add-context: leak of application context parameters

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.15.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.15.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
