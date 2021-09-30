Return-Path: <SRS0=MOqf=OU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55273C433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Sep 2021 11:44:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6348261216
	for <lttng-dev@archiver.kernel.org>; Thu, 30 Sep 2021 11:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6348261216
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HKrxD2HH7z1H9g;
	Thu, 30 Sep 2021 07:44:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1633002241;
	bh=gk9vFbjsANEbTQ77mfdjM6RBEToKOqtHbrwoBCSGHUM=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=S7bNJGFC0pJmHKRBFm7cNhvH+DFaLot+Km+/UhdOT1qy8pK5sjSgIAYZhLDhE3pfU
	 f4CffmrIvetdRrL7NNyF1vQ/NmuY9cbws0M1GXFgD9t7Tsa5/kImc7wFn6USz9m1qw
	 KVllvtZymbGKnu2//PBRN2dwbkEQ+90z13Ta/2PO6osxWIc2PyWg1H0i+pFshYuWQU
	 J73kJ2UXnmJJhWI/Z404MRFPi6op0F3X7nZTNXqYN5STEVMOkokF4bWD7Esi5i+NiA
	 vUfqO+wV5OMRYxs0jG3TCgSXZqJMrp203uFSj+cI5W3NQFD/+OynvX7fcx7pVUiu3V
	 c/9q7hO6ICSRA==
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4HKfyY2qbzz1GxS
 for <lttng-dev@lists.lttng.org>; Thu, 30 Sep 2021 00:14:29 -0400 (EDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U3Z4k2003653
 for <lttng-dev@lists.lttng.org>; Wed, 29 Sep 2021 20:47:52 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 by mx0a-0064b401.pphosted.com with ESMTP id 3bcceqhanq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 29 Sep 2021 20:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4CIO6YWVyumK9O6RbPESIg0kdvXrb2r+ImacgD6KhbNHV9V680MFiBzxxaxOV+HpFLzPkm+JY7JfkjRUXW7jPaPLV5I2j+wPjTcEys2Z+NUGo3nxmKi/I7mzrTT3I5xEAPBWs/WHX80hG0IE9CV/wyW9rBrc2F+VfJ2k6UOSbHgglUpjLAIOe+ulrfgu/0d4DtLGTY+lxADHEjANpPTveXROSSVzjwLF1D2gVLiJAemjyrSmD6k8eLW2oO5XAIbCNYC0dz8TKYgubiv9ExqAQZ9hCzEkNCAwZ58zIKqpvHXOREcgnfwIkCsJuWo47WZ0qrhQ5I4CuLwcOboHD9tMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eGUKV5FfjydUz3Z/0fA6sl/IrNYnDqiFGAeaPrDQSiI=;
 b=SQmpBPiTNDlAQA+whMzMJUL3JPi1/Q1hjDNMJwKSpFEjY6YmaZ1bkx/gJX4pNNMsLdmF9UIaTyt4ezZTm1a6Bpp26AjkRJSrqScrg37pg5/iiH3sZvYH1xw1tMBH3lOKMZvZReRJfZKFzvsa/TFWO6djxG/ZxTQQhfdFkL4N8YcsXpf0bGcIUBJutebYskCvGY+X631LqNUec+jCuQRvmQFQ84wmmL6URe/L3YjbrUpuZzsRC727R2+T85JhHW7SM5SKbIyik/MUEieOTfkPBD35gd0fSV8Lzo4SxPHczbO8ZmFUXvN36lSD2YLnxU9AOmlUpmvaJsJ2O5rtZjnSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2557.namprd11.prod.outlook.com (2603:10b6:805:56::33)
 by SN6PR11MB2990.namprd11.prod.outlook.com (2603:10b6:805:cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 30 Sep
 2021 03:47:49 +0000
Received: from SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::a544:19b6:196b:f339]) by SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::a544:19b6:196b:f339%5]) with mapi id 15.20.4544.021; Thu, 30 Sep 2021
 03:47:49 +0000
To: lttng-dev@lists.lttng.org
Cc: Changqing Li <changqing.li@windriver.com>
Message-ID: <0c4c0d31-5551-b84a-386c-32990b128f09@windriver.com>
Date: Thu, 30 Sep 2021 11:47:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Language: en-US
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To SN6PR11MB2557.namprd11.prod.outlook.com
 (2603:10b6:805:56::33)
MIME-Version: 1.0
Received: from [128.224.162.189] (60.247.85.82) by
 BYAPR11CA0048.namprd11.prod.outlook.com (2603:10b6:a03:80::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 03:47:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6835e7-3ee3-4a13-6c03-08d983c512ab
X-MS-TrafficTypeDiagnostic: SN6PR11MB2990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR11MB29901551845FCFE20F2F4FBC82AA9@SN6PR11MB2990.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+nT/mk4JD0dthSbfCzC5o+SR4CEHV0iYlbfSeWJp2XpD5nw/oVl8koqypvR4hyuKC7wLfv0bXDdgXa9SZn1zJNjDHD3VoA50muvhuznnXFyCtQst3nx8EazKtrEKOYn5VC3mNVgUnJkdi6L41n+7ynFHA3l7USIYw/iN4ITzgLqd3oxEUhajNZZbwAxqE0M16+t18GlxPSgMGtMRq76fgA6plnJovk/RI4OXJp8Ce3ZQIIalzeAL09pN+o/M5TVJAPGm4HynwzDsNKAhB0qN1JaMuvf8KwqfVwANRugfxmmOnVzf1rdvZciwFd5R+/DTg3GK0NXkPn3eccJjGsVT4t6xpQDwgdkVYw5y9/px9+qriJd3FPGPjKeUT5+uewGUZi1DP0LCtb8Jivf9eoszLnHmMDHJFaJPxTqDPa8IYszxuDWuDxoDz5IMHqDqwQ1ShnPjac3e7cp9Nciy23DnlbxJvDj1crZgb8811K72pWeFgTYYx2Y4H5Ygx6gteVZaIsHoQ79JnWpyiEtCVjxlIubrsCPy7ZRjX0ojVbj1Q95jBTRhXzZ56d96cPh9BS4WYNK+GI94R43C0NYNAX1IqbJOSxaEs6nZllV2w8Li8/bw1/CbCz2i0YXCWOpVGNKTrt831G3svQC+KXnWf+SGIhr+Mvt0wrEaMeG/AzBiuBXoKERirH1cMpJUkiYKbUTB8hgAS3P+tXsn+Pfv0l+Z09doeFqgRNJAYvBmgPfDL5snEnX1JTB85qWFc5z2fAPi81YKIT5oDJErC0jqH7BT3l6YH9RBFb72xZwkwRvYJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB2557.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6916009)(6706004)(16576012)(66946007)(107886003)(36756003)(2616005)(956004)(83380400001)(44832011)(66476007)(33964004)(38350700002)(4326008)(31686004)(8676002)(8936002)(86362001)(31696002)(6486002)(6666004)(186003)(26005)(316002)(66556008)(2906002)(5660300002)(52116002)(38100700002)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdNa052ZlExS1NKNE1lWXFuTFlTaXo1cUtUblo1YUJqWXo0NFMwdE01ODlQ?=
 =?utf-8?B?TWNtZ3RGN3dUa1VZUXlUNkc3dkxDcXV3MEZTU0NPcjR2SlEwNldzVk9PTnFG?=
 =?utf-8?B?T05BUXBncG5VOHNscmpVUEtGZ1Ryd0FHUzlhRW9aQzB4VVJ3MTdORmRXTFpv?=
 =?utf-8?B?bHllT0M2ZnlrY0ljOW5zRWdqK3JtL1cwc29wN1VWU1FlU2NQRmFIQVBKMDd6?=
 =?utf-8?B?eUllYitHZVNSSjF6MU5DYlpZaFBiNlJTdDVwSVRUai9vaGFSZWRmQ1NDNEJD?=
 =?utf-8?B?TUdTdVdRUEs4MWcxWUFreXVmMDJZY0wwNG5lTU9NbnJwV0ZnMng3NnNmeUY2?=
 =?utf-8?B?aXlmQmNXN0F2SnQ2dlpoSmtKcnluVDE2U1RkdFp4dHJEZFpkZXpCMHJhQTNa?=
 =?utf-8?B?QVRyemh3L1h6TUEraW5xbks0Z3FoTTMvR0pEYThUa2JXemhaTU9aY0FNa0d1?=
 =?utf-8?B?dTR1TXZDazZNb0Rzd2VybG1weUlsUVlhRmJGSGxlVkNxNHlWNXQ3czNrN0c5?=
 =?utf-8?B?cnBNWndyMGd2cmFEcG9xYjB5SmFYMHB2dHVCYjM3UVU5bkY0VE5aMXVpYS9F?=
 =?utf-8?B?RlF4eCtGREVOYWNuRnh3KzBWNlJ6QWNaZ21XT3c2U2MwQUh6QWwyOUYzYkVX?=
 =?utf-8?B?OURBck0rVUl5elNGTUxqcGE3eFBPUU9yT01FcHhlWVE2aTZwVVVzUVRORDQ2?=
 =?utf-8?B?Q1crN20vNUFPZERsTGRJaTl3dVVKL00zM1dsYnJROWpFVHpGS3RCa2w4WTlM?=
 =?utf-8?B?S3FYZjNnVFA2ZXlxVzdhZ044aW9hSnFCYUJtRWR4Q2dGZHgxZmllNzhHZkZY?=
 =?utf-8?B?U3RtUnpGNzRLbzUxZmlwem0wbHFkcC93NWtiUUxnTUhUQlVFVVVnMDRiUzBP?=
 =?utf-8?B?RllwWkREZGdWd29OeXB4QU9NdkhPa09mc3Irekd2Mm11MTgwN3hIQk5wYkdm?=
 =?utf-8?B?YnZqNUZJNGNDOHFlWWc5aEZmY0hpakZBeE00akxGclZTTVhKOGFGQ2lSQkJB?=
 =?utf-8?B?TlpuQktmd0ZqYVhRaVpMUGRpQ3BNR1VMcG96SmlwcGxsV1JSRFd1UXUxK2gy?=
 =?utf-8?B?a0F2QktlR1I1a0M0RFdjSVRydnkrMEgwMkZGMlZkaGtHY0JMMitsbGREV1dZ?=
 =?utf-8?B?MHQyc01UMWkrMGFnQ21HbHYvdVg5ZTZsTHdhTVdmMFhJZ2ZpT1VzelBTRktY?=
 =?utf-8?B?WiswRjF6MGlKeFVGSlRQY3RkZ1kvdlVKeE1Sc0Z2MmFPWmxaNHVvY0pMLzV3?=
 =?utf-8?B?Yk1kZ2RRN29LcWMrdzZZRVQ0cmlQN3NWU01zZVZvN281UXJZSGliUVZyaGwy?=
 =?utf-8?B?R2ZlVTMrN0Q1eERCeUVEWnhFSjlsbFdwdHFiZUxFUnJGSy8yaWJ6L3krL2Fo?=
 =?utf-8?B?NnYyRzV4KzNkNVBpK1lSVXhtOTlsM2YzOEJUVlhtc1lYUTg2eXdJbC80UlMr?=
 =?utf-8?B?bUlsRXlva2diNDlkakVQbE5ERE9iUlBUb1d5M1VUMFNNZ3dvZGJHNDNuc1By?=
 =?utf-8?B?b2xORXV0NllFa0pLbjhxQlM0Vko5NlMrT05RM29JSloxZW9IZXBGN2RLRy8v?=
 =?utf-8?B?dnp5SjZzRjR0S21CV09OZXFCczUzYXJBR3IxMTU3dWxFUVZ6OTlrWnhleXBM?=
 =?utf-8?B?QVBkdWd2em8yZTlIRWU0NktBY3V0MmI1ZkRacmFvM3VNcDFYYVZFejdKSCtX?=
 =?utf-8?B?UTJjMEFJRy8raXNaR0FtTWc4SU8wakJiUEpCZzc3SjBTZm92TlpPaEt5NXdk?=
 =?utf-8?Q?/VcmjilLtdfiPKHMxf4O5GhfbRgbZ3iblkbru0p?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6835e7-3ee3-4a13-6c03-08d983c512ab
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 03:47:49.5865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdoMtn7c2iS6nhMELzjou2GaODB4+NmC+AvjfR1WZZJmWNED1uN5p/8IMKNdxcJHFZtnNbLvwRC1z0dcHdWImexjBLOxn28bDa/6n2OXVkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2990
X-Proofpoint-ORIG-GUID: 3fm5dsXJhEGWKbv7sxou6vLFmSaS9Yd6
X-Proofpoint-GUID: 3fm5dsXJhEGWKbv7sxou6vLFmSaS9Yd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_01,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300021
X-Mailman-Approved-At: Thu, 30 Sep 2021 07:43:59 -0400
Subject: [lttng-dev] with -Og option, lttng-ust compile failed on 32bit arm
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
From: Changqing Li via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Changqing Li <changqing.li@windriver.com>
Content-Type: multipart/mixed; boundary="===============4902685823292740789=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4902685823292740789==
Content-Type: multipart/alternative;
 boundary="------------4520D624DB8FE57BD18AD973"
Content-Language: en-US

--------------4520D624DB8FE57BD18AD973
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

The problem happened after upgrade to lttng-ust 2.13.0.  2.12.0 don't 
have this issue.

liburcu version: 0.13.0

gcc: 11.2.0

This is my reproduce steps, it is cross compile enviroment based on 
yocto project.

 1. git clone git://git.yoctoproject.org/poky
 2. . oe-init-build-env
 3. echo "MACHINE='qemuarm'" >> conf/local.conf
 4. echo "DEBUG_BUILD='1'" >> conf/local.conf
 5. bitbake lttng-ust

compile failed with error:

| 
/work/cortexa15t2hf-neon-poky-linux-gnueabi/lttng-ust/2_2.13.0-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi/../../libexec/arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/11.2.0/ld: 
../../../src/lib/lttng-ust/.libs/liblttng-ust.so: undefined reference to 
`_uatomic_link_error'
| collect2: error: ld returned 1 exit status
| Makefile:399: recipe for target 'test_ust_error' failed

checked with "nm ../../../src/lib/lttng-ust/.libs/liblttng-ust.so" | 
grep atomic, we can see 'U _uatomic_link_error',  but since -Og

is used,  liburcu don't define this function.

[snip]
#if !defined __OPTIMIZE__  || defined UATOMIC_NO_LINK_ERROR
static inline __attribute__((always_inline, noreturn))
void _uatomic_link_error(void)
{
#ifdef ILLEGAL_INSTR
         /*
          * generate an illegal instruction. Cannot catch this with
          * linker tricks when optimizations are disabled.
          */
         __asm__ __volatile__(ILLEGAL_INSTR);
#else
         __builtin_trap();
#endif
}
#else /* #if !defined __OPTIMIZE__  || defined UATOMIC_NO_LINK_ERROR */
extern void _uatomic_link_error(void);
#endif /* #else #if !defined __OPTIMIZE__  || defined 
UATOMIC_NO_LINK_ERROR */

[snip]

we cannot see 'U _uatomic_link_error' in following conditions, so 
compile successed:

1.  without -Og(using -O2),  + 32bit arm

2. -Og + 64bit arm

3. -Og + x86/x86-64


Do you have any idea about how to fix this? I don't understand why only 
"-Og + 32bit arm" will call function _uatomic_link_error.

Thanks

//Changqing


--------------4520D624DB8FE57BD18AD973
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi, <br>
    </p>
    <p>The problem happened after upgrade to lttng-ust 2.13.0.&nbsp; 2.12.0
      don't have this issue.</p>
    <p>liburcu version: 0.13.0</p>
    <p>gcc: 11.2.0<br>
      <br>
    </p>
    <p>This is my reproduce steps, it is cross compile enviroment based
      on yocto project.<br>
    </p>
    <ol>
      <li>git clone git://git.yoctoproject.org/poky</li>
      <li>. oe-init-build-env</li>
      <li>echo &quot;MACHINE='qemuarm'&quot; &gt;&gt; conf/local.conf</li>
      <li>echo &quot;DEBUG_BUILD='1'&quot; &gt;&gt; conf/local.conf <br>
      </li>
      <li>bitbake lttng-ust</li>
    </ol>
    <p>compile failed with error:</p>
    <p>|
/work/cortexa15t2hf-neon-poky-linux-gnueabi/lttng-ust/2_2.13.0-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi/../../libexec/arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/11.2.0/ld:
      ../../../src/lib/lttng-ust/.libs/liblttng-ust.so: undefined
      reference to `_uatomic_link_error'<br>
      | collect2: error: ld returned 1 exit status<br>
      | Makefile:399: recipe for target 'test_ust_error' failed</p>
    <p>checked with &quot;nm
      ../../../src/lib/lttng-ust/.libs/liblttng-ust.so&quot; | grep atomic,&nbsp;&nbsp;
      we can see 'U _uatomic_link_error',&nbsp; but since -Og <br>
    </p>
    <p>is used,&nbsp; liburcu don't define this function.</p>
    <p>[snip]<br>
      #if !defined __OPTIMIZE__&nbsp; || defined UATOMIC_NO_LINK_ERROR<br>
      static inline __attribute__((always_inline, noreturn))<br>
      void _uatomic_link_error(void)<br>
      {<br>
      #ifdef ILLEGAL_INSTR<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * generate an illegal instruction. Cannot catch this with<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * linker tricks when optimizations are disabled.<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __asm__ __volatile__(ILLEGAL_INSTR);<br>
      #else<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __builtin_trap();<br>
      #endif<br>
      }<br>
      #else /* #if !defined __OPTIMIZE__&nbsp; || defined
      UATOMIC_NO_LINK_ERROR */<br>
      extern void _uatomic_link_error(void);<br>
      #endif /* #else #if !defined __OPTIMIZE__&nbsp; || defined
      UATOMIC_NO_LINK_ERROR */<br>
    </p>
    <p>[snip]<br>
    </p>
    <p>we cannot see 'U _uatomic_link_error' in following conditions, so
      compile successed:</p>
    <p>1.&nbsp; without -Og(using -O2),&nbsp; + 32bit arm</p>
    <p>2. -Og + 64bit arm</p>
    <p>3. -Og + x86/x86-64</p>
    <p><br>
    </p>
    <p>Do you have any idea about how to fix this? I don't understand
      why only &quot;-Og + 32bit arm&quot; will call function _uatomic_link_error.</p>
    <p>Thanks</p>
    <p>//Changqing<br>
    </p>
  </body>
</html>

--------------4520D624DB8FE57BD18AD973--

--===============4902685823292740789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4902685823292740789==--
