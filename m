Return-Path: <SRS0=QQXA=KQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26467C433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 21 May 2021 10:14:11 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CD4613CB
	for <lttng-dev@archiver.kernel.org>; Fri, 21 May 2021 10:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CD4613CB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmjBR25cHz1sLj;
	Fri, 21 May 2021 06:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621592048;
	bh=akdT5GbonKPzOtqTxqM/8zDReTYCxQMa3DddpbZovcI=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=sdqSqMzbrG0UqxOH/Jf07aUgbTkALM51tMRcoM07YzqcdBjDETKxB/NzzekVb5QFl
	 HQsFNLOc+ItMg4oV2LfJxRwbvyp5zEMWDZxnVTHtoI1xIkYo5tC1COUbIhKx9WfvWl
	 9g1JKw6lumKzoVJxTm47hdQLEMxLIfCcjFYiXQ/8Z9/Tz7NU10pfO8eqiDMB9mxIXC
	 fbjcxtsLPZ6ewfbheNE368YxxJ/3Mw+biV/wZxeTdkOXdt+BO345/iNYJleZwtwMaJ
	 qenpOyzytHpn7uCj6o0MYuH0/TsCmrzbQd0qyt/oSzjROTJFMIF27jrxDLsFrP9nHD
	 QMaxCXgfuIBGQ==
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-eopbgr120052.outbound.protection.outlook.com [40.107.12.52])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmjB85BhNz1sGG
 for <lttng-dev@lists.lttng.org>; Fri, 21 May 2021 06:13:50 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHlr1Z5l200ej7mKaTkHqXGeBIYr79Exhk+w+GS7TXoOXDE3dsOApDsxT6b8PfT9ZJgd5VW/EPunbaCPPK5sj96MN76qEUQmdfaOhv8b/toqz8KESgR9IIbRjPXG2Pxw1WVCcqOb/upzYMm+agTZyPYyABKaILptVwC2Axms8ACyt+zYnTdcGrFRgjeEmDcLYCDQNt9aJBFFwowwJs/XDj/+4RStCNARwjWGf8ll03ez5fuW+BczAwgE6SDrt2iy/+yzlCVF22QKFcgAq1Y8BToMFZA1CSu0552+WTwsvbV54GoIL2Ody1b8sjaIqwpnQsugx20biOetdTuc01C8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Qse0W1KsE2+PGadLppqyoEZpl+Hl246dbQu1CDuMU=;
 b=Fi2VlKDKRhZ2z1KCQVe7mU3g5nOn7uMvxoZ65lE1JjgB0czhUvIHhZFg2pwyzXN0E1J0g9Dkl4YerfPlZYB3Jb+81mowfuLAb1dgFuwATsjXW+2OZmugQCMAx2qGfmCj36tEEp2c2KOh6Am6d3NEAWjdN2eZoCVlOnEyG8cRPSMjCo+GabUnmu9oV8OpIMz7CslBDKzs28KP+ejAmPP+GovM5viM/HRAANiAEcnz7H/iGddomli9ZoYaJJeoRS/GpB7YZ/HbEeh6xLgw3N0qQXb4Il3P3mI2KqxXXhG8nJa1SgODbtKpuAScloyNP5b6TL4Rw8yJMO3Aq5bHtymMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR1PR02MB4889.eurprd02.prod.outlook.com (2603:10a6:102:3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 10:13:40 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::8934:f375:de69:b87]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::8934:f375:de69:b87%4]) with mapi id 15.20.4150.025; Fri, 21 May 2021
 10:13:40 +0000
To: Norbert Lange <nolange79@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>
Thread-Topic: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
Thread-Index: AQHXTK3+V6xPgg5JGUSEQZtxbA1QkarsCL+AgAAAvjmAAA1lgIAATxYAgAAAogCAABQxAIAACH4AgAEmx5k=
Date: Fri, 21 May 2021 10:13:40 +0000
Message-ID: <PR3PR02MB6202E077AEC8C62B022780EED1299@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB6202C5373D6CECC72EBF45DAD12B9@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <CADYdroOAiKwD_um-ONn=UfNQrOxjs0fM-7ozhUNc18jUQX9cQw@mail.gmail.com>
 <AM7PR02MB6194C2E06B14077092AA06A0D12A9@AM7PR02MB6194.eurprd02.prod.outlook.com>
 <CADYdroNm+rLkqXV3tjtQ94_PQM_mTiHvmx3JzJG5h2YHbRfguA@mail.gmail.com>
 <851697925.52293.1621518874455.JavaMail.zimbra@efficios.com>
 <201689209.52304.1621519010729.JavaMail.zimbra@efficios.com>
 <186729016.52398.1621523346736.JavaMail.zimbra@efficios.com>,
 <CADYdroOCUu7BWqMZ1CMa5mHSJB50V1aS+98sVfgXQRPdnJTyYg@mail.gmail.com>
In-Reply-To: <CADYdroOCUu7BWqMZ1CMa5mHSJB50V1aS+98sVfgXQRPdnJTyYg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.76.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22584e0b-1959-40cc-d596-08d91c411b39
x-ms-traffictypediagnostic: PR1PR02MB4889:
x-microsoft-antispam-prvs: <PR1PR02MB4889892CB9D497BCF6C3BC68D1299@PR1PR02MB4889.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJVCaZDAq0YzJBXopsytt1eXcYYhKpgWdiB/5HoIkg3LipwlVmderr2BAs8hTFUDFK/eSlw1eYdS9VIJ3jcpB2DqDqL9NFOHgT5Ub4DnNFO3/TTSd73htKgEYUMh8IIyi17OOnPoRgLJ4iti5WNz2fhtsoXhdJglu4VVtMj//pAos03xA78JgaFVrUaDbyJP7FicibZi4uv92Dm8r8YLmZrMwNeIBQsm0AwnP4dNFwV5yXvoskAwyCFuyCCDPCPmBiKCTC9OAliI84NPIWiDKKx9qlxAiS43GuhjiEb9dDESf9nd5/kgIrU0kj3Am/rdR/6ECubaQFYvK5Dm+CZJEEle703Ry5PKIyttG2/hxJE7IieJi2jLPUmQbPx5cIy7qzFfT/lN4oVl8ZUcKMB6sXu7VSbWS8tysBgDsrplveBm2gSVSaPiA6PutqQUSi4XppeR2z2S5mpjOAM9tYyEjNyA2EszLxVuroDUzO66rZHdvs9zJuGu5DW+v7QWvrvxz24cQ0NDY+zEdsj3NCKdpmWj8aar7pwNRnDd1CP3sOH239ivi/dtO0yfm9Dw0yGAQrLpFchu8KgwPEAi1kOjPZCZEvv1NShV5RRGAeUB7viesfcpc9UZ08kl3ekCnqXRSFetXOK9v/mAZmWNoOQfgr9OFc7h7ZIH51Zlv6v301MgbYPNkc6zB2FDIbUVo8DhIUjob5IpT+i0WRo4NpPbMMdv3d7IorMw8P8xjElF8S0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(83380400001)(9686003)(186003)(786003)(33656002)(55016002)(166002)(19627235002)(86362001)(508600001)(55236004)(53546011)(6506007)(45080400002)(26005)(38100700002)(7696005)(8676002)(71200400001)(966005)(110136005)(54906003)(19627405001)(52536014)(4326008)(2906002)(64756008)(66556008)(66476007)(66446008)(66946007)(8936002)(91956017)(76116006)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qK55MtgpQ2mfs7ChSNzrAFd7xDm0z7600meKWuBOBKNDr140Q5at3wEMow?=
 =?iso-8859-1?Q?La8dsXG68D63y5Hy9jit9XBNzXw9drew7/cYcqScJDuoNYivRrug6ACkAQ?=
 =?iso-8859-1?Q?Fruf5Qnch+pF+hU47E+GymztCTUQwLzWWyKwdMQqAh65y+9M7r+7xZzpjx?=
 =?iso-8859-1?Q?6fAfterawQILlszPMPpUQh4JTvusc2a27WYD6LMGp+n4qykqeFyh0V3lVO?=
 =?iso-8859-1?Q?bRjZmpnQI8vgDqxVhDqu1/srTqqzwIByMH+cJl9kwmGHPR+Dbk+NHCEkBp?=
 =?iso-8859-1?Q?3frdqygkQ3Jjaruoft06xCW7SgMz3s7Ny0H+gW+miL5tyEPyaX6nlrKfDV?=
 =?iso-8859-1?Q?sCCsM9+i1AXdS1VflWTUP9+418iIyhmdSvH206V0fjZwpryfgi9grePuKd?=
 =?iso-8859-1?Q?mII/tL+4YcmeHp1ZruHEVuq97HLwDg+13mJIbw9zLSWA2yVRRdrFhzntKi?=
 =?iso-8859-1?Q?1H0mpixb9iThDH9OmaQJfZelMcQX1LR2A8Jk9lXiBUd4QIs9q7h/sTPLRR?=
 =?iso-8859-1?Q?ATkKVwxV6fUywdzcbzDbyBmk2ufzpRku5CLox6hgQRbWwfoM3XfH6579jK?=
 =?iso-8859-1?Q?9ndBRfxc7pRr2W3/Us1Qj9VDQCdHBTeUeHIzwcgyHywNZyTJkYYn+l4+ni?=
 =?iso-8859-1?Q?Lh+4RNKREpPUY2KhVtJqyhhetFmCG5Lv5m+vpofEYx7L1bO3enqRaI79g0?=
 =?iso-8859-1?Q?DJFGxKSIlpnzeNw3Id3TwmssxlxtTJG+CKqrDfFLkwuRDCY6xokS/u133V?=
 =?iso-8859-1?Q?wSmBKBVjVtQoLN5mWQ0xrAuQN/asVUBKfVKC2HK4yBYqRxqdoahHN6o9Ge?=
 =?iso-8859-1?Q?AsguwpD06lr+zsS/sK4Lkt8vXO+0wyNm3aDfbvFIalOey7lHu+lnvvTpG4?=
 =?iso-8859-1?Q?0Z2Myb3b55wbuN07QBYRCaqbaoHHJFRGE+YieRqEHsFIwnWTKFFlIKry9q?=
 =?iso-8859-1?Q?Hk70qFJzwoauZkA7HR3zQIeco8BwpnV7Q6rpX93x57UtC15+/lqz2X376q?=
 =?iso-8859-1?Q?ozEderLoG02roOPozNQVIxotbBLPR+DuJZk177PgSu5tsftZclBtNVUAb7?=
 =?iso-8859-1?Q?JqbRCA98+6ATlw3O/va58sg1SOhlCxrV+Og/Xc/9e48KUw+wtKzHjc00UY?=
 =?iso-8859-1?Q?YckQseIskw7j8lN/RUR2k5HCM6T7/vvZOyWzwo/RunYrsIsfPoTvROuIxF?=
 =?iso-8859-1?Q?dyyL3/TakxGHTr8Bg+EBQcazTiOxgBKBbCLKbBwzfCJ/8Ii1ylkQWgLBKk?=
 =?iso-8859-1?Q?19n99525O7ZsMVz3Ii1k2NhoYCgz5CuyTj97YCgyWG85iBNhfwLvnHRFE0?=
 =?iso-8859-1?Q?jpVeGnWlfTczigU4G5Yjw9QNAqDmqJg2p/wQva6pWxsPiy0=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22584e0b-1959-40cc-d596-08d91c411b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 10:13:40.3459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gABO53y5kPFY78lIpAE8Ye3TTYC7z01cU6S9r6LNGxi2nWImXhrNSZ4YIEfwCI/DBDw6hADTNGFCaySU0tunclFXV/cVHrzS2fexjgExLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR02MB4889
Subject: Re: [lttng-dev] LTTng - Xenomai : different results between
 timestamp-lttng and rt_time_read()
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: MONTET Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: MONTET Julien <julien.montet@reseau.eseo.fr>
Content-Type: multipart/mixed; boundary="===============8524810146352299112=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8524810146352299112==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB6202E077AEC8C62B022780EED1299PR3PR02MB6202eurp_"

--_000_PR3PR02MB6202E077AEC8C62B022780EED1299PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Mathieu, Norbert and Jan,

Thank you for all of your explainations and the overview of the system.
No I didn't change the ipipe patch for the vDSO, I may try this.
If I have correctly understood, this patch prevents Cobalt from entering in=
 a deadlock when the kernel is using the vDSO and the program interrupts th=
e kernel at the same time. On which kernel does it word (aroubd 4.19) ?
I currently try to avoid kernel 5.4 because I remember I faced some boot is=
sues (but it is on another topic).

Here the issues i faced (drawn on TraceCompass). Are these the deadlocks we=
 are talking about ?
https://postimg.cc/BP4G3bF0 (on 11:02:56:380)
https://postimg.cc/q6wHvrcC

Regards,


________________________________
De : Norbert Lange <nolange79@gmail.com>
Envoy=E9 : jeudi 20 mai 2021 17:39
=C0 : Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc : MONTET Julien <julien.montet@reseau.eseo.fr>; lttng-dev <lttng-dev@lis=
ts.lttng.org>; Jan Kiszka <jan.kiszka@siemens.com>; Xenomai <xenomai@xenoma=
i.org>
Objet : Re: [lttng-dev] LTTng - Xenomai : different results between timesta=
mp-lttng and rt_time_read()

Am Do., 20. Mai 2021 um 17:09 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On May 20, 2021, at 9:56 AM, Mathieu Desnoyers mathieu.desnoyers@ef=
ficios.com wrote:
>
> > ----- On May 20, 2021, at 9:54 AM, lttng-dev lttng-dev@lists.lttng.org =
wrote:
> >
> >> ----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.lttng.org=
 wrote:
> >>
> >>> Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien
> >>> <julien.montet@reseau.eseo.fr>:
> >>>>
> >>>> Hi Norbert,
> >>>>
> >>>> Thank you for your answer !
> >>>>
> >>>> Yes, I am using a Xenomai cobalt - xenomai is 3.1
> >>>> cat /proc/xenomai/version =3D> 3.1
> >>>>
> >>>> After the installation, I tested "test tools" in /proc/xenomai/ and =
it worked
> >>>> nice.
> >>>
> >>> Just asked to make sure, thought the scripts usual add some -xeno tag
> >>> to the kernel version.
> >>>
> >>>> What do you mean by "it might deadlock really good" ?
> >>>
> >>> clock_gettime will either use a syscall (kills realtime always) or is
> >>> optimized via VDSO (which very likely is your case).
> >>>
> >>> What happens is that the kernel will take a spinlock, then write new
> >>> values, then releases the spinlock.
> >>> your program will aswell spin (but just to see if the spinlock is
> >>> free), read the values and interpolates them.
> >>>
> >>> But if your program interrupts the kernel while the kernel holds the
> >>> lock (all on the same cpu core), then it will spin forever and the
> >>> kernel will never execute.
> >>
> >> Just one clarification: the specific locking strategy used by the
> >> Linux kernel monotonic clock vDSO is a "seqlock", where the kernel
> >> sets a bit which keeps concurrent readers looping until they observe
> >
> > When I say "sets a bit", I actually mean "increment a sequence counter"=
,
> > and readers observe either odd or even state, thus knowing whether
> > they need to retry, and whether the value read before/after reading
> > the data structure changed.
>
> Looking again at the Linux kernel's kernel/time/vsyscall.c implementation
> of vdso_update_{begin,end}, I notice that interrupts are disabled across
> the entire update. So I understand that the Interrupt pipeline (I-pipe)
> interrupt gets delivered even when the kernel disables interrupts. Did
> you consider modifying the I-pipe kernel patch to change the vdso update =
so
> it updates the vdso from within an I-pipe virq handler ?

Yes, I did use an non-upstreamed patch for a while to get things in order:
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.xen=
omai.org%2Fpipermail%2Fxenomai%2F2018-December%2F040134.html&amp;data=3D04%=
7C01%7Cjulien.montet%40reseau.eseo.fr%7Cef0b71ac314f4ab2321f08d91ba57c9d%7C=
4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C637571219835495365%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C1000&amp;sdata=3DdOiRFzeKFQA%2B25R6aqrjL2ZJMkV5c782DSBGiHHoYZc%3D&amp;=
reserved=3D0

I would prefer just a NMI safe source that might jump back a bit, no matter=
 how.

> AFAIU this would allow Xenomai userspace to use the Linux kernel vDSO
> clock sources.

The Xenomai folks are trying to get their next-gen abstraction "dovetail" c=
loser
coupled to the kernel, AFAIR their will be VDSO support and
unification of the clock sources.

Still need to get stuff running today =3D)

Norbert

--_000_PR3PR02MB6202E077AEC8C62B022780EED1299PR3PR02MB6202eurp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hello Mathieu, Norbert and Jan,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thank you for all of your explainations and the overview of the system.</di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
No I didn't change the ipipe patch for the vDSO, I may try this.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
If I have correctly understood, this patch prevents Cobalt from entering in=
 a deadlock when the kernel is using the vDSO and the program interrupts th=
e kernel at the same time. On which kernel does it word (aroubd 4.19) ?</di=
v>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I currently try to avoid kernel 5.4 because I remember I faced some boot is=
sues (but it is on another topic).</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Here the issues i faced (drawn on TraceCompass). Are these the deadlocks we=
 are talking about ?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://postimg.cc/BP4G3bF0" id=3D"LPlnk">https://postimg.cc/BP4=
G3bF0</a>&nbsp;(on 11:02:56:380)</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview_1 _EReadonl=
y_1"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://postimg.cc/q6wHvrcC" id=3D"LPlnk">https://postimg.cc/q6w=
HvrcC</a><br>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p style=3D"margin-top: 0px; margin-bottom: 0px;"></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>De :</b> Norbert Lange &lt;nola=
nge79@gmail.com&gt;<br>
<b>Envoy=E9 :</b> jeudi 20 mai 2021 17:39<br>
<b>=C0 :</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Cc&nbsp;:</b> MONTET Julien &lt;julien.montet@reseau.eseo.fr&gt;; lttng-=
dev &lt;lttng-dev@lists.lttng.org&gt;; Jan Kiszka &lt;jan.kiszka@siemens.co=
m&gt;; Xenomai &lt;xenomai@xenomai.org&gt;<br>
<b>Objet :</b> Re: [lttng-dev] LTTng - Xenomai : different results between =
timestamp-lttng and rt_time_read()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am Do., 20. Mai 2021 um 17:09 Uhr schrieb Mathieu =
Desnoyers<br>
&lt;mathieu.desnoyers@efficios.com&gt;:<br>
&gt;<br>
&gt; ----- On May 20, 2021, at 9:56 AM, Mathieu Desnoyers mathieu.desnoyers=
@efficios.com wrote:<br>
&gt;<br>
&gt; &gt; ----- On May 20, 2021, at 9:54 AM, lttng-dev lttng-dev@lists.lttn=
g.org wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; ----- On May 20, 2021, at 5:11 AM, lttng-dev lttng-dev@lists.=
lttng.org wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Am Do., 20. Mai 2021 um 10:28 Uhr schrieb MONTET Julien<b=
r>
&gt; &gt;&gt;&gt; &lt;julien.montet@reseau.eseo.fr&gt;:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Hi Norbert,<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thank you for your answer !<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Yes, I am using a Xenomai cobalt - xenomai is 3.1<br>
&gt; &gt;&gt;&gt;&gt; cat /proc/xenomai/version =3D&gt; 3.1<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; After the installation, I tested &quot;test tools&quo=
t; in /proc/xenomai/ and it worked<br>
&gt; &gt;&gt;&gt;&gt; nice.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Just asked to make sure, thought the scripts usual add so=
me -xeno tag<br>
&gt; &gt;&gt;&gt; to the kernel version.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; What do you mean by &quot;it might deadlock really go=
od&quot; ?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; clock_gettime will either use a syscall (kills realtime a=
lways) or is<br>
&gt; &gt;&gt;&gt; optimized via VDSO (which very likely is your case).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; What happens is that the kernel will take a spinlock, the=
n write new<br>
&gt; &gt;&gt;&gt; values, then releases the spinlock.<br>
&gt; &gt;&gt;&gt; your program will aswell spin (but just to see if the spi=
nlock is<br>
&gt; &gt;&gt;&gt; free), read the values and interpolates them.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; But if your program interrupts the kernel while the kerne=
l holds the<br>
&gt; &gt;&gt;&gt; lock (all on the same cpu core), then it will spin foreve=
r and the<br>
&gt; &gt;&gt;&gt; kernel will never execute.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Just one clarification: the specific locking strategy used by=
 the<br>
&gt; &gt;&gt; Linux kernel monotonic clock vDSO is a &quot;seqlock&quot;, w=
here the kernel<br>
&gt; &gt;&gt; sets a bit which keeps concurrent readers looping until they =
observe<br>
&gt; &gt;<br>
&gt; &gt; When I say &quot;sets a bit&quot;, I actually mean &quot;incremen=
t a sequence counter&quot;,<br>
&gt; &gt; and readers observe either odd or even state, thus knowing whethe=
r<br>
&gt; &gt; they need to retry, and whether the value read before/after readi=
ng<br>
&gt; &gt; the data structure changed.<br>
&gt;<br>
&gt; Looking again at the Linux kernel's kernel/time/vsyscall.c implementat=
ion<br>
&gt; of vdso_update_{begin,end}, I notice that interrupts are disabled acro=
ss<br>
&gt; the entire update. So I understand that the Interrupt pipeline (I-pipe=
)<br>
&gt; interrupt gets delivered even when the kernel disables interrupts. Did=
<br>
&gt; you consider modifying the I-pipe kernel patch to change the vdso upda=
te so<br>
&gt; it updates the vdso from within an I-pipe virq handler ?<br>
<br>
Yes, I did use an non-upstreamed patch for a while to get things in order:<=
br>
<a href=3D"https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fwww.xenomai.org%2Fpipermail%2Fxenomai%2F2018-December%2F040134.html&amp=
;amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo.fr%7Cef0b71ac314f4ab2321f=
08d91ba57c9d%7C4d7ad1591265437ab9f62946247d5bf9%7C0%7C0%7C63757121983549536=
5%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DdOiRFzeKFQA%2B25R6aqrjL2ZJMkV5c782=
DSBGiHHoYZc%3D&amp;amp;reserved=3D0">https://eur02.safelinks.protection.out=
look.com/?url=3Dhttps%3A%2F%2Fwww.xenomai.org%2Fpipermail%2Fxenomai%2F2018-=
December%2F040134.html&amp;amp;data=3D04%7C01%7Cjulien.montet%40reseau.eseo=
.fr%7Cef0b71ac314f4ab2321f08d91ba57c9d%7C4d7ad1591265437ab9f62946247d5bf9%7=
C0%7C0%7C637571219835495365%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DdOiRFzeK=
FQA%2B25R6aqrjL2ZJMkV5c782DSBGiHHoYZc%3D&amp;amp;reserved=3D0</a><br>
<br>
I would prefer just a NMI safe source that might jump back a bit, no matter=
 how.<br>
<br>
&gt; AFAIU this would allow Xenomai userspace to use the Linux kernel vDSO<=
br>
&gt; clock sources.<br>
<br>
The Xenomai folks are trying to get their next-gen abstraction &quot;doveta=
il&quot; closer<br>
coupled to the kernel, AFAIR their will be VDSO support and<br>
unification of the clock sources.<br>
<br>
Still need to get stuff running today =3D)<br>
<br>
Norbert<br>
</div>
</span></font></div>
</body>
</html>

--_000_PR3PR02MB6202E077AEC8C62B022780EED1299PR3PR02MB6202eurp_--

--===============8524810146352299112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8524810146352299112==--
