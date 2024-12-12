Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E4E77180
	for <lttng-dev@archiver.kernel.org>; Thu, 12 Dec 2024 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1734022338;
	bh=FPmXfYjdYarmkQ/8VPQu4t7TTxLRPYhbYMiSP+weqwg=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Q3TNWlL3SPNCG56DXTELeFoZ/IxNiUQ6P3Qj0+LsSk+8OvfcHcS53u7pb4Wb3HPxz
	 BbtVxtwqEw6WF2FA+yLe9JfwHZ5XrrbLpJ83ENpDnSUfISKmtH9m8XFCLn1+qJytjp
	 SP2Sh/jn8b1akOpludm7b4mGZtU2GaBUmjxId7A3dI2JdRv53NESMBEVass2NXBwmi
	 JrhL5tNz3QGnHMeONtxIjR7TYDbQzVxAtUlLJpgonwx98O/xwwDur+U/SXtauMFu5w
	 +DLHBCTPCo3Et6GAbNaYCmGLnE1PZAb8hxFLie3mBDA0TYgQPfK0RjqJ/cEa14SCGA
	 qZLH3GQ6yhWmA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Y8JRQ1zg7z18gL;
	Thu, 12 Dec 2024 11:52:18 -0500 (EST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71e])
 by lists.lttng.org (Postfix) with ESMTPS id 4Y8JRN4k09z19B3
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2024 11:52:16 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/yUIJimeejxfB0iGZrPbNdujTDlVmvsOb2JUNA8Z5fVXduiYH/WI3RnWDRg/I8jVKocOs49NxiTwvolrz9+KPENg3xrHB24T8AcV7uAd5UPH7l9XXCDaSQn5EpHNOTmotkZ323akYBJNjJlBDUe1urE6i4JPvgZHa/zVhCYrjU9lZJodlKepJWScaJZZTLFAs+vMfMa7hZLUkfc3D8DoLsJGev3n0uY/cUuIkZHzSd6cxu8+Lo8TG9jyISpeHEN3Xsq8G3W+eR9ph3PBowt3gIwMynGdcMzt5pZ3r4XEiARJBZMHt+G30ewCQR5+kUOLQBK/yU1d8Xf7e5/dtDe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXafOCLgw1zyclvoJsEHBjXJbNj5vRGTYpmm4UNIiP0=;
 b=rZqAOysmMyNhyciywHgnfSzj7C3+fkrSPlWqp926lNHpaF958EkwSYL1rSRqfon4gvQCXHaUg7Hv2rrvSXzU4yZ9yANlKV8aFejbdDQF1mp5/ecBHUIGsNxgddD0HJvMYKP+LppAaJk2PJ+gQIlmyuUfN2XMT3HK2nXV/paCf8oIsay79t8REd71xrj4jT8CEZiAR9Gct8s7jzs/2xpel+JlfFP0deU+K2/iUFIAN+1f8qAjqcE+psmp87O6CA+1KpXQ69d5/rAOcFifHhHfVQYy7cxTrr8kHDVZdOcQkwFlYTtaVSOZ6UnNQtKBfC18Bjew2Ud6V1phSNAAFBzsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuka.com; dmarc=pass action=none header.from=kuka.com;
 dkim=pass header.d=kuka.com; arc=none
Received: from VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:19e::9) by AM7PR01MB6834.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:1c1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 16:52:12 +0000
Received: from VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 ([fe80::f8aa:3597:6578:79e1]) by VI1PR01MB6845.eurprd01.prod.exchangelabs.com
 ([fe80::f8aa:3597:6578:79e1%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 16:52:11 +0000
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Record stacktraces at userspace tracing domain
Thread-Topic: [lttng-dev] Record stacktraces at userspace tracing domain
Thread-Index: AQHbTLYwTs1zyi17lkS7p8TvKr/qcw==
Date: Thu, 12 Dec 2024 16:52:11 +0000
Message-ID: <VI1PR01MB6845126CAEA7354042BA5E8B823F2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
References: <VI1PR01MB6845D1C81221547CEC94B3A782352@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <CAAS9dobC0wERGMQf9CLjhYY4ay_zSdAMAE9qxBezLtH-kL_1NQ@mail.gmail.com>
 <7f722802-752f-4cf5-ad2f-cb60264d8091@efficios.com>
 <VI1PR01MB684540CF33FFE72F69417E62823E2@VI1PR01MB6845.eurprd01.prod.exchangelabs.com>
 <8b3dc807-e512-4ea9-be7b-39abae58d886@efficios.com>
In-Reply-To: <8b3dc807-e512-4ea9-be7b-39abae58d886@efficios.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Enabled=True;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SiteId=5a5c4bcf-d285-44af-8f19-ca72d454f6f7;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_SetDate=2024-12-12T16:52:10.996Z;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Name=Public;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_ContentBits=0;
 MSIP_Label_717b8430-11b4-47ed-b1b2-7ef5cdca0b43_Method=Privileged; 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR01MB6845:EE_|AM7PR01MB6834:EE_
x-ms-office365-filtering-correlation-id: 7dc24e76-ef0e-4992-8882-08dd1acd52c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gLqOIJNGT1CysmedXb6cqn6xgTqJhEK+7PmE/aotYYdIfRPMfzQZch+pC1?=
 =?iso-8859-1?Q?9L7G/+N0ZQdiA4VWbfcbFdPYsCbG0JbB/antIHnAKpV3Tqm3sBmRRDZOY3?=
 =?iso-8859-1?Q?Mwjsd6qC2gYu1rdxBfqLcftiZ8vqoIQKVc1MaMhUdxdtaGT5DJZI+wKOze?=
 =?iso-8859-1?Q?7Z+vsRO6mjvls/gZNWN5zqruvmHeYdFmJqV3ytG3ZFtFXWd1MpgoYSG1pJ?=
 =?iso-8859-1?Q?5vYZWEfvR6CXW5NxRoyvY7LxSN3l+O/2OR/+icmDxX2uF44PPHhQsRSKfl?=
 =?iso-8859-1?Q?5TiksY/7QxngMFHg3jXdv4GcHLJyTp9f6NHjPC60K5hxkJTDnOfJ00h+9s?=
 =?iso-8859-1?Q?ILtHTblvMsOI0NQyo5bhK0nPiZ73ccRkXTKfQ9UePOtqkO9zS/qm2bfLNe?=
 =?iso-8859-1?Q?ssS9Y7o9vOFY9pCckywmqZOXQFp+qQ+dGFzsQc5fDEsuxdzIDYOScNyaiz?=
 =?iso-8859-1?Q?omIVAaiHg2sTumpmbleURlZvchmg4dVsQRUvRSXxAKYJOZXg43l0DnUQZX?=
 =?iso-8859-1?Q?QwsecyEQnwgGHsq6d47sR4GGvYcVbX6CI1TPMNVbsC4HBluQx+8FNUUz1K?=
 =?iso-8859-1?Q?S/LaHpcXkB1QbH7vDg/e/A/hmRkJUq1TaPgb5MWVlU5vF1aKJXhSVsFBez?=
 =?iso-8859-1?Q?jGxeBaK1CVQ3IIv9GyahDaQnJZGTRBQPZCrpfKYuB9Z14E5eB12AJVyQ2H?=
 =?iso-8859-1?Q?WZ9/n0SN5dyVxv8Znjp7w1DwK24rd+dgrYBWubX8QanRQpnxJ4IksY5KJe?=
 =?iso-8859-1?Q?/IrgV2GknL0IB64lg3v6CFavPS/No3WYFySg4hWRlrta86nlsZ+/V9rC0/?=
 =?iso-8859-1?Q?pJiLBRfVA4m2923MePJfX9GQXnUqhN+Ke39qBGa/riJjmRQxJCJC5h6JeB?=
 =?iso-8859-1?Q?X99JJXXWTkr0okmoS66zp2Oxnw9d5R3XQQNCnq6oZAK+mwYxr9h4ngiACP?=
 =?iso-8859-1?Q?3ZAfKqcVO6MkGxK4C1HxmW/WqHtohPXwm49fmYHAcV28ra/5oqxmbfgTTS?=
 =?iso-8859-1?Q?TC2JiC2AzSE+zWx6S+tCLMxL34v3VyTCeurvnvlfNiNNnQcLW14N1bYDSE?=
 =?iso-8859-1?Q?wJY3Y/nJQ9BX3P4wfp/k5f4dl+cn2c7Gd3O1S5UvLu6RdQlHSjHMQbrycK?=
 =?iso-8859-1?Q?kPxfo3i/bnUCSsMWiQPjf9wKRmHheJjJ4tHj2KGyXvYtnyH1c4+Q9NUCuY?=
 =?iso-8859-1?Q?JELOlra/9YxsDNgpkvdK5ocmYRQNw0fO7k6MPJlrvedBQ1vfAeKf9Sl2Cl?=
 =?iso-8859-1?Q?DHOO3rQP0C1RQr8DSxho9VKPbLCJ8+OO2Vh0NW3C0H9/VDzvYhc6M4hBZl?=
 =?iso-8859-1?Q?z8B8RXWZHUlpxPaDO2eBDOZ2ZoBU8ZiyO9KAFtnZ1HJ4gwTNeA1V+plvgL?=
 =?iso-8859-1?Q?AHZa782hnAugcx8/PMouF56sir0H7AHpuU1uJ+jZLL3M5GpiiITPMLcxvD?=
 =?iso-8859-1?Q?H9PvsN+ZRDGRq65O3qeccJUdOp1NsozcCAf6QA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR01MB6845.eurprd01.prod.exchangelabs.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GaCY1+6Prq8UEHqaNOKwMGSrJzrICuQD4pzV4bYsewOXKAYv8n0K4jU6js?=
 =?iso-8859-1?Q?zjcH1fBghB+dcQsH0t9CblBBQIawcKK8yeCV5WZJi+j+w5VonvCI2LpPb7?=
 =?iso-8859-1?Q?yUma4DSK+QaewggkBPYRpnpI7KGXNLZNpkroo7HLw8mP+PM0zsH3EXpe+R?=
 =?iso-8859-1?Q?49XdIfwWJRijWNLHIlZrermOGvg4IcHwi9bSDvSv2YZBF+5ec56svW/s5t?=
 =?iso-8859-1?Q?m6DYWP64173hKFBWFg/2XRwQ6k+NDWMo4tNki4rrnvSlioSFYKigA2az5q?=
 =?iso-8859-1?Q?ZCv23JEZB0zEoh34nPK8bGSBEcj1QJB9NF+JM2URD9N5oXT4jRYMRiBBDv?=
 =?iso-8859-1?Q?382rIR44KjTww3FUMaJL5rScSL9Brq5MIGDaEnX1GnPHF7R46/WMLu4zDt?=
 =?iso-8859-1?Q?8UuPpIxUHL5x+pLxHlawPFv63rWpSr+jru5v02VBPdvF5JHqrhjtKcbZ7P?=
 =?iso-8859-1?Q?hNBfDdioBBgMme+KwVQFnFh5cLByDGSulRQPLnpwihI9HpaTHaq3lQsCzV?=
 =?iso-8859-1?Q?GwaNJ2JGk2fBqfu5XsesCfl1FU7tXYpaq92UjiBGIQQEXKVdMoo26onbAd?=
 =?iso-8859-1?Q?k3hoKICNMvOwRMJLI2fjh/rX3Uo5HCMA2SPEiQ34WthVgsrHElBXCEvWyl?=
 =?iso-8859-1?Q?fcfeYQoPqbPEz0HTIQ4/hXJOHishbqkbUYwEoi8zR52/edEr8onzWL0fsq?=
 =?iso-8859-1?Q?/6foRTFCdw6ajQ3CM87oumzWDn22zlBc4AGv9tcXefRkHBwfd+DJBhOZuA?=
 =?iso-8859-1?Q?GhOGmmEf/v27MWoUzAFVvJqvhrUt00V+RjoICkQbNu/4BuZXTQ7H/Qhnsf?=
 =?iso-8859-1?Q?8XPLM+pX3mSCurncueA6xptYB8ZFU6Lbqsbk6cCsVApkDZfvs6wzDKJr4D?=
 =?iso-8859-1?Q?m47E3V7gnNIVdc4ImOm2RAW2k96O+9ALmTB4w3dWU5qz3vAlN0ULdaaFOp?=
 =?iso-8859-1?Q?2y4tV9vhodUVvgA3Zvs6iAFlF+z8tg3cJEmb6RQPsuyw7gcU3YzXfJFR+/?=
 =?iso-8859-1?Q?mSBlxDmRf2vGuEPL4PWY+lbT24HRU5jyza2CXo7YYXSI6/68eNJo0YEkZm?=
 =?iso-8859-1?Q?NGhOd0umIDoWE+zLTYg0TmWi+28n1hq8fVg2/dCyyKZSsM+5RFP1fB1mec?=
 =?iso-8859-1?Q?wFWbPhTGBqWqgz9bBaJwsE0nZ4vl8YOx5VpL+Cw2btEfaWhHLH8Ts9yyrV?=
 =?iso-8859-1?Q?H7EKN7yacFMHIwLMOXALm8KBi6pL0ZGkuC7VpWB/mFTbgmqmtF4MpofzRz?=
 =?iso-8859-1?Q?tRWqLhNbuivacjCf3n+BCsS3U4o7OSCp3fH1s7qkVN2FLQe69vfDYJs/Jf?=
 =?iso-8859-1?Q?jIdUkIOtmGbArlJ8PrLyuPB74n6rwZ5lFZDt4tU+Mz6Me2WFrcF5tLuosD?=
 =?iso-8859-1?Q?dRewkXVZYct7SvRF2o+3qeLoZOlryxUOnlIKfQVgYiI6df4oaBYuer43n4?=
 =?iso-8859-1?Q?GOXa/jcg/MkaaT1R/zgHPK7NvW/wHOx99uds28rrJ5hhlL7+LGRaT9vwrT?=
 =?iso-8859-1?Q?B02bhRiimK3y4ad/Zhm7STtU/O3WDqNAcZgUYhIA6fl8aT6Q/Z9Gw8BAKs?=
 =?iso-8859-1?Q?D3/OPimvpt0RsgAY7FapvjIyxJbbu/nQNOHp1QJiTjJmd/qtqRZtnfT2LS?=
 =?iso-8859-1?Q?n1XvUcceBWqo0bBqfQpsJbjIphHEIwN1WE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kuka.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR01MB6845.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc24e76-ef0e-4992-8882-08dd1acd52c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 16:52:11.5536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a5c4bcf-d285-44af-8f19-ca72d454f6f7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hRlLS5JQ+mbxe85Ux64v5gQOfy4lAZ4Kx0FS1h6VANC1Mulkpmxf9A5VrX8Uxkc3bxGFKOM3sP0579ZEeCaM1KCveOnE7jxEYWrGJpUOGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB6834
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

Hi Mathieu,=0A=
=A0=0A=
On 2024-12-11 10:43, Mathieu Desnoyers=A0via lttng-dev wrote:=0A=
> Another approach then is to add tracepoints within your C++ standard=0A=
> library functions. Then you can use the caller ip of _those_ functions=0A=
> and pass them to the tracepoint as "ip" context override.=0A=
That's difficult, as this would require to modify very much code locations =
and may also be difficult due to inlining.=0A=
Also it would just add one extra level, but I think that's not enough.=0A=
=0A=
I'm rather thinking of something similar to this:=0A=
LTTNG_UST_TRACEPOINT_EVENT(=0A=
    ust,=0A=
    malloc_callstack,=0A=
    LTTNG_UST_TP_ARGS(=0A=
        unsigned int, callstack_length,=0A=
        int*, callstack=0A=
    ),=0A=
    LTTNG_UST_TP_FIELDS(=0A=
        lttng_ust_field_sequence_hex(int, callstack, callstack, unsigned in=
t, callstack_length)=0A=
    )=0A=
)=0A=
=0A=
And then use backtrace/libunwind to retrieve the required information and p=
ut it into the tracepoint.=0A=
=0A=
Thanks,=0A=
Alexander=0A=
