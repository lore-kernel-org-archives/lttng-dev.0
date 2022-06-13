Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D741AC433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 13 Jun 2022 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1655121086;
	bh=C/GB+2fQ49BLaq8tFyZqtTJGbZQv2Zotx13if4J8y+0=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=g7wqN10TlWQeLI2S0SNSalMNaFg/utISlPndQHf9UMb76IcQLhMS1qErm5x1ljn/H
	 jxkJ0lB6+HIRUMPo24m79s+k+2imqpi2q4Ik3sbFxJ2G7dm+4L2fyLdnLpO/QFhet9
	 xppe4p7sYoWXoTCVviev+dsHjnN3Vi6NGk3CBR84y6U9II2Were60pqicykil5vrPS
	 oYrGGQaM+LC4nVRH3kb57wrX//NzIIfPGibknfF35YZzOw7V8UnwtS6eTIFWleuf7n
	 O3WHvtDlDH009NmocZa2Fyz/hrXpL5FIe7h/wIXXUoZX2/SEzh3Ex609hJQRs4yFdI
	 aMbhyhNd20jLw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LM8zd6YTCz7hh;
	Mon, 13 Jun 2022 07:51:25 -0400 (EDT)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4LM8zb5kqfz81q
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2022 07:51:23 -0400 (EDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DADuad027866
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2022 04:48:54 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gmpb59aht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jun 2022 04:48:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ5f6SMdrLI6+JKu4kn8ysT2SyGk1RQwYyiwkWGmNAcRyKw5Ehi/paMIkSxHMz4PbGvstD/KeMvMbcxmVRNQtCcYwyS5YXVwIQjqAASHoKVgT+SKE7pmQii6mEDUMM0+H12/vtb0EcjZRcrQ9RLeMc5kmx/piu8Et25waAaQolUrJ4B2pCu2E/f/l5zMtPp5E5z2q1iMFpVyWYvbg0R7Ld7Iw+fM7pT9kwbbdPcl4JfVXy9X1rNg0sCTutFoz98nczLQihqmRp1Y4ywABpAGHvbzaUTcbOG9QrR9l6oHa7DA9ujb/p5rfilRj32ENvUOs00YckYpN/5KX/NwpVD7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWyBOiHltI5IXhvCstQtTDsXAHxfnd6G8ywrZ0c4lOU=;
 b=huPmRMUAIlYXmBVq+n2Pt7Hys8RfJQty+T7ozIpV0XC5vv7Qx/tdTd+8iutx0HUoDpoATtp9a2JsQUEHwXRtW47x4brRggAIwoTZcBDl5vgAuvcqiXOHBu/2sU/qs6uO/GtuY99R+tSCEMUEyYTDMmu85C/jKHt5xsXL+rFwXKziEDIBa1DmRplaMOJKg4dyj4DudCaRJDkkF/FtchR1a9SZdAE/1nKrsvA5bvhGgtFyfHYU24wAyHRN4rR2cxuaKvi4zsXUlhzVa2vigMkPNbPllsQiaaRwjvqCJxHtaHXuXXGVcVxEg16JMGqmYNDfm9Ca55HkMQD9TXY9StGGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by DM6PR11MB3547.namprd11.prod.outlook.com (2603:10b6:5:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 13 Jun
 2022 11:48:52 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8%8]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 11:48:52 +0000
Date: Mon, 13 Jun 2022 13:49:39 +0200
To: lttng-dev@lists.lttng.org
Message-ID: <20220613114939.GA276938@windriver.com>
Content-Disposition: inline
X-ClientProxiedBy: BYAPR07CA0079.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::20) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61d63d55-0eea-4e8f-5085-08da4d32aff3
X-MS-TrafficTypeDiagnostic: DM6PR11MB3547:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB35472C9937094A4F3063C12E92AB9@DM6PR11MB3547.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5u9rf2iCu2Vg8MwZ2zoQYJo5Fi2z6Lqn3ajXZuy1LMJBubRUIf//f5ZUeITPfRhbglv9uKPWk/HjKY382vqH8P+U4GDxhplNzrGymW46Ow3kbInxVTPmTxWNXflzoRwbxU6AsXiPs7lH9jBNwsY65AF9XEvJNpDo33HPDA8FUGPNan68iut8237cdfjifwvZ1BXmGGpVJKEWWFo0Y3N0Ur3IuVdV0ANo2IIJFeE6DWYB6iG9tUJZKC+7MQ3h95gKicrkd22ltOXIunFsFWq+BbLNJ4hLqj7gBLFS2Rnmb1EdT7osgWM+Nh6CP/CxL9ciSLqGdRZHbRuCicuZrRcBMbd5Y9vcAPdT5pOYYnOaBSiBq4j90EesZMGyr/eK9fUTK5ws9A1me47GEIih+slkKRWr2ErCU+UB4TuPpLFslnWnTJ3z3+fHyi4kd6E4o4Sh3AUar70ZWdcx/j2kjXn1h99WL1ebuaWEc3PcZJ8zXMMaIwS/q8Sa0O/XDkwZKV62yxXQbULDsr33ArMbIzjIRtXvoFK68IXjEfJKKg4lheKgMLJS9Y0ah1d0bBRhGEu1Q/YVJCAuErFwMHVgqlBXIMrbCi39zJ0ryjuraStSNi/9yYS4SPePM29bpo9hMwz/reI/VBjj9t2pgodAXr0bKD8/HaPnRuJTIOnXogSoH4exD0GOX33Ky6ZHck2nDW0LnKvragRKFQbroHc8dy9KaTa4S9S450GWRUpZxd4Wm2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5617.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6486002)(36756003)(6506007)(186003)(5660300002)(38100700002)(66556008)(508600001)(38350700002)(2616005)(6512007)(26005)(1076003)(83380400001)(6666004)(316002)(44832011)(8676002)(8936002)(66946007)(66476007)(2906002)(6916009)(86362001)(52116002)(33656002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ddxfqKhLdLNvofBPbYU4e3EJLol1w/uGD6y11r0JpYPbBInY7erHzb/WTJlN?=
 =?us-ascii?Q?mW789oSEL7QsUvEn0Xg3bz+P7r1jcBU8tivRLB7btJdgca0Uq3KM24JtlOik?=
 =?us-ascii?Q?ZD36XhN8cNBnDdGooJijYFL/bA8k2grRfAjCCmWO3B/uOMf11mP1m8zgiuwW?=
 =?us-ascii?Q?J3xC0SlCtRCUqQYXRA+IYnbjmdeZoRjAjXcD6nHKLjYvbFjiMLpaJHtabt38?=
 =?us-ascii?Q?ho2Ge5kykLAloBaS4EgVQX+4tq6c9xnsVHc7Qs6RqNhYs0GwV8S+cmkZHkHo?=
 =?us-ascii?Q?Ok/25cW3/0CDUvhTxQ/XnuSP+46vywB12Teru+GGFGL4+bsiMhlbZhebFwtw?=
 =?us-ascii?Q?JtouoetnQQ4SAV3zUPJ5xQsLyEuJOcRkw1LCOYjU0Q9RqrZ6jsIzC5x6sb6X?=
 =?us-ascii?Q?EQ1JNYRR7cuVr3Szf9lgfyfWvARZHf1z3jlPxOYqnNgT+gJTDwjvkidKXnS6?=
 =?us-ascii?Q?LEhunilllE/juBi9xYbsmgpamLnNJ8MPrgPZSHWbvy/v7X0lbZu1xmnqBHM/?=
 =?us-ascii?Q?kxI0ZlcgCI7wFagWDhItdt+6lpgQa0J3YxSFklOCG+TBHhbe196PQNvUvuM3?=
 =?us-ascii?Q?xrLBJMxAkUHISDvX5Y9KAMuzKZhyIFWKwGZ/RpL9/cNu/ROdUjBKeHOtSK+W?=
 =?us-ascii?Q?UKSjBeKc4mRinpld4COrfp+djNP9oi8FqVt+2+EpYW67nRSIrmlBRePCco+c?=
 =?us-ascii?Q?T/zuHL8pMSbd668RWaCoDXIjtX4J1av2FFPItgRHpoG/CD5kWkiStSVIvI9Y?=
 =?us-ascii?Q?knP9/2tf/CxQ6tk0xHx1mjfcFKzNHIN07C6CTXvSTYHi8aKX5jrwQkLcX8LL?=
 =?us-ascii?Q?Tlaioc/d6VuJ4V6VMLYTvtumBxRSt5GNed+rI5+/3Gu3qpiE6LbwUd233uag?=
 =?us-ascii?Q?9XkIpx1DMswLwGHKzKSfSEY//u5eWYF+MhfPgn1fh0H9hF5UYp9KEOWpTpV/?=
 =?us-ascii?Q?SmvbKX91llgRrWu8IeTvx6JKNeOTkuK6689ZXk5q6823fM6cj6Cti/+Hj2o9?=
 =?us-ascii?Q?FcyxJNvBMEKFr2SG9lgN71VYfi0BhhHCpkueFqy5ogVP13mSsGANN0iiJPHs?=
 =?us-ascii?Q?llp3FVwF64gYIYxSZSaO92rS0tG0ewtSqNIWEWIB1tAKy+dtoKEifkkSqGCI?=
 =?us-ascii?Q?9ORS+4yGhqJnyJtMutPKKmPZ1XMxHDvySKfX+w3V+wVIbVdCCHNYgB1bqQ1B?=
 =?us-ascii?Q?+4RUpVjYkbNcHWLuWLcfwzS/pPFACXTF1+h+0Zh5Co7CWBBdWeFmHdWkbwiN?=
 =?us-ascii?Q?fCrzblrGqPA0namJLkslh+LnPn2Bn3Z+xRCyH5dZKHKQ4rLnB2LTVpHBtMXZ?=
 =?us-ascii?Q?CnWtsMTmZO52AWVUczlU3kXboMWnaPrsTaNoZLcFq1/gzLsZ+1GQRMKZZPdp?=
 =?us-ascii?Q?vDcGdRgi0LER+gUt4KurQr5BrYpxVgji+xyV2JpNcRFuB9uilgkKgfuFzxhk?=
 =?us-ascii?Q?OxVALoofD6+6kRhHIL0YYwYXMJ12HULdHSMzJCKVUgwDajbze5zPYP4/MKU/?=
 =?us-ascii?Q?GHCB+BGZK66F8EuhuVNatoM/rNmZeMA5wDgCNUNCBt3EhvgZlmL91qssd/SI?=
 =?us-ascii?Q?6deomBgmNZCIujV0JbvdUNSyGpMpnjF+MTfPCEWbPyDe7v6w9dLlDzaH5ois?=
 =?us-ascii?Q?S/+4GY6STyq/5hxHv+63tIDjG+NsknIkyHXIOMs/31slg0hl5FPsHjlRCYLe?=
 =?us-ascii?Q?nfy3X1EzI8mSVYyvnUUE9FYPjVAwImz3WuHuRlTP3Iz7ta6R05Ge/+KVrgyv?=
 =?us-ascii?Q?6F89GJ81GqQXjUa9idjDM4MsLS2ipC4=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d63d55-0eea-4e8f-5085-08da4d32aff3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 11:48:52.4655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mAHP8/I1m2yJPeg5U2uv41ZkOj3eOZpcYvFKxbjiD9mDrss6o5UtB9K1ejdqQHoaqlbC8gWK8CZYKHJgx8/5PmNZlREvbZFpBdeFVFY880=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3547
X-Proofpoint-ORIG-GUID: NsuSTOYRt4_DHey11gNs62Dav-BHtb9t
X-Proofpoint-GUID: NsuSTOYRt4_DHey11gNs62Dav-BHtb9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_04,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=810
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130052
Subject: [lttng-dev] [lttng-tools] Removal of root_regression tests
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
From: Marcel Hamer via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Marcel Hamer <marcel.hamer@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

Since version v2.12.9 of lttng-tools the root_regression file has been emptied
to make the tests part of the 'make check' sequence instead. 

We were always actively using that test file as part of our regression testing. 
In our case we are working in a cross-compilation environment, where the run.sh
script was used on target for testing and as such not at compile time. It is not
easy to run a make check sequence on a target.

It is now also a bit unclear which tests actually require root access and which
tests do not. I understood this was the reason the file was called
'root_regression'?

Some questions that get raised because of this:

- Is there now an alternative way to run regressions on target in case of a
  cross-compilation environment? 
- Would there be a possibility to fill the 'root_regression' file again and
  possibly revert this change?
- How are tests now identified that require root access?

This has been as part of commit 9e2d9d2bae015e6748ebf8575ea602ee0fe65c62 in
lttng-tools.

Thank you in advance!

Kind regards,

Marcel
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
