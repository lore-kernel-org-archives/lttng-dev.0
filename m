Return-Path: <SRS0=oCXi=GV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46DC433E0
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jan 2021 02:19:57 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8D0224DF
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jan 2021 02:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8D0224DF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DJwV15WSPzSRR;
	Sun, 17 Jan 2021 21:19:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1610936394;
	bh=oT7/L+c/qhHnxw8sAW3uOi319PpAM+AkvzsRwWfXPqs=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FN0/UJ9aheraXRiCamdweqGLvkfG7VehdXpGtSYutU/ruM8TFTt96x0BwC5sNd2Zd
	 ZfXIc5HP6UtjsBowhzkfo8CKpE6OBapAxSAmftx003+Z2pbIRoiLR1lD9O7et0/Tgn
	 vEMZQJL6YE7knlZILALy7XXWMBoq9idpSN0pp+fipWw2OQL3s71rDEDOmVuD1jayGy
	 MgNauFUJKQKMV+R4mw8LNAftaW3AXQvfODLhcq+VaZYY6PP1AlqCDokweubVAutgrr
	 9PZ/sxB4kLP/sPwiYOVXuWHUj9ghpyUpex/hi3zzyuBLcsnvhee3NVHn1hPZUwCKL5
	 xvrddoUhad6SA==
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690069.outbound.protection.outlook.com [40.107.69.69])
 by lists.lttng.org (Postfix) with ESMTPS id 4DJwTz4kKSzS5j
 for <lttng-dev@lists.lttng.org>; Sun, 17 Jan 2021 21:19:51 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYgMmG/xcXAZz+AO5cPQrzSWC38QcYiIA3llHtq2Pbpij6dnKAimGdbDcc+yT56HXdOUYxf+4hd++KDt3YU5vfPFyQzp06zVML+JxzfUzgUgcJnVIb2SwulBQZVzt8kzsrw4BoTkMuXt8fEt0Xn6Lw3164y/bLF88JuJCJMc7FUrfQ5nQKbGPvtNxDyuENiYN19ZxVTHC+rC1Ti/6ZGsRL9/SoKUFQhBD4DgI4A5UDDvUOXcO7TcB3aYBf8HPqu5RR+nRlNldaYTQgHJBSC5R3IdIybO18RktECrzE7ovvZsLudxxogxTgDGeTv9MgjV7Ajrn38tFU4HVThHIsJ61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3n267R/KK5p04+lXo2SuqPd5KErS+E47/LO580UbPA=;
 b=JxilzfCh1WBfVXMkM99AexIqTsh57CxLS142SO0W6SXJKBThPRSDVBXx5CSuC4CEN4V7K3mMJzHi+eKKKpAwzk085YS7/eozoBhJWu01AvbFWyaDll+w6RR01X5ZJx48V7sABP1T8HAjObWXIg/pQUQcllcwBxj5X/pBwDBUKqrgwP56jvohV8KrhTuvuGMa2fZpJCGPPDCwvvkEqTV8kaISMGUk42W8+9sZn+0cU08qPHTTbkKN+dKzxVublGaM4hIht7NV5+aMAdvTB5Z661/xFkxOJHAH8yxTrImPn0MLuazJfmrocPEnjiVAYsgpTkie5yP95UHB1v0Wrx9Aew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3029.namprd11.prod.outlook.com (2603:10b6:a03:8e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Mon, 18 Jan
 2021 02:04:59 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 02:04:59 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: =?gb2312?B?u9i4tDogu9i4tDogaGVscCBtb2Rwb3N0OiAiX19iYWRfY21weGNoZyI=?=
Thread-Index: AQHW4D7de02FTHE4o0SVdoHpF3AAf6oaFo1DgACjDICAAKuTD4ABBcQAgAE4wQaAC4JIgIADlZCk
Date: Mon, 18 Jan 2021 02:04:59 +0000
Message-ID: <BYAPR11MB26324771B431CB2262ACDBA0FFA40@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <BYAPR11MB263254ABB57F458031AB33DBFFD50@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632B3DA9B535943CEE08A73FFD00@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210106150309.GA227614@joraj-alpa>
 <BYAPR11MB2632B5DE22E2561F0B018909FFAF0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20210107165408.GC227614@joraj-alpa>
 <BYAPR11MB2632B7E0BD848485746A80AFFFAE0@BYAPR11MB2632.namprd11.prod.outlook.com>,
 <20210115191841.GA3115961@joraj-alpa>
In-Reply-To: <20210115191841.GA3115961@joraj-alpa>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [106.39.151.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22fd29e9-fa43-48db-689e-08d8bb5575e2
x-ms-traffictypediagnostic: BYAPR11MB3029:
x-microsoft-antispam-prvs: <BYAPR11MB3029C6FBE5D94E5657C28458FFA40@BYAPR11MB3029.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LpfJhyWW+9+Rjsk5zo8y806Fnv5ZrtWT25E+NI5F55xxKazmcK+PXdnThzyQNXxcvm/B4RTjXB/KodQR1xPxIRBDt1cri1HIirw6S1jAACtu0MkFszy4zGaNdDFG6/IcJHDrffTXxwfCX7zZox2FZ/mxM7pkqYGVf9v9x4FoUQuiP42Q/T2VOo2l71RZIczHmuiJqixlgQIIgtqDxu/HVkx4aF4UC26Q1Ttg77gRYNGQwHfX62gSlcMe5RnviM4FIhKtKR3lgPuIxOsm2x8H8UNgVVTIeKqdTgTfQbnz2zsr4br8vFMhXGyq+42GbnIwybjWklDlLOxR+pkl9lAfZGXTH7IINnZ4xYu007KN7sEhtNcAOxgm1TfZXPBGjlwbsbx8cMqqRV4ACz/+WRFb+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2632.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39830400003)(346002)(376002)(366004)(136003)(7696005)(86362001)(9686003)(8936002)(186003)(6506007)(26005)(6916009)(55016002)(316002)(478600001)(4326008)(66946007)(64756008)(66446008)(66476007)(2906002)(76116006)(5660300002)(71200400001)(33656002)(66556008)(83380400001)(91956017)(52536014)(224303003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?cWR4TjMveTNlY1hVODdZN1A3MHYrOTNzZW15ajZYU3Z3SS9ScVBiNEEraTho?=
 =?gb2312?B?cWdSbkJZQVZTNmhIVStuRVlKaTA3VUlyb0JLaUtOTVpHaGFVWHRJNDhMWTFL?=
 =?gb2312?B?dW1YTXM2ZGFTbkVBVWlrTkRFekhzS3ErcnJvcTFlWVdHQUMvYjdnekRzVlli?=
 =?gb2312?B?UFFXS0gycmNxVVFLSWRBYVRDQ25OWW9rMlZSN25TWGlxQ1VkZFd3R1psQXlw?=
 =?gb2312?B?T2FOMEJEQkxhaWFORkZFRmljbUN3SW82cmNjVTVEbUdFL0VkRmJ1aVNNOHI1?=
 =?gb2312?B?OXZDeVl3bUtOVG44L2grbll2NWlLMzlCQWR0NlJmOW9TVnpYalVVZUVvYmNF?=
 =?gb2312?B?RGtneG1FUEhMM0htQVJyTm96RmN6bFJxSExEdk9KajVTYmRsL0t3eEdKT3Rp?=
 =?gb2312?B?M0o3ek90eFYwT1BhV0VWRzlLQ0N1bXRseE16UWpHZkhQMURRZzB5Wk5tRDl2?=
 =?gb2312?B?clY1bVZTWGNtMDBmZE44ZlNjK3hDR2kyRGhXYndrcjg4SlBHMi9lRDcxNjRi?=
 =?gb2312?B?Y0RuODNkQTNGTi9jVjRab21NVmE3ZXRyYkJ3Y0RBZVlIYkw2WVRrSTRtdFNH?=
 =?gb2312?B?L2dNSkJZbG94cndwRGZsWGlhUEdlNHRlN3ZrRCtLT281YlUrT0ZTLzZDR2U0?=
 =?gb2312?B?dzRjeHp4MVpsc08xd2daVG1nMzFDeHd4L2NKS3pLSHdrZkNEbU52bjhkUlFw?=
 =?gb2312?B?SDZ6aUNwWTNUbENXVTMyVHd0aDlaaGl3ZzFxd3hWa0VqaGFhK3Mwd0p0S1lX?=
 =?gb2312?B?ZkR2cVlUMnJDT1labVE1ZkZEdFhhT2JOaUNCUFhIOFRIcHc0WStMR1Y1d3BL?=
 =?gb2312?B?OEZWVVJvKzNRT0tzWjRyRGdpb05COFNNNVpBNmc1MGJvOURIWTVnbUdhQitL?=
 =?gb2312?B?bGhnSVR3cmZMaEFhY0ROYytJZ0M2VTI0eEYzbGorRUY2M2ZjcGxUcW5ENWwz?=
 =?gb2312?B?UWVZaWFkQUw2QmMvWTJTNmhKRFNMSzQxRDEvOVB4VS9wTEJCSHFNajNpVTFy?=
 =?gb2312?B?L01TS01pckhoeHNDV2x5TUl1QnVtQ2dhV3NDYmdGTHgwN0RtRWJ1RjZNcWpt?=
 =?gb2312?B?ZEw1aUpCT2pGQlMzcEd4NG1YY1VOVGtoZDVkcytOaTR4eVFIbGlublRFTTBs?=
 =?gb2312?B?SVFpRmVKTXBNYnlHM01qVTRZSUNaa1hxREFoZ0lIK25jcnQwUjBsL3pFZU1V?=
 =?gb2312?B?RjNlQTRSY2RFSTJlSTl5cUU5VjRjVHFvUzlnYVZuQkpNTjRySzRUaHhBTXdH?=
 =?gb2312?B?Tk52bS9veE5idTUrSHV6VmNYT01wMzdRT2htSm83Ukkrbk1QSFE0Q0paeFl0?=
 =?gb2312?Q?4mgN2mHx5Rx3s=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fd29e9-fa43-48db-689e-08d8bb5575e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 02:04:59.5262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30cRNmUjfzCRrC0TLggbupBdUFY9xsZZSUFzsCpCqLxBUkZfJJaO4KnFQPGvx3El0/qlQrCPj6MDk4keoVXjjVvrydJvuUgTy3KFggHwPKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3029
Subject: [lttng-dev] =?gb2312?b?u9i4tDogu9i4tDogu9i4tDogaGVscCBtb2Rwb3N0?=
 =?gb2312?b?OiAiX19iYWRfY21weGNoZyI=?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Zhang, Qiang via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogSm9uYXRo
YW4gUmFqb3R0ZS1KdWxpZW4gPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4K
t6LLzcqxvOQ6IDIwMjHE6jHUwjE2yNUgMzoxOArK1bz+yMs6IFpoYW5nLCBRaWFuZwqzrcvNOiBs
dHRuZy1kZXYK1vfM4jogUmU6ILvYuLQ6ILvYuLQ6IGhlbHAgbW9kcG9zdDogIl9fYmFkX2NtcHhj
aGciCgpbUGxlYXNlIG5vdGUgdGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwg
YWRkcmVzc10KCj5IaSBRdWlhbmcsCj4KPlBsZWFzZSB0ZXN0IHRoZSBhdHRhY2hlZCBwYXRjaC4K
CkhlbGxvIEpvbmF0aGFuIAoKVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLCBJIGNhbiBjb21waWxl
IHN1Y2Nlc3NmdWxseSBhZnRlciB0ZXN0aW5nLgoKQ2hlZXJzCgo+Cj5DaGVlcnMKPgo+T24gU2F0
LCBKYW4gMDksIDIwMjEgYXQgMDU6NDA6NDhBTSArMDAwMCwgWmhhbmcsIFFpYW5nIHdyb3RlOgo+
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gt6K8/sjLOiBK
b25hdGhhbiBSYWpvdHRlLUp1bGllbiA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3Mu
Y29tPgo+ILeiy83KsbzkOiAyMDIxxOox1MI4yNUgMDo1NAo+IMrVvP7IyzogWmhhbmcsIFFpYW5n
Cj4gs63LzTogbHR0bmctZGV2Cj4g1vfM4jogUmU6ILvYuLQ6IGhlbHAgbW9kcG9zdDogIl9fYmFk
X2NtcHhjaGciCj4KPiBbUGxlYXNlIG5vdGUgdGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5B
TCBlLW1haWwgYWRkcmVzc10KPgo+ID5IaSwKPiA+Cj4gPk5vdGUKPiA+ICBUaGUgaW5pdGlhbCBl
bWFpbCB3YXMgc2VudCB0byB0aGUgIm93bmVyIiBvZiB0aGUgbWFpbGluZyBsaXN0LiBQbGVhc2UK
PiA+ICAqYWx3YXlzKiBzZW5kIGVtYWlsIHRvIHRoZSBtYWlsaW5nIGxpc3QgZGlyZWN0bHk6IGx0
dG5nLT5kZXZAbGlzdHMubHR0bmcub3JnIC4KPiA+IE90aGVyd2lzZSB3ZSB3aWxsIG5vdCBiZSBp
bnRlcmVzdGVkIGluIGhlbHBpbmcgeW91IGluIHRoZSBmdXR1cmUuCj4gPgo+ID5Tb3JyeSBmb3Jn
b3QgdG8gYXNrIHlvdSB0aGUgZm9sbG93aW5nLgo+ID4KPiA+V2hhdCBpcyB0aGUgYXJtIENQVSB5
b3UgYXJlIGNvbXBpbGluZyBhZ2FpbnN0PyBUaGUgbW9yZSBkZXRhaWxzIHRoZSA+bW9yZSB3ZSBj
YW4KPiA+aGVscCBoZXJlLgo+ID4KPiA+UGxlYXNlIHByb3ZpZGUgdGhlIC5jb25maWcgZmlsZSBm
b3IgdGhlIGtlcm5lbCAodmlhIHBhc3RlYmluIHBsZWFzZSkgYW5kID50aGUKPgo+ICBIZWxsbwo+
Cj4gIEF0dGFjaGVkIGlzIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiBmaWxlCj4gIGFuZCBjb21w
aWxlciBjb25maWd1cmF0aW9uIGZpbGUuCj4KPiAgYnNwIGlzIHhpbGlueC16eW5xIChhcm0zMiwg
YXJtdjcpLCAgdjUuMTAga2VybmVsIGhhdmUgZGVsZXRlCj4gICdDT05GSUdfT1BUSU1JWkVfSU5M
SU5JTkcnICBjb25maWcgb3B0aW9uLgo+Cj4gIENoZWVycwo+Cj4gPmNvbXBpbGVyIHVzZWQuIE1h
dGhpZXUgRGVzbm95ZXJzIChDb21wdURKKSBtaWdodCBoYXZlIGEgbGVhZCA+cmVnYXJkaW5nIGNt
cHhjaGcKPiA+YW5kIF9fYmFkX2NtcHhjaGcgbGlua2VyIGVycm9yIHRyaWNrIHVzZWQgYnkgdGhl
IGltcGxlbWVudGF0aW9uIGFuZCA+dGhlCj4gPm9wdGltaXplZCBpbmxpbmluZyBjb25maWcgb3B0
aW9uIChDT05GSUdfT1BUSU1JWkVfSU5MSU5JTkcpLgo+ID4KPiA+VGhlc2Ugc2hvdWxkIGhlbHAg
dXMgdmFsaWRhdGUgdGhpcyBsZWFkLgo+Cj4gPgo+ID5DaGVlcnMKPiA+Cj4gPk9uIFRodSwgSmFu
IDA3LCAyMDIxIGF0IDAxOjIwOjU0QU0gKzAwMDAsIFpoYW5nLCBRaWFuZyB3cm90ZToKPiA+Cj4g
Pgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gt6K8/sjL
OiBKb25hdGhhbiBSYWpvdHRlLUp1bGllbiA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNp
b3MuY29tPgo+ID4gt6LLzcqxvOQ6IDIwMjHE6jHUwjbI1SAyMzowMwo+ID4gytW8/sjLOiBaaGFu
ZywgUWlhbmcKPiA+ILOty806IGx0dG5nLWRldi1vd25lckBsaXN0cy5sdHRuZy5vcmcKPiA+INb3
zOI6IFJlOiBoZWxwIG1vZHBvc3Q6ICJfX2JhZF9jbXB4Y2hnIgo+ID4KPiA+IFtQbGVhc2Ugbm90
ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRyZXNzXQo+ID4KPiA+
ID5IaSwKPiA+ID4KPiA+ID5XaGF0IHRoZSBrZXJuZWwgdmVyc2lvbiBhcmUgeW91IGNvbXBpbGlu
ZyBhZ2FpbnN0Pwo+ID4KPiA+Cj4gPiAgICBrZXJuZWwgdmVyc2lvbiA1LjEwLjIKPiA+ICAgIGx0
dG5nLW1vZHVsZXMgbWFzdGVyIGJyYW5jaCBjb21taXQgOgo+ID4gICAgNjFlNjMxZTkzZTUxMmI2
MzZlYTZkNTI3OTZiY2NlMWM0ODVhNTUxYgo+ID4KPiA+ICAgICBDaGVlcnMKPiA+Cj4gPiA+Cj4g
PiA+Q2hlZXJzCj4gPiA+Cj4gPiA+T24gV2VkLCBKYW4gMDYsIDIwMjEgYXQgMDU6MjA6MDZBTSAr
MDAwMCwgWmhhbmcsIFFpYW5nIHdyb3RlOgo+ID4gPgo+ID4gPgo+ID4gPiBUaGUgZm9sbG93aW5n
IGVycm9yIG9jY3VycmVkIHdoZW4gSSBjb21waWxlZCBsdHRuZyBtb2R1bGVzIHVuZGVyIGFybXY3
IGFyY2hpdGVjdHVyZQo+ID4gPgo+ID4gPiBFUlJPUjogbW9kcG9zdDogIl9fYmFkX2NtcHhjaGci
IFsvYnVpbGRhcmVhMS9PbkRlbWFuZF9DSV9CdWlsZF9Xb3JsZC9idWlsZF9kaXIvMTIyNTE3Mjct
YnVpbGRfd29ybGQveGlsaW54LXp5bnEtc3RhbmRhcmQtc3RkLU9FL2J1aWxkL3RtcC1nbGliYy93
b3JrL3hpbGlueF96eW5xLXdycy1saW51eC1nbnVlYWJpL2x0dG5nLW1vZHVsZXMvMi4xMi4zK2dp
dEFVVE9JTkMrNjFlNjMxZTkzZS1yMC9naXQvc3JjL2x0dG5nLWNvdW50ZXItY2xpZW50LXBlcmNw
dS02NC1tb2R1bGFyLmtvXSB1bmRlZmluZWQhCj4gPiA+Cj4gPiA+IEVSUk9SOiBtb2Rwb3N0OiAi
X19iYWRfY21weGNoZyIgWy9idWlsZGFyZWExL09uRGVtYW5kX0NJX0J1aWxkX1dvcmxkL2J1aWxk
X2Rpci8xMjI1MTcyNy1idWlsZF93b3JsZC94aWxpbngtenlucS1zdGFuZGFyZC1zdGQtT0UvYnVp
bGQvdG1wLWdsaWJjL3dvcmsveGlsaW54X3p5bnEtd3JzLWxpbnV4LWdudWVhYmkvbHR0bmctbW9k
dWxlcy8yLjEyLjMrZ2l0QVVUT0lOQys2MWU2MzFlOTNlLXIwL2dpdC9zcmMvbHR0bmctY291bnRl
ci1jbGllbnQtcGVyY3B1LTMyLW1vZHVsYXIua29dIHVuZGVmaW5lZCEKPiA+ID4KPiA+ID4gSSBm
aW5kICB1bmRlciB0aGUgY29uZGl0aW9uIG9mCj4gPiA+Cj4gPiA+IENPVU5URVJfU0laRV8zMl9C
SVQsICBjbXB4Y2hnX2xvY2FsICBmdW5jdGlvbiB0cmlnZ2VyIGVycm9yIGluIGNvdW50ZXItYXBp
LmggZmlsZS4KPiA+ID4KPiA+ID4gaXMgY21weGNoZ19sb2NhbCBpcyBzdXBwb3J0IGluIGFtdjc/
Cj4gPgo+ID4gLS0KPiA+IEpvbmF0aGFuIFJham90dGUtSnVsaWVuCj4gPiBFZmZpY2lPUwo+Cj4g
LS0KPiBKb25hdGhhbiBSYWpvdHRlLUp1bGllbgo+IEVmZmljaU9TCgoKPiAuL2FybS13cnMtbGlu
dXgtZ251ZWFiaS1nY2MgLXYKPiBVc2luZyBidWlsdC1pbiBzcGVjcy4KPiBDT0xMRUNUX0dDQz0u
L2FybS13cnMtbGludXgtZ251ZWFiaS1nY2MKPiBDT0xMRUNUX0xUT19XUkFQUEVSPS9idWlsZGFy
ZWExL3F6aGFuZzIvamlyYS9MSU5DRC0zOTA0L2J1aWxkL3RtcC1nbGliYy93b3JrL2FybXY3YXQy
aGYtbmVvbi13cnMtbGludXgtZ251ZWFiaS9saWJnY2MvMTAuMi4wLXIwL3JlY2lwZS1zeXNyb290
LW5hdGl2ZS91c3IvYmluL2FybS13cnMtbGludXgtZ251ZWFiaS8uLi8uLi9saWJleGVjL2FybS13
cnMtbGludXgtZ251ZWFiaS9nY2MvYXJtLXdycy1saW51eC1nbnVlYWJpLzEwLjIuMC9sdG8td3Jh
cHBlcgo+IFRhcmdldDogYXJtLXdycy1saW51eC1nbnVlYWJpCj4gQ29uZmlndXJlZCB3aXRoOiAu
Li8uLi8uLi8uLi8uLi8uLi93b3JrLXNoYXJlZC9nY2MtMTAuMi4wLXIwL2djYy0xMC4yLjAvY29u
ZmlndXJlIC0tYnVpbGQ9eDg2XzY0LWxpbnV4IC0taG9zdD14ODZfNjQtbGludXggLS10YXJnZXQ9
YXJtLXdycy1saW51eC1nbnVlYWJpIC0tcHJlZml4PS9ob3N0LW5hdGl2ZS91c3IgLS1leGVjX3By
ZWZpeD0vaG9zdC1uYXRpdmUvdXNyIC0tYmluZGlyPS9ob3N0LW5hdGl2ZS91c3IvYmluL2FybS13
cnMtbGludXgtZ251ZWFiaSAtLXNiaW5kaXI9L2hvc3QtbmF0aXZlL3Vzci9iaW4vYXJtLXdycy1s
aW51eC1nbnVlYWJpIC0tbGliZXhlY2Rpcj0vaG9zdC1uYXRpdmUvdXNyL2xpYmV4ZWMvYXJtLXdy
cy1saW51eC1nbnVlYWJpIC0tZGF0YWRpcj0vaG9zdC1uYXRpdmUvdXNyL3NoYXJlIC0tc3lzY29u
ZmRpcj0vaG9zdC1uYXRpdmUvZXRjIC0tc2hhcmVkc3RhdGVkaXI9L2hvc3QtbmF0aXZlL2NvbSAt
LWxvY2Fsc3RhdGVkaXI9L2hvc3QtbmF0aXZlL3ZhciAtLWxpYmRpcj0vaG9zdC1uYXRpdmUvdXNy
L2xpYi9hcm0td3JzLWxpbnV4LWdudWVhYmkgLS1pbmNsdWRlZGlyPS9ob3N0LW5hdGl2ZS91c3Iv
aW5jbHVkZSAtLW9sZGluY2x1ZGVkaXI9L2hvc3QtbmF0aXZlL3Vzci9pbmNsdWRlIC0taW5mb2Rp
cj0vaG9zdC1uYXRpdmUvdXNyL3NoYXJlL2luZm8gLS1tYW5kaXI9L2hvc3QtbmF0aXZlL3Vzci9z
aGFyZS9tYW4gLS1kaXNhYmxlLXNpbGVudC1ydWxlcyAtLWRpc2FibGUtZGVwZW5kZW5jeS10cmFj
a2luZyAtLXdpdGgtbGlidG9vbC1zeXNyb290PS9ob3N0LW5hdGl2ZSAtLWVuYWJsZS1jbG9jYWxl
PWdlbmVyaWMgLS13aXRoLWdudS1sZCAtLWVuYWJsZS1zaGFyZWQgLS1lbmFibGUtbGFuZ3VhZ2Vz
PWMsYysrIC0tZW5hYmxlLXRocmVhZHM9cG9zaXggLS1kaXNhYmxlLW11bHRpbGliIC0tZW5hYmxl
LWRlZmF1bHQtcGllIC0tZW5hYmxlLWM5OSAtLWVuYWJsZS1sb25nLWxvbmcgLS1lbmFibGUtc3lt
dmVycz1nbnUgLS1lbmFibGUtbGlic3RkY3h4LXBjaCAtLXByb2dyYW0tcHJlZml4PWFybS13cnMt
bGludXgtZ251ZWFiaS0gLS13aXRob3V0LWxvY2FsLXByZWZpeCAtLWRpc2FibGUtaW5zdGFsbC1s
aWJpYmVydHkgLS1kaXNhYmxlLWxpYnNzcCAtLWVuYWJsZS1saWJpdG0gLS1lbmFibGUtbHRvIC0t
ZGlzYWJsZS1ib290c3RyYXAgLS13aXRoLXN5c3RlbS16bGliIC0td2l0aC1saW5rZXItaGFzaC1z
dHlsZT1zeXN2IC0tZW5hYmxlLWxpbmtlci1idWlsZC1pZCAtLXdpdGgtcHBsPW5vIC0td2l0aC1j
bG9vZz1ubyAtLWVuYWJsZS1jaGVja2luZz1yZWxlYXNlIC0tZW5hYmxlLWNoZWFkZXJzPWNfZ2xv
YmFsIC0td2l0aG91dC1pc2wgLS13aXRoLWd4eC1pbmNsdWRlLWRpcj0vbm90L2V4aXN0L3Vzci9p
bmNsdWRlL2MrKy8xMC4yLjAgLS13aXRoLXN5c3Jvb3Q9L25vdC9leGlzdCAtLXdpdGgtYnVpbGQt
c3lzcm9vdD0vaG9zdCAtLWVuYWJsZS1wb2lzb24tc3lzdGVtLWRpcmVjdG9yaWVzIC0td2l0aC1z
eXN0ZW0temxpYiAtLWRpc2FibGUtbmxzIC0td2l0aC1nbGliYy12ZXJzaW9uPTIuMjggLS1lbmFi
bGUtaW5pdGZpbmktYXJyYXkKPiBUaHJlYWQgbW9kZWw6IHBvc2l4Cj4gU3VwcG9ydGVkIExUTyBj
b21wcmVzc2lvbiBhbGdvcml0aG1zOiB6bGliCj4gZ2NjIHZlcnNpb24gMTAuMi4wIChHQ0MpCj4K
CgotLQpKb25hdGhhbiBSYWpvdHRlLUp1bGllbgpFZmZpY2lPUwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
