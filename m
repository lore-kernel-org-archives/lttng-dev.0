Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21764C433FE
	for <lttng-dev@archiver.kernel.org>; Tue, 18 Oct 2022 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666118564;
	bh=xd7Vgx+C4mrDWIr5FHJKAOFYx3SxIzrY0v2NIAt4nf0=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=mqo7dGXMdFxZdIzrSFhTYvcA60gh5uUabuT57or+SdZ3511f7+ck31MPohCUT/bHF
	 7yaLO8g5HVB9hIXIVZ2lABvLuSpnZLt5oawHHC0L9hi33FzbGpUwk5od90VC06OLie
	 a/x4NquUmTFuJ3MljP1n0cuA5r4J/a8HrQG9ys9xMWay6fsuv+rEyZBsRLdFCyOkKU
	 PRAHywGZlHjYdcv+KZfcEszcS3gWizetSz4cfjq1/4vuBVXZiMY+nnjBciCq1dSX6A
	 DoiWPLvDc/tw2hBebPLziHJKFYg3GzOxbzxUeP3RnOjyM4Z1kKSFncF3zLv61MbD1B
	 mHP+wvYnMvg8w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MsN5b3Gsnz8gs;
	Tue, 18 Oct 2022 14:42:43 -0400 (EDT)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by lists.lttng.org (Postfix) with ESMTP id 4MsN373G06z9MF
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2022 14:40:35 -0400 (EDT)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IGJqfe030511;
 Tue, 18 Oct 2022 14:40:30 -0400
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3k7r1cvqs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Oct 2022 14:40:30 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIdQ3a033841;
 Tue, 18 Oct 2022 14:40:29 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3k89s10u8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Oct 2022 14:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXIxlxS87ccFMHEvdUsd45cjsniPq/f7LwhEUG7xic6DLQN3xMiD+K3p774WSEyK/NaIwX+e0RMXvx5+qCl2KIY1PqAJecXRdW5Si26cD6+WdUBTRyTkHam//0/7ndVPRCnJd04r4xFqjo3azONzx36sf1koSgPVj0Yz481PxdP+LYwBDR/rDxTu2ZX9CFco6TxxnuULQdxKwIKiX60XFe/NBaNOda38Z584Tz2vV8WEP5yzJNWtOUB8+lidnGcCEiNoXAtiDhTcfNr6ZqkBlcHf4Lb4SV0pY4kUSnMMkMHDfrzJ560pUF8n3RJrOvPS/ry21nKb8DYAsyQXwOEKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLj/hoUu4/bqRg7X+XtXbjM5tMqFCBQRA8rmSkoO6bs=;
 b=fsmvWYtB5+krVwIFCn82hdKXJZG2rfXh7V6J4/Xo60bevKzvDNaEe9l4hsD2FTr5WohfdXLRixtmxz1uAwtScCBgRCU0wa6afUSaEUELH4amfETi/ObaGy0wdoi+lswRnzSU5JPy1EluM/T3AgswAx7Lx7I+saXkvn0mZmevvIEWcd4H/c2BY3o1k7NqhL8kcSXfcgDBf7zJnYYBvLX9gagjncWw5zNTFYPlzV2L6YzfZXczp7MB/GGL3wJpsbH2slb069BzMig74lH68A1n3QYXHt+pzk5t7BXPDFvdNgXBemDPnyNAH83TOIrwioDrnKS/p9p+SnnpW9FRvZfbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DS7PR19MB6375.namprd19.prod.outlook.com (2603:10b6:8:95::20) by
 LV2PR19MB5911.namprd19.prod.outlook.com (2603:10b6:408:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 18:40:23 +0000
Received: from DS7PR19MB6375.namprd19.prod.outlook.com
 ([fe80::14b9:ed78:c1bd:11ba]) by DS7PR19MB6375.namprd19.prod.outlook.com
 ([fe80::14b9:ed78:c1bd:11ba%4]) with mapi id 15.20.5723.029; Tue, 18 Oct 2022
 18:40:23 +0000
To: =?utf-8?B?SsOpcsOpbWllIEdhbGFybmVhdQ==?= <jeremie.galarneau@efficios.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Shared memory circular buffer and K8s pods
Thread-Index: Adji8M7GViVJNUMsRCq/vvRKs+l3XgAL2ceAAAAaS3A=
Date: Tue, 18 Oct 2022 18:40:23 +0000
Message-ID: <DS7PR19MB6375A69D1325272BF842E4659F289@DS7PR19MB6375.namprd19.prod.outlook.com>
References: <DS7PR19MB637575A3329444AD675C12379F289@DS7PR19MB6375.namprd19.prod.outlook.com>
 <Y07xoexhESiFtJTy@efficios.com>
In-Reply-To: <Y07xoexhESiFtJTy@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-10-18T18:40:22Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=0dcf77ea-d3c7-4e9d-8c4e-ca6b79ff6629;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB6375:EE_|LV2PR19MB5911:EE_
x-ms-office365-filtering-correlation-id: 676f3ddf-089c-47b1-e6ee-08dab13837c4
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TsaQNR2h2begP1vCH+n0Ih8k/Hj+B0Ig4oGvi1IDRA8Fg5LnlVg4VsM7V6STtgW8PeeSILyHxbpMswhisdTWGrajY6gTu6a3LCQEbvja6nuMORFe/E2+/jpvJgpmdWYi2ELfhiMLMFhWOPKjqsr17CcSdBiZosuzzVQ3iVT+NxkQlHsJy2XAUf27d5YZPPbBPiWdGll3+QPjuHqaijV88AC8Qt6DAjDuN7q2AjmKpvPrNftP2vic0PZo7dv/Fwd1xLq9ozY2ksf7CJ3PnVg+7cfv0Ci9m3mFsT2MLs5tNj8PiH3Ebz32epj7y0DY8wIsp5bh5IeqLva7GganhL8R/T3reUVFpone0Dp3tsELfrgIgTb0bF8cw4kqav6c7BstE3hI0Qp5VH4g5Lo28iD2kIKPzJwXChZePMpLen3Pxb+rMEpcVhkowEJ9GlInyzQHdJUwc7EfkJ7pnjZeNphntOTO/avFyU1Np2Jhbo8e09IoSOR7Zq0dILpx+Rh5lpIgAHK1qp/yxaWYV5DZ5Mp8Ooh+ozLLdzDPJg1TkPLlhHKVQw3kgN1xKer9mX7X58b+IcyWBQEmxI33T9tsj1qHuOoJvVWAmjFkDVqzB3JPYxfhVlKEQHRqFnxsiM6KfYSlW9eForK9HuUtEe4XvtoE+tvCzinxvrqfZS0FxWps7g+3pU577k/G6DRc//RJFhqPx2YMpNyjSBmne26tLi/6ggzzgjmiDrTgHvuAMFPv2y29XpIy5G4IlARNEdt3C9nX+s8UX934bQjsOuYa7SXBiHFtgcQJ3hvsR6ioBm/qgjpPwuMueD0boVWHXw/BeQmMCtKM+IzXCizDTyDS0Scdmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR19MB6375.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(84040400005)(451199015)(6916009)(5660300002)(8676002)(76116006)(786003)(316002)(52536014)(9686003)(66446008)(7696005)(478600001)(41300700001)(6506007)(53546011)(71200400001)(2906002)(186003)(4326008)(966005)(8936002)(26005)(66476007)(64756008)(86362001)(82960400001)(38070700005)(66556008)(66574015)(83380400001)(38100700002)(55016003)(66946007)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW5YY3I1SU5JN1VZM2NlQThrS0ovanVYTllscnV2a1hCYkpNM0RhdE1kRmNy?=
 =?utf-8?B?NlJEYVNOOG9MczdyQzB0Z0pxWm4wOEsrai8rdjJyL20zVzhxdjJnVGcyTG5G?=
 =?utf-8?B?NElhSnJ3R293b1k3YUdJaEk0OTBrTmVYV0tRVlJCMlRqeDN2cWMxK2RNdGtx?=
 =?utf-8?B?bzA1bXZDU2F4TGxoc0pyYWcveVQ0SnFxNDZqblgxb0dKR2lpMVRTRmpDOUN4?=
 =?utf-8?B?TFhyWlM3ZDVnQ09VUm1rbDBIelBZeXJyblFYdkVad3ArSDlZR1J0aXNkenF5?=
 =?utf-8?B?bGh0R2JGMzRlbXJZTlVxTWtxOE1GNWRnRHBpZitrNDNKN3ByZXg0Z0dVZ2tx?=
 =?utf-8?B?UHZkMExRUEtYTDI3cFBDK0xnU2lWaWtlZVF6Tk9KZWxYTXRFb2ZRRER4bCtC?=
 =?utf-8?B?azJzR2NXVnpJa1IzYnNWRGtXNFQ1b0UzR0R4Sk9LWCs4SnM2VC91RUNZa096?=
 =?utf-8?B?bm9abENPZzQ2RVhaK08xbUJMaUoxWWJsWk1QWm85UHBsM2ErUUNDdHB3d3N0?=
 =?utf-8?B?N0V2cFhZWk9XQzZ6encwUkxFbjAvL0tIcmpnMHFmbnhid2RtL2NnRjdCeTdl?=
 =?utf-8?B?SWNuclJUOUsyU0pZbUY0K2w4Q3R4RVR5Q3hhVjJFWkhWMEQrV2xYQ2NJT1hC?=
 =?utf-8?B?M1JoWDI0U3h2bWJXbzRNLzFBRUJiblBLUzVTQ1pYWTlObDNzMUNQU3ZBVHk5?=
 =?utf-8?B?OUh0OEFpOEI1bmJuU21uSDcxQTh0YVNBdDNUMUhzU01vaVgzZDNuRDRXU1lE?=
 =?utf-8?B?eGFZMHlZeHBFekIyS3JwYXBqNisralUrOG4rdW1TbmhlQll6Umh3eWxRTU9N?=
 =?utf-8?B?d1BoL0tKWjQrZDdIUW16SGFDUzFtSG12OUpZMHpDM2xNMXhZSkx3VVA3ZnBL?=
 =?utf-8?B?TlVPeFpJQzl1Tk9jMGk1bzJWdDlacnJhMnhhbWxWS2VJeVY5aEVmbTlnd25K?=
 =?utf-8?B?SlFzS2dudW1FZitGVkhqRXpXZCtzd0g4bnBvS2VVeEMwSDJCNzZLS1hHMUxn?=
 =?utf-8?B?bVF5RDhVSHM0RGJJdVpqa25WZUpXazBSQXVpQ0gzb0lWVUFJL1VTUTBiUmli?=
 =?utf-8?B?bS8vR1VHUDNOWDZQNEZSMjNUT1FGOENVdkpnVTdKV0xUcFlCUVFLeHBqVE91?=
 =?utf-8?B?Q1dsdVlFS2hwWVkrVktWeENVZGNEZUU2aG1hVzNZU3BNMUZ5c2xhSE9rL1p0?=
 =?utf-8?B?WFkvQXR2eEZzTXlqQ0tmQjZxRkVSL1lJTEJ0dlgyRndWRVBOQXpxYnlsRFo3?=
 =?utf-8?B?WDZrY2FvLzMxUVZ1ZlBGR3l3SjM1RmQrS2lQUEIvaStIM1pRL3JJYlhRV01N?=
 =?utf-8?B?TUpsaUUzeE9hcXNub2MzN013VHM3SHp4cXg3endXaGlJcGdYc284WFFPTC8z?=
 =?utf-8?B?NVBXV1dyTEZPa0RGQlBGU1o2ZmlKSFFaYTc2Z1dLVHdYWXM5bEZ6NU9jUzAy?=
 =?utf-8?B?c0kwRGx1V3d6WTFFalJGUXRvM0M1WmxOOWJENmloekNoK04rdjNOY242WkdE?=
 =?utf-8?B?Q2g3UVFYTGJSUVFsWFRlczU2cVpNVm1VOWNFUzNPaTkxQm5CNDlocmp4Ty80?=
 =?utf-8?B?cjVvZXNySVhvODhpc3I4ZGNLQnM4ajRkRGtES05JbkZrSyt4dDNmTFAzMURU?=
 =?utf-8?B?N2F5WnpzSUduWW5EUDUwdVMrT1BLL2NjYmhncnlseXJFK0g1R1lEc2p4cm9l?=
 =?utf-8?B?ZXFpOXdNZXN1TVNVTmhReGZVRE1QOTZTSzViQ2Q2VVdlNzZic1F0N0pOemRa?=
 =?utf-8?B?SzNQYWFFa2RvWkxoTTVGWmphZUsrVGlYQ1d3WnloQmliMVEzYytMRS9ZYmg2?=
 =?utf-8?B?dHpTb29SSzJ2WEFVWVNySDNFeG43Vis0RFh1Sy9qcitOWEhtQ3V1U3JOZVpY?=
 =?utf-8?B?TjZyYmdjMVlGb3N2MlVwUnRGZmVTMXVjbmh0SWlWcEJHeW5ZcG9sVzRGWFVI?=
 =?utf-8?B?cXlwVFBqV0Z6bnhLUVVMVmU0a2NOdXh4VFRkb2hYTi9lT0hZT3VXcGlITC9n?=
 =?utf-8?B?YmVIMkhQLzZWcnI5a1BZQXFGaVlkWXNNcEtzR0NpNlN5MTNDWnM4TGJSLytV?=
 =?utf-8?B?K01IL1gvRVhFZzcxVU9kamJTUVB3VXNRejEyVFE4TXV5b1NQZTRIQ1A2aDls?=
 =?utf-8?Q?Wx5cN+1h0OcS0WoPyDoSEfKjZ?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB6375.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676f3ddf-089c-47b1-e6ee-08dab13837c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 18:40:23.8126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRTzDwj0nyvZOrD/u2AB6pwWk2X0WvOwodp5Wk34IvKmm1k/Dy3YO3Bm0kRKbhiUNvSDmVchGcsCVe+vMoxQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB5911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210180105
X-Proofpoint-GUID: kaPaeDERImdCxQV825woU8_s5H2PCsgw
X-Proofpoint-ORIG-GUID: kaPaeDERImdCxQV825woU8_s5H2PCsgw
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180105
X-Mailman-Approved-At: Tue, 18 Oct 2022 14:42:41 -0400
Subject: Re: [lttng-dev] Shared memory circular buffer and K8s pods
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
From: "Lemay, Paul via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Lemay, Paul" <P.Lemay@Dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

TWVyY2kgSsOpcsOpbWllIQ0KUG91ciB0ZSBtZXR0cmUgZW4gY29udGV4dGUsIG5vdXMgc29tbWUg
TCdvcmdhbmlzYXRpb24gdMOpbMOpY29tIDVHIGRlIERlbGwuIEplIHJlZ2FyZGUgTFRUbmcgcHLD
qXNlbnRlbWVudCBldCBqZSBzdWlzIGludMOpcmVzc8OpIHBhciBsYSBmb25jdG9uZSBxdWUgdm91
cyBkw6ljcml2ZXogY29tbWUgw6l0YW50ICJGbGlnaHQgUmVjb3JkZXIiLiANCg0KSmUgdmFpcyBs
aXJlIGNlcyBkb2N1bWVudCBldCBtZXJjaSBlbmNvcmUgcG91ciBsYSByw6lwb25zZSByYXBpZGUh
DQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBlZmZp
Y2lvcy5jb20+IA0KU2VudDogVHVlc2RheSwgT2N0b2JlciAxOCwgMjAyMiAyOjM0IFBNDQpUbzog
TGVtYXksIFBhdWwNCkNjOiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnDQpTdWJqZWN0OiBSZTog
W2x0dG5nLWRldl0gU2hhcmVkIG1lbW9yeSBjaXJjdWxhciBidWZmZXIgYW5kIEs4cyBwb2RzDQoN
Cg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KSGkgUGF1bCzCoA0KDQpXZSBkb27igJl0IGhhdmUgbXVj
aCBkb2N1bWVudGF0aW9uIGFib3V0IGRlcGxveWluZyBpbiBLdWJlcm5ldGVzOyB3ZeKAmXJlIHdv
cmtpbmcgb24gaXQuDQoNCkl04oCZcyBoYXJkIHRvIHByb3ZpZGUgdmVyeSBzcGVjaWZpYyBndWlk
YW5jZSB3aXRob3V0IGtub3dpbmcgeW91ciBzZXR1cCBhbmQgY29uc3RyYWludHMuIFNpbmNlIHlv
dSBtZW50aW9uIGFwcGxpY2F0aW9ucywgSeKAmW0gYXNzdW1pbmcgeW91IGFyZSBtb3N0bHkgaW50
ZXJlc3RlZCBpbiB1c2VyIHNwYWNlIHRyYWNpbmcuIFRoZXJlIGFyZSB0d28gbWFpbiBhcHByb2Fj
aGVzIGZvciB0aGF0Lg0KDQpGaXJzdCwgeW91IGNhbiBkZXBsb3kgdGhlIGZ1bGwgTFRUbmcgc3Rh
Y2sgaW4gZXZlcnkgY29udGFpbmVyOiB0aGUgZGFlbW9ucyBvZiBMVFRuZy10b29scywgYW5kIExU
VG5nLVVTVCArIHlvdXIgYXBwLiBUaGF04oCZcyBwcm9iYWJseSB0aGUgc2ltcGxlc3Qgd2F5IHRv
IGdldCBnb2luZywgYnV0IGl0IGdvZXMgYWdhaW5zdCBLOHPigJkgbW9kZWwgb2YgaGF2aW5nIG9u
ZSBwcm9jZXNzIHBlciBjb250YWluZXIsIHdoaWNoIGNhbiBiZWNvbWUgYW5ub3lpbmcuDQoNClRo
ZSBvdGhlciBhcHByb2FjaCwgd2hpY2ggSSB3b3VsZCByZWNvbW1lbmQgeW91IGxvb2sgaW50bywg
aXMgZGVwbG95aW5nIGFuIExUVG5nIHNpZGVjYXIgcGVyIHBvZCB0aGF0IHJ1bnMgdGhlIHNlc3Np
b24gZGFlbW9uLCBhbmQgaW5zdGFsbGluZyBMVFRuZy1VU1QgKHRoZSB0cmFjZXIgbGlicmFyaWVz
KcKgYWxvbmcgeW91ciBpbnN0cnVtZW50ZWQgYXBwbGljYXRpb25zIGluIHRoZSBvdGhlciBjb250
YWluZXJzIG9mIHRoZSBwb2QuDQoNCk1pY2hhZWwgSmVhbnNvbiBoYXMgYSBkZW1vIHNob3dpbmcg
aG93IGhlIGRlcGxveWVkIExUVG5nIGluIEs4cyB1c2luZyB0aGF0IGFwcHJvYWNoLiBIb3BlZnVs
bHksIHRoYXQgY2FuIGhlbHAgeW91IGdldCBzdGFydGVkOg0KDQpodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL21qZWFuc29uL2djbG91ZC1sdHRuZ19fOyEhTHBL
SSFoeDFOZUt2WDA0aEhhcEJGSjRablRYWkczamx1SFZmbThmaF9mb0NFX01IOUtTZ2tmMVZ6S1BY
ZG9waVlQUTN4dF9HMUIxYXRMbjRqUTRJUnllOGxXYll5OXckICBbZ2l0aHViWy5dY29tXQ0KDQpU
aGVyZSBhcmUgYSBjb3VwbGUgdGhpbmdzIHRvIG5vdGUgaW4gdGhpcyBjb25maWd1cmF0aW9uOg0K
ICAtIEEg4oCcbWVtb3J54oCdIHZvbHVtZSwgZGV2c2htLCBpcyBzaGFyZWQgYmV0d2VlbiBjb250
YWluZXJzLiBJdCBoYXMgdG8gYmUNCiAgICBsYXJnZSBlbm91Z2ggdG8gYWNjb21tb2RhdGUgeW91
ciBidWZmZXIgY29uZmlndXJhdGlvbiwgYW5kDQogIC0gdGhlIGNvbnRhaW5lcnMgc2hhcmUgdGhl
IHNhbWUgcGlkIG5hbWVzcGFjZSBhY3Jvc3MgdGhlIHBvZA0KICAgIChodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9rdWJlcm5ldGVzLmlvL2RvY3MvdGFza3MvY29uZmlndXJlLXBv
ZC1jb250YWluZXIvc2hhcmUtcHJvY2Vzcy1uYW1lc3BhY2UvX187ISFMcEtJIWh4MU5lS3ZYMDRo
SGFwQkZKNFpuVFhaRzNqbHVIVmZtOGZoX2ZvQ0VfTUg5S1Nna2YxVnpLUFhkb3BpWVBRM3h0X0cx
QjFhdExuNGpRNElSeWUtQ0Uzak03USQgIFtrdWJlcm5ldGVzWy5daW9dKS4NCg0KVGhlbiB0aGF0
IGxlYXZlcyB0aGUgcXVlc3Rpb24gb2Ygd2hlcmUgeW91IHdhbnQgdG8gc3RvcmUgdHJhY2VzLiBU
aGVyZeKAmXMgYSB0b24gb2Ygb3B0aW9ucyB0aGVyZS7CoEJ5IGRlZmF1bHQsIE1pY2hhZWwncyBk
ZW1vIHdyaXRlcyB0aGVtIHRvIHRoZSBsdHRuZy1ob21lIHZvbHVtZS4gWW91IG1heSB3YW50IHRv
IGxvb2sgaW50byBuZXR3b3JrIHN0cmVhbWluZyB0byBzZW5kIHRyYWNlcyBvdmVyIHRoZSBuZXR3
b3JrIHRvIGEgcmVsYXkgZGFlbW9uIChwb3NzaWJseSBydW5uaW5nIGluIGFub3RoZXIgcG9kKToN
Cg0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbHR0bmcub3JnL2RvY3MvdjIu
MTMvKmRvYy1sdHRuZy1yZWxheWRfXztJdyEhTHBLSSFoeDFOZUt2WDA0aEhhcEJGSjRablRYWkcz
amx1SFZmbThmaF9mb0NFX01IOUtTZ2tmMVZ6S1BYZG9waVlQUTN4dF9HMUIxYXRMbjRqUTRJUnll
OEREcnFaSGckICBbbHR0bmdbLl1vcmddDQoNCk90aGVyd2lzZSwgeW91IG1heSBhbHNvIGJlIGlu
dGVyZXN0ZWQgaW4gc2Vzc2lvbiByb3RhdGlvbnMgdG8gbWFuYWdlIHRyYWNlcyBwcmV0dHkgbXVj
aCBob3cgeW91IHdvdWxkIGhhbmRsZSBsb2dzOg0KDQpodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9sdHRuZy5vcmcvYmxvZy8yMDE5LzEwLzE1L2x0dG5nLXNlc3Npb24tcm90YXRp
b24vX187ISFMcEtJIWh4MU5lS3ZYMDRoSGFwQkZKNFpuVFhaRzNqbHVIVmZtOGZoX2ZvQ0VfTUg5
S1Nna2YxVnpLUFhkb3BpWVBRM3h0X0cxQjFhdExuNGpRNElSeWU4amJXMmh1ZyQgIFtsdHRuZ1su
XW9yZ10NCg0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbHR0bmcub3JnL2Rv
Y3MvdjIuMTMvKmRvYy1zZXNzaW9uLXJvdGF0aW9uX187SXchIUxwS0khaHgxTmVLdlgwNGhIYXBC
Rko0Wm5UWFpHM2psdUhWZm04ZmhfZm9DRV9NSDlLU2drZjFWektQWGRvcGlZUFEzeHRfRzFCMWF0
TG40alE0SVJ5ZV8ydko5WjhnJCAgW2x0dG5nWy5db3JnXQ0KDQpMZXQgbWUga25vdyBpZiB5b3Ug
aGF2ZSBtb3JlIHF1ZXN0aW9ucywNCkrDqXLDqW1pZQ0KDQpPbiBUdWUsIE9jdCAxOCwgMjAyMiBh
dCAwMTowMDo0N1BNICswMDAwLCBMZW1heSwgUGF1bCB2aWEgbHR0bmctZGV2IHdyb3RlOg0KPiBI
ZWxsbyBUaGVyZSwNCj4gDQo+IFdlIGFyZSBsb29raW5nIGF0IExUVG5nIGZvciBhIGRldmVsb3Bt
ZW50IGhlcmUgYXQgRGVsbC4gQXMgSSB1bmRlcnN0YW5kIHRoZSBMVFRuZywgdGhlcmUgYXJlIHNo
YXJlZCBtZW1vcmllcyBvZiBjaXJjdWxhciBidWZmZXIgdHJhY2VzIGNyZWF0ZWQgYmV0d2VlbiAg
YW4gYXBwbGljYXRpb24gYW5kIHRoZSBjb25zdW1lciBkYWVtb24uIEFmdGVyIGxvb2tpbmcgYXQg
c29tZSBwcmVzZW50YXRpb24gdGhhdCB5b3UgZGlkLCBJIHNlZSB0aGF0IHlvdSBoYXZlIHN0YXJ0
ZWQgd29ya2luZyBvbiBjb250YWluZXJpemF0aW9uIGFuZCBwb2RzLg0KPiANCj4gU28gb3VyIGFw
cGxpY2F0aW9ucyBydW4gaW4gcG9kcywgYW5kIGFtIG5vdCBzdXJlIGhvdyB0byBvcmdhbml6ZSB0
aGUgcG9kcyBrbm93aW5nIGFib3V0IHRob3NlIHNoYXJlZCBtZW1vcmllcz8gQ2FuIHlvdSBoZWxw
IHVzIGJldHRlciB1bmRlcnN0YW5kIGhvdyBvdXIgY29kZSBzaG91bGQgYmUgb3JnYW5pemVkIGlu
IHRoZSBjb250ZXh0IG9mIEt1YmVybmV0ZXM/IEFueSBkb2N1bWVudGF0aW9uIHRoYXQgd2UgY2Fu
IGFjY2Vzcz8NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiANCj4gDQo+IEludGVybmFsIFVzZSAtIENv
bmZpZGVudGlhbA0KDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QNCj4gbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZw0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpDQo+IHN0aW5mby9sdHRuZy1kZXZfXzshIUxwS0khaHgxTmVL
dlgwNGhIYXBCRko0Wm5UWFpHM2psdUhWZm04ZmhfZm9DRV9NSDkNCj4gS1Nna2YxVnpLUFhkb3Bp
WVBRM3h0X0cxQjFhdExuNGpRNElSeWU4ay1ubkMxQSQgIFtsaXN0c1suXWx0dG5nWy5db3JnXQ0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
