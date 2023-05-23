Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63AFC7EE23
	for <lttng-dev@archiver.kernel.org>; Tue, 23 May 2023 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684853509;
	bh=7y9xYDsLRd2il8Z1vBbFsSAAm+XUOV+BaSvQU632KR0=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Lu9exdCFotn81QwZ92MeMVeg+IMzDRolq04oUkBZdpNa8Lx23EpTSyaaPA4RuF2tr
	 dYVbCkhu2aOjt9QHm5MI6GZQ7PIdTWou71fi8E15xSbiAqf+Edr4TX5Xiw7FEzw+pd
	 D70JVr2IfkuWdTadabNlukCxgYsYZcaPezBqblHcGBhKJE3IbwvxAdSThgzjULfWsb
	 jlCDzVykyKKJpgj0hIRAf2YhnlSx95tQbBaM32U6EUsSo+XugOiTO8V55XMvSmmUfy
	 czWhbUxkdKBiBkg4NZySgWVNDXVgCGT2zkKoS5ywE+ixMX+lWKPSwqGwAzwKSR5vsA
	 beVyX87sg+tyg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QQcj10ZcTz1HHh;
	Tue, 23 May 2023 10:51:49 -0400 (EDT)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2080.outbound.protection.outlook.com [40.107.115.80])
 by lists.lttng.org (Postfix) with ESMTPS id 4QQchx5kDFz1HZJ
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2023 10:51:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjncRyFAexeSXe8Q1EvnEzpEqV7cUZbc+4+lFM6aOt+68bzz5C4jEYXN2l+YGwwTLU+HVSNDwordR5XzBpmbd037YZlbzA3SRamcLenYgWApLIkNTDMepBvEBnqgXtIZVdgQhZOmY3D7w86BhvjU2qICwdv3nVkxP6xRNZt5Q7m19Z2B6nbZpQEXt90eTOdRoFkpSXJoG78OdWGPb0+li5hU4eaHmstipFGMT1DhSJdte7nUJ6L0HXIe4sfJQ8KXtnAteU/chIKYV5roerz7FTMRYkmihHv3VxJq2lNBLBA7g1W9BzshjVgbG+iS3OBoPDsRjMbz1nnZRwlS+HuGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ms/FG5FD5c4tEQjlWXJO8vlvklEq2l2mQgiFn5RBEQ=;
 b=V/Asek+jYj803lBtcxZw+FTuGnaAqmsiQ1t5D+6218M2EQ823I0U0NeQG4On7eOlN++KXPfsP6cwku0H1wYLp+ZyOB6XshW9WVT+8w8YgE8FGdRiziKlBDiiJQffhQMlPvQqyjsD016HyoJxLGh/BgutF7+BrwklQmA1iam6oYOfQCTaivBN2NpOu0QUol3blhnjEIhi/hcUQnwpGu6knPDUD74227++0Ta+dC/jHmnm4TPjsaFqVQ5PSRUT054kfovV+Swyvkxm/kHWH4URP0RoYT84BNbhANSRJMnDssprDR7UFHp6kf/vJbyo8H6sM97GsM3XWDrHKQch3U9zdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT2PR01MB5741.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 14:51:44 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::43c8:88d2:4710:99d5]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::43c8:88d2:4710:99d5%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 14:51:44 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Yitschak,
 Yehuda" <yehuday@amazon.com>
Thread-Topic: delay between trigger and action
Thread-Index: AdmNbmIDJquxntJBTEq67T5MR6x9DwAFsRpF
Date: Tue, 23 May 2023 14:51:44 +0000
Message-ID: <YT2PR01MB59848AD0183B0C7EBF8C7E9CBC409@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <ef30ea91bb3c427e84c6677350bda6d7@amazon.com>
In-Reply-To: <ef30ea91bb3c427e84c6677350bda6d7@amazon.com>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YT2PR01MB5741:EE_
x-ms-office365-filtering-correlation-id: c747fb4d-4e48-45e2-b8ec-08db5b9d39c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CM8t4AY2i227mKHOvwAK3Zmzms6o2HDs2bndS5iVVonC3OSV46An5bxVbYptbkvqld8w9Sq0OsWCR4SPc3VZv5aKhBmt+oe3ObVIQPa02XzfN371jA9vcA2OgzFGwzghDYjGQRx8T2eQc8CDeOjUZN0t+dZdf4mn/YVYqEdtjXiCZe8EjYfNnkqeRMH+oTzeqUcUqKEC1eB+1ck2YBBCuCyUurlwc7V5PhYscrgRF647tQo+uxAe/93uFZtSLh5iBhL7+7lkdRjgewOJg1XzzMne702/6QUXZ/oTNxW9bi2lQmHtSnRv2fbAQgVJEnLKvbyz0uNlpqHWVC1ICT0qIhADK4gWDuomxV812DULosmi9T3r+3HHvAPaqXvDRESbof4dLtUcYwKeDVCZ4BbVqF79yCpfSTSR3ss8SVCd/GxGQasMb3LX0tDkxqrUMYLyDSzs25Ltd39RLnAp2B1+7k37P+6MjT5B5uqU+yE2V/l06QpQ0jZVNao3Q5QcEWwuGbrfMXNi5DIkNg+rbFZLY/B9Zk0wIfo6elQjymoiI9y/oEXRaFVBiRLPwGo8274Zd4Wgll8PU+eplMjWUyjAOU/q4OrvLCEZQB55ePFKFMpoOKynRPBWScc7GbdIA/fp+i+oHEpimncQFWiWS8vQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39830400003)(346002)(366004)(136003)(451199021)(55016003)(26005)(122000001)(186003)(53546011)(33656002)(6506007)(9686003)(38100700002)(83380400001)(2906002)(41300700001)(7696005)(71200400001)(316002)(110136005)(966005)(478600001)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(91956017)(19627405001)(38070700005)(86362001)(166002)(19627235002)(8936002)(8676002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l9Kn5cFT+s+vnFewgWBQ4uLHJJrM1Q+fcsMN3obqm634/ypw0rG1g8zjFy?=
 =?iso-8859-1?Q?ltAPxzX9CAz1NP1QVDje04BMCbXJOdomMmzAEXY9Lm4E1gr/SIxZ+OsXZV?=
 =?iso-8859-1?Q?zfWWpGT0eL0Q9DLAgLXA4FzTFoKSXGcq/84yaW5O29BwRq4oPIt9SUJKOt?=
 =?iso-8859-1?Q?zm1CJVjwFbqu0I91gg6ZmwZ39svPw8PlGVb8e39pN0wOV4S4BkVrphrJl8?=
 =?iso-8859-1?Q?Hhw8nakWvSNUt38eYOpHbqZUaikdAPrhw68B6/rnYADSvsSkdPo9IqOMR1?=
 =?iso-8859-1?Q?w76Hw30Z6rabJGEheKqHHwkva26JzeMkUKQGYdtnrs/QxwAs+y3pE0eHZ2?=
 =?iso-8859-1?Q?vT5nYfqCQ6BhwbaI7/uISd5aVQP8auhQwn0KpYZnOskkcZHBnrxORgdtqm?=
 =?iso-8859-1?Q?MF4Tk5XNMw89KKtWbkxDvuOiQrH5YjR7Pji68djV1Mlfor7MOR4OP4Kayl?=
 =?iso-8859-1?Q?54A5veXMjToMzujvkf97cb14xZRq7AEKclRHlPBbTYH3mRWUbAbfspkU5m?=
 =?iso-8859-1?Q?2/tzhPJcwKxer8v8kxwabKgEoXq7KGhurCybd7NHRYi+Hy6mjp+z0Wj+Xl?=
 =?iso-8859-1?Q?rkHl2Z8j64JK6pUS4oCaGBykYSoCC3MZ3HRGT9gCy9zorNnTDoPn1Dl+Z1?=
 =?iso-8859-1?Q?d9OrjwiJEGV2I/4fa4HMJXSVZBMtrOZ7Hl3FfX8INPe2nBy95j621D0vB0?=
 =?iso-8859-1?Q?gupsnTsJsAN29WqFuZi+uIFzbBxmEyAkOyIttqWtF0q3+tI2dhnBupcjQ4?=
 =?iso-8859-1?Q?qEMj36XkncqTNkQfPaAN29pPmzYcrk2077OoQmBXwMBs5xzQI7+cQARf3/?=
 =?iso-8859-1?Q?oK/9G2Zr4fUNj9P3GT6ILPUwLbFih+eY9gdYgeKD4nTW8DxUjBfzHhv+iK?=
 =?iso-8859-1?Q?s2hbrg/GttfgFBfotd72NUJ7Un+ks9dZPDNtT5HQMospoJmwecqUqo0qsD?=
 =?iso-8859-1?Q?r0DzqlGzFZ95S8/H9HMK05hIqkWHHdL8P9E1qP9igIoWaMEj1iuFUQ4sBo?=
 =?iso-8859-1?Q?oW9H4NZayw+9xh1w+8ZG3YSxntd36GfhsI1tzEE07095Sw1Ltn5vvk8P6K?=
 =?iso-8859-1?Q?8DccZYnsGKCp7jTBPsbu6ZXyo7bqd1NjKb/OF8KEkTAs9EBr3y+myZAJ+D?=
 =?iso-8859-1?Q?Gl3cY4UiizM/tXIn1oRtLOBR7YSniR2dVtuSZcPLmJb//gsz4B8VbYROju?=
 =?iso-8859-1?Q?A642dQoBcFtXQKsXhv489K34wB6a5l/Z6M6lYKkqU5GdOgeXGNMzdf2G+0?=
 =?iso-8859-1?Q?mSxcMQyxt7ADIxP2SXBEn3y2BnHgyoKQMVbpLEWEmSBkbmGB9xNsxOkUq1?=
 =?iso-8859-1?Q?oqDal4xru+H0xLy1nub5ENvUUUXDNjaehHhlOH1n56JtzmF3Ikn8eZx6BR?=
 =?iso-8859-1?Q?sAfNMsAY7cLi/Q2ZUfAMzK1q1MmnTVIkDlZknyqbbUnYhxQSw4aKvY0D0t?=
 =?iso-8859-1?Q?lXjQRxtJoaiPJG0fDABK7lnJ2lJ/t1hzIkbvYjoa0lJQYgarUcHHA5Aowb?=
 =?iso-8859-1?Q?DJ2s+z+U/eSlk7pzOzfGFRZuaKo0WaBAnhACTfg9VvoBuEoEH5MQyOIC1y?=
 =?iso-8859-1?Q?TLiZxw8mZQlWdaghjuKGm5vbbgY9itPrSKvGXp335o8Z19Ts5K0ptxHK+Z?=
 =?iso-8859-1?Q?nku6ys+wn2CTRoiguef1tkklv8Anyhym0G?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c747fb4d-4e48-45e2-b8ec-08db5b9d39c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 14:51:44.0070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXpWzYlnYZvgjeYS9VwdI1GEdEUjN7z9ScOCDLy9tQKqWfC19ce5yP7gk6sUoAMCYBFbF9b4G4ZyJqIDGDFtVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5741
Subject: Re: [lttng-dev] delay between trigger and action
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
Content-Type: multipart/mixed; boundary="===============1099477211426575418=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1099477211426575418==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB59848AD0183B0C7EBF8C7E9CBC409YT2PR01MB5984CANP_"

--_000_YT2PR01MB59848AD0183B0C7EBF8C7E9CBC409YT2PR01MB5984CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The trigger mechanism is asynchroneous. The applications (or the kernel) wo=
n't block until the session daemon has processed the actions of the trigger=
.

As such, it is likely that you will lose events between the moment the trig=
ger is triggered and when the session is started.

We have been considering implementing synchroneous start/stop actions, but =
no one has sponsored that work for the moment.

In your case, a work-around you could consider is to:

  *   setup a snapshot session with the same events
  *   set the trigger's actions to record a snapshot on that session, and s=
tart your existing session

In that setup, you would most likely see the events that led to the "start"=
 (since they are captured in the in-memory buffers of the snapshot session)=
, and you would capture the follow-up events in the on-disk session.

I hope that helps,
J=E9r=E9mie

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Yitschak, =
Yehuda via lttng-dev <lttng-dev@lists.lttng.org>
Sent: May 23, 2023 08:17
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] delay between trigger and action


Hi everyone

I am experimenting with enabling trace for a specific iteration of a loop i=
n my application.
I created 2 trace points at the start and end of the loop which log the ite=
ration number.
the loop itself creates thousands of trace points. It runs for ~5ms.

on lttng side I created 2 triggers to start and stop my session in case the=
 loop tracepoint registers a specific iteration number.
the triggers seem to work since there is another session entry created unde=
r the session folder but there are very few tracepoints.

is it possible that the delay between the event happening and the session t=
race starting causes loss of events ?
If yes, is there a way around this  ?

here is my setup :

#lttng-status
Recording session session: [inactive]

    Trace output: /home/user/lttng-traces/session-20230523-113537



=3D=3D=3D Domain: User space =3D=3D=3D



Buffering scheme: per-user



Tracked process attributes

  Virtual process IDs:  all

  Virtual user IDs:     all

  Virtual group IDs:    all



Channels:

-------------

- user-channel: [enabled]



    Attributes:

      Event-loss mode:  discard

      Sub-buffer size:  16777216 bytes

      Sub-buffer count: 128

      Switch timer:     inactive

      Read timer:       inactive

      Monitor timer:    1000000 us

      Blocking timeout: 0 us

      Trace file count: 1 per stream

      Trace file size:  unlimited

      Output mode:      mmap



    Statistics:

      Discarded events: 0



    Recording event rules:

      trace_events* (type: tracepoint) [enabled]

      loop* (type: tracepoint) [enabled]

#lttng list-triggers

- name: iter-start

  owner uid: 1000

  condition: event rule matches

    rule: loop:iteration (type: user tracepoint, filter: iter=3D=3D2 && sta=
rt =3D=3D 1)

    errors: none

  actions:

    start session `session`

      errors: none

  errors: none

- name: iter-stop

  owner uid: 1000

  condition: event rule matches

    rule: loop:iteration (type: user tracepoint, filter: iter=3D=3D2 && sta=
rt =3D=3D 0)

    errors: none

  actions:

    stop session `session`

      errors: none

  errors: none


Thanks

Yehuda

--_000_YT2PR01MB59848AD0183B0C7EBF8C7E9CBC409YT2PR01MB5984CANP_
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
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Yehuda,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The trigger mechanism is asynchroneous. The applications (or the kernel) wo=
n't block until the session daemon has processed the actions of the trigger=
.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
As such, it is likely&nbsp;that you will lose events between the moment the=
 trigger is triggered and when the session is started.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
We have been considering implementing synchroneous start/stop actions, but =
no one has sponsored that work for the moment.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
In your case, a work-around you could consider is to:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<ul data-editing-info=3D"{&quot;orderedStyleType&quot;:1,&quot;unorderedSty=
leType&quot;:2}">
<li style=3D"list-style-type: &quot;- &quot;;"><span>setup a snapshot sessi=
on with the same events</span></li><li style=3D"list-style-type: &quot;- &q=
uot;;"><span>set the trigger's actions to record a snapshot on that session=
, and start your existing&nbsp;session</span></li></ul>
<div><span><br>
</span></div>
<div><span>In that setup, you would most likely see the events that led to =
the &quot;start&quot; (since they are captured in the in-memory buffers of =
the snapshot session), and you would capture the follow-up events in the on=
-disk session.</span></div>
<div><span><br>
</span></div>
<div><span>I hope that helps,</span></div>
<div><span>J=E9r=E9mie</span></div>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
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
<a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Yitschak, Yehuda via lttng-dev =
&lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> May 23, 2023 08:17<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> [lttng-dev] delay between trigger and action</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:#954F72;
	text-decoration:underline}
span.x_EmailStyle17
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-family:"Calibri",sans-serif}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">Hi everyone <br>
<br>
I am experimenting with enabling trace for a specific iteration of a loop i=
n my application.
<br>
I created 2 trace points at the start and end of the loop which log the ite=
ration number.<br>
the loop itself creates thousands of trace points. It runs for ~5ms. <br>
&nbsp;<br>
on lttng side I created 2 triggers to start and stop my session in case the=
 loop tracepoint registers a specific iteration number.<br>
the triggers seem to work since there is another session entry created unde=
r the session folder but there are very few tracepoints.<br>
<br>
is it possible that the delay between the event happening and the session t=
race starting causes loss of events ?
<br>
If yes, is there a way around this&nbsp; ? <br>
<br>
here is my setup :<br>
<br>
#lttng-status<br>
Recording session session: [inactive]</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Trace output: /home/user/lttng-=
traces/session-20230523-113537</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">=3D=3D=3D Domain: User space =3D=3D=3D</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Buffering scheme: per-user</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Tracked process attributes</p>
<p class=3D"x_MsoNormal">&nbsp; Virtual process IDs:&nbsp; all</p>
<p class=3D"x_MsoNormal">&nbsp; Virtual user IDs:&nbsp;&nbsp;&nbsp;&nbsp; a=
ll</p>
<p class=3D"x_MsoNormal">&nbsp; Virtual group IDs:&nbsp;&nbsp;&nbsp; all</p=
>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Channels:</p>
<p class=3D"x_MsoNormal">-------------</p>
<p class=3D"x_MsoNormal">- user-channel: [enabled]</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Attributes:</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Event-loss mode:&nb=
sp; discard</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sub-buffer size:&nb=
sp; 16777216 bytes</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sub-buffer count: 1=
28</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Switch timer:&nbsp;=
&nbsp;&nbsp;&nbsp; inactive</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read timer:&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; inactive</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Monitor timer:&nbsp=
;&nbsp;&nbsp; 1000000 us</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Blocking timeout: 0=
 us</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Trace file count: 1=
 per stream</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Trace file size:&nb=
sp; unlimited</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Output mode:&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; mmap</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Statistics:</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Discarded events: 0=
</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; Recording event rules:</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_events* (type=
: tracepoint) [enabled]</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loop* (type: tracep=
oint) [enabled]</p>
<p class=3D"x_MsoNormal"><br>
#lttng list-triggers<br>
<br>
- name: iter-start</p>
<p class=3D"x_MsoNormal">&nbsp; owner uid: 1000</p>
<p class=3D"x_MsoNormal">&nbsp; condition: event rule matches</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; rule: loop:iteration (type: use=
r tracepoint, filter: iter=3D=3D2 &amp;&amp; start =3D=3D 1)</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; errors: none</p>
<p class=3D"x_MsoNormal">&nbsp; actions:</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; start session `session`</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errors: none</p>
<p class=3D"x_MsoNormal">&nbsp; errors: none</p>
<p class=3D"x_MsoNormal">- name: iter-stop</p>
<p class=3D"x_MsoNormal">&nbsp; owner uid: 1000</p>
<p class=3D"x_MsoNormal">&nbsp; condition: event rule matches</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; rule: loop:iteration (type: use=
r tracepoint, filter: iter=3D=3D2 &amp;&amp; start =3D=3D 0)</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; errors: none</p>
<p class=3D"x_MsoNormal">&nbsp; actions:</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp; stop session `session`</p>
<p class=3D"x_MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errors: none</p>
<p class=3D"x_MsoNormal">&nbsp; errors: none<br>
<br>
<br>
Thanks <br>
<br>
Yehuda </p>
</div>
</div>
</body>
</html>

--_000_YT2PR01MB59848AD0183B0C7EBF8C7E9CBC409YT2PR01MB5984CANP_--

--===============1099477211426575418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1099477211426575418==--
