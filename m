Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBD3C48BF6
	for <lttng-dev@archiver.kernel.org>; Mon,  4 Mar 2024 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1709570905;
	bh=TmQUO8FJsypJ3MWS7oKvCsQDeJme00lIfueHqNrGtm8=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Jy5gzQC07Y6QtdUizZxwuWPyng/APFop3SFp65gTONZ5l8ICQLAHrTyFSVsgj3Mni
	 fThCiPGb/1yxNiTqpQWRetj/UOmog7bdDHuYb35F8soqs2NKARzMGrHYYc6IuF2mvS
	 hrR6ZJsvl/0yi41VyLoVWKAFz0jiyU0SqsYmi4615grpy0XnG70rMisEmCFBIGh5Ua
	 4l9sEvE3XDDeDF9eehm7pb+hy316Ha9mEkfTtFgDErR8COKs0kGe6DHbvugXOEm+WG
	 jthSlxMQFeK2Gy+8BMgUjJlU2UgfY0mfXVzZHD4QLSAxEf8NfY9x4E2JuIAOj6Qr28
	 4g10kk8SuNlDQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TpPlX1GgJz2FVY;
	Mon,  4 Mar 2024 11:48:24 -0500 (EST)
Received: from CAN01-YT3-obe.outbound.protection.outlook.com
 (mail-yt3can01on2138.outbound.protection.outlook.com [40.107.115.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4TpPlS6kYMz2Fb8
 for <lttng-dev@lists.lttng.org>; Mon,  4 Mar 2024 11:48:20 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV1yveKR7bc4H0wHhTRmkXtRfHFzvD1FRME9B7dijDdAglfGPQl2lCu7sv1Er0ZpLz2hv27ZpFgLeVv9NDgHICYl9hmxFJf7SpJ0tJnlTE4oI0t+0gUuqkubsiEwLHSQh19PaNVYdDRED3gU+f3Ioq1f781qAqQUUw75K7+wmonaJO4oAqMNvEATWjdZozgaoLfFwNkwl0YjztSTBgG5ddh+E4Wobwk2/dqzOW6dr1W5eLe6wTM9AoWTd0ptMrbq87YtIMJlHxVu6Tj5Tm96EPVuWWc/GMNCqgs9rt93mnIkBvlsfecl3DhzzGySqc2iBt+L52MBQPaJtHYpzAn98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1wKDVUDiloLE3yWt1QtlqIZ+E8IcBN2JB1SaFsikpI=;
 b=XwHZ6pUdZ7aRY6hGLPPCBad9PkvgIBYlqOB0Z902rO03+L4ZnuNsyKCOj0vcflTsV31FptYMUZVoGUXB+qaQMlHa4MiqHj0xVJTBYOk7QwjhLd90Ah7468r1OQkhL9Aj9M1rpJ62rYoBGfvmvKycqE9wIoQ77W5Z9Xo/7Rj5Gry+xjScuViweFaQMG7sb/OFClZu6JHjMFX2KorTREFfrEopyDbxWJNs88nzDBh6imDPsC7kvrW306eTI//GFNmD8Yd1Rj6BqPqlbodTH4IR9H/MccA1Y5aVPjNY1aVLrdupnAfMYMH2kfm56gISkrLPchVh+oufToZ4uQC3GWlY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8b::14)
 by YQBPR0101MB8846.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:59::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 16:48:16 +0000
Received: from YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ab5:944c:6533:d327]) by YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ab5:944c:6533:d327%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 16:48:15 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>,
 "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>,
 "diamon-discuss@lists.linuxfoundation.org"
 <diamon-discuss@lists.linuxfoundation.org>
Thread-Topic: Upcoming CTF 2 specification
Thread-Index: AQHablM1pDc4jyXBvESO4eNBIZg0Tw==
Date: Mon, 4 Mar 2024 16:48:15 +0000
Message-ID: <YT3PR01MB97235A5745DD33CD2B7D0478D3232@YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB9723:EE_|YQBPR0101MB8846:EE_
x-ms-office365-filtering-correlation-id: 4a2f24d6-18ea-4afa-d5fa-08dc3c6ae30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBv78IXhu4cXAubXPQ46NsRaL57cqKgYYnFvdpgSdoJCRzJYbWTyylEKPefiYcRz+DVtDkYrFt4Z7U5jjpP5ecFvPBuU9yffDdxk3KWnUIvhS7S89xBSB3Hx0ZLMi/FGnoagEy1Kc0XEmZh/0zB9YB45e2qV/i4/GEPZh5DZncVV2XdjKTDaiosPGOAjAhug3TN496XlFvZOiTlKQ3pXf872C0Xh1DjVoC2Yz9vi7rbSe3XT7BJUp7/I2qFbWN8urKq8uCLydx+yluwaFAw67gmIn4xK0VIciOaTPyLm5Dg9xHsFwLxVXbnOqjqIgvLBktQzlEP0GbZU0RyP77sNsZlf6DW1YLgeeKtwX1Ygf3pu7yR3B7gJ1hbgogYxLgTfsV2hUP2LNQSnHIEoKHSPqkdWrEVKRfjvaQVMIjZ2VXmQeD4EvFrDXd4Q4SYZhENtTr7PdVzDDQnNW8js2SioA/Ti0ncG2ZgJZ0qtDxwIpPYWFIwt3mD7cnvjnVqJgpHXW70tBw4/uD94ByYe1CIS2+6Q0SO9DOHhZ8CI7hAOJ577oEGRjsswi5Vou15I+BYjM7pF7rKfV/mfWjuGnQOZS2Cicvqs92xVpEKJGEQE00cRTJGL2WVsGk/TXiW0U5QsVOqMJ0aScFK4ObpDRHkauAv0DwapoPUKXiZ4HBCt40w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vsvjJO8xImxKmo+DMh77jestnRspeZY+TMfeeRaCUM3xuCGftKlTyrKz68?=
 =?iso-8859-1?Q?QGI7mDQHHp1PaWGShMZeIqVV61fYg8m6tcZTOH6NGw67yxqlzkgglI7Jyr?=
 =?iso-8859-1?Q?CCAAGUts5raWAImLDID8q0knE1dxYT3RZz4o84yvmxb2gyebxjCEx7v/u7?=
 =?iso-8859-1?Q?1PbqH5xrjsdEgRmADQ6g/8+Lxzd7OYPOaTEWD8pEXu1YiwcjqWIhUEWK1D?=
 =?iso-8859-1?Q?QzOY+r17jUO44FgK+V3bCjHr4iEkvuLT1jfyJjSoqCZxz3EVpEr4p+JMb+?=
 =?iso-8859-1?Q?WN46rsOnXeAsafUeOO5SS5AQ/cViAvZEPtQqVp3XoXUOFyzT0Sj3c9xtiu?=
 =?iso-8859-1?Q?7gH38kVMW3+EY7erY+6sGTgRhbffb2eYnCZkZcYYoACYz2SoMefrOkDZg7?=
 =?iso-8859-1?Q?WfPI4nYl9g4P50oHm37HquoYZtm5YAyh4mleay9qLQHzz/GON/v1Mc+0r9?=
 =?iso-8859-1?Q?HH8QZPZw+C//I56h2me5EgQLrKo35fGKxZALn7XDTsL6z+3CzJmeq/l4mW?=
 =?iso-8859-1?Q?IzMuU57JSKOOPAZ/aZjrBQ866SqrnpL1XDaohV1QybucSIo1do3QnuuVuw?=
 =?iso-8859-1?Q?eFxj8dW8xztz9fHctwt4dBNXVb4G15CT3B/IRGu47e9ZpvT21WM2ycveHn?=
 =?iso-8859-1?Q?otflePgK0mmMZXg3NAesSvZW8ZUWv82Omt2B92gL6HLay17IcIq/tUF9Rb?=
 =?iso-8859-1?Q?s47e5hlHCO9MEuphmeOJvMNUmGSokFOl0iADHAM+V0Jz/YVxkrPXI/n2/3?=
 =?iso-8859-1?Q?8L4tglnWL4VzUuJ05zbENlcOY2cnNEV/6thhrggM9hE6IVGbfgSP8Im/f9?=
 =?iso-8859-1?Q?bBj1oNlZNWCjIl+JxvHuVm11WYrEfd3ZQD5tkFKDXkt5Fst469PJupw/3b?=
 =?iso-8859-1?Q?IBIJhksNzo6aX3jBjlU7Kc/05ZSQMDA2zKd3eKTIwG8dCoxvz0I+FCrONn?=
 =?iso-8859-1?Q?Q7NlLa15pKRWOAkvVvZPafOm3knGcDaFJixIuM79eZE9hwREx+XFP+Fqti?=
 =?iso-8859-1?Q?+eJU5zruM53KTBVx/7nxf2xfgfVOBWbO6VM81FM4bbam7EDnDGa1/EsytG?=
 =?iso-8859-1?Q?P7xi6OXxbnbJ222Y+WwfFtdsbjgbokdvRP3Tx3Eyn68Xu1CtZUXdk1DEyU?=
 =?iso-8859-1?Q?me0Yru0LfOojxiikW54HTTL73UrkC1WtiRSsE+xlFTYTakrU7x4gA4kUVD?=
 =?iso-8859-1?Q?hWXs4u5spDH0TBYAKOqGGPDOV9Sm7JOpXta6ueeDzcilRqZ1TSk63YXoJb?=
 =?iso-8859-1?Q?j5OwSjjY47meh29kmlYOZWYNEzmbF/wOep+I4jzVbLsfAxmQALBBA2PmuS?=
 =?iso-8859-1?Q?N6u9yuszUQywpNIPAIX1O6rIEunD7dp3ZIF3Gu3uRdjzj7UWhKr7nKV7bX?=
 =?iso-8859-1?Q?+701pAzycVywmSj9ZnIXnL/BFkWvl0Zuy5vF+NZZ1JwVVSVlF9YOXSIQ3v?=
 =?iso-8859-1?Q?GW10i1tPU7JdjEZ4lqwboIWA9lmvXK9FCGDG9VPxu+ULFveCKhoEUWZVHs?=
 =?iso-8859-1?Q?An956U4i6eZKa1zx92mhSlV4PeI+p8wfPLXJY15x31Js7Qlylm2+3yY6TO?=
 =?iso-8859-1?Q?vXjUQ71ShjYjuC51TbxGBreM43CuGgFtQLwUP16oP0icZuADKFndrNG00w?=
 =?iso-8859-1?Q?TvByd0D330knC6si6/dDG87eb2mfLq05VZ?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9723.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2f24d6-18ea-4afa-d5fa-08dc3c6ae30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 16:48:15.2894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyXRPcveGmcl00oRnrlpF1UhisWkOC0qYsoKI0lRKAkcXZPLvpFv0N2rrBAgu2Oiu3eKpm4onKav6xRXQgnZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8846
Subject: [lttng-dev] Upcoming CTF 2 specification
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

To those concerned,

After years of development, the DiaMon Workgroup announces that it will
publish the official specification of the Common Trace Format, version 2
based on its latest release candidate, CTF2-SPECRC-9.0 [1].

Indeed, we now possess sufficient implementation code to be very
confident that CTF2-SPECRC-9.0 does not contain any major errors or
omissions, taking into account the goals of the format.

Consequently, we will publish the CTF2-SPEC-2.0 document in two weeks,
barring any significant and justified objection in response to this
email.

Although its form may change in the future, for instance to add examples
or to make them interactive, its content shall remain as is in
perpetuity. In other words, we do not anticipate to publish
CTF2-SPEC-2.1: any additions or changes, which we will document as part
of new DiaMon documents, will be made through the new metadata stream
attribute [2] or extension [3] instruments.

[1]: https://diamon.org/ctf/files/CTF2-SPECRC-9.0rA.html
[2]: https://diamon.org/ctf/files/CTF2-SPECRC-9.0rA.html#attrs
[3]: https://diamon.org/ctf/files/CTF2-SPECRC-9.0rA.html#ext

I hope you have a very good day,

Philippe Proulx
EfficiOS Inc.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
