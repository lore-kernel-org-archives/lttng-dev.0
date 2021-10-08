Return-Path: <SRS0=pE/l=O4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F53C433F5
	for <lttng-dev@archiver.kernel.org>; Fri,  8 Oct 2021 08:14:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AA360F90
	for <lttng-dev@archiver.kernel.org>; Fri,  8 Oct 2021 08:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83AA360F90
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HQgvv5PxRz1KQs;
	Fri,  8 Oct 2021 04:14:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1633680876;
	bh=28R6iBql5Uzh9ggYSPzLsNc7HUOrJQhfQaH+0DTuoUQ=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ylClP5WxScseV52xbx0JQ6AXwyKoNJI7AyYXMtdY4U5lK1OA8SF/9p965HeG26rzv
	 IDkirytxsw/S2d+5RqXsiPdlXn0clwEiMiVeCTYCDJOpP84g5HrJzzcYuw6qJkrDdY
	 76Prnx24trktwXC5XJlzWJgvNbSya9bjB+x4jABMumC8LQOnK5t/OYtVpNY4rLaEh9
	 9mZNVfzTOD5F5QOqCrjaFNXsGD3WkVsQBw8f1fnhzKvWMiz895IWD4bd+vzQ/JFxna
	 YGL/hqGCwjSMzo76DOieDln2vAUvAtFlYIsCA5i7xqvOF1tIZafk3OFEPLuUsENjh0
	 gszVlMRmmATYA==
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4HQgvt2Vtrz1KTC
 for <lttng-dev@lists.lttng.org>; Fri,  8 Oct 2021 04:14:34 -0400 (EDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1987b3eo013332; 
 Fri, 8 Oct 2021 01:12:37 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-0064b401.pphosted.com with ESMTP id 3bhx4n90jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Oct 2021 01:12:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMBM/ONd92bRrRt0eu3rt4abkFr0SzQNVzYFthAw6spe2NjaaGAe+mD1tmq81nXenjhklQZaiefpsRhhYK5aocXprg3gjg/nomaBu1JqBPEKvoUo9haMXIo7UL3cyJ/c/78lzixyxqSUKc2No2UXctHH/gsap/ixH+3+UPgVnI2mqe75LImET/nyFSJRnKtlD4C7mkJYvldsrgMkr7TS7Sz81FHYN07XGaLdvo8Cy41CG7vvzWrBg3Qz+rC4YBEua4Tcn2yVoBkF2K8OvjkxDRNJP7wesONMcuy7tfyjoum9uTVHJ8eATi/j5C52ryHohQjrmsttGC4W2YzhqxwIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbejRx7SEQ09zOgcPBtVsll+ryOaJ0GqSqEZS6Mh6hc=;
 b=cDR9kSKhr5VwTr6DDVYGVyk86TKfAr4UBIBK75eW3o37xFS2VKqKorQFjUyfSXUTkM6RpEG05v+6Ua7iDGdbPN5B/U7OYfiGiHHeYvBEAN1P7q1sc1DM0cr80UW+I4Vw7NbZDa/Q5NYOQbXontOGaEFXf3PcxQiY9U58Z67qH/DAfqBUFjQEgBOXblQe+Tex113Zkx9lbmV046GYqvYIhEkPNK5n/Ypw/T6kfnQPpoeRDC9wA8l8QqZSITETRgi/oyavTBSjVO57HDeBjyKxTfhzuxGEVNOBBumdeIvGyetCuHyo0ba+oIoJAQ7KHf7WJi1Nkv6Skdweq876kIJCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2557.namprd11.prod.outlook.com (2603:10b6:805:56::33)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 08:12:33 +0000
Received: from SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::a544:19b6:196b:f339]) by SN6PR11MB2557.namprd11.prod.outlook.com
 ([fe80::a544:19b6:196b:f339%5]) with mapi id 15.20.4566.025; Fri, 8 Oct 2021
 08:12:33 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
References: <0c4c0d31-5551-b84a-386c-32990b128f09@windriver.com>
 <613136200.45770.1633007697070.JavaMail.zimbra@efficios.com>
Message-ID: <6b8c43e5-758c-d73e-ec0a-0196b3e2be65@windriver.com>
Date: Fri, 8 Oct 2021 16:12:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <613136200.45770.1633007697070.JavaMail.zimbra@efficios.com>
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To SN6PR11MB2557.namprd11.prod.outlook.com
 (2603:10b6:805:56::33)
MIME-Version: 1.0
Received: from [128.224.162.189] (60.247.85.82) by
 HK2PR02CA0184.apcprd02.prod.outlook.com (2603:1096:201:21::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20 via Frontend Transport; Fri, 8 Oct 2021 08:12:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a188f89-3c55-4ec5-9cb0-08d98a33612c
X-MS-TrafficTypeDiagnostic: SA1PR11MB5923:
X-Microsoft-Antispam-PRVS: <SA1PR11MB59234CC210ACFDE6D16782D082B29@SA1PR11MB5923.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUxuIzVW2vujHAIbHpcuzXaEz3+/TO6RH+PpAeHf8Z191VNZBXJK7AhR5REZxdA24+Ea65FH99/+o/RADDt2SqoCAjgy/IeTcZakrSUM2G4JU07PrZf2i56jq2EY3194egTzcG1A7LKWmbBbeQByRXlXW16oconGXHd2T1gOY+7CaIGmOIVcGKo9aBhf8z1mMNApnggzTsRbUPY9tJlX4sIUGpOBAy+nSPuhV/Seyg2mfSXWTBm1Q58DY0Rusm4o8d4p6FpNsqo2w4rm8yUt2Ed6vdFArKgzvYSTHj2TGWCnYp7UEgph9SWACrs/4/6g2N7oVKzfPv5Z6VegsAqxaYiszwX6zdakMs+tD7AekxMC9Kzxs9Mr+bTLnTHxEY4AfJd4V+RT1h3P0Bdlng82umEJ1GEQT/W8HqpTbiAYD9aymolgqFeIz2cvTrIi+LNurVIDww7aFaxDz2C3D/QnRC/4pM5mTYQTERf4MTWMtdxLRJj+lJX1EEQ81xFNtbPolkwU3DDdMH3edxMDcbbHNBTnB3zerk6w8NFxYqxvSCLSPU8bGsnZU83KQFT48KzoMQ+b/X8I+NisplY/4/H+z2HJKAs+DzbeWTEEWVzk8Uy2uxxTf9Q9KImJh7WjMROQdayt7dPONt+RfZd4ac2LZrTmp479bIcrAfmsIj/cYsgzpD+pe3Zge4JWmy6mQjWHV34EE1RgOpZDXf8MiUQaNCk+pjY7MR4XzwUAUyIcAqG4kQwBYfCKkmJYgALwPvEa+OwUgLtWdBH0+KZqYA5T91un9bWy6n4CLOMuUkN7vWauTDTJQHVCB8gWxByvVm0plodYtw7eiKJME6fNWGoyLqWjirE6/UmDUD/ncykvzVP5D68yRdfuy/iBZfE3xSPr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB2557.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(31696002)(6666004)(186003)(2906002)(316002)(66946007)(52116002)(38100700002)(38350700002)(33964004)(66556008)(53546011)(86362001)(6486002)(508600001)(166002)(26005)(83380400001)(966005)(31686004)(36756003)(8936002)(5660300002)(16576012)(2616005)(956004)(44832011)(8676002)(6706004)(6916009)(4326008)(78286007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R213R2ZTVS96YzFJRkpCQ0xyazBsM215VGZWWjlDcnhBZWNTbjZTVm55dG5T?=
 =?utf-8?B?d3RzdEpBOUlHSGdiR01jWG9KNExwV2lkdlBPNWgyQXJ5MkFrbGtLK2ZVdnhS?=
 =?utf-8?B?Q3ZVZUNQSm1qdXN2anRscEVvY3l4TlBYRC9rQXB2U24rK1VSdVZCcEpyM0pq?=
 =?utf-8?B?NCtieVFIb3lzRlJGR3JjL0pZUEE0YitNcDF3U2wxQTc2YkZtQ1VscEZQOW5l?=
 =?utf-8?B?ZG9TSkFYWXMrcFpIbTJVSmhxSFEvUGZBbTRMMzBtaEdiWVliaXFVU0R1OXFF?=
 =?utf-8?B?Y0NXZ0ZBY2dFZEppSWNHNkltY1RwNXhRQm5uRGZtUDJ3T0xIRXozT0lBSDhK?=
 =?utf-8?B?U1hEM294VFVrNXk0Snk2WnlaMkd6TEhCL1RyV1l4ZlRHRmpDbW1zRHNhbDFO?=
 =?utf-8?B?d1NPOXdZL2c2S2ttNmtlVGtEcmxydWVxa1Jia3ByR1N5ZXZ6bGJzOSs2bXk3?=
 =?utf-8?B?M0NHNGU3SFM5bEExSW1MMkZwcXNIYlBVaFdzMkEwRmJ2a3prb1N2YmFjTWRy?=
 =?utf-8?B?aWlScnZTTUc5RUR5UGI4cjBTN1ZFeDBFbTZmais1SmJIRVdOdE15TWZHRXds?=
 =?utf-8?B?NElJQnJJZWNYZDNrUWJHL0ZXUUNtUnQveFhUN3pTdGtqSjlyaThhTFR4TE5m?=
 =?utf-8?B?MlRKQUxIRGNTRzN3dU9EUVB0UGw3Mmx6YmtpYmc1NGhFV1Vob1JTWDZlaTAy?=
 =?utf-8?B?UHpodGVSc0tlZVVZL2JVN1dwemlxM05reG50VWI1ZXJVbFBRdlpRNEFSWTNI?=
 =?utf-8?B?YWtqSTFnUU5kLzh0dHBlVlkvTERud0FaMkdpRVNiZTNET1pRZldvcHprUnFj?=
 =?utf-8?B?dGZoOUtPeFJvRGRSTGFmd1dDYTU4OXJ6cFlDblNTZjh2YzhpS1FTWG5kWURr?=
 =?utf-8?B?SEpZcS9BNnhCdnZ0STJTQ3VlaWRMMFR2enQ1OTNEaXVmQktHUmV4U1Zad2o0?=
 =?utf-8?B?UlhPZmlnb1lBMVpjbk5RRUo2K21vYU1IQkF0ajNOSHVnTFNyZUxqTmpySWxv?=
 =?utf-8?B?bFk0K1RRT2taQkhRSjdERjc1V3RrZXNnSHUyM2cyVHBTOVJ0MzVxYjJLa3NB?=
 =?utf-8?B?a1p3QlBMZzFoZ2wzQUJqTUMvSVhLQVpQN1hZUlJKWGw0OTJuTXozb0tEZlQ2?=
 =?utf-8?B?K2RVdWpYaUUyUldYcWhGQ1NPMmtFd1FReTBvT3Vaa2RVSUNLYzdPOU9nOUJV?=
 =?utf-8?B?M0pGOFhJZWRxMExKTk1qaUZSaUdTUzl0M0RrL2hHVDNYZURSNStONUt3VTdW?=
 =?utf-8?B?cVFzZkJITlRrSmhDcEJCLytsdTEvb3NPWUluYSsxazVkNFA3dTlWYUpEMngv?=
 =?utf-8?B?bGxRbzhOemZhdnJINmhKSVJaREhhRnVqQlM2clZhdDVaZ3gwenA3ZnZJaGVJ?=
 =?utf-8?B?S1dCbU1Rbzk5SmJIUHh4aFU4Z2JLbFFvYndMbFBLYmFWbitKeGxiRkVZWkZr?=
 =?utf-8?B?Tmg0NDZHblZiQXZiUGtWMlBNOFpQZ05DaStvSGVaaW5RZDJvZTU1V1FaZmc0?=
 =?utf-8?B?Nlo1Wi9nYmczMVV1eXZ0ZFcySUxFQ1dNeEpMVEdkNjhRSk5WNllZWGlMYmlY?=
 =?utf-8?B?MnBQeEpyczhXdzRnb2NnQm9Dc2xPblZqeGgwcjhTN2Y5NFppZVcvR1VrUkRV?=
 =?utf-8?B?TnBNd1NKSHFQekFiSFcxUWhRN29jS1luNENIQThWNjB2S3lnTjBaRE52L1h4?=
 =?utf-8?B?VThwc2lYcFpnSHlGK0FNU1RpOU9RRjQrd0JZMWkwbUlLanpPQytrNjU2VlZU?=
 =?utf-8?Q?hXQDoV6EKu/Qwmh2cALc7RPeNlH9gxzBj5GDVWt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a188f89-3c55-4ec5-9cb0-08d98a33612c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2557.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 08:12:33.0603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQdW7ErQAXamx+Er5ox9beX4GbNJlzREn6GJGQHyOEru9zYlxxP4K4HouxDfUhIqCXZVJSkB4XJipa2S1+XeGtmKHJ+/HhEwb9XURyPzboI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-Proofpoint-ORIG-GUID: UmxwiwtRvKTgzQo4mCAQLpfS7k7dPQb_
X-Proofpoint-GUID: UmxwiwtRvKTgzQo4mCAQLpfS7k7dPQb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080050
Subject: Re: [lttng-dev] with -Og option,
 lttng-ust compile failed on 32bit arm
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
Content-Type: multipart/mixed; boundary="===============0456853090352659194=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0456853090352659194==
Content-Type: multipart/alternative;
 boundary="------------4B8A72D366D81FBC35BCBCBC"
Content-Language: en-US

--------------4B8A72D366D81FBC35BCBCBC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/30/21 9:14 PM, Mathieu Desnoyers wrote:
>
> **[Please note: This e-mail is from an EXTERNAL e-mail address]
>
> ----- On Sep 29, 2021, at 11:47 PM, lttng-dev 
> <lttng-dev@lists.lttng.org> wrote:
>
>     Hi,
>
>     The problem happened after upgrade to lttng-ust 2.13.0.  2.12.0
>     don't have this issue.
>
>     liburcu version: 0.13.0
>
>     gcc: 11.2.0
>
>     This is my reproduce steps, it is cross compile enviroment based
>     on yocto project.
>
>      1. git clone git://git.yoctoproject.org/poky
>      2. . oe-init-build-env
>      3. echo "MACHINE='qemuarm'" >> conf/local.conf
>      4. echo "DEBUG_BUILD='1'" >> conf/local.conf
>      5. bitbake lttng-ust
>
>     compile failed with error:
>
>     |
>     /work/cortexa15t2hf-neon-poky-linux-gnueabi/lttng-ust/2_2.13.0-r0/recipe-sysroot-native/usr/bin/arm-poky-linux-gnueabi/../../libexec/arm-poky-linux-gnueabi/gcc/arm-poky-linux-gnueabi/11.2.0/ld:
>     ../../../src/lib/lttng-ust/.libs/liblttng-ust.so
>     <https://urldefense.com/v3/__http://liblttng-ust.so__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwolB77-gw$>:
>     undefined reference to `_uatomic_link_error'
>     | collect2: error: ld returned 1 exit status
>     | Makefile:399: recipe for target 'test_ust_error' failed
>
>     checked with "nm ../../../src/lib/lttng-ust/.libs/liblttng-ust.so
>     <https://urldefense.com/v3/__http://liblttng-ust.so__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwolB77-gw$>"
>     | grep atomic,   we can see 'U _uatomic_link_error',  but since -Og
>
>     is used,  liburcu don't define this function.
>
>     [snip]
>     #if !defined __OPTIMIZE__  || defined UATOMIC_NO_LINK_ERROR
>     static inline __attribute__((always_inline, noreturn))
>     void _uatomic_link_error(void)
>     {
>     #ifdef ILLEGAL_INSTR
>             /*
>              * generate an illegal instruction. Cannot catch this with
>              * linker tricks when optimizations are disabled.
>              */
>             __asm__ __volatile__(ILLEGAL_INSTR);
>     #else
>             __builtin_trap();
>     #endif
>     }
>     #else /* #if !defined __OPTIMIZE__  || defined
>     UATOMIC_NO_LINK_ERROR */
>     extern void _uatomic_link_error(void);
>     #endif /* #else #if !defined __OPTIMIZE__  || defined
>     UATOMIC_NO_LINK_ERROR */
>
>     [snip]
>
>     we cannot see 'U _uatomic_link_error' in following conditions, so
>     compile successed:
>
>     1.  without -Og(using -O2),  + 32bit arm
>
>     2. -Og + 64bit arm
>
>     3. -Og + x86/x86-64
>
>
>     Do you have any idea about how to fix this? I don't understand why
>     only "-Og + 32bit arm" will call function _uatomic_link_error.
>
>
> I suspect it depends on which optimizations are being enabled at -Og 
> on each architecture.
> The "_uatomic_link_error()" trick indeed depends on the compiler 
> optimizing away
> unreachable calls.
>
> If you really intend on using "-Og" on arm32, trying building with 
> "-DUATOMIC_NO_LINK_ERROR".
> It should take care of making sure to generate an illegal instruction 
> rather than rely on the linker
> error.
>
> Thanks,
>
> Mathieu

Thanks.  I have tried with "-DUATOMIC_NO_LINK_ERROR".  With this,  it 
can compile successfully.

Changqing

>
>     Thanks
>
>     //Changqing
>
>
>     _______________________________________________
>     lttng-dev mailing list
>     lttng-dev@lists.lttng.org
>     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>     <https://urldefense.com/v3/__https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwqteQD9FQ$>
>
>
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com 
> <https://urldefense.com/v3/__http://www.efficios.com__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwo9O85jiQ$>

--------------4B8A72D366D81FBC35BCBCBC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/30/21 9:14 PM, Mathieu Desnoyers
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:613136200.45770.1633007697070.JavaMail.zimbra@efficios.com">
      
      <div style="border:solid #9C6500 1.0pt;padding:2.0pt 2.0pt 2.0pt
        2.0pt">
        <p class="MsoNormal" style="line-height:12.0pt;background:#FFEB9C"><b><span style="font-size:10.0pt;color:#9C6500"></span></b><span style="font-size:10.0pt;color:red">[Please note: This e-mail
            is from an EXTERNAL e-mail address]<o:p></o:p></span></p>
      </div>
      <div>
        <div style="font-family: arial, helvetica, sans-serif;
          font-size: 12pt; color: #000000">
          <div><span id="zwchr" data-marker="__DIVIDER__">----- On Sep
              29, 2021, at 11:47 PM, lttng-dev
              <a class="moz-txt-link-rfc2396E" href="mailto:lttng-dev@lists.lttng.org">&lt;lttng-dev@lists.lttng.org&gt;</a> wrote:<br>
            </span></div>
          <div data-marker="__QUOTED_TEXT__">
            <blockquote style="border-left:2px solid
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
              <p>Hi, <br>
              </p>
              <p>The problem happened after upgrade to lttng-ust
                2.13.0.&nbsp; 2.12.0 don't have this issue.</p>
              <p>liburcu version: 0.13.0</p>
              <p>gcc: 11.2.0<br>
                <br>
              </p>
              <p>This is my reproduce steps, it is cross compile
                enviroment based on yocto project.<br>
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
                ../../../src/lib/lttng-ust/.libs/<a href="https://urldefense.com/v3/__http://liblttng-ust.so__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwolB77-gw$" moz-do-not-send="true">liblttng-ust.so</a>: undefined
                reference to `_uatomic_link_error'<br>
                | collect2: error: ld returned 1 exit status<br>
                | Makefile:399: recipe for target 'test_ust_error'
                failed</p>
              <p>checked with &quot;nm ../../../src/lib/lttng-ust/.libs/<a href="https://urldefense.com/v3/__http://liblttng-ust.so__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwolB77-gw$" moz-do-not-send="true">liblttng-ust.so</a>&quot; | grep
                atomic,&nbsp;&nbsp; we can see 'U _uatomic_link_error',&nbsp; but since
                -Og <br>
              </p>
              <p>is used,&nbsp; liburcu don't define this function.</p>
              <p>[snip]<br>
                #if !defined __OPTIMIZE__&nbsp; || defined
                UATOMIC_NO_LINK_ERROR<br>
                static inline __attribute__((always_inline, noreturn))<br>
                void _uatomic_link_error(void)<br>
                {<br>
                #ifdef ILLEGAL_INSTR<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * generate an illegal instruction. Cannot catch
                this with<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * linker tricks when optimizations are
                disabled.<br>
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
              <p>we cannot see 'U _uatomic_link_error' in following
                conditions, so compile successed:</p>
              <p>1.&nbsp; without -Og(using -O2),&nbsp; + 32bit arm</p>
              <p>2. -Og + 64bit arm</p>
              <p>3. -Og + x86/x86-64</p>
              <p><br>
              </p>
              <p>Do you have any idea about how to fix this? I don't
                understand why only &quot;-Og + 32bit arm&quot; will call function
                _uatomic_link_error.</p>
            </blockquote>
            <div><br>
            </div>
            <div>I suspect it depends on which optimizations are being
              enabled at -Og on each architecture.<br data-mce-bogus="1">
            </div>
            <div>The &quot;_uatomic_link_error()&quot; trick indeed depends on the
              compiler optimizing away<br data-mce-bogus="1">
            </div>
            <div>unreachable calls.<br data-mce-bogus="1">
            </div>
            <div><br data-mce-bogus="1">
            </div>
            <div>If you really intend on using &quot;-Og&quot; on arm32, trying
              building with &quot;-DUATOMIC_NO_LINK_ERROR&quot;.<br data-mce-bogus="1">
            </div>
            <div>It should take care of making sure to generate an
              illegal instruction rather than rely on the linker<br data-mce-bogus="1">
            </div>
            <div>error.<br data-mce-bogus="1">
            </div>
            <div><br data-mce-bogus="1">
            </div>
            <div>Thanks,<br data-mce-bogus="1">
            </div>
            <div><br data-mce-bogus="1">
            </div>
            <div>Mathieu<br data-mce-bogus="1">
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Thanks.&nbsp; I have tried with &quot;-DUATOMIC_NO_LINK_ERROR&quot;.&nbsp; With
      this,&nbsp; it can compile successfully.</p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:613136200.45770.1633007697070.JavaMail.zimbra@efficios.com">
      <div>
        <div style="font-family: arial, helvetica, sans-serif;
          font-size: 12pt; color: #000000">
          <div data-marker="__QUOTED_TEXT__">
            <div>
            </div>
            <div><br data-mce-bogus="1">
            </div>
            <blockquote style="border-left:2px solid
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
              <p>Thanks</p>
              <p>//Changqing<br>
              </p>
              <br>
              _______________________________________________<br>
              lttng-dev mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
              <a href="https://urldefense.com/v3/__https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwqteQD9FQ$" moz-do-not-send="true">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
            </blockquote>
          </div>
          <div><br>
          </div>
          <div data-marker="__SIG_POST__">-- <br>
          </div>
          <div>Mathieu Desnoyers<br>
            EfficiOS Inc.<br>
            <a href="https://urldefense.com/v3/__http://www.efficios.com__;!!AjveYdw8EvQ!LLTouw-mBEBAY8hObF75ydNA3D3KMc0Hla12A4D4cQ-hm-F5lidnggb4zDVbAwo9O85jiQ$" moz-do-not-send="true">http://www.efficios.com</a></div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------4B8A72D366D81FBC35BCBCBC--

--===============0456853090352659194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0456853090352659194==--
