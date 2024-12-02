Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F022FD78336
	for <lttng-dev@archiver.kernel.org>; Mon,  2 Dec 2024 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1733157110;
	bh=DSSLv8ROakbfH/8qyDokHuP2bYS4zpEwAyngaNbsJLQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Crk4J2vN1aeS9ealkHGu+0Y9/cUyBxZ3xnX5wiYtJTNQctZoIdWFjURXdCmwDGWIT
	 Wu05z2GR8HZgrsXBBGky2murG1GQ+MVG+fvYp8TxpFjqEH5aD/wNqr5Q4Lt0w/eNSg
	 ygOlj93MG++rJ3SD8oHei79+hsrLwKlwvXEVwSpqrjpP5nkCssWlH3LOmezpLY3DEn
	 doKpQ93ksEW6bzdQSScIpGD8emUItOJBgCqrOSj7X2KUbaN3StaI7sePLd82ulJezh
	 DHm5WWfoOqVnDWtsSW2TNv2UCij7z0w8U2EuvgfZfQQ92XVJGmd3PlQjD4CBDtCtL4
	 yI0FNzYbnmU5A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y28SQ2FBmz1WmR;
	Mon,  2 Dec 2024 11:31:50 -0500 (EST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72e])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y28Q421WTz1WR9
 for <lttng-dev@lists.lttng.org>; Mon,  2 Dec 2024 11:29:47 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWJJs/SOQN9RaIQ6rm9tL+4vM1zvSA1Az9p5A2nNV7Urb18i9zDvirMHR1FKbt8krR6VSb13Pff5EPSZfkjVaX4lo+cOEi+LhkFOB9888GKuHI9UdkLjSfl+LDQ1Cxa0zGBGOcU9IOHBeUesfS/TjywnwF1K8VPaiIytjZKMOkZTyu+SK1K3nL5k5UReURdKHvGohyAd8Lhp27oY+/jFLlYiytYLnyHO43zV7FbhxTLLhdkSEUvopQ2wR1LDVrvWvug54bgSRnCDVrG2VExhJmMo2kvHQmAyuZmkjytK2nVWDZvIHF2ZP8ghjxnoq4t74JSV7U6yesXAxdoqJv+39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSSLv8ROakbfH/8qyDokHuP2bYS4zpEwAyngaNbsJLQ=;
 b=kYQLKr1YR4I/lFEHH75IplBy3TFjmXg/g18YVbc7EP87a3tNcoHiIrXIIizSyGJ2sCA+VTQooZNnbgrBvnVjNyd3wvuJQpq7Vqwp0M2bTTeJgQ6iKJMu4oqjUyPJW/vvA/vQGz7R53vR+xURn69zpjxFgvnsyts5kXLwiFqLk75YM1z6TGHUOA2vhlXOJOvpRY9NkgmMs+T4qL1qKoJVb1M/o8MuoyGOusk7Dy2DuGoqtQDE6OEFUnreBuksui85Il2nQElOOEte5XrDUV0fAWj9pVmAXs0kt54j8t33345JcK/XQoTAMz4MqLz8Btfi8Sah+7SiBiEbRbUrYwLNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
Received: from VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:19e::9) by AM0PR01MB6465.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:14a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 16:29:45 +0000
Received: from VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 ([fe80::f8aa:3597:6578:79e1]) by VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 ([fe80::f8aa:3597:6578:79e1%4]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 16:29:45 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Record stacktraces at userspace tracing domain
Thread-Topic: [lttng-dev] Record stacktraces at userspace tracing domain
Thread-Index: AQHbRNEpeQNVkoGk6Um/5xrxP32z0Q==
Date: Mon, 2 Dec 2024 16:29:45 +0000
Message-ID: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2024-12-02T16:29:45.424Z;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=0;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR01MB6845:EE_|AM0PR01MB6465:EE_
x-ms-office365-filtering-correlation-id: 728d2b17-f657-4855-5e5d-08dd12ee8874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GbwpNvvuobOXi6WM/fZR7ebIfa4DuWMnqunGzN6DTzoOBcMpQiAay332ze?=
 =?iso-8859-1?Q?HlEFGkOcChGxUedfowpG76/WqrRwTkrlqZDqCo9LZxn9Gttbojo0J+++nk?=
 =?iso-8859-1?Q?f6WJtj4V/VCNKv7e7XrZYMo2KUFhk5HZnm4qhC021UQK1XDzWYNcELK7+o?=
 =?iso-8859-1?Q?c9f6R+yc0R/Kr2bTQOwEmqr5A+FECQ+ASyfmp+tEwwfz+BOGsEo3EdJ0dV?=
 =?iso-8859-1?Q?AKhgwPdS11aU01HaLcq2BwQVFLPSrzyoNGlgRKbSMTEaSSfBXPb6pr+MC2?=
 =?iso-8859-1?Q?3AH+ChHGeLRGvS6QfHmliNZDiIcjH0z5mEIbo1x8oULDXUrMyCYxBy1KUN?=
 =?iso-8859-1?Q?Yn8SwwjK9bBvnBl7w+iENXV98WgtHhCb8OM4k1kMbz1wcfoS11UHdqNZ8U?=
 =?iso-8859-1?Q?jJSmStx2kxOinfuTW5MqdLwv/OvFlL/1mTstGD5V79peyLQTp4kezRWCg/?=
 =?iso-8859-1?Q?V439C2Gl8Dmja79Nuh+UVHm98XwP/xf13cw8FRLJ6H+h7byVG89HWMHbtn?=
 =?iso-8859-1?Q?nJdtZbBPPz8WzYbc5PFGsJ2GmlrRDFF8xU4fHmEqSTxCS/x2z59e7KLPhZ?=
 =?iso-8859-1?Q?aomxlu+b0PDt9x0ySenq3MV64r9w8KqU+JyVk2LYdBiqIspWyodutBfVjv?=
 =?iso-8859-1?Q?AWfil0/1V4bJkcCDabatgjsbm+Ej4T42C5ARAl0Sfykfk35NzaZF/1GoaN?=
 =?iso-8859-1?Q?bjXtAHf856D9yamNmXNMHhKJl8ZSrepFcdxroaWgdImujP/DlAQOHo5rtX?=
 =?iso-8859-1?Q?HV+KBRRiXOGrl02fmklR5eBO65GIaYpBcQKHmtwrQtnV5ZheK54T8D4kH2?=
 =?iso-8859-1?Q?xqL5RA1ERrxtvqqujwuOzHf0mR22dAofF5JjwMnHgnIJdS8g2r1A6Mqtx1?=
 =?iso-8859-1?Q?xyc2WXdPsk67VbUk/XbXEdKqRmdqXT8Q5249VbHxRv0WxPB7OLgV1bnLAf?=
 =?iso-8859-1?Q?B+Khx3gvYoPdjVcjiP7fDAQamZR/2NHTMs0EUqpNb/Lxq4NYTIqCKoa1rE?=
 =?iso-8859-1?Q?BEqFV6ObMHD3pwneP08KpnF+vL7nPLUHv0gi0JKGHObthuclPn+xJBssu+?=
 =?iso-8859-1?Q?mYeR7M7Dt0nKBwvATfPRnFmk0QlqusTSEAsamPt2pZvvysDRzoqhaSr6K2?=
 =?iso-8859-1?Q?5NyUvXw3Tl4j60z9v9RmtJixIPmRmX2U96bdCnwJVQjcUgeqsgKrG0SnLJ?=
 =?iso-8859-1?Q?6Hf4o15aLBuDgzokAHJeGVhj/4/2SnjAhabL+omv1Y8GqMCk2mMfqNDhgU?=
 =?iso-8859-1?Q?BeO6mfWNdpT4T3VRR3h0YvWOQT8lymVB+ryPOrb02WwkjSbAvQeL9D4mE1?=
 =?iso-8859-1?Q?HwmkuCWZxBNvk814eG4vZdXraQe8Yzsq37vuy05GPg/Rrg0su3l6t4ywNe?=
 =?iso-8859-1?Q?1u+8lnRsQMj/WZsMso5tE0if2I4mw3LAlP+l3k4t0eXvyp/fGZCj+KvdYB?=
 =?iso-8859-1?Q?zBUUyeMxlsmyGMuPy29GgzFAYGYG9MAUmHL0Jw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR01MB6845.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dJrxKuhAqJgWwFOTyUxeXEkxpPEUbz6EmdLpfRzh52pGhK4muw19lJRNU3?=
 =?iso-8859-1?Q?oVTUXsqNBihb+fAvJjPyVFX0WTl1t/VJWLuskbp63vcyhpGN7ii89nmPRE?=
 =?iso-8859-1?Q?QSxguXQiTh+nPaawXYpLZ1D4Keu5uy6QKJbBnV077d1rQVRtJ7cK6BDZwA?=
 =?iso-8859-1?Q?J3BE4tmjMP+ZezXiY9m42k572GUnq/0IZ3yEMsRpBuvM0yvOLsIdsuQyq7?=
 =?iso-8859-1?Q?wEyH8CYXIxfI97Rv1Dm/wJAApAX9ekABdRS4PQcpmkl87N6tt3fYf0IUfO?=
 =?iso-8859-1?Q?fTqzmzwcfWZAQ2WiQ9QjKCsRrlfiWBlXHoIK7kUExjQTaNYjPOCSXgZHES?=
 =?iso-8859-1?Q?KJANcSAlhDruGVDW669EyQChpwwTZhqCbrD8s31x8I7uWJi75yv0NXoT/e?=
 =?iso-8859-1?Q?qvtG5H/tdoJO/4w6Jgdeuz/C1yDYDM4hdRFG7gusdrT3P4BLu17q+BlB3O?=
 =?iso-8859-1?Q?Dcg8B8uwEoGmIPejRvuvg5tG1DPTFJYma6Bq4U4Wr4jEyOlw2eNRT2YeEo?=
 =?iso-8859-1?Q?JdNwn/0H0RCrl8UBfZPAXaOm2s5W7Ok2PjmKlHpV5CBBbfeHdz1bjZ00DT?=
 =?iso-8859-1?Q?iyVLF9oEZoN0AygGlNzNi1El1TjTZOCbglJDQtLz2ZG1E84JV8SfcBtqIZ?=
 =?iso-8859-1?Q?l+6Lj0X8Py1nl8DBHaK7maKqCKNT8TZPgih6TStIeOkCEaAedUD9fxi+cv?=
 =?iso-8859-1?Q?zhK7fjphM75BhvRL27Yf3FuUALKgGHPiRk+a4UrP6Q4qOsF/34ffiCIZ2T?=
 =?iso-8859-1?Q?3A6B0UzMGq7MOvSc9awbDpcaSPDyR79Qkl7xZRpdPrfR3nIxvdXLxeshW7?=
 =?iso-8859-1?Q?OzRqaZdQ82RKj3I3XgO/I/eGyGJmGEfx3ey8sf83oi+8BSMvNVGO7Mmw/O?=
 =?iso-8859-1?Q?x4xQBhLDE7jwSyzHCnk7I1fTg8w31c4sZK2CBlTyD02BYj0+1BYnfYpJZZ?=
 =?iso-8859-1?Q?6RCfr6MMezyLUAfoDoUUe6d/ig2fCx/LTK5aqx/S9eyBO10/KoKvVVnGOV?=
 =?iso-8859-1?Q?BVpheagSnyUhJFYFfWyT4xl40qpgKw3/C9EYp8aCqXDLY9iT2DeM3rT5bL?=
 =?iso-8859-1?Q?Wc8EqrEMyiGQV9YIIhUpjSPpyyFGBfuoQgRwpfkfm0vvTnfExQZQqo2TFo?=
 =?iso-8859-1?Q?gS7+mxWZmBjxNwZ+K3u2I5gqNMtU3SLsdcyId8GfW6nkAByqmY+6XD7xHM?=
 =?iso-8859-1?Q?eLZDf8c/JWohoq1zoajU3VE0ldwdEwdCo0ZATwk53Ciw+Au0ZibvaSZAMp?=
 =?iso-8859-1?Q?he5WMYLYcCUNLNQKJMHRvg9zIMx2fWdngPoF2V0CPPn8QLGcfPvThE2F1v?=
 =?iso-8859-1?Q?6nldonlzoDOEqJ9uiiiJIpGJTl0KFGcyRPSUsfse0yKG5x7pjXnwdxNCsJ?=
 =?iso-8859-1?Q?RcKrSDJcUYYrQWnyExkA3y1ABYr2xcTXsncG9hAr0nYdh6LpGN6OKYZE54?=
 =?iso-8859-1?Q?CXatvDSeMijw4LFjNuaJeAcZDjvO3Wg0s7aK9se7ITIzljekgNOKX+rgcH?=
 =?iso-8859-1?Q?FLvODLymCzcxGmh6tz8WYguSP/rclfrQODKy4beNARXjjX8NOzM199IwNn?=
 =?iso-8859-1?Q?JkpFCXUKFmJ/beEXAJVnma+mqsIYnKdLkYjV4w26Lm124KpS00m3Kxeo49?=
 =?iso-8859-1?Q?0Vyv6JxMxPijTZzRskb+9uNYURxXWeAjiP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR01MB6845.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728d2b17-f657-4855-5e5d-08dd12ee8874
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 16:29:45.7226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JVZ7O75OvWSuewh7Blo5ODvZmLcf3wECsZA1yxsCZjb2YlkcshO1PSmfS3NPnumOL59B84ScRkK5r8HEo+P9YlIBE3I90MrqLUO1jFsOpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR01MB6465
X-Mailman-Approved-At: Mon, 02 Dec 2024 11:31:48 -0500
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
From: Alexander Krabler via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alexander Krabler <Alexander.Krabler@kuka.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,=0A=
=0A=
we want to record stacktraces at specific userspace events like e.g. calls =
to malloc and free using liblttng-ust-libc-wrapper.so.=0A=
There is the callstack-user context to achieve this in general, however, it=
 seems like tracing of userspace stacktraces is only available in the kerne=
l tracing domain.=0A=
=0A=
Is there already a solution to achieve this goal?=0A=
If not, what would need to be done to achieve this?=0A=
=0A=
Thanks,=0A=
Alexander=
