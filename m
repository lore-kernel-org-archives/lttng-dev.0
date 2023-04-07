Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B56EC6FD1D
	for <lttng-dev@archiver.kernel.org>; Fri,  7 Apr 2023 20:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1680898435;
	bh=vBz04rotUFG2RTsbaF2WbKlHgNmVn8wBdFr2/xAp+Y8=;
	h=To:CC:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=zy48M88OFrINBoqo6ZEmwjz3QTt8ayjRB3vmw6tGBojUCYL9c9iGqYdGne8imuhPM
	 ZMgq/SOazf3BY0wo90hvJYz4qqRjHHjwx4+wDAckUgHd/XuJ2t9X3/ay3ufEAGxPkD
	 +yG5MNwic+QMQQfKcKKKecvFUK+0yiJdGiLo/ysVZqU4jI62n+DfYlyGyEhwbSicSy
	 LKtG02nbLFI5XMyGrI9TI9S7B386qHLYBeIdpPDOxTB8izW2F4LfWVewC25dVNQf3e
	 whMwdqDjAqF/4V1XClKKc6TwrE4lWDRmhdjmC1V83OdEsWdVxZYNEGOj9Tm8P5/4Hu
	 1TP4QDnMzUesw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PtV1v02Mtz2NjL;
	Fri,  7 Apr 2023 16:13:54 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2065.outbound.protection.outlook.com [40.107.116.65])
 by lists.lttng.org (Postfix) with ESMTPS id 4PtV1s35mWz2Nsw
 for <lttng-dev@lists.lttng.org>; Fri,  7 Apr 2023 16:13:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs02jXO4sVcyAN71CRP1y1IR8P/xNYEm2uigXoPN5fUtw+g3A3Kpkv33YRB0eELyfRSqWvC9dbgdDeBd5hPoh71c2voOlkPjy6jsSJRQEL5ewziN0yvMU6ATta4dHcWT0Kc2/pu8quxXMJHljsd0BUVwF7Evy+s4eMD2J7K4XsfSDs0/F7Td+x/4JGOBtDitWaKFab/6NpwDLbMYK0hUTaY2ydm16j7YmrVOB7vkXm+/x4VoUdzcD3MAxvCdPOGVI3dKA3GBJoaaaf9lDAxCXGoUiw6s0AvVV41ZIdd+eoCm2SesC3aWRWyhVmxfdmBmf/pqWHvCvjrzmCENvP1Beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlbrIqUye/0+FUaAH/qRJFHdyNKgSQYrKsZK7Qa0rbQ=;
 b=NH1f//MSZR7xQZuLj+xOvKFx8byv/sRphe3WaHvIckQbYVP2+/WZNKpcxWY/5D85skaKydz5UGXeXWV0FBt4J3hJRuG5MfWQSmj5QGijRD355MJkWDLmQDLvuvL2laAzPt1PXF1aSMzF1MSQvBt3STKDl79P3fOfeheW74pU1YqXmsyto/X2+5b2sE38JrN1s7q4uVDgQaBKmLr/rm6ez8gjhHEOOlfkyoIy3y9pRxBdIwALwztII1TbJoKB0jLOD2GG9gzE+wIYRsaRRxhfQnBf2eTa8gTAMaEelkoT90qtNOAiMDX93Mwho+f0ZUhbrQ9rZ2XhBIN7kf7UGKs3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:7b::6)
 by YT3PR01MB6211.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:69::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 7 Apr
 2023 20:13:38 +0000
Received: from YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fd09:bc13:5afa:7209]) by YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fd09:bc13:5afa:7209%2]) with mapi id 15.20.6277.034; Fri, 7 Apr 2023
 20:13:38 +0000
To: "diamon-discuss@lists.linuxfoundation.org"
 <diamon-discuss@lists.linuxfoundation.org>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>,
 "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>
Thread-Topic: CTF2-SPECRC-7.0: Common Trace Format version 2 release candidate
Thread-Index: AQHZaYvdJ3Irlipa30mGbqWkrEa05w==
Date: Fri, 7 Apr 2023 20:13:38 +0000
Message-ID: <YQBPR01MB1031875373843E5EBD8A9BCFAD3969@YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQBPR01MB10318:EE_|YT3PR01MB6211:EE_
x-ms-office365-filtering-correlation-id: 0fcd0162-a329-4ebb-1ca5-08db37a492f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oz416XLFqRismhWVlBzd+eLaSD0cPcNZvTZ41wT4n0vgj3C9ANL7KQzleiB7EJVeueHaR33JWjXeNGNMRHikTzSlA881fZHvcpilRIwZuc3ySlYB/PeNrmcxWLOXDdL9jtxYUkxKbqcZu8GkQ3npo8p6UyvLRtOlu/U6twLBB1WucSex2P/aVAJqQPfVaT5kacZvt44Iw9tBMKpvQYt1Id606TATxnFJUymDhWp5RmkGEOsSYI2YY2VNkQFDPbER/q6U57T5pECk2hl5ReusYdGL0jH0SPoJoPvBub4bcf+QXY0fhSdKC8M12PknK3FAtFnToNjaENR2jrB2tH8voednGR8lqenMWj5O5tTLTE8tAllOfFzW+E7emyDCsW6KcZuC0fZzVq14LoJtABDMlnZ2KVyYwf0trknewpapXqSkGEDumNwt1tV+hETdyua+/YwkbHBq8EZ850kjJDTgTsHDtGQOxBAaP/c/u4P4mt9ZXEUov7D7fdadTnlgREWP9IDC9pKbdrsm2oieSWYTh64MZeSrOcmWA1UKjaujWov1vXd4BkaURkRT5hvUYALjblNFh9whWy5xW2JRGEGKRNHm1f2byWIjbNiS6ED+Oq0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(396003)(39830400003)(376002)(346002)(451199021)(38100700002)(54906003)(122000001)(316002)(38070700005)(83380400001)(86362001)(478600001)(66556008)(66946007)(558084003)(91956017)(66476007)(186003)(8676002)(33656002)(6916009)(4326008)(64756008)(26005)(76116006)(9686003)(6506007)(2906002)(66446008)(5660300002)(8936002)(41300700001)(52536014)(55016003)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3skLFfUHAx0NzFskrjjZgfGhmlgIwcKuTBE5A4yhnoIAHDryuejv9nkkdU?=
 =?iso-8859-1?Q?XhgYfQx9e1gBVMTsoz7f9D50OqbIH9FmA+WjhlR2PMG2OSfmj+d3aolCfL?=
 =?iso-8859-1?Q?r4GcDxO0jYfPIvF6hDM6peFlKa7qWXvBxZ5gbxlnu1nISKPjA5LKfb+wiC?=
 =?iso-8859-1?Q?MVugQBSanNCa+j8dwVt6rsdxS+wlCIUrAX3bCl+FoLA6p566zK2t3gACdC?=
 =?iso-8859-1?Q?qQ5O+JHFItHd4APwe78zO5edGEiV0UcWwUobz3s6d0ml6Oe6b2gUU1UO0v?=
 =?iso-8859-1?Q?QSwnaiAyRsk1LpUZx7WH8cJkHQ5WAv3VUvTiIFIspDzN585e0XK2sxjYoc?=
 =?iso-8859-1?Q?sFnPjqoK6YX/79JEhJZim2XI9cnPyn0kMqfXU6ykwv1csNz3TpS2peT/5V?=
 =?iso-8859-1?Q?qfzQLeakNrkLGraGAP3kiGm3z9v8GkQuf06UtFUqEswE7QsCmcQVyufVtA?=
 =?iso-8859-1?Q?yMvU9/MfRDHiF70ERL+dhXdKHJW/3qFonlbgu6kGKgRnQCHc/aBdi0esAE?=
 =?iso-8859-1?Q?ygGjd0JL5b24sTrjUmcQ35FjTH4I2b095rAjPoMU8dL8cnxFDmQeSkz5qK?=
 =?iso-8859-1?Q?YTiah/FUf7tbyxUQxUxtEkQR3/yTcxS/7Z2NxOd+UCG68f0pleiPUsXi6N?=
 =?iso-8859-1?Q?gMHDWGw0GqyNx18VXXyrC9exj2zNECdEaXZoPscaEHKcCMtHvt9cJcwXNX?=
 =?iso-8859-1?Q?NPLdttU4gkDvBsk8LE8Fxwz39DTTlFUrvmg/kG+re3hhyT0gPwYVTmiQQj?=
 =?iso-8859-1?Q?ANNdxKRvvklD7sl3uy1KFOfutXZf5ihNBHsT/wpFEXrgdRW/7iZ3JN+V25?=
 =?iso-8859-1?Q?lUHR8WcpScT82cpVSBkpg0VmuDuRbi4JxoA8TYhORzhNKm0GLJnCgy8i65?=
 =?iso-8859-1?Q?JDYaldLhMHcYJvyrnIQLjbIG1ontdGOHTLRdHSRHdPRn29GKm2a4t/92s3?=
 =?iso-8859-1?Q?xQ0J6l+ux3a2FHUvUBvqwDZaHY1LVOTrdq+9eoGNrTXnybAFeB5sg4C7UX?=
 =?iso-8859-1?Q?ysSfeCQz3oDMmktfu8XvNPH0Zu0WcjmyPhCWK2MaeeJ3Q3ihfwSJQoinQD?=
 =?iso-8859-1?Q?O7JArUKNzRPgaQ13GY6FgNfssbhtr/oKJU7VUF8sPAfolMBGrRby/y5og0?=
 =?iso-8859-1?Q?Y/32+ADBJETJBZTyIReIJtT0Shu0b4ZITA35XIGgLNHFCSX02GrIFWWdeW?=
 =?iso-8859-1?Q?jSrvWa9RRgEOltLmA0EBBjs3e8SM5hKhhGWUuReQxahgctQRcmIOk8ENQZ?=
 =?iso-8859-1?Q?onOTlcOrZfx6SMP6nbMXBSFvroXjJ1pByKdK2ptjbdT96gN46f0adMHrsl?=
 =?iso-8859-1?Q?YGJ3ar39Z20hedDaAPmmqEX60EuK7UHg/vNYzQrmX6NOPKmoGcuJX6j68c?=
 =?iso-8859-1?Q?gsM7LpOla7w349BM2cFCSC8KF6BZ5nDab+XU6aE2Gc55y6Kku/TU/KDGe4?=
 =?iso-8859-1?Q?QzGOPA6bc/l8ng8tEOHW4IxFjbzKsNnXvxuTlCsabPPfXNJYQ9Re2lsNSn?=
 =?iso-8859-1?Q?71m1RdFfhefwgwLwA1WEYLIRKYc1CNBBmFXFc4zK/97HQ9UTZ3PIS2laWw?=
 =?iso-8859-1?Q?bssnsmnoVoM95AEV6zRwITMB8HjAnC6wJ3FyfbdzPCztmLY9nV7poXnMHw?=
 =?iso-8859-1?Q?7OGMjD+meBZYM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQBPR01MB10318.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcd0162-a329-4ebb-1ca5-08db37a492f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 20:13:38.2632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHLE5e/dgJyVF9gZK+2dD1IdyOR05r2UVnguT7yYMrK/aHahpbaxD0azomR+JnlluiMMnGxEaoTtjd2hYSOqVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6211
Subject: [lttng-dev] CTF2-SPECRC-7.0: Common Trace Format version 2 release
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
v6.0 to v7.0.

This document, named CTF2-SPECRC-7.0, is available here:

    <https://diamon.org/ctf/files/CTF2-SPECRC-7.0.html>

See the first section, "Revision history", to learn what changed.

As always, please feel free to provide feedback.

Philippe Proulx
EfficiOS Inc.
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
