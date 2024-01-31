Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D745C47DB3
	for <lttng-dev@archiver.kernel.org>; Wed, 31 Jan 2024 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1706723905;
	bh=8dPALSlFrmCXtuDWhgLT8Y4py3m4yidu2kPUl75MFl8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=n9yK0RqkK92tBJC+jHrCLWaNoA7AuXCM3rST+uAl2jX6HmlWR/DSVcn26hdLLCBNl
	 V8JRPOECAZY8DqdcwBkUBD5j9FOPbQWCvLmA7LuQMGOi+v/IoAaL/WH/g7gmSZ880t
	 re5eF892rWZ5wrkNhdAOyyjQPGAssNc0H8BHoIiyV0cXLtYI2gmJX+kutQfmZaepo9
	 +wfKoAOzx1TZ2KtUX89XrfaKMapaHUcgILeObzwP52jr94xnF3LVJtXgFrZ7rzVT4F
	 Bjr1OqosB1I8+MH5NFFaxOdwiJRyPsY3xjZ9nFt7aHoPECFew147rAj927MU5vWMi+
	 xtMRXa+Odr8Cg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TQ8sX5Fczz1qLx;
	Wed, 31 Jan 2024 12:58:24 -0500 (EST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11020003.outbound.protection.outlook.com [52.101.85.3])
 by lists.lttng.org (Postfix) with ESMTPS id 4TQ8973rmyz1qlw
 for <lttng-dev@lists.lttng.org>; Wed, 31 Jan 2024 12:26:49 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD9a1SiHCNiIxq9Pnd74Ra5BwbVDjkh6IN2rFOk4JyVxKtfAylEjBB9V87K3/MhwYA+C++/baCBTUNbstKynOwNIBAJquo4n2KKAiKkRasI2H6PxFN7PfqA8DPl9hXKbWWJOZ9ju9eLA/0hZ+KeplngxVyCKiQPBlrpmfHpumGV+w2q1ajTaiP3MoXUzdnpBuryM5BnC2fPuzz50ooHd2pWyoPq2vQjzUXbFrTye2vpFIRrkqzasrXhQ8Pv7YShbuHxzAx/63hyW+iykuYawoFpYZnsp3N0uo5pMR+5U1nYmJM3NFEEaEnDC5cf6vCriFeVKrAXKpxqZ5rzvwnYywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2CQP//6wOSYXgMrtJXvmE3cggGPMCaSbE0UvjuLjqU=;
 b=l+EGxVnPokmSC1bz0W8cQFDKqUizjkEw0zZOteBQvKo+dnHtA093bklgfNamCql0bY7IKJ6PX7AzaW1xRl9mX0IX2DIvs15cXhhKHWNeAENKG8DiJviU3mAnPf3FZ68g9eDIAyHB+SkyfBVde02Rfr8KhiBRpwz1bMXZQ6pN/w16Sasp7Psi0z4F2piPCTHIS9Gjem5ZWCpQWQbyM2FZUvrviZoMAutQBMSC84je9IQh8cFZfYlpHyFTmZy0mjC+l41qQMub4o8Xt3UtZhhwWfpeFu3VclweutaxitRurENT4cNScovrOgbBzr1UhObgW+hHXamHWV0TAZfB35rJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Received: from MN2PR21MB1487.namprd21.prod.outlook.com (2603:10b6:208:20d::9)
 by PH7PR21MB4058.namprd21.prod.outlook.com (2603:10b6:510:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Wed, 31 Jan
 2024 17:10:56 +0000
Received: from MN2PR21MB1487.namprd21.prod.outlook.com
 ([fe80::e053:5f82:9670:2c80]) by MN2PR21MB1487.namprd21.prod.outlook.com
 ([fe80::e053:5f82:9670:2c80%3]) with mapi id 15.20.7270.007; Wed, 31 Jan 2024
 17:10:56 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: error with ctf_sequence_text when using non-utf8 encoded strings
Thread-Index: AdpUaHJEdO9tnv+SS2e6Gsk7cxzjJQ==
Date: Wed, 31 Jan 2024 17:10:55 +0000
Message-ID: <MN2PR21MB14875F808A597503CC62BC05D57C2@MN2PR21MB1487.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=629bbf03-e008-4100-8d18-987b9647f17c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-31T16:32:07Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR21MB1487:EE_|PH7PR21MB4058:EE_
x-ms-office365-filtering-correlation-id: f748fb94-09b8-4759-f04c-08dc227f9679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pn+SItDp/RzFloOSAWHtJ8WqSUT3w04pfAV28J+Ka6WTCpv5GOH34nd1Q0QE5fZXM6+XyQ/OBFeQUZeqYavbA32dTezgMk+IM4AjGlADMdwuC8KI98OpbmOZx/29gB97aVbHVkAoduTBVQVQ6aLpgNUaKVJI8iJ5WWDQK3NefwHatjxS7qA1ZVd2+IomV5pFYtkiO5AddDKnAW+uFePQRxSISOeJ1PICKZo7k5+3U5/lOVvqCUpH1rj+19pCOt7lBJ3PISN1VbWVuMODuAdJ8YBInBdC21AAYGl75T0ehInPQHxxtmoVbyROGV4B/Cukp2+mgoCezOyQooS70q5upozHIq44+HUC46Dc8RQcbEOR2HoCWUfuV+RKsPeT4FJIXjPmd6h4jD2wFPsCzT81zSHm+det0UzBuKiPTZYzgIeDJ6rJFd0hLpcsCXiAnj26bVnxSA7W0hKUFvOhAhGmQGfusPk8qfUoRCPA9tDOT4g+YwC3UF7XuEOmWbnxv95Xla+0GnzReNXfFatPc95tVYJ81oYtw3bDGpCmt0GCapSbgR72i76oHJh5DwulffahQnW+8M3nCgaIjKAefOaiIYdMryRxAShm+lJxyjgCM+AXeTN73RPdzA8/XbtVZIK/1/AyXKYB/bxRa13K/jIP5KMeLm2UfM4ueDfj+XkTtic=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR21MB1487.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(9686003)(38070700009)(86362001)(10290500003)(41300700001)(478600001)(966005)(7696005)(6506007)(71200400001)(52536014)(8936002)(8990500004)(8676002)(122000001)(166002)(82950400001)(82960400001)(38100700002)(33656002)(5660300002)(2906002)(55016003)(66946007)(64756008)(6916009)(316002)(66476007)(66446008)(66556008)(76116006)(505234007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SUzVcoQKtE2zFo3roTKL7dgtj78mexdu3cpMVGhsi17y7xERy/FUAtZTH7+u?=
 =?us-ascii?Q?iaYp9z0JC6MlcycKIoHPXs8HoUtgBnrou31Bua1xwsz0Dv0c+cm59HjWx7y0?=
 =?us-ascii?Q?LuTKsKaX1kfqM3E2dVY8zD4y2Q5vI7JsJtzN7S5v7JJ5+TOQPPDu9PJbGB+j?=
 =?us-ascii?Q?sgm7a8PvMzGsOoW56DRTWW2iB/GykXNltvgsbnoiiDHma5i3MgWGIdP76d0D?=
 =?us-ascii?Q?UdARjUTT7s0FYaMCDv/sYcfaA7DscKcG4MgH4eo6Kvz7CzoFJC1QcrCIbkIc?=
 =?us-ascii?Q?TitrFCx+oRsGsJ4wp6hCxjoFd2r3+glMH8dozkhwt1ppcQf1sKG+GrCBMDDx?=
 =?us-ascii?Q?d3gctyZHow/Zb1QQPskTO2C37Z6b17sYNlypPB87HKrGha1o87lV+5xx2W5U?=
 =?us-ascii?Q?cdHQ24uvMpAUeKXeT9G6g/tnN93AOUTpamNYrvNqv0Gh6rpQmU7DsvZMjnFv?=
 =?us-ascii?Q?WrSS0kcPQbRs/lKnPmoGOWBRd5OVM/LLvjpCmVy9+HRwPSr3WhcFJSxM7pkO?=
 =?us-ascii?Q?k3afmBL6YOVRUTC/mNYwDzlxvxW5Lr9dHZXjiDPSutf+PnROaLkKAa26BXc2?=
 =?us-ascii?Q?jAFe1tM8EM4VGjfZf9iBVz2kI2KijjX2o2oZS0ntNTQfQ8I3qKstYX8pr/IU?=
 =?us-ascii?Q?ADnqt2Mj93tSnuJr2hJ4HTEXc2YxMZnnxqzi2RAF5OfFjqMUzHchfe0lkpOG?=
 =?us-ascii?Q?rcAEfqxHiLayJM+qKcBebMWu4wnVbsbROneFNvk4lRXxP8e/OUGzs5tyZo2i?=
 =?us-ascii?Q?vThU7Ws9025EajAbwwABJPvB2j0wdoM0sEYx+XKF23rGcjzBbxg7o2nkvA8Z?=
 =?us-ascii?Q?GKcZ5ZucuUDuhL7EeJBiM3tMfVpEFxLnZb4AJHwSV/ZO5LFgnseEjD3tCcln?=
 =?us-ascii?Q?jjmGc4bmHi9g74IstKiCPWT5VT8t48Gi1Fru7NrUGcs0Dwm3ILgY9dFVrWoW?=
 =?us-ascii?Q?f/zpga+kdxPutFyEGDQ9VhuOeZ0e04YU51YrP14UCrapnHldcKVuOAI3hfjC?=
 =?us-ascii?Q?TXorLiUglP0rFh9XCHFp2LvYA1bfVFXt7MNrT8XiJBsHFwLKQ6v0X2xQJSY4?=
 =?us-ascii?Q?W6kHv5gb5xLSAnwoq1qpkmXTmE37/gNFHsKzIbE9YOhBCvlBYbC6Dc3DLjdg?=
 =?us-ascii?Q?OYD0LU1ANuUQp3SYUwawq5RBbvK/TUyfUktAKcaF05/bBTUVRLacQRS/He5c?=
 =?us-ascii?Q?0VFAPGNzGlyDyMrYOAtbLfonrYlgtJW74hSZnp2wQaIGV+5c+q3vp8xMmxgN?=
 =?us-ascii?Q?ZzJDLjP9pI/mV1MHTT2sorNbQtTDCVRvcgaDvxzrEQGJFALPZtmnThrcM7Rg?=
 =?us-ascii?Q?ZGjYOamwZOgi7ceZcvryOtUpJhk9U+pg3IW0CBFUQ7S7Msw3U6QzyNleLRKW?=
 =?us-ascii?Q?cXyVmimPCCvOq0LCbnwpKvmnaqwZQIvrn90qkVUG/FYlZk72caW4i86ZTOX2?=
 =?us-ascii?Q?GUNjA/SXVopCyiFaKhX2SiYLChxoFfldcV2dLuqqWFOhlFL047nd/z4C8z5e?=
 =?us-ascii?Q?sz2AFf4i8Y+mV2+VxFyURy2gv48pm9yWoK2N6b35+lKeZ5RupFw0KKLXcRUr?=
 =?us-ascii?Q?xQdenAo4mN0qpjiBv2zH8SdiiE1OAOIGetj2RGOgXQLXskjYFFyEI6CLhhbw?=
 =?us-ascii?Q?3nf1NrjGa5p34xoFB3ge5EApGZSjdcAb+Mcg7nKf3O9J?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1487.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f748fb94-09b8-4759-f04c-08dc227f9679
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 17:10:56.0069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HemDMPsZgSlbl4DxM+SOomYr3eWhgE7ivcnM9JE2qHvxLT6/U0B0JoLs9kDCVyH0KkEYoZ+A+OwcsAMLtrrHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB4058
X-Mailman-Approved-At: Wed, 31 Jan 2024 12:58:23 -0500
Subject: [lttng-dev] error with ctf_sequence_text when using non-utf8
 encoded strings
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
From: Nathan Ricci via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Nathan Ricci <naricc@microsoft.com>
Content-Type: multipart/mixed; boundary="===============4344811155915968636=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4344811155915968636==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR21MB14875F808A597503CC62BC05D57C2MN2PR21MB1487namp_"

--_000_MN2PR21MB14875F808A597503CC62BC05D57C2MN2PR21MB1487namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am trying to emit a trace that has a wchar string, using as one of the fi=
elds ctf_sequence_text. When the trace is recorded, it seems like everythin=
g at but the first character is truncated, and I think this is because it i=
s assuming UTF8 encoding and stopping at the first null character.  This is=
 on Ubuntu 22.04, using this liblttng-ust package:

liblttng-ust-common1/jammy,now 2.13.1-1ubuntu1

I've boiled this down to a simple repro; I've included the code below, but =
you can also get it here: https://github.com/naricc/lttng-test

Here is the main file:
-----

#include <stdio.h>
#include <unistd.h>
#include <lttng/lttng.h>
#include <lttng/tracepoint.h>
#include <wchar.h>
#include "repro-tracepoint.h"



int main() {
    puts("Hello, World!\nPress Enter to continue...");
    getchar();

    const char* utf8_text_value =3D "Hello, UTF8 Sequence Text!";
    const wchar_t *wchar_text_value =3D L"Hello, WChar Sequence Text!";

    // Emit the tracepoint event with the sequence text field
    lttng_ust_tracepoint(naricc_test_provider, test_event, utf8_text_value,=
 wchar_text_value);

    return 0;
}

----
Here is the tracepoint header (repro-tracepoint.h):
___

#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER naricc_test_provider

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./repro-tracepoint.h"

#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _TP_H

#include <lttng/tracepoint.h>
#include <wchar.h>

// Define the tracepoint event with a sequence text field
TRACEPOINT_EVENT(naricc_test_provider, test_event,
    TP_ARGS(
        const char*, utf8_text_value,
        const wchar_t*, wchar_text_value
    ),
    TP_FIELDS(
        ctf_sequence_text(char, utf8_text_sequence, utf8_text_value, size_t=
, strlen(utf8_text_value))
        ctf_sequence_text(wchar_t, wchar_text_sequence, wchar_text_value, s=
ize_t, wcslen(wchar_text_value) * 2 + 2)
    )
)

#endif /* _TP_H */

#include <lttng/tracepoint-event.h>

----
And here is the repro-tracepoint.cpp:
___

#define LTTNG_UST_TRACEPOINT_CREATE_PROBES
#define LTTNG_UST_TRACEPOINT_DEFINE

#include "repro-tracepoint.h"

---

I built it like so:


g++ -c -I. repro-tracepoint.cpp
g++ -c lttng-test.cpp
g++ -o lttng-test lttng-test.o repro-tracepoint.o -llttng-ust -ldl

naricc@TDC20748914:/workspace/lttng-test$

---

After starting a session, running that program, and destroying the session,=
 this is what I get with babeltrace2:

```
$ babeltrace2  ~/lttng-traces/my-user-space-session-20240131-161638
[16:16:43.553211421] (+?.?????????) TDC20748914 naricc_test_provider:test_e=
vent: { cpu_id =3D 6 }, { _utf8_text_sequence_length =3D 26, utf8_text_sequ=
ence =3D "Hello, UTF8 Sequence Text!", _wchar_text_sequence_length =3D 56, =
wchar_text_sequence =3D [ [0] =3D 72, [1] =3D 0, [2] =3D 0, [3] =3D 0, [4] =
=3D 0, [5] =3D 0, [6] =3D 0, [7] =3D 0, [8] =3D 0, [9] =3D 0, [10] =3D 0, [=
11] =3D 0, [12] =3D 0, [13] =3D 0, [14] =3D 0, [15] =3D 0, [16] =3D 0, [17]=
 =3D 0, [18] =3D 0, [19] =3D 0, [20] =3D 0, [21] =3D 0, [22] =3D 0, [23] =
=3D 0, [24] =3D 0, [25] =3D 0, [26] =3D 0, [27] =3D 0, [28] =3D 0, [29] =3D=
 0, [30] =3D 0, [31] =3D 0, [32] =3D 0, [33] =3D 0, [34] =3D 0, [35] =3D 0,=
 [36] =3D 0, [37] =3D 0, [38] =3D 0, [39] =3D 0, [40] =3D 0, [41] =3D 0, [4=
2] =3D 0, [43] =3D 0, [44] =3D 0, [45] =3D 0, [46] =3D 0, [47] =3D 0, [48] =
=3D 0, [49] =3D 0, [50] =3D 0, [51] =3D 0, [52] =3D 0, [53] =3D 0, [54] =3D=
 0, [55] =3D 0 ] }

```

The utf8 sequence prints fine, but the wchar one is truncated to a single c=
haracter and then zeros.  To rule out an error in babelltrace, I inspected =
the channel files with hexedit and found this:

```
85 58  E1 C1 43 EE  9A 93 9C 60  6D B7 2B B0  00 00 00 00  .......X..C....`=
m.+.....
00000018   06 00 00 00  00 00 00 00  6A 33 DA B4  2D AD 02 00  04 78 1C 56 =
 30 AD 02 00  ........j3..-....x.V0...
00000030   60 0B 00 00  00 00 00 00  00 80 00 00  00 00 00 00  00 00 00 00 =
 00 00 00 00  `.......................
00000048   00 00 00 00  00 00 00 00  06 00 00 00  FF FF 00 00  00 00 3C 10 =
 F2 E2 2E AD  ..................<.....
00000060   02 00 1A 00  00 00 00 00  00 00 48 65  6C 6C 6F 2C  20 55 54 46 =
 38 20 53 65  ..........Hello, UTF8 Se
00000078   71 75 65 6E  63 65 20 54  65 78 74 21  38 00 00 00  00 00 00 00 =
 48 00 00 00  quence Text!8.......H...
00000090   00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00 =
 00 00 00 00  ........................
```

So it seems the error in the the recording of the trace, not in the viewing=
.

Looking into the lttng-ust code, it seems like ctf_sequence_text ends up ma=
pped to this:

lttng-ust/include/lttng/ust-tracepoint-event-write.h at 717c38f658248bc04cc=
fc6e7fdf5d03040c2a846 * lttng/lttng-ust * GitHub<https://github.com/lttng/l=
ttng-ust/blob/717c38f658248bc04ccfc6e7fdf5d03040c2a846/include/lttng/ust-tr=
acepoint-event-write.h#L73>

Which assumes utf8 encoding, and ultimately writes into a ring buffer termi=
nating on null:

lttng-ust/src/common/ringbuffer/backend.h at 717c38f658248bc04ccfc6e7fdf5d0=
3040c2a846 * lttng/lttng-ust * GitHub<https://github.com/lttng/lttng-ust/bl=
ob/717c38f658248bc04ccfc6e7fdf5d03040c2a846/src/common/ringbuffer/backend.h=
#L126>


If we agree this is an error, I believe I can produce a fix for it. Or if I=
 am just using the APIs wrong, please let me know what I should do instead.

             --Nathan Ricci






--_000_MN2PR21MB14875F808A597503CC62BC05D57C2MN2PR21MB1487namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.ui-provider
	{mso-style-name:ui-provider;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I am trying to emit a trace that has a wchar string,=
 using as one of the fields ctf_sequence_text. When the trace is recorded, =
it seems like everything at but the first character is truncated, and I thi=
nk this is because it is assuming
 UTF8 encoding and stopping at the first null character. &nbsp;This is on U=
buntu 22.04, using this liblttng-ust package:<br>
<br>
liblttng-ust-common1/jammy,now 2.13.1-1ubuntu1<br>
<br>
I&#8217;ve boiled this down to a simple repro; I&#8217;ve included the code=
 below, but you can also get it here:
<a href=3D"https://github.com/naricc/lttng-test">https://github.com/naricc/=
lttng-test</a><br>
<br>
Here is the main file:<br>
-----<br>
<br>
#include &lt;stdio.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;unistd.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;lttng/lttng.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;lttng/tracepoint.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;wchar.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;repro-tracepoint.h&quot;<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">int main() {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; puts(&quot;Hello, World!\nPress E=
nter to continue...&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; getchar();<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; const char* utf8_text_value =3D &=
quot;Hello, UTF8 Sequence Text!&quot;;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; const wchar_t *wchar_text_value =
=3D L&quot;Hello, WChar Sequence Text!&quot;;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; // Emit the tracepoint event with=
 the sequence text field<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; lttng_ust_tracepoint(naricc_test_=
provider, test_event, utf8_text_value, wchar_text_value);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">----<o:p></o:p></p>
<p class=3D"MsoNormal">Here is the tracepoint header (repro-tracepoint.h):<=
br>
___<br>
<br>
#undef TRACEPOINT_PROVIDER<o:p></o:p></p>
<p class=3D"MsoNormal">#define TRACEPOINT_PROVIDER naricc_test_provider<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#undef TRACEPOINT_INCLUDE<o:p></o:p></p>
<p class=3D"MsoNormal">#define TRACEPOINT_INCLUDE &quot;./repro-tracepoint.=
h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#if !defined(_TP_H) || defined(TRACEPOINT_HEADER_MUL=
TI_READ)<o:p></o:p></p>
<p class=3D"MsoNormal">#define _TP_H<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#include &lt;lttng/tracepoint.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;wchar.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">// Define the tracepoint event with a sequence text =
field<o:p></o:p></p>
<p class=3D"MsoNormal">TRACEPOINT_EVENT(naricc_test_provider, test_event,<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; TP_ARGS(<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const cha=
r*, utf8_text_value,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const wch=
ar_t*, wchar_text_value<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; ),<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; TP_FIELDS(<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_seque=
nce_text(char, utf8_text_sequence, utf8_text_value, size_t, strlen(utf8_tex=
t_value))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf_seque=
nce_text(wchar_t, wchar_text_sequence, wchar_text_value, size_t, wcslen(wch=
ar_text_value) * 2 + 2)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; )<o:p></o:p></p>
<p class=3D"MsoNormal">)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#endif /* _TP_H */<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#include &lt;lttng/tracepoint-event.h&gt;<br>
<br>
----<br>
And here is the repro-tracepoint.cpp:<br>
___<br>
<br>
#define LTTNG_UST_TRACEPOINT_CREATE_PROBES<o:p></o:p></p>
<p class=3D"MsoNormal">#define LTTNG_UST_TRACEPOINT_DEFINE<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#include &quot;repro-tracepoint.h&quot;<br>
<br>
---<br>
<br>
I built it like so:<br>
<br>
<br>
g++ -c -I. repro-tracepoint.cpp<o:p></o:p></p>
<p class=3D"MsoNormal">g++ -c lttng-test.cpp<o:p></o:p></p>
<p class=3D"MsoNormal">g++ -o lttng-test lttng-test.o repro-tracepoint.o -l=
lttng-ust -ldl<o:p></o:p></p>
<p style=3D"margin:0in">naricc@TDC20748914:/workspace/lttng-test$<br>
<br>
---<br>
<br>
After starting a session, running that program, and destroying the session,=
 this is what I get with babeltrace2:<br>
<br>
```<br>
<span class=3D"ui-provider">$ babeltrace2&nbsp; ~/lttng-traces/my-user-spac=
e-session-20240131-161638</span><br>
<span class=3D"ui-provider">[16:16:43.553211421] (+?.?????????) TDC20748914=
 naricc_test_provider:test_event: { cpu_id =3D 6 }, { _utf8_text_sequence_l=
ength =3D 26, utf8_text_sequence =3D &quot;Hello, UTF8 Sequence Text!&quot;=
, _wchar_text_sequence_length =3D 56, wchar_text_sequence
 =3D [ [0] =3D 72, [1] =3D 0, [2] =3D 0, [3] =3D 0, [4] =3D 0, [5] =3D 0, [=
6] =3D 0, [7] =3D 0, [8] =3D 0, [9] =3D 0, [10] =3D 0, [11] =3D 0, [12] =3D=
 0, [13] =3D 0, [14] =3D 0, [15] =3D 0, [16] =3D 0, [17] =3D 0, [18] =3D 0,=
 [19] =3D 0, [20] =3D 0, [21] =3D 0, [22] =3D 0, [23] =3D 0, [24] =3D 0, [2=
5] =3D 0, [26]
 =3D 0, [27] =3D 0, [28] =3D 0, [29] =3D 0, [30] =3D 0, [31] =3D 0, [32] =
=3D 0, [33] =3D 0, [34] =3D 0, [35] =3D 0, [36] =3D 0, [37] =3D 0, [38] =3D=
 0, [39] =3D 0, [40] =3D 0, [41] =3D 0, [42] =3D 0, [43] =3D 0, [44] =3D 0,=
 [45] =3D 0, [46] =3D 0, [47] =3D 0, [48] =3D 0, [49] =3D 0, [50] =3D 0, [5=
1] =3D 0, [52]
 =3D 0, [53] =3D 0, [54] =3D 0, [55] =3D 0 ] }</span><br>
<br>
```<br>
<br>
The utf8 sequence prints fine, but the wchar one is truncated to a single c=
haracter and then zeros.&nbsp; To rule out an error in babelltrace, I inspe=
cted the channel files with hexedit and found this:<br>
<br>
```<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-se=
rif"><br>
85 58&nbsp; E1 C1 43 EE&nbsp; 9A 93 9C 60&nbsp; 6D B7 2B B0&nbsp; 00 00 00 =
00&nbsp; .......X..C....`m.+.....<br>
00000018&nbsp;&nbsp; 06 00 00 00&nbsp; 00 00 00 00&nbsp; 6A 33 DA B4&nbsp; =
2D AD 02 00&nbsp; 04 78 1C 56&nbsp; 30 AD 02 00&nbsp; ........j3..-....x.V0=
...<br>
00000030&nbsp;&nbsp; 60 0B 00 00&nbsp; 00 00 00 00&nbsp; 00 80 00 00&nbsp; =
00 00 00 00&nbsp; 00 00 00 00&nbsp; 00 00 00 00&nbsp; `....................=
...<br>
00000048&nbsp;&nbsp; 00 00 00 00&nbsp; 00 00 00 00&nbsp; 06 00 00 00&nbsp; =
FF FF 00 00&nbsp; 00 00 3C 10&nbsp; F2 E2 2E AD&nbsp; ..................&lt=
;.....<br>
00000060&nbsp;&nbsp; 02 00 1A 00&nbsp; 00 00 00 00&nbsp; 00 00 48 65&nbsp; =
6C 6C 6F 2C&nbsp; 20 55 54 46&nbsp; 38 20 53 65&nbsp; ..........Hello, UTF8=
 Se<br>
00000078&nbsp;&nbsp; 71 75 65 6E&nbsp; 63 65 20 54&nbsp; 65 78 74 21&nbsp; =
38 00 00 00&nbsp; 00 00 00 00&nbsp; 48 00 00 00&nbsp; quence Text!8.......H=
...<br>
00000090&nbsp;&nbsp; 00 00 00 00&nbsp; 00 00 00 00&nbsp; 00 00 00 00&nbsp; =
00 00 00 00&nbsp; 00 00 00 00&nbsp; 00 00 00 00&nbsp; .....................=
...<o:p></o:p></span></p>
<p class=3D"MsoNormal">```<br>
<br>
So it seems the error in the the recording of the trace, not in the viewing=
.<br>
<br>
Looking into the lttng-ust code, it seems like ctf_sequence_text ends up ma=
pped to this:<br>
<br>
<a href=3D"https://github.com/lttng/lttng-ust/blob/717c38f658248bc04ccfc6e7=
fdf5d03040c2a846/include/lttng/ust-tracepoint-event-write.h#L73">lttng-ust/=
include/lttng/ust-tracepoint-event-write.h at 717c38f658248bc04ccfc6e7fdf5d=
03040c2a846 &middot; lttng/lttng-ust &middot; GitHub</a><br>
<br>
Which assumes utf8 encoding, and ultimately writes into a ring buffer termi=
nating on null:<br>
<br>
<a href=3D"https://github.com/lttng/lttng-ust/blob/717c38f658248bc04ccfc6e7=
fdf5d03040c2a846/src/common/ringbuffer/backend.h#L126"><span style=3D"font-=
size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif">lttng-ust/src/comm=
on/ringbuffer/backend.h at 717c38f658248bc04ccfc6e7fdf5d03040c2a846
 &middot; lttng/lttng-ust &middot; GitHub</span></a><br>
<br>
<br>
If we agree this is an error, I believe I can produce a fix for it. Or if I=
 am just using the APIs wrong, please let me know what I should do instead.=
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --=
Nathan Ricci<br>
<br>
<br>
<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR21MB14875F808A597503CC62BC05D57C2MN2PR21MB1487namp_--

--===============4344811155915968636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4344811155915968636==--
