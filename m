Return-Path: <SRS0=fpp6=IW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96116C433C1
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 19:08:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2036619F3
	for <lttng-dev@archiver.kernel.org>; Wed, 24 Mar 2021 19:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2036619F3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F5Hns2TrGzMjX;
	Wed, 24 Mar 2021 15:08:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1616612913;
	bh=IizxPZHtt5PuTkLqbTQOCuTnm4ik8uWPSvC5Vj+F/SQ=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EqKK9axInEttoS6LnwRvRApGxaS27z1Qedo9na3Tco0AfINygLdPiprsAqgxNFIQy
	 X7zjkn9skGo1i/DUK8fKpM2shsbUx3OO1acgzrbhxswG+t1Xq7LtcEAyxEPJq8j2oB
	 X/O9ObaXZtYiu9E8ktrtM/H7Qfjqre3S+ikvbVEifcG9dSZ2A92QIx/M3mfMged2LV
	 hnofzN5+8fos/BvJ832c7Qj4akV/Dc10J3+Xjr9Dn09lsWHj89wNA58K6j/Ij4l2F3
	 5Gpd63oWUchsvse7odOmGFlNY+eAbEib0qvpBkn+gFCYBMGOL5dy59f/VXS8MrB4NH
	 LEJNpHMmUcb8w==
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
 by lists.lttng.org (Postfix) with ESMTPS id 4F5Hnq0M5szMjV
 for <lttng-dev@lists.lttng.org>; Wed, 24 Mar 2021 15:08:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiwNkLefrNyoiG1LSu3EorZLewWHp5a6HTW1pvpzdlo7XApAa0sQadEojALHy/w00evn9HAMwazsNKjvD18YumwVvFQjj1Gm1GB9SZ2RIlSdmWaqc053Dd9cdftgFqVe4VSld0XfxDAZx94f957uJ3Uq+0pV9LEJYIN+bwZtYBJ4sWVLdJiYaswvjxIAnxyW3jggBc0woMCrbP5N197plMPNRmEz709lWI6TtzyubKBafItKSULcdtuQt3CVX8ecdKRuOp0U54HM6Is0rvmM/FLtED1xy1h2o/OLrzgnesoR61/lMzpv6YY6cPszahQ84VLD+7FHSFiAzXdCN9gPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd6s9REifWz8552CoMMTevFQlK0FKv+mV+zjEBnau3I=;
 b=PW9UjbQWm4wmhTYR+B8ONUxEJkwuBw6MrSBLR+QvwBoj8tYFGY7DYe/Ji1z+uNggg/ifPkz+TdXqO6RYoV4PocULzSy68VxI97/pu2rwCBQBRKgsk8BMFrToCo7aYGo6riAiVv39w+CKHlEDFyXbm6U8VtIZO9toQ3NKLPXVvblq/RwKXEZZSLkqISp0JLwgGi2Q3bQ4nzLm9Prw6TAE38ygKagDC3c8hTtnItyVWyuyZ3ueZvbX8guLfhLoIUqsf3f5m0LEM+qdlXCRsirIJcY0gBcqaMukzHZ1u3nuWT3DlJQjjrO6wjXRuyQvnM/9VyQuyxuuY+bZBiP82mrJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=reseau.eseo.fr; dmarc=pass action=none
 header.from=reseau.eseo.fr; dkim=pass header.d=reseau.eseo.fr; arc=none
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com (2603:10a6:102:63::15)
 by PR3PR02MB6347.eurprd02.prod.outlook.com (2603:10a6:102:7c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 19:08:28 +0000
Received: from PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482]) by PR3PR02MB6202.eurprd02.prod.outlook.com
 ([fe80::9183:a57e:a921:f482%7]) with mapi id 15.20.3977.025; Wed, 24 Mar 2021
 19:08:28 +0000
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
Thread-Index: AQHXIJ8+s4nBMhgB0EaYFg2Q2oJLGaqTMeIAgAADJsmAAA+lgIAAAWh+gAAH+ICAAAhNgIAAI39wgAAE74CAAAGV+g==
Date: Wed, 24 Mar 2021 19:08:27 +0000
Message-ID: <PR3PR02MB62025CCA7D6372430CC89AF7D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <PR3PR02MB62023431654FB93182EA21A1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324142540.GB344120@joraj-alpa>
 <PR3PR02MB6202F969540C279A6A171F83D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324153255.GC344120@joraj-alpa>
 <PR3PR02MB620209CCED35CC62E1C8550FD1639@PR3PR02MB6202.eurprd02.prod.outlook.com>
 <20210324160629.GE344120@joraj-alpa> <20210324163611.GF344120@joraj-alpa>
 <PR3PR02MB6202B24C2EBFF492A659DFF1D1639@PR3PR02MB6202.eurprd02.prod.outlook.com>,
 <20210324190053.GG344120@joraj-alpa>
In-Reply-To: <20210324190053.GG344120@joraj-alpa>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.20.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cea80d38-a304-42a6-d045-08d8eef834ee
x-ms-traffictypediagnostic: PR3PR02MB6347:
x-microsoft-antispam-prvs: <PR3PR02MB6347E71637D3F40DDCF605C4D1639@PR3PR02MB6347.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kcEnd8MDDBZE26BwTPT1vHjTsQoX7lj84itXpqVsnVqiLi9gA6i+uS2CHoY/bCMJ/mMCr3fYjfPqGCala+4rCfT3ZPOJtER43peKxMIv7jIYe2u9j82KICjJzpaiyRDzLyEm2jjx1OWeQFJ5aaH9zQrm5Ndd51G6BURTw5MUBeSNDTpCYkIERAYTZwsHQNWjD5FBcgfWa1Xyh83BcJVTuaUS6/GbwrRt/GIBPXAWStZ7hvyIAX4jvHDhfJmvgM9n9V5gBiW+AMJyEbLYUU9k2+zHeGNdIZne5w1IxSIvg6MYhDcDLfn4VU6UfjEXKNcCHVBxuBlpLyAEKYjPyCwbWd3UgNmoWhFkiD9Oq9+XbVf/ZTVcsOygGJD35yliF/wGgdws3n2FBFd9X+8LF/tlw/JM87ILrzilkPlnSPUa88o4hNAct88omMdh40OwUP/xjMin5i/o4Qd+Fe1P6p4LVmxI05HsCWjmMsW5bKo1PHnEU2uUGUC2yOfkazDK4uqhFfxUT695bD6/Jk8L/rMIbARyTA/K33jYkDT5/SAtKeZ6Q+v3FGR3mdwxNPD0nbpW2roMOtfYSMdAdTFlfXBt5Pzs3euoMgardptP/bnI8q9Fc4oFYR9x5QxLcsTN4oX3hDSEvVpMbzlmltPLDXAnAdYHFBHMfQz5AmijJpfYd/ZCRQPRwnN56VKfWRCpqU3pG65FuTRSRjZOh90tTu7nGk5Jx67kS/hLubJtI4nH2yE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR3PR02MB6202.eurprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39850400004)(366004)(86362001)(55016002)(4326008)(33656002)(71200400001)(38100700001)(8676002)(316002)(9686003)(2906002)(6916009)(478600001)(26005)(186003)(166002)(786003)(66476007)(7696005)(8936002)(66946007)(64756008)(66446008)(52536014)(19627405001)(66556008)(5660300002)(76116006)(55236004)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?mnOCeYX1v0YiOGkBnjNl3W/tbIRlg/ydBCh1m57fkKInQd3OwGgY6J8JNT?=
 =?iso-8859-1?Q?7Mboy6A/Q89Plt18l9OB8xd1trmQZitenhOxmlrTsE2XGWSLfa7hJ/6cTr?=
 =?iso-8859-1?Q?Pg+D3YIep65eirmuPgnQwbne2T8RamkLg5m13Yqy7drsGr+NaoaX7SYEoM?=
 =?iso-8859-1?Q?JCdW1n28R4aZ3zWMz2IyUM2AHnD6hcNwnWjRbucaYmIIXhNgOQFYgho5JG?=
 =?iso-8859-1?Q?pqgju1xE+SXvnu5LQASwADFjF7Kj7AfNAHDQN8jaR8K0fXSRJAuhnY+MEA?=
 =?iso-8859-1?Q?wfkXC8jH9hjKXLZCSTs1knb0k0QqRwnhue+y7kHgrX3R9DWlr8fzwdcQAv?=
 =?iso-8859-1?Q?+VoPSfmkczCkDjU40g3p7mB6Q9WSbEmrE00TSihIiPu7b8wlhfWKfD3d/N?=
 =?iso-8859-1?Q?5gnyNH7ifJ9S9P9uvtd8wJeBRp0cRjQTbnUmPReDSwHa4sD/Ni+zg8dBbN?=
 =?iso-8859-1?Q?cIXewj+RcPHv4FBR9Pm4vPduQACQ6GWqjpBawb3gq+AodIo/nh6S0i2es6?=
 =?iso-8859-1?Q?+uSCWBukGmAgQSaemG2LfP5U5F3qc2SFSSp6MJ+JjMoxjtGCLhZ29jxOk/?=
 =?iso-8859-1?Q?psPYA1SpbHvx1OB4OllM3/usWNl6HQdV9IqHt5Z3tAvm3+Job7Gz29bnqH?=
 =?iso-8859-1?Q?yfU1NIriP4FE4cDu8XmKl4jSdqLWkervmH61Ho23BV0aZrxrQ2Mwl+c9cr?=
 =?iso-8859-1?Q?M6uUgVHEX8yWDaQqwduTAnauCXSGmW7y1uQlNeBa1Q0CKGYpkPAipKOR8V?=
 =?iso-8859-1?Q?nwi6exd2i0ClqbDzwxPRjvz2p4xvr5vFTIn6Oewj7Hg9mm3n1sFq115KkG?=
 =?iso-8859-1?Q?TdyOAdWgsJ7bzIhUr7CxcNn1ZGnwXC+gtX6uBpoJym4UynplPkFDZQeiyU?=
 =?iso-8859-1?Q?X/oOZOW9cYEU7Z4nZfMph+30AE/HyLcj1JaP/cIqHKXU4jM6EPkrpaqMfv?=
 =?iso-8859-1?Q?hCcBZzfQMEPZPpFpkj80l6wJtUwHFr56j+56Kr694/RSJYODdy9YwZAVFJ?=
 =?iso-8859-1?Q?Pa2Pyyw3Hq6QovJ4YgXuupPXp+fGLb6fZwrUdEmJOeZmCriRh81Iv54vNm?=
 =?iso-8859-1?Q?zOx5bynG+0XDhfmOcSovAOlp1YACNlpWEMS2NGjF1bthjn6e2DHFzYdFrU?=
 =?iso-8859-1?Q?z4euMkdnX5ii5agN1+J45aiG46lxC9x/BKG9weN6gwWQ7SJaw0CMJoa1Gd?=
 =?iso-8859-1?Q?4Ba7FGVANSJfErwhPnN63g3F/NBd5Gwi7SgdTYFmQF+xdDT3NuTJP9KK2i?=
 =?iso-8859-1?Q?BSjlQvGAZAIM3ww+BOCxUOOpt7MKEQ6D2JKFcLPDMJB09v/qVckkUMgWxF?=
 =?iso-8859-1?Q?HjtHXFhJIoW/SoJE9Uk7Scy0yeWVFeunB/xPNThcfxxtgbQ=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: reseau.eseo.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6202.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea80d38-a304-42a6-d045-08d8eef834ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 19:08:27.8509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d7ad159-1265-437a-b9f6-2946247d5bf9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5VoCz4gap8xRyGnwknfBs5P9flZpG16/XCaWc8pQab0Gvr69zXDQuJ0VHWHlH5De8zLwroFlKyKryh6QBvFexZ3tR3EyipSY3ediV4UZiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6347
Subject: Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)
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
Content-Type: multipart/mixed; boundary="===============2886123420558877733=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2886123420558877733==
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_PR3PR02MB62025CCA7D6372430CC89AF7D1639PR3PR02MB6202eurp_"

--_000_PR3PR02MB62025CCA7D6372430CC89AF7D1639PR3PR02MB6202eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you so much, it is 100% working.

Let's enjoy LTTng !!!

Have a nice day,

________________________________
De : Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Envoy=E9 : mercredi 24 mars 2021 20:00
=C0 : MONTET Julien <julien.montet@reseau.eseo.fr>
Cc : lttng-dev <lttng-dev@lists.lttng.org>
Objet : Re: [lttng-dev] Issues on basic LTTng trace userspace (tutorial)

On Wed, Mar 24, 2021 at 06:55:37PM +0000, MONTET Julien wrote:
> Hi Jonathan,
>
> You are absolutely right !
> I have two different lttng :   find /usr -name "*liblttng-ust*" Ubuntu Pa=
stebin<https://paste.ubuntu.com/p/NVtXPhj4fW/>

Glad to know that we are making progress.

>
> According to you, what would be the best solution to solve this issue ?
> I have indeed a folder named lttng-ust where I have made the (wrong) conf=
igure / make.

Go into the lttng folder and do:
  sudo make uninstall
  sudo ldconfig

>
>
> I tried to (temporary) remove all the libttng* /usr/local/lib/, but I fac=
e this problem :

That should works also.

> /usr/bin/ld: hello-tp.o: in function `__lttng_events_init__hello_world':
> hello-tp.c:(.text+0xe56): undefined reference to `lttng_ust_probe_registe=
r'
> /usr/bin/ld: hello-tp.o: in function `__lttng_events_exit__hello_world':
> hello-tp.c:(.text+0xeb2): undefined reference to `lttng_ust_probe_unregis=
ter'
> collect2: error: ld returned 1 exit status

Did you remove the -L/usr/local/bin flag? There should be no reason to keep=
 it
at this point.

>
> In the worst case scenario I am able to get my last clean snapchot.

That is also a good bet :).

--
Jonathan Rajotte-Julien
EfficiOS

--_000_PR3PR02MB62025CCA7D6372430CC89AF7D1639PR3PR02MB6202eurp_
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
: 12pt; color: rgb(0, 0, 0);">
Hi Jonathan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you so much, it is<span style=3D"background-color:rgb(255, 255, 255);=
display:inline !important"><span>&nbsp;</span>100%&nbsp;</span>working.</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Let's enjoy LTTng !!!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Have a nice day,</div>
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"color:rgb(0,0,0); fon=
t-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Sym=
bol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:12pt">
<p></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>De :</b> Jonathan Rajotte-Julie=
n &lt;jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Envoy=E9 :</b> mercredi 24 mars 2021 20:00<br>
<b>=C0 :</b> MONTET Julien &lt;julien.montet@reseau.eseo.fr&gt;<br>
<b>Cc&nbsp;:</b> lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Objet :</b> Re: [lttng-dev] Issues on basic LTTng trace userspace (tutor=
ial)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Mar 24, 2021 at 06:55:37PM +0000, MONTET J=
ulien wrote:<br>
&gt; Hi Jonathan,<br>
&gt; <br>
&gt; You are absolutely right !<br>
&gt; I have two different lttng :&nbsp;&nbsp; find /usr -name &quot;*libltt=
ng-ust*&quot; Ubuntu Pastebin&lt;<a href=3D"https://paste.ubuntu.com/p/NVtX=
Phj4fW/">https://paste.ubuntu.com/p/NVtXPhj4fW/</a>&gt;<br>
<br>
Glad to know that we are making progress.<br>
<br>
&gt; <br>
&gt; According to you, what would be the best solution to solve this issue =
?<br>
&gt; I have indeed a folder named lttng-ust where I have made the (wrong) c=
onfigure / make.<br>
<br>
Go into the lttng folder and do:<br>
&nbsp; sudo make uninstall<br>
&nbsp; sudo ldconfig<br>
<br>
&gt; <br>
&gt; <br>
&gt; I tried to (temporary) remove all the libttng* /usr/local/lib/, but I =
face this problem :<br>
<br>
That should works also.<br>
<br>
&gt; /usr/bin/ld: hello-tp.o: in function `__lttng_events_init__hello_world=
':<br>
&gt; hello-tp.c:(.text+0xe56): undefined reference to `lttng_ust_probe_regi=
ster'<br>
&gt; /usr/bin/ld: hello-tp.o: in function `__lttng_events_exit__hello_world=
':<br>
&gt; hello-tp.c:(.text+0xeb2): undefined reference to `lttng_ust_probe_unre=
gister'<br>
&gt; collect2: error: ld returned 1 exit status<br>
<br>
Did you remove the -L/usr/local/bin flag? There should be no reason to keep=
 it<br>
at this point.<br>
<br>
&gt; <br>
&gt; In the worst case scenario I am able to get my last clean snapchot.<br=
>
<br>
That is also a good bet :).<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</div>
</span></font></div>
</body>
</html>

--_000_PR3PR02MB62025CCA7D6372430CC89AF7D1639PR3PR02MB6202eurp_--

--===============2886123420558877733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2886123420558877733==--
