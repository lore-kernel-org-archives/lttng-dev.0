Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C884FC4332F
	for <lttng-dev@archiver.kernel.org>; Fri, 21 Oct 2022 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666361057;
	bh=PQcxatTUZEVgJ6WHcI29xgGuHdF5K8k2Kz4cuDJ4v4M=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=cGtZKSx1m6Q3baoCvT4Ni260BwykCihaeGwG2aX7waayy4wWwzTnVqMA14qLwqNZ1
	 mAFqpclLm5aI7xb/fVvS5VMgt+txt88MEfLT0AqIOeItQdWtXGZHr3ZInfDiEKxt9n
	 g/8nWnUgRMLQ+BrTozYX8x5+jvX7jHK2+PYLmrUzzegpryjVaS7zy+47CCGReJkRZ9
	 JpowCfK9+mJr8yBXFe988CDMOsL+OHFG6p0vwn8AZfvSYBGMSPTF+QjJvAYz5Kk0cm
	 eVzY++b8fFKAGElQJlU61JzOgYxivl1NQHsP4falAZSrfYWNxfD9ZO2fKCy5c65tOE
	 8hWSZaqhaGFkg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Mv5mw4FZwzClk;
	Fri, 21 Oct 2022 10:04:16 -0400 (EDT)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4MtZQF6YspzCXK
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2022 13:31:17 -0400 (EDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 29KBavS1003027
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2022 10:12:46 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kavutrr4j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 20 Oct 2022 10:12:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQm8zmKSz8dFwO3gBPr/be9PK7kfk24T5yXIVQFuGd6ABpTijjmeUmnTnNofaZCaxI2wVdyovJV8zYpRPCVKy3NjEVOT1bV8xI1+zN4N6iRl98lw58SWhlHIe60n7fHpMT827/Qe9VcTBOLaUNQGaJkMK415JAbytqGXMhUqLiiW+1NuixPMebxIRGJ+OHq7KOY8ElNjr4OXPj8Z3T+b90vFOYn9NAC+iX824CoQ8WXJ6K9bOt/iBTM5e0hfiuU5S9VpW/NAqGIjLLYe9BdId2CAQ5aEEQWpKrmIj/7FN7eJ9XYKZlwYKE27yzM0Ab4QS45PZmkzbzrfWq9KJsx4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5Jmc/5WSNbKELuHyMu4gyoeEWM3CQDYr8V8scu3FTY=;
 b=a68u+GWmjzjJu5ZG2RF2LnMiu74MzGvPuVCHIbUWPCVxdzgFFgOJYESHp9pe4xQ+2kyu//eIcowKVNvauiIxelF9w9MeycBlnbKSxkPZMdOac74CGXB/lkk8cVcbeLMDibT4ed3BCeKi2Ed6j4JqGHm/x4p6eInbHE9HkxgbHE/zU7CpfDH8ixwGpp4QrAaS26vcQ5JJ37MEj+feOD4cRRmp8YVwPgM+upuxZvelP7EejXgTO6y4DGnUx3XE+LKucTwv8JPOz3SUfGaSPGY1jxJtptDwedWlOFur0Uv09xfuZDHO/pe4xrU0Bbp70Mf/VjKFSz9pf0XHdWg3aG48vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Thu, 20 Oct
 2022 17:12:43 +0000
Received: from CO1PR11MB4900.namprd11.prod.outlook.com
 ([fe80::dbb0:c503:a8bb:effb]) by CO1PR11MB4900.namprd11.prod.outlook.com
 ([fe80::dbb0:c503:a8bb:effb%6]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 17:12:43 +0000
To: lttng-dev@lists.lttng.org
Date: Thu, 20 Oct 2022 19:12:26 +0200
Message-Id: <20221020171226.3450-1-mikael.beckius@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: SJ0PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:a03:338::29) To CO1PR11MB4900.namprd11.prod.outlook.com
 (2603:10b6:303:9e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4900:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c818a1-5e2a-49fa-79c1-08dab2be4d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iD8Xu8Mx//npA9UnNcFZHHZiBPYw4U82mXDT6HeHHc0Au/Pbjtx0pScQnysTRRl43rDFf8ZqaFoioEstV++beZIW1EnzuPkwBP1O8wUNCdog3KIGrh8d+WjYrKjG2F0mv8I99V/pdSIBdVrQDrYbENcjxjZQSwM1SdxiLmATLW4b/qewTEKGOXx03VmPRM1lUQjRTM0Vqk6ztTDNGbYUaJq0aDja9Hdm39rXs/APm8dy7T8HlFOCKqob5kIj+tIAzU+9sMTYmF2216MnsQnON1+f2juKQtHl2i+d5C7iqoOiuPHA1kZHWSlctyk4BwEIeoy/fxqh4pLkwCmNmUh2ONZKRVgeiAsOJxqbZ1PwJEmZZM5W3dGPlgfgjQmFJG066TqvYKc5xTFNQBLlTft2XcbNMUWM/mN0nuDTxgv1LYaFN5AXCVhT2EHU8ecTbKoB8dUtRA5cYDBxq0+jxFGUS/rQXbBNTFhK7HaBjGRtlpoFClTtprO2Cit/cW4Xjoin9as5z9WY1uRNn+gjPSEwY9uyvnbVPzOXj0JOMQUsc40uG5/RU8ckoor0mwAJkPt3UXzInviTrI6XGRPD5QmGYtJwIla9cwkJrexlayR55gXFtIFYR/1+Dn9XcfCoIQObLKjLUZo/vjsOI3tzFvwkPHaI1jSktZyOilghN7NWkgRib4L+JL7mYdNIH8oRiucPEIUu4Rhne4KuCCgIpjl5DWW0r6MGeIDniMVXhTNcRplPQQf41nzl8Dvf0c9gCJjQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4900.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(366004)(39850400004)(396003)(136003)(451199015)(38100700002)(6916009)(86362001)(44832011)(66556008)(66946007)(8676002)(66476007)(26005)(83380400001)(41300700001)(36756003)(52116002)(6506007)(5660300002)(316002)(8936002)(6512007)(6666004)(38350700002)(6486002)(1076003)(186003)(2906002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfBNTL9FkAsut8jfDGgCylFygTAo6/v3T/rxeYnyrqa8mM+akhcdT/qoCLab?=
 =?us-ascii?Q?z12p/lwfWatJVAM2y+w3DNaUKytmb4w5aw0M05qO8dQTrIGhKEpjXgH7LM9C?=
 =?us-ascii?Q?IMkjJsZy4dxNNZaB3dQZvWb2zD9Cc0KY3B9vv05MIyjggYo5wcRQerQgWLSX?=
 =?us-ascii?Q?eM0rFwvKKQgx+wAeb8dgcA3ruay5dF6WDn0Wb/wu9zIngVaa/BKYj2hL+Dy+?=
 =?us-ascii?Q?VbM4MhK/D+PCVahYX+Eoz+gf5ye3/HcvpS4FhWV5G3DN20xcEgAKIa2NCii8?=
 =?us-ascii?Q?veEwCouiAAmpBYhv5OE7BkKaMe3yEGb1LaUB3tJSROFeQHOC5VhEoRfz9DzY?=
 =?us-ascii?Q?vlVvBjya4bjaC6h1n0hm+Od0PX0c6U+k09Q+wpdEw29BLCFWGYvSeuwIW2ZE?=
 =?us-ascii?Q?ZfFmkaiIyCtzK33qK+rhrwapxweoIO92lZHNH1A6nV2YMxdNtInu8agrqwIP?=
 =?us-ascii?Q?ClSjESd/fIkkF9xTqWWy1K2lfgFkZt3/q5LYCNxgaYf09HBZ2pXFPbimIIAX?=
 =?us-ascii?Q?0FLMdUPATyuX14jJFKu/taG0PuaJU22TckRebr1hPUHQZLY/A0WzdpqGDkhJ?=
 =?us-ascii?Q?1w82fCN7oFo7ZheMTUCjcZ4ktODm60sgkM2Crtj6FIDDycuZ2R3Ik497Vifm?=
 =?us-ascii?Q?r4+XvfD2yIIQpwJaK1fHKToaaaVf82wLIugIA2KyC/L+q2o6yYO5llGwP7c0?=
 =?us-ascii?Q?CbP4JH0L+WARn6HvHoxd3dUln7UVDX0xMwru1q1vRsHoZT2Zp6fya0VdEQiq?=
 =?us-ascii?Q?L8TsoJ0IoVCSs9RioczMC0qRzdb4ZzpzMt14cPgsqNCTAU6wohs6GMzqwREg?=
 =?us-ascii?Q?nhjRi9WDXCL8tiC2bejQOhintERgtwBsr5ER3yirGjbyYys+LLf5rLPM89Sw?=
 =?us-ascii?Q?DIr3A+ny8hEZsgH85l17uYv/KU6QsURKGwAtR59A4On0widFb1mu0Zj486vZ?=
 =?us-ascii?Q?T95/cnBtHerPwm7ZrcfrwweDmZENGmRWw8u+TGsNrNjq6r5DdYQqvwkIw2jK?=
 =?us-ascii?Q?aZVbVZEtsYbVVbBntv61cJdyG5Zsda2hJYSB1h3FKHFuqVNMU7iWbHk6N6V1?=
 =?us-ascii?Q?MJ0YPBSj7vPtJBnpT54uPemiTqTfU6Pycb7TfZnmeD/4qdch0EHp17rKf6pZ?=
 =?us-ascii?Q?QqK136rrUwS/NhBf8uNRqdk8vcdHhN4CRySbeHC/AvfcpgqMw37w7lvirT8d?=
 =?us-ascii?Q?+KxD/C1Wp70QOrzl7t3vg2div2GRuxo360+IKJBHz35Va/KmzJ/KmGTyQwHB?=
 =?us-ascii?Q?KSy3vsntOwbeTqg/obV6Onodj0BPIsl0Snt/SRkRjuP+4qWuEupxy/j2mDLZ?=
 =?us-ascii?Q?6ffnX8GjKrLXRS6gloUQ0Fngg8k+eGx36nIR7s+0P+Eanw/QjM1IzkNQJhIs?=
 =?us-ascii?Q?8DAeEC43YqOhtesOuk06TlVyx0Q1NlyUV547C0KuFNUWVIkxYBstppAIlxEz?=
 =?us-ascii?Q?IVLxgEMvKZt3PgYtEK1DGodgauM0FVzLCQNTIj+kbZx6aNEi529QxcwnW1vd?=
 =?us-ascii?Q?X3bYedZwW9ef5TQNAoftn44mWZOMZgXOJv9VYeyAKxJziwjeQ7qoWBMnBnrW?=
 =?us-ascii?Q?wQ7jWlbsIJ+/JEz0nKXtvlJM73g/l2ctqpNEfkYtqAftS0HPaNiJf8lMTELR?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c818a1-5e2a-49fa-79c1-08dab2be4d1b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:12:43.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj/M7yBEtE9kN9ES+TE6+u3rgQCwJwbwPGCiUUpzjwzLDlVXbFFsYPjkYKnn5YtPWbiNQSz5K4XqdgPDRfah4MK0BAzLeLuvAZbfVVgBTuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-Proofpoint-GUID: H-RGdx_GU4SC46rok_fFqFe2zsNUkbm2
X-Proofpoint-ORIG-GUID: H-RGdx_GU4SC46rok_fFqFe2zsNUkbm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_08,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=760 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200102
X-Mailman-Approved-At: Fri, 21 Oct 2022 10:04:15 -0400
Subject: [lttng-dev] [PATCH] Fix incorrect number of tests in test_callstack
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
From: Mikael Beckius via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mikael Beckius <mikael.beckius@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

regression/kernel/test_callstack                         (Wstat: 256 Tests: 12 Failed: 1)
  Failed test:  12
  Non-zero exit status: 1
  Parse errors: Bad plan.  You planned 11 tests but ran 12.

Signed-off-by: Mikael Beckius <mikael.beckius@windriver.com>
---
 tests/regression/kernel/test_callstack | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/regression/kernel/test_callstack b/tests/regression/kernel/test_callstack
index a4477fd7c..b5d604535 100755
--- a/tests/regression/kernel/test_callstack
+++ b/tests/regression/kernel/test_callstack
@@ -9,7 +9,7 @@ TEST_DESC="Kernel tracer - Callstack context"
 
 CURDIR=$(dirname "$0")/
 TESTDIR=$CURDIR/../..
-NUM_TESTS=11
+NUM_TESTS=12
 TEST_APP_USERSPACE="$TESTDIR/utils/testapp/gen-syscall-events-callstack/gen-syscall-events-callstack"
 TEST_APP_KERNELSPACE="$TESTDIR/utils/testapp/gen-syscall-events/gen-syscall-events"
 PARSE_CALLSTACK="$TESTDIR/utils/parse-callstack.py"
@@ -123,7 +123,7 @@ function test_kernel_callstack()
 # Only run userspace callstack test on x86
 uname -m | grep -E "x86" >/dev/null 2>&1
 if test $? == 0; then
-	NUM_TESTS=$((NUM_TESTS+11))
+	NUM_TESTS=$((NUM_TESTS+10))
 	RUN_USERSPACE_TEST=1
 else
 	RUN_USERSPACE_TEST=0
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
