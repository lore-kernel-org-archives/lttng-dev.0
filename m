Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8ADC4332F
	for <lttng-dev@archiver.kernel.org>; Thu,  3 Nov 2022 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1667483892;
	bh=bXUY2qmFisZeYYB/1Mi67yH6pe4seeF37Cc7e7hosoY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LyuZI2LpnKqsQB+TPC0jXgE4qS4k1HpZ8Yev35bBWNzO1e5XbOvfM2p9VcuHKcvmp
	 Husxd1j2O+YeKyjLGg3zj2gTG5MKi+Cfdp697xNIn/sx3fRVT2OnoYQ9603Ap9Fz4T
	 E8kqUQ4cukJHJA89zhUnKqPqtH5b3zOON8HXEYGM8D9RChMwdU5nXzWWyT0Mo+OIHh
	 QQcTIwOZ32/R+CSz45+jPtx1cCe1s3xATXOLFEPkmhN6tszFzKrDF6vWdO4W5QzZs2
	 R1td0XDJL1otB7G9xjkfx2RmkAWdF8rpfQSVKgkn6MLVc8QM9XuKPWClI48pg6PZ8/
	 +4SwBRiRSgntA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4N351v2b4hzFFK;
	Thu,  3 Nov 2022 09:58:11 -0400 (EDT)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by lists.lttng.org (Postfix) with ESMTPS id 4N2JKm2kgkzDnQ
 for <lttng-dev@lists.lttng.org>; Wed,  2 Nov 2022 03:24:12 -0400 (EDT)
Received: by mail-ot1-x335.google.com with SMTP id
 c18-20020a056830349200b0066c47e192f0so5119607otu.12
 for <lttng-dev@lists.lttng.org>; Wed, 02 Nov 2022 00:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxX+b/6f38Owyho4AAU1EdEoPSPc4qd+sc4nn3W01oc=;
 b=5oObJ0zkrX9SI9xxWzwYb5aiGocZxyR8Yn45f4/naURZ7nKVeTx8Bevyv93ILbBnSq
 tIomVQZ85NKFu4x0pVDMSwXIoT0H9ROt1RjBix1bXU3yii6jkPy/eZoaGgEHY8IMDP+U
 5v686G6NsBnedBSioK6C1kOfAZd6UrEW1SMpitPGv5BHNZxOKIUygEOlYXf3eU6zaDEk
 x+1KYqpgXKSnSJPpUGSEXjS/Gf0n8qwkyXhJSghR4HbeylWABZ19pvERmr7CxCX5RiMh
 tQtj6to1NkkPNpxH6ueSC/bZvhSbYhax1AW1TQNxBSLopbZBMFGfRruWbZ3M3/tjhjtZ
 NE4Q==
X-Gm-Message-State: ACrzQf37gnMTdc8scajgpRq9WpMCCDlcY7PGs1G9uaIAeKrJbzJuZTBL
 fd9sslta+SiKTXKoJ1r+5z0gMrQj4YnCemdq4yy7QxtN961MBg==
X-Google-Smtp-Source: AMsMyM7FebgNwhiOvYASIdWKXEMIozT+Faqh/xH5C+9ExdxeU5n5wYsnlclDxbcYeqGT6WKEYuFHzv7+63NhJU3NU+4=
X-Received: by 2002:a05:6830:3c1:b0:637:28be:7920 with SMTP id
 p1-20020a05683003c100b0063728be7920mr11329544otc.105.1667373850810; Wed, 02
 Nov 2022 00:24:10 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 2 Nov 2022 15:24:06 +0800
Message-ID: <CADs46id2Mv80raH6xA8mSX3BRdCiNVydC-1G=3xEFD1iC6Ng9Q@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 03 Nov 2022 09:58:09 -0400
Subject: [lttng-dev] README issue of liburcu
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
From: Yongwei Wu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yongwei Wu <wuyongwei@gmail.com>
Content-Type: multipart/mixed; boundary="===============0977307195090540093=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0977307195090540093==
Content-Type: multipart/alternative; boundary="00000000000015dd9f05ec77ba3a"

--00000000000015dd9f05ec77ba3a
Content-Type: text/plain; charset="UTF-8"

I apologize if this is not the right place. I do not see an Issues page on
GitHub.

The README on GitHub now says MacOS is among "Tested on", so should we
remove Darwin from "Should also work on"?

Best regards,

Yongwei

-- 
Yongwei Wu
URL: http://wyw.dcweb.cn/

--00000000000015dd9f05ec77ba3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">I apologize if this is not the right place. I do not se=
e an Issues page on GitHub.</div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif">The README on GitHub now s=
ays MacOS is among &quot;Tested on&quot;, so should we remove Darwin from &=
quot;Should also work on&quot;?</div><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:arial,helvetica,sans-serif">Best regards,</div><di=
v class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">=
<br></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica=
,sans-serif">Yongwei<br></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Yongwei W=
u<br>URL: <a href=3D"http://wyw.dcweb.cn/" target=3D"_blank">http://wyw.dcw=
eb.cn/</a></div></div></div></div>

--00000000000015dd9f05ec77ba3a--

--===============0977307195090540093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0977307195090540093==--
