Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A411C28B20
	for <lttng-dev@archiver.kernel.org>; Wed,  2 Apr 2025 14:01:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZSRNs4d6sz1kWH
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1743602479;
	b=XTcIucQl3Mdjn6vpEC6XOccKfGYUhqFzfRRSJojdCyYZshsHm+4Jra6fDLqaHEmJlujI
	 2slY5uqeubjMUyySkscQ2IQ9iWBTXibDkLxDXQzesz1u7SI0p6zS5csDePZDm6TRZB4uu
	 CFVI9G1eqVA+Y+Ia65Yl4G4A5oO4TiN/HQH1KLcsJWMwbUuqmSzxxUbbVdNzi27Ce+rlf
	 oljtT5DEQTpI9PjBQz7Y8xzsXdRIJ6XTK1dIiSwZY5oX6MOXJFvqrHSxViYNYs88K0yAy
	 HSo7hUMpvzOK4IqQEO0+QXq1VrfkdanFBcnQBMu2dB9LN7X5GP56dc2VytJXIJWzKPw==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1743602479;
	h=DKIM-Signature:To:Subject:Date:Message-ID:MIME-Version:From:From;
	bh=qCKe9d4P/LkFqiI4PNRFsO79lvyvtjWo9d75cerZ4xk=;
	b=Ov8fTStKqx7qfMdErlJy5savScT0ZqWiEqgvpyz+IAJSQfDIh51UiGxJSM4BobuEs9jn
	 70J1eVEEKWGmVgL0FoXBagMc5ekvT8xyBD1ZXvcuXxXUzQcs8HxZNFCuMFL/tUZA2HDXb
	 WlpJqaQuBdqmVqWd5/AuEp0gNgCGJSX56UY5CISyoeOv5pWC93osdFGNe0ppgtLS1/yLe
	 MVr8FfNhB1GFplib92nbNOHH2omCaJyrE+jhGkEs+TFKVVDkso2+zowz11cibazwImLpy
	 twzDqqL4Ct87lDasvbdM+7zBQtnviYvnI9Ik2KRKwpruI9b3jR24OeCwJ7nRNJ4VsKg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZSRNs4d6sz1kWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1743602479;
	bh=qCKe9d4P/LkFqiI4PNRFsO79lvyvtjWo9d75cerZ4xk=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=VSS2uFflhZku0NynLZn43ygsbGzjsnRFgyB+w3jihNlMdLFEuYwuh3SqawPU93dej
	 zJ/f7O3A8Ef2wiSnHcyYSgw59cqnUWoS65boqFjIeWgCvXlzShotn7Y7qL3qR0mHI8
	 QFB4x6/A9+2NXWWjiJlqU1gLeFbfgSFSmZmlklJxt0LUjY/ofG/LKTWWewJdRNAjTE
	 Jc3hc86v0A5LStFbU2ah5gSYLukkg7bbyUljDVGcCjoLjDSPtgmg0Ex5uSBobxOugM
	 AaxrxDN0ok4HCJZo3ExcBUCnQnMezDfssgg+GCOwqrnF9+hHJlWru/fhyjfKZDnO1Y
	 ubDhSppykMD1w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZSRNs4d6sz1kWH;
	Wed,  2 Apr 2025 10:01:17 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZS9dk0qVcz1cjd
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZS9dk0qVcz1cjd
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by lists.lttng.org (Postfix) with ESMTP id 4ZS9dk0qVcz1cjd
 for <lttng-dev@lists.lttng.org>; Tue,  1 Apr 2025 23:41:29 -0400 (EDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5322Bx7X026717
 for <lttng-dev@lists.lttng.org>; Wed, 2 Apr 2025 03:41:27 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011026.outbound.protection.outlook.com
 [40.93.14.26])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7v8j2r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 02 Apr 2025 03:41:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA/U7C9dMtA+QEaOaohzImddRr3e8GFSmoT2dL4j0IH8HdhWvOg2nhSV4AH4GePFlSpk9bJxvYKzQTiB6U+9x7A6DfTk8ckjK576i34gPwYECKYF7zMX8EIukxYMU7Hi89GQbDef5FfkpBs6UXKwfhI2hw41pl9+dDmUQ2cmB+aG8S9mW0X77SpqjTJ8CCPMe+pic4L1qb1EPGf+muIv4TeQh4vJ6Q1ScgmykvP0cPX/er3VduCXxXpYRxbW7+7b+GAty3relHF2zKPHQ7q9fCy5Mx084sehUQ7i/vVD9ruiBkntW8qbKzs7BQg/5T1Kz5eBMkEvK7I05XujsmXn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgmRQPpmyR1mlvNo+lq7b4lAvQdPFIsMYsl8KRf7u9k=;
 b=pFKclfg6BoNnCY09i5b0fQrUeXWzeIH16JTWNrTYLW67ep2Q7CUGGMfvcackw1CVt+BA+hqHaDfxjtW5rMxFXvUNaXs5/KkACD8Erm3l6b8S4UhTZsIaJCRJXbx6FFriHhRhVlKv+/3FTM8lHhCIyNlx1eCHIyYJqocOOLiI9EFH/p6mVGiyrbHuadoYeSouceCA7uy0n30hzAL3npiOKiofcPp6DmMop2BsbjuCZWK8P4tRavvDBImsklZsWaEn6s6+2Z6aopeJmk4QbwGZ1dm94CF+zSNoUUtTniCbQV9PV3QRGmfEoesMhVDylCXEXQ8QCbcfOaxnDbOo5Jc09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from MW6PR02MB9671.namprd02.prod.outlook.com (2603:10b6:303:243::8)
 by DM8PR02MB7927.namprd02.prod.outlook.com (2603:10b6:8:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 03:41:08 +0000
Received: from MW6PR02MB9671.namprd02.prod.outlook.com
 ([fe80::7b8b:ef57:1485:5461]) by MW6PR02MB9671.namprd02.prod.outlook.com
 ([fe80::7b8b:ef57:1485:5461%3]) with mapi id 15.20.8534.045; Wed, 2 Apr 2025
 03:41:08 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: LTTNG Session daemon is crashing when i launch lttng
Thread-Topic: LTTNG Session daemon is crashing when i launch lttng
Thread-Index: AdujgIZzavP0WODUSRWeK9bPmCUICw==
Date: Wed, 2 Apr 2025 03:41:08 +0000
Message-ID: <MW6PR02MB9671CDAF08B397819190B963F9AF2@MW6PR02MB9671.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9671:EE_|DM8PR02MB7927:EE_
x-ms-office365-filtering-correlation-id: 08f5585a-65e3-41cd-8d37-08dd71983459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uu0gF8E4W3DeOlN928aXnxRQVXKNt39Bg378JtnCSTE/rTzyIMwdtb19QATM?=
 =?us-ascii?Q?T+aWwNpM6wEHSVHa7vlzzEqw+NjOXBW5PlLLnC06HAz45Jlbpi5N2DcdtgCr?=
 =?us-ascii?Q?wfpBbGz+k9iscJxoEoyzRxdACwzhqD45TvsIp9GyiIGhtAWfZMFVTSuyHp1n?=
 =?us-ascii?Q?Ya4Wq6CtnbGZGANzA8WsoIwqBE+nWe/zGFq03NuDYqwoYyymnnH4ODzR/WFa?=
 =?us-ascii?Q?pfQ/cSxZcWc0dViHWGBc3euTDNHlX6MBU2geN5qPXJsyvNKA//c52QhSShN1?=
 =?us-ascii?Q?lroae/QwtAPHpqgIWWf5aRpsktgYbmu+dwVJDXMAQoTmBGHpHXAm1wvDZtNp?=
 =?us-ascii?Q?+oklP/t3XXJo61wfQ37jBrUNmrlaRycHd/m1ml7a9jR7k3nbrP2lNfCi8sdy?=
 =?us-ascii?Q?arPNCpW252o5J6dEW4g5wFT6g1SIUulwm1e2CI7/m4ooeNG72RazwvgyDcr7?=
 =?us-ascii?Q?Emm/RuJTNk5NQOOFaU/sC7bfsQG7+cimY0EzRv6YsTpdl8J0vG4Yq/5eGDBL?=
 =?us-ascii?Q?dGl/WnLf3InVbQ9e+tvFZe9mMIEVv81fR0mjkhZrUtPx6+e74JXRFl8eESy3?=
 =?us-ascii?Q?Ily/4E1sdOVS8cYKTEbodBrjYPErFBqNdoabfk/BpCBcQYSXLjYsvdQPNNcL?=
 =?us-ascii?Q?xoRmuZXfwajo9VnfIKJaxxuWDrVxbwdms6V1vYfcKZEM2WuYFeEIFB9H51zg?=
 =?us-ascii?Q?Y3HLoJtgYDHUE5WXl7MYGqpxbPR3AiO9UHo+1DJGbSOkh+6pV2g1JC9+BMco?=
 =?us-ascii?Q?ZIYNdtaogi2krUdQWC4/FzNCbBbGk1TzKZUY5ir1hwd0c+jb78HBxaCCJDLn?=
 =?us-ascii?Q?5eV5ftbJE5zabHDgG7T7iu8BZX2kT/F0fNHy2WUNFSTdHiYLkfx7kdwypXDA?=
 =?us-ascii?Q?vnj6lx8o8SHdOATu2fMCUSyaYULnn8mumdmHM2UVkQtKRSg8wpyfA3jrwiS6?=
 =?us-ascii?Q?aIluQ1DM7KBj65rqa/9ls2riDZE+cUu8N6L2epvW1ytvdpQbeDEhkg1MkkMu?=
 =?us-ascii?Q?3znc3v3oilECmqZriE/adRulibgHsF2uaM0J+X0FTQXmZDNcQ+oP2U+5OlVp?=
 =?us-ascii?Q?r9Vpn8Fn3sfVyW0hRnXsOgZDW3ATRkC1ioOKPyr44ogVQaJz5W9OGQ5Ya6KL?=
 =?us-ascii?Q?PSkz9OAmMVl+j4onT4zzprv4cg606s8Fn3IlI4WKi7/ifRNMnKV3HBqlPR+I?=
 =?us-ascii?Q?baZNx1ztOb0z6WP8kI4CjPp9JXtEL5H6Bh4zTHLnVt3Eye/kWYgUvxSfhFGy?=
 =?us-ascii?Q?/WkPHKUYfFVS/p0JpSZd1gQsfdLXB7IEi5pAXkQ/HIdgS7wk71qKLYSHduDX?=
 =?us-ascii?Q?tXOSAICAiUhHKu+o6J41NU3mbaUr8XyrhoncdcIzUAMS82RY0DrUVC3V7W+4?=
 =?us-ascii?Q?IgV6v+NJNCWpYuzC8wHOazw2JxpuQlp5CnL4Bvw/gbvqDTvqUc4PtzBD5nFd?=
 =?us-ascii?Q?etuqDHIkl9MIaxBX3uV06x+Rf4Uivdvo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9671.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ynm7qacICqy3dpnDI+pjxFaVpIIRCiggFb/XnbtW/syh0SXfu8ih5vKa7Cbc?=
 =?us-ascii?Q?q5Gqaa+iOxs3k+gEDlVp2l0hZpvYFUJC31ez6uoifHX0JTPNSkqzhQVopl3Y?=
 =?us-ascii?Q?dPQV/dhfCij9gPomAIV2U0ZjX3/CFTLFwFVZfpuHLnIfrCThQQs7ZqCiRkVI?=
 =?us-ascii?Q?io7+tHsVG93qY1QqehQWY21L0Pju/mM1oPbcPdxDtQ8jmC71J0KP5UPSJtnu?=
 =?us-ascii?Q?O1Y6bTGQU2t4BPePu0dj3SInLXhK9R9Kixd8NDg+8YC/xmwHkbI3YlLipfJX?=
 =?us-ascii?Q?tyi74IMmWtMMb0RIYLSpSv5L9fCM0N0FTzNMMwoU8l1a5Rx60N8dTR4I2XdX?=
 =?us-ascii?Q?b/+CxkQ4X+IUTTZjd9yPhBcZCgoav7G4FMNowq4IrZ557U/nDud1EFf755LO?=
 =?us-ascii?Q?Hs2i0NtydpNSQAVl7xYoQ2RYlJT2q85or7kwLwYn8ECCvygsJZ0Onk/pgsc7?=
 =?us-ascii?Q?lmOrByV3oAVBnglp4a04uea4pqfXD1h8fm1Lrx7zv6m1MC1PrmYkrysJXu0L?=
 =?us-ascii?Q?rryx9tCM0H4/kRq8YLvXTctSQHZniRI9rOPx7DTZ+h7lgLKaV+XBoCDhn4aX?=
 =?us-ascii?Q?I2rtfD/spa5WnxKD9wSO47l5zQWqZinH11AcSg9V22jYUTnwjwyINrg4764Q?=
 =?us-ascii?Q?FVBP+mZH9h9N1eg1WYeEESfKSfLC2hFRBFERBBJn1YCkf9pts43jPaOm0wMO?=
 =?us-ascii?Q?eZDtvk8aC3Go7S47ZAycUMsHT+Lq7Xwof7TeZn0FnStJ4Z8uaLb/q+u1asDX?=
 =?us-ascii?Q?RmYdX3nabnt8NpYYWgXQaf+40tmBBzR4av28p+jFIiDSPU+RN6DczKUDksZk?=
 =?us-ascii?Q?2uwRQBgpwjlCEvx9gQhnUdKaoXMWSeoenxLw9v5BovZzzZWpfZj19+0O4V5e?=
 =?us-ascii?Q?6uxw8frpSeT6KM+bwYestub+Dguir6yUIkgTJU2JOaBNa+qX6odZXk0mZ0Vx?=
 =?us-ascii?Q?tbsTS56unE+Ham+7TF57KK3lThByaW0gK13pvKTyIEIUqyTnOKPoFftYC4E6?=
 =?us-ascii?Q?1FjPhGatdaInSRkgQD22g1VbKFPIdCywEvOLPZ15f5VJs8qzQOQV6UbLrhJ3?=
 =?us-ascii?Q?ZdbGj0TPm2etdIHwFbXyzdfrqBzsZ9+Wn9HRDyQ4VBW/2AN9cwyQjEuO0MYv?=
 =?us-ascii?Q?yPe1iz+jrnR8xMp4kRQGUYFwA4obI/qwdONkXDeR7vuhGII67L2EXZuCl+W9?=
 =?us-ascii?Q?3/MbPTu42xf3p18jXjgTRqlnk/3N4xC+mDZUcU+j1qK6B+oW7yOVxCk7ZuJa?=
 =?us-ascii?Q?oCZu5sbls9QVRmH6I21KWTdqpCYCMlRz/SQjtnENp9pVHFN7myLLmEL0+SSw?=
 =?us-ascii?Q?CzcltB6doFSXetSBn8YQLe3UKE55dAy40ekWECByQ/2grtNeQiDTR4+uF1IW?=
 =?us-ascii?Q?d2Vn5H/6ukQJt8YeDYeL87FrkrQLdvZqPQE85aMWhYiTLK9RF3f3s+HnsdMu?=
 =?us-ascii?Q?oVJZRW/OfN7owba0hsi+BW1ZQ4Evacrs1mXSdgrGnkCgZUXBcFMgdSGTLuSA?=
 =?us-ascii?Q?wKPYaRADN+LuNx3ZTlQzzrCGy+IeC9vR6dAXotJTVonohtyt/xjWTPIye4VV?=
 =?us-ascii?Q?2nNPW6CK631P5URyRTSranhj86jcvbJDcQ4FTV+5?=
Content-Type: multipart/alternative;
 boundary="_000_MW6PR02MB9671CDAF08B397819190B963F9AF2MW6PR02MB9671namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OlkSt6RAdhtWGT+2mcYh9UvZLC5gSsKN89uKKRQLoudOfwhRHAa2saSNKALcwInyJgPaBNIefVEclnvLcFnueRt1CuqC59lcvFp6mg7gjW1HZzIeV/1mwxUzv8gHDEbteuHBJgjUF1HIxN6TPKa3unoedxmVMn3V+6N4LxJjFlbZPJfpCChLIU4Pkgjw24vTRMONq2Hu0ce8xABHXU9SJrheYfvHf23KeTejLpVA3Pm4kTsDkKSbHBlrmaiN7AEfj5qK+rdATNB/KpancjatjBxBNUMhpYlpBDPLwUESVyzoYBYk5E5u0Xmtc4+oyVLdOYfdF/wyEcGQ+mANeWxGU6AJ7ns0j7T7JLGJIIyoH1qVgqsd2FIzWM7XlGBRdbKsoqiTWsRux2MaOZNhRhfryYzigdwsYOVkqTXZxUe9huuf0W9LDaCfVBrd9m+h1rqtVL8WPZFpfvD+7mV5xkDG0HQg2Ua8sI4p/X99vASnOUlMxeDpMy2CdxI9qxtNqQ0TK4DfdMlJjU30voW3paBSpmCdO+ObuIcByrk56GSZiBxanD+MkXz79RSvG+YXMI/Qpw9iY5yPtKbvIgJuvyyYVXzUT9zECGd8UP8DyisQqE3qog8vrkHrbmc6Z6Oxa7Qp
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9671.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f5585a-65e3-41cd-8d37-08dd71983459
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 03:41:08.3651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kB/zGksPOzF/RXvCfoz7wKIg7BDnlEO3gSIOrhymmu/HEiH9a2s4GlokVd7ZW3cnkctW4Ake2wBe5766pZm5UoRljlmDQnqIVlwpef/SKv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7927
X-Proofpoint-ORIG-GUID: _VfwcIfRICs4-dG4SUyPJdj8OAijlLjE
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=67ecb1e7 cx=c_pps
 a=GnUjYDbtZuq/T0BoTQNfSw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=9jYZGyJ8cc-0a5p317MA:9 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=0ORDjFhzc8L5WfeF8hcA:9 a=AIRETTNAJUfUveJq:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=vUsbdJjsiYsWhgVz2Rkt:22
X-Proofpoint-GUID: _VfwcIfRICs4-dG4SUyPJdj8OAijlLjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020022
X-Mailman-Approved-At: Wed, 02 Apr 2025 10:01:15 -0400
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
From: Deemanth P J via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Deemanth P J <dputtaja@qti.qualcomm.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--_000_MW6PR02MB9671CDAF08B397819190B963F9AF2MW6PR02MB9671namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
We are new to Lttng,
We have integrated lttng in my image ,
whenever I launch lttng we observe hung behavior,
So launched just lttng session daemon I observe crash,
Please help us in moving further


root@sa8797:/usr/bin# lttng-sessiond --verbose
DBG1 - 17:44:14.742294853 [Main]: [sessiond configuration]
DBG1 - 17:44:14.742326260 [Main]:       version                        2.13=
.9
DBG1 - 17:44:14.742350999 [Main]:       verbose:                       1
DBG1 - 17:44:14.742374333 [Main]:       verbose consumer:              0
DBG1 - 17:44:14.742516468 [Main]:       quiet mode:                    Fals=
e
DBG1 - 17:44:14.742524437 [Main]:       agent_tcp_port:                [534=
5, 5354]
DBG1 - 17:44:14.742531572 [Main]:       application socket timeout:    5
DBG1 - 17:44:14.742538083 [Main]:       no-kernel:                     Fals=
e
DBG1 - 17:44:14.742544645 [Main]:       background:                    Fals=
e
DBG1 - 17:44:14.742551260 [Main]:       daemonize:                     Fals=
e
DBG1 - 17:44:14.742558083 [Main]:       signal parent on start:        Fals=
e
DBG1 - 17:44:14.742564645 [Main]:       tracing group name:            trac=
ing
DBG1 - 17:44:14.742571885 [Main]:       kmod_probe_list:               None
DBG1 - 17:44:14.742578708 [Main]:       kmod_extra_probe_list:         None
DBG1 - 17:44:14.742585374 [Main]:       rundir:                        /var=
/run/lttng
DBG1 - 17:44:14.742591937 [Main]:       application socket path:       /var=
/run/lttng/lttng-ust-sock-8
DBG1 - 17:44:14.742599385 [Main]:       client socket path:            /var=
/run/lttng/client-lttng-sessiond
DBG1 - 17:44:14.742605999 [Main]:       wait shm path:                 /ltt=
ng-ust-wait-8
DBG1 - 17:44:14.742612978 [Main]:       health socket path:            /var=
/run/lttng/sessiond-health
DBG1 - 17:44:14.742619593 [Main]:       LTTNG_UST_CLOCK_PLUGIN:        None
DBG1 - 17:44:14.742626156 [Main]:       pid file path:                 /var=
/run/lttng/lttng-sessiond.pid
DBG1 - 17:44:14.742633551 [Main]:       lock file path:                /var=
/run/lttng/lttng-sessiond.lck
DBG1 - 17:44:14.742640166 [Main]:       session load path:             None
DBG1 - 17:44:14.742646728 [Main]:       agent port file path:          /var=
/run/lttng/agent.port
DBG1 - 17:44:14.742653551 [Main]:       consumerd32 path:              /var=
/run/lttng/ustconsumerd32
DBG1 - 17:44:14.742660114 [Main]:       consumerd32 bin path:          Unkn=
own
DBG1 - 17:44:14.742666624 [Main]:       consumerd32 lib dir:           Unkn=
own
DBG1 - 17:44:14.742673812 [Main]:       consumerd32 err unix sock path:/var=
/run/lttng/ustconsumerd32/error
DBG1 - 17:44:14.742680478 [Main]:       consumerd32 cmd unix sock path:/var=
/run/lttng/ustconsumerd32/command
DBG1 - 17:44:14.742688864 [Main]:       consumerd64 path:              /var=
/run/lttng/ustconsumerd64
DBG1 - 17:44:14.742698916 [Main]:       consumerd64 bin path:          /usr=
/lib/lttng/libexec/lttng-consumerd
DBG1 - 17:44:14.742705478 [Main]:       consumerd64 lib dir:           /usr=
/lib
DBG1 - 17:44:14.742712353 [Main]:       consumerd64 err unix sock path:/var=
/run/lttng/ustconsumerd64/error
DBG1 - 17:44:14.742719020 [Main]:       consumerd64 cmd unix sock path:/var=
/run/lttng/ustconsumerd64/command
DBG1 - 17:44:14.742725947 [Main]:       kconsumerd path:               /var=
/run/lttng/kconsumerd
DBG1 - 17:44:14.742732666 [Main]:       kconsumerd err unix sock path: /var=
/run/lttng/kconsumerd/error
DBG1 - 17:44:14.742739228 [Main]:       kconsumerd cmd unix sock path: /var=
/run/lttng/kconsumerd/command
DBG1 - 17:44:14.742748656 [Main]: Starting lttng-sessiond {3cf95868-38f8-49=
4d-963a-0c83c13262dd} (in sessiond_uuid_log() at ../../../../lttng-tools-2.=
13.9/src/bin/lttng-sessiond/main.c:1437)
DBG1 - 17:44:14.743890166 [Main]: Resetting run_as worker signal handlers t=
o default (in reset_sighandler() at ../../../lttng-tools-2.13.9/src/common/=
runas.c:1377)
DBG1 - 17:44:14.743934593 [Main]: run_as signal handler set for SIGTERM and=
 SIGINT (in set_worker_sighandlers() at ../../../lttng-tools-2.13.9/src/com=
mon/runas.c:1438)



Thanks,
Deemanth PJ

--_000_MW6PR02MB9671CDAF08B397819190B963F9AF2MW6PR02MB9671namp_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<br>
We are new to Lttng,<br>
We have integrated lttng in my image ,<br>
whenever I launch lttng we observe hung behavior,<br>
So launched just lttng session daemon I observe crash,<br>
Please help us in moving further<br>
<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal">root@sa8797:/usr/bin# lttng-sessiond --verbose<o:p><=
/o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742294853 [Main]: [sessiond configur=
ation]<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742326260 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; version&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 2.13.9<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742350999 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; verbose:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 1<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742374333 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; verbose consumer:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742516468 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; quiet mode:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; False<=
o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742524437 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; agent_tcp_port:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [5345, 5354]<o:p></o:p></p=
>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742531572 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; application socket timeout:&nbsp;&nbsp;&nbsp; 5<o:p></o:p=
></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742538083 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; no-kernel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F=
alse<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742544645 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; background:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; False<=
o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742551260 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; daemonize:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F=
alse<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742558083 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; signal parent on start:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; False<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742564645 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; tracing group name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tracing<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742571885 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kmod_probe_list:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742578708 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kmod_extra_probe_list:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; None<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742585374 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; rundir:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /var/run/lttng<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742591937 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; application socket path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /var/run/lttng/lttng-ust-sock-8<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742599385 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; client socket path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/client-lttng-sessiond<o:p></o:p=
></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742605999 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; wait shm path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /lttng-ust-wait-8<o:p=
></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742612978 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; health socket path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/sessiond-health<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742619593 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; LTTNG_UST_CLOCK_PLUGIN:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; None<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742626156 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pid file path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/lttng-=
sessiond.pid<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742633551 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; lock file path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/lttng-sessi=
ond.lck<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742640166 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; session load path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; None<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742646728 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; agent port file path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /var/run/lttng/agent.port<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742653551 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd32 path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/ustconsumerd32<o:p></=
o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742660114 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd32 bin path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Unknown<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742666624 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd32 lib dir:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Unknown<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742673812 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd32 err unix sock path:/var/run/lttng/ustconsumer=
d32/error<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742680478 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd32 cmd unix sock path:/var/run/lttng/ustconsumer=
d32/command<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742688864 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd64 path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/ustconsumerd64<o:p></=
o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742698916 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd64 bin path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; /usr/lib/lttng/libexec/lttng-consumerd<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742705478 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd64 lib dir:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; /usr/lib<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742712353 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd64 err unix sock path:/var/run/lttng/ustconsumer=
d64/error<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742719020 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; consumerd64 cmd unix sock path:/var/run/lttng/ustconsumer=
d64/command<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742725947 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kconsumerd path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/run/lttng/kconsumerd<o:p><=
/o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742732666 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kconsumerd err unix sock path: /var/run/lttng/kconsumerd/=
error<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742739228 [Main]:&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; kconsumerd cmd unix sock path: /var/run/lttng/kconsumerd/=
command<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.742748656 [Main]: Starting lttng-ses=
siond {3cf95868-38f8-494d-963a-0c83c13262dd} (in sessiond_uuid_log() at ../=
../../../lttng-tools-2.13.9/src/bin/lttng-sessiond/main.c:1437)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.743890166 [Main]: Resetting run_as w=
orker signal handlers to default (in reset_sighandler() at ../../../lttng-t=
ools-2.13.9/src/common/runas.c:1377)<o:p></o:p></p>
<p class=3D"MsoNormal">DBG1 - 17:44:14.743934593 [Main]: run_as signal hand=
ler set for SIGTERM and SIGINT (in set_worker_sighandlers() at ../../../ltt=
ng-tools-2.13.9/src/common/runas.c:1438)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<br>
Deemanth PJ<o:p></o:p></p>
</div>
</body>
</html>

--_000_MW6PR02MB9671CDAF08B397819190B963F9AF2MW6PR02MB9671namp_--
