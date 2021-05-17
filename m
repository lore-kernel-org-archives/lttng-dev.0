Return-Path: <SRS0=B+Lc=KM=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E7C433B4
	for <lttng-dev@archiver.kernel.org>; Mon, 17 May 2021 14:36:17 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DC46192C
	for <lttng-dev@archiver.kernel.org>; Mon, 17 May 2021 14:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DC46192C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FkMBl18Dqz1pwb;
	Mon, 17 May 2021 10:36:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621262175;
	bh=9/x88NGOIIeHXVcSH33e4blG4aRzwbxrfQ6jBtFHtFk=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=x8ACPCC7RYjzPU/LpMzoUcrMDZaZ61JHvFUBFf5QU31IOqbJu9EIWTBvYPbYhaA0i
	 TryD6kfyzACQfEE+FhCxUuBJGWehE+RqITX46dMe/IXmNW32g8RQ/sH8zo6dOdCrBv
	 94j4Ioai0MpRFcYhnnquYUngEkm5aDfbgeziTvwme4JyUGm8P+uwyhiEXo8q8J0icC
	 z5H4FwJ7I3XItEob26JeMMBiRymOK6bpRX+azRPztF0Ox0LyKQw6u7kxde9ay+0Dhr
	 BQJ3/1Jpi5P+3ZLlrp4joL+Xiqw8mKGqnsk1xfmxAD9T7/8O3Ak93jaDkst+RxyZcc
	 YPw858FzH8DuA==
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by lists.lttng.org (Postfix) with ESMTPS id 4FkMBj4xtWz1q2F
 for <lttng-dev@lists.lttng.org>; Mon, 17 May 2021 10:36:13 -0400 (EDT)
Received: from MWHPR17CA0071.namprd17.prod.outlook.com (2603:10b6:300:93::33)
 by MN2PR08MB6224.namprd08.prod.outlook.com (2603:10b6:208:1b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 12:04:06 +0000
Received: from MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::59) by MWHPR17CA0071.outlook.office365.com
 (2603:10b6:300:93::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 12:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 213.95.163.135) smtp.mailfrom=elektrobit.com; lists.lttng.org; dkim=pass
 (signature was verified) header.d=elektrobit.onmicrosoft.com; lists.lttng.org; 
 dmarc=none action=none header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 213.95.163.135 as permitted sender)
Received: from denue6es002.localdomain (213.95.163.135) by
 MW2NAM12FT019.mail.protection.outlook.com (10.13.180.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 12:04:05 +0000
Received: from denue6es002.securemail.local (localhost [127.0.0.1])
 by denue6es002.localdomain (Postfix) with SMTP id 4FkHq76lZzzlbv
 for <lttng-dev@lists.lttng.org>; Mon, 17 May 2021 14:04:03 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by denue6es002.localdomain (Postfix) with ESMTPS
 for <lttng-dev@lists.lttng.org>; Mon, 17 May 2021 14:04:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nakWM0xB065js0U6tFKQbiM0BYo+uFkb/9VUGRPuRkgatHCmFAMfWwz+ROQaCUkdyo+7HhdWCh8+rKq4iiq0ZxkL5vB8y8F+yBOKqWPYditTxBbHGV1Nd8GhSkdJwBqsUluAJ9t/KTfax6M/6gaZdZe6V9DvLm7q+q9CHqz02E0jay8ALa51c8mKKPeehN5snUADkZzhNbSozAhZioFYQIBTaHOjJakHiFwj+7qOLpMWdB2NQBtBu+cUwjdA37DF2PIFJiMjW04RU+EhVPdFFfRqZBaics54ivM6mI8wug6Csm25vxEt8BZlYp+UtX+huNdhHH4+enGawGwKcTPSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63WQhA6tOXgONJel02LkWxtg5GPosz/VOG8k1ow/Nho=;
 b=iNMpvgx8eiVDq//bS77MCi/CjjkE7+C2S0jJYODWWf+6UBZvzzmAOe/rAaeDPULEWlQZxx6AbqonlB1VFs7RMRieW0bwlMU9opjXAIZVK5S5blKcSwGwzP5YT8yRMv1CiB7OaQ9lRbPnK2xgJvnG+OLid5TC++OAA1bsOrUJaMS0qurSy2M08trx2Xj4AS6LxAN3Zvtnu9+KVm3nPQnqiobJ4DOew9EsZBRoyONia5EZSeDp7LEkFV4HqnjxG9ISKmxfh1IPKNrZOhH1aAcITWcgmk+rOdMRJDaq1FiLmFl1bf2fhVAktkHNhdNeB4mnvdm/ZomkugreOFZhEeD9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 213.95.148.172) smtp.rcpttodomain=lists.lttng.org
 smtp.mailfrom=elektrobit.com; dmarc=none action=none
 header.from=elektrobit.com; dkim=none (message not signed); arc=none
Received: from MWHPR04CA0065.namprd04.prod.outlook.com (2603:10b6:300:6c::27)
 by BYAPR08MB5750.namprd08.prod.outlook.com (2603:10b6:a03:129::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.29; Mon, 17 May
 2021 12:04:01 +0000
Received: from MW2NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::a2) by MWHPR04CA0065.outlook.office365.com
 (2603:10b6:300:6c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 12:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 213.95.148.172) smtp.mailfrom=elektrobit.com; lists.lttng.org; dkim=none
 (message not signed) header.d=none;lists.lttng.org; dmarc=none action=none
 header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 213.95.148.172 as permitted sender)
Received: from denue6es010.ebgroup.elektrobit.com (213.95.148.172) by
 MW2NAM12FT012.mail.protection.outlook.com (10.13.180.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 12:04:00 +0000
Received: from denue6es010.ebgroup.elektrobit.com (10.243.160.100) by
 denue6es010.ebgroup.elektrobit.com (10.243.160.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 17 May 2021 14:03:56 +0200
Received: from denue6es010.ebgroup.elektrobit.com ([fe80::e1fb:46b:8e36:4b79])
 by denue6es010.ebgroup.elektrobit.com ([fe80::e1fb:46b:8e36:4b79%5])
 with mapi id 15.01.2242.010; Mon, 17 May 2021 14:03:56 +0200
To: <lttng-dev@lists.lttng.org>
Thread-Topic: Compute execution times of threads
Thread-Index: AddLFJcC7fD3NBHjQpa9Z0GTDp7GVQ==
Date: Mon, 17 May 2021 12:03:56 +0000
Message-ID: <63cae3953d25479ab410be167b5155d7@elektrobit.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.243.160.111]
MIME-Version: 1.0
X-EOPAttributedMessage: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7728e20c-1523-4ba2-5521-08d9192bdea1
X-MS-TrafficTypeDiagnostic: BYAPR08MB5750:|MN2PR08MB6224:
X-Microsoft-Antispam-PRVS: <MN2PR08MB6224BBA2CEE012B082BCEA17952D9@MN2PR08MB6224.namprd08.prod.outlook.com>
X-SM-outgoing: yes
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lZDEuSqxDa1RQsawyq/Nll4C2hv92uP9gMNgI7VOfR50MowsZfKVklAmZbwkUNGW0gRa/V9rGoFmEiHTRiMnQg6D0j6tvJD9c0oDc4vUIMqeJJOpfbzCBWY1uT1XTjZd1YIJ1pUejPYndcTBA6UdLe1iKyq3YrQP6Ify5nyQzDAqjW8eDusdDSPCsc0fF47pymIPYE5AnXQ3f9a/SV9le5Dod3VFxVoWYkykVz3tIWKVnSsxXxPtYZLYf1TuJXu6kVWI1Dx2A/fAqJGwicta2KsHRENylleUC1R2Ev02HqA2x1fx66cT5l19Llhbj1Gl8y2LTC5+4U0ku3FfBxOvRi6c9lNfKwV7gL+6S3M1YABbPwXpU3ZeWPwtKMa4rUFtjicqvY1gdpzikCcMaNI7BQboebXR6eeplyfKlfZeWbzPcYW/7ySYRgIV2EQQFL2vVpJSu52LVcTz0uKLjaQg7JxYPnb+vTdavYniuujU9a+FaOIM/k+o1PlT70t6Iv0dWF13X1JzZlvQEDTVCdxtny4EX2J59QvZZXLoTaW8MCsPfSdXOlKDcjAvjcA1q/JILdiMmIxqoh7mF4EqeXSC3rHvIwy8U21Z782CQhwg7qzublbp10TiDjGCvy0KC772FuyzHaFYldEZ4wv2H7/sKqUFBCnCtEG6ng4CAbP/r8E=
X-Forefront-Antispam-Report-Untrusted: CIP:213.95.148.172; CTRY:DE; LANG:en;
 SCL:1; SRV:; IPV:CAL; SFV:NSPM; H:denue6es010.ebgroup.elektrobit.com;
 PTR:eth1-fw1-nbg6.eb.noris.de; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(36840700001)(46966006)(2876002)(5660300002)(8676002)(186003)(36860700001)(82740400003)(83380400001)(47076005)(426003)(8936002)(6916009)(478600001)(26005)(356005)(24736004)(108616005)(70586007)(36756003)(70206006)(2906002)(7696005)(316002)(81166007)(86362001)(82310400003)(2616005)(336012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5750
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c20a0427-0b94-49c6-db34-08d9192bdbc9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiA/yXHoxg/OsDE93fgQKlGLSCRsAPEWuTLI3RhqH3lGirhn9S0usGYEGer5PHNVXhItEZ3wvukZzR8e21z9Z2FR9qlMI/ZAj715coVTU6G6edo0NBmgjTYNnZuLJGrJvBJzFDmpMLK+eHtD+rNqT9Pr3LVhn2aBVHQII+q/wLmIvP6zDu4U+VjTCC2KudZZjFu/ZRQjTYNvz4uSl7EfUfNzqjq25HGAT6mINUET+mSLJYm9ll36IKTCi3sfw/h3yoCHx4M/9t6WZXxK/aCMayPK30XrzDGngkBGjeDKGUrqXBWs2fKLsmq8I4LTSwblUyZ1eKO5MNE+KTkYcpOmK3GDFabdwpfTkjpQ8bBZ0kMTjJg7GClfCHt7k1aWw1TUlQ/oxvA1mTYismIv1aV9yFHiiFLA8qFhxdJSyZ/4QeFIkJJ6MI9M4Q1CX6aasimL//jqTRtVFW293KFgAdQRO7XPYZK0s7JL/QQFkPY8OdHQhtVWXEzIJ0yTApd9s0tB8IugJdrN/VVew5wLoWx3WJpmE3SPMdp0Wowe0N9mJpsMMKTa4yFhHcUC1At0Y0h11sWoPh537lEyw2SH1eijK+nyV3y/cGekrwRpKHXL6UuqYxiqiwIkQ8CoERDzUu+zpLJkMu8G/rRo+wAnwMgKd0dUDD+YKCCSS+ii3RT/nTAWQ8J7KKpjMFN+/SXbF0/V
X-Forefront-Antispam-Report: CIP:213.95.163.135; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:denue6es002.localdomain;
 PTR:denue6es002.automotive.elektrobit.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39850400004)(136003)(346002)(36840700001)(46966006)(26005)(2616005)(2906002)(36906005)(316002)(8936002)(6916009)(36756003)(5660300002)(82740400003)(478600001)(47076005)(186003)(336012)(2876002)(426003)(70206006)(70586007)(7696005)(108616005)(24736004)(82310400003)(36860700001)(8676002)(83380400001)(86362001)(27056005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 12:04:05.4551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7728e20c-1523-4ba2-5521-08d9192bdea1
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d; Ip=[213.95.163.135];
 Helo=[denue6es002.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6224
Subject: [lttng-dev] Compute execution times of threads
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Phil Hertha via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Phil.Hertha@elektrobit.com
Content-Type: multipart/mixed; boundary="===============3330669889792860311=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3330669889792860311==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_63cae3953d25479ab410be167b5155d7elektrobitcom_"

--_000_63cae3953d25479ab410be167b5155d7elektrobitcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am currently working on my master thesis on a Linux project with regard t=
o communication- and execution times.
Therefore I want to trace some user-space applications using lttng-ust.
Here I want to compute the best and worst case execution times and the resp=
onse time of several threads.
The simplest approach would be to trace the start and end of each execution=
, but this would neglect scheduling effects such as interference with highe=
r priority tasks, where the thread would pause execution.
What would be the best practice approach to calculate the CPU usage of each=
 thread activation.
Lttng seems to be doing something similar in their kernel traces.

I am using lttng-ust for tracing and pythonic babeltrace2 for parsing of th=
e trace.
Additionally it would be possible to collect an kernel trace if required.

I really appreciate any help you can provide.

Best regards
Phil Hertha


--_000_63cae3953d25479ab410be167b5155d7elektrobitcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1762872202;
	mso-list-template-ids:1353623570;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am currently working on my master thesis on a Linu=
x project with regard to communication- and execution times.<o:p></o:p></p>
<p class=3D"MsoNormal">Therefore I want to trace some user-space applicatio=
ns using lttng-ust.<o:p></o:p></p>
<p class=3D"MsoNormal">Here I want to compute the best and worst case execu=
tion times and the response time of several threads.<o:p></o:p></p>
<p class=3D"MsoNormal">The simplest approach would be to trace the start an=
d end of each execution, but this would neglect scheduling effects such as =
interference with higher priority tasks, where the thread would pause execu=
tion.<o:p></o:p></p>
<p class=3D"MsoNormal">What would be the best practice approach to calculat=
e the CPU usage of each thread activation.<o:p></o:p></p>
<p class=3D"MsoNormal">Lttng seems to be doing something similar in their k=
ernel traces.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am using lttng-ust for tracing and pythonic babelt=
race2 for parsing of the trace.<o:p></o:p></p>
<p class=3D"MsoNormal">Additionally it would be possible to collect an kern=
el trace if required.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I really appreciate any help you can provide.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards<span style=3D"font-size:10.0pt"><br>
Phil Hertha</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_63cae3953d25479ab410be167b5155d7elektrobitcom_--

--===============3330669889792860311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3330669889792860311==--
