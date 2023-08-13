Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73793C04A6A
	for <lttng-dev@archiver.kernel.org>; Mon, 14 Aug 2023 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692022874;
	bh=s7jwWtWAJW0M0nZUPyu+nXueDZP9s0HVk5VaVSgzmwM=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Ma7BQNBylMSNvFL2LaaV2v025smXpmUkEI9KwxqRCu5y/w0VCwusr3Kfh9gqJjR5g
	 k9PLDWmzIUooaTnGXzbBeSwq4Atd4YS0SYYsrwUkIlwPr6ezztrLfUW/g6ezGGgsps
	 iY71E6IopFwWAJry+1dKvZlNt5zNIQhxkz1RAa6GzIli5x6BwToPWVUM0trOYwxaFW
	 20zG4HdbREHDh47E1Q+GXzA6gxf8Vt3E3JwwYz2/MvdGwfM2mJr3kaoM0JtGNnDS+C
	 z9qAqatGe17f/Ph3ewYrj8bR2Kyz1irFrrY9b5Yy5PcT6RPruTu3cqCWbkZpQaOIDH
	 ZB48ZvOzV2RBw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RPc5Q2WtZz2M1Y;
	Mon, 14 Aug 2023 10:21:14 -0400 (EDT)
Received: from IND01-MAX-obe.outbound.protection.outlook.com
 (mail-maxind01on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700f::60f])
 by lists.lttng.org (Postfix) with ESMTPS id 4RP4QP3GcDz2LNy
 for <lttng-dev@lists.lttng.org>; Sun, 13 Aug 2023 13:34:05 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXTiwqWjExFd+R25kd5/oV7hoiS+1F4G2gP8rS5LhSXzAAZAk9N7DqWKA7yoZlmlpYOABqdUfet474vtrI/Jh2MMcLQcRFK5W9QYMnIvqPL8tQtoQCih2O1GGQn6Kj96fQdIybx/5O6nbnmzPKgrf2qk3B407xjXlsq/rSpvxhC20cO2LDHYIHRan8ngeUtFYvkKiolrag/jLxYnltMchfXLGVM+ufYGFvkm7vu7olcl2wLj8A3ouhyYoV6Ae/0BvKK+sXxIzZxH9LohoGHBJRyEAXcNibRvpkkKmYm10ld2iLcH6tP0oCf5JhBVWVn65/Xkjq7xNjqLK/9jwKNvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4u/XsQjplTOk/JkTjDP82ayMhHTw+jsMoNVu/bZXu4=;
 b=mgzcLzPFYOvHYVUUavId0770LIKOx4O3X0bg50YKBCavCqHVDBh4eBHdpuXVe/m73Tazf7tnYlg9u9eARxRTuXZGNx87hmN0sQbxROLhZxApZZV+xKaNm/Li1CNjGiAocsj3YIXUr5FCw+X9dqGcxR1sEp63w74Ga6GISxKD/nvUi20aPYmOieQrJ/2rrWVHOhawXEzOmZQkkZE3vFa1XCQT68Bvk2LTvd1oe6x9dvQ/q5qi8QiLkfDuMoPfY7n9FeZqxeYw0kuzltxNFg6FxQdcg6H9KKlBoUGKZSH5Ddg0CldRGqmKUrmKuyyRL7o3VFOkztCmBPatP/glDhdYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kpit.com; dmarc=pass action=none header.from=kpit.com;
 dkim=pass header.d=kpit.com; arc=none
Received: from MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1f::9)
 by MA0PR01MB5532.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 14:58:18 +0000
Received: from MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5d7:959e:5cdc:e85e]) by MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5d7:959e:5cdc:e85e%7]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 14:58:17 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Discarded events 
Thread-Index: AQHZzfPb//jmQayBCkyDMxfjLjDs6Q==
Date: Sun, 13 Aug 2023 14:58:17 +0000
Message-ID: <MA0PR01MB6987563FB945A5A4C90312EE8516A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB6987:EE_|MA0PR01MB5532:EE_
x-ms-office365-filtering-correlation-id: 6a392f5e-a640-4826-4120-08db9c0db9fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJJZ8YPoc6dJVazNw8wpuszcz9I8uhBBdcuaUrDVMNbwcgVqSQHC3GsuqM4znAGVhQtESS+sw6peYex4Ot+aW2FnJoj4DjXBSkIU77OgRynUxP3aBIuNimdNy6Lpu6mgSKDWwe1wO9XUcq6RedzQft5AZOcu7plwae7l1BGX7erbxwKThDWYwJARSSAJkmc4GnDaBM+f3ivM7iyoGXkDiYbPPvGpdQBsJYy85Fdr8buxLZxmQ3ouuGK7+7W24Anrtk8rLyoiblvsvxm57Z0OsAEsDtbDu6ScmTDQ1x/yAQ+3LT++6+U/bdE3sCO6LYRP8KNsUKIppqz18JatqwMY7xdKSJm7MvDsuR7iGbLTpnl5yhBj0NFF9efRbgeyVvu79nFgCbyAQPsG552Fed4IqBSnN/z5zfoiZEPlXM6Q/oo7wMh1G0Iinnh1BZ5gqBLGlp1HEq5g815MZTkGtxZUR/7XxUAadIJh+CfjSZZ8wPinc54lDrCU/VZiC5PKgFhNHdbHQydaKqDT9Ug5hOWryb4NnKixjDbsLGo3R2i7Z6rQbN6ZhPsBtCs2C/T9efIcFcJ1WAZE+TyLKrfZijrhifxcpS0tkKhDp2u3ABYF/rSAWn/ww6Di+WD09fHWFDUS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(39850400004)(366004)(346002)(136003)(451199021)(1800799006)(186006)(71200400001)(7696005)(9686003)(478600001)(55016003)(66574015)(6506007)(26005)(2906002)(4743002)(316002)(6916009)(76116006)(5660300002)(7116003)(8676002)(66556008)(66476007)(8936002)(52536014)(64756008)(66946007)(66446008)(41300700001)(38070700005)(38100700002)(86362001)(33656002)(3480700007)(83380400001)(122000001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TUP0ehM6kvMFFvHnxI64mPS8Tu0FCFuaZgIACOOh2fWDrCN6Zcm3UVtJwA?=
 =?iso-8859-1?Q?FjdM7zm/hL1XEcNtCC0rFKPKkunHAoQ9GFJKk98ApqSc3fwj90PHWutkWX?=
 =?iso-8859-1?Q?S567P98N44pnSFU8ild41r6kONzdGR6WlXu56/nTqY61Azv6nkh4ThcPEW?=
 =?iso-8859-1?Q?TACydAOPvK8bxByHMYUD0pHuMIUTmyWzvU5v/zk58M89FtVM+gvq4A3ftE?=
 =?iso-8859-1?Q?0VDe8PJmKHGB/lFnRhJYxx3UHGsXz4oD1283BtRBjolUDpsO7xGFePk60a?=
 =?iso-8859-1?Q?EyBtqoPLCxH/OmvZtBo+ZOzfy2MY4+esTy9WlB0r8LB+bB0ZTeiwOGpeMx?=
 =?iso-8859-1?Q?hoJmYU4mf5+TIkXiu88El7katJuxHU/+wEChODH2BYnLiLwUayMQ5EbZXX?=
 =?iso-8859-1?Q?fwlo9hGG7giFAottHZFuNF0yWqy4ZQVGnH3oUr6jiPUnVZqDmeSo1mPfqk?=
 =?iso-8859-1?Q?fuDr3Mo8Rpe8dNsKxm9YQxWo3o70Fs+R/Xt9LU/InifUhG7BlPceyFLp1I?=
 =?iso-8859-1?Q?cw4yelWYt3ISYDvRf+teSLmfPLB6z1T8MQOAuEcjcPDPRupt0BKjEgFBv/?=
 =?iso-8859-1?Q?pM+Rd75Diq4RRRum6rr3GpHvRn6JHZj9VW1lQ9zdpCbRCuPMzfzULpl0eP?=
 =?iso-8859-1?Q?3QME99Ts/dF9a71PsGpcGq5RxMZdoYiJzE4AET7lwGV7s/9f1LP13uy07e?=
 =?iso-8859-1?Q?Azq68d7xUSD/7TvALslRuHNjnKhyEvgfJ2lAMSwTWBMCn+47aaTth16IS2?=
 =?iso-8859-1?Q?jzCvL/X2SIflC+2Q+4nvgzhw2EGynf8vXiYI/QHBCJRAeFOrrH5R6u162c?=
 =?iso-8859-1?Q?Lljd2aD0yNZUPpBW0SvcGyZdIiZD9QmSgcu1T5j/7PpUGISKWaUUBwWPQF?=
 =?iso-8859-1?Q?479DvcAUQaKwyuGb2hp3HG0VOKBDYZdNlM8SmOAGXXI3JiQy//ueXQhFwJ?=
 =?iso-8859-1?Q?QmIzlEbA69Kym+LxFV+4Ium4jRnFX3wkeb6qYA8XGnvTnxkBW/MJ9Y9MFK?=
 =?iso-8859-1?Q?mxvcV1uLPeAqoH8kf1kyetO00qViGwL9a9fMlAaezMg3HdtAXJu0EOnHOy?=
 =?iso-8859-1?Q?1IVaB4zk6DpIkSUFw0hT5eaGOC2TAlR1sWmrTvHQvGDuOsLOjO2FYFVX8t?=
 =?iso-8859-1?Q?5/2oDvk4lROPHxv1cED/dcXoUsFxl2RPHSPwsdru1xZf9SvThgmew16lwb?=
 =?iso-8859-1?Q?sotbYLuLzY9SvCDqEa/Y1Q7qj5FZKS5yvU9oAAKZEZWSxRU93Jqdk37zzG?=
 =?iso-8859-1?Q?fwQYhTmjT1U2cbXGvxil/LL1AhzF9KHYcYvcFued0/WSu+eWWv0G65Ve4x?=
 =?iso-8859-1?Q?KHmGjqkSBpf0mTmLhpAZOEfTOox0LGtALEiVXUVAlFR0v0m7nx5PB1er3d?=
 =?iso-8859-1?Q?Ti/dDj6fXjR3Uxup+eTa9MSf6lL3/5T4rMD/ay86H56fAlz4G7XMogE2s/?=
 =?iso-8859-1?Q?cSTF+WqNFupTPrrc9AyqhJ3kx6fpRkuPmWfXVpa8g52WvL6edmzC4i8tHl?=
 =?iso-8859-1?Q?evWJmYe/4m90QCGv84qN0ui9ICk/bRIUa2lnFgiVyzuG10DpNvER4gOrYl?=
 =?iso-8859-1?Q?EkXeF13hR2QiUMZF8G4wMBmm6EfKQTscE4qaLnGwAzT0R7vkP3xstItCch?=
 =?iso-8859-1?Q?G/bfjcRTOgk0U=3D?=
MIME-Version: 1.0
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a392f5e-a640-4826-4120-08db9c0db9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2023 14:58:17.1869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eFKt/LsMqNlsA7lG+LKwDS5PvgC1dp4XYSMAjfOnAaGnV6mCu/otzyrsEXlA0hC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5532
X-Mailman-Approved-At: Mon, 14 Aug 2023 10:21:08 -0400
Subject: [lttng-dev] Discarded events
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
From: Bala Gundeboina via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Bala Gundeboina <Bala.Gundeboina@kpit.com>
Content-Type: multipart/mixed; boundary="===============0664528502496895564=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0664528502496895564==
Content-Language: en-GB
Content-Type: multipart/alternative;
	boundary="_000_MA0PR01MB6987563FB945A5A4C90312EE8516AMA0PR01MB6987INDP_"

--_000_MA0PR01MB6987563FB945A5A4C90312EE8516AMA0PR01MB6987INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am Using LTTng in my project , I am recording a kernel session for long d=
uration (eg more than 15minutes) I am enabling all the events for recording=
 but some events discarding after stopping the session, if i run more than =
5 minutes only some events are discarding. I have tried to change in the .l=
tttngrc file also to increase buffer-size.

lttng destroy
Destroying session `my-kernel-session`...
Session `my-kernel-session` destroyed
Warning: 94424667 events were discarded, please refer to the documentation =
on channel configuration

actually when i am running below command i am getting below warning i am th=
inking this is the issue because sometimes this warning is not coming that =
i didn't seen discarded events.  how to overcome this problem can you provi=
de some detailed
lttng-sessiond --daemonize
Warning: Failed to produce a random seed using getrandom(), falling back to=
 pseudo-random device seed generation which will block until its pool is in=
itialized: Failed to get true random data using getre

Thanks & Regards
Bala Gundeboina
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

--_000_MA0PR01MB6987563FB945A5A4C90312EE8516AMA0PR01MB6987INDP_
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
Hi,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I am Using LTTng in my project , I am recording a kernel session for long d=
uration (eg more than 15minutes) I am enabling all the events for recording=
 but some events discarding after stopping the session, if i run more than =
5 minutes only some events are discarding.
 I have tried to change in the .ltttngrc file also to increase buffer-size.=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted1">
lttng destroy
<div class=3D"ContentPasted1">Destroying session `my-kernel-session`...</di=
v>
<div class=3D"ContentPasted1">Session `my-kernel-session` destroyed</div>
Warning: 94424667 events were discarded, please refer to the documentation =
on channel configuration<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted1">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted1">
actually when i am running below command i am getting below warning i am th=
inking this is the issue because sometimes this warning is not coming that =
i didn't seen discarded events.&nbsp; how to overcome this problem can you =
provide some detailed&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
lttng-sessiond --daemonize
<div class=3D"ContentPasted0">Warning: Failed to produce a random seed usin=
g getrandom(), falling back to pseudo-random device seed generation which w=
ill block until its pool is initialized: Failed to get true random data usi=
ng getre</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
Thanks &amp; Regards</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof ContentPasted0">
Bala Gundeboina</div>
This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print,
 retain copy, disseminate, distribute, or use this message or any part ther=
eof. If you receive this message in error, please notify the sender immedia=
tely and delete all copies of this message. KPIT Technologies Ltd. does not=
 accept any liability for virus
 infected mails.
</body>
</html>

--_000_MA0PR01MB6987563FB945A5A4C90312EE8516AMA0PR01MB6987INDP_--

--===============0664528502496895564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0664528502496895564==--
