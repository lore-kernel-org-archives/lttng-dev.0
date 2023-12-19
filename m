Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13F1C41535
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Dec 2023 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1703014113;
	bh=D6Nm1XoU49EMnzK3IoCLCoL321YajwbQwhEfFjHveNg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=a01+1OppYbw4Y6X0rjLQTiUFbdGJ0SgMS825na/P+ddJE6x+tiEr5augBblhIl8w4
	 656wy/QoQz4TQi+GxWSL/xQywxEuHRrYYAzVfDs7zHkpMKzPKfQ5kPHrJswRvTJoMA
	 GYQKncma1evtohW6I918IiNi32F+lfj9yAHBGSCs4e0hQYfN7VUrxott7z9sU9xjOZ
	 UzGBd11c691SBD3QN+oqyDRWOGdj7YXh0/Tq9SPcYmY4f9WoYe6gG7dk61I2ffazxK
	 24JYGjmoLCY/OytMT2XnFXN13YAUwTi3kViTTOwLmgXfMlgdENXbVHT8JT4H8FIw8T
	 Zo9n3GHlT3ZjA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SvmvN5cS6z18B8;
	Tue, 19 Dec 2023 14:28:32 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2063.outbound.protection.outlook.com [40.107.115.63])
 by lists.lttng.org (Postfix) with ESMTPS id 4SvmvJ61lKz18cw
 for <lttng-dev@lists.lttng.org>; Tue, 19 Dec 2023 14:28:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKK/5vijeWoQkpPqpBRp0k+S5AARWmK5HC8BlIMfJjC9f0VnAi+aE94BB7+M/Cp9xs4wmC1pOnFBk+nk+A430VuK0GEJlxeSTMtRnmYCXwwTsq5y+EiuoS8Fkckm4hRQj4uez9P/KKIOp3P/yv0MdiSFHH8b2gpkP0KWuEvObWiKDV1LcA6AJLb4OHmWda1OBpv7dARGxus51ECE9I+qZqHYbPXoaM1QTWnpHSUDSvGThyNU3n3RVE+HwO4bqVzU0I35aJpM6Qc2u8t7BDyYr6/nqFp2lNPIuX9Sms55uKIZSGWyFy9lWQmVdCI+EoLSuoT6wSinSD/fpyoM8RDc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfPlHuRhPl4QOu2IP3NSdBABYw6oGxZTRQovqxMfLWc=;
 b=WwNwr1rKKzSFcO8WSHXSpAJICETRtTL/5KJ7gxkSYyXIYaD7HC+7upWMBbiLXbjItDeMOMYZojCoavzraGM6hDY8yyXGkJ/A824r+1e4S58zrzHR5RjWerddzTmfybHJR8GganY6jkcg/c4MquXJ5Hg24MTS0v0x6OYadnHynmA8wSqK8jkbBCTL//vSbBufRft9q3EhmPsIldsW/6PzIi3AIpere6bk9O/5qVgbOJ4DVVGbS1OxmO2RK61WcaQq2a7ElmpBhVP2s4VZEDkrhoGusGgvsw2z4F4RyiJ+5Fl7z/Ek7eAIfxhBOXkigLNSzwipiNuJPaMsOjnM/GqziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7b::6)
 by YQBPR0101MB6585.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:48::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 19:28:26 +0000
Received: from YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::79bb:d1f1:f857:4ac0]) by YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::79bb:d1f1:f857:4ac0%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 19:28:25 +0000
To: "diamon-discuss@lists.linuxfoundation.org"
 <diamon-discuss@lists.linuxfoundation.org>, "lttng-dev@lists.lttng.org"
 <lttng-dev@lists.lttng.org>, "tracecompass-dev@eclipse.org"
 <tracecompass-dev@eclipse.org>
Thread-Topic: CTF2-SPECRC-9.0: Common Trace Format version 2 release candidate
Thread-Index: AQHaMrFTWbJy/DdSvUe8/ykVDifPJQ==
Date: Tue, 19 Dec 2023 19:28:25 +0000
Message-ID: <YQBPR01MB103187E14E2A2C7D61B5DEE01D397A@YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10318:EE_|YQBPR0101MB6585:EE_
x-ms-office365-filtering-correlation-id: 20f2aa08-2996-4f19-985a-08dc00c8ac06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2HkuWY2P+fW4QwSxToxWJQiArjuAZEzVFREG/GoIBdUd9xiBQtpgUivuDHsdiibcL4KeywyGijLcn5/Rp5fozREXVbwHpNmG1tRf1Z/GLr5k/MY8BSC5QPqLBEbrpCZxg+JEL+5fxA80ShS3VsF5NuBYzpfQIceBFepX/f4i13ba4t0IuU4yMmLtL9/Lx6TaSvMPaHOn69Q+QDoZiXiuS3XL7Lv48lsAcrIB1KhmX9PIZbuKbUtWpnejsd3FldSABW9NkDCPxsDS1Prs6N8EkcskHRvXGqUxAn9Uhbw96zlog8yM6xXZYC8z3kVYu8i0ZrM4f/loRPcPHM/+wUYT1hn1yDylguhMZmYuOViiBumZfUfvMFmxXXL2A7PdE9dlkhSPxJ73/X1XqilBvTIQedjAGE6sm28I6j4i75nHaXG0DkieSCtancm6i9CQz/bcyUqPf254mb4RkfRgB+iaxP8QOWG8TBhDSN88w1lB5oz30MJvdiycKWByfV+O/uiD4fZ0eTgZcx3OqIuy8xvIjxqbJQ+vV1CJ+w3JsxEUZOJ1NajTg5ZDhUNLL001XJI2Cn9xqIRjAUGY6rHCIyApDjab8NmNaaa4Y6MvbGETT4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39830400003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(110136005)(66946007)(66446008)(66556008)(66476007)(76116006)(64756008)(26005)(71200400001)(7696005)(6506007)(41300700001)(122000001)(9686003)(38070700009)(38100700002)(33656002)(83380400001)(86362001)(558084003)(478600001)(8676002)(8936002)(2906002)(52536014)(5660300002)(316002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g/Xje2rwlFr2AvR6bhlxjEJnPPJ4bIUUfS6i7rFR85GVvtsKtrRQ73RHst?=
 =?iso-8859-1?Q?yWEgVHYYazcap+Gd1IG7I7oToJrANQZxKgbEVOCOqycAs6UP+KgOeJAAca?=
 =?iso-8859-1?Q?8HBYhD7a6xNbLmOn8GMcx0iHglgCQJDGDzjKkidyW78zLB/fBPNEr+D/t/?=
 =?iso-8859-1?Q?0OLEfNUtVoKmx49rnff+3wvZ3groezKZYchbvTghpDTaP8syRdOjQ0VEEJ?=
 =?iso-8859-1?Q?QeQ6jRQ5LZemAKLBGz6mOjRcI/JUXyIxY6S4A/KaMk4MoeSy8Jy0JhEe4U?=
 =?iso-8859-1?Q?GV3mtSg/Ce2RO0MmWaRCiHlC5qdNbUABmmhcqVbm7yKONTrJNV3oVb7mM1?=
 =?iso-8859-1?Q?39RuKQNm13+rUDBzKnOcAeCkWV2i3mzf4l9bYZnEtWIwZWXgplYjxvJuUE?=
 =?iso-8859-1?Q?mi6xybVjuhpVN5sHD8+6nyq7Pf323m1abExQC0csN4AOX8fe25hLf0skcQ?=
 =?iso-8859-1?Q?kayoGwJ38vLD9FGIZwhzRVB9Iw8QdaFsFNXaITI3QkCHJbn8fl/bRTYmTl?=
 =?iso-8859-1?Q?h7H327nstS+S9QcnyuhHZKtQw8iaXXnuHn9laKU3XhlGP8zzkmuiewsofQ?=
 =?iso-8859-1?Q?ICFcwQyOFz9iaZPuSbsZJSgf53cSs1ooEpekj9XSxdvD0zl/F0olw68i5z?=
 =?iso-8859-1?Q?NQyFSu32+3jpk7GKSxMNEtt4jrUdnoZetXSSrCPb05e7ELGRctD0WnSZIt?=
 =?iso-8859-1?Q?rKeZMbsgCW3pXXeNcXxTn4MRjgz3jG4sE3hj76TfuzUN3yL802lnwFejCb?=
 =?iso-8859-1?Q?8w14m0S6AgPUzGM1p5+r0Rd8igCqcnoSO+aY1rv9mEg+2ficCH+JHpKrg/?=
 =?iso-8859-1?Q?3UbvK++lPlAnHXe6mDycTrhPj0IEoWpvowlpMNcHp5/e618UI6LmDX4VJJ?=
 =?iso-8859-1?Q?fOjcXsIC12XBzom9IJE7Vw+xExCyJPrBYyY+p+owHUsq7pXyvRfBf8AbrY?=
 =?iso-8859-1?Q?Di3ehowMNeLZIiMyL02YCes/+DcWSS96onFJdyNHQ2wh6R3oUuw0eKkosW?=
 =?iso-8859-1?Q?5Ej9ZhZQRHnayJNKMyJXXb+AMeTQkutN36aRdau4yjZ/iwDVXTCW22fHn6?=
 =?iso-8859-1?Q?Cgcc8p16S81er+yiARYUD9a5XAexrDfUSfsg1kCC+jp54SLurl6UiyX9O0?=
 =?iso-8859-1?Q?ILjPEOe4+DLttjqY8U4OKtc8RnirtXz+4YqhywRgpNE6EhWK/ii6h7b7Ub?=
 =?iso-8859-1?Q?FcXV7mFGNIWyRW8t40DW7zGbNp+mloxCU8PGRbM/ZBhyPI2pVBTkbdkvJI?=
 =?iso-8859-1?Q?E8Qur+bU2dX8DgAlroxiHKNs+jkNnpzcy5LejPaYALqiNqmSQSbL6qLrls?=
 =?iso-8859-1?Q?W8uQ5as3WadBO25RUjYyBVUQ3aJPwVNMzm5SbpBkLoYeTdo2YYsXxEwqES?=
 =?iso-8859-1?Q?sIPB0qQZjVTuOO2ULcjzj8PV+PFpfZ/N05fxNMOryHuQyWLLkk5KKXBVrF?=
 =?iso-8859-1?Q?KD0tJgfRYYQAcy7KGhg8+ElhRW1ClAqsIDI0bhPaXJE0kXHtm09Ick6u0O?=
 =?iso-8859-1?Q?2AzaexaVFXBWUjqfTJ3zfBSJihG2Jd6lUO1xze9gtFV3FX1jHNkHXNVCF1?=
 =?iso-8859-1?Q?i4SlQGd0+vYimCg12itbxOcVtBG4y4zR11zn3HkgqSR8eLsUMXzoO/dFtO?=
 =?iso-8859-1?Q?wxPEYYQ/jAYdDoNjMqs/OjvpurREWEycVQ?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f2aa08-2996-4f19-985a-08dc00c8ac06
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 19:28:25.9080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ6dEAmERiRF/qmT9R7aOsjXUQyPaZZXnIR8vLoxnzhehX1scGFMqoOPNjxL6bkO3OucPZd9qrJXYS6JhvinJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6585
Subject: [lttng-dev] CTF2-SPECRC-9.0: Common Trace Format version 2 release
 candidate
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

This is an update of the CTF 2 specification release candidate from
v8.1 to v9.0.

This document, named CTF2-SPECRC-9.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-9.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
