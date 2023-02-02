Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B78C636D3
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Feb 2023 23:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675379911;
	bh=03qWaGzSYLxYZd4rD2rNFsg5RDtVPq5I0b4Mt57eZ5U=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=J45nfXjqer5/N1GACX3HEBmlebDTAHbvcmlgX1ZgXOYSOeSNlsgBCMzeJNAz/N/HT
	 W/GAYQ9DIdtd0k9t7h+OlVrNeB9sy0vkro+ta4mObASb3BODPsdvBS6v7mQi2aPio+
	 /76xwGIdfnDcY3H+36+a1qSJkF4WvQ8xEeLWzPiGbmAC+HhcD1opVBONjAaW6FPXQX
	 G/7OsvLg3VOfpq8MdXnipPq9slmr0cUjg8ty/sbI0A/H1AEeFCfIv6Awo6+YntZ6Ey
	 KIh7GWZqk7ApyYoblfFkvJvvY/XS6DYHfGc/gMgZoN62Mo4YzxmUYcVAA9C+YZVd/P
	 km9mDJYy0Hreg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4P7F8R1Pf0z1Y6G;
	Thu,  2 Feb 2023 18:18:31 -0500 (EST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by lists.lttng.org (Postfix) with ESMTPS id 4P7F8P355dz1XyG
 for <lttng-dev@lists.lttng.org>; Thu,  2 Feb 2023 18:18:29 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vug1PgG5rSSxl42a/Oko6mIp3lt88knv4uPLqmP8SX49eDjixNnO2/IxzR+pwnXAhNMrCBAqhQB4GblDwlSo7QtE2BMczW+9+PR3eWwLrNcSmknDVMHTgMMYoD0NOM1fo66TjlP2CDgQJZ2Jkwj1oHCk7RMdG8fC2a7dS9Gm50vWKpB/WEHUIAFzD2GXbjhj04Ha1TkH3oWuTMWorOt3opb15oHgsxeBU2sWB1ZlSTRaG2Jau/cSyBKrLmZdbUwP+JnlS7NQhyPfCDHe7CjQDCQ3i7RTXl1XfpCmbNEC66HfI887lwvvNunbbL+/7cExOfcHMQm69z5xyfBA9Wjo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5LhN6DXYsgEsYBFBjEUBEBmRw0H/WwHrnyBD6OhUsQ=;
 b=CNMT45DiszkSJxSg50dsz3e0rW0jJ9fVbSnJwzQZy9SNdaXtYcGuJ9I1gVFLFWJdtPrat3VximZICKVXGSRonxwv+WsALSugw7eBMwwdVg2tQzzVy40+9+Pp2VgHoJpPVgJGukmcf2V0fxPlnANbJsKnlmoyzhDT+RhQ39IQpUJK9nzQvIFYxftiI+J89yfOo7oxr7VQlWUR8QHC9IisisFAMijBYm7V58hMwbSHsNX/8K2nOPjKpwtbcrm+kNIaJkCY8Dtk5wMZzpOBzDzUsTjD2ImCsr1Y4EKx3hLIPRrDQOm+/6GzG+zx9pKiHFJWxFtkoAv0bUlLMux2f28fWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB9505.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 23:18:13 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::157d:652e:dcc8:1d01]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::157d:652e:dcc8:1d01%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:18:13 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "chafraysse@free.fr"
 <chafraysse@free.fr>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] LTTng UST structure support
Thread-Index: AQHZJDttVP/TZI0+4USL3qyzEYzfV66bO3+AgAWYnQCAGyQggIAAbSDi
Date: Thu, 2 Feb 2023 23:18:13 +0000
Message-ID: <YT2PR01MB5984548C6294278120154FDEBCD69@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <1512260626.80256142.1673861908243.JavaMail.root@zimbra43-e7.priv.proxad.net>
 <233483636.139091746.1675354007888.JavaMail.root@zimbra43-e7.priv.proxad.net>
In-Reply-To: <233483636.139091746.1675354007888.JavaMail.root@zimbra43-e7.priv.proxad.net>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YT3PR01MB9505:EE_
x-ms-office365-filtering-correlation-id: 26cc5c30-33df-49e2-4881-08db0573c1c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J93TEOSoLzruVLao7MqcYgBnqQNfXf0O1HUsMO0B3JBz5SXv50uUTY0+8M+UWdjJJ7AoGSu4AiIBn1sSIEsj7ikBr+dB801XERfEth6GA+Gq6uNOng9fGMXWa67nsIL7SpXOTt7/4+AfsYPzxtckY6jkgC+nTSo5Cb+OlwwTpMURUQtbOan+t2Fx1oIJ1wIpz5QiUzu6LcL9ypejXw79TdTnmXnAYEdrc5s8tX278ROdtsQgDDnHShrvCZ9/p4acfvfj3S/YXgZco15NuBTvHYo2MSxM+g2SI41y7hferr6EntoWsc2x2arfTEK3iRAC6FhEb1QlaeyRW2jZIwkMKPdhJMnYlVBvIF+AGqtBalfRGQ8MUPsz6/yZauxFy0lMVccnPYpf/rcGgsl+Cddy9FbnKSrcCsxe/uTHw93+frGj/GXIfYteW8lPkVxiLH97b5pUU/3xHy4bDgRit0356yHbEySGs+Hy+5RDh9GH5gysc2PyGwq7ciqKC8nd6F1VVo8nv+hMWng0bMbA+4KUw5HW/GRV46B+qBZQtI54Xi0IF/qOA+0EaV7UrXR39dMfMoa97PbwS6lHqbEnRyHZwvZ3hxnGFF4YZmxMT6qeX5q4WbfhqHZBhwoCPsolUkbT5gfpulhcwt91yNuNLYyuKCbT9Upu7lsx3vY7xFoaGQYW4WJJqmGNAwxzN12Wg2nhCs2f8OcjqWh9KK3P4+D2qRJPdXV57qRXbwLmqwT2W2pgG8iI5HOPWH9C3Z04wFJ3rMU010mkSKUwm5uwB+uaKC7QG+SA7souIFS/bMCEjry/XmbcmzxbotVXEfFgNVJUS+8jC1AjN3W71TJ1u8JeWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(366004)(136003)(396003)(39830400003)(376002)(346002)(451199018)(19627405001)(2906002)(478600001)(91956017)(66574015)(966005)(9686003)(76116006)(186003)(71200400001)(53546011)(26005)(52536014)(8936002)(38070700005)(7696005)(5660300002)(86362001)(41300700001)(55016003)(66476007)(66446008)(83380400001)(66556008)(8676002)(4326008)(38100700002)(64756008)(122000001)(66946007)(6506007)(33656002)(316002)(166002)(110136005)(41080700001)(15866825006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UzyQ8xB47Vlic3ZKdIs9EXixe624Ddb30Q8Ayq2Am5XdA1jwI4UzRQsmc6?=
 =?iso-8859-1?Q?CYSqmu5ovvlYlCyFjmZEEGxZMYw9R5TS6I4qDG+fY25yv6cxNzoiK9nAZL?=
 =?iso-8859-1?Q?NbrtsgqGj5Fg2g8a18ahe9oIOiz8Bqs/ofoOZAtlv9+ZTZMszk5LRhw1d+?=
 =?iso-8859-1?Q?+/vCBPydSPT9esjbl3iv3NvnMJE4EBktVSR67cPXyAjmUdZvp3kb5WTbw2?=
 =?iso-8859-1?Q?wY2vGy2kBZGGLqhRxOdprklR6JSw/Y6kTZn8+iOdsEsPva+0BIKn+YV9+G?=
 =?iso-8859-1?Q?9OMdtSVUyz7nG6sOFF6Sik8K3yxG9GEPRNj8SJmC3/GKNGtGj/PXNOcC5L?=
 =?iso-8859-1?Q?GUl9/uVsr4Qo+d30aBLzSLX77sBUpMXcrpHJXMW0W6Dof9Wr9wLerUsaNI?=
 =?iso-8859-1?Q?FsdGtC/pJ4OB4Z9AQZTVqIAsJhk1hsr17+lEvlheAXtNGOsELj3Wh9B/DH?=
 =?iso-8859-1?Q?7nWFx7+8eOoQi4DcPLMEtnWNfyGb/PbQCashL/8E0KTvVunU6GcWL0ce7w?=
 =?iso-8859-1?Q?I7/+VVA0E8zEwr5ikvQePCYRbz9q56oFYixbirh2FmRRhmLiGQMz5IEsSG?=
 =?iso-8859-1?Q?PrRPmCzQefvI2AbopbDM3r9pIdT2KbFLrXMHwrXemK3r3+xkOl5g/b/cmY?=
 =?iso-8859-1?Q?T7gJb+7DF5vTWSBnZj6LS3AIIcCuopCmQnyXOAwI4uMmZ1pfVjBb55xNtQ?=
 =?iso-8859-1?Q?DN3++bclF6CsHEcL2DGWJVB2c2enYV9lZ1St8IyrTAjYvYmmOY/LLz+Bjq?=
 =?iso-8859-1?Q?6uTkrsHpGBdlBX5MgnQdJf2VWFBySMKNJbBO+Gy7fw+EYv0GpkKiOR6MGc?=
 =?iso-8859-1?Q?hpmeYs+UQOmYJ+iNlKJgnYnn0wFMptHvPskXX1xY9X3E26+BetKtdCPotI?=
 =?iso-8859-1?Q?bdQXetMtgho03L6mSwqAyDeZBl675tPfnJEI+q7P4UPgv5PM8ov2wam58m?=
 =?iso-8859-1?Q?gMjASIWtDD7h+4cnfPr56Ud6LWUPxVSZGTK3vt9rnUucew+gzPm3LhbVee?=
 =?iso-8859-1?Q?XzC3V1wui0E4fNtbcKd+QH4R/7Aw3nCxZUcMGeDS3WqP/+a24Jdc9nU+xb?=
 =?iso-8859-1?Q?4jnCobx8GkAJtDSq5zPzIcvBTIONJqnRKwWEZScZF7W0lVu3/22IAPjvnK?=
 =?iso-8859-1?Q?ZKvNz5U1/rKWyvayhUBbeykjAKaLG86ORzmbptnzQC6ZxwNleV+397viaF?=
 =?iso-8859-1?Q?0MJro3ZzLQQy16nk2gYr7GU4tMpubyWN83TPFVZDwcUulAAX+K29fli05d?=
 =?iso-8859-1?Q?BCchdfx4rmcX+w+47jDQQMbXKYU86By2T1qPwB37muwu6OyqJwNllt4MuI?=
 =?iso-8859-1?Q?2c/WJjaA2oyVEjviFmidx2OO+pqW7XG1ktzmGkg4BLDoaTD25k7DARatGq?=
 =?iso-8859-1?Q?h0dl5rcLgpD5fvjrjCMIHm5Xj/s2jkhLSgOqNP8r5+dYaFyvMcwjnARAsk?=
 =?iso-8859-1?Q?2I7091nr7pjpMvGWqTi1OjEo+xCyY4jBYyk9zzJuWlBhlz4JUSBKUlP1sR?=
 =?iso-8859-1?Q?PNc7H0/DFmoeXHZqCHvf/ZwHSTeka2/AkZGG2kqgGpVAHHKRBPJYMLoTja?=
 =?iso-8859-1?Q?ugfC9+s+44aaYqyrR/2EHky4s077Q8Fq8F/yk8gbstHA5IDsFcR3c5yDKU?=
 =?iso-8859-1?Q?6ofwgiOQ/2fbgDZzmsJ7w29QCSE8rmQler?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cc5c30-33df-49e2-4881-08db0573c1c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 23:18:13.2273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDxalYjGFScrmTW1GjIOItrSCtD6HFCKcHTqBNwP+ScU3DD1nwcglyqWOxR61gbooHvV1uTSxYCBcBQC2jGaTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9505
Subject: Re: [lttng-dev] LTTng UST structure support
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
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jgalar@efficios.com>
Content-Type: multipart/mixed; boundary="===============8168235115965073830=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8168235115965073830==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB5984548C6294278120154FDEBCD69YT2PR01MB5984CANP_"

--_000_YT2PR01MB5984548C6294278120154FDEBCD69YT2PR01MB5984CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Charles,

I can't really comment on what the packages do, but babeltrace2 provides th=
ose headers under "include/babeltrace2-ctf-writer" since that library is so=
mewhat "grafted" to the project. Which distro are you using?

As for where to "plug" your bindings, that library is there to maintain com=
patibility with the ctf-writer library that was provided by Babeltrace 1.x =
as it had a number of external users. I don't expect it to keep up with new=
 CTF versions.

A more "future proof" integration point is to write a source component, and=
 instanciate it in a graph configured with the CTF filesystem sink, and fee=
d your events through the graph.

Let me know if you want more information,
J=E9r=E9mie

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com

________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of chafraysse=
--- via lttng-dev <lttng-dev@lists.lttng.org>
Sent: February 2, 2023 11:06
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] LTTng UST structure support

Hi,

So I wrote a draft of Rust lib above ctf-writer, using the apis as demonstr=
ated in the ctf-writer test
For deployment I wanted to use "libbabeltrace2-ctf-writer.so" in the "libba=
beltrace2-dev" package but I could not locate the matching includes in ther=
e or in the other babeltrace 2 packages
Did I miss them somewhere ? Should I have plugged in at another level in ba=
beltrace2 ?

Best regards,

Charles

----- Mail original -----
De: chafraysse@free.fr
=C0: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Envoy=E9: Lundi 16 Janvier 2023 10:38:28
Objet: Re: [lttng-dev] LTTng UST structure support

Hi Mathieu,

Thanks for your reply :)
I'll stick to bt2 modules in the meantime then
I'll already be saving a ton of time with those and the CTF spec which is g=
reat !

Best regards,

Charles

----- Mail original -----
De: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
=C0: chafraysse@free.fr, lttng-dev@lists.lttng.org
Envoy=E9: Jeudi 12 Janvier 2023 21:10:57
Objet: Re: [lttng-dev] LTTng UST structure support

On 2023-01-09 09:02, chafraysse--- via lttng-dev wrote:
> Hi,
>
> I'm looking for a CTF writer to serialize instrumentations in an
> embedded Linux/Rust framework
> LTTng UST looked like a very strong option, but I want to serialize
> structures as CTF compound type structures and I did not see those
> supported in the doc or api

This is correct. I am currently working on a new project called
"libside" (see https://git.efficios.com/?p=3Dlibside.git;a=3Dsummary) which
features support for compound types.

However, we still need to do the heavy-lifting implementation work of
integrating this with LTTng-UST. This is the plan towards supporting
compound types in LTTng-UST.

> I'd love to have confirmation that I did not just miss something :)
> If LTTng UST is out for me I will probably try to use the ctf-writer
> module of babeltrace 2 instead

For now the ctf-writer modules of bt2 would be an alternative to
consider, but remember that it is not designed for low-impact tracing
such as lttng-ust. So it depends on how much tracer overhead/runtime
impact you can afford in your use-case.

Thanks,

Mathieu

>
> Best regards,
>
> Charles
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_000_YT2PR01MB5984548C6294278120154FDEBCD69YT2PR01MB5984CANP_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Hi Charles,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
I can't really comment on what the packages do, but babeltrace2 provides th=
ose headers under &quot;include/babeltrace2-ctf-writer&quot; since that lib=
rary is somewhat &quot;grafted&quot; to the project. Which distro are you u=
sing?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<span class=3D"ContentPasted0" style=3D"font-size:12pt;margin:0px;backgroun=
d-color:rgb(255, 255, 255)"><span style=3D"margin:0px" class=3D"ContentPast=
ed1">As for where to &quot;plug&quot; your bindings, that library is there&=
nbsp;<span class=3D"ContentPasted0" style=3D"font-size:12pt;margin:0px;back=
ground-color:rgb(255, 255, 255)"></span></span></span>to
 maintain compatibility with the ctf-writer library that was provided by Ba=
beltrace 1.x as it had a number of external users. I don't expect it to kee=
p up with new CTF versions.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<span class=3D"ContentPasted0" style=3D"font-size:12pt;margin:0px;backgroun=
d-color:rgb(255, 255, 255)"><span style=3D"margin:0px" class=3D"ContentPast=
ed1"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<span class=3D"ContentPasted0" style=3D"font-size:12pt;margin:0px;backgroun=
d-color:rgb(255, 255, 255)"><span style=3D"margin:0px" class=3D"ContentPast=
ed1">A more &quot;future proof&quot; integration point is to write a source=
 component, and instanciate it in a graph configured
 with the CTF filesystem sink, and feed your events through the graph.</spa=
n></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<span class=3D"ContentPasted0" style=3D"font-size:12pt;margin:0px;backgroun=
d-color:rgb(255, 255, 255)"><span style=3D"margin:0px" class=3D"ContentPast=
ed1"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<span class=3D"ContentPasted0" style=3D"font-size:12pt;margin:0px;backgroun=
d-color:rgb(255, 255, 255)"><span style=3D"margin:0px" class=3D"ContentPast=
ed1">Let me know&nbsp;if you want more&nbsp;information,</span></span></div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
J=E9r=E9mie</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<div style=3D"margin:0px"><span style=3D"font-size:12pt;margin:0px"></span>=
</div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div class=3D"elementToProof">
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
J=E9r=E9mie Galarneau</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>EfficiOS Inc.</div>
<a href=3D"https://www.efficios.com" data-loopstyle=3D"link">https://www.ef=
ficios.com</a><br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of chafraysse--- via lttng-dev &lt=
;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> February 2, 2023 11:06<br>
<b>To:</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Cc:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] LTTng UST structure support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">Hi,<br>
<br>
So I wrote a draft of Rust lib above ctf-writer, using the apis as demonstr=
ated in the ctf-writer test<br>
For deployment I wanted to use &quot;libbabeltrace2-ctf-writer.so&quot; in =
the &quot;libbabeltrace2-dev&quot; package but I could not locate the match=
ing includes in there or in the other babeltrace 2 packages<br>
Did I miss them somewhere ? Should I have plugged in at another level in ba=
beltrace2 ?<br>
<br>
Best regards,<br>
<br>
Charles<br>
<br>
----- Mail original -----<br>
De: chafraysse@free.fr<br>
=C0: &quot;Mathieu Desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&gt;<b=
r>
Cc: lttng-dev@lists.lttng.org<br>
Envoy=E9: Lundi 16 Janvier 2023 10:38:28<br>
Objet: Re: [lttng-dev] LTTng UST structure support<br>
<br>
Hi Mathieu,<br>
<br>
Thanks for your reply :)<br>
I'll stick to bt2 modules in the meantime then<br>
I'll already be saving a ton of time with those and the CTF spec which is g=
reat !<br>
<br>
Best regards,<br>
<br>
Charles<br>
<br>
----- Mail original -----<br>
De: &quot;Mathieu Desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&gt;<br=
>
=C0: chafraysse@free.fr, lttng-dev@lists.lttng.org<br>
Envoy=E9: Jeudi 12 Janvier 2023 21:10:57<br>
Objet: Re: [lttng-dev] LTTng UST structure support<br>
<br>
On 2023-01-09 09:02, chafraysse--- via lttng-dev wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I'm looking for a CTF writer to serialize instrumentations in an <br>
&gt; embedded Linux/Rust framework<br>
&gt; LTTng UST looked like a very strong option, but I want to serialize <b=
r>
&gt; structures as CTF compound type structures and I did not see those <br=
>
&gt; supported in the doc or api<br>
<br>
This is correct. I am currently working on a new project called <br>
&quot;libside&quot; (see <a href=3D"https://git.efficios.com/?p=3Dlibside.g=
it;a=3Dsummary)" data-auth=3D"NotApplicable">
https://git.efficios.com/?p=3Dlibside.git;a=3Dsummary)</a> which <br>
features support for compound types.<br>
<br>
However, we still need to do the heavy-lifting implementation work of <br>
integrating this with LTTng-UST. This is the plan towards supporting <br>
compound types in LTTng-UST.<br>
<br>
&gt; I'd love to have confirmation that I did not just miss something :)<br=
>
&gt; If LTTng UST is out for me I will probably try to use the ctf-writer <=
br>
&gt; module of babeltrace 2 instead<br>
<br>
For now the ctf-writer modules of bt2 would be an alternative to <br>
consider, but remember that it is not designed for low-impact tracing <br>
such as lttng-ust. So it depends on how much tracer overhead/runtime <br>
impact you can afford in your use-case.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Best regards,<br>
&gt; <br>
&gt; Charles<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 data-auth=3D"NotApplicable">
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"https://www.efficios.com" data-auth=3D"NotApplicable" data-loops=
tyle=3D"link">https://www.efficios.com</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" data=
-auth=3D"NotApplicable">https://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_YT2PR01MB5984548C6294278120154FDEBCD69YT2PR01MB5984CANP_--

--===============8168235115965073830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8168235115965073830==--
