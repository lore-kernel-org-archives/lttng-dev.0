Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296EC44536
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Jan 2026 15:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dx7G22fpkz16Mr
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1769008908;
	b=PdHy5ueBzxSH7xGY28A2SQ4W3ADtNr77zYUL/vJ3weDOgtQLVZ3s9zfotJARY3i7mH/b
	 eSiIkqBpmtdAImVyIsYLc/VyLa00Tq5anFdZuYAIhb64X0Unf0r8ETinWJj2M9ufeU1xg
	 s+FOFssaJylvcAeY7NyjPt/Usfgbj7A3V/eNhnwUK+T4Mh/N6E7riCU0bvTVJG63rvYzI
	 qVlkoYD1tQ1CPSCGCzpVDYQ3Sv0H8+OT52ENDvuFrHMHuaoAuy/+GA5HAKbX5trGTnYiF
	 Xa1j4nDHr7qq82zk63yHckLzSDFk0t7rN6Zlx0t4Vj8W8FGyYU+hnXo+U80HpIr2acQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1769008908;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=oVYAA4SWcpNOStpkhNoInCMnEpMQ4hAvRi1MNDG9iv8=;
	b=Jfsri5iO6j6eHqTi2sYUSjcW59flP+ZtU9cBNukE3IaFWL4cOm1hCOODcZZodlU+T2TC
	 zuALB519kgyGRUeJ4p+GjJmACBA5Xd+1N585A4Dt9B80G6CrfQ6NkLjJLHGrV83/Et3te
	 6N6GN1oliddVKn21eD8GfjRoobMwPeKynwEvhObWodj69EYNs9af3rRUvukrYOhJLxPH1
	 3lk9Ng+kPlPmg1wHG6BysttsVSS86gLmXdboz/2cV4zMxhiJCyy4n8CXYw4Vxi5B3SfFH
	 YP+ruVO4t2kGgNLxe2ebkyqngw9N6dg7QLyE7s3P09uirTxbqzbqJvSUb+NZSJBcyuA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dx7G22fpkz16Mr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1769008908;
	bh=6InjapQSEYRW+E59OtI4gl4lGqGBbqO1l3uQ0/Dmaeo=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rpFTKZ1M596BM9gmjF/w3sARJMc2X8f/mbvXbwtC3WMPe8S09zJBda60OX+CRN7WC
	 hmZmocYZx1OKBtqjxYrWKj67VQi8QUr4G6wX1g9dpk5lCcyaCYwYuKOkIrF4HLMIYj
	 /9ZV2vlxKVWqgIbtHyGaQYUroKHbNt+N8C1q41YSHklkPokI5sq+xpIPWHpD7RGkny
	 X3epVgeKP5q3Bu6YpXRcVPmiPWLWod/5ghNRHTA61HvUgG+27GPTlhqL0XaAkOUXOL
	 qs5I7Ew6onJQSzaP0xlMm5DTm05B16Lxq3GKDOf1iMbVuqSiOlUVTZ+/pgUCGjHPex
	 Uv6Oxv9tpteAw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dx7G22fpkz16Mr;
	Wed, 21 Jan 2026 10:21:46 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dx7G03PStz16C9
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dx7G03PStz16C9
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazon11020094.outbound.protection.outlook.com
 [52.101.189.94])
 by lists.lttng.org (Postfix) with ESMTPS id 4dx7G03PStz16C9
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jan 2026 10:21:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn8B7tLdfruPTAaymI8GzQmtYapbVkVdhE2fx1Y0mT91TiI06v5kmNeBcV6tNjimwmP6AoIa82Vdugho8m4Ou4DcwwSZjaOS14o87BlEhv0gzvFbsV8ZHroy1y128NGsgR8E2iiLexACDc0uix9rIfHpqACD+S8ElEHuPTu0JSDX5auzbJoj7I5RJpXrVefin9d8JfDmTzW/P8A/+htQV+WeQdXwTZvEjZQwHDK7iVy6o8NigOegAeEUniu88+x3r0Fa1VMb6Hen1gFwr9jDfmjP98l4ViS5HiZGlpa3N5vlqtxemXwHLcoMBdRXpRHXiAznvKfgGvqdAMG/IgjmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6InjapQSEYRW+E59OtI4gl4lGqGBbqO1l3uQ0/Dmaeo=;
 b=YOT/xrfbyhXkBUtrMC1w2+pgZJpE37Y7N1kYaIAsD84QFegyoVfVufDIk7Osn02hf/uEE5CYrVtOHOnWXvBlKOxUY0GjwfP4Gysy2nDvouU7qYLeNc8MUNS9+/jGoaVHfvtL1H5xGdiWDC9CwqQINKzz+96DHycESSu8r5OEn7FZy2AmHzSuDnB3szhrahOXDola7PeDGtPsQ9NVvQj8HDj3FU0vOm7qyhv6rEb/gQT2WI8LDYeGEX+PKKkwjl/BHONda+qwQxd+vfl1m8wATZLzWmky500k0EC2ll+iqDdYhWn42G3MXJiviGi1PazrqDmbB//bDOYMiegLlfvC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB8693.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 15:21:41 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::78b8:70e2:6bf7:1a86]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::78b8:70e2:6bf7:1a86%6]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 15:21:40 +0000
Message-ID: <c4788d1f-f968-4eb0-877b-58cdc6762121@efficios.com>
Date: Wed, 21 Jan 2026 10:21:39 -0500
User-Agent: Betterbird (Linux)
Subject: Re: How to build lttng on RHEL 9?
To: David Aldrich <david.aldrich.ntml@gmail.com>,
 Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
References: <CAJK_ieh7GpnMBe-J3ktiU4EmE2puqafgx4pmEBoJsbqKz9LEEA@mail.gmail.com>
 <c3a11b9b-5cd1-4a0c-b15c-d86a5f0d3924@efficios.com>
 <CAJK_ieg60p6=3sdLSQGoPPEYGx8J=VdFS5vHx-=0APvpnOUmuw@mail.gmail.com>
 <CAJK_iehfzujSUOUjh4WqWwP9-fndEDHaNXitmgKE80gUhbJ5cw@mail.gmail.com>
Content-Language: fr
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <CAJK_iehfzujSUOUjh4WqWwP9-fndEDHaNXitmgKE80gUhbJ5cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::10) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df8dd16-3b53-4bee-96db-08de5900c6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnJ3SG1lQ1Fpblp6YlVNeldRZGNyU2xWQlVoRWR0czRYaUp5QWwzWHFOVFBO?=
 =?utf-8?B?NGx6c1JNalgyNUhKeDA4aGhjc3cwYXNPanY4ekZWc3V0SXlDajFYZFdRZHpl?=
 =?utf-8?B?bmx5ZGtDZEsxOTgvNFZDbENqM0l0aHVXYTdmTlVaWVZQWU1NeUoxNTYyTTYv?=
 =?utf-8?B?MHNiQUw2YmVzRXpYRkh3WUFaL250akFZMDVlQ09nYi9pS2hvZ2RhTUdSRDdN?=
 =?utf-8?B?MHhDTGN3UTlJR3VVVStUWGRPdVhQVkdqS3d6Q1BZaW5JbkwvYzM0T0tBVDMw?=
 =?utf-8?B?amhtWXNFc1JzcEsrT21hSGZYU1JadEw3Q1FoWC9FL0YzSlJUN2t5VTFDdjFx?=
 =?utf-8?B?Lzh4Sy9SU0w5WXRtcG1lTzg1TVhZc1lXYnJuU0NWYTN3YldkT1dFb0xZY0ZU?=
 =?utf-8?B?ZVAxL2hjUTZCc1hZVk5MQWJJbS9SeVZLenkzd3JBMnpNbHROVU01ZmhvQUdM?=
 =?utf-8?B?R285clBnNHlONGJHRUhiUm95RDJ0ek9LaXlXMmVYSElrMGZuWHI5NjRLYXN1?=
 =?utf-8?B?YVRSLzAydUEyTmhvSUNwRm9WNDFtQ0IxU3FqMXJpQTRJMk1uZlg0UmRMcmEz?=
 =?utf-8?B?dDhpZGROMnRyUVAxcDk2RXQySjlEVHpjNEdXeFhISG1EZDI4d1hBRzY4alZk?=
 =?utf-8?B?VHg4azFvdkRxMkdxUnl6SnVUV1BtemxQWWlLRTI4UXhOTldsN3NUUm5lZkhp?=
 =?utf-8?B?MjBqQi81NHovR1dsTDF1L1dhM1hYMVFWdVd3REQ1K3FtMmF1bThpb1J4Y2lV?=
 =?utf-8?B?Rm5VQy9zSFpieitBMzF2UExuRGhkV1FqZjlUWU9mSTFlS2cya3dXd3R1US9i?=
 =?utf-8?B?OFM2bUFYT1RKMjN1N3RLRGlKNTdDK0xNY1lQY21hQmY3NE94bWpBOGVSN3VO?=
 =?utf-8?B?cW1DYWNjWkZ5Y2pYTnVxSUQzTVNBSlJRK0xnVHVPZjE1cVlBckRnbXExQkJp?=
 =?utf-8?B?bzMzeE9KMGE5N3hOMHNuU293VlFmNlk4VWtiN05LTm5xZ1MzeStJSWt5bXht?=
 =?utf-8?B?RkVLMjJMcE0yQUI1N1pXSXBibVFLYXczMUNUdjZFK1l4NElKQ004bjFTaXdk?=
 =?utf-8?B?QjY0UXhMVTM2WlI5VW95eGpld21SL0EveWdGUlZkZVV0ZUVLR1dZRG1ieGxC?=
 =?utf-8?B?VndpeUVocDJyQnVsTDNrOWZjeVFab3l3SlZqaWtxVWRFcnRTMG1lc1VCUUI2?=
 =?utf-8?B?WG92K2lNcm5jVncxVFhHKzU3elVqNzNIUFJRdjlQTExhNFFKUmhKYXMrL3pZ?=
 =?utf-8?B?YUxWRitLV0hCOUNwSGpCK3E2ckh2N3pLb2c1ekV2RUxDRVhETnJ2ZDdYdEwz?=
 =?utf-8?B?Rlh4ckFtL2tjQ2V6d1lxRmFKKzZiU20zMTU0V05aVGZ1V0RJLzUrcmhqekcy?=
 =?utf-8?B?eExZMWNyR2crTEJjYmR2ZlFVbGZoS1hVdE9mYzM2OEVURDkyVVJBdWtiblhp?=
 =?utf-8?B?Q2Nxb2U4dmdndjgya0FDRytlcVZDTFVYaE93T3VxS1lUQlNzWkNYSDkwc0J1?=
 =?utf-8?B?RFF4WUZ0Z2tqeHIxUGNkdVNtaDRqVlI3TmxWcnBtNVBhNkhxN3RBcnlZbVB5?=
 =?utf-8?B?VjhDdTdWR3FtbGdtc3hSaXA4T3c0N3FoSHVBNGJxdnVqM1E2YkRYVmtNeVpq?=
 =?utf-8?B?anZaVkFsSVF1SjJtS2N0cGVjREJ2eDBKSFRjVHkrQUxhNWZNVzFIbU05cTh4?=
 =?utf-8?B?UHcwdm9tWE1wa1FOMXFTUW1sRkRPV1dXWGVnVnF0eXlMdGVRTkRibG02clkx?=
 =?utf-8?B?UXpiRU1MdktFR1JFd1IvRTAyUzUxbXBQOC85UndadTlyL0srcFAzK3Rvd3Vk?=
 =?utf-8?B?MDBGcnlIWk9nSzBWNHNmRTQvNFRaM0dGQ0NqRDZ0QVBuZTlJclJiYUc4UVlV?=
 =?utf-8?B?VXFIS2RTN2xqT0hvb1Uycmh5SFNMSzNuOHM4aXlSZk8zMG9vY25hY1JYcDRW?=
 =?utf-8?B?RzZkNWhRbUFpRFppc2RBL3lCUlhBa1dvM2pNOW5WZG14QnAwUU5RV0RLblM0?=
 =?utf-8?Q?i6+PyLFd8FYsLJ+SjGGgyN/iPZac+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjduWnU4TTJnUDRsaithNDNTYUZaVXF4b055ZjcwMkp4RVBUcGRMcHdVRXY2?=
 =?utf-8?B?N00vSnZlcFVHMW0xMU9lUjBWZ1VKNU1sN2pJbXFnTVdaUE9YRjFiUCt6ZTRh?=
 =?utf-8?B?VzBQL05zaTFZZFg1RzllbTRrTGpxcmJUT3lOdjRvZXIzV2xQY3FoU251Wkpw?=
 =?utf-8?B?cEdPZjNYaXdVWUl0ZFZyYXArMnVBSHdPK09FajBKeEtNSDE1bFVJTDQxMjNo?=
 =?utf-8?B?d3U5VDZhN1d2MDJ1NGZ3VkFKbUxRYWs0SHM5UnptYTNwUlR3bnpFajZqMlRS?=
 =?utf-8?B?L0NIV0xOSWZYRDJIRlB6WUZkTnkrZWZidEpONXN6azlrdlBtVTV6MHRrODJx?=
 =?utf-8?B?cTdiajJZLzlSajBEeVJoUGs3TGw1aTNPdkh2emt5Y1d1MVlCS1cwZXVnZ3JL?=
 =?utf-8?B?SjQwaEFhVlZNME9SdmdnM2puMm9ycENhWDJpc1E1bDFsejd0dEFvMXF6Rytp?=
 =?utf-8?B?MUVDVjhibnZtQnRHc2lReFZSVWtoc3R4UEhvQW5KN3R6VERiSGZUT2ZpT0hP?=
 =?utf-8?B?WkZSVWJZUHRpejhLaXJhdER5b0QxQ29LMnVHSUVaT2dOcjNuUGNkSk9SbWh4?=
 =?utf-8?B?R2NjV0JmUVlibUFJZEJmS0s5SmlHQjZHRnVUT3JaYVBkMUVXaEtVOElNSUdw?=
 =?utf-8?B?WFdoUnpOWEJjWWhqMmJ6eVo4WVQya1AxMjhTRmdiTE9tYjFmSEU3MmhuVGNC?=
 =?utf-8?B?ekdBUjhiZnFYMi94MVdxbVRLOUYySjNTR0tSbjVUOVV0V1IwWGVwUytLRzIx?=
 =?utf-8?B?clZOMXFJNG1BWGVHaG05VzZJQWtjUktmL1EwMkEzdVh3dHN2T05DVFhMbWtU?=
 =?utf-8?B?ZXY4TE82ZnpQZUZVdHJqK0tseFBxYit1SmdoZEZxMWo2SlczRlZUL3RHcVZG?=
 =?utf-8?B?Y01QZ215Z3FCcS9JcHJxaEJmZTFYRWNUblAva1NPZm5pQlN1akNHYUVueGpy?=
 =?utf-8?B?YkFHZFlVd2U5ZEFmcTNLYlVoeHA3OUZsdldaNVZ3dnplb1NISHIvMFVyb3hI?=
 =?utf-8?B?ZTRVRGQ4RjNVNm8waEYxcU5TeEhtWEtPRlloeVRkWnJSclVFQUxReEpvNGlS?=
 =?utf-8?B?aHJhTnhjZmVUaGttNEdtNjBHaUd6RDY1b1QrWlFiemVMRUk3YkFjUVBqR3c1?=
 =?utf-8?B?L0V5WlByR0IrdGQwQkNnaTdGQ3BUVlRSdkZBWEFraTVIbHZqSGxmSzJkRkw2?=
 =?utf-8?B?N2pDckM5TVlLcGNCcUhsL1hCYVJGSjhzUENBSC9VQTFOT2E3ekxGYklzWGpC?=
 =?utf-8?B?K2pwUks4amRyVElYRlEzTEw4a0pWSzJwVGZXMEJUWGVNQ0xwRzFzOGpPcmt3?=
 =?utf-8?B?dXRjN09lRzBJUkZKZTVId1ZrUmNaRmNGWWUxTGNEM1E1dy9kcWRFTEJwa0o4?=
 =?utf-8?B?QWcrZkU4c0dQRWwrZmY2U2wvckVOTkZiSVM4MGEzczEzNU9idnd0K1FCekMr?=
 =?utf-8?B?dVgvU1hwNnJacTVNQmcyVDBwWGF5cjNZdnZnbXByQUgzWDBjcTZGcXF6T2Vt?=
 =?utf-8?B?eFpNakl1QjdTUmVoQWJ1S1dMUmFpMGtNUWdsM2hXV2hqa1pjZmdaN1VKUTl1?=
 =?utf-8?B?N1ZTWm16V1JkOWxXNVUwUE9oMURsYUhJcDY5NTAwRWUzcDc3V25rWS9FUnFY?=
 =?utf-8?B?L0hlUytUUkRDZDIrZ1Vocy8zZWw3TjFNR1NCQjhBRHZWeEJDeSthRUpzRjUx?=
 =?utf-8?B?dEMvamVUdmVGVS9qWTVwdTZSZ2Q5ZFBkWlZhbWZaa1krMWsyTStSM3Jyc0lK?=
 =?utf-8?B?Q3h6UXRkOVJGeGtrVEU0YVprY0I2QXZ3OW1ZcVd3emNvNnE0U2tiZytkZ0h6?=
 =?utf-8?B?c0JSNUVJeFFxMlBpbVltTngxdURMdXRiWnYvZDg3VnVNTWgyOFhNYmM0c1ZY?=
 =?utf-8?B?QmYzcDM0eWxiL3hWWkxYcW5EOVFDZ00zVWlpRWlyVGNnaldpbVd6QkpkNFgr?=
 =?utf-8?B?aWJ3YnF3dFQva1ZwUHM0YlBZUm9iaGZ4bEpqdnlwL05tZzJLWWpjalh0OEU4?=
 =?utf-8?B?Qk9zYXBGVVpoT2oxa1UzbkdjMyt1QWRaalFYQkxuMWtHYXVxVXRYTGsyNmg3?=
 =?utf-8?B?dkpJOHBWWnNYSlJ5N2RFY1dGd0haY1JpbEdDQTZVNk5leGFpNWZ0MTYvTXg0?=
 =?utf-8?B?REVla01DZjY5REpZQlltZW1zWmlDZkNLQXJKYzZudGl0OHkyaE5IdmhSSUlM?=
 =?utf-8?B?WElRQWRGdnBJWEw3Z1E1WDlqNWdjUm9HR0JydXYzc0VrM3o5b2ZYaGtsODF3?=
 =?utf-8?B?Zjl2ZytIdFBNVjRCY014VlFxUGsrTFMva1hUNUlWdW1VT2cyQUQ5a1p0T2Q1?=
 =?utf-8?B?UlRDdThHRlJvVlJEREJTMnhYZzNGOWhvRnZON0FqNHVHelMrTGljdz09?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df8dd16-3b53-4bee-96db-08de5900c6bb
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:21:40.4047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/kWQTlRl5ycfufk/R7eIFVc/tsF0H/9B88Wf6BxH81wQh7irNjnHc7hn/je1yx5WLVvb/H8Wz+jOFyvkc7BqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8693
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2026-01-20 11:12, David Aldrich via lttng-dev wrote:
> Hi Kienan
> 
> I have updated to the latest kernel version for RHEL 9.6, which is:
> 
> 5.14.0-611.24.1.el9_7.x86_64
> 
> AI suggests 'RHEL 9.7 backported into its 5.14.z stream: dev_base_lock
> was removed from the networking core' which I guess causes the
> problem?
> 
> Is it possible to provide a fix for this?


This issue should be fixed in a further release of lttng-modules, if 
your requirements are time sensitive note that EfficiOS [1] provides 
commercial support for LTTng.

Regards,

Michael


[1] https://www.efficios.com
