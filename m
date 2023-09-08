Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54794EE57FA
	for <lttng-dev@archiver.kernel.org>; Fri,  8 Sep 2023 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1694172239;
	bh=BNryLiBkkEHT9c2A79DgRlXotk5x27brh6iFEM85BIE=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=jESyHofJpyYa9i++GE/qle87JH5gxMohb981vo6jQesVgedcGzW7Tgf2U6PVKb/tE
	 /Qj5hK/exGiUVJU/WuIR17H+HGmQaILzGv4SvHyfd/F3UN0+5ndS9GdLPx6Cvde19Y
	 BfCt/408DNz5jsqZiaT+AV1XGoMUVveLkGpNfC98aFGGtd740y6yj5UD2SLt9tkrix
	 D/FEyE0WDGUGN8o06hZQlBnvTelpbgW+S8UyyG/U+qo7FnKQ55absokmM8I7Q6IHeu
	 C35ontpYuQDKJr05hppuVGje/AoQxzUTqMqjYiQbblRuUKl7nQsGxCJQ9PnwN+2hR5
	 FO2zjpfulxTkQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RhtzL2mSQz2WZk;
	Fri,  8 Sep 2023 07:23:58 -0400 (EDT)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by lists.lttng.org (Postfix) with ESMTP id 4RhtzJ3kLYz2Wvb
 for <lttng-dev@lists.lttng.org>; Fri,  8 Sep 2023 07:23:56 -0400 (EDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3889nguI027740
 for <lttng-dev@lists.lttng.org>; Fri, 8 Sep 2023 03:56:20 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sv0b05d7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Fri, 08 Sep 2023 03:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6FYaRR2kvgbopwv4K2ApSqgVpu9mtFkokufvYDs6mC2tZxrKLY6xsYLppoUtrXERnE6IsmQXiV7STqLzv3pLF/nT5XVXeImIBHEGAuPle6+L/nD4QVhMtaxHpkAceT1DhHJmIjp5OsfsOK4YCIdUEB1/7DiDSK09K3pIPBlgergpTv5ZNArREurG8tWI9UmqfhK8BVLmM49Sl/yUtqlPTszqpU+frPTBNhfoyRpUoKf0CHSNlrWm1nOaOHlQXqLK6SIYLPfX8Czv543GmaG2EX2CrprelWIL4PejAdW0lXPfRwkfq8BNoEK5WCmO0fqvaEJXV8sUeUrJjpg7qD9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAri+I1fWWQHiAeV8xV0oSbu46E9huCAW5ePIbIqH5U=;
 b=K1rNsPF95273+JfGsgi7VWgIzbJRwPYa7rG/tIev1wcO1uqmrUlmybQZl8cEFsnXswGwUWaaNJj5mclZ9tksk6vWnH74qIQDt9jkf+v/88Bj8ww9WRBN3N9cbXwGJZ6sVIEgS0InM+2eFMHr0Zt5bQ+TUrFSUTHAY7pnnXJ4/oO7RwpAAaCW4dv4CRxyj2DxaQLeioefZrIyQeGMfSEgkkQpr4LlGGYalFgRvnj5H7P6DX/EvcUdUtGh6xODxhiGwM4h1OVJeS/vgtLiZe8+196qjua1UU+WRvbhf8s78Zkq/g9KRtT/riJFrlLpKmEq3gBnbh+b360QeAoCbxjobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2749.namprd11.prod.outlook.com (2603:10b6:805:5f::16)
 by DS7PR11MB6270.namprd11.prod.outlook.com (2603:10b6:8:96::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 10:56:16 +0000
Received: from SN6PR11MB2749.namprd11.prod.outlook.com
 ([fe80::ecb0:e0f8:8b44:cb86]) by SN6PR11MB2749.namprd11.prod.outlook.com
 ([fe80::ecb0:e0f8:8b44:cb86%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 10:56:16 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: Adding a simple "look here" event to the trace
Thread-Index: AQHZ4kMX/VCspc7e6k25p6U8EqYljQ==
Date: Fri, 8 Sep 2023 10:56:16 +0000
Message-ID: <661596f68dcda5a1aa87cd5faa4d5f6c5937728e.camel@windriver.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2749:EE_|DS7PR11MB6270:EE_
x-ms-office365-filtering-correlation-id: c013ebfc-8afb-4b82-2c98-08dbb05a39aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZ4jWgWscbD1Xn16Ufoycaj15+NVPMlr94kRHXiY3U5FEvYWG9eevRuAfMpembLADCZnvrFPq+cpj8RcySuJ8WxjIACIK1so+PW9nxDP+zT7zWO5VvEU08dF7IIOC2xtnPlI7lP3FDHC1L0XkASCmCy3dK7IBYev51uzgSpA9BmP6J6hQz34Z2afMtd9NRVoAQK82t3U+BnBH5YkqsrzJ6p+1gcuftBkQT2nPcJMvOa6WAc8sAB3I9LDRlGFbY4GrpV25GivGPl1HCVk59JgUYTJfM5G1QmlkwijazRkL9JUkUaoR8VmVX0YH7i5tY5CHJbxpZYOjpnOdXwcfs26QyZVHiW51JbwGipuuPx3LwnngpBmmbn32LySV56l6GiqmwNqpIXUguJcmQn4AS0Aor8mK9KH8vbchYO7mbMb7B+0HZk0pK+STeFrWSjG0eenGkIGkGu+Z2PFAWw/sdR8HueuWd9oA3u2lIh/36V/ISnDxLsIYJSJBT1RO8padFboHAUk28tRL4rbHHlo3CNZavWptKmvjR8ZItIGXuwXMg13KC6g/sl19dr0K/lhvgUNADCDAx52iKWepO750n+BFPcin/tOSxRQqDu+oxOPRHIdFtaiob7S48dknTKGq58zptgo1IMCnoiwhSJeAChxjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR11MB2749.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(346002)(376002)(396003)(136003)(1800799009)(451199024)(186009)(71200400001)(6486002)(6506007)(6512007)(478600001)(41300700001)(83380400001)(2616005)(4744005)(26005)(2906002)(6916009)(66946007)(66476007)(316002)(64756008)(66446008)(66556008)(76116006)(91956017)(5660300002)(8936002)(8676002)(86362001)(36756003)(38100700002)(38070700005)(99936003)(122000001)(67593001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0wxU3NRYytlRGVWZjdIaXdDOEJIY1Y1Wk1ITDBtdHVEZDVxM2VTbytJeTVL?=
 =?utf-8?B?Zm9idkFySmhIRkxXQ0Vld3pId1dZdU1iQVdzU2RnTlhNbU1IZ3k3eFEvVFBU?=
 =?utf-8?B?a3Btd1hTMVVaTW5pcnMyclo0YXhBSTJJaUhoV1h1ZjZCWlNrR3BXVDhUb1FZ?=
 =?utf-8?B?R21nd1A4WGdUUElpUyttOVRJWlB1b0hDaE9LOVNDVTRkU1FRbnI4NU9xVzc0?=
 =?utf-8?B?MU54Rnd2NXFCcmx2cUNXUzVKZDY3ZGlIcHp4cTl5VWQ1dlJ4UWNMWEVXeDdr?=
 =?utf-8?B?VFREWkdvSkJKYjQ0alcyL0gwVThYM1lraVExbkE2QXVEWjhPTlR4ZFEwcmZW?=
 =?utf-8?B?ZFF6RnBwRTgzY0pMcEJIZll4NXZHSy9QSEhtNVVlZ3RLSWh2dmlFSDNFcHJ5?=
 =?utf-8?B?TUlzc0FPenliSG01L2tSRWxPQ1Y4SkRCamFYSDZYTVBkY21qUWtaWXBLbllR?=
 =?utf-8?B?eXBuNGpseVRLQjlpK0hvQk5MSmNwZWNWOWFmdVlaYldNQnVFUVVibEI5cEtu?=
 =?utf-8?B?N3g2c0gweDlUM29lOExLNkxLRlJoVWducHBPVjlRMXcvcVFFNVlsTis0YnF3?=
 =?utf-8?B?Q1FicWlYbURmNGN6RzNaN2t0WVlLOUJGSUorcHlHRWN0SGJBV0RKd0E3NlFO?=
 =?utf-8?B?cnpmV3pnUGUzSTYyMDFESGtGd2RnREg0RlVFMUFNU1MybVp2ZkxLbG9VTTEv?=
 =?utf-8?B?b2JGbkVnM1dzL1hxMElWd1VFZHJUM2RaUVppeUJNbmpXZExMdmw3TFBGTjlz?=
 =?utf-8?B?UUdRRGZLTVlKcGtPZzdtRnVWY1BUY0ZyOEl5ZFJLYlBFeFB3cktLd2pQQTRo?=
 =?utf-8?B?WVBWakxmeGREZ09vdnZlMEVQNUhadWpObVdyOURrMHloVUIzeDV3Uk8xd1FD?=
 =?utf-8?B?bEdJWDlBS0owSm5pc3o5SWk1dmRFWjlNZGhsbHQ1a3JNSDBPbVdhZE1vZ29p?=
 =?utf-8?B?REhlVmFhNnRaWG5Cc25HVjN2K2hWME5XcXl2Y3c3RDVBQlNaVDUxNDJkbFhV?=
 =?utf-8?B?QzMxUHhhNWNtSFdMOTdqZENSYzFZRVR4M3VPQk4zdEkwYnNvSDVaMHhrVDcz?=
 =?utf-8?B?VlJ6Szk1Rk8rck1vcjFsYVZPTVQxeVVHSzRSMnF3dWw3UjNzZ1U4c2Ryb1Zm?=
 =?utf-8?B?S3Z6QmM5RzR2b1lLNVpVN091eTVqVXFIK3A3VWVKUmZtUkxqdlp2cXJEZzYy?=
 =?utf-8?B?RU0vV1huL2hqeGZGbXIvanh4TlptZ1p1NStTclZXcHdPNmRsL1VxbUZCVkRM?=
 =?utf-8?B?NEZYNzU3UVp6dW1PQXZ5ZU1SbS9hbVkvell2WHloUXAvU1BNSytmN1EySVpy?=
 =?utf-8?B?QmFYMTNyOHovbE14RnlWYmg4U1ZxdEZKbFB5cWpwa0x6VWxleDVVdk5ra2Fk?=
 =?utf-8?B?NUlPNG55cTJES01HOHBGbjV2Ri92bXM1OVV1TXhEOFVHa21tQVlhaEJ1MzBo?=
 =?utf-8?B?R24wYWZ6cEsrSlB4bjFacE5WaHpWV1Q1dXFqdWxoandSb3VUNHl3RFpRSmg1?=
 =?utf-8?B?ZnQzTWwrOWNmQWZzOUFXcFp2RHk3OThvWnFMQ1dvZWhJOHNmRDNQWUpWeXRQ?=
 =?utf-8?B?MzRSd0dIWm5MRTNBOVUxbXdJWWZ6YXlVZjduaFptU0RYR3VRK3RQY2cwUXFQ?=
 =?utf-8?B?cUFLQUl0RlUrdGJySFFrdTdLTTlsOGdjSU1GWEM3Ynl0RVdHZTZWdDYyT2Jt?=
 =?utf-8?B?cWhLSzZuL0tudHB3TlZndUc0Um9BdjVDTHlMbDFWd2lid2NjUmxJaHZOb0w0?=
 =?utf-8?B?cDhnMmlmUWNHdVBwUW1iTWlFbDN4TFpBQkhhZlRQNW5Majg1V241NUFFQ2Q3?=
 =?utf-8?B?R0pJajUyamZtOUtBczE2N0N1blhDUDRhMHpla3IxcUY1RGlmLytYdWlKTnFC?=
 =?utf-8?B?L09ZaHBvb2FmNE5kZjl5L3YzZUdCNm0xOTVTTmJzeTJyUjkxMWVlU2tmMGo2?=
 =?utf-8?B?S1hXaHhxNnN3ZXhoTzJWRS9SZ0trcGpSL0JDUEx4dDYrUlQvTW9LcHhRM0RS?=
 =?utf-8?B?eDNva2J6MVcxaTYzVVF1RW1LQUZIMlNJNndyVzU5Z0pscmd4OXJ5V0M1Ykdw?=
 =?utf-8?B?SUFyYkZyOU5kdWhMeVZ5ZU44Wlcxb3c0Rjc1b1pYNUEzNk83SUhTMjM0V0lh?=
 =?utf-8?B?K2NleHhpVXIrYWEwanRjcFU0a3BSU0ZIdVM4Z1BtRVYzZkpqMFJKdmttZlpV?=
 =?utf-8?Q?jKvoYg0gbrh5E7Sc5GLp+fE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2749.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c013ebfc-8afb-4b82-2c98-08dbb05a39aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 10:56:16.3805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C98R6Qj3woGJzh7l/Z9Ysuh0aSQ3Gu5yXz20eWoq25S+meslr10LjTULbD11tfwTzYGkgJLy+intnkgAtSLnq4LaH33MBaV650AU/rrY9Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6270
X-Proofpoint-ORIG-GUID: ygBwDxvZ9pmRMow_1nlkUuAIqgP1QPvD
X-Proofpoint-GUID: ygBwDxvZ9pmRMow_1nlkUuAIqgP1QPvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=651
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2309080101
Subject: [lttng-dev] Adding a simple "look here" event to the trace
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
From: "Danter, Richard via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Danter, Richard" <Richard.Danter@windriver.com>
Content-Type: multipart/mixed; boundary="===============3542132784782597755=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3542132784782597755==
Content-Language: en-US
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-pn+pZpiWTVzPSZbTBHti"

--=-pn+pZpiWTVzPSZbTBHti
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am investigating an issue that takes some time to reproduce. Finding
the right point in the logs is therefore very difficult.

Since I can detect when the issue happens in the kernel I would like to
be able to emit an event into the trace that I can then search for in
Trace Compass of through Babeltrace. So basically a kind of flag that
says "look here". That way I can jump right to the problem and then
look backwards from there to see what happened just before.

I have looked at the docs for how to add a trace point, but it seems
pretty complicated. I may have missed something though, so I wonder if
there is a trivial way to add such a flag to the log? Up to now I just
put a printk() in which helps, but would still be nicer to have
something directly in the log.

If there isn't such a thing already, then would it be a reasonable
enhancement request to be able to add such a feature?

Thanks
Rich


--=-pn+pZpiWTVzPSZbTBHti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEErzjP234FF8wy07NdNk3LIt9/FNUFAmT6/c4ACgkQNk3LIt9/
FNWW1gf8DObQzo4633FGOXJ+NcasoYDVXCUKPoJj5lDCNITQf3V3MZekwBn0T85q
6ZBQJBLvINCf9X1DrIl9ZKS/3teQuqkibV1aztwZV6qpuH/Wz6gLiHqGBD91J5fc
xgMTdEnNyyz4mH8Nqpxe7/AA9JZZtyXyeqDR3AWw+RgMxSJgFu9mfMcqbvA+X0Gx
rJ2/ZMUMYslseNn58vdQT6+wg7knUx5DdcgIyzoAdaXHBXDw3Twd5RCZ2rNkPZO3
tjv916AuVQrqMRc5kCRdsLDpLrg1CdbqK7adg97/MiIx3bPAlhZLtzRD2oXzQL/B
oT/99O52zp7cD7+7eS1/XvmoHvrb9g==
=UCbi
-----END PGP SIGNATURE-----

--=-pn+pZpiWTVzPSZbTBHti--

--===============3542132784782597755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3542132784782597755==--
