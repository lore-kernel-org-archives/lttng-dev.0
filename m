Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BFEC7115A
	for <lttng-dev@archiver.kernel.org>; Thu, 19 Jun 2025 17:10:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bNRvS17S1z11VV
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750353046;
	b=gQnh13l9ed09VjXrUBz7k63xI86lLJ19s2aVom8V/I8IdMFOSve2+z3TIvRyLxxd3e/v
	 zszZeFq4oNg9T+vVD/ZI9Z6hOHH5snoXOTdC06t08jcjJCEGNIRTTDrfe8BHqdtSBYhX0
	 0PpQKo+5sI+HkI+gxC1HrRByTsiIvpk00Z9aL7jYBLNRjcRlKShlb+W+0TQXqb4EbE7PC
	 cTVCPVADFIi9xcTryb7WjXHZWMsVOjdQIW9yJ/p4MahOiNYWmNsDGjSxtzhIvusu5PaFs
	 GJolQtSo/hawgxfRrdXQ2Cl7zOZ4PJk4q+Ch8dc8WBGrRE5tAgLetsNsKwVYqQ8oKmA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750353046;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=sIEeo48fAF9eP7Z0cpoZdIWD4J+gEZhhs57hevzWHMc=;
	b=hLjTR5pc26M2Da4sLpeFYv760ShmrOadz+LlLz2LkRV3Y0RV40ih4e+IIYtkdgte2i1S
	 ajCLq0fNcSl4EL6ivr/o1XFd/VUu7iU5b3HR1Zct6tUbZNYJAgLd6C1JOLCd5XS0dDMuO
	 5KZMzYQTNlCnlV/RngJPlEzdr5NvmkRkAABbeWX6rZrNizTjYne7CtYjlNtIsNRErLCs+
	 7st4t8K5Eg2AEPORCL5U2RHiq6LcFyTOydZI9gRyzfCLC9BoDq0uOj/+wFQeTeHuzAXze
	 VXpV4odobXlzrEzFLBRZKAyGJKOlmZI/JyGxMHxyAyC07p8XgzBz7uYkChFlc+FrZBg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bNRvS17S1z11VV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750353046;
	bh=sIEeo48fAF9eP7Z0cpoZdIWD4J+gEZhhs57hevzWHMc=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=k/Mh4bVv6fWoI+YGbL7sdfJePM4M/rCdcjOqUsUN9KPEf51pMirk3gnL4rdCMnnLd
	 dJdvog1rkM7eVT7dVIHMU47ZSVO7fXqsjhf8BcMiWtuadHSjq9EMxdoHBzpWxex9Tk
	 6pemRrALvrvJKO/5kSn2VGrGBxTIZW1Kmy/07KdIA5I1d9D3h1GBjHaDPG3nS5KvbN
	 jmP6+PZOWWLfL8dun8Ha5ENPPJpQ7x1vjRsd49cf2pViq5OjkDGPg97wRpC5Fy1giH
	 KaJTetBm2DBW5nme+sE7ye5x78c6FP8Uo/zkTI5p8R80N2Q5L/yl3SD3nOv26CCjgg
	 HMMa10aHF+PpA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bNRvS17S1z11VV;
	Thu, 19 Jun 2025 13:10:44 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bNNzn40rnz10WH
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bNNzn40rnz10WH
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by lists.lttng.org (Postfix) with ESMTPS id 4bNNzn40rnz10WH
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jun 2025 10:59:17 -0400 (EDT)
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3ddc5084952so2845065ab.2
 for <lttng-dev@lists.lttng.org>; Thu, 19 Jun 2025 07:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750345156; x=1750949956;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sIEeo48fAF9eP7Z0cpoZdIWD4J+gEZhhs57hevzWHMc=;
 b=lQzpEETX2lsfIednqb3Ia87zQuizCMGqe+CY2+Y0oziEPB2wwAGiAh2ogg1XAdNlFG
 8ev0whCeX7qIhCtwU+wxSSnqLbtnz/eppm/fXkF1UH1IpfPJ5MxWTAS+c0LL0tTtB6EN
 5sBqPtcyMXVqooqQsoZa/Mz/I8122Garb+uIbSbPTDO/tn87SMlKRr2Q3GqSe1Jvjc8+
 P1kKw/F+wy8qJbB368YFKoyT10af3JW511lzHlnrAFfT1lWs/ptsyoY1ujQBsNQ4r+Iq
 dCeB9JNdY0ys0m4gKWD8HBRdSHOhFy4Mi1VJLZ5GBlogr38ZlBBcGO7gSXA/WgQElaMy
 uXZA==
X-Gm-Message-State: AOJu0YwD6oDRF+hbWhEB8d+kRySqBA7fhEA+ADd1rGXrrgYQQ+670IBF
 E8x3ckm6rxNEHjIpzc7AOO4pdDBLks7D/tY2wjZ679/ymhP8zHJa/gNMsCd26fXXvK2Jaza1Kgu
 yWvMXMfHY1HVsvqXTuSomWJLljjZvFwdibphLT3Q=
X-Gm-Gg: ASbGncvgRa8teWgVZD1BSsG6PLQL5pzuDJuvYGn5E7cU2cZPj8rXvOlFK7Kxld5K0OH
 AfCbPHKs21ZC258iu2NHoFY3H7k8/t5YUdpMyxyeLjVOOipDgW/1AyzK6DpKaJJIoeHFjduMvEi
 ltF+/N3A8N5AFP3jws8FqOZodnsQV4fcQfUAUPNrTjir0DfEGhr3vMSjGXgie1xKd8xRzwYr9i
X-Google-Smtp-Source: AGHT+IHitHc5Mx0viTxpjp+tbJYk2wuhpMhCSAVBcZoeFCbw0Lm4Kgifx8aVSIQFQVQEpKJ0x1rVanrbF0n1CEh2PiI=
X-Received: by 2002:a92:ca4e:0:b0:3dc:7c44:d006 with SMTP id
 e9e14a558f8ab-3de07c55a95mr247234505ab.8.1750345156002; Thu, 19 Jun 2025
 07:59:16 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 16:58:59 +0200
X-Gm-Features: AX0GCFuRrzGFuoQuuN-yET9rnOGPEXe7T4j0kjMEaXdsPSKKyABxN-6mj0N49sM
Message-ID: <CAEobtPOhc8K3c-Qcymm1m-pRpHSZyDSarAKoGKeiKqZfUqXOCQ@mail.gmail.com>
Subject: Malformed Tracefiles
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="0000000000004209220637edfd39"
X-Mailman-Approved-At: Thu, 19 Jun 2025 13:10:41 -0400
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
From: Georg Muck via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Georg Muck <georgmuck1@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000004209220637edfd39
Content-Type: text/plain; charset="UTF-8"

Hey,

I am using the LTTng tracer (2.13.11, C-API, rotation=1s) to trace my ROS2
system (userspace only). Everything works just fine within my Docker
Container (Ubuntu 24.04), but if I start the same procedure on the host
itself (also Ubuntu 24.04), it does not create a TraceFile if to many
tracepoints occur (speaking of roundabout 1500+ per second) (sometimes it
malformed the tracefile, but I was not able to recreate that. If I remember
correctly, Babeltrace2 threw an error that said that there was no
metadata-file). I played around with some configurations (like increasing
the buffer size from ~16kB to ~512kB or a less aggressive rotation), but
the problem stayed.

Would be thankful for help. I guess I delivered to less information, please
reach out what is interesting at this point, I am not sure about that :).

Best regards,
Georg



Never burn the bridges before you
If you've burned the bridges behind
Never burn the one that you're walking upon
Or you're sure to hit the water in time. *(Savatage, Streets, 1991)*

--0000000000004209220637edfd39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey,<br><br>I am using the LTTng tracer (2.13.11, C-A=
PI, rotation=3D1s) to trace my ROS2 system (userspace only). Everything wor=
ks just fine within my Docker Container (Ubuntu 24.04), but if I start the =
same procedure on the host itself (also Ubuntu 24.04), it does not create a=
 TraceFile if to many tracepoints occur (speaking of roundabout 1500+ per s=
econd) (sometimes it malformed the tracefile, but I was not able to recreat=
e that. If I remember correctly, Babeltrace2 threw an error that said that =
there was no metadata-file). I played around with some configurations (like=
 increasing the buffer size from ~16kB to ~512kB or a less aggressive rotat=
ion), but the problem stayed.<br><br>Would be thankful=C2=A0for help. I gue=
ss I delivered to less information, please reach out what is interesting at=
 this point, I am not sure about that :).<br><br>Best regards,<br>Georg<br>=
<br><br><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signat=
ure" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><span style=3D"col=
or:rgb(80,0,80)">Never burn the bridges before you</span><br style=3D"color=
:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">If you&#39;ve burned the =
bridges behind</span><br style=3D"color:rgb(80,0,80)"><span style=3D"color:=
rgb(80,0,80)">Never burn the one that you&#39;re walking upon</span><br sty=
le=3D"color:rgb(80,0,80)"><span style=3D"color:rgb(80,0,80)">Or you&#39;re =
sure to hit the water in time. <i>(Savatage, Streets, 1991)</i></span><br><=
/div></div></div></div>

--0000000000004209220637edfd39--
