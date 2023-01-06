Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AA8C61DB3
	for <lttng-dev@archiver.kernel.org>; Fri,  6 Jan 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1673032222;
	bh=vjz3qOWmAkOruxWnYXIpMpFUS2lrTVf0wXenkJANZUU=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=SHOhpVwa3CTtO+xeqhlZvMmEgjecVhKHNtrLJAlJ9kd6Kew8rDYscUQEG2iiVGYuR
	 feHDGqC+vS4igg14bl2F/0fi4ipLRPOw8vNm/7Gv1JpPnrEFSXK7By4oyDsT3/bZPE
	 Hrnwpo7/MfgnBeTQb623wlYyLaJoe7ggSLH/ovhKOoShghklqKZ5ETGsejGib11z39
	 dZ2saHsmm72bC1ijfDQddNs8duFRm6mN+Yaw6hKnjhI79tq6noXyhGiXx8vxxo5b5j
	 b68AuVJUsgufTMaxw9+Itpi3pND+3zLxLM3gBscGaxJsfCYsWNc6sYQeNT6qupuPIw
	 TGDH3ONnk89RQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NpXwY4PzPz1N6r;
	Fri,  6 Jan 2023 14:10:21 -0500 (EST)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2081.outbound.protection.outlook.com [40.107.116.81])
 by lists.lttng.org (Postfix) with ESMTPS id 4NpXwW42nmz1NLP
 for <lttng-dev@lists.lttng.org>; Fri,  6 Jan 2023 14:10:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0xF2dEXaBsKe7mHRBIraupOdVeJ0Dy8S5uNpniYxWuTPSEd/Li8+DJL+8R3dksTxwdZ3X5tjPRXGv7Lr/fliCYheuweYspBgGZceeX+ovmEOYtK9lRisYvDlCvoiDkRdqIuDoWcsLLxT3N0BJDHKmx5Mh3kzgW/mYMpn6zwXuF1lnbGAgrntAHFCpwugWn4g4qRjkpjXBtGP50Wf7b6b7wMleM01/E3H553Gt4mfP5bowGZMEbnd5tPxPif6cwdQVMDB6wK2VYW4Udmm3FbqUtHXNMIxX9SgxskLTU3u1QpFucdgPGN8ZHhFFj/k7p6FU83fDk1UiWjtms65jCIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPbDAkG1eUgPY/IelZf5YYZ9Pw3KzBseR4iFC2kyK/I=;
 b=Z/eyK4iWK76UtikLUH+ZFruafWuh5jG+OdoLoWy9ThwKGL44E/7mlrjw3yU3R5zKa7ixG1yS3nZSOnCiZiez6+gBX7zeB58AQoAI0cRfnH6be5D5jp03GCiI76ud1q00t7bVB3eydb7ke8a9ytiiAfM/mTs738zIJaE9J4gYh8tBE/WSRo1KBsigPTaxCgHojousxux1HcUTsoHZ88/IV04rVINj7BNDth6U4r3ic5CvuD4Kf4LHvDrOH2x3kuoI/9ob27+WdWBmpR82/uLFl/JLbRmJH4+fyFFZfZ2XyT4/ZefLeRCXW15B79TEd6VlLAZSRg8i86Cf3RnnHFXhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB8195.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 19:10:17 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eed5:b4fc:c863:b2a]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::eed5:b4fc:c863:b2a%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 19:10:17 +0000
Date: Fri, 6 Jan 2023 14:10:16 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <Y7hyGFwLWGQ2KMWc@efficios.com>
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::20) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT3PR01MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b34c80-70e1-486f-d1a1-08daf019a5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mv1/GeEc9iY46MKAptrXrpB3rDtVFPKhoQBUTCpkdsk0uoNO2fQnAm0R3LbcX4zM3O+fBsDIkxsJzRkTnHaMvgXGmSdaDonvIUYHQHUq0TCtgG3A9fg0/1r+o7zVeBH0wdjSClAA5YL3UKvIZS8eOrnQpFV0w2/RaYOTH4ZllQgtUSVJFnAPvtgJtsEqO8XLUuqk/bE7IypwflCTuAgPs0kQd9R8F9iK5lQsGHpjdKroWUUYNUvLp2+eW+/YftuvVEVW86kdgnjLr8l/bLarUN2Nb6KtUEVs1EhEBC4jU8ikWkFeWZnDK0/kW0JajIYbvjj2GacVdWiMt2x0/CZTsF5lHfuCTbEto+dMioBzaztJQUupR+h70dDDfhMvevYF57JHdvFw2hHxfHBwWjXycqIe2al5lJSjlg+vfAwwECZ0zoDiNbsd4WLCyIl1Xvl9t1tO/b1FLJxlJznjaH4jj+mKcSBuJ2p8niRcEHvzc9vCm0Fka5O/zPX0XIxyaRiKjB281OderyfKVnR8rJRTG7zHdoAJ9oySOYYRfQt6GmvM81cMbNfa6tetqf23S9LahWGK4hwa1GoX10uw7Xc8T8WdXdgq2hdTQGA5K40F2KO1ATIhskUUvbwG95H+vFkbY3fui/L41sBrmPog7iITycCE9nYEHBoVlzdN6ls95AU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(346002)(376002)(136003)(39830400003)(396003)(366004)(451199015)(316002)(4744005)(5660300002)(2906002)(41300700001)(54906003)(66556008)(6916009)(66476007)(4326008)(8936002)(66946007)(83380400001)(478600001)(6506007)(224303003)(36756003)(966005)(186003)(2616005)(6512007)(6486002)(26005)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DR2Afl7QnF6C+Y0znikU0ktDRHIjR51MBelnREy9vZllAJwYYs7csnKh3P?=
 =?iso-8859-1?Q?9QoKc2g/D7L3yL6v1A1bfZ2cAR3516Z1pn003DwR4WiLXLkkhwol9KUt9h?=
 =?iso-8859-1?Q?Kl0pXYYDHSvqsnT3Ltc7WnDQ0+IZmfRlkgQq/fdnMpCxrs6HPFfaefwxZq?=
 =?iso-8859-1?Q?udF2So+Yx0SK1H+dN6lZVoBy1ZmnDCYJ4sAjOKlWRbavbVbUFmWxUiklb0?=
 =?iso-8859-1?Q?q/jKg3r7/4IMLWNYV3ctL80PWqPHdWZcVbRL9mLZVpqGothFDQcduJye+N?=
 =?iso-8859-1?Q?glzNpDD6xL4dAAHZh0wi8cgUgPM4EWkPIj/nJm6ZzwS8wFawFdJFE7JO2e?=
 =?iso-8859-1?Q?jGGuVT/yrr09fvAemR/bps1+HbxwATiKSUkAkWuNGkaUUO77VedTSPTaCD?=
 =?iso-8859-1?Q?a7nyJkLp0B4QNc7o2zNiQCxaE/lqfOUhY5Yrufvnytf83D9h233obprPjf?=
 =?iso-8859-1?Q?Zl76YxPd+E7T9PgGBjtxTetG/ciWvEXZZZfWvcPmyXOmpzuxHi4ikXORsn?=
 =?iso-8859-1?Q?WsGIyzz67hQ6qGTIhDKlU2UyKRpBDDLnjJI0W33vV3mO1ocExg0bkWCGcG?=
 =?iso-8859-1?Q?VLWtI+A+t4iEO16pi3Pw7O/PBX7VYjn5CR3sZR4LA+Y6R1MxwVvARYtuF/?=
 =?iso-8859-1?Q?yFiGUqGUzLmmcg1Eqhwk/1oVCvJNcRd/SAPn5yM/eT/aUXxl4g6NKsRAEt?=
 =?iso-8859-1?Q?sePhzRVxsl1vRrmNb7b5/YIw+dJffz7P6Maau9i9ehoblfi8P2ztcfjLq8?=
 =?iso-8859-1?Q?qO4mSDlfarC8Fpl3EXVnJmORpjJybJG8kwI4MQ8JxmSuFPEYZBiXU5W3YX?=
 =?iso-8859-1?Q?ZXbRzegkMoKEwXPF600Ogixm9i9NkTLOzLRVhPkH5kA69/ndGJWLlYnVWN?=
 =?iso-8859-1?Q?dnwPuOmKSxhm1cyu88AXU+NvA4/ndR1/0MbEZmu0HEsC7i0rLA69/bTV3I?=
 =?iso-8859-1?Q?XFTZ6CctRbU6DOQlreCd0sZy+Uib6KN/TdTCJMbvG0pmGhhb5zMmFDhfJk?=
 =?iso-8859-1?Q?nQvQjMfvsFlkFLvL9A6AjzACJSvm+X6DDRlmaKGp9LwC7Zbj+l8U9ZFuee?=
 =?iso-8859-1?Q?xqnmJQ6PcIi4iSin41vL/2NbZwv8NdBsE4hFuBhopnSF5ATPSSczCsuITx?=
 =?iso-8859-1?Q?lA3kP5yzbMfzkmSWNlgdc+aZUvlKJPlnpdnNAWCaHTfgPflsNInzu5hSOb?=
 =?iso-8859-1?Q?Dv8dOpDry2bkCoGgD4iCpn8s9+BVlolD7HwZ4Wd51uAesymZtWXpT5qoRE?=
 =?iso-8859-1?Q?+QrZmm4SeHmWs8pDSyty5CbgCTM7jHNmTBCgLfDvUqlUJ3fMy7eAinP9zo?=
 =?iso-8859-1?Q?UmwCQJ1uLy8JsaNDx5BfBhUM9y5Kd56m1mkxZf+5rra7jBdCtsYojsjLh4?=
 =?iso-8859-1?Q?tfovTc8adlYiodr3oLZNurG7LeM3vfyY05dti08C8GvuZuZXsSF7QkPYdy?=
 =?iso-8859-1?Q?JWmXYr8dlfz1RrJWkC8sNGwo/eau9ljIv2JKOeFgL3qmsiO8Xwsn0hDiiL?=
 =?iso-8859-1?Q?PDDSnAa1ugz1fHA9t3yzZMG1YBdSZYPcqWqbOpqwb1kMXhtxthN5p8CAqh?=
 =?iso-8859-1?Q?y7LYOGcQ0UKNZ2VpDGIvkKAlolhEFjBT8KVfMU7fbBfHSoJjbVRsZX58Q5?=
 =?iso-8859-1?Q?01JZaQbn3/m62Kjyevt3osa6Zoei7P+Ocb?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b34c80-70e1-486f-d1a1-08daf019a5f8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 19:10:17.7148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJReP52BQp3awhvVJiA24i/OmdgTGrM/xoJSHrw4dRXo4YBAH6IPMhormRQ3C4fKGPTUGxl8MkWqT5qKJNIsNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8195
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E9_?=
 =?iso-8859-1?q?-_Nordicit=E9?=
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the ninth bug-fix release of LTTng-tools 2.13 -
Nordicit=E9. This release addresses a number of issues listed below.

2023-01-05 lttng-tools 2.13.9 (National Whipped Cream Day)
	* Fix: lttng: poptGetArg doesn't provide string ownership
	* Fix: relayd: missing space in trace creation logging statement
	* Fix: event field value: assertion fails on empty string
	* Build fix: rpath of test libraries results in non-reproducible build
	* Fix: never use 'no' in a command variable
	* Fix: sessiond: abort called on undefined client command
	* Fix: consumer: snapshot: assertion on subsequent snapshot
	* Fix: sessiond: instance uuid is not sufficiently unique

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.9.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.9.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
