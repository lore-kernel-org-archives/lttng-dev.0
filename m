Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DBDC05027
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Feb 2023 21:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1675979699;
	bh=zR6/keYP8ak805BdqzY1NOZizhCG0B/HNuaBMFL1Gr4=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=cwavSe5XftCsxs7EWCl9h3e219R1u5WWoRRm9BeEsZyUtLdX0cL4rhzyX036xWlKr
	 qewc67RzqWROUsmE0FkBIBqYjDmkVdLbPe1nQexB1opT5FnAhG0zokiZ0qhtbqOYaH
	 m4a6eRLEpbf4VokHpAk/kgUNixQEYbtEFl1Q/RFd8D7cHo5RB1pKXEzngHLU4/E+mA
	 1dnysnGU1SJ1/QME7soDmaaucsg9iCpajKM/ZvWte/YcmHK9ec7OCi6YNY4Rby0QyN
	 F433fTN56SN1aaoUQy4JKPU0R4DfCteDborai0b/13wN3zerDuDBxjcoMj4s6FpLyR
	 4L/5rocm9YWAA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PCVyp5QGxz1byH;
	Thu,  9 Feb 2023 16:54:58 -0500 (EST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by lists.lttng.org (Postfix) with ESMTPS id 4PCVyn3fNrz1byF
 for <lttng-dev@lists.lttng.org>; Thu,  9 Feb 2023 16:54:57 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXPr9Svr+Xnj637CrIuhJihcupEmFZyUPTRgkVxFS9RHVkFG2VyhK2+IYf6XF91Lo5vsDgEJu8A6PJ4XZfCuIUI75rchQnRyHrXQ3pHGjyYGAafSMRklcV1R/LQa2LURQfInIRQv4cvJmbtgRbslps47VQrPiB9qDr3RBwAyXvt7LSQSoTfd1NDYASyt2E2L7t1QAoVo3LRh2knL6Ffb/QsiakG2IMvNbctP/w836RmXtUbQV5jupPWCONVknkWJoXk7KVbbEUJvJfWTpAvKN2btHCd1rSbraW9fFRgLB9uDDW3ZH69R9CchMGc/ClxhI7DztMofe4ACLsZbM1xZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmmF1WfE7hTqwfILHn/mutko/MWfYIrX8WC4cgyg6J4=;
 b=dPc7UoIEenzUJaT8ld99kD3FzJoaKhirLpGvTrfuLFz89SpBXfQDRnDQ3IW/qCclD+EGyEqeWBXlnXoMH/KAd4mxt35mmONUNAqLSUBr9U31XaTW5UEqqaD5l5Ma9CkYEQZYpuBkw6Rri7QUE3QTaAwZV+pgzoqUuICDs38/ErJX+oA8lVRY2DBdONAOLs2rHBDwGd/Tjj85vNI5S2c7MgCEYecWOteQPQeZB+KHt/EZBguKWOVTLmR9JhvnLoYYIlAHy4bDqWra1bkLV+tfhU8g1OgO3PDku8vXYKzsxcla6zTpSFNXV7mv6MXYy+rJvrbh1PJ8gMY9+mYk2NIMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT3PR01MB5954.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 21:54:54 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a5d:d20d:1c9d:58b7]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a5d:d20d:1c9d:58b7%2]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 21:54:54 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>,
 "chafraysse@free.fr" <chafraysse@free.fr>
Thread-Topic: [lttng-dev] LTTng UST structure support
Thread-Index: AQHZJDttVP/TZI0+4USL3qyzEYzfV66bO3+AgAWYnQCAGyQggIAKjV0AgADQ620=
Date: Thu, 9 Feb 2023 21:54:54 +0000
Message-ID: <YT2PR01MB59841AA1643770227AEB8A29BCD99@YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM>
References: <233483636.139091746.1675354007888.JavaMail.root@zimbra43-e7.priv.proxad.net>
 <500e3dbe8edfbd0b3369e737288f7409@free.fr>
In-Reply-To: <500e3dbe8edfbd0b3369e737288f7409@free.fr>
Accept-Language: en-CA, en-GB, fr-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB5984:EE_|YT3PR01MB5954:EE_
x-ms-office365-filtering-correlation-id: 7b5f8bb8-6bbe-478d-f47c-08db0ae8470f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+MKuaoTE9J63UOGUh5i9zX6TSg+Rg5yx7t+NkQjQmt9xF9luoHWyDbL8kEpoZueJJwj9KjO9ZqdJKqgKMHt5STgkxOZYWefwcIJ6EVTbyovW2DCjCjXhlHK6ONyrc2Y/ItFahLu3cqFK6e8hFWZFFWs43RhjBQ15AW/2tKlQhB8QEVH+k3UdCv0OpQZzYuDXa33ClAmNJ1n0GGj8bUzNLqyXEz13W8o7QfYGMycBgGu7C07aVN10zm7ws0amCKVOyJtjA5ry4WNoTOlDAJ2UiC2YRq2j0/ErJ847DRMzR7bz/fpAv9JpJXrgkSuzlHUAc3xlbJsr1OF7o7mqewd3baMk7t5X/LgNQ2KhJixAI/+RpA9yrPq1CBSTqMQSrVWX8uvs2KLVJf8xDeWGajbpk0DfYdJrDFJyacLjdQgu9SSf2ouuYLfUpSmj0sCUxLdW3BfeCoLO6FIfKb2R+lzUI0M4zbkTZ1nYlnuA+gcUIozDbkOzJS1zP98ISa2NN1pvk6IQaMhkPEmhGZGw9/CudkYO3lJ2CNkRqCZeVBaq7Pq6Csgv++HTI0yZiCxI+NPpsNeUL3vTkhPz+WvifXQSi5arKTUAzpoVJQVpxUoUhlrlYcjLfAX6ArqYWhOdyFVu3yX5/WnCUXtLOKxRF0X5FSxuWZVv7KVZyinJnNcDcc601vZyKcVGdxNQmNkV28OHqNiZt131KUN/9ZSvSLhHbD2CxzXBpJrT8uXCoYR1h3DhJpkoP4/9ibM7OunNG1crggEBIaStJFGB6sTA9dl1STEUVmVhn87ps1/317mgzwf6vGmgxhwT28+e+dINkS6BAMJEMChnupFftcigiMqsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(366004)(396003)(346002)(39830400003)(376002)(136003)(451199018)(8936002)(52536014)(316002)(6506007)(9686003)(86362001)(38070700005)(26005)(186003)(478600001)(38100700002)(122000001)(55016003)(71200400001)(83380400001)(5660300002)(53546011)(166002)(7696005)(110136005)(966005)(33656002)(66574015)(2906002)(19627405001)(76116006)(8676002)(66946007)(64756008)(66476007)(66446008)(66556008)(41300700001)(91956017)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Pl+ISV6bYovZxbyYLqBmOSsESmqnOcpX7PwuYcAXspBjqgJFE1pKMHx3wK?=
 =?iso-8859-1?Q?NDT2xZUr/F6kLNF8jM68SWgzKNkHU2mdhaiaPFOHKdMLur0rDFNMAooBq6?=
 =?iso-8859-1?Q?mr0YhkfCRzr4WZKL1yUinDt954pvcIPCtPn3EFoR33oTNqyPaMUGKuIAA7?=
 =?iso-8859-1?Q?ojdpT1MuDA2gM65kbgi8KDFAjqty150hwbivo29GRPPLeTPhaygU60H/T8?=
 =?iso-8859-1?Q?viEQW48VvyxqcT28Va1cZQz46o6MJTCAHDD0/UmkTRCu85FS6QU/fM2yxc?=
 =?iso-8859-1?Q?WOswBzCnigJO86ShBmyX0lcDIDbJ1GBfr9zGR1+HKXySunN9koWdFG9XMF?=
 =?iso-8859-1?Q?5C9y/I1fe9vaI+5/nf7elB+f3yWVHrhLWi0ZREswfqJvADx6MnXoeA64zK?=
 =?iso-8859-1?Q?qq0UZTQJPEZCx82KWsKEp++ybmvXnZRR40htsdPFRJqHV2jlgDh5Kv0bqS?=
 =?iso-8859-1?Q?UJrj5OWJ4vdOD4opg7abFY4AfUe2nb/GDfvr+8eyO6tnvoJrrNDV01dHFp?=
 =?iso-8859-1?Q?mGVl7/qUY5wwFRGrZ537ilcbMdYGWZsNirOGttLjD1bGNSwiwli7L3QbOG?=
 =?iso-8859-1?Q?x0nRNFqvqMCT4f0hCgguKqF+Byz9W/EaB/7CzVF6USsGodA2J31BodP9Jg?=
 =?iso-8859-1?Q?IFyrMfOwlUTkGHWErSU10+3WI8aO9nkkqjcMJbxkxR1C/t3lGu2wT1I+B/?=
 =?iso-8859-1?Q?07WyjVIacVPOR4pI64oG/rVule4ZgwMq9pUPeHQLUI02009ZgAc5NZvZ2j?=
 =?iso-8859-1?Q?zDN84xwe1uttR+8ykhmyZW3scrdvcDxotmfN+rvDtrjNhZZdHWiYSAmocb?=
 =?iso-8859-1?Q?GrOA37O3IozH5Bp4fNkYWqGREsPzkodwU2gFRcX1/z3Kf+NKGxORtM5R/m?=
 =?iso-8859-1?Q?ao1fEskGUMcTRmea6guD0wlinUROgsqh3+xq336aCwgRC4/n6WAzvlozXl?=
 =?iso-8859-1?Q?I79IFiuC2l9zZT5YaU3I+E+YCM/oQVphokCC+XGo1NRUgUpwoMkZogofHr?=
 =?iso-8859-1?Q?+qruT3yGwxWUJGjHWFc88lUbBSXHiUKuUdJnK+d2keyLl2z2WhogKYECFe?=
 =?iso-8859-1?Q?dMxpBoCBb+eCsOQdsKGE+9ByZAeZtjLDOBeBQ/zZFq47vRe3K3O1E8+GOw?=
 =?iso-8859-1?Q?pdmBd6OVpXDeAjpG571ZAhF5e5dYwzGHjWIBnT9gF0cYDNGd38/yJU+WCq?=
 =?iso-8859-1?Q?ylotFO/qy+Hw3tMUq7Vpsf3O12izrR9jTDbhD/JxY+zDtwSucO+NzrvR6p?=
 =?iso-8859-1?Q?S8CdnkqAr4byqahu4ZXV4XwBr9xtx5bZks90U/AMA7NL+I47XoHOZdokgw?=
 =?iso-8859-1?Q?qawVE8zDHtULolK5SG1hcRq1XH9uV8Plk+M4QpTogoS/xPf28j4Qa2lgTe?=
 =?iso-8859-1?Q?gsueJ6p6QzgVWO2UGb9UKMQqfkBq0RgFufC4/wxk9bKrT3mFTxkGqziCQX?=
 =?iso-8859-1?Q?r1bav6aWqUHMUJ2V2AVPISjVG4+9YmMBX6HZcyWASk8T3NV94eLCFC0Uko?=
 =?iso-8859-1?Q?6zluSZjmastzKPuI9eItEJsSt4aW27lZAoKmsV2ZES2BRcXKkJNMf/c9Mp?=
 =?iso-8859-1?Q?ZXsRGjxPRwii/ASyS/Tt8C7IWwp63OvhvOBC9L/0JsMP88fz5D/4lTru9c?=
 =?iso-8859-1?Q?BTz7c80Ldky7P/DQrTkoUpXuYkju8lioX7?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5f8bb8-6bbe-478d-f47c-08db0ae8470f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 21:54:54.3663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBl6Y/H7cb5bLyEkxmwarK7xWFsVY/8D97hm6Br7mQDPhN3sbnZyRqfSjhKnMqoAUTB/hDkY1ki7tFt9ihPxjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5954
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
Content-Type: multipart/mixed; boundary="===============6535963233497509338=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6535963233497509338==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_YT2PR01MB59841AA1643770227AEB8A29BCD99YT2PR01MB5984CANP_"

--_000_YT2PR01MB59841AA1643770227AEB8A29BCD99YT2PR01MB5984CANP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Charles,

I'm not sure why you can't embed a graph in your application. The idea is t=
o make new events visible to your source component (or the iterator it prov=
ides) by exposing some form of "user data" as a shared context [1][2]. When=
 the event is made available to the source through that context, your "writ=
e" function can then pass it down the graph by invoking the graph's "run" m=
ethod.

I'll see if I can find time to produce an exemple if you think it would be =
helpful.

Regards,
J=E9r=E9mie

[1] https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-self-msg-ite=
r.html#gaa0795c9c18725a844df5b5c705255977
[2] https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-self-comp.ht=
ml#gae01283b1ee0c3945c4f54205a1528169
[3] https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-graph.html#g=
ad2e1c1ab20d1400af1b552e70b3d567c

--
J=E9r=E9mie Galarneau
EfficiOS Inc.
https://www.efficios.com
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of chafraysse=
--- via lttng-dev <lttng-dev@lists.lttng.org>
Sent: February 9, 2023 04:15
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] LTTng UST structure support

Hi J=E9r=E9mie,

Thx for your reply,
I'm doing a mockup on an Ubuntu host for now
Ok for the graph, I cannot embed it in my application though
I wanted that application to directly output CTF (with compound types,
excluding LTTng) but I guess I'll output it in my format and then
post-process it in a bt2 graph with a custom source and the ctf sink

Best regards,

Charles

> Hi Charles,
>
> I can't really comment on what the packages do, but babeltrace2
> provides those headers under "include/babeltrace2-ctf-writer" since
> that library is somewhat "grafted" to the project. Which distro are you
> using?
>
> As for where to "plug" your bindings, that library is there to maintain
> compatibility with the ctf-writer library that was provided by
> Babeltrace 1.x as it had a number of external users. I don't expect it
> to keep up with new CTF versions.
>
> A more "future proof" integration point is to write a source component,
> and instanciate it in a graph configured with the CTF filesystem sink,
> and feed your events through the graph.
>
> Let me know if you want more information,
> J=E9r=E9mie
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> https://www.efficios.com
>
> Le 2023-02-02 17:06, chafraysse@free.fr a =E9crit :
> Hi,
>
> So I wrote a draft of Rust lib above ctf-writer, using the apis as
> demonstrated in the ctf-writer test
> For deployment I wanted to use "libbabeltrace2-ctf-writer.so" in the
> "libbabeltrace2-dev" package but I could not locate the matching
> includes in there or in the other babeltrace 2 packages
> Did I miss them somewhere ? Should I have plugged in at another level
> in babeltrace2 ?
>
> Best regards,
>
> Charles
>
> ----- Mail original -----
> De: chafraysse@free.fr
> =C0: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Envoy=E9: Lundi 16 Janvier 2023 10:38:28
> Objet: Re: [lttng-dev] LTTng UST structure support
>
> Hi Mathieu,
>
> Thanks for your reply :)
> I'll stick to bt2 modules in the meantime then
> I'll already be saving a ton of time with those and the CTF spec which
> is great !
>
> Best regards,
>
> Charles
>
> ----- Mail original -----
> De: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> =C0: chafraysse@free.fr, lttng-dev@lists.lttng.org
> Envoy=E9: Jeudi 12 Janvier 2023 21:10:57
> Objet: Re: [lttng-dev] LTTng UST structure support
>
> On 2023-01-09 09:02, chafraysse--- via lttng-dev wrote:
>> Hi,
>>
>> I'm looking for a CTF writer to serialize instrumentations in an
>> embedded Linux/Rust framework
>> LTTng UST looked like a very strong option, but I want to serialize
>> structures as CTF compound type structures and I did not see those
>> supported in the doc or api
>
> This is correct. I am currently working on a new project called
> "libside" (see https://git.efficios.com/?p=3Dlibside.git;a=3Dsummary) whi=
ch
> features support for compound types.
>
> However, we still need to do the heavy-lifting implementation work of
> integrating this with LTTng-UST. This is the plan towards supporting
> compound types in LTTng-UST.
>
>> I'd love to have confirmation that I did not just miss something :)
>> If LTTng UST is out for me I will probably try to use the ctf-writer
>> module of babeltrace 2 instead
>
> For now the ctf-writer modules of bt2 would be an alternative to
> consider, but remember that it is not designed for low-impact tracing
> such as lttng-ust. So it depends on how much tracer overhead/runtime
> impact you can afford in your use-case.
>
> Thanks,
>
> Mathieu
>
>>
>> Best regards,
>>
>> Charles
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_000_YT2PR01MB59841AA1643770227AEB8A29BCD99YT2PR01MB5984CANP_
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
I'm not sure why you can't embed a graph in your application. The idea is t=
o make new events visible to your source component (or the iterator it prov=
ides) by exposing some form of &quot;user data&quot; as a shared context [1=
][2]. When the event is made available to
 the source through that context, your &quot;write&quot; function can then&=
nbsp;pass it down the graph by invoking the graph's &quot;run&quot; method.=
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
I'll see if I can find time to produce an exemple if you think it would be =
helpful.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
J=E9r=E9mie</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0">
[1]&nbsp;<a href=3D"https://babeltrace.org/docs/v2.0/libbabeltrace2/group__=
api-self-msg-iter.html#gaa0795c9c18725a844df5b5c705255977" id=3D"LPlnk10995=
0">https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-self-msg-iter=
.html#gaa0795c9c18725a844df5b5c705255977</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1">
[2]&nbsp;<a href=3D"https://babeltrace.org/docs/v2.0/libbabeltrace2/group__=
api-self-comp.html#gae01283b1ee0c3945c4f54205a1528169" id=3D"LPlnk333868">h=
ttps://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-self-comp.html#ga=
e01283b1ee0c3945c4f54205a1528169</a></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted0 ContentPasted1 ContentPasted2">
[3]&nbsp;<a href=3D"https://babeltrace.org/docs/v2.0/libbabeltrace2/group__=
api-graph.html#gad2e1c1ab20d1400af1b552e70b3d567c" id=3D"LPlnk394072">https=
://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-graph.html#gad2e1c1ab=
20d1400af1b552e70b3d567c</a></div>
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
ev-bounces@lists.lttng.org&gt; on behalf of chafraysse--- via lttng-dev &lt=
;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> February 9, 2023 04:15<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Subject:</b> Re: [lttng-dev] LTTng UST structure support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi J=E9r=E9mie,<br>
<br>
Thx for your reply,<br>
I'm doing a mockup on an Ubuntu host for now<br>
Ok for the graph, I cannot embed it in my application though<br>
I wanted that application to directly output CTF (with compound types, <br>
excluding LTTng) but I guess I'll output it in my format and then <br>
post-process it in a bt2 graph with a custom source and the ctf sink<br>
<br>
Best regards,<br>
<br>
Charles<br>
<br>
&gt; Hi Charles,<br>
&gt; <br>
&gt; I can't really comment on what the packages do, but babeltrace2 <br>
&gt; provides those headers under &quot;include/babeltrace2-ctf-writer&quot=
; since <br>
&gt; that library is somewhat &quot;grafted&quot; to the project. Which dis=
tro are you <br>
&gt; using?<br>
&gt; <br>
&gt; As for where to &quot;plug&quot; your bindings, that library is there =
to maintain <br>
&gt; compatibility with the ctf-writer library that was provided by <br>
&gt; Babeltrace 1.x as it had a number of external users. I don't expect it=
 <br>
&gt; to keep up with new CTF versions.<br>
&gt; <br>
&gt; A more &quot;future proof&quot; integration point is to write a source=
 component, <br>
&gt; and instanciate it in a graph configured with the CTF filesystem sink,=
 <br>
&gt; and feed your events through the graph.<br>
&gt; <br>
&gt; Let me know if you want more information,<br>
&gt; J=E9r=E9mie<br>
&gt; <br>
&gt; --<br>
&gt; J=E9r=E9mie Galarneau<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
&gt; <br>
&gt; Le 2023-02-02 17:06, chafraysse@free.fr a =E9crit&nbsp;:<br>
&gt; Hi,<br>
&gt; <br>
&gt; So I wrote a draft of Rust lib above ctf-writer, using the apis as<br>
&gt; demonstrated in the ctf-writer test<br>
&gt; For deployment I wanted to use &quot;libbabeltrace2-ctf-writer.so&quot=
; in the<br>
&gt; &quot;libbabeltrace2-dev&quot; package but I could not locate the matc=
hing<br>
&gt; includes in there or in the other babeltrace 2 packages<br>
&gt; Did I miss them somewhere ? Should I have plugged in at another level<=
br>
&gt; in babeltrace2 ?<br>
&gt; <br>
&gt; Best regards,<br>
&gt; <br>
&gt; Charles<br>
&gt; <br>
&gt; ----- Mail original -----<br>
&gt; De: chafraysse@free.fr<br>
&gt; =C0: &quot;Mathieu Desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&=
gt;<br>
&gt; Cc: lttng-dev@lists.lttng.org<br>
&gt; Envoy=E9: Lundi 16 Janvier 2023 10:38:28<br>
&gt; Objet: Re: [lttng-dev] LTTng UST structure support<br>
&gt; <br>
&gt; Hi Mathieu,<br>
&gt; <br>
&gt; Thanks for your reply :)<br>
&gt; I'll stick to bt2 modules in the meantime then<br>
&gt; I'll already be saving a ton of time with those and the CTF spec which=
<br>
&gt; is great !<br>
&gt; <br>
&gt; Best regards,<br>
&gt; <br>
&gt; Charles<br>
&gt; <br>
&gt; ----- Mail original -----<br>
&gt; De: &quot;Mathieu Desnoyers&quot; &lt;mathieu.desnoyers@efficios.com&g=
t;<br>
&gt; =C0: chafraysse@free.fr, lttng-dev@lists.lttng.org<br>
&gt; Envoy=E9: Jeudi 12 Janvier 2023 21:10:57<br>
&gt; Objet: Re: [lttng-dev] LTTng UST structure support<br>
&gt; <br>
&gt; On 2023-01-09 09:02, chafraysse--- via lttng-dev wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt; <br>
&gt;&gt; I'm looking for a CTF writer to serialize instrumentations in an<b=
r>
&gt;&gt; embedded Linux/Rust framework<br>
&gt;&gt; LTTng UST looked like a very strong option, but I want to serializ=
e<br>
&gt;&gt; structures as CTF compound type structures and I did not see those=
<br>
&gt;&gt; supported in the doc or api<br>
&gt; <br>
&gt; This is correct. I am currently working on a new project called<br>
&gt; &quot;libside&quot; (see <a href=3D"https://git.efficios.com/?p=3Dlibs=
ide.git;a=3Dsummary)">https://git.efficios.com/?p=3Dlibside.git;a=3Dsummary=
)</a> which<br>
&gt; features support for compound types.<br>
&gt; <br>
&gt; However, we still need to do the heavy-lifting implementation work of<=
br>
&gt; integrating this with LTTng-UST. This is the plan towards supporting<b=
r>
&gt; compound types in LTTng-UST.<br>
&gt; <br>
&gt;&gt; I'd love to have confirmation that I did not just miss something :=
)<br>
&gt;&gt; If LTTng UST is out for me I will probably try to use the ctf-writ=
er<br>
&gt;&gt; module of babeltrace 2 instead<br>
&gt; <br>
&gt; For now the ctf-writer modules of bt2 would be an alternative to<br>
&gt; consider, but remember that it is not designed for low-impact tracing<=
br>
&gt; such as lttng-ust. So it depends on how much tracer overhead/runtime<b=
r>
&gt; impact you can afford in your use-case.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; <br>
&gt; Mathieu<br>
&gt; <br>
&gt;&gt; <br>
&gt;&gt; Best regards,<br>
&gt;&gt; <br>
&gt;&gt; Charles<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; lttng-dev@lists.lttng.org<br>
&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt; <br>
&gt; --<br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href=3D"https://www.efficios.com">https://www.efficios.com</a><br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http=
s://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_YT2PR01MB59841AA1643770227AEB8A29BCD99YT2PR01MB5984CANP_--

--===============6535963233497509338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6535963233497509338==--
