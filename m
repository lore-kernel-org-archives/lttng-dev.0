Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B251D19502
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Jan 2026 16:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f0Dpk0PpDz1KNT
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1769445743;
	b=i96KPhOJUPmkULY0zxow+0gWw+TeN0kYkI4g1soPDP66CnEkeeXbDiNHDeXDOGG+ekxN
	 owFT1L2124yxfZ21Kw5Pd0W++Lj8c/JPPQ3BTXmWSX0Yn/l6UskkkNl6YfU9BoPn6NmQ8
	 EQIvgUFxgUpxzuXdyFS5iohdf3ygnhTsh+KZI4wZCRg9stDZBU5PMqqHT6trYtqEKCLJm
	 ftgkD9cEYnzpKQ0R0zzXFFGoSK9uhfe3HomhIW2W9L0lNvM1BPH0KxfXFz8rAKbfJCPeF
	 wBuXRkhq25pTQ9jwQ8R4/2O2mLLnt+0tlOaaN7koAaM4NdJjDy4Ca0c8lA320DHX4Jg==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1769445743;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=pPw2SYFZhqTOfkUFNwwPcOBBJSwpQfIz2IRYnPHtACs=;
	b=VMYG1tA0qyhKGa5EOb1+b9SrNYIBjacX3oKvSvSyOQefuHXubbOnUjUcQwA6Q1tJ8L0e
	 Ee2p8mfYHP3k3hlxzatMwmdN4qaDgdsipF38Paoqs/mOFsG5ECyf4L5mlAqNFkjoGtwzm
	 oX70Ouye+PDKFBiuXUTtMNaM1mHCsJG881ZxAxl7w9YViFF8CKDEo7tFPAwM9fELLBQlc
	 fTr5UlsCrR2v+MQl7uHyA6vTBEMWI31/2uTKGsMkZf6JC8qoasiqZ+lDUaiAtrqkhmnds
	 L/OU8ovRxFCszo/igmxwJ8mrxLv5d3XhOiFjcb9ckGVRV/9C6/YDKwjd3CsIYWJy3ig==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f0Dpk0PpDz1KNT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1769445743;
	bh=pPw2SYFZhqTOfkUFNwwPcOBBJSwpQfIz2IRYnPHtACs=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=CGULwHyl3Srn7ce2S6hJMsNDvtFwPu8ErG73iNKAqpxHhOFJ3oURxzZeAkkiFI9LS
	 tAFESYv1reT1eMGl4o0KoAm9BFRtKnaArgSEhTvFwoiQR/M9LomLLnE3OtMgBj672u
	 EhJx95tr3jnnIT+fEsRZDym2zhLJItdBgsWm7ioqQb/hmnnjNdPaRKej2gQlCZQlQH
	 E7NEC6nGMsbOG+E3wxsoEVDnblfMSqZ5jWX4ldiNiaTmVN72sba99EKdTkqsPaRtnR
	 +oRKAmotcziod8IYO+PdmXeiJ8N29bXzgzAbolfj4B4uI8m7W0GqVf+QanCufyN+C1
	 Z78zVBa+2hx9w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4f0Dpk0PpDz1KNT;
	Mon, 26 Jan 2026 11:42:21 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4f0Dpg6WYgz1Kym
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4f0Dpg6WYgz1Kym
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by lists.lttng.org (Postfix) with ESMTPS id 4f0Dpg6WYgz1Kym
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2026 11:42:19 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/ALkPCjqctAJowe4zs/0LYui0c0KHDs81ScGENkKMxBHbsVvYaOLtrxz3ty2POxWeFlU3pV2MKoSD2uT13L6AzSrl8zrqDNvUMI8yztnHGwVfvJGUC1v2mwECXLkR3Si0wdM2m+1Qww9eHsf36i/LkyXae2G1O3+1W6NLIJmbqsbetcPYc69Zaf8bGa4qamP0+97g/m9h+p7Oonl+yE1fFyILkZnnv6IYn0oV+zXr85PagrhJclOdRmg8rmQHYV3EfHLOjOa5peR7D6wA4NZpuslgd68CKryQEFG5qFBGtPRZ/6GW1Fz5kRPfygXdHUJernEZBsgq6Qjq46DBm3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPw2SYFZhqTOfkUFNwwPcOBBJSwpQfIz2IRYnPHtACs=;
 b=G9yvW9szl3N6n2d0ptYypHLAitZT7IBZjdk1T5VqyRCYtFMQHI64dLQWaCxiwDzIzCiJokRs50oEdfB3GBVzC2YDKBwGROnT/FBxt/T+7vrpO5Dbj9meEQj5bzjDrkJS3/3V2f9OItGmHtG9oDUbBcjVGFCoNbIck6Ckhrrx3FqEfd4c4tpFOvS/Izd3ufSytPeRzwFba0h2Rwoj230kWFyEj1XN+dsZ7G4Ef3JMmJYIA0xEepi/iCCsvDZgoPCZZhvnO49aC6CqKPmBNV8wrellZrYqZ9PBVfFLYkgcRdcAZnc8oxOQpuNIEsl2A1WoYT3lA9hZN8lGNAMoIpWDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from DS4PPFB691D9211.namprd15.prod.outlook.com
 (2603:10b6:f:fc00::9b3) by DS4PR15MB6777.namprd15.prod.outlook.com
 (2603:10b6:8:320::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 16:42:19 +0000
Received: from DS4PPFB691D9211.namprd15.prod.outlook.com
 ([fe80::5c59:d68d:e8ec:d09c]) by DS4PPFB691D9211.namprd15.prod.outlook.com
 ([fe80::5c59:d68d:e8ec:d09c%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 16:42:16 +0000
To: tracecompass developer discussions <tracecompass-dev@eclipse.org>
CC: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Invitation: Trace Compass Monthly Project Meetings
Thread-Topic: Invitation: Trace Compass Monthly Project Meetings
Thread-Index: AQHcjuKGix7vxiSHoEqfMjqpSuz5sQ==
Date: Mon, 26 Jan 2026 16:42:16 +0000
Message-ID: <DS4PPFB691D9211B0432FC71D96571491B79E93A@DS4PPFB691D9211.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFB691D9211:EE_|DS4PR15MB6777:EE_
x-ms-office365-filtering-correlation-id: 518d6b9d-843d-4d0d-2870-08de5cf9dd8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ISJSfv0W6wuGTJLXIGOXs96puDvBFLiL9Ueity9e1fga06uVfxo6NkJcV8?=
 =?iso-8859-1?Q?+CWeP+6LJbsG+PcB58miSZTl2QsAbSKPdKuq9RsJpfcMIiAuBxk63UW0Pz?=
 =?iso-8859-1?Q?rR3x3Bfhry1wDXEPKuwmVnAVqQBE2EQ/Zq9AN191XyQWqB1QpukmABAm7A?=
 =?iso-8859-1?Q?pqxA2TuX7VuZBTk6L80w04N96A7cDe6j+hW5oU6FQfA3JfxhisFfsPKpRo?=
 =?iso-8859-1?Q?leC+dn4Gnu27hFTb9tqVLv3ik4VYz6PWGRMPK71H13tQau9FAO71/LVepF?=
 =?iso-8859-1?Q?qkefaAOahTe6ZthfkDeVNtLyR7mJK1Q02BJvxRbaGvQEz+EN92nxKu7hXH?=
 =?iso-8859-1?Q?QtuGTz1j2fFwyQHHn+FHka7ZXnT1Uxl7Q2cDu8XABy73I60sLM8D+fNVNn?=
 =?iso-8859-1?Q?Rkhyhx94jMF/f03uzy1OUzV1HTHXDdP3gJU/bmF2o46v1p1FG7i4ZX5a8J?=
 =?iso-8859-1?Q?AT560Rn8hvYvuAKY81Yn60Me9i1rqXhB3MWik41UdawO/uiq62vMI4k3AN?=
 =?iso-8859-1?Q?jkPW8U20Y39lGIJ6B0T2pBTEWBokJa8rTmYwIhuWGMMdtDibhBGOPVdrPy?=
 =?iso-8859-1?Q?3FMP3+icYZn7rIHBFkKbkvX35u73XTTSJw2ksexIPwaRH5rSBSxZ/LsBV+?=
 =?iso-8859-1?Q?PuNlMLCHBlIgGQv8b+xMSSR04LcqcAEJddt4t3K1q0vK64vZ2qzqs7I4oF?=
 =?iso-8859-1?Q?w0MX9eqw5HQbBQprufTA2G61fOs3bR3Ki9UQ462swM6PEtgKBjZGmUKAuk?=
 =?iso-8859-1?Q?d3T58E8F2pLHAUT5cKw3U2/KS2rNqJOUyZKgvcBNjV4gV5FbxTkV3SL4pv?=
 =?iso-8859-1?Q?XoGyJjrV3gbkrgn8k70VsWr4a37fZbTAag3y0Q2/vmV+6G+9gj6gQTkXGh?=
 =?iso-8859-1?Q?540PjfSo6fvf3wpBMgtOBwISWArfVK8zgZmb0Rpk/OmR18SfoOv5EtU+AV?=
 =?iso-8859-1?Q?N+FgrsJsh7Y+YaOs6wxLq3DRFa1dnN8yIaCu+bWHPQswHxNvlf6wsCw8XG?=
 =?iso-8859-1?Q?rHbxMYt5atcyjYWu2dorgFTG9fGkvwbhQ62Qc7HiGqQLGuTRhvC5mKP2gJ?=
 =?iso-8859-1?Q?qH2duA9PLmMxQXc1XskxWW/3oOkuKS2QPfDS71JrSpb7OjibUx0OKNsI10?=
 =?iso-8859-1?Q?KSN4kLUUe+jRWZuz/RB/ByJKvtO2wdxWb3tOwH8zB+bHBUQh15L9S/ifd4?=
 =?iso-8859-1?Q?HJtAX2TdFosQeZf1J8gBD2esS33pbQbPAKRvKl2tXMrgpSl9lUC3qHcV/d?=
 =?iso-8859-1?Q?ODx8PQ+eZga5TkiWxpE7bbdv4LXp4kpOjvZ23ZCy/aSWG9uA1Q6Ba8C6k/?=
 =?iso-8859-1?Q?jbCoGZyEjGMsWotLi2aVCsPe//4U1Ugdtp6ozs7MMbFK7ZEAw1hKpZa3RF?=
 =?iso-8859-1?Q?vnGOtyRR3THqukP++Pu83om1Y5esJoJ/lKmY4YHmZ8lCiTkitofKeDzErx?=
 =?iso-8859-1?Q?PWjBpIa6c7ev4r8LuZcb57mRamy5hsZyMdT0zXIF53mOtG5WOseRaQ/1DL?=
 =?iso-8859-1?Q?CnzRimA0Ka6QCwCF4ARi1O/muIgfa3iXosJwfCRwzJ3FHd7P8FvRdWPTi2?=
 =?iso-8859-1?Q?ovMg3Lp6fEep4E0I2JT1zU5P0+eYYL8WOlH3Ykep/NR7w0rf1WDHiF7UHN?=
 =?iso-8859-1?Q?6U36fH28lc8nFx/p070yxcaRmjRBbCgM3jW3pMWA+CLIBhkimqddzJOVxc?=
 =?iso-8859-1?Q?A+cL6otx8l1PyDLtjO0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFB691D9211.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aNBXHHkvl8wOcmqqPJuN4kIXIxOZAxOuPfqp5o3F4dmahFAj+FIulIHtNt?=
 =?iso-8859-1?Q?eXr7aewjK+yNq7vh4trtFkJb4rnxrlRLCwX+o/bIoUP4XIp9WsKAmL3ZJM?=
 =?iso-8859-1?Q?UBfaaKCb0zTGuoqiHDWXsUctk1eX5Vabx6LEHp71jQEGG0DlhC5pmVLer0?=
 =?iso-8859-1?Q?8+KCXvedkfb/sl+wc7/Mhn92ejeWU9A0WcXddeVXBETnerw7nxezEEnJAn?=
 =?iso-8859-1?Q?Q01TAfLCoQZuTqHtJhylkKZ+Hy6CXHaGj/TGcxiWj30qyIx2FMBMXyrmgt?=
 =?iso-8859-1?Q?c+dmC9/LD0ElKzTiWwUDhZ0mjsSWM2shqnPMBcNhq/im1qqcssqyu/gNeN?=
 =?iso-8859-1?Q?YY0a2oBXb3chcN2r9F5f8B6aKX7NWiSahu51VdwFocO55S3GBmcf5xTtWi?=
 =?iso-8859-1?Q?wJiD49vIQHdKBgKqyXuPhWqgxskdAKOVHxe8yt8jr5NPssXgOBLw8GL8Re?=
 =?iso-8859-1?Q?3oHK6SfyX7DqskK9Nb52Yz1fTmA3DGeXC0XHcDYg/CrwkiTn0n3jSxGECU?=
 =?iso-8859-1?Q?b0VmCK7eOKejbaI3sFKw36Ft0Kwh+jwi9gLNCuk4dm3HG0S/yJjFBaAMwV?=
 =?iso-8859-1?Q?bUn0UvWIAftpS+lUCLq/nD3B7cIaqSE0GaqHX3I2eE0Y0aN6TPe3cbGGQm?=
 =?iso-8859-1?Q?B8DSGR0kqvtZ8dpoP1ipui7TBxVnbxRN8l6QRhXKCQX//jB9+AYeJE6G/8?=
 =?iso-8859-1?Q?FeeHPGQbTTaP5WGd9uusLqIPOzm7Ym8zR40BDO9dj2lTpjuXSsuiWmwUD7?=
 =?iso-8859-1?Q?eP5830jMoMqPOEVQ5Tgpzs5rUW6ku73W9M5BX/0mUYGNqgGzqNXrvHqcEd?=
 =?iso-8859-1?Q?BWtnSdClqlAtwThW+i1kLdTLJ+A9j17HDUy3154cvSHBtBqmTu78YpX0MT?=
 =?iso-8859-1?Q?KD5M0ZcH/N5E4A6IHoGY/4204+tGLywCMiwgf6rnEBEGTcdiJnxkt6QSxi?=
 =?iso-8859-1?Q?hEurWoNWO8UYV9yTfAvS/YFnKBJO+ZAxIReauUX2Caoq716AhhIyNuh/9I?=
 =?iso-8859-1?Q?8iCXK2Wzplp/S/Kkl14I2XVUmClYc9kGVyQp18zA3/Sr0z5hZINkbigYrB?=
 =?iso-8859-1?Q?nfcXdwHgYqj/mtCSOwPtR5iWC4NFH9SIjvmomP9gRTfL6sugKWSLUwi2sh?=
 =?iso-8859-1?Q?FNBZvzunwLJbzQv8uHPP9ylAfwJrz+Yps0t6jlAM8HZa/cII2Ia6BTvm/a?=
 =?iso-8859-1?Q?GER6B+ZJIe6A/JpdYET6mt21+UTVgBmpne5B1hlZKIPiWj4IjMGIhdGWiu?=
 =?iso-8859-1?Q?p/IqdjjLQK2cg4ZH5eTjA7GIJgdyAvFE4tIUoFIoRPlujN5bLfCinekKGa?=
 =?iso-8859-1?Q?R6FywxEghQgQUSJXMSiQm2Upt8IGhRGIDyA7GB+NMplm9EU1ZMqg+/YUO5?=
 =?iso-8859-1?Q?UfOKOb/Q5uyDKDl20e6mAGQgt6ExAnzgnBVDG6KxUTPwtdwhCxtJwWkSgD?=
 =?iso-8859-1?Q?w/Uo0DTBNyehfyyr2NbQneE2FWhk8MGDH0Q9baK7cwUrvRDN5LMGvSd/Ep?=
 =?iso-8859-1?Q?ufnibWRwueVZGTsxeHlY6t6zX8PRHg7nND7XTKUMNdigB8RU+pF1T9Pgd4?=
 =?iso-8859-1?Q?EMvhStDTILFu6RhYHT4udTXv7hJ+ih8GR4aAiUnJ292uLt9Egp8nfSpVmr?=
 =?iso-8859-1?Q?NIOj7Z8apVVSZ15cMxOYEmgmti3wuqXtWnQdfZ2Vj7bBefYHp3iPM19YZR?=
 =?iso-8859-1?Q?pVksmR2p+knr5BfjuEWbtJS/ZpRrP0OQRggXaVULxUKJn/J8aj3kryyBN7?=
 =?iso-8859-1?Q?wfiXhKNJzWRo3OpWO7K4IqqcyUovfnMDAE1nkAG8jKWl77ExQ7Tj8HO+GH?=
 =?iso-8859-1?Q?gj+Ae92+AA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS4PPFB691D9211B0432FC71D96571491B79E93ADS4PPFB691D9211_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFB691D9211.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d6b9d-843d-4d0d-2870-08de5cf9dd8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 16:42:16.6268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Eu0sVxEgbGYoH23TcrVF43mbCjk5IuGEk9d0IWJu2ntNgZLMVy42jfzNCQVv2DioBhBUHWQRc6+sjqzwSmdEexmgCc8ZTdTDiT6a0dZ3hU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR15MB6777
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
From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_DS4PPFB691D9211B0432FC71D96571491B79E93ADS4PPFB691D9211_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everyone,
The Trace Compass project holds monthly online meetings to discuss the curr=
ent state of the project, ongoing development work, and upcoming plans.
These meetings are primarily intended for committers and contributors, but =
anyone interested in Trace Compass development is welcome to attend.
Schedule:
The meetings take place every second Wednesday of the month at 10:00 AM Eas=
tern Time.
Location:
The meetings are held online using Google Meet.
https://meet.google.com/rsq-gzem-tkv
Calendar:
All meetings are published in a shared Google Calendar.
View the calendar:
https://calendar.google.com/calendar/u/0?cid=3DdHJhY2Vjb21wYXNzQGdtYWlsLmNv=
bQ
Subscribe via iCal:
https://calendar.google.com/calendar/ical/dHJhY2Vjb21wYXNzQGdtYWlsLmNvbQ/pu=
blic/basic.ics
Subscribing to the calendar is the best way to stay informed about upcoming=
 meetings and any schedule changes.
Agendas and minutes:
Agendas and minutes are maintained on the Trace Compass GitHub Wiki (https:=
//github.com/eclipse-tracecompass/org.eclipse.tracecompass/wiki/Project_Mee=
tings) . Participants are encouraged to propose agenda items ahead of time =
by editing the relevant meeting page.
We look forward to seeing you at an upcoming meeting.
Best regards,
The Trace Compass Project


--_000_DS4PPFB691D9211B0432FC71D96571491B79E93ADS4PPFB691D9211_
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
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Hello everyone,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
The Trace Compass project holds monthly online meetings to discuss the curr=
ent state of the project, ongoing development work, and upcoming plans.</di=
v>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
These meetings are primarily intended for committers and contributors, but =
anyone interested in Trace Compass development is welcome to attend.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Schedule:<br>
The meetings take place every second Wednesday of the month at 10:00 AM Eas=
tern Time.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Location:<br>
The meetings are held online using Google Meet.<br>
<a class=3D"OWAAutoLink" id=3D"OWAe86685ac-2ffd-a267-5580-1df07c75bfd4" hre=
f=3D"https://meet.google.com/rsq-gzem-tkv">https://meet.google.com/rsq-gzem=
-tkv</a></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Calendar:<br>
All meetings are published in a shared Google Calendar.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
View the calendar:<br>
<a class=3D"OWAAutoLink" id=3D"OWA86c67b98-944b-2fd3-e0ed-49cf3e58b1d2" hre=
f=3D"https://calendar.google.com/calendar/u/0?cid=3DdHJhY2Vjb21wYXNzQGdtYWl=
sLmNvbQ">https://calendar.google.com/calendar/u/0?cid=3DdHJhY2Vjb21wYXNzQGd=
tYWlsLmNvbQ</a></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Subscribe via iCal:<br>
<a class=3D"OWAAutoLink" id=3D"OWA2c3614b0-82a3-727c-0032-d9dfcd66c3e2" hre=
f=3D"https://calendar.google.com/calendar/ical/dHJhY2Vjb21wYXNzQGdtYWlsLmNv=
bQ/public/basic.ics">https://calendar.google.com/calendar/ical/dHJhY2Vjb21w=
YXNzQGdtYWlsLmNvbQ/public/basic.ics</a></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Subscribing to the calendar is the best way to stay informed about upcoming=
 meetings and any schedule changes.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Agendas and minutes:<br>
Agendas and minutes are maintained on the Trace Compass GitHub Wiki (<a hre=
f=3D"https://github.com/eclipse-tracecompass/org.eclipse.tracecompass/wiki/=
Project_Meetings">https://github.com/eclipse-tracecompass/org.eclipse.trace=
compass/wiki/Project_Meetings</a>)
 . Participants are encouraged to propose agenda items ahead of time by edi=
ting the relevant meeting page.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
We look forward to seeing you at an upcoming meeting.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Best regards,<br>
The Trace Compass Project</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS4PPFB691D9211B0432FC71D96571491B79E93ADS4PPFB691D9211_--
