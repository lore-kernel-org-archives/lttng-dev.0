Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ED1CD6E7C
	for <lttng-dev@archiver.kernel.org>; Fri,  5 Jun 2026 19:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gXBSm441Zz1qYJ
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1780688040;
	b=UjcVCJ4X7D41OJEboPm7Sby4rEUtS2/aTY9Q6RQykSiE8EJSTmmqs2RwZJ12okXUGfv2
	 Qjz/PVRl7FaQxumXsaG2tq+Bl2xpSAmWHAVVlTMg5ysks2jkICh2L02l7BbeT+WKp0DJm
	 MG07KTNh8meVKBsKh1Z1s6tcHogYgtolbSRrklOfj8KJMCrDbBalkgO2XdCrZqXmcoFO8
	 9va2l1r6eYHi9G3sv/Zr909mX28mN97vKPF1vmhqCR1OD5IWLFPMkSrT4NF3IOGmaFkfX
	 Mn7SbnI9lf0KhrhYItsLWcTtu2ydCtcCONSj96Cf2Gha5ySq64OWWWmI2yZXGQHtSJw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1780688040;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=ALFaMr1R0/TT69pOnSE4sMiI0toY489R9P/aqtG/cOM=;
	b=KzM3AuURCmp2mCaqm3IqoEDmmIzbkP6EZxOJx6i+Qyl0KAWT4BmYOPAbsuw1Z14s/6sE
	 bRlJeH7MD8kWW9yispCoIDj49xk7IEOPYOyv9e73Ty7Jj+v8yq6Mslhk/idJdZZ0WVj4R
	 +JwR+QOIzOHC7M84UrLXrh+Zgl2ALpe9s9yYdrbdk6+1ZBWX9rLL47qaCk4GMY5CLYXTr
	 gkP68fylJu2F2C6qoYNaPwZfMPHOpgmokk2p8WciRiN68N54Aq0fwjIb8PThTWF2ooW2Y
	 WQCLqPfORsfxoKb9OswanaKJbQqsCynugbGa3DvKHSPM0SvFnITuRxyLdrbBfx9Nmvg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gXBSm441Zz1qYJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1780688040;
	bh=nD6QyDA5sVhxuwAtk1QNEXMaYKw/K++lubkzWNFHaTM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=GaaM3GP0ZiBm6GCCTVyE/zPVDzPSRHAS2UDQKfIC0OP1/Cshk5gl8PkwwZDd7m5Sf
	 Cb7CPwjxET6J9Y2YTZXuPDWWF+1QBGdRH9NUzwjtf6pVfUhAJRmZvdk3tsuHUpR99Q
	 0E/QK3enZ3X3hqJZY60uHvdqICkxiNeFDHNvI2wKSIJ6YMpQOLZ6pgxvdnHYk7+T/x
	 rOBeU9aOjA3Y4aucrIt61ic692hGU/6KFQgL+eVNpOEfyptyCfQOseoCk+irMAlXoM
	 C7O+TlH/XDwcLzpS7abhv1gk0hvtaaZ2hNP/Z9sX+snWh/VNi1ZmEZs6kd8MNmzlh3
	 SIMt3m5EVOVrw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4gXBSm441Zz1qYJ;
	Fri,  5 Jun 2026 15:34:00 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4gXBSl3ZYzz1qdr
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4gXBSl3ZYzz1qdr
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4gXBSl3ZYzz1qdr
 for <lttng-dev@lists.lttng.org>; Fri,  5 Jun 2026 15:33:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kgi/JUsXv2GibsTV0NYE0g0N6yFXFNHFxU/BSmv5ApfgTQCJds8qDfiiAhK77CZHkBViVPLyHbViYevfH0HpGl6BDTUP/iLDsr3/BR1r7uDLVKGVTPiaX039uGXFmsoTXxXonAFw32JZ4KsC8CJo9AA0xpVpWb+N+WVYhdwZl8PAFn9G7b1gpbYV81zJm5Tg1qeQPvOnbgUXZiPr2JQ+8vLbSPoibR4EA5Ayl30qDsIUt/GD0Wj7pRbBCL7uhh/zkjF1VAgngoqZ9Hn9tEefI1E55WeWFmcqR7jvHqiurtQm2Eh/TAWSVIb35rNH5bmAri++Hu+875B1CnkscE2lLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD6QyDA5sVhxuwAtk1QNEXMaYKw/K++lubkzWNFHaTM=;
 b=jrZufro0Z0S5VVQYzhAmREn25sBYHg+uaTK5Q3+PzD59ZgKymiP00vWzwMCntMI/MEpsarWhZ7hR1VDrXLxYZ//DyZ4yrAQuidQBZbWG8+IUCZ74KcVxokX14jhJmvNbr7ihXLa1CkQNmL7jPO1BQS0XHgosWvdPMgJ/GcgPDmDdTuvSnB6l5S/mYo27lW0tzIT0S/2NtLI3G72jvVK6u8eRmRizcSlFwbVO+w/1KOnrMHUkwKacukq3I2nKS4nB7mc0BJ6ePbRp2TWOOAF/rwetMZSgFKrwvmp9EFFRKo/JL5t0wZIZ9LFX+IzQG6EITbkgXX2dFpMb3FWjoGgVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:167::9)
 by YT2PR01MB5856.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:58::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.5; Fri, 5 Jun 2026
 19:33:55 +0000
Received: from YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b0e8:8334:afbf:9bc]) by YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b0e8:8334:afbf:9bc%3]) with mapi id 15.21.0113.004; Fri, 5 Jun 2026
 19:33:55 +0000
Date: Fri, 5 Jun 2026 15:33:54 -0400
To: lttng-dev@lists.lttng.org
Cc: linux-trace-users@vger.kernel.org, diamon-discuss@lists.linuxfoundation.org
Subject: [RELEASE] LTTng-tools 2.14.2 - Orbitales
Message-ID: <aiMkot_alZCgDpSC@efficios.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0212.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::10) To YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:167::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB12074:EE_|YT2PR01MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 4071fd69-2062-45d0-8a7d-08dec3396178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: miq4JjV+2MtVUcQfp/r946qp/iaQ7e1wxtzxNwy4br9qjciDVqzO2GF+tTy739xXoy6OlJyE3ZtyNagScIkllRMXxRfMk0XhbEKQVkHq7hqddLDfEOs0jARw43isHO1i4fuM/4M3MveD7OIiRZqwBC2YOdmsLhXt3wgWjr05DGpnhyYCkIcaPnnwixs95PS3iMLluwSvFXu5+m9F4GfJryexzPTV1UNrygKkyV4KbnFtreSBkriBepyMY/Hgv+mJwhJ4q3+PNDOfvpuc/K6NaTrBqjD6o4Auq3qg14UhNhI+PbgPkyuOAei8f5cBKe7B496fKFVZgM3V/H9mYBJZazbPAuwkyvq+OUbHBCShaGuQUtG1AQeUEMi3AjYrnhbHFq9SMhWGsvr/X7G0u3VONk+byqC0RaCkwjU0TFcnJT+z7NGZnq3zDRSfBDU8coBED0BJ9xiBTBiqa1NawzTL5yYUIL5RymQmsoyqlO1dIsTxS6B8aUNkOv7plsh1NZboi2T0HC8a3HJXtXJG5ERnYwuHOv0jJbee/XhycOeEOEl0siUfTQrrLPwySKVEhzE6e/1ysC94RLqsQnBQVygbH+CVwqCWXR+lDUD23N0zfiBYGfiDIK9gsBaJUj4V7/YT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PU8Rj37rRAG6UOksK28DL9S3ieq7ryWSca43Pth/j01zPwysuHQmHXfkbN6P?=
 =?us-ascii?Q?NW7fcbQrayB/YSxOX3ITIUeJKZJJdpKEFVZqW5OAfr2mcM+22vAxhGG2AyEh?=
 =?us-ascii?Q?sXKAiH6cOm0ZEBEWaZHlxhZx4FfZXn8h4kRx4sMG3wvWE901Y9EPMSmzomNa?=
 =?us-ascii?Q?YYw823UFrs+p5EHvS/VImVUpWQV2TrJ2QN3U1T9RcFTn8Wja1eEmTCI9FZcL?=
 =?us-ascii?Q?G6i/agvt54rt5ufmZJ4bKIsix104c4Kla/shl6hJNC6XoSkb9+DxZaJvcS9d?=
 =?us-ascii?Q?T4xn7zHEQjAZzFHREOZIVOnqGeJ1QnjE9+NQ960ttKgmBDZeLCxP7HrpT56p?=
 =?us-ascii?Q?KBlF55/k9VOnQ7u/cBNDw4r/XOmxQBHFGyixnRjd/6LOfM+rvi83GQgvCtj3?=
 =?us-ascii?Q?iWNeR1HsdQ9A97MBBxOmy7qwJO8b0yvAC9Y/O1EDWHgV+/UR0cAlz0vuWx30?=
 =?us-ascii?Q?9F5nih3cFxpSq5Qswh3/qRwSWClS4+QEVc7ivaq8Q/K2t14KIZqYqhFJG6ur?=
 =?us-ascii?Q?Pucrq6bBJAnWe4J4tg/fUG5ofxaaTowD56ZfvrQHMJFgWPtBqvZCfkDCGd0o?=
 =?us-ascii?Q?0qbeOpkJ4B77eFFfymGWZVyZJhwGQR/E4WLAuJIEMseLRCNiIvlg2XVr7rYT?=
 =?us-ascii?Q?mjForcGW4mL6is5rfqch7Kiw6aBIzZw0CSZePHrUfLCYkWPDLV/vtb6KJU0v?=
 =?us-ascii?Q?3hVCVib5llqBqPZEArr6MxByvFQXLZSca41RDY2ddAygtBJX/y69UXP+DNBk?=
 =?us-ascii?Q?I9mC+I7fJw2fvfKL5gM/xdgavwFO5f/qKDA5kZvZUxnqD3xiHa9ffwj1p05V?=
 =?us-ascii?Q?3iMUYmKVxi/6+/QvBTIeKtp36N/zYevC/YciogPG2P2e19pSRzkCGyhyMgEY?=
 =?us-ascii?Q?hgxLPg9wyY9n1Pvw71tbFk5LwvkWBMDOTmIEQ+zT+v6qg8ZYPIXFJXnzJ+Hg?=
 =?us-ascii?Q?t5sMfONSTie2jPlp3lhp5H8sEqB1VB5WFt47EaPJWeqN5ZEmxsRorLhWjoiD?=
 =?us-ascii?Q?NjWAtTrxe7TFB+GOFe/Y5KQ8K8OMGEVYRHlEqKec/2Ev5dBt456S7jfiLJQt?=
 =?us-ascii?Q?s8LGc86komSY+pxreM1hM/Pq+qSA0e0CZhh/0pQDpKLO6zIa8TWviyO6LA8b?=
 =?us-ascii?Q?SDfX2qRsUmkkVZdtFz+QqSWKa825e83FEDcR7/p6NL7e8IV+PP6jU75Ahxxl?=
 =?us-ascii?Q?wYbnOngnT6XxO+4k1BEozEHdavIiNnT/zcbp+06b7/QlCHSyt0dPNviFJI/I?=
 =?us-ascii?Q?0neGkcrYWsa+6qO+fcocrTxIrRLFKzZrYWV1WFYZ9WuMc/TIGX5Halg/Scv9?=
 =?us-ascii?Q?tKH8cWShJPmi9LU6fRLEBu9qxjenbPQKXIPDRbOSS74YhKR3V2P3vnrtsV48?=
 =?us-ascii?Q?0VoM45c6xqZSoKiCOk1UTh/GQpnmxFWJx5p0R7m1crr5iv4Yq33M4Zc0B1uB?=
 =?us-ascii?Q?gFGyc7PYhYJGXWkTMyJz8jPLcgUuetf9GuUCJvAvRG0OZl6WJ4XKa4HhZWI2?=
 =?us-ascii?Q?COtvpyTYNpZHfp3XhNjJovUd5UA8nMGBCO5ma/AU6dlJlEmxx+CjYyNr3jBs?=
 =?us-ascii?Q?Ekh0kj/3sZqTnYD7Ra/a4T+hIOkBsiDTE6agX1qbrNaBSKm8ox+y66UcbwYP?=
 =?us-ascii?Q?ruMr4MWk+9rnQtoJUI4/2XGGvreg793hUJtVI3+baELXmF8Sinrrzm9cT+a6?=
 =?us-ascii?Q?KSJ74CeU4iurnEhcfH9BhXOrmNeKmyXaRqJv8NlIla4zm2CXo9BCqmoWdX7A?=
 =?us-ascii?Q?StJtSt+8CA=3D=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4071fd69-2062-45d0-8a7d-08dec3396178
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB12074.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 19:33:54.9719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdjl2HoVrtcQaawpSLyOEjXG46JXaQjteBFzcTIZ2U0ggs/drXHskrwxdI14GOz71SisXs6Iy7NLhv+h3NR+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5856
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the second bug-fix release of LTTng-tools 2.14 -
Orbitales. This release addresses a number of issues listed below.

2026-06-05 lttng-tools 2.14.2 (National Fish and Chip Day)
        * sessiond: Relax CTF 1.8 TSDL identifier validation
        * tests: Exclude `.tmp_new_chunk` from rotation trace size calculation
        * Fix: consumerd: silence -Wstringop-truncation warnings
        * Fix: tests: use portable format specifier for int64_t in tap
        * Fix: Include 32-bit kernel trace expect file in dist
        * build: Fix api-doc help string indentation
        * build: Fix enable-werror help string indentation
        * Fix: sessiond: abort when loading an agent session configuration
        * Fix: relayd: wrong session id used in trace chunk existence check
        * Fix: lttng: truncated session name when it contains spaces
        * Fix: common: remove ambiguous operator[] from c_string_view
        * common: Split CPU mask parsing from reading
        * Fix: parsing CPU mask with no separators
        * Fix: common: Improve cpu mask error checking
        * common: Escape newlines when printing CPU mask
        * sessiond: Fix: Deadlock when handling notification overflow
        * tests: add test_condition to the unit test list
        * tests: add notification/test_rotation to the regression test list
        * tests: Fix rotation notification test when tmpdir contains symlink
        * Fix: tests: race in rotation notification test
        * Fix: tests: undefined CHANNEL_NAME in rotation notification test
        * Fix: relayd: live viewer reads wrong chunk after per-PID clear
        * Fix: consumerd: pause testpoint not re-evaluated after poll()
        * Fix: tests: consumer pause testpoint FIFO EOF mishandled as error
        * Fix: tests: serial runner produces empty log files for hanging tests
        * Fix: common: uri_compare compares uninitialized union tail
        * doc: lttng-view(1): remove non-existent '--session' option
        * lttng: handle popt parsing errors
        * fix: '-Wsuggest-override' only valid for C++ warnings
        * Fix: handle failures to find pid cmdline
        * Fix: common: lockfile fd leaks into consumerd via fork+exec
        * Fix: sessiond: default kernel probe list missing 9p and dma-fence
        * tests: fix: lttng-sessiond abort when using libkmod
        * Fix: common: lttng client abort when serializing rotate-session action
        * Fix: common: stop-session action serialized as start-session in MI
        * Fix: common: MI XSD names start/stop-session actions without "_session"
        * Fix: common: MI XSD rejects add-context per-context success element
        * Fix: common: MI XSD names snapshot record action "record-output"
        * Fix: common: enable-event MI emits duplicate exclusions element

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.14.2.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.14.2.tar.bz2.asc
