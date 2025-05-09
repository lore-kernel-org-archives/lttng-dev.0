Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4412DC3ABBC
	for <lttng-dev@archiver.kernel.org>; Fri,  9 May 2025 10:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zv4MR1qHCzydH
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1746785013;
	b=AN5j1MzJpVr3nlzf+O+EXH909APU74WY5/qcMeAdMNAcKk+wcMcDz2PJZimT41XyGRXk
	 3Czk+CbU/u9ulj8TDJV4HdrISmBWaT3+/6TLCiJ+LUH25Hk4fjbDqQkWdxwPdCP/GvfPl
	 RtRa1+S9ZjhaDF2uigNsbaIxCxEOHGqQJ2mn8jfZgRiW7RAD0LfYRZiSO32UURxKDJb36
	 hBYiVEZ8uid89Vhy2gqE+35PCsR1fhSO8nWF2B8lZ3mXHPbWByg3+hJhEmLfDnIQ48Dm9
	 6lLxsiXJAfv508qZO7mwzA7viAk/SdTvVFQyauDf8WU0Hg0UsqZrhHEsQnUKvYj8rDQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746785013;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=8ZYoA67oDxmskF/hYckMNhf6T4auXPiP3ctvoT+jgeo=;
	b=OhPjb72m29ItL+2VWxREINrQPh0sdK0GGe3ZdyuwLDHe3lYKkOkZwZg0CvpiIz8tWhQB
	 ubqFLpOOsh+GsYIbE11Y6QsGqtk1QVdKFy2cinavTdk8cUgvpE8uUHA9ulPJc+z4FXUCj
	 9wyE9fuAG8BBYvKAZw0uF54OxgC97HW0Vd4Qd2Ow2p+O1z+T/m78QoCeBP3Fi2m1+D5oa
	 q4mIhzq6TxAEhPKTTtGYgKe34kRaCMPXnDof8vvvj/kmnduEHVaQRJSP8s4inOrQL9WRr
	 dlG6eO+HabPPivfSxz7BHeL+QdlMBUy6msGZDMNnJSiCAMYBxIppGzkcx2teYuVLarg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zv4MR1qHCzydH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746785013;
	bh=8ZYoA67oDxmskF/hYckMNhf6T4auXPiP3ctvoT+jgeo=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0TmqgLZPK9R4fT0w01kXPE/z15kEbRP5zissd5aElkHwJOPNeElgkXbfUm7ENeE4I
	 yOdAkqPuRcuO8lEpmAJF587zXo84mUgtVsjibDlCDGFpYAXiHMbuThZiqMGhjMPfG2
	 VuexQ6mVxmJYsPREA63Yna9/lWStPKf1efwkQoX0F/GoguPEbaNyfR0JSJ9pf0Cd/T
	 HwCxLws42KcxlvHBzvYybvyijFtTkaeSbcj3cysk9Nj8jC2nruNPSboVDp3rfD+6nF
	 CTE1q6CAV0FWtREwHn+DisH35Xi1T4qbS4+or0jug79RfsIdrfl/9UUikdqy2XO5MM
	 SxNCfu5t3Cgxw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zv4MR1qHCzydH;
	Fri,  9 May 2025 06:03:31 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zv4MP0xZBzymF
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zv4MP0xZBzymF
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70c])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zv4MP0xZBzymF
 for <lttng-dev@lists.lttng.org>; Fri,  9 May 2025 06:03:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLPo47ln0HvByEYEOo0kJ3whyCvxdfSnCg57aIlIHttiXOiiUPBWmwoJcHH8TcjOoCb5hr2AWiuyYi+9m0a6rkkUK79KqTetRjPR5zu+DlQN72C3REutKBTafkoi87q6CGiffMGWaDt3sr9TtIgctq5pKZg0T/afkALLvhxO6aAv+tz3WF55TihSDJbm3v2Clzb7q0TsqMUDguwN8KIVXsnUNKkIEm6qn5EynCXAVF+UbGuS2nr5icvGegRKwKtlpuZ6vgzRDVwzTYghY71+r/XZAAyvJkQ7K/mskgi03oKf21WFaYH1AlfbZSNRqZSzIvb/dGYx0CcjPCggtyRjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZYoA67oDxmskF/hYckMNhf6T4auXPiP3ctvoT+jgeo=;
 b=vQU7cBjhqplOQQ1AfGohXRG5rghq4bi+3s4D+qMXEgunS1OcXD01AgH0ORWoaTXsVt4oDoN0ZNSTTdgmL7gTZavAc9itjZdMfrsKOZVX5ozCZUO8VEFw4IA3SLaZnv+TZ2hjDplIbcegxP1SHk5PO/SdUEgAFIAsCtU59UzFT6lOipE7kbfyw50rsNdtiGxN+jEQPZ5VKhDNje2+ELhyw+GeoALDiUB0w/3qMbHN2S1JoZfKIxtBUBmQvhAZFS9oGwbxBOondJcQyeVcA5IULq6xUn+5yji9FRXhWjpt2qMO0PhJ53RW8UUw0xk4vF4j2FNWRS6rC1WqwvYCKWsv5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
Received: from AM6PR08MB5013.eurprd08.prod.outlook.com (2603:10a6:20b:ef::21)
 by DBBPR08MB6089.eurprd08.prod.outlook.com (2603:10a6:10:206::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 10:03:24 +0000
Received: from AM6PR08MB5013.eurprd08.prod.outlook.com
 ([fe80::2277:ee89:28ee:ac0a]) by AM6PR08MB5013.eurprd08.prod.outlook.com
 ([fe80::2277:ee89:28ee:ac0a%6]) with mapi id 15.20.8722.018; Fri, 9 May 2025
 10:03:24 +0000
Date: Fri, 9 May 2025 12:03:23 +0200 (CEST)
To: lttng-dev@lists.lttng.org
Subject: Problems with arrays of floats (lttng 2.13)
Message-ID: <00f6c849-e4f6-396f-9f71-4b58bd203eda@kuleuven.be>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: AM9P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::25) To AM6PR08MB5013.eurprd08.prod.outlook.com
 (2603:10a6:20b:ef::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB5013:EE_|DBBPR08MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac4587d-6ad5-4cdc-1f25-08dd8ee0bc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJnbbTqrb0I6xDn60anNtTnXodtovtQsvyySHL++sgqnxcfgpecX60sCKtv4?=
 =?us-ascii?Q?WeqnqHtPuU5Igc6i4rkrU8k5OxicEcJt66fyRmn70FykQftaDEFDdAxiu6Oj?=
 =?us-ascii?Q?G4rBobkZc16BWpBPiwipW1/XrkBhdRxx/z26lCsB9yStUmQTQpCxbx0acMaR?=
 =?us-ascii?Q?8CvPS+qhG0DWLKeZ2SDluNicmJ/d0L8Xpfk4D10HlLWgze2yTg1e8fqmjJG3?=
 =?us-ascii?Q?k+4oPtKnBNBogrCOstJz6ObDHbVYST4JRXJg8GvfGO6PZpw16ndgazhVgsWt?=
 =?us-ascii?Q?8uBNybs9FSqvABnkpx9o3Xq5j9DgvZcvXb5Z6vyWTwgTqGEvxCV/wcvDQ/xW?=
 =?us-ascii?Q?aIQ/6GuXbcU3hUgLaeteUf3ZxLUwXU7wUZanVG8VkGeaI2fhH3fOvQ9WPlCy?=
 =?us-ascii?Q?aMfX144kdas0sp1SZE5gesHHm2l4VXhRGRzZ2N8Y9oJtO3qxjwHUZzXS253/?=
 =?us-ascii?Q?AvHZGtfQVAja+kyfEh0f166+jSbsPFPr9ei98eTvXONNcaCFuQDxDNtM9o7V?=
 =?us-ascii?Q?SfkddyYPqeyBQ8eeWele0yu94DB9e73gCjIJhlhkLKKvemkaXozl88CRgDfG?=
 =?us-ascii?Q?Y7XQhq7BnjWiWhgFVQzI4BpVO3kJpfJuxEOhUx42oeV418hpMi1UC/tQsSgp?=
 =?us-ascii?Q?oy4DGcs1sLBk5H8uVEDxRaD2bbZNmfuKA0N7tmzdA8NiCKTXg4XG7qTkwVRO?=
 =?us-ascii?Q?JQmqMvkyl4pXpw2rmVRr+b00sf+0uUV7D4FdPEInvq9r7yBJnNXmvkyjngDp?=
 =?us-ascii?Q?SnO23NNT4ger5K5JGmcO8UXQZ8K5BeIB7Vp56VfQ/LVnNoL3Dc9bVDoQ32SD?=
 =?us-ascii?Q?baxbvmDZPpwPCRhnxMEsGAbErBp3ohQxadPsdS9F9lTLd3AS/Z2SQPDpVSaG?=
 =?us-ascii?Q?t088jqjNhQ2WK5PV3ASDYnmqC/jeCwZJ/27D8u9sOw4Xx8wmHZdIAtmtxU9S?=
 =?us-ascii?Q?wqeTjbvIJ3PTi2uOMKXA7DNHK/AbD55OyyW68NrGdlCo98G6453TTv6XNRHh?=
 =?us-ascii?Q?kHkFHcxHUSvhF4+fNYPpc8r7/7mcmrbxYfByGh9cG/jJeaqoPjeA8IIGZmXc?=
 =?us-ascii?Q?JeIq8h5FMn3el4L6CZBqp/LhKoaYU3uKdb6+0fPrRmZLNyySMMnEG/yKXgwf?=
 =?us-ascii?Q?FRDo0fL643LWfYTBQIlLGill2Mv8nryno+XYlL7See1+dy2wvZxEluibNjF3?=
 =?us-ascii?Q?ciEM5okuqp8Ckd6xc77eFbsfljs+8TQH8ZDdNQw72S3u/cT9gBQFwyKNwTsB?=
 =?us-ascii?Q?kxITaZZsOrWpOfa722SaUOr6qzOnhAyEXnBmWkLk8uml/veZL2FFscKHWTbG?=
 =?us-ascii?Q?862KOejXIh2CYUTJccs0WxMlbahu0ght4+8p1hbCXz9dhW7KxNng1Zi+p761?=
 =?us-ascii?Q?suXQkwlzbCiS0vURrumYcaaOwkHxk9spRByD8QgVXBJIpYcbLJIyJVhU7xV9?=
 =?us-ascii?Q?VuUV5QEz1co=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB5013.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+x9PMtkzQAGfBl+aWHMBQlGwpLrh3lT7FbB4SVgYV/NieTGJC5WfjWFSwNCs?=
 =?us-ascii?Q?RCUVOphL9TKKPHuLV0Xz86EKRohgNM++OipZjtLXRdT/CY6TyEmgbKgwsKx8?=
 =?us-ascii?Q?jLGPXL9+a/0Ar0MWzdqOw6E1Gcv+YQRs9QrvqhyU8u9PXLU4vAlm/XcEJnnv?=
 =?us-ascii?Q?xAARMNHq5ocsdqutM8fI1SnXY1VmUAIoyxG8mI069n/A9Q+/ksvPVqCXuRi5?=
 =?us-ascii?Q?+yjFRpFiklTYi5mMuBcDgGdGkQaf63dfuEm5woGMFSKxeUjoi784lScLduZF?=
 =?us-ascii?Q?LzEntyKSyMx1iSstoqIyaHTnmeKsjk9JjEweL9pUvwBgIAbWMdJ3dsv0rTrn?=
 =?us-ascii?Q?vGoN9Srgjy3KoFiSPK8+dXvLZYNm0icR0lFHOP06T2HBb1YQ+c+gGAB/ddl/?=
 =?us-ascii?Q?gvO1faEOeh1OH4TDD02mUYoqzMMZSdr6IZ0Oc4A993EB8u2f2Dh3zQorXGZa?=
 =?us-ascii?Q?nHAPj3NUGHCXE+uucn6qaOzcCwwOzSfGq1MIt/H2NdwOFKFAfOYlaQ3MmuDN?=
 =?us-ascii?Q?IlmPaL65oKfj4mug2Ikp1l+z+J2dSs09wpkd9Eu7yNr+PfSD6/GwEpoKuttK?=
 =?us-ascii?Q?S+K79SNWZ91ubJoyat2hJXbz5ar1a94Jw7DPuCSDcSLQEFuqjVh81BbuNGMs?=
 =?us-ascii?Q?Tc2VxiDj2jlZtsp5nUF5ye8k2DDPR2M6WRYyTMiYflx48xF6C8OOVbq2xKB0?=
 =?us-ascii?Q?xk9hz+gyHTZke0Tb5+fDXT3jduEdu0m2qzvzGgQuzc26l0wfgS6h722xQyHQ?=
 =?us-ascii?Q?3PfUD9Q+6+v3TTMcnUUgBtWwJLAgMC7zqoOknjTr43TwkANh117U6g1bZxNd?=
 =?us-ascii?Q?U8pRmfn5bIHX2SpnMlGHnOBf+sIzvQ5P421Ta0aLdBUk5pDI9u5ScciYxxnA?=
 =?us-ascii?Q?w0DrneN/ABormJsQ7ZkLoz4c0WF4g8qAD7E95bjsNqhpa4VtY6msmJvZrY61?=
 =?us-ascii?Q?2VLcMeOoMiYffK1ufQsIvlKi/NEsRlHl6RNHT6OVL/GEIRj/kDPL8QCIsJrA?=
 =?us-ascii?Q?BqUTBogdzH1gamArljbxZo1rd5no9DroENAc/e4QklwnSKa00B1lyNZI3Qxa?=
 =?us-ascii?Q?cWtLnoSdxGVRhent+K9vRa6a8I1+8uvqdwXzHh/t30gVFGhh+GcXX24Nl+Nz?=
 =?us-ascii?Q?mlHsw0tmdvI/zK7VO5d7Em5yqsmXtr0kUJUSGzQG67KvAlTwmj5kq5u7fiw4?=
 =?us-ascii?Q?q60k0GVCDznoLf+GZIB54TIeHxI6TX5JJkxYvGu4AEMBCyCDsyKUPOlH/BeK?=
 =?us-ascii?Q?xWTfktE/ZoYqg6FLAX8ckSQxXz7CQlOWy/3MkUaGu/ZbQ32Kz14ymlSta9H9?=
 =?us-ascii?Q?jvvcPUP7oHOvMiMV8SE54nRY+N5P1dTqb93Crln7ZsktE+WaVzZosDh5b+4A?=
 =?us-ascii?Q?0mga7fp0Cxh4EC0a8r/dPuxquIHbE8P8xeXVH7foBlGN1jyUrPHHRLbkXUsm?=
 =?us-ascii?Q?58ewZOLSzDfur4QUsP5CcnOCHIHXTLYzkNcdqhynuG5k2tVa/lP7NibJCW2r?=
 =?us-ascii?Q?gBYQGnHAjCxwVZxkAogBGl765oLYzHoVRI7EQYVn6rGilioRIlYeRivVgajx?=
 =?us-ascii?Q?n1MZuSqDhOyxatb57ZTKel8RjPmzfVSY20ZnMUalyXcDsICk9Cvbd1I0yOeP?=
 =?us-ascii?Q?LIUEc53WjzsotxSMNHBgMgckaPS36e0pgM5IkWFV+uDMaKBteTCjgA1ryf7l?=
 =?us-ascii?Q?vMFXqw=3D=3D?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac4587d-6ad5-4cdc-1f25-08dd8ee0bc5d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB5013.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:03:24.1311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiqDrMAQa44EWMZMRAJC+6T1QFZVV0ZIs1NuEGHfzRGGOjXYpqf/3t1diM5qSZpOKXEi1I9cqwLsHr38+vy1ZIMLocxz2uUW2I8htvUWGmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6089
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
From: Herman Bruyninckx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Herman Bruyninckx <herman.bruyninckx@kuleuven.be>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Dear all,

I want to trace an array of floats, but I always get bogus output at the
(Python) Babeltrace2 site...
I have no problems with arrays of integers, though.

Is the float array feature not yet implemented in lttng 2.13?
Will it be in 2.14? (Also the "BLOB" feature is useful for me.)

Thanks for your help.

Herman
