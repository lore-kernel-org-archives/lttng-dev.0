Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C50C4332F
	for <lttng-dev@archiver.kernel.org>; Mon, 30 May 2022 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1653920478;
	bh=ts2AdWdDseOtg3/9iuY/GrrgCiZaQtCCio0YkbeWHvw=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=IXLmeXgiGA3xM5+XxV9A3BMavZ3KYx2ngdlOBYKBa9XVDtms02iOcYXbcMEAEga8C
	 vqGMsmSZRIhhgEoXCAdGm1PW3QVbwWxDaH+S0c83q2VzXc++S6Kddrphndlo4PJco9
	 Uo3DUp1m+9S2xfkLvjv0wZrVPffrPBKC1xjvKV7VXK6hUZ1gDNRHgxRmVI46hAN3b6
	 4MW6mpTy+onJX5Xd3wd1Jc2bWSxVH7Abx4YHS+phs0trgQQ3KmffGtLRxoxhinQcUo
	 0xUsp2ljsFhj/GrqpX8muKofDb6qn8Xw4Z6pSJRInmY3GEgak4TG2sLxtVfPRbnGCj
	 qHK67XbhhOiSQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LBcz13b0Dz2wV;
	Mon, 30 May 2022 10:21:17 -0400 (EDT)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4LBcyz1v3wz39Y
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2022 10:21:14 -0400 (EDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UCRevc015700
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2022 07:09:59 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gbf12996j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Mon, 30 May 2022 07:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxZ35Zgow3e2LRbkfWf/WKP0cl2XenYl3ZlCV2akGSCEdiugCEwv9d8TbJO2tfVOQJuosXZ8Eu8IQaijBq651mXSNJJzF7TKEzSn7zAXpSU9JsbG3iui3aEok8U30kgXowNk/dEhs9XZiU5iepl+OELZ20YDuTlBMUgPt/R2SdGxStyVWhpuI5lW/t4SrTBA9xZcTtRc4QMSgR1gaiBu9tW1YcJL2skviOOvAnXjSMxIQ/+JD1uPWHe/xQTLvE1IzyLummeKMQB9qc5MTzqWcyzYfjfvtDDMok6HV3DDiSZDrgq21DasOdCQ8+W+z6aFs9FYkpMgkMxBtLfirs405A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSYd8eWQPdkZoiWsNjhG8GNexA0vOE2y4bHSM2/UdOo=;
 b=g+NnvJ7vWO+F7IzTTqNP/aDfTGQ9zmTSOexjymF+mcG1WLolO91aFR+bASEBT1Kxl8NIIaJO5O7meqayPF/ipkg9I2nm8ijXrNWJ8Ttbs79QacIsWd34QU/RiBIASjczDcXtwYWL+26IX1Rqq0IoMkmF8NF4JWAP0OD0yUm8RKrav/JOPTG75ePUCM+AN05ia9uab7kFPl6vbZJBmJku2/BXfr+W5qkRGym4iXYBNXo5U1/pU6hBTVP6bTqfTdoqmu03VKBp59WI0f4Lb7UzUPxjQLQDSFgfXcziP2EaF2+x4Vhu0gbPWP/FbaivPT+sTlVM0kB01Es1ivbY9yQ+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 14:09:57 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 14:09:57 +0000
To: lttng-dev@lists.lttng.org
Date: Mon, 30 May 2022 16:10:21 +0200
Message-Id: <20220530141021.267219-1-marcel.hamer@windriver.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ec8494a-5bdd-4448-11f0-08da42461363
X-MS-TrafficTypeDiagnostic: PH0PR11MB5045:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB50452F8A6215A0962F100F4292DD9@PH0PR11MB5045.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRGncHMtVDnM+SjDIeX9yomlkFLGYUEPx8N5sat/CfhyA0l6ZlZjCofO2/Y8Cuw/rgsXFgVNDK6NM9aMxPNUwT9WlSoM2j38Ft39sMiXCRTywby/ia2WkHrsOXcjeNvwMbAWFXXGKpdlswnPCF1vQukCtsNjMykhl1iD6PAzAokcULWwqhbRCNU/REcluoCUZjCbB8jax+ePMc81AvPwGtculKO6zf1x3CEGn92nkPlGylVuUH7agXxhDTzGCeH1c2kLOcvRD8gKLRc7OMjPcrAK4Qp25pn4HEc227U/vs3e1vzOg4HVW8g08i5dASnwtUWvK+5yvMpcAc0uULj1qPhTsekp+k3UjeTL/HiBd2r7t4cE3Vio1j7aacgtfuhq/re486eU2t0aOJUL8+ehRT+z5I04OT3Fu7FdDduIah2NTUOaW/ZAKzm/n4xHGRY6gDUHT4TEteC8MpwDDNsWytEK0ujmW+qpxwVL7aiNrdrlhWMf7FlFbpHSKdwpKAuNOpHsb335kzHj1tat7O6IjUEScowZt8OYaul4xvmvgtbw0riX+RIkSsqyPo/IdGvdFsmVshHtf/q0j5cqEap/SHwx3nPkimbEzl4vF3OjeOAlE1nLjmvByrTrPcR9yRteAXTpIgy7mPyYrv16BZIl1Jsgzzfp9Ot8gkVNst05Jk4nhsA9jUZWNgJejuOV5u1Lo6t9iy5pZiNH2oorfe9zyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5617.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(66556008)(66946007)(66476007)(36756003)(86362001)(6512007)(1076003)(2616005)(186003)(6506007)(38100700002)(52116002)(2906002)(8676002)(508600001)(83380400001)(38350700002)(6486002)(316002)(26005)(5660300002)(44832011)(8936002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t94YiztSEiifIpAWbqSFE1tpsGEcjWrcdarFKBURvrNc8aoZ9Gs9bFxuAexm?=
 =?us-ascii?Q?Nw63k+hCadgZsmflx6r4t2NkXTgwJkqApEc5S6HO8hswxGEDIQXtIEsGO2mq?=
 =?us-ascii?Q?eWzwi3MfIlBrIAjZqXOWc3/saBy57OMweW4IgyGtR4B2MuWeGy/JhOyJd4wx?=
 =?us-ascii?Q?D2meuDvLQ68X8uEsP/b+D+OCE/CrFVmwTzk+WL16LSdz5BDv//OESW1X8psG?=
 =?us-ascii?Q?3E1GSWD12fNigSLIQmfW5SEDr9QuAPaHn0AR3fxz3zdlvKIV5nSaW/BvViev?=
 =?us-ascii?Q?YUFdTtqQVNOymUlo+tIhKo50l4x3o3ypB7AHgcbBstHfYLi/9zq++htlWZLe?=
 =?us-ascii?Q?gXwwu5t+fs/ZhyIhHQqqb2YMIb7vKThe+DkN5FsznCC4D9B4QxKPTPkYkCqZ?=
 =?us-ascii?Q?2wNd/YpmVJfjuladOFevJ399iZXBqULz4YoUtbdDOSvjjprI0k9SZ1tI+XI2?=
 =?us-ascii?Q?MOXrT/NJVEVID9viaJabev4BeDtIU4elai922iwDyTxmakwwHWeHcK1l2EMF?=
 =?us-ascii?Q?OyujNNp4SdxYuq1tq+5+lXmvzACm8fDuQhik6KOv8AQuP+6h64aYlLFiMsk0?=
 =?us-ascii?Q?xgk4gsG0kiKF+0f29HsY/Bt/Gbm8954H6y1FohoXQVmuusilEZc9FI6L+jbc?=
 =?us-ascii?Q?GQre1ZPIyGg/K4R5PEgMy8h6F0PDaE0a2yg1QkgQKF0nvrrAqGBQc8ZYS6y8?=
 =?us-ascii?Q?uCsj6HvBGlheeUUxqF14Z4oc0LGLoMJKlp2QcncCmlD7AdivYGfG7peXi3tQ?=
 =?us-ascii?Q?XnVf2feB6pNorkYySKYc+fP5erd/0nOM9gupEeBCC6BCyphiAlxXxbaWrv9R?=
 =?us-ascii?Q?bh5IRzX+/kaONcOPA0yyzq/vzY1R3TGDoK34I2JO1UJQFv1J+0mJrRW3fifi?=
 =?us-ascii?Q?C3P2oegmqLGFJR59zo96QTkuY68TitPiMO0DE3Yh9Y45VjDTb47h9uPpLUVk?=
 =?us-ascii?Q?jypeTRzD+gVm7MniZ/TUIvWUj3jM2Gfvi5Mbe3GA8ka1aOAFjzWuX+JYFwjj?=
 =?us-ascii?Q?ob2x/rZH0hH1l0iJgH0HIS7y/wGzY9M4y1QEynhiTWM58D7huif24RmG5CXX?=
 =?us-ascii?Q?a1/xRgjvF31C/lArSH+ra0MFWv9RrfBgJc8usMycWWdh7GYwOYqeXI/9x9dg?=
 =?us-ascii?Q?hkVIf+0QM3yVATr89/L36F3ngn+YRJf6NfdngTg/bSQd9E5P4vjiNtvu+uZJ?=
 =?us-ascii?Q?GyEfqjCFUhOFGV1ZvOlufFx0xu74NHCsUJernbVdj0iw2kTxdcQJnjHvZK49?=
 =?us-ascii?Q?iIhU3znVkXws3ppyLOjBp2OO7F9e8qUQK5ebjFBJYVF5V2g1BbzF0Fa9SRGd?=
 =?us-ascii?Q?vlLasKyKNDZypKlmO/aRLr9MBtIuYjS5TsAsaIJNseUaOwLFCeYnVCQXsiOA?=
 =?us-ascii?Q?R8yEZlh7UUmE4prcVoDLis6Kzf/Z65BQYCpQm/UtF3714x9HYoxLxedF9/yK?=
 =?us-ascii?Q?AM/RFv8bmssDiP+7YZnQcvLeBOZdZUBbXTm4RdsITSwKfIFK/hhYt2mIns3N?=
 =?us-ascii?Q?+m3fImLDaxd50NIOfAdJl8W7N5FiOoyKP/e+wTWGCG5ZuXdboqC8oK03c2AY?=
 =?us-ascii?Q?gcD4xEZa0n5BhQndvF0JTchHph77b/rMF0PnoDCUGweNM4rQXaTut7X7LWWr?=
 =?us-ascii?Q?2a12z9gdy4cbnrPZN0kOwZzrBrKvBBZFVbCCiTXSzSmdA3ugrLlNiexTdFsT?=
 =?us-ascii?Q?CfqYz42QBjEa1wjSOUbJ9Ev/NaDXnknhoFefayhcmziHV4n6FJZSOBj3x//u?=
 =?us-ascii?Q?B4ZftSi73l4bKjpfrc+7vhTC3ZCNlp4=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec8494a-5bdd-4448-11f0-08da42461363
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 14:09:56.9874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPKxU1j0Jo19w9pXTaiuh5CKQgrrlG6hz+z5pZkrLHu2GavYbc/uSMIQYkFU6+BbK8UKNXks8eC++sK2ahNwzSB5tG8ZZm5tQD4vQQ5rTDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-Proofpoint-GUID: HnUmECM3aaaUQXFSupebHrdUmR6wvJVN
X-Proofpoint-ORIG-GUID: HnUmECM3aaaUQXFSupebHrdUmR6wvJVN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_05,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=775 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2205300074
Subject: [lttng-dev] [PATCH lttng-tools] Fix: cleanup stream on snapshot
 failure
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

When a channel snapshot creation fails the stream should be cleaned up
properly. If the stream is not closed and cleaned properly on a failure,
the next time a snapshot is created an assert is triggered for:

	assert(!stream->trace_chunk);

inside the snapshot_channel function. Since the stream->trace_chunk was
not reset to NULL. The reset to NULL happens inside the
consumer_stream_close function.

Fixes #1352

Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
---
 src/common/ust-consumer/ust-consumer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index f176ca40a..f43216829 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1147,13 +1147,13 @@ static int snapshot_channel(struct lttng_consumer_channel *channel,
 		if (use_relayd) {
 			ret = consumer_send_relayd_stream(stream, path);
 			if (ret < 0) {
-				goto error_unlock;
+				goto error_close_stream;
 			}
 		} else {
 			ret = consumer_stream_create_output_files(stream,
 					false);
 			if (ret < 0) {
-				goto error_unlock;
+				goto error_close_stream;
 			}
 			DBG("UST consumer snapshot stream (%" PRIu64 ")",
 					stream->key);
@@ -1170,19 +1170,19 @@ static int snapshot_channel(struct lttng_consumer_channel *channel,
 		ret = lttng_ustconsumer_take_snapshot(stream);
 		if (ret < 0) {
 			ERR("Taking UST snapshot");
-			goto error_unlock;
+			goto error_close_stream;
 		}
 
 		ret = lttng_ustconsumer_get_produced_snapshot(stream, &produced_pos);
 		if (ret < 0) {
 			ERR("Produced UST snapshot position");
-			goto error_unlock;
+			goto error_close_stream;
 		}
 
 		ret = lttng_ustconsumer_get_consumed_snapshot(stream, &consumed_pos);
 		if (ret < 0) {
 			ERR("Consumerd UST snapshot position");
-			goto error_unlock;
+			goto error_close_stream;
 		}
 
 		/*
-- 
2.25.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
