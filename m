Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D72C6FD1F
	for <lttng-dev@archiver.kernel.org>; Tue, 14 Mar 2023 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1678818991;
	bh=UT//MXU9T2LnGTw1wx+j79KmUP/8GY1+WRb6We+oQqY=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ca6HP6wpv5+PTZzO+tpAWVYHdk6yVhU+T9MhnDnkRPkKmPvI98XJiIT/oJ1RV26iI
	 Uh15qrOPaWzkmp3ctyXa1QSr9n64nVM/kY/FshKAd+8CBQFT73GXJap8I2LvbUfcjR
	 KmMnHmv/5HB3qZfv8ateS7fpgfVko3ngFjRp0e9ElHsUlG8Vi4ynba44s+mtl+Ha+0
	 gLjAAhhIcXO+e8mmc9Qzxw7YgR+NkyYOtuabvAt0mDz+MgDMdQ4R/MlxSafmi59JEh
	 WG2zWplT+Y2nUHBi9LGXxG5amalRgIUm9Vt9iZKNfG4gGW5NVH1udInAOmrO4pk1o+
	 BtjyPJUU2yVUQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Pbj0b1qmKz2Bhk;
	Tue, 14 Mar 2023 14:36:31 -0400 (EDT)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
 by lists.lttng.org (Postfix) with ESMTPS id 4PbSHW2034z2Bn1
 for <lttng-dev@lists.lttng.org>; Tue, 14 Mar 2023 05:03:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH/4lRuonEAZ8oVbybyyxUnzZ08sMUeAwzXwONewFwRbGWpz5XAPlDmyJDYxubQBJUxCOhJB7CV8j5MwPYPIKoMpgW+7t4ELaRbw2QEbZVD/U7PaEvY8ecb3RzTX8ae+oF9ng511g7swHXLG181ZMgl69fYGMjFQ5WoXRCfISbnSpxwvNK/bFHo1olnm53rlrV1qnPGFYLn/U4aO3Tlpat1FDJGJ4dYsw0KTGPKUqBHnFsXelncOqrnwSVaurS770TCm8ZZLZBm8gELa8zno+9h1m73KgIZ6nOOJ0nIix5PhOWii5jF9FkKuWb7YPk9Lai3Mu1ejV8hrjqE0741JlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vUEan+21IfbEdp4n8/0BsX5v2MAABdgjQhRmFtokxo=;
 b=hKi3AMs8gD8AkCHg0BOk03mLEEXY47oEkDYBBjqOhaoG1nQE91XEDldsB23abAR9UGr82r5KUc0Qv8DqM/uETZxY2wKm/tr8+GLULvp5ouRZlT5k+wfwebgeU1IYkSgGb/as75H1HaIwSbLkzPZ0NiOjaIpE1+MmkLcGzgq7dHOo0q3c7br0dCvSbW3Klr+dkFdJV35bAbvtSIeGESs0oa5+EG3NADPgNusa2oPUFzEvEuGY+cN83lzLgl28N4Y/KHbQAPfdA65wUUXRi/DJeOSX/NQyTuShzl/JbnPanroIB882RdZW/uFnnZkK3gkT/k+YD73Yk1uH91rkJGIr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
Received: from AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dd::20)
 by DB9PR10MB5859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:396::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Tue, 14 Mar
 2023 09:03:32 +0000
Received: from AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d5:551d:2d3d:4a4e]) by AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1d5:551d:2d3d:4a4e%6]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 09:03:32 +0000
To: lttng-dev <lttng-dev@lists.lttng.org>
Thread-Topic: UST context field "ip" is now in decimal since 2.13 instead of
 hexadecimal as before
Thread-Index: AdlWU1thKimbRcIJT/u/xe6ifEEvzg==
Date: Tue, 14 Mar 2023 09:03:32 +0000
Message-ID: <AM7PR10MB3175ABFF6003EA76635C94BB96BE9@AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=663be660-a594-448f-ac9a-31edf51f09c1;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-14T08:52:22Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3175:EE_|DB9PR10MB5859:EE_
x-ms-office365-filtering-correlation-id: f27ab1d6-0cc1-40d0-aa07-08db246afcb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tT5tT2GAQmCGpf2TluTIaWzC8woNu/iyc+XrLvu5fNtsMdd+bu/cRt2jTYmkkIMa57Rs9IuPNCRsF8CC53m8UjwF0APjpxVDGKEV/J163vCDpAGqoGrYSijz0xfbWkQvUh+s93wgqt1Zmu9+ASgqqzac7u3cQ+eWhxpDVbkmtU+45Ch9UJigo7dInwkKS/hVmjjhDLg446J6TiP/bo3JSfW15PLilf55MpUUXx394PhvG1cJmjL2QsEp+drj9c0OC+CKDEcUEZ0ppEmJmhSIqsh8f8f4yctQJTMKiYNqP2GvEPA/gx/coK48AfcXbwUUnPhoxFJtZ4fyPxBTn8Swo14JgVKEHglGTOv+l3RXIaJrSVpggjjoMk/dwKfBP6HuGJQXIC+0UcBeWyXbs4LnzPLZugDl/dRCF++2ZB9fyI46bqb4X6McS2vXqdhprhkZsiv5Shm7FNxxHhStg90nabB+Da1QRRegQstg0Rt4HXJKcrJExvEf2/FsApM5+NOV65LRSrL3ciN7MxLgHxZcqe6Y6zG2d6tWGKYPIN+vmNUng4D0QaOh0/Hb3W0Girg3uXKBhsnRD2lbM8oIO+Ct+LIXfxbyyMppLvpT7uzntkhHUYBB6I4r8SUlNcLyf+ftus7RgXM6PJZT18iGKiVowWJe0cxyGve5sN+SJfwhM2tNOb3mUZQZgFWAB5Eq5DQn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(33656002)(86362001)(166002)(26005)(122000001)(38070700005)(82960400001)(186003)(55016003)(6916009)(38100700002)(9686003)(6506007)(71200400001)(316002)(2906002)(478600001)(966005)(7696005)(5660300002)(52536014)(8936002)(4744005)(8676002)(66446008)(41300700001)(66946007)(76116006)(66476007)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VgdrqNkG0a/LirptPxpS8oJYPRS759Pr+L1KT9Kk/iYToXl6LbAJRkK0rSJX?=
 =?us-ascii?Q?EK+AgvfzRV0t2RGsOmSRHOQcwcDXlIq4AZMjMoZqIsetR2Pz+nKcCXsj2mty?=
 =?us-ascii?Q?Ev2KmQ9qWcu1JLMM6UGS1TicBSqIHH0Uf0EwDj/RnDyFCxMG1c5z3YprGaPa?=
 =?us-ascii?Q?33j3hEIdyIC1fZI2xdrOyNOUsrOHVm3Q4NSSsNMW3/cmixfeEZmLzVwUzrGZ?=
 =?us-ascii?Q?CEC7YzLWrC9eFE9tpKu2dueLGbFdnXxbP52wE2B54wspsNcOYIMroKpGDncc?=
 =?us-ascii?Q?PmCqOLzAWCbO3DzA77uo8Z7F4HgfdjvHaptIUmQjNJxdWhbwRz7Y5zaZwOXo?=
 =?us-ascii?Q?MWn55DLZVpDbvkIlqpvhRTDjtiftWVkFxcysRt0BR/2A086FCG66p97UL/zB?=
 =?us-ascii?Q?7EMO6oogvcwsAOeCUony8GdIh6sWVjP5pqfgAnbI5IVdtZnW5tTAYY4pZB4C?=
 =?us-ascii?Q?dTTqjIzBrvw4B3zsQt635XgYr/7S56e7A2deT7AzSTxVN12qeUwIq7lc+TIn?=
 =?us-ascii?Q?Fsty/kcDa19xA4NXNiEKCx3vny+RbCys7IOByHWXfnAekqNGpJUuqtme+s+S?=
 =?us-ascii?Q?GuZOTqruvyKPn9x7ftXynE2lhc2HfS5IZp0yUiuR0sOUzOUi0xB1vsWp3P44?=
 =?us-ascii?Q?8ZvczOTnkUA/U4ugqu3bGXDF5sfJFTPEOiu/Oh/VYUPHQS8zqc/lXrZ4wwtb?=
 =?us-ascii?Q?ZASF50674a3qIKKk5F5AqtNcJgMvB0ly5QppmfuXdhYF9T6/t9fjtsC4BYSL?=
 =?us-ascii?Q?IzE6dO2x2fGymOalGRb/wllB62RV8bwS9wGOKGO/CGI/+fNGAgqKMZzjGwky?=
 =?us-ascii?Q?4eK29Wtmhfq6uBvGqVG5BvP3wihIMlzkux47O0sb6INig/Qv4oMK0oW5zuGw?=
 =?us-ascii?Q?+K5azgiPjwNaCo9ejQDhEuj+EWqJVADFv3W/+Z2W59b/7j+QLRCT99IfhOUw?=
 =?us-ascii?Q?clBEguEVOXNk5kz5oNTw44V8gLF7tTiaxn+ekAsDU8t4vGTSxCDvhV39IZLV?=
 =?us-ascii?Q?ktQ0nokJjtWFfRYinQ8HOMr3btH6PR7FM8Yp+PTXeW6Rpqfq2n6wKN2glOZF?=
 =?us-ascii?Q?UqNAZuIcTvv6n3Dbal2txM8S+fEbx2ITL3qd2kndm0JhVw6ILbzykg9eyYWE?=
 =?us-ascii?Q?D3CDtU7uZWNiMQEegwTzMr24uqqaqPBX8/Rgvs0OiGP/U4gabZhrMn8pqNc+?=
 =?us-ascii?Q?i4sxlbezF5Z1uWmTckeXDPlPY4jchSLdw0PtGWJXA2XdmXM/nO0YKsAoqXnh?=
 =?us-ascii?Q?Zihudt+EmdmDxEr1NEXqylHg9KY0gCuFp/GopLj3m/bhqkU/XCa2okG6muzI?=
 =?us-ascii?Q?ee50tyVe36yZQU419reDVrM8+UBy2tQd9jC8kIN6i8wMyDiVOminqVR6thyM?=
 =?us-ascii?Q?PsecVLKbP/ngF+KTrL3HbI0fvGUs09fuHmnR3i7WuSABTqauf2SSwH7ZXYF3?=
 =?us-ascii?Q?IfsTnSTUwIr2sp1BxrKY5jKATyP/j585LsPBTCfU7LJ8GW2SwetxQ7Dt4SYY?=
 =?us-ascii?Q?rUU2h08T6/pCq1YQBSZB/YJKDGwab1i0pYSaLK/lpXye9X/8OQy8C0Ksy+3i?=
 =?us-ascii?Q?n0WNEP89msOsi6tQhDOGpmVcbBSloqaFaHUPuypip+CptScJ3b1MtGWA0I8n?=
 =?us-ascii?Q?5w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3175.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f27ab1d6-0cc1-40d0-aa07-08db246afcb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 09:03:32.7354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rjk3hABSyDeQbFjaTYrrs4u1CinyTMb/9hE9yCbVtW6tHfwCNcMOg+Y3c+8JjZVPgM3Md+pxEDT8nureZQML+jbobOMX+iKHJXcBieAhkX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5859
X-Mailman-Approved-At: Tue, 14 Mar 2023 14:36:29 -0400
Subject: [lttng-dev] UST context field "ip" is now in decimal since 2.13
 instead of hexadecimal as before
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
From: "thomas.gatterweh--- via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "thomas.gatterweh@siemens.com" <thomas.gatterweh@siemens.com>
Content-Type: multipart/mixed; boundary="===============2688347470012545258=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2688347470012545258==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM7PR10MB3175ABFF6003EA76635C94BB96BE9AM7PR10MB3175EURP_"

--_000_AM7PR10MB3175ABFF6003EA76635C94BB96BE9AM7PR10MB3175EURP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi!

In this commit  https://github.com/lttng/lttng-ust/commit/4e48b5d2debaf6c0c=
598489c183cc6cb2125c8a3  the base for UST context field "ip" was changed fr=
om 16 (hexadecimal) to 10 (decimal), most likely an unintentional copy&past=
e error. See change in lttng-context-ip.c, line 47.
Can it be changed back to 16 (hexadecimal), so that the ip address recorded=
 by this context field gets displayed in hex again, which makes much more s=
ense?

Best regards,
Thomas Gatterweh

--_000_AM7PR10MB3175ABFF6003EA76635C94BB96BE9AM7PR10MB3175EURP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"DE" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:bre=
ak-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In this commit &nbsp;<a href=3D=
"https://github.com/lttng/lttng-ust/commit/4e48b5d2debaf6c0c598489c183cc6cb=
2125c8a3">https://github.com/lttng/lttng-ust/commit/4e48b5d2debaf6c0c598489=
c183cc6cb2125c8a3</a> &nbsp;the base for UST context
 field &#8220;ip&#8221; was changed from 16 (hexadecimal) to 10 (decimal), =
most likely an unintentional copy&amp;paste error. See change in lttng-cont=
ext-ip.c, line 47.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Can it be changed back to 16 (h=
exadecimal), so that the ip address recorded by this context field gets dis=
played in hex again, which makes much more sense?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best regards,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thomas Gatterweh<o:p></o:p></sp=
an></p>
</div>
</body>
</html>

--_000_AM7PR10MB3175ABFF6003EA76635C94BB96BE9AM7PR10MB3175EURP_--

--===============2688347470012545258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2688347470012545258==--
