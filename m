Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B7DE92FCB
	for <lttng-dev@archiver.kernel.org>; Thu,  5 Oct 2023 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696543449;
	bh=QDdeZA0qDYoMOdNsWU8/TDkWWIe2/rgAqJr2lRnxNf8=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=sKHz8+WgxnsHhLl9+u5whgSPszH2UDAwtiFHcntqG3LrzeKfGIshCVunWFq7zfsJ/
	 cA2ihgOE2CLQiQptgCJ0v1XolIrs/rEhhNmimhijLzFAcoGivzOs1MCBMjQWBsLhg5
	 s25MrI6y9SP18pxpIHsREnT1Q9XVJBMbsuchjGqxe6DbzpmqQR9Zm0G/ywcYOM9f9a
	 fRV2ZBSXNrE+FMgdoO+oyTCiu3QsdZuE0f87AKBITRkT7CRdcQ4rewO853jsFrzceT
	 E8EpILnOHVx1Py/rq5UrhWqaV1D8hiknL2B3olZaBWl/e44OkawuCMAZmFOdLiRgLR
	 Jdl3N2CpjjbeQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S1lvX70cZz2swy;
	Thu,  5 Oct 2023 18:04:08 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2056.outbound.protection.outlook.com [40.107.116.56])
 by lists.lttng.org (Postfix) with ESMTPS id 4S1lvW4FhQz2sjM
 for <lttng-dev@lists.lttng.org>; Thu,  5 Oct 2023 18:04:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtOCK0Lo3Zb6FE5nJmISqnmqh7VOYKIX2ZyC6sKgOJBAyG2tSwUEWobT9fCBafDzI29xtjjgNw0Z55cFmD6p2EOn7FspglBqfQIxuloCX0bdQFvgW5rC71hkvLH8rEd3Xp7x7RjEPuIRRecH1/HuRLmD1ECNVwBIyvOq5T0vNnlsBjxFLnCvwFuW6S3Nmuk1yB41+ZgiE78XTKiCOeRC9efEJkAYjAWWeqWERVu/FBxkDJ3G0q1JbI77hQQV4eYZLuBoAhUBaDR4pYBZES7Lfv5P0lHwhNyWy3WBXPAf5CKdAZpANzvA1YAp4AkVnYYyY+bf7NxxBySvrTkMi0L5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxKulJe2IUQHIjhURfKW1+H+AmvT6/I/XQWWrAmbA9Q=;
 b=QS6RnWoWxDJsSG06XRpZcUtbEWrmZbsFW/MRHKCy/LAyj/VtoYlD7gKPqdaa6OiaTonlNVWL9lUKOfy6YI/Nx1CnO1b0HodOf2WMI654lyzBTS/BHqEwoMttrLlELd/5ze5fQqc+3pRjj11EZgaF7HFc+G0zlPiYU1xACZoe2V3P+GYmCC748mrQ+TRt2u3wUcPSa8GdgrWGF2sBTJZAZf0RmqvIQzBM4ytqUhZAjWjdZ8nnJdtaJGxe3kNEdsnzQbywoPT4GkpDDR1TGr8avroRhU2BI/kEyQQorJO+xlCmzo3eaqSLlTxZA5k5BU8IrSQuQeEHXg1oAYh0/yZByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::19)
 by YQBPR0101MB8959.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 22:04:06 +0000
Received: from YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd]) by YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ff6e:51dc:2551:82dd%7]) with mapi id 15.20.6838.028; Thu, 5 Oct 2023
 22:04:05 +0000
Message-ID: <f0437833-964c-4aee-a52b-e79fd89540fc@efficios.com>
Date: Thu, 5 Oct 2023 18:04:04 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-CA, en-CA
To: lttng-dev@lists.lttng.org, Zach.Kramer@cognex.com
References: <SN6PR06MB426922F9DBACE81D0C6B66A591C3A@SN6PR06MB4269.namprd06.prod.outlook.com>
In-Reply-To: <SN6PR06MB426922F9DBACE81D0C6B66A591C3A@SN6PR06MB4269.namprd06.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::13) To YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:de::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9793:EE_|YQBPR0101MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f54b20-6b4d-497f-ec6e-08dbc5eefdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsDUjSZLJ/chajjAlTnh+/gZ+FdfFbsSDAMTFGfsWshd5L/8VLdUcD0nzM5HyPbTkTq4e6JeX25I/jvTDVTlqeb4+omhlWB51E092VOurPkrEPMznocbl3ci2bwpE9Lf58qMwSoj0gy5AEyErIv8rA/kgXKGcwOuTXkZ97BuIyMfHxHS7E7Z2kRA4iPVzwKEYX1mKuP0sYKONZO3hyWGWEWe3Hi/OMQ2JaLefDxKHLSl7P3RPPAOICuY8qr3Rx+RvZqwiSDEPYqJBr/jyqW8zeP5ZhVu7zeq9qkABVS2tcYdQzhJfi+vPSx9VhxUownlsvgMUfLVz2VZ/dYwN26g89iBIKm93R9AQ90KZYd9dWPXrT6AjlAygYB8+LfIGn5COVeGX2vpSHxGf0EDTkwS5kQlaww9dxtodb19bSAmHoKcm1olS09tWcnvspLkZgGqhvxfv3VPZjSaR4XBYnTbWNFuLnzcjHjmkiuACWuWWrqwGMpeuRmcGsbQkOH1exadj9rxWI7P2DLASOUPdX3fMVqEzPPtZkIGT2cL4kvvnpUEcq2B2PiLQIjbNvQfJbfYPC1ltR97x4yfTHmL0EzKa/imzQShDkwQD9sbqg/zyWKOJHtCPRXMIw+kQ7f1apJw5LTOFR+q/9hrSUEeFFwvhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(39830400003)(136003)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(5660300002)(8676002)(2906002)(8936002)(41300700001)(2616005)(66556008)(316002)(66476007)(66946007)(26005)(36756003)(6506007)(53546011)(6512007)(83380400001)(86362001)(31696002)(38100700002)(478600001)(966005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZIVXNZZXFjNUVpM0JEOTlzbzVPV0FON1ZXa2xDNklHME5RV0VCSzZGdlFX?=
 =?utf-8?B?QzNHZjIzMFExZnh4b1lkOEx4TlRYYjZRMjRyQjZUS1pYeGJBd1Zod1A2NHYz?=
 =?utf-8?B?VEVodUJzM1lPd1dvcFRud0pLcUJ0ODhHZzRFWlphc3NOeXdZVjluUEFDdDlq?=
 =?utf-8?B?M0QrYjhGQW4yZVN3cmFKQmxOelhDem5UVFRFc1hTRVBJdE1mMENtVnV2WS9x?=
 =?utf-8?B?K0RRREFJNGkvWm03T0V4WE84QmJpUUJCWU0wMXZyVkZPeWlDR1dmZzYwVHIv?=
 =?utf-8?B?MDl5aHR4OWRpeWpTdithQUowaWRVcVdBWGUyN1AzTHgrOGpFVDQ1L0FOS29a?=
 =?utf-8?B?WEVjK1p4eUNMR21oU3l1Z3hyT1U5Y0lmNk0yY2V3L2NZano4WDQvZXlSUjdn?=
 =?utf-8?B?V1NSTWk4QTc2Ti9QSU5iM01OaE5taDd6ZWhCUC9CdmVuRGphOEtYcVpEaWZ5?=
 =?utf-8?B?UVhLTERtWmhvQ2JzMVlUV0RqeDkyVGtZMmw3MGVTRHBoZ28vQTVYNUVxUTRt?=
 =?utf-8?B?bUd1Rm9STEVPYiszM2xxczRjQ0w3b2tBMThxelMrWnA0ZUNVRW43S0FLYng3?=
 =?utf-8?B?cXBoSkRoUlVFN0QraUR3MlgzVTFCL09OK09IZEwyYUdNdGIwUElBWGNMRHdj?=
 =?utf-8?B?cERBR29QOGV6SUg1ZUx3NHlDNVVPR0k1TG9uSklwekVaakgzWmtqeDNFY3BO?=
 =?utf-8?B?RWZMdEU2VGhHOWJqU3pCbE1NNVlJcy95Vld4Mnc1OWxuZSt2QVdINlhHek9M?=
 =?utf-8?B?dDdjVlVjaFpTbGd5a1YwTmxQeElFbjRVS1pocWJhbHowRmtQNE84dDRsZnJt?=
 =?utf-8?B?dUppY09hbTJGVE1qZlI3bndUejFYMTdUVTlrYnpscVl1ckZtSnNJaVRha1RI?=
 =?utf-8?B?ZmdiR0tRN1VtbHJXbEpxS2ZkV2g0THBxSXlXZml5aWUxNGsvWlNXcVdCTEYz?=
 =?utf-8?B?SFBQZ2N6emxzdHVkRS84bHZYTzFyOUUrK2tQMWtYMUlyNFlWM3FSRTM1ZFRQ?=
 =?utf-8?B?MHgrQVRJYnlWWUQ1andQZ0F1eWk0TDhqeTJmSjhVcGh5MkI5Q3luMGk3eHFC?=
 =?utf-8?B?NFdVMWE0dGMvM3JHdXlPS0RHTGI2Y1NVZ25uZi9CMU5ISHRnUTc1c0pFRlV1?=
 =?utf-8?B?enpzenY1RFR2ZFFVQngrTnBoQ1p1K1RpMGx0Z2lCMlJINlVsejBXYVh2YXlL?=
 =?utf-8?B?TkZueXV1MlFVZVlZdXF6ekpOa2YvZkUxVDdzRlJRb0RlWXZOWWVFRnE2djAr?=
 =?utf-8?B?dmN0SmhJUmh2emdjRUNDbW81UXJhaERHTmpqLzd3YWFJNUUzNUI3WHROYWdL?=
 =?utf-8?B?dGw5TndXQi9EQjdRbDJOWURySC9mbzE1dFpQWTNOTGpCY3pDSWZKSm1raENp?=
 =?utf-8?B?a1RBb1RSQWxSU3lNR1JscWpNbHhsVXQrL3FmR1VoMm5LZGNCUk0zb0JMblFz?=
 =?utf-8?B?azRid2xBM2V2UzFNdVAyQ1NXLy9JeXd1ZlRvcG5Vc085aEJPR0kzMEpUblFN?=
 =?utf-8?B?bzFlcS9sZGZnU1Z1Wmpvb0xNNjJybHJER1J4eTdWWk1DL1g1bU9pbXBKQ0hH?=
 =?utf-8?B?UitTbHMwaWw4dStnd24yVWV2ME1sV0FuRW5ybEM3QTh5eVk4U1BpUExWN0Y1?=
 =?utf-8?B?NDNlT1gzaHJhU3VaTC9uMlU1dk5zRXFJb2dyenBDc0oyTkNKM0FCQ1VQdGpz?=
 =?utf-8?B?aW5MNkZmRHRndnE1c0F4QTNyem8zUlhWS3dCZVNaWFRDeisvQXRodEV3NDFj?=
 =?utf-8?B?N2pCeVJQWHNFVVBYdjY5U0w3dko5dkZyYmk3NDN0cTBIZXdHd2x4YmVzc1FE?=
 =?utf-8?B?d0ZjNEh4MTc2cmxNYy9kQ2VHOXpKUFNydG94MS9xZGdZbVBIRGZaZHlQbXAr?=
 =?utf-8?B?ZHVaZitTeU94eHEwWlN0N0RYdzlaQ0tJRGhXSjZxcGZTeVNlNnhRYkxlRjJL?=
 =?utf-8?B?TlZlbEtCZlBVVXVwcDdJT1FqMlVmUHFHZG5BRXR3bVVtRXd4dHZyRzdSWDIw?=
 =?utf-8?B?MnN0ZDBxUTVsSzErODBUaldqaHhKU3Z0anpwZmtDd29INWFTeVlpcjF2TGd5?=
 =?utf-8?B?SjlOakgzU0w4ODFWRzlmOGlTcDVDQm5Gb3BmbHM2dFNzQkJNY1ZVMC9rSXRw?=
 =?utf-8?B?VEMwMDhEVHpOamZjT3hhcEpBUlJPOVBZcGI4dURaTFcxVlZwSGRTNEdzaGJu?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f54b20-6b4d-497f-ec6e-08dbc5eefdff
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9793.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 22:04:05.8495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3wyccPuDlN0TjnH1XBtlLzHcOZvw4kDgr9TiR7TOnZOn0dGgBVKxOXmYI3FMZXed7erSbWlNE4NIuiAMA6oVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8959
Subject: Re: [lttng-dev] LTTng enable-event performance issue during active
 session
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
From: Kienan Stewart via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Kienan Stewart <kstewart@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgWmFjaAoKYXBvbG9naWVzIGZvciB0aGUgZGVsYXkgaW4gcmVwbHlpbmcgdG8geW91ciBxdWVz
dGlvbi4KCk9uIDIwMjMtMDktMjYgMDg6MjcsIEtyYW1lciwgWmFjaCB2aWEgbHR0bmctZGV2IHdy
b3RlOgo+IEhpLAo+IAo+IEkgYW0gb2JzZXJ2aW5nIGEgcGVyZm9ybWFuY2UgaXNzdWUgd2l0aCBy
ZWdhcmRzIHRvIGVuYWJsaW5nIGV2ZW50cyB3aGlsZSAKPiBhIHNlc3Npb24gaXMgYWN0aXZlIGFu
ZCB3YXMgd29uZGVyaW5nIGlmIHRoaXMgaXMgZXhwZWN0ZWQuCj4gCj4gTFRUbmcgdmVyc2lvbnM6
Cj4gCj4gICAqIGx0dG5nLXRvb2xzOiAyLjEzLjkKPiAgICogbHR0bmctdXN0OiAyLjEzLjYgCj4g
Cj4gU3RlcHMgdG8gcmVwcm9kdWNlOgo+IAo+ICAxLiBFbnN1cmUgbWFueSB1c2Vyc3BhY2UgdHJh
Y2Vwb2ludHMgYXJlIGF2YWlsYWJsZSBpbiBgbHR0bmcgbGlzdCAtdWAKPiAgICAgZS5nLiAxMDAK
PiAgMi4gQ3JlYXRlIGEgbmV3IHNlc3Npb24KPiAgMy4gU3RhcnQgc2Vzc2lvbgo+ICA0LiBFbmFi
bGUgbmV3IGV2ZW50cyBvbiBzZXNzaW9uCj4gCj4gVGhlIHRpbWUgaXQgdGFrZXMgdG8gZW5hYmxl
IGVhY2ggbmV3IGV2ZW50IGhhcyBpbmNyZWFzaW5nIGNvc3QgZS5nLgo+IAo+ICAxLiBFdmVudCAx
OiAxbXMKPiAgMi4gRXZlbnQgMTAwOiAxNW1zCj4gIDMuIEV2ZW50IDEwMDA6IDE1MG1zCj4gIDQu
IMOgaW4gdG90YWwgYWJvdXQgMS41IG1pbnV0ZXMgdG8gZW5hYmxlIDEwMDAgZXZlbnRzCj4gCj4g
SWYgZWl0aGVyOgo+IAo+ICAxLiBObyB1c2Vyc3BhY2UgdHJhY2Vwb2ludHMgYXJlIGF2YWlsYWJs
ZQo+ICAyLiBPciBzZXNzaW9uIGlzIG5vdCBzdGFydGVkIHVudGlsIC9hZnRlciAvdGhlIGV2ZW50
cyBhcmUgZW5hYmxlZAo+IAo+IFRoZW4gdGhlIHRpbWUgaXQgdGFrZXMgdG8gZW5hYmxlIG5ldyBl
dmVudHMgaXMgY29uc3RhbnQgKGUuZy4gMW1zKS4KPiAKPiBCZWxvdyBpcyBhIGJhc2ggc2NyaXB0
IGRlbW9uc3RyYXRpbmcgdGhpcyBiZWhhdmlvcjoKPiAKPiAjIFByZS1yZXF1aXNpdGU6IGhhdmUg
bWFueSB1c2Vyc3BhY2UgdHJhY2Vwb2ludHMgYXZhaWxhYmxlCj4gCj4gbHR0bmcgY3JlYXRlIGZv
bwo+IAo+IGx0dG5nIGVuYWJsZS1jaGFubmVsIC11IC1zIGZvbyBiYXIKPiAKPiBsdHRuZyBzdGFy
dCBmb28KPiAKPiB0b3RhbF90MT0kKGRhdGUgKyVzJTNOKTsKPiAKPiBmb3IgaSBpbiB7MS4uMTAw
fQo+IAo+IGRvCj4gCj4gIMKgwqDCoMKgwqDCoMKgIHQxPSQoZGF0ZSArJXMlM04pOwo+IAo+ICDC
oMKgwqDCoMKgwqDCoCBsdHRuZyBlbmFibGUtZXZlbnQgLXUgbHR0bmdfaXRlcl8kaSAtcyBmb28g
LWMgYmFyID4gL2Rldi9udWxsCj4gCj4gIMKgwqDCoMKgwqDCoMKgIHQyPSQoZGF0ZSArJXMlM04p
Owo+IAo+ICDCoMKgwqDCoMKgwqDCoCBlY2hvICJFdmVudCAjJGkgdG9vayAkKCh0Mi10MSkpIG1z
Igo+IAo+IGRvbmUKPiAKPiB0b3RhbF90Mj0kKGRhdGUgKyVzJTNOKTsKPiAKPiBlY2hvICItLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIgo+IAo+IGVj
aG8gIkVuYWJsaW5nIGV2ZW50cyBvbiBhY3RpdmUgc2Vzc2lvbiB0b29rICQoKHRvdGFsX3QyLXRv
dGFsX3QxKSkgbXMiCj4gCj4gZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSIKPiAKPiBsdHRuZyBkZXN0cm95IGZvbwo+IAo+IGx0dG5nIGNy
ZWF0ZSBmb28KPiAKPiBsdHRuZyBlbmFibGUtY2hhbm5lbCAtdSAtcyBmb28gYmFyCj4gCj4gdG90
YWxfdDE9JChkYXRlICslcyUzTik7Cj4gCj4gZm9yIGkgaW4gezEuLjEwMH0KPiAKPiBkbwo+IAo+
ICDCoMKgwqDCoMKgwqDCoCB0MT0kKGRhdGUgKyVzJTNOKTsKPiAKPiAgwqDCoMKgwqDCoMKgwqAg
bHR0bmcgZW5hYmxlLWV2ZW50IC11IGx0dG5nX2l0ZXJfJGkgLXMgZm9vIC1jIGJhciA+IC9kZXYv
bnVsbAo+IAo+ICDCoMKgwqDCoMKgwqDCoCB0Mj0kKGRhdGUgKyVzJTNOKTsKPiAKPiAgwqDCoMKg
wqDCoMKgwqAgZWNobyAiRXZlbnQgIyRpIHRvb2sgJCgodDItdDEpKSBtcyIKPiAKPiBkb25lCj4g
Cj4gdG90YWxfdDI9JChkYXRlICslcyUzTik7Cj4gCj4gZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSIKPiAKPiBlY2hvICJFbmFibGluZyBl
dmVudHMgb24gaW5hY3RpdmUgc2Vzc2lvbiB0b29rICQoKHRvdGFsX3QyLXRvdGFsX3QxKSkgbXMi
Cj4gCj4gZWNobyAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLSIKPiAKPiBsdHRuZyBkZXN0cm95IGZvbwo+IAo+IElzIHRoaXMgcmVwcm9kdWNpYmxl
IGZvciB5b3U/IEFueSBpbnNpZ2h0IGlzIGFwcHJlY2lhdGVkLgo+IAoKSSdtIGFibGUgdG8gcmVw
cm9kdWNlIHdoYXQgeW91J3JlIHNlZWluZywgYW5kIGl0J3Mgbm90IGNvbXBsZXRlbHkgCnVuZXhw
ZWN0ZWQgYmFzZWQgb24gbXkgdW5kZXJzdGFuZGluZyBvZiB0aGUgYXJjaGl0ZWN0dXJlIG9mIGx0
dG5nLgoKV2hlbiBhIHNlc3Npb24gaXMgYWN0aXZlIGFuZCBhbiBldmVudCBydWxlIGlzIGVuYWJs
ZWQvZGlzYWJsZWQsIHRoZSAKc2Vzc2lvbmQgd2lsbCBub3RpZnkgZWFjaCBvZiB0aGUgcmVnaXN0
ZXJlZCBhcHBsaWNhdGlvbnMgb2YgdGhlIGV2ZW50IApydWxlIHN0YXRlIGNoYW5nZXMuIFRoaXMg
Y29tbXVuaWNhdGlvbiBpcyBnb2luZyB0aHJvdWdoIGVpdGhlciB1bml4IG9yIAp0Y3Agc29ja2V0
cywgYW5kIHRoYXQgcG9ydGlvbiBvZiB0aGUgcHJvdG9jb2wgc2VlbXMgdG8gc3RydWdnbGUgd2l0
aCAKbWFueSBzbWFsbCBjaGFuZ2VzIGFzIHRoZSBwcm90b2NvbCB0byBjb21tdW5pY2F0ZSB0aGUg
Y2hhbmdlcyBkb2Vzbid0IApzdXBwb3J0IGJhdGNoaW5nLgoKRW5hYmxpbmcgbXVsdGlwbGUgZXZl
bnRzIGluIGEgc2luZ2xlIGNhbGwgcmVkdWNlcyBzb21lIG9mIHRoZSBvdmVyaGVhZCwgCmJ1dCB0
aGUgY2hhbmdlcyB3aWxsIHN0aWxsIGJlIGNvbW11bmljYXRlZCBzZXJpYWxseS4gVGhpcyBtZWFu
cyBhIHNpbmdsZSAKY2FsbCBhY3RpdmF0aW5nIHRob3VzYW5kcyBldmVudHMgY2FuIHN0aWxsIHRh
a2UgYSBsb25nIHRpbWUgdG8gcHJvY2VzcyAKKGVnLiBgbHR0bmcgZW5hYmxlLWV2ZW50IC1zIGZv
byAtYyBiYXIgLXUgdHAwLHRwMSwuLi4sdHBOYCkKClVzaW5nIGdsb2IgcGF0dGVybnMgb3IgYC0t
YWxsYCB3aWxsIGJlIHNpZ25pZmljYW50bHkgZmFzdGVyIGFzIHRoZSBVU1QgCmFwcGxpY2F0aW9u
cyBjYW4gZGlnZXN0IHRob3NlIHR5cGVzIG9mIGV2ZW50IHJ1bGUgY2hhbmdlcyB3aXRoIGEgc2lu
Z2xlIApzZXQgb2YgbWVzc2FnZXMuIEluIGNhc2VzIHdoZXJlIHlvdSB3YW50IG1vc3QgYnV0IG5v
dCBhbGwgZXZlbnRzLCAKZmxpcHBpbmcgdGhlIGxvZ2ljIHRvIGVuYWJsZSAiKiIgYnV0IGFkZCBl
dmVudHMgb3IgcGF0dGVybnMgdG8gb21pdCB3aXRoIAoiLS1leGNsdWRlIiBpcyBnb2luZyB0byBi
ZSBhIGJldHRlciBzdHJhdGVneS4KCkRvIHlvdSBoYXZlIGNhc2VzIHdoZXJlIHlvdSBuZWVkIHRv
IGFjdGl2YXRlIG1hbnkgb2YgZXZlbnRzIGJ1dCB3aGljaCAKY291bGRuJ3QgYmUgY292ZXJlZCBi
eSB1c2luZyBnbG9iIHBhdHRlcm5zIGFuZC9vciBleGNsdXNpb25zPwoKdGhhbmtzLApraWVuYW4K
Cj4gTWFueSB0aGFua3MsCj4gCj4gWmFjaAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0
dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
