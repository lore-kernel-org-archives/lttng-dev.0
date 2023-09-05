Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16876C83F33
	for <lttng-dev@archiver.kernel.org>; Tue,  5 Sep 2023 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1693924347;
	bh=ntmPiAZJ1fSBQ4seflL/NHg5WS1b3TzhcGRvAoX4idw=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ghu5QqiUsxLGZekn1xAxJsbHjp0fAqsvhfXnYD2j5nkj/w+qwxGy5AJadtvRvVt1/
	 UCeTjnowv9263v7lgUP6KRx5bQfxQqaSP56nkQM9r5iKW+/s7RDX4+Ing8ghiYaCdd
	 yTU2u5H5MNjPw/4EOieVxFfT/U6qhfR5ufwiyLOrRtmCQ4ymR6bvajGh2pLEyDBJ2c
	 3IgP+lcGfwfBES/xJj3C21AQG+vOtEeBvCEukapa6qWeUhzMuj2kJ0lGRa8gbm/Wsg
	 xC/PQlwYFMhLbJz2cEqOeyLuwLXFAUtQNYSQDcwCUtppGxbAtdO9Gk1Q3mcVuhh4Dv
	 9/uS0jkoNOW/A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Rg7JB6gSPz2Vyr;
	Tue,  5 Sep 2023 10:32:26 -0400 (EDT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by lists.lttng.org (Postfix) with ESMTPS id 4Rfwwy2sn2z2VYt
 for <lttng-dev@lists.lttng.org>; Tue,  5 Sep 2023 02:45:06 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqh9tOqVXxvDfSpmTd5FGIYdzGhZwPnRZYcwX3yDvkZc341bN1hKBnFopRL/m47UiwgvCtwYbehdoFD4kKB3SXQ9r6tDfhPH97lFUAicp3FwMLw69BJ0VMxDtoxgHdw9fZ7mLZZVu2TUXfTrHO1hYlMHvEM5UFvmZAsMvjYisYnGPNTBMdiRApeXnnE4K444GnaAoWQeYzk2gM+OYLZO5xEzKqYl6pVSbGOzAoOoplaaIZgQQcSKd/MsHP6UhjX+hrlPPQk3WxFqu4hQRTgaRUQ8rywrOTFN/Jt9mKMDbBKUKK4NRJwPaMlwOEkcZk266gr/F/3uwBwqtmEPBtajBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5H2CQycQb1Y0OQjInZhLw7H4VZvSGyz9mEW40GaEwI=;
 b=T7gQXj81Ca/W1ocqmzQPT7S6YqJSdc+je3MwI59ch4hJt3YGL28f4/ptqR12vI+d8nrYoA7QvurOCe6eU7047Qr41SMWNb8o56Kmm+KhgSNa0T+jJ8NI4jZKAa7jw2TxfMmajlnBUBov9Ei7ZfoJHZsshZztzQTRuagnEJCCgIAA0A/QVwFBF9Vu3cxK9Egb6xQ+PluVCvlpnjpV6SgNsaeoUAXjHGdOJMaNGZ01byyCtiSSBW2xbtpaWd67BmxBb7hVRHoqxHBenoR7nEpXN+vXGJmhDs72n36dnfVqS8SAjq1KtsWMG1pDClkHXF6s8RXEaRdUwBliFXGj9w4E0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 06:30:48 +0000
Received: from MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::5acf:b492:72c8:6e99]) by MW3PR12MB4555.namprd12.prod.outlook.com
 ([fe80::5acf:b492:72c8:6e99%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 06:30:48 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: LTTNG LIB UST Crash
Thread-Index: AQHZ38CUibDWq+jpPkCnQS40t4VDBg==
Importance: high
X-Priority: 1
Date: Tue, 5 Sep 2023 06:30:48 +0000
Message-ID: <MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8A@MW3PR12MB4555.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4555:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: 68b342c9-a907-4d29-9aaa-08dbadd9a4a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlrdLA/Ju/fcCCGyAvtZkd8qrIeTzBPRdRqQlO1DeK1dyHiJV50SKeeTnYa6mvQNT7NOV0asiefQBOmHKgGIDgC8Q9I6B+8VF3MLTH5K9jvCu6sZ4w6bR3nAzQT077b/ePYLPEXFeRqYuFsI9oCQLWtMdUmQg3dyD+ttg9j4sedtaEU5SE3IyfxDwXNH+G4W6yn5aGAOzHL1jLVyKqLgWzCKYLj1SyveAKV8bjeMgJmsufeGWEe9BWc642ddFUoYzhf+DK7YOGUGIk2T4mVdDmlPdW90Jqw3NGQzInhi1NbH8Om+tay8zixClvUy9dEUXhmS/CW8+jky8B8K6fiar9JYyuHKLJ3fVLT+7b2QMfNVPPBE8iPLlG2SwAnQIEk1pdJI4jpOcxiUupM6YFEE5I0gygOMeApWxA2fNmtdUMpgr8SqqRbovEk24OZZxoWray7tF/XwgpLMmfU2tbhQx6IIV+gK8CxMD9oY6u0xqPIRRjCxoLu16abQuc3+rO+DUH1aJbingtvjSO139w7qUk+6mz2nQSC4A6/QH/EKpFkIuLiS3zbNboxAO6BAyj3oLuA5/pvumBK8p6SR7okybtVdFGl61w+1EfA58OSa/Gpfoysagk27+/0A40x9Ye6c
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199024)(186009)(1800799009)(86362001)(38070700005)(38100700002)(122000001)(55016003)(33656002)(478600001)(64756008)(2906002)(66946007)(66556008)(66476007)(91956017)(66446008)(76116006)(7696005)(71200400001)(6506007)(26005)(8936002)(8676002)(5660300002)(52536014)(316002)(6916009)(19627405001)(3480700007)(41300700001)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZhHzCv34Ol1lYaxTacspCWRQ5U66K+sYOAKuqifQtTIxS1HxTdZR8M/qnK?=
 =?iso-8859-1?Q?yZpZ4F0CYUkRmTpU69QnkpI6DwzOvTE2pOLmUPfXhHDacQrMItGBGoQmbH?=
 =?iso-8859-1?Q?tHlD+9m+JLYCQG2kCx19DsqK5EghcxviINRPY+DFGY+bu01Tkr14eT7NLv?=
 =?iso-8859-1?Q?fNXmZJKsWWltDO9b6rrVFWeZGIhqc9FG7dWgxeSZ7IGhPn19A8E8z8q1SK?=
 =?iso-8859-1?Q?micJDp/m6RjK/H5fEjyKljW+Imwc3QWKTYlvjoThX/iKU76zo3kFY2LSOU?=
 =?iso-8859-1?Q?wHavgUTZSLagfXlDQadGdtRlMi8zFKb+vzpVSEyONNJkKJEV4/RC9hK21r?=
 =?iso-8859-1?Q?o8DmxwgpYTWqvmnFoO/RhTYrZQ5ubU6+MsUVF40ApMglL50NIhvsmy8g8w?=
 =?iso-8859-1?Q?yGHH4g5m6tp9Fb2tLgKs/2/S6U6sY+7hJTMp7yrVA+FAO/H17TrZLYUauj?=
 =?iso-8859-1?Q?+eWiGghY18XQpMLTLZ935ht20os9BLQlEU4hPIUGmYDdWPX8GxKrPY39b6?=
 =?iso-8859-1?Q?lKsjFMkqtawFUetg4xY2X68uINCz4v9/O+0wj654l5ofwCDamvUBwIgki5?=
 =?iso-8859-1?Q?9QQCA5dRwBMP9mavaUJD8/qORVHvqIXZMl37aus2gkfqT9LAGZNqHg9/Mo?=
 =?iso-8859-1?Q?zeTRUvYTe2qehC2+N88VNDQxgUxxfwag3Wyc/2sbpYmLEv5zOKtqawrbL+?=
 =?iso-8859-1?Q?kocp2MjqTvVEU7cl3oq/GWTyHPVnOu/SEsfHdy270ZUBoBCk90+S4H1QUT?=
 =?iso-8859-1?Q?w0Nh/iqQtP4xvz08CtX7Ka4tR1+jQv1nXndSIlFp4DFUNGTxKF9QRWzf5p?=
 =?iso-8859-1?Q?zq6AuBAoJHCo1KggDjroh688rM56bW5QQ/yMdDla9dzDeRmooNBu0LYesb?=
 =?iso-8859-1?Q?QvPxg6+5SNrDtbWjW38cupamjloCtmJdvO3ZEwbQ/L3yM1hdqQI7KLbicd?=
 =?iso-8859-1?Q?uV5OQCIVWWVNiFXaKRXlTNP7MdC2iRia/z0v52XlqFYJ2F8yyxWvrm2Dho?=
 =?iso-8859-1?Q?+JO2csiCyHPRz3Dv4SCkzzDRBJswr7loeJfZsUFkjaee2Upx+6XNb+xCDv?=
 =?iso-8859-1?Q?m/IFJ8KOfNvyFgPMXv0ozgwABjXmSjT9QQepvn+2GkRs4oQA3G03F5Q2Ku?=
 =?iso-8859-1?Q?ZhK/9Y5VolfLeEYIObyViBijtcplmxbyNmDQMPMeQFjyNp8QZwpiExD8dQ?=
 =?iso-8859-1?Q?0/BKKDNOHQJuZUoOGBl4dqULz0vtDiwCcbL/03EFSptoq3EYuT+QAhA/8+?=
 =?iso-8859-1?Q?KT29MdijYB84kJ/e3VmrLeLh2vBwBJkB1b2dr+6EUgK6jmyIl45r13eiio?=
 =?iso-8859-1?Q?ZH6OCCfeuw5ZS/p0rGZ8Amhk5CXWW8qcQekl65kIR8OAVQdfl2zmFquT5m?=
 =?iso-8859-1?Q?aJxedr4qiLZkE5lom4sUo2rAtz7T3zLOxnF55EcaC2rLh6TbDpysmCrZ3U?=
 =?iso-8859-1?Q?+V27Yn53vLW8Xn9GZXN3wNgKlOyKlwHos1HQxtA4Tr8xCXBZWszYnmliL6?=
 =?iso-8859-1?Q?QeoeERSnh/dwzAgiCiJnGpzF7RENI9sfhexFSS80qZkYvBQMMSmsq+7kEW?=
 =?iso-8859-1?Q?VZEQVNyz16P1IXrki9HiKyoG6K55wZvv4d4GLmL/3a9QC8VxU88QBI18Ti?=
 =?iso-8859-1?Q?Fg1cwHPkzRUto=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b342c9-a907-4d29-9aaa-08dbadd9a4a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 06:30:48.4576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppVjhwQCHTQLxFM9ZDJnn757ke3xvOcUUeMbEx6hjcSqN+J8XRhnlIOtXfpJDVT8qfpYaeHi98unbgY/6KbBTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Mailman-Approved-At: Tue, 05 Sep 2023 10:32:24 -0400
Subject: [lttng-dev] LTTNG LIB UST Crash
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
From: Lakshmi Deverkonda via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Lakshmi Deverkonda <laksd@nvidia.com>
Content-Type: multipart/mixed; boundary="===============3970562429210643862=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3970562429210643862==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8AMW3PR12MB4555namp_"

--_000_MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8AMW3PR12MB4555namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

I am observing lttng crash while trying to interface LTTNG for one of my py=
thon3 application.
I just tried the following things,

Added "import lttngust " in the code.

# lttng create clagd
Session clagd created.
Traces will be written in /root/lttng-traces/clagd-20230905-062210

# lttng enable-event --python clagd
#lttng start

#service clagd start

cumulus-core: Running cl-support for core files "clagd-ust.95410.1693895062=
.core"

#0  0x00007f134fb938eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007f134fb7e535 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007f134fb7e40f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007f134fb8c1a2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.=
so.6
#4  0x00007f134f1a9677 in lttng_ust_add_fd_to_tracker () from /lib/x86_64-l=
inux-gnu/liblttng-ust.so.0
#5  0x00007f134f1bdcf4 in lttng_ust_elf_create () from /lib/x86_64-linux-gn=
u/liblttng-ust.so.0
#6  0x00007f134f1bf8de in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
0
#7  0x00007f134fc8f957 in dl_iterate_phdr () from /lib/x86_64-linux-gnu/lib=
c.so.6
#8  0x00007f134f1bff6b in lttng_ust_dl_update () from /lib/x86_64-linux-gnu=
/liblttng-ust.so.0
#9  0x00007f134f1c061a in do_lttng_ust_statedump () from /lib/x86_64-linux-=
gnu/liblttng-ust.so.0
#10 0x00007f134f1b5ca9 in lttng_handle_pending_statedump () from /lib/x86_6=
4-linux-gnu/liblttng-ust.so.0
#11 0x00007f134f1ab6d1 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
0
#12 0x00007f134f1ad7eb in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
0
#13 0x00007f134ff0dfa3 in start_thread () from /lib/x86_64-linux-gnu/libpth=
read.so.0
#14 0x00007f134fc5506f in clone () from /lib/x86_64-linux-gnu/libc.so.6


When I stop the lttng session, I see another core

#0  0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
[Current thread is 1 (Thread 0x7fad9331f700 (LWP 2221103))]
(gdb) bt
#0  0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007fad95183535 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007fad9518340f in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007fad951911a2 in __assert_fail () from /lib/x86_64-linux-gnu/libc.=
so.6
#4  0x00007fad947e8d9f in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
0
#5  0x00007fad947e98e3 in shm_object_table_destroy () from /lib/x86_64-linu=
x-gnu/liblttng-ust.so.0
#6  0x00007fad947e4d9a in channel_destroy () from /lib/x86_64-linux-gnu/lib=
lttng-ust.so.0
#7  0x00007fad947ba6b5 in lttng_session_destroy () from /lib/x86_64-linux-g=
nu/liblttng-ust.so.0
#8  0x00007fad947b47c6 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
0
#9  0x00007fad947b4bac in lttng_ust_objd_unref () from /lib/x86_64-linux-gn=
u/liblttng-ust.so.0
#10 0x00007fad947b4bac in lttng_ust_objd_unref () from /lib/x86_64-linux-gn=
u/liblttng-ust.so.0
#11 0x00007fad947b4bac in lttng_ust_objd_unref () from /lib/x86_64-linux-gn=
u/liblttng-ust.so.0
#12 0x00007fad947b5304 in lttng_ust_objd_table_owner_cleanup () from /lib/x=
86_64-linux-gnu/liblttng-ust.so.0
#13 0x00007fad947b2b75 in ?? () from /lib/x86_64-linux-gnu/liblttng-ust.so.=
0
#14 0x00007fad95512fa3 in start_thread () from /lib/x86_64-linux-gnu/libpth=
read.so.0
#15 0x00007fad9525a06f in clone () from /lib/x86_64-linux-gnu/libc.so.6


Can you please help here if I'm missing something. This is a critical task =
item for us but are currently stuck with multiple lttng crashes.

Regards,
Lakshmi

--_000_MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8AMW3PR12MB4555namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi All,&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I am observing lttng crash while trying to interface LTTNG for one of my py=
thon3 application.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I just tried the following things,&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
Added &quot;import lttngust &quot; in the code.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0 ContentPasted1">
</div>
# lttng create clagd
<div>Session clagd created.</div>
<div>Traces will be written in /root/lttng-traces/clagd-20230905-062210</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3">
# lttng enable-event --python clagd<br class=3D"ContentPasted2">
#lttng start<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4">
#service clagd start</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4">
<b><br>
</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4">
<div class=3D"ContentPasted5"><b>cumulus-core: Running cl-support for core =
files &quot;clagd-ust.95410.1693895062.core&quot;</b></div>
<div><br class=3D"ContentPasted5">
</div>
<div class=3D"ContentPasted6">#0 &nbsp;0x00007f134fb938eb in raise () from =
/lib/x86_64-linux-gnu/libc.so.6
<div class=3D"ContentPasted6">#1 &nbsp;0x00007f134fb7e535 in abort () from =
/lib/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted6">#2 &nbsp;0x00007f134fb7e40f in ?? () from /li=
b/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted6">#3 &nbsp;0x00007f134fb8c1a2 in __assert_fail =
() from /lib/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted6">#4 &nbsp;0x00007f134f1a9677 in lttng_ust_add_=
fd_to_tracker () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#5 &nbsp;0x00007f134f1bdcf4 in lttng_ust_elf_=
create () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#6 &nbsp;0x00007f134f1bf8de in ?? () from /li=
b/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#7 &nbsp;0x00007f134fc8f957 in dl_iterate_phd=
r () from /lib/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted6">#8 &nbsp;0x00007f134f1bff6b in lttng_ust_dl_u=
pdate () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#9 &nbsp;0x00007f134f1c061a in do_lttng_ust_s=
tatedump () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#10 0x00007f134f1b5ca9 in lttng_handle_pendin=
g_statedump () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#11 0x00007f134f1ab6d1 in ?? () from /lib/x86=
_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#12 0x00007f134f1ad7eb in ?? () from /lib/x86=
_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted6">#13 0x00007f134ff0dfa3 in start_thread () fro=
m /lib/x86_64-linux-gnu/libpthread.so.0</div>
<div class=3D"ContentPasted6">#14 0x00007f134fc5506f in clone () from /lib/=
x86_64-linux-gnu/libc.so.6</div>
<br>
</div>
<div class=3D"ContentPasted6"><br>
</div>
When I stop the lttng session, I see another core&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4 ContentPas=
ted7">
#0 &nbsp;0x00007fad951988eb in raise () from /lib/x86_64-linux-gnu/libc.so.=
6
<div class=3D"ContentPasted7">[Current thread is 1 (Thread 0x7fad9331f700 (=
LWP 2221103))]</div>
<div class=3D"ContentPasted7">(gdb) bt</div>
<div class=3D"ContentPasted7">#0 &nbsp;0x00007fad951988eb in raise () from =
/lib/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted7">#1 &nbsp;0x00007fad95183535 in abort () from =
/lib/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted7">#2 &nbsp;0x00007fad9518340f in ?? () from /li=
b/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted7">#3 &nbsp;0x00007fad951911a2 in __assert_fail =
() from /lib/x86_64-linux-gnu/libc.so.6</div>
<div class=3D"ContentPasted7">#4 &nbsp;0x00007fad947e8d9f in ?? () from /li=
b/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#5 &nbsp;0x00007fad947e98e3 in shm_object_tab=
le_destroy () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#6 &nbsp;0x00007fad947e4d9a in channel_destro=
y () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#7 &nbsp;0x00007fad947ba6b5 in lttng_session_=
destroy () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#8 &nbsp;0x00007fad947b47c6 in ?? () from /li=
b/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#9 &nbsp;0x00007fad947b4bac in lttng_ust_objd=
_unref () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#10 0x00007fad947b4bac in lttng_ust_objd_unre=
f () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#11 0x00007fad947b4bac in lttng_ust_objd_unre=
f () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#12 0x00007fad947b5304 in lttng_ust_objd_tabl=
e_owner_cleanup () from /lib/x86_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#13 0x00007fad947b2b75 in ?? () from /lib/x86=
_64-linux-gnu/liblttng-ust.so.0</div>
<div class=3D"ContentPasted7">#14 0x00007fad95512fa3 in start_thread () fro=
m /lib/x86_64-linux-gnu/libpthread.so.0</div>
<div class=3D"ContentPasted7">#15 0x00007fad9525a06f in clone () from /lib/=
x86_64-linux-gnu/libc.so.6</div>
<div><br class=3D"ContentPasted7">
</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4 ContentPas=
ted7">
Can you please help here if I'm missing something. This is a critical task =
item for us but are currently stuck with multiple lttng crashes.&nbsp;</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4 ContentPas=
ted7">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4 ContentPas=
ted7">
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted2 ContentPasted3 ContentPasted4 ContentPas=
ted7">
Lakshmi</div>
</body>
</html>

--_000_MW3PR12MB4555EFAAF7F86C5EFA8DB849D9E8AMW3PR12MB4555namp_--

--===============3970562429210643862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3970562429210643862==--
