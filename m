Return-Path: <SRS0=Aspu=I3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651AC433DB
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 06:34:22 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B696192B
	for <lttng-dev@archiver.kernel.org>; Mon, 29 Mar 2021 06:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B696192B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F82qJ23LLzQ7V;
	Mon, 29 Mar 2021 02:34:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616999660;
	bh=Eyj/hfTwnGinHmHa19jEjQdM11etXeQIWreaa7gJY8U=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=oCBLt5AGT6wIH1eW6GQ3j9M3rtb4wS01r2AYopoLKp8pDP7A/QAkXc9Qcl1suxLZo
	 N5jjQd7+DX3MFxnSQASPabTItv6pDjXvy/AnC56oukyokiT2h2vXfF3X2Dqa4D7Op7
	 jAJS6NoHTioZN0/pZhi5WNAEVtQq7GXf8FpFjmB1Rres0vABg6KQ90dz2yx2Nt2yoS
	 BmLFjsUqKEjUgxeZWEXB73kB0/1G0V844WAbFxnGKr09GQHcUG98RHp2aUSrDNk9Qb
	 VieQQzzRdjwhJ0b5ytj4q5a5gGvgYAtOj/biZB/hFH5nGJHoH7wHPbRwZ0b5wSqU3d
	 7apXFg3QcN3ww==
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by lists.lttng.org (Postfix) with ESMTPS id 4F82qG141czPpy
 for <lttng-dev@lists.lttng.org>; Mon, 29 Mar 2021 02:34:17 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+uFDvNyKFtMgsg1sUdbYNXPMJlVSxoF7PbllEl9C/2X3XcI+jw34ejHXQKXJ+UYA8cXMMHZc/8RPp81gKLyjzNoUso9LgPelAV1ZZYE0euX0Ud7VevfYXniS9kj5uRrEZH3djp4jcgbGcLSQl8pzc4fcJ02mEdlXhajtzRXp8L32Wta8N9n9y7XXTVu6etkIPqTvz1GEr9ZKddpRs+vx7KJ+BmJG7MiimgbT7KK+yE6hn4jEk2ah+g0KHAxhOBEN5W+M7URubCUV68+HCkIy9vOid4qvrIITO4gMpPTlEeD63aSkRm0EX7PuyD2S3b+xN7/hpAsCyIEa1jqAefFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSCYxH/9Z5mv7uzLRsSkT7W6VPWewY/SvL+icVtsi2o=;
 b=MeiCrctCAwnaqiOyaHanpn8+YLB3top41ExNNsCougHkj8d5ARacsXHE3eXO+SK7EFXRaWqV1q/p1rhvJyvs0hSEFiAqzypU2ALdf+jKpiwp7M9Bz60c/OmtUt/fhrmXShiE7z5lukv1t680ogNWcalvkPbvPMo2M61Q0cOkNbVPxVaJqi8vQcyVRi6oqT570HAzm7RsLnRZ8D20PkVdbmIXoCDQp4NoW1XuR0ThWDRIl0NOQCPm56xsq062sPLIA6xcUc/DLCp8q9BI3FKfmUlUk4OJ+oVEa77grC+g9BBMGzBuTd4JFK1rXQ6+n1FeKyJ4TnRqrw4S2CUZihBRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3895.namprd11.prod.outlook.com (2603:10b6:a03:18e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Mon, 29 Mar
 2021 06:34:14 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 06:34:14 +0000
To: lttng-dev@lists.lttng.org
Message-ID: <18f8e21c-f82a-8a63-fd30-4acbd843cc68@windriver.com>
Date: Mon, 29 Mar 2021 14:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 06:34:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc0d7e6-6eb1-47a3-ee0f-08d8f27cab92
X-MS-TrafficTypeDiagnostic: BY5PR11MB3895:
X-Microsoft-Antispam-PRVS: <BY5PR11MB389546672F88D7FFD83570A4E47E9@BY5PR11MB3895.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qoECYJ7eO1VTGF88lREkl938iNpTXZs8qmwTKhpAV56sXlVGWCItJMfefMxrUAXekLz1VmQP2UtSQj3/OkcUT6ObSJ6xLmClvmcNd7RDe2eCe4nRnFirKLpUfHZyConvH3UaVi95p2h13Rj5t8aY61LnkMH+oqLnMOmT6EJAKh1T/DLkcw6StOnljgiQQ5xXt3Q+G2Qfdyj0XGTIUyxor8cr5NO85nhAE4ts3R9HkbhPf1pRKAYftehEbUNdnH+qh0vqpkevXIFCW/V8lxW5QlayloKEwqndMjfg4V7KvA9zRfjrRIzDJVDWNCJ8ONLWWPtdtx6o+YAA1bKdis6zsiR+LIRKHSc9MTSJ+npBYrArPGqfYrF/OUqHXfSlHSU/EZ9x/uLK7W/VHciY7516Rqw5l+PMitnRwanZOBEfwARC4BOes2WTKGPT+GyBnjExmMYQ2xxkG2zVP97mdOFfgm0r2Upi3lXgW9l6GpWztXTg3zMwZJDcQhXqsIk9pAB341nyQVMgfirkXT3GYNaK1icpMURq9AvQSnMchh0mNRF7mkVAjs4jAE6CksE7K40n54tumolKYTVGoSYmgWbnmveS4K4mi0ohQzKF32mgK/+yaskx5wHWo3NnI3BAL2ITLwn5pK/XdoNZVZdIcdDQAC8S2LLG7MR22Wh3OwBG1uJP38CzRq/bBzngHGfecjMbV8YVhpGjjHUMbllKnga211YnlDFtGZcrmzoX075YNknOMcVXjJ+ddQmEvceGm9G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4241.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(376002)(346002)(31686004)(2616005)(4744005)(5660300002)(6666004)(8936002)(52116002)(38100700001)(478600001)(86362001)(6706004)(6486002)(956004)(83380400001)(316002)(16576012)(2906002)(66556008)(66476007)(66946007)(8676002)(186003)(36756003)(26005)(6916009)(31696002)(16526019)(78286007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEtHd2Y2Q3M5YkZnWDVWUEV3dFBvUStCcXdidlN0TXBqbGZxaDUxRXRjTGEz?=
 =?utf-8?B?Mk1ISzNxaVNnNWZGQVgzdXJaQ2FkMXpNbGVDVlpFazNXL2Y1TW9ybmd3OVZ6?=
 =?utf-8?B?WmM5cVVtaUdRL0pDeGpFUjZPY2FIY2tadytLTXJ5MVBqU1ZFTlU2WUhKQ2tn?=
 =?utf-8?B?dFFDYUNlL1JRMS9UQ3BWNmkwcU4vU3M5cnFodWtpRFE4dVpsSWNXN3ZoZW85?=
 =?utf-8?B?VXowYzNjQm9lbGdFQWlyaEJEeDhKYzNLdUhxQmQxRkdSU1dTOEhuaGJ0RkFz?=
 =?utf-8?B?MjhiYkQyTEpQdkhhb2NYNVBnUkc0M0ZhK0d0b3dYMjJyN3BnM29pRlMxZXBm?=
 =?utf-8?B?MUxjaXI4bHBPcW9SS211WjJjVVhKaVFLYnhxYks4TWw5T3diOG84WlMveFBG?=
 =?utf-8?B?YzlsaUh2WjYzMitQMStwM0tFbHAvZ256YVI4RURxdnJSNUE4ZG9NWTFqWjhE?=
 =?utf-8?B?Ukw1b0w5bi9ybC9qZXUxTzhsS2N4bkthUGQrWjVlY2pSMGg5dDFkbllqQzZq?=
 =?utf-8?B?ZWRzelZnVnRqSkkybXE3ZzNWMDFMNkNwaTdxRDBJZjBJNzFrQlAvYWJaN1oz?=
 =?utf-8?B?KzlYWTExejNlT0hVc21yTDhyT1c1aVNGNFNlSm1rTGMxRFkyemhZY1MxbE8r?=
 =?utf-8?B?WDdnYnk2M2VLbm10aVU2Y3dMOUZjeE8wdzBWYXpXSDArbjU5VmZsYUdGNjZ2?=
 =?utf-8?B?b1EyNm0ydkpveXJnVXhYUjl5MDBHZ0JObFF3RTRsWE81RmRxVlVwdE93MGxI?=
 =?utf-8?B?V09sYmVSdEtmR0h2VG13cmRzYnpwNm1DbklZRmRUTWRqeEg2ZjNXUTdWN05q?=
 =?utf-8?B?L05aRHBQVy8wV1d2VXNRRzBFOW1zamJZT2dPS2hnNTJ0Z2VkVWhkc0VxYkN6?=
 =?utf-8?B?YkRVTkdrTDV0cVVIdHZxRmd0b0RTQ1R5VmVTL3d0OXBpWFZoM0h4dzBMV3BP?=
 =?utf-8?B?Ykt5eFFwcXd5a0FadU9vU1F5Y1p4R1RjTmxxN0dCeVpQVjZPMC9YaDRoNDRB?=
 =?utf-8?B?N1psdEdreitYeXptaEtyUGlDam9SNjBzdjNaNEREQ3JyRU1uMlFzd0M1akw4?=
 =?utf-8?B?YVN4VHpOM1JwdnY0Wmp5Mm8vNXBPbjhrWVFLTHYzU25nSUVHamxnSmNDTDdx?=
 =?utf-8?B?bzhOSk1YRkY2b0RQQzVDZW1OL0tnRFJZRlVaZmZ6bjZBR0xYWkRRV2huS3hN?=
 =?utf-8?B?bEhMaUE5MHdlMHVxam9xZXFLbkE3OTlueWN4SVM1RjMyb21ESlhRa21QWDVN?=
 =?utf-8?B?YnQwY2ZTU1gvS1p4T0F3UmlYTFk0VDM5ZUxZM05xOC9KRVNCOGxtT3NwWFFn?=
 =?utf-8?B?bXlBMGIxVGdJK0ZoU2swSVU2RHVsVUliMzQxUVo5bUpaRzhDWkZXSnpYNFFW?=
 =?utf-8?B?eFZkTVd4OUFrcThobGU2L0hzdXZKZ0gzc1crVHVrNWxmQ3ROLzVQb1Q2VkV4?=
 =?utf-8?B?WUpQeDB6QWwvbFpjZTBxVDBSYTNpdkRaNDFKVUw1aCt0c1NiNDNLUEcyL0xF?=
 =?utf-8?B?aWh5S3RWTG4zU3l5WFJvaWFxUDVYbUo3bVdPR0dGdVVkZUZweU5OSGZ5Z045?=
 =?utf-8?B?RjZrZm96SEdKdXB2Y0lPd3RMdTFXdUNhVW1MamRHUHF0TDdmY2NieXhuYnly?=
 =?utf-8?B?S0NoazcxeCtZUzBaeWhpb3J4ZU5VcElBamVvSFUwRXRMUWREWENBeE9MU25p?=
 =?utf-8?B?WVhmeEhtUzJZTXpoR1EybkJZUjV1VzA1RVhJdzBTL0FqV29ENEVqTVdTMW4w?=
 =?utf-8?Q?WnsrzcZ/9vmszkAZkrpNHJuozM3Hezh+kw1B+eZ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc0d7e6-6eb1-47a3-ee0f-08d8f27cab92
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 06:34:14.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50HQ8bMrxa5QY+C9X20YFNPNXEXMIoPFbLlQKxY3M7ZKEkF6Ji0kNn6okzOKN44weoZRoqfPwbWYdwoLxoF4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3895
Subject: [lttng-dev] [BUG lttng-modules] lttng-module compile failed with
 the v5.12 kernel
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
From: "Xu, Yanfei via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Xu, Yanfei" <yanfei.xu@windriver.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi experts,

I found a file named lttng-statedump-impl.c in lttng-module is always
compiled failed. The file use some functions which were export from
kernel. But the v5.12 kernel unexport them by 'commit bc359d03c7ec
("block: add a disk_uevent helper")'.

The function are disk_part_iter_init()\disk_part_iter_next()
\disk_part_iter_exit()

Thanks,
Yanfei
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
