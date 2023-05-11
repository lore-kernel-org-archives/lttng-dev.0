Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC57C7EE22
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683838256;
	bh=Xh5TdrtAQS4J0KS0VGtG/Fo4exc1pmiRPmHjSNnLaw4=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=HrAVSucqf+CqS6RlHyRlQIj1nWQdfHfN7m7WLWAx/agu+IN70EX491BLvcfQKE4O7
	 Vyy9Pl+ic/EvPhPaJx5x1WvhhxI/Cv4RWwZ/8xSqw/Do9H3ONYyW/N3d27talVd/YR
	 64CRG9EdoAGHsfAAR69Ij66jQHDAKj0NyqfEUeSHg5H2zG4Ap5MAbQtq0fmuIMvq6X
	 MIpNqs83S7FUq4sCu2v+a44lpf5J7BLCTEPsQitw2raOqzBAeCwtHMyw1dT0AP1yKT
	 XLgjqEpe+oAJHi3rCBpLhoY+PgKFVskAG4xdH1QaN/Jj9wuywUX1m27ClXmooLWHGQ
	 dWz71QtCPO6Vw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHPDw3KxPzT0r;
	Thu, 11 May 2023 16:50:56 -0400 (EDT)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTP id 4QHPDt26WyzSWy
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 16:50:54 -0400 (EDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34BGRVZi027330
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 19:56:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf82x3318-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 19:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Qqnja3Bj3OT6M3fRBsW4IONRFxIYtc1wFv+EuqzuuL55HNg+XLMj3Oxd+cE7yeG6Zk4bHzro9jsy1JaGzYX8RwB23DjVLswNod+p/9hQ+OMN6uwlfyzJFjKmLYuQKCsFP51wef8/jKpsQ3qIukXffMUW/4+xJ+S4+xAvLDAH1RVGTcRJSTBsD4ygz4B8eQoLRboRS3k1xCaoEychDWKDltkGBDHBU/Ot3aVMa3TFFhQ0xCVm7qj5Tph+wzeiPQ+oa03FFZIwu2/rZ+bu7Nfkbk3NPfzOX0msTjHvXTtylzgDI2Sv5o6Bb3+KleQhrX2HdHxQUDnknef3Wo6dafLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8emDSy1FW0Dt7Ko7RhmWkIsbSjH/RpYxZzDw0G+e0Q=;
 b=MjQsCr9uND7LqXlTe9ozCtm2W+8Y3bK3986UK/hUkqSewBzWupw+GwDQThrjKcfMFpIFul4Ux/u9VIfHU1SQ5cLClZw24CAgG9dnNAVMByvT8CN6D87MBFTrKK7E/duS7hIiaY/oYKMA8pltdwVOWjsXL5DtGPKHsHrSTKD5v6wEgOkw7EORAoytzn9hgntwZd2k5DOPqLKFJ4PdR3u6v+vP7lKbqeKpDVm5DppT+eTANfvwkpq+h3p4VPACdL3C6hlDS62YIEna/JpbLYZ35yV2H3azaDO5Lye//EZv+Q/tnImZm4ki8kO7oexuFNzFLr0q3c2xzKqma27LZblYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 19:56:12 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::6032:d4fa:b428:a77a]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::6032:d4fa:b428:a77a%4]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 19:56:12 +0000
To: lttng-dev@lists.lttng.org
Date: Thu, 11 May 2023 21:55:51 +0200
Message-Id: <20230511195551.67606-1-mikael.beckius@windriver.com>
X-Mailer: git-send-email 2.34.1
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To PH0PR11MB4904.namprd11.prod.outlook.com
 (2603:10b6:510:40::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4904:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: c020a568-496d-42c7-6a6a-08db5259c56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+QHr2ExUhZb7I9Y2YnZn415CtGDUaAdY0vjxIPFzxoFHYAt5rsQKwBYOgdtePBCNAMOvsKkUKzDXcqjFeo96v5YlCLMAkGGwAlDbPl5Zkl09V/bc5YEAM6vKeQB/PKBn32KJTzBzdMZaqiYvT2QDDvhJCaU8tI1GYFm8M2ufJkuKIEolGlCcl/yLeMeR9TFWk+Iz9ojxb99qlj/XAdWEolRPkaExrTzEeJfBOfml/W/+UhOvJZpqTcvfy5Z5VyvqQamjXau9jCyJ7F9sss2w0UkvMuj1Csq6PjCk7a3oYWsDMrdjRgCMHipseCbgOLNkibeFB8RUrRHs80I92z8x4HhHSf9Pa1geCrC2a1JV/0ilQb0gaa5xBopAbgafC203hzrkT3+dAq09Abl9kQB6jBolgBh9ZEEzcizoV11eKIpumowHuZa5SSOJ7QPytiOvBHDXcL8juaMR1/Q0Q/DMRw/I9jtXExWHU9Vzc0lk+cimzKIp7s+9X2utafL7UF/qqTROb8alV362INMl5bGUDFUPmf1GppnuiM/hoaMcFwbGNq2XE2CtrpXIYqoKg8NCq6Ce9Y45IqCMfFZ6ZPoowtZ8uwxJ/uQPi0iDwS5HmhxItrRQffVfJMpZvMiJeGV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(366004)(396003)(136003)(451199021)(44832011)(5660300002)(2906002)(83380400001)(6512007)(6506007)(1076003)(26005)(8676002)(41300700001)(2616005)(8936002)(38100700002)(38350700002)(66476007)(66556008)(6916009)(66946007)(316002)(186003)(6666004)(36756003)(86362001)(478600001)(6486002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7oOHs2SSrS6BH7vLlTdqJlmN+Dg0w1loApg4aeKSRvhnp+TApn+ugsvLTir9?=
 =?us-ascii?Q?qJEi24smPB6aoo35QDSVijqyT9LxsjAi6Qd6eppfB5DyuYQ2Axx+duZzb8E8?=
 =?us-ascii?Q?rkttOni6DLyIuvBSWhE4c3xN/wJPwh42BVSy4nxMwxhCo7+HZQmFixQElSvk?=
 =?us-ascii?Q?8RBO9TuZpld5P/2pSuetMrDva9houTjGV2t/Y8FYdr4M5HTKrenEzLUi86ev?=
 =?us-ascii?Q?HmINgPxPZVM7FbN0HXHSekR6f58UfHfy9SZ5SU4ZEoxoa2x2SweEamsqbBzK?=
 =?us-ascii?Q?tvLJUvr4c3XLFhlIXzL0hUlZr04uq2uZs4MprIivg75sXwvz1F/Lo+IGnbRv?=
 =?us-ascii?Q?CYzFEs2OQs+64I18L5GFs46VOPNb6Nm538RFx3YWJ+kUye3Y+VAnCCwZQJ13?=
 =?us-ascii?Q?/PLv6nBZqYXRysu+JRShEpohfoA5Rui+3KmKxlQie1LV6oFuwiwlroJ5/xii?=
 =?us-ascii?Q?9uF6MtBUpas0B7Ka8MrSzI2wqETZMlIM0iaQBX7TSQkdmrI/EbvGxdNW9ejm?=
 =?us-ascii?Q?BrnUhhCwiuKK7qK5VkTG5J3tNQupBAzhYzyodQgTxXWpgfHkc7uFgzaNq26W?=
 =?us-ascii?Q?DIaTKf2lZqnkAwkbOmb36VVrz5EOyUOxkXJqihe9/80stsEKkEVp2xYIyGNE?=
 =?us-ascii?Q?q0iMX9hTA1dW+1J9YjjjionhDFnjmt93Eq2KMrqkyHjxGhK+kF83p23TYUmh?=
 =?us-ascii?Q?El9ixCm0dtZGdZwcuwNGSXh9htm6kJeIT9Sl6C/LWE0w1VNaBsON2ugmOUmD?=
 =?us-ascii?Q?YTfQwVDBhHctT2yWO50Djvr26f5M5pxyIG6IGudTKpV8hzdoDF6ypQ9TQcQN?=
 =?us-ascii?Q?SZIa8P7nFkz71Dmv+Na7mLEXkNr78c3U42DsHeZmDTxoFBJRSEt0mJx8YmmM?=
 =?us-ascii?Q?Ne2aI7q9sB5O9NeRC7jZV9MloLzJUb0hDwJrbnBbKa7NjFMHf2c2vhQpydcS?=
 =?us-ascii?Q?1czVh9CMCtwST1CEvk6zrpwphx/hcStSp0BcVQ0cBv8iSh3iABdsIt4dgwTh?=
 =?us-ascii?Q?f32hEJ+ZFUT+9hvsY7T6g+nmt5I30Q2U+w97DWIhO7ix8XSoPUJvhn3Z3LPh?=
 =?us-ascii?Q?sOxp3ESJPN848H5NE3w5SHa4STzSsXxTKsl5HuXjQ5Z6obl1BWwJIuIegJlU?=
 =?us-ascii?Q?MQMNN97rFBnK69soBd2C+Ca8UpoMoMrgrfJ2dJUdgBlpmcO4gxhrte+HH1ct?=
 =?us-ascii?Q?B0pzTvIBObJKgawk8lfZVKZXJgVUyMKFicX2+Th4usLZQYf1tz4qYwGnA7LV?=
 =?us-ascii?Q?SOxtknGn67298JUcFk+KQngISebpnFHWsVMDQfBDSegVXNYqPvhz7xGFAhtP?=
 =?us-ascii?Q?/nUQH418TAQClufGaO2PnZseC9KIqv7QPcrQowUui8/MBlIYzUbTV3kfZhy/?=
 =?us-ascii?Q?FZEq3YtjdCdLjh5qljPg8vTAol+HGCqKLuyeWW+muAd6oLNi9Xlxhn6aIKG+?=
 =?us-ascii?Q?/nr3+Hm4Cxn38bWLCSqbnXIXzZtHdqGl50GdeSL8SZqMDDgLd5XZ+UqjR1jS?=
 =?us-ascii?Q?WeMIEc8j+Huedskj6C3WgE7MTWMcCb7guVMsmvZ/nGLQtoYGk0siDGb71ZkF?=
 =?us-ascii?Q?VqkLYQNjzZN5w8LUzMkgL5EAtVe0ooi4aNWEoY3bQfOmQnAz2+rf97ev0HY2?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c020a568-496d-42c7-6a6a-08db5259c56e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 19:56:12.2937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6WfVOXtXJ/+Gsu/aWR5Hd2EK9tUnE+JtNBMegS0I8OMpmL4VoMycCWAAMmFuXn/2mC0Y1czLeB7hFOG6S7Cardw3hmj8DdvNnrMDRM026I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-Proofpoint-ORIG-GUID: n7EXZiVKnAWZPoZ1ykabBsCqobZK_ZOT
X-Proofpoint-GUID: n7EXZiVKnAWZPoZ1ykabBsCqobZK_ZOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_15,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 mlxlogscore=583 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110168
Subject: [lttng-dev] [PATCH lttng-tools] Fix: sessiond: Consolidate key hash
 generation
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

add_unique_ust_app_event will create the same key hash
for both --loglevel and --loglevel-only, resulting in:

add_unique_ust_app_event: Assertion `node_ptr == &event->node.node' failed.

Signed-off-by: Mikael Beckius <mikael.beckius@windriver.com>
---
 src/bin/lttng-sessiond/ust-app.cpp | 16 +++++++++++-----
 src/bin/lttng-sessiond/ust-app.hpp |  7 -------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.cpp b/src/bin/lttng-sessiond/ust-app.cpp
index b9091424b..f34b17d05 100644
--- a/src/bin/lttng-sessiond/ust-app.cpp
+++ b/src/bin/lttng-sessiond/ust-app.cpp
@@ -179,7 +179,7 @@ static void copy_channel_attr_to_ustctl(struct lttng_ust_ctl_consumer_channel_at
 static int ht_match_ust_app_event(struct cds_lfht_node *node, const void *_key)
 {
 	struct ust_app_event *event;
-	const struct ust_app_ht_key *key;
+	const struct ltt_ust_ht_key *key;
 	int ev_loglevel_value;
 
 	LTTNG_ASSERT(node);
@@ -253,7 +253,7 @@ no_match:
 static void add_unique_ust_app_event(struct ust_app_channel *ua_chan, struct ust_app_event *event)
 {
 	struct cds_lfht_node *node_ptr;
-	struct ust_app_ht_key key;
+	struct ltt_ust_ht_key key;
 	struct lttng_ht *ht;
 
 	LTTNG_ASSERT(ua_chan);
@@ -263,7 +263,8 @@ static void add_unique_ust_app_event(struct ust_app_channel *ua_chan, struct ust
 	ht = ua_chan->events;
 	key.name = event->attr.name;
 	key.filter = event->filter;
-	key.loglevel_type = (lttng_ust_abi_loglevel_type) event->attr.loglevel;
+	key.loglevel_type = event->attr.loglevel_type;
+	key.loglevel_value = event->attr.loglevel;
 	key.exclusion = event->exclusion;
 
 	node_ptr = cds_lfht_add_unique(ht->ht,
@@ -1499,13 +1500,14 @@ error:
 static struct ust_app_event *find_ust_app_event(struct lttng_ht *ht,
 						const char *name,
 						const struct lttng_bytecode *filter,
+						enum lttng_ust_abi_loglevel_type loglevel_type,
 						int loglevel_value,
 						const struct lttng_event_exclusion *exclusion)
 {
 	struct lttng_ht_iter iter;
 	struct lttng_ht_node_str *node;
 	struct ust_app_event *event = nullptr;
-	struct ust_app_ht_key key;
+	struct ltt_ust_ht_key key;
 
 	LTTNG_ASSERT(name);
 	LTTNG_ASSERT(ht);
@@ -1513,7 +1515,8 @@ static struct ust_app_event *find_ust_app_event(struct lttng_ht *ht,
 	/* Setup key for event lookup. */
 	key.name = name;
 	key.filter = filter;
-	key.loglevel_type = (lttng_ust_abi_loglevel_type) loglevel_value;
+	key.loglevel_type = loglevel_type;
+	key.loglevel_value = loglevel_value;
 	/* lttng_event_exclusion and lttng_ust_event_exclusion structures are similar */
 	key.exclusion = exclusion;
 
@@ -5004,6 +5007,7 @@ int ust_app_disable_event_glb(struct ltt_ust_session *usess,
 			ua_event = find_ust_app_event(ua_chan->events,
 						      uevent->attr.name,
 						      uevent->filter,
+						      uevent->attr.loglevel_type,
 						      uevent->attr.loglevel,
 						      uevent->exclusion);
 			if (ua_event == nullptr) {
@@ -5167,6 +5171,7 @@ int ust_app_enable_event_glb(struct ltt_ust_session *usess,
 			ua_event = find_ust_app_event(ua_chan->events,
 						      uevent->attr.name,
 						      uevent->filter,
+						      uevent->attr.loglevel_type,
 						      uevent->attr.loglevel,
 						      uevent->exclusion);
 			if (ua_event == nullptr) {
@@ -5952,6 +5957,7 @@ static int ust_app_channel_synchronize_event(struct ust_app_channel *ua_chan,
 	ua_event = find_ust_app_event(ua_chan->events,
 				      uevent->attr.name,
 				      uevent->filter,
+				      uuevent->attr.loglevel_type,
 				      uevent->attr.loglevel,
 				      uevent->exclusion);
 	if (!ua_event) {
diff --git a/src/bin/lttng-sessiond/ust-app.hpp b/src/bin/lttng-sessiond/ust-app.hpp
index fdc007853..7781984ff 100644
--- a/src/bin/lttng-sessiond/ust-app.hpp
+++ b/src/bin/lttng-sessiond/ust-app.hpp
@@ -41,13 +41,6 @@ struct ust_app_notify_sock_obj {
 	struct rcu_head head;
 };
 
-struct ust_app_ht_key {
-	const char *name;
-	const struct lttng_bytecode *filter;
-	enum lttng_ust_abi_loglevel_type loglevel_type;
-	const struct lttng_event_exclusion *exclusion;
-};
-
 /*
  * Application registration data structure.
  */
-- 
2.34.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
