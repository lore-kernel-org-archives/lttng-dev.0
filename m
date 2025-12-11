Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF8AD41D64
	for <lttng-dev@archiver.kernel.org>; Thu, 11 Dec 2025 16:14:36 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1765469675; x=1765476875;
 h=Sender: Sender: Cc: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: MIME-Version: Content-Transfer-Encoding: Content-Type: In-Reply-To: References: To: To: Subject: Subject: Date: Message-ID;
 bh=a1/Hz/01+2w7vMqmQo6O4mTqpAjmTiTO1BrNQEIY6WA=;
 b=o2btn3221sJHQ60tpTR3ClZA8PazXdQ78dxtz7sTOswMALTv/awjLDQpgdlCvbquSRbS8UNQBKSmkoUGm8lUQoMvgCrg8TcLeRwt/6iRQUOqZGjX9AjVNMghKamluXh/p13k1EqYeBJeQhzGsnSyuukIqzLLg0w8D4ycPlF85A5pgjYqclB1Szr+xJoUNfyYLZ4XkdXUTSTiyd9CyH8myo6yMfnmNHPDxZuTxyl2s0GFpHp+0PJsxyv3JaPOKTnDnC5oIv3u8Iz+vxYRE63BS3DIlyc2aVLrXGZEIoQB39vRpcxzbE7iSVXHjMEdG915NJnGREawG0n/90BYsa3XNw==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 f79737c0cc1f1b4a9d3ac82fb546c8533422bf6515ec96090b4f8a99c4126def with SMTP id
 693aedeb0b2e34eaf1e7ac1d (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 11 Dec 2025 16:14:35 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRyMt1q7Qz1xDb
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1765469674;
	b=cWC9SHwlH5IWivLWk4buFM0UEDHoGyDEp+6G8J5W0qiHfaNxhtbAowvavFMx62dqdgux
	 8VJ1xijneqvaWpbEOuGznnV5zjp4VGrUlxwmW/VD2wiLrLLeBL1v8Le5aLra/ZBdnOHu7
	 BIMiyVrnv/Nd2DJ5VbadIZJVf5YVfAYM7ig6B9R3N1zbNy72VJnpTx5v2t4LOPGexjFb4
	 pkezIp0D/QKRD4Gk9viWmhkw8SVyJLfDo8eLjY/Uq9ZFHoUuCq/4SGdpGKhU8/lH6Q++s
	 K3Cvd0QzSz46UmbU+RlQ/7QKGmvlzoB4PPO7b9jXShxosRqddG4qovybW0hAVDH6NUQ==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1765469674;
	h=DKIM-Signature:Message-ID:Date:Subject:To:MIME-Version:From:From;
	bh=UdHmilUKBek6OGoTMGti2dqWQgYCoXxXEf0YOFLQPoY=;
	b=OgNYFgbFx/lbUp+0zl1Zdbi/6OYUMMGrzIBSpFV+EZoZmILd/fWJmuLLh2zU62hL8P+1
	 VAlLrFiTsIb42feKUcPw7INIjVNCzQBO35f3DYK03gW+330NcOBNAqkZ6D5IJfGMAZiw1
	 L/8YFF11qH80taGPazsTWurEyY/IJrtKH4ZylFfUDJ8Ri3dpUenJ8SSngivdm9FW3CJDr
	 yMbLZ3gAzVcrOhkX7fdcshCW1jgfKV5HpT+s3wHxqg5945ivsiAfEvPxgSlMWMbWE/QIb
	 1gZ99NrDg0QVyBhLh+5wSjHYZMZ5b1ciQMtruplrIZrO4CxPP/cVy9X9Usan8p5EPLA==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRyMt1q7Qz1xDb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1765469674;
	bh=UdHmilUKBek6OGoTMGti2dqWQgYCoXxXEf0YOFLQPoY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ouDkEkO8Gx0JWGLJ5pr5KAfstG5g/NFBqKUtsTCk+//uEeXhwfyOklzOj/xHdf7X1
	 T9NAJUDLLK+iN4NJSfiDUBVALCAtWsJES54GynSGSBXB5WhXkewR1uPmjGaoJpFbD9
	 t1gGvuoZ102LOIuAH+ahTzj+0GtJ66ifPN23g70BIP7gLx8GMEEeyoGx6E1H1D2T7Q
	 qXgCmbKSllbnpVs6ZbIfASbUR42B6kj4wDf8523iiA2o6kT1CA/rzSrEPyMbrHE9bc
	 Soobu7dpavCa9oltpnoIlvdUTeDg5YeM2SvCRdj2uxL4WRlng7YIOV+y+cjqJcdUHw
	 4nRnTAs7RHEdg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dRyMt1q7Qz1xDb;
	Thu, 11 Dec 2025 11:14:34 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dRyMr13n6z1x3P
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dRyMr13n6z1x3P
Received: from YT3PR01CU008.outbound.protection.outlook.com
 (mail-canadacentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c103::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4dRyMr13n6z1x3P
 for <lttng-dev@lists.lttng.org>; Thu, 11 Dec 2025 11:14:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNcY+SaELx1xXpqHKpe16jCnFUcKfAJg9uJvk0FSxPMOamiRi1vfhvelN9ndS7GR5lMHHUgAFSoAo2vxFSZnJtn7qZrxy+f6RF+eZmDyBlsa187hNUT2LrZFtGKG7sqw1kq6zrsp5DSOnSJ9a4tF5r5fpNtDfZ1s03sSUB3da7eDXHZanjwN3x9LPt/vx+kJYpOSJdQd0Ep/nc2s1CyxtcefvZlxvomkTh2XdTeGcvxpGTwykB0XQ+0s3r88TaM+r80DojGHnL6aRXFBbi36+jP2TqGB18o53anpRPTNMT/inefjjm0IFFxA/obqKsntxp/qtF4xMe3P8wL9mWax2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1/Hz/01+2w7vMqmQo6O4mTqpAjmTiTO1BrNQEIY6WA=;
 b=zBc/kaAIGXxFXnqTkEGTnftrR+fJLn/Qc/xQJeuqVDkAFIznl5/1aOe4EE2oCEHMiuEHhq9Udb3CYuPFimtaAl9cR9VUeoqpxTZlGu4RO60ppa0nHGzlBsnSU6kDnxyo0sUQrv+jmtoZaPVCANylP2lG2s+oDSL9tTSZywy9E20bSrj0PaHPmsdJrJMdunEtTfUoZTAod4CgRlqYqV6FW0ob0+WPIOQXK3csD04wIu69SoiBVGuYEJHACNtCjrbcZENJNDKSnYXhKZ31JfRKMhH1jPCI2LH9Q2Qu0UYeXZFgQOWMj7GHhM2My7XLk55ga+8y1m8cXneIWwjR4N74nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT2PR01MB8918.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 16:14:27 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 16:14:27 +0000
Message-ID: <ad04c3c2-c0ac-4ed6-96e1-29c661e868f5@efficios.com>
Date: Thu, 11 Dec 2025 11:14:26 -0500
User-Agent: Betterbird (Linux)
Subject: Re: Question about LTTng Context
To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>
References: <CAOQX81f1zGCsnr3Ksjv0WoO-J4-OULanefNxzWdrxP8b4+aqJg@mail.gmail.com>
 <87a7e3d3-3ce2-4ded-acdf-bc7f152cdcec@efficios.com>
 <073db198-6792-4caa-81f5-ac65f5d76f1e@efficios.com>
 <CAOQX81e-dtfgLQ+xTt8kr-Qxc+hhiaW4vHF=S=RDVsMR0-TnLA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOQX81e-dtfgLQ+xTt8kr-Qxc+hhiaW4vHF=S=RDVsMR0-TnLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::38) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT2PR01MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e91bf0-c750-4b04-bd54-08de38d05b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDNacGpWUGlVMzN1Y2xQcFFpNHhOWWt2Qk5RUStRbXNMSXVOMjF1cWlnMVMz?=
 =?utf-8?B?K04xb0xXU1Ywcmo5NHhFVWVQcjVHMzVQODBFNkhtRndQVlJvMnIxVlNQUGVr?=
 =?utf-8?B?RTBqaTEwOWhPUGk2aHBiRHlCcFVMU3U5OFRYRlhXMTIrRDhTYnZ4KzhwMjVs?=
 =?utf-8?B?NUZlYWpIZFo4a0gvSSsyeWZCQ1BuUkVGQVlFeWl5ejFtcUoxK1NJdlJTeDhv?=
 =?utf-8?B?Rkc0MVcrWER0RHJNSzNKWEYrbkxzMmFEYTdLdU16VUJnK1BsVkhvakdLam9M?=
 =?utf-8?B?Y3A1WVFlZ25YQVRqT1JuTnRhRmtmaDJHU0hGNlVWdE5OQXlNNHlneEwzaklH?=
 =?utf-8?B?QUFrQ0JlSS9PUW8vREFJUnYvT2MrUnhpR0M5YjlIUkEwRE5YcU9hK3VFalNW?=
 =?utf-8?B?c25NWkdrTUs3RXVPb0hnNm5DOXZxZnlkY2dtM3VnSFFWeUY0UzB1N1Q5OXBF?=
 =?utf-8?B?RGxQY2ZZdDZDdUE0K0RLWDJsdTNBSjFvODV5a3QzMXM3WlJtWlNxU2FrTVhz?=
 =?utf-8?B?Yld0S0lMaHp5Q3lVWFYrNDFPN2IycjZXZ01JM2lzNXJJTGxsM0F6NERhUHI0?=
 =?utf-8?B?NGg0YzN1cWtXeEhPL3JGbmNSUkpQR3c5VkxuNEpZY0h1aDhMMmkzUDYxNGZH?=
 =?utf-8?B?SnlkWlBveU5MT1I1akQ2MGR5WHZoaVh3ZU9EQ21HZktjS3M1SDBpRjh2MTM1?=
 =?utf-8?B?STJ6S0o2bS91OENqUjVhK2hNSC9BeTBGc2o5WCszMExYOFhrQVhEUDZTQzZP?=
 =?utf-8?B?dEcrbHVaamlQaTRObzM1aENaZ1I1UjRpTmFObFNLOFBpUjkxRExDcmNCbFVW?=
 =?utf-8?B?ZnA0UndsQzE4ckJ2OFVrZU1hb1lwcGM1QTFnNjNMRk9NS1pZWlYwMWNJWktY?=
 =?utf-8?B?bEcxL2Fja0xqc3kyT0YrbE50ams5R05NM01IRGI5ZUovUVJMMXQwVnYwVmN3?=
 =?utf-8?B?eDk3Zks0SkVBeGgrN3YyZWdJVnlsNXdGT0REaDg3QytEeTJZWkMzZUVSZHpF?=
 =?utf-8?B?b2lKdjRpZHlFLzhuR0RjdWZvTUpmVVZpczlOanRUN28rSVVQb1hrMWRxL0Iw?=
 =?utf-8?B?VmkyU0VYMlBIQkhwOGh3UWRQZ2tpd2VrendHRVRjYWJEWkVtZTc3MU1DWGps?=
 =?utf-8?B?a0h4cGJQMmUvdTFub1dJMXVzNmNhdCtZMVV0NXRlbHlFZngvSzc4Kyt4aWhF?=
 =?utf-8?B?QTdCOUVKMjR3K1JlTlZlanlmMW5POGJtaE1JRy90YmNqTG0wTno3UnZsQ2o0?=
 =?utf-8?B?b3J2d1VSNVA5S2pCWUdZYVpWalk2bVVVLy9XU0F4TGRKK0wzWmVOcnVRMDlF?=
 =?utf-8?B?Y3ZuQnU0d1lyTlZPaGRSYTZoRkZnakxwMDZCVndQMkFxdjNNemNwTXpwVlU5?=
 =?utf-8?B?S0lnbXdwQkJLa202MEpjdzRtb3VpdTZsUzlVdkVQd2p2QVRZWE8wOUM1SHlU?=
 =?utf-8?B?WEpRTFhMd1dpczVqS3c2QzBjWm9NTjlNOHRPTHRubUpLaXB0NnEvSEJFaE1h?=
 =?utf-8?B?eFFaUFpIQXhMdURjK0tIZGlvdmdPenFmdmNJY1R2d2htSmpPUHZiR3lsQlJT?=
 =?utf-8?B?Y1V2NHk2TlI4S083TGlET3gxeGNxMWJRZUp2YkhsSTZHc2ZDQTNKMEdTVFMy?=
 =?utf-8?B?T2FyTmFBc1FESVZ4RDZKc1ZFalh1ZzJraU5aNms5VHhZNW1XUGozaDVxMlg4?=
 =?utf-8?B?WmxkdENhVnVMK0tCRjBCN081YkJJTW1XZ2ZLbXZtOWYrVmlEMDR3UUQvbHF2?=
 =?utf-8?B?WHdTNU5LWjdqTFBLV1V2OWpCZDlQanh5bDZvSjJZeTN1ZkdDcDZoY214RXJr?=
 =?utf-8?B?RjhhWDR4R09reUs0dklHbTJpUXJpTnZTdDJCMkJsYXpjeHFvNTBiYUcrcE1D?=
 =?utf-8?B?dERmUGR0dXo1dTVvbUtkU0lGblh6VEJ5N0k5d3FicEdjSlVYcnpjampQNVh6?=
 =?utf-8?Q?tcJhpeqHsHEIPoQ0wfSIVmuqBu/faRbR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dURlWUlwOGlhYy9iakZVYk85dXhoNUJHMG5heXJnMHJoNzlBN1BQSUdPOWpN?=
 =?utf-8?B?dUdRc0l0VVh4U2ZOclBuK3hTSjFnaFhRelFZZTBQc280b1M3Y3g1MXNweDFY?=
 =?utf-8?B?cE1NUDZKVFMvNGo3c2VwcHpCWlJRTjlvR0d3cHI2ZDd0NjNnTUdLYjNsUW5u?=
 =?utf-8?B?SmxhOTZHRzFZbVhGYms0NndTdUNENkNtNHRxUnRtSWwyY2dmcHBzdmhJY0ZC?=
 =?utf-8?B?d2RzUWlGdHZVbXg0NUFFT09oaHpMWU1ZVXBxRjBmSFkzY3RyK2M5d1lRbitz?=
 =?utf-8?B?d0VIWmJ6ODBpODAvaXN1bHVqWmFzVmlqUm56b1dhMXNOUmlJSkNsU2thcDVJ?=
 =?utf-8?B?VWt6eVNwMnAxaWRXa085UHBwVldWbGxUeTJWRTZVemg1Uk12Y3hzODR2d3FE?=
 =?utf-8?B?UmFRV1BHUUdMY2F0ZVhIZ2QyaFVjN0JYT0JXNkJiMjhkUHZUMWNSem51elVR?=
 =?utf-8?B?VzQ2aElJaUoxN1ZWNDZqRm0rZ0ZjZ0tWSDV4K0RncFJqaW5FK1JYa1VsZnE3?=
 =?utf-8?B?eUN4b1o5UGJBYjJaQ1JnV3k0SjVVT3RPRU9vTjFXUG92bTlLN0pvN2paRzNm?=
 =?utf-8?B?UnRJa2lxRy9tWEs0THd3a0l2SHZtcWFKbmcyZ2szR3lHMGJIS0RXeFpEaXRh?=
 =?utf-8?B?UUQwWFY1K3hjQXZxdnprN003cXBPbVZNUjdsaTBnZmJ6WDFwaW9HRThzdlF1?=
 =?utf-8?B?K00yd2FsYXFCS1htbm5QNnFqYVc2MWVFVjQwWDZVNjR1YU90MjBHWHVQUnBT?=
 =?utf-8?B?YVJjUys4OFhjQmx5dll0a0Mya3VSWFMyZFd1K0lUYXczZ282bG1jOTVDZjVJ?=
 =?utf-8?B?MUJVUnM5aDJMOEF1cmsrcU96aWhjL0M3cmNDdDYyc3cvTWp4QlRIaGd2aVJV?=
 =?utf-8?B?dm4vdk5sVUxxczBsNkl6N2tibzJkTGpvT0ZGYVBjdy9oanZpcmVHQ28zU0Vq?=
 =?utf-8?B?bVhXME5Ca25pNVVkZ2JpNkVQSTduR2JKbGxHRy96Z2JRdGUvRnJreGUzT3VJ?=
 =?utf-8?B?TEZ5dGU3d0E5UFdjeU1lTVN6SlBQaEJlNkRtK1V4c0ZWTEVLZmxhMUVQcVN4?=
 =?utf-8?B?d1V1c3MrZW8wV2p3SmhtbWVYMHJ0Y2FSS2UwWmE2T2NENUJuOVFYNUluQUdt?=
 =?utf-8?B?NThmeWE4THorVkpZK0tpODBSQUtiMEd0UW9kUzEvRk5VT1dmM3I4ZnRNKzZU?=
 =?utf-8?B?VjRaSWZrVVFZbmY1OUt3VktxOWQvclcrS3h4TGFNWGFuMDNTd1hWZElFeXh3?=
 =?utf-8?B?Tk85R2x0TktkYmUrcXVrdEs3a21PQk5vck5hNDViUmw1OXh0MjlhSmJiblNq?=
 =?utf-8?B?TFFSN3laRmJ4SXREREg5VW9kVUFuNTk2Vnp5NEVXdDV0alhreGZnK0FFWjBo?=
 =?utf-8?B?VGNtV09iSms1WGlGNjZKQW95KzRoejVTZlptOGJQeGdLbEVFS0hUMWFHcm5X?=
 =?utf-8?B?bGNISDh3R2lPalhrUEU4NC9lbGFUUVNoQ3hmOU1rT2RLbHcyUGdWbTB0a09s?=
 =?utf-8?B?djNaNGlaL3NRM0x1NjdyaDlOWWxHTWl0dFNzRnYrek5aTnBxWnNmaFlyZ01P?=
 =?utf-8?B?Q0U0N3pwRTBHdHI0ZEFsakN2ajZvQ1AxUnoxL1llZ3E0aXd0QlBqTVNFKzJB?=
 =?utf-8?B?bGF3eVR0U0xzWTVHRE42QjlwRUJEei9SZ0c4UVE4aE1hWmRERmpDSXRJdStN?=
 =?utf-8?B?SDNRRStRV2xLdnBPbkpvL2UyNElDUlBsTCs4djcrZ3pRU0dGNlVCNlUrOFdG?=
 =?utf-8?B?eWRGcURCUUJyUkEvazU3NS9PZ1Y5RXlKUHEyQmluTTZteVVKNzR2blpPUWR4?=
 =?utf-8?B?VjJuV0llL1J6dEN6R2xmOElhUWZuZU9HcVRPb2FNZjY4WFJlbE9XMUtoeXli?=
 =?utf-8?B?dUpvc3dveEQyalFDRHhYRTRKNVdqU0Z4MVRmT3VJdmJEeTFVTnVNL2VGSERh?=
 =?utf-8?B?SkN2b3BDMmowclYyaHVMc0FyMHR1ZVNqekhLL0NDSW9YS09SR3YydjZFVjI1?=
 =?utf-8?B?MFlXclIwb0RuZlZkajVBMVhWZXRZQWNlamp1SXUxUUV2dGxYcUFFWlJhbmE4?=
 =?utf-8?B?am4xR01LRnVQQ2RyZmIrZDBDdm9VNjlTVG9aRFVaM3ljRUwrNmNTY2lGNmMr?=
 =?utf-8?Q?L692b+8bHO8cHzSiq1U8MbqEJ?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e91bf0-c750-4b04-bd54-08de38d05b73
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 16:14:27.4265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q51PmXF1hrUy9Ul3SKgee0cLkiGxbA6OoO/ZBqoZoZoVA00VpfqZuRfHcJPMsQDf/yW8lzVXOyIcrm0mU6jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8918
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 12/11/25 10:51, Amir Najafi Zadeh wrote:
> Michael, Kienan, Thank you both for your replies. As you mentioned the 
> cgroup namespace, it isn’t very helpful in some cases. Containers may 
> share the same cgroup namespace, and the container runtime often avoids 
> giving each container a private cgroup namespace for performance and 
> security reasons. Because of this, the cgroup namespace can’t be used as 
> a reliable or unique label for filtering trace logs.
> 
> In my case, with container-d you can inspect a container, find its PID, 
> and then check /proc/<pid>/ns/cgroup, but you’ll see that different 
> containers often have the same cgroup namespace ID (e.g., in the 
> following logs you can see the calico-node and kube-proxy containers 
> sharing a cgroup ns).

If you want to track containers, the pid namespace is the one used by 
most container runtimes but I don't know specifically for container-d.

> 
> ```
> Name: calico-node  CID: 
> b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace  PID: 
> 2243  cgroup_ns_inode: 4026531835
> Name: kube-proxy  CID: 
> 52f3c12def7a680f61a925ac92dd5ebd5eba6cad17d671efbfd1d40db7dff624  PID: 
> 1851  cgroup_ns_inode: 4026531835
>    >> MATCH FOUND: shares ns with container: 
> b5624afe31b005725f4ba53c7b6fe758f3c09fabf013085231ff8b97588f6ace 
> (calico-node)
> ```
> 
> Thanks again for your answers. I hope this feature appears in a future 
> patch.
> 
> Best,
> Amir
> 
> On Thu, Dec 11, 2025 at 9:57 AM Michael Jeanson <mjeanson@efficios.com 
> <mailto:mjeanson@efficios.com>> wrote:
> 
>     On 12/11/25 09:30, Kienan Stewart via lttng-dev wrote:
>      > Hi Amir,
>      >
>      > On 12/10/25 9:40 PM, Amir Najafi Zadeh via lttng-dev wrote:
>      >> Hello everyone,
>      >>
>      >> I hope you’re doing well. My name is Amir, and I’m a PhD student in
>      >> the Computer Science department at Stony Brook University, New York.
>      >>
>      >> I have a question about the LTTng context that I haven’t been
>     able to
>      >> find an answer for in the docs or man pages. Does LTTng support
>     adding
>      >> the cgroup ID or cgroup path as a context field? I want to
>     filter my
>      >> trace results based on cgroups.
>      >>
>      >
>      > I think you're looking for the `cgroup_ns` context which adds the
>     inum
>      > of the cgroup namespace as a context field.
> 
>     This will give you the ID of the cgroup namespace but we don't have
>     contexts for cgroups themselves. It's probably something we would like
>     to have but there is no concrete plans on implementing this at the
>     moment.
> 
>      >
>      >> If this isn’t supported, are there any plans to add it in future
>      >> versions, such as 2.14?
>      >>
>      >> For reference, I’m currently using LTTng 2.13 on Ubuntu 24.04 with
>      >> kernel 6.8.0-87-generic.
>      >>
>      >> Cheers,
>      >> Amir
>      >> --
>      >> *Amirhossein Najafizadeh*
>      >> *PhD Student, Computer Science Department, Stony Brook
>     University, N.Y.
>      >> File systems and Storage Lab (FSL)
> 

