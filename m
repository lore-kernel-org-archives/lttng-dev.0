Return-Path: <SRS0=11In=IC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079FC433DB
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Mar 2021 15:28:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B92364F97
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Mar 2021 15:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B92364F97
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Drvs95GxxzBlv;
	Thu,  4 Mar 2021 10:28:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1614871710;
	bh=dqBS00AyQb0I/StYsPfwG9bakoR/v6e1caMKWU8+v5g=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Q0cwxc+jV48+SGk/ftARDpbTurmDJxf3YhZ8zcnN+tPJO1keFwEh1TtRimIG1HBV7
	 fl1M8aQWGZE8jW8sX55duDhHrtaPkQj8xlz2S7vPbruVEDNzW3z/EvhKTdig8oiQlZ
	 YiwP3TbgRjN5AR0lb3OK/PyRwXoYkQF4eNQlJTL9N9DnetNDGl2gNcj9Y4eBDhdiNr
	 B2YM/ep7JzLnM4dU5Tc0+8bDTV3UXDAp4VG3MFbDGCk935iOncsYE9hZm6O5FuMz2X
	 ZeMzhx9h33BMLk6I2pkLh20K7oMdSg1hILHkMf2D2EokzXcVYjqT2CGl6N9tBzO7YR
	 yuYyskbX9qFeg==
Received: from cirse-smtp-out.extra.cea.fr (cirse-smtp-out.extra.cea.fr
 [132.167.192.148])
 by lists.lttng.org (Postfix) with ESMTPS id 4Drvs82WtwzBXl
 for <lttng-dev@lists.lttng.org>; Thu,  4 Mar 2021 10:28:27 -0500 (EST)
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
 by cirse-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 124F6DpC031764
 for <lttng-dev@lists.lttng.org>; Thu, 4 Mar 2021 16:06:13 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 805E5206384
 for <lttng-dev@lists.lttng.org>; Thu,  4 Mar 2021 16:06:13 +0100 (CET)
Received: from muguet2-smtp-out.intra.cea.fr (muguet2-smtp-out.intra.cea.fr
 [132.166.192.13])
 by pisaure.intra.cea.fr (Postfix) with ESMTP id 78286206371
 for <lttng-dev@lists.lttng.org>; Thu,  4 Mar 2021 16:06:13 +0100 (CET)
Received: from I-EXCH-A0.intra.cea.fr (i-exch-a0.intra.cea.fr [132.166.88.224])
 by muguet2-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 124F6Di7025246
 for <lttng-dev@lists.lttng.org>; Thu, 4 Mar 2021 16:06:13 +0100
Received: from I-EXCH-A3.intra.cea.fr (132.166.88.227) by
 I-EXCH-A0.intra.cea.fr (132.166.88.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 4 Mar 2021 16:06:13 +0100
Received: from EXCAH-A3.intra.cea.fr (132.166.88.77) by I-EXCH-A3.intra.cea.fr
 (132.166.88.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2 via Frontend
 Transport; Thu, 4 Mar 2021 16:06:13 +0100
Received: from EXDAG0-B1.intra.cea.fr ([fe80::c18e:d8e8:9a27:5b84]) by
 EXCAH-A3.intra.cea.fr ([fe80::60de:a77e:427d:f7e6%10]) with mapi id
 14.03.0487.000; Thu, 4 Mar 2021 16:06:12 +0100
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [barectf] How to ensure that last events before a crash get
 recorded
Thread-Index: AQHXEQfH8OO3fMfK7k2UMsDwYOrjfg==
Date: Thu, 4 Mar 2021 15:06:12 +0000
Message-ID: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92@EXDAG0-B1.intra.cea.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [132.166.88.225]
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1012-26010.000
X-TM-AS-Result: No-10--2.829100-8.000000
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
MIME-Version: 1.0
X-TMASE-MatchedRID: Nndoh8f4x+zvsNWMI3fHiKo2fOuRT7aa3V4UShoTXaeXuKyHuSLTfCcN
 /7nuYGKBinRvY0E1MLdmGc9VKv7OHEB40z3xsh6M1uDM+OtX7BwacZilk37ECCGeZKmZv/3llUc
 xGfWk0G1vu+EAUOCx06KZIk/mE2mLXOFTT+immjbfSQNpZkETVOMBxl40mBj3StFk/81wIJIoIh
 l+v+yCGcJToVJxC6y00AAj4Lcjr8WZEKhZJ6HsIWK3N9p/OFh65H0EtfKK8cVOYqdbUeMAD0CR2
 FZol5Yt4vM1YF6AJbZWVhu8IR7GcCrJhLSjJRVm3B0wkc/Tu/2lIFL+ylIMrkfskvHug9G0r2sS
 wOtaV7TpFO6FRB6NmLdHm6Rwk+fdcbg2hk2Cp7rOS3jryostVcSQHbVu2g8/7boyyFiO9ECdhxQ
 B19Z/s91qnlsc2vie9kI5cJWgCzNMpJIFK6Rp3dbtJ0JSVwQGagz0XhbT247RHT/Dxikn+d/1FN
 uycnO/Vlxr1FJij9s=
X-TMASE-Result: 10--2.829100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1012-26010.000
X-TM-SNTS-SMTP: A53CA5350294C454F25822AAC3EBD38497CB37D0A828E0C9EFA95D8DCA16EB042000:8
Subject: [lttng-dev] [barectf] How to ensure that last events before a crash
 get recorded
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
From: RADERMACHER Ansgar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Content-Type: multipart/mixed; boundary="===============3012026724180627582=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3012026724180627582==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92EXDAG0B1intrace_"

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92EXDAG0B1intrace_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

when doing tracing with barectf, the trace elements are written into a buff=
er first and only written when the buffer is full - or if the function bare=
ctf_platform_fs_fini gets called.
In case of a crash, it's therefore possible to loose some events. What is t=
he best option to prevent this issue? I've used signal handlers that call t=
he function barectf_platform_fs_fini. This seems to work well with Linux, b=
ut is not portable. When using the provided sample platform, there is also =
the option to reduce the buffer size, but this is not ideal, as trace event=
s that are too big for the buffer are not written.

Best regards

Ansgar



--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92EXDAG0B1intrace_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<div>Hi,</div>
<div><br>
</div>
<div>when doing tracing with barectf, the trace elements are written into a=
 buffer first and only written when the buffer is full - or if the function=
 barectf_platform_fs_fini gets called.</div>
<div>In case of a crash, it's therefore possible to loose some events. What=
 is the best option to prevent this issue? I've used signal handlers that c=
all the function barectf_platform_fs_fini. This seems to work well with Lin=
ux, but is not portable. When using
 the provided sample platform, there is also the option to reduce the buffe=
r size, but this is not ideal, as trace events that are too big for the buf=
fer are not written.</div>
<div><br>
</div>
<div>Best regards</div>
<div><br>
</div>
<div>Ansgar<br>
</div>
<div><br>
</div>
<div><br>
</div>
</div>
</body>
</html>

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4B2B92EXDAG0B1intrace_--

--===============3012026724180627582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3012026724180627582==--
