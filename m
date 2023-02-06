Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C197DC636D3
	for <lttng-dev@archiver.kernel.org>; Mon,  6 Feb 2023 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675700808;
	bh=ODRSPSLh+G0hgYXlpteGig9BeyykBQ5db/auCOmDpLo=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=lUWcmrPwq3dHPaepQEe4udd5bN7I6CA1hIw9Bm8sscmb+OuZjh4JdvlGcaISlAQa/
	 JX3Z/pay4pgEVzMv0mPJ2kzGikAdU/vk8uqKs7X9hebRVQ4j00DJJvITFQhTmRFlrJ
	 cKL2Gj8nyOZXIUYlltAORpb10Rdm6mn43FWeQHjtybfOqDfn1bk+4FiCXsh5Vmg7gz
	 GpKXxX3HMNCx4OdGqj2VyceriLndI2qq/gnexUdO8nCtUhwhKEejiKSqdMZTdb99HS
	 eKzNeL8j81LLpInpkJ1oXDjBkgCJ3EcENWcr6f1lO6Ac51VWS8FF4Av1w1B+wNDrvD
	 JuD2kv8mEYEqQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P9WqX4YpRz1ZdZ;
	Mon,  6 Feb 2023 11:26:48 -0500 (EST)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4P9Wnf4jPmz1ZHb
 for <lttng-dev@lists.lttng.org>; Mon,  6 Feb 2023 11:25:10 -0500 (EST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 316E7jX0022909; Mon, 6 Feb 2023 08:15:40 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3nhkh99rgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Feb 2023 08:15:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8hlIl3ebbDHECedNzRvXBko4AUKlX8D40Sn0q9DzixwrFw4ydbPEJraAQfn7avN5clD3/Ugb977SI6OIcZ+Mnf5q8If1YUv4z7C3I6cavEGGUYTJkTIRZ/DAotT7WDbbQeJS2uw7NzGNBcVwXFsHIdNaQdQx7G6cBzH1B53oOrQWA5vBgHJnAbTh3MutJT9iSb/YNwghgxapZRSZHNpvqRVlFPi093rZZfIsRD9ie7odIZTVWbbiO/4LP1l6D0ADlLHAjYfp96N1a0xfaFOqrQWEPb0YIaFNmRERH79nKH8y392NIkQD1JhXBbaJPLoF1QnRhD1CE2q/nLmnly38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/lF1tGy/v6q2ENWUUgbQYwp4kxHghjVErNtVrNQS2s=;
 b=De+q5i3E7Z7iuviEizm9ES/ii/BAKr8Gzs93HH5zi5RIov1f1HX9bK4RZ04x5GLR8Gc3V4i2v2FeGGJ3ljadj74Gxg4qRt1K25d0+brjfMG0CBQfHujE1Pve0BhW/f1F3kAC4o0uQzMwRrHMY9VFrn/zBsnVWdUE8KteutUSI2B4+m3AO5Uu3A7sj1LyfjJ3SQdDFLtB7jd+ezCKlFoeX0DMFaEKE6pC6Woqj5f0F4ERp0Eikbws60yi1sK95hg1FZz6BkuQwiYCEFLSRVkkdH8DO+jgcap9yfxNN04kjcvP3P9dKJd0r3b6/sBoVGX9nImfS/3hpQbw14jToqYplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 16:15:36 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::f00d:1df7:18cd:2194]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::f00d:1df7:18cd:2194%2]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 16:15:36 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
Thread-Index: AQHZNY5Xd7zW3o4uskqmkE3H94l/2664tByAgAAD3ACAAyMcAIAGJ1Og
Date: Mon, 6 Feb 2023 16:15:36 +0000
Message-ID: <PH0PR11MB49043811E60B4E2AE3C58EBD92DA9@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <PH0PR11MB490408B49130B7C9CB661E1A92D39@PH0PR11MB4904.namprd11.prod.outlook.com>
 <46f36a1a-c748-773b-8f6d-d481c9c8ad1b@efficios.com>
 <e525c864-a2ee-ef34-b7fd-1c114e70b081@efficios.com>
 <d1eb23d9-269f-85ea-0b7a-a3b779ffa843@efficios.com>
 <ea3518a5-e539-1616-432c-b7fe7fcada2f@efficios.com>
In-Reply-To: <ea3518a5-e539-1616-432c-b7fe7fcada2f@efficios.com>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|SN7PR11MB6828:EE_
x-ms-office365-filtering-correlation-id: e4a0c82d-0478-4991-3c20-08db085d619f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZ38rS9ukxtxlHss6f4RpskZYu4QwYwXOzqc6hvN2f8E7NxbmI4mK6w7ep2X5R3d2PMcd6i8TgVi5QFxD1ZM/LXZeSE3+//aNg0dsnjeIOBlksN7wlqvil+tc357jPm2bHzcHJIDEmHOs1LDYjmcWDXkwOTXzluAaAlNxmBIlY6y4qajcNr6RmDP+i6Uj+9W7S+GCkayoM7nwG4mGHH6d4xKN3eIiyaSCTlyPL2ViOwuWI4DFAl6BMA6r0k3fOZzOxCb/I1I2sOjuSQq/xMTCfo6qqh5DO8lGtsrCa68SzJOWn1GbyMOeYmuJ0hpcf9Z+Iir4+xKfwVG0g00PaMLBWhyxhIcGp1oTiKEeVDciKngVqVR6lLneuAjrI+VzbDVQJfdXCR0YOL410BPRiw5mjWG/Ak6g2/CEeDWG5Fh4smXZyEUNlI9evqjOXsgxTFc9ckZGJ0qIa+5+yI5c911nwuo2/1EYUywDxHUzIh1WwUR1z2dYNGWfwjtUuFX/Oc7XrHc4YuzPo52Zxw9MPxliEhpNnXGiRWMDQcsXgAedE+Q/2veNnZwLgJHYvd0SjRv6BmSCuAUIu9NFqfW9JVqEYKf3+uTzCN/jVLAb5X+Q5cxa2h9JBvw1wszA1KpdsWND+ijzSUPJ7YKEFRBVwz756jZ/3rCBzMyPt+kB4J7w8+XRUZCkkODrPvCLK01x/BA3djGdvWhLmtH6mJPf5kmeHA9TBB//kza+gS9YS1Kc2A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4904.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(451199018)(38070700005)(122000001)(83380400001)(38100700002)(9686003)(26005)(66574015)(478600001)(186003)(86362001)(6506007)(966005)(7696005)(71200400001)(52536014)(8676002)(110136005)(316002)(66556008)(66946007)(76116006)(66899018)(66476007)(5660300002)(8936002)(41300700001)(64756008)(66446008)(55016003)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVdyMCtJR0xHaisvaVJ2bGxoQitPNVJvRHBRK0VxUS9iZnBocCsyTnkvaDc5?=
 =?utf-8?B?MmJIN0dGS1ZDenlRbmYvM2QrNDRnWEoxbk1IVElGY0FZby9JS01nQ0ZiSFJn?=
 =?utf-8?B?dlIvdi9LVXQ2djZsU0d3YnFqM0pCZjdxOTE0a00vS0g2aEFkV0J0eWl0czdj?=
 =?utf-8?B?a2dwL2txV29vT3FIcElzbWkyR1VxZ0FXSkRNN3dtbXgyWHp4ZEZrOS9NVVpk?=
 =?utf-8?B?Y0prSThGb2l6V1h3MnE4SUhFRmlpeWpOejBuK1BGRy9IKzk5UGlOdm1ucS9Q?=
 =?utf-8?B?Z3k5UnJucFNtbzlyNWd1N0VmVlNUYm52OEplRXdlQXZPVmpDSnVNVkRnRFli?=
 =?utf-8?B?QVY5aDR2dzdMWVlnVEErOGRxNytaYnZ2amRDY3dEeEk3NzhSbDNRRHp6TlNy?=
 =?utf-8?B?R293QnUvK1M5TUw5a2JzcnM4UUkvVzNnN0o0QzZ1QzhmQ0dIeEQ3WWMyNjM3?=
 =?utf-8?B?U3NWUHBaZkptQkpIWTUvMnZENXhQT0pnSThvMzN5SFhJekdIdzdCaTFJbXNt?=
 =?utf-8?B?T1FYMVlVbzFmdytwTTRTTlA1V2ZwQTNDZUNYNlROWmEwWDVGTXFmOEMzTFJj?=
 =?utf-8?B?eEJVSDRpUnhvNkV1QW42dzd4QzBzSVhCZzVFdVpKbVpNRnlzSlNrWmVHaVRJ?=
 =?utf-8?B?WVdBOUVWeGlKZnVVTkVMNWxpcWhqOEZacFBRb3BZeldBUHBFT1lkWlFtV2Ez?=
 =?utf-8?B?RzEzL3lzUGhYVENib3RGYm41YTVieGVIUHozYXZSM2RFdnJYTHVmS1pDWVNO?=
 =?utf-8?B?b1RWeVRhdjMxTlhtYkdOdyt6K3NFdG9najVsQVpmN3diRGdsOTNmWXBKdjEz?=
 =?utf-8?B?S3Zza1FqamlRYVRUeEhyam5xNE9YNmlUMG84UktTM1EvUUh5eDFFT1ZkL29i?=
 =?utf-8?B?bkptOTdTY1lVaUc5VHgwQnZyRUVEQmdSMmNKTzl5SVBFOHpSRjdKQ2JGalNN?=
 =?utf-8?B?RnZ5RUVQRlpjczdjbU1IaWUxaUtEZGxzZUFHVmZ6MWhwYWtXb1ZGVk8wVnVL?=
 =?utf-8?B?MnhiTzVxY0doZ3o0YUV2TXJIOGJmMWxic2RFSlY1ZVJBV1JuVkE3dTFJL1RF?=
 =?utf-8?B?aURrSjhwd01hWDN2bW1jcmNnS3IvdDl2S3BUYkppRCtWeWpzeUVJcXd2WXVz?=
 =?utf-8?B?M0pkUHgrVml5UitXS1p6bGQ0NHZVSGFwRXpHd1FtMnUzRjJEbGxvMjFzMTBI?=
 =?utf-8?B?OTVNZjFXQ3lkSEpPeXhxazY3OGM0OFZNVXVab0xiMks4U2tTNkVNL0hQN2cv?=
 =?utf-8?B?UVhDTEJ6bGJmZmdDSDdrTWlUT1BFdjlzZEo1aTY1c2FsV2FzK0NuNjVzVlRh?=
 =?utf-8?B?OEFjbnJ0TmZqVWFjWHUrQUNwUjJsZ2VpU3d5emZzYk1mUTBDMGk0MGpPTVNT?=
 =?utf-8?B?NU9DWE9CVTVRUTNHQzNoaEU1RFVWMHdENlNDVyt5VmJ4N0pqZC9Ba01YTjRB?=
 =?utf-8?B?V2Z1a3VBRWtvdGxrUi9WTXFROFQ4MmdVTHJvb0hseHZ2NEkzWFBwb0FLS2lI?=
 =?utf-8?B?T2srdDhrMHhUOG1TMXRIOGhLdkJkVjBPU2dZRDJDNEVXZlZyWExHZzVoNnU0?=
 =?utf-8?B?RVVYUWFzbmc0L2MrNnA5dFdTdERyRlNnNGVSdk0rV0hXVzd4bERId245bEJR?=
 =?utf-8?B?TjYrYnVlMDRFVkg0ZVU5THl0N3FPR3RIWmVlencxYklsNEs0VGhkbmlRd1VC?=
 =?utf-8?B?UTh4ZFFib0EyVnIxaG03eThiWWkvUFYvYWtaTnF0eG1WTzd5Q1I1SjVqNHJo?=
 =?utf-8?B?TFE1M1hpZno2d2JGYVFzR2VGR3I3MkFMcjlBVUtyQ2RtblhyN21CRlN5UFRO?=
 =?utf-8?B?Y202dmhBN2w5c3lad0UzbGlXaUpSS2MrSmZSNkQ1UFViN1FkdlFjV043VWww?=
 =?utf-8?B?NjRnaWJpZlUxZ1pEckVuRjFBMkx5Nm9WQ3UwS2o4UFRzMVU3b24ydDZpUlps?=
 =?utf-8?B?Qk1Yc1ZXc3RYRnpvRUxIYkJzWHpXT3ViWXNESFBKSVFUTEtaZm9OMnBCUlZJ?=
 =?utf-8?B?YUpCenNYV2ZHV1ZUd1h0UnVvdXJaQ0YzY3o5TmdSZVRrcTQ0L1hJZzVmNFhh?=
 =?utf-8?B?SU9rVGpsTW53K1llbGZoRUlXUEhaandOS0JwNGlUWnRwdmVCSmtReXV0M1l6?=
 =?utf-8?B?K3JNcDhmdFZVUHovQktXN0pidFZoaDJLMHRWY0dmRTZoVGd1WjIxc0NKbnQ1?=
 =?utf-8?B?aGc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a0c82d-0478-4991-3c20-08db085d619f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 16:15:36.5238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL3IOUaoC9NEwaMeIuUuFUCR5G/SM0OCePs0Gi80fAx0Kj/Su7JX0PC/L68BoDCOMSvCycsoENt4VYt8QZ2I7w0f3f+pOpFEJFq9Y9QDIa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-Proofpoint-GUID: XLopkKU73G7krj8uY_RsEyOeThGuJVxK
X-Proofpoint-ORIG-GUID: XLopkKU73G7krj8uY_RsEyOeThGuJVxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxscore=0
 spamscore=0 mlxlogscore=872 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060141
X-Mailman-Approved-At: Mon, 06 Feb 2023 11:26:41 -0500
Subject: Re: [lttng-dev] lttng-consumerd crash on aarch64 due to x86 arch
 specific optimization
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
From: "Beckius, Mikael via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Beckius, Mikael" <mikael.beckius@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGVsbG8gTWF0aGlldSENCg0KSSBhZGRlZCB5b3VyIGxhdGVzdCBpbXBsZW1lbnRhdGlvbiB0byBt
eSB0ZXN0IGFuZCBpdCBzZWVtcyB0byBwZXJmb3JtIHdlbGwgb24gYm90aCBhcm0gYW5kIGFybTY0
LiBTaW5jZSB0aGUgdGVzdCB3YXMgd3JpdHRlbiBpbiBDKysgSSBoYWQgdG8gbWFrZSBhIHNtYWxs
IGNoYW5nZSB0byB0aGUgY2FzdCBpbiBvcmRlciBmb3IgdGhlIHRlc3QgdG8gY29tcGlsZS4NCg0K
TWlja2UNCg0KPiAtLS0tLVVyc3BydW5nbGlndCBtZWRkZWxhbmRlLS0tLS0NCj4gRnLDpW46IE1h
dGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+DQo+IFNraWNr
YXQ6IGRlbiAyIGZlYnJ1YXJpIDIwMjMgMTc6MjYNCj4gVGlsbDogQmVja2l1cywgTWlrYWVsIDxt
aWthZWwuYmVja2l1c0B3aW5kcml2ZXIuY29tPjsgbHR0bmctDQo+IGRldkBsaXN0cy5sdHRuZy5v
cmcNCj4gw4RtbmU6IFJlOiBbbHR0bmctZGV2XSBsdHRuZy1jb25zdW1lcmQgY3Jhc2ggb24gYWFy
Y2g2NCBkdWUgdG8geDg2IGFyY2gNCj4gc3BlY2lmaWMgb3B0aW1pemF0aW9uDQo+IA0KPiBDQVVU
SU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBhY2NvdW50
IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJl
Y29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0K
PiBIaSAgTWlrYWVsLA0KPiANCj4gSSBqdXN0IHRyaWVkIGFub3RoZXIgYXBwcm9hY2ggdG8gZml4
IHRoaXMgaXNzdWUsIHNlZToNCj4gDQo+IGh0dHBzOi8vcmV2aWV3Lmx0dG5nLm9yZy9jL2x0dG5n
LXVzdC8rLzk0MTMgRml4OiB1c2UgdW5hbGlnbmVkIHBvaW50ZXINCj4gYWNjZXNzZXMgZm9yIGx0
dG5nX2lubGluZV9tZW1jcHkNCj4gDQo+IEl0IGlzIGxlc3MgaW50cnVzaXZlIHRoYW4gb3RoZXIg
YXBwcm9hY2hlcywgYW5kIGRvZXMgbm90IGNoYW5nZSB0aGUgZ2VuZXJhdGVkDQo+IGNvZGUgb24g
dGhlDQo+IG1vc3QgcmVsZXZhbnQgYXJjaGl0ZWN0dXJlcy4NCj4gDQo+IEZlZWRiYWNrIGlzIHdl
bGNvbWUsDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBNYXRoaWV1DQo+IA0KPiANCj4gLS0NCj4gTWF0
aGlldSBEZXNub3llcnMNCj4gRWZmaWNpT1MgSW5jLg0KPiBodHRwczovL3d3dy5lZmZpY2lvcy5j
b20NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0
bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlz
dHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
