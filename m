Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51EAC61CE8
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Jun 2025 12:50:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bGBbg1FwTz28rk
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1749473425;
	b=WSLAeqbnSpAeHOSmE1MSdn9H6AWA1oOxmDCv+JZRSkZnSlMcCoJa3DtkKyYcKJzVZMEt
	 /EratWTWnutZDJDb3ImietSqqP+Z694YxOvPH2RpH09FB+Yxf7cl8onDVjH0EbdrkW/IL
	 uvSlHaoRcJx29hdGkUkWBPu5N1oIPxjHVNzgW/G2vLGhpALWVG/gBFQVDkS4RwElUuWD0
	 XaO2km66ACLb8CfJ3fxEhqRMwhcnd38zVKaWF3/bsLQ8kEd0WYvqBB0I3xrNG0R247l/A
	 8KcwkHMWhK+Wi6Oordl8eCYpMMgjYB4m6Hwbx1HB9uXbvNMnu97/K3hcLTcMpykE2xQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1749473425;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=3GO+0mKyisUOtLWLlp6Q20UdXk/OSKYfz0TbvIUXIJo=;
	b=FVFZnjl/nCP8Dz1dmK3Xz5Z9W7fJYe8aBwFzcYDqDqjw8t8GbBmwDS+XOVeBfRlOpYRa
	 EjuDb2Feg3JInbVp1g6l6tpQhs5MbNPfDHZuy7xIni2hboWvATtpTJDUpM9DXaGZngDTJ
	 biTYS43Xem23ee7nfzR7pZndqBOeBw7DVhbHMh8jJSneapMnt+X/2Y7kU9Byl6Dbsk/oX
	 RPxMdxAEKaggiv09PnS0lOMuVZ490zYMMwl2kpA8+hrLjoGPIPdexZkmAjAhJYh/2rXmx
	 7oK43IfbZAC/rbhEdMAbsn3OpKJE1E/g2FXNGBvlOZw7MJ/mIQj1U1u0EltoBjx1/jQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bGBbg1FwTz28rk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1749473425;
	bh=3GO+0mKyisUOtLWLlp6Q20UdXk/OSKYfz0TbvIUXIJo=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ypc0MJxUWPVMlFEtQTuUGmu6Kk/VHI4zuh6xA8aALFT9VzbNxjIRwYG2PY2AnY41f
	 qC7UzbvEhwMToz9Km6+Jf2o8uGgNeXUzncqfXMKcpNqJ/avrxH+SqN2KyKABlCkf6S
	 XHixGQ+GEAKmr3pv2k9e8x6W2kJzFj0lDoNhsSo0T2InN8ipTvLsNqDAVxcJa7YGiM
	 Gl0TVWPs1eUFAM259dq6ZopdfsfFb05clQ3ZAvIeWSdFtmCvPZS7Z6JG8m7BWO8NSF
	 rFvGWBFqUEX1EHfqm6jaeikX9SgQ2EzfdDB+jyB/iasecSlceQFekxozH65sGSncy1
	 7zvXw5Fkisj9w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bGBbg1FwTz28rk;
	Mon,  9 Jun 2025 08:50:23 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bFxGy5Vxtz23tX
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bFxGy5Vxtz23tX
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by lists.lttng.org (Postfix) with ESMTPS id 4bFxGy5Vxtz23tX
 for <lttng-dev@lists.lttng.org>; Sun,  8 Jun 2025 22:50:02 -0400 (EDT)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-addfe17ec0bso903905966b.1
 for <lttng-dev@lists.lttng.org>; Sun, 08 Jun 2025 19:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749437400; x=1750042200;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qa0TmGbwIiL342S8sp2t5oUZLPPxi0DxaE5tEFKbnKI=;
 b=pOsvySFmjHj2DZ9W6VICJp8onh++XcKT8y8z3lsPl7WQFkdZLeLUEkLiwv/zG2EOjl
 //CSXxzmOD0ifH2hE297wqDwel/uNt9Jygkk6eyNOqyG1A0ZGpnOqhaMmyXA/rP7yrIu
 lattu5ZS7ZHuy+hFSrNSR7DcWlCyvtG3yGCPCTOADRE6vKogaLXvt5JsF0vtZUXCZNoR
 KokSnsRqm1vEQcK5rP+s6mIOjB84bTRhzyIWOy80vH78lcvJ9ZQMsMyHMd0Ndi8KGjXo
 jsTFAgsTmB7pGFxxxSQg+n3p8J0lifQweoJs1yLLodIeuK6tRmG6eZK+YnPgFU9orIj6
 WOTg==
X-Gm-Message-State: AOJu0Yw3OK0YKA0OYVJ3YJzST+aIjV9WKt0TtyqT1q1c7drv36UFKJlM
 02MNzAMlhUcb/x6LB0tvqdJPq1qpsuyMUU4rishqkCPoNFt3bL71MKA1RJ+Lxb1r74yqs9HCRa1
 IG+5hi7y4RAr2nOEUY/L7BLvjb7IUjn3gKP085/I=
X-Gm-Gg: ASbGncsXY5dgT/NEZZwDFcz3tDz9xM+kDJVQuldZflD93gNO/RQE5sMHsonNO1JwABc
 URL6kJInM76RGmw6/St1EqFG7+DXJiu3tz88drbHDXi5r2RvXx5/k1TfFT+MXmpOydtDU+7znx1
 KuTyZs+bkImmowRA+WxWe0dw9ONzKv4KAMiSVDzEo2bh89
X-Google-Smtp-Source: AGHT+IH318xtUYtrqKzBymVrEcBgP+qdwDo4WmhPk3XCY2aMzx0EZfR+DzCxqKqfAGm86OVd81VZjMInqDs6e1kla7c=
X-Received: by 2002:a17:907:608e:b0:acb:37ae:619c with SMTP id
 a640c23a62f3a-ade1a9daf91mr1035259466b.15.1749437399838; Sun, 08 Jun 2025
 19:49:59 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 9 Jun 2025 10:49:23 +0800
X-Gm-Features: AX0GCFs72yqlYgPzyDPXJ5AXpHLl2i4MwaOhBHhkHeoDSN1GkQdo0aAMqPwLSPs
Message-ID: <CALMA0xZF8=aZfdqjwhXhgWqUtnUs9onDSqz0oKxfqCWFOnOigA@mail.gmail.com>
Subject: [PATCH urcu] src/urcu-bp.c: assert => urcu_posix_assert
To: lttng-dev@lists.lttng.org
Content-Type: multipart/mixed; boundary="000000000000c6a08906371aa2f4"
X-Mailman-Approved-At: Mon, 09 Jun 2025 08:50:21 -0400
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
From: Zhixu Liu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Zhixu Liu <zhixu.liu@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000c6a08906371aa2f4
Content-Type: text/plain; charset="UTF-8"

otherwise build failed if has -DNDEBUG

thanks
-- 
Z. Liu

--000000000000c6a08906371aa2f4
Content-Type: application/octet-stream; 
	name="0001-src-urcu-bp.c-assert-urcu_posix_assert.patch"
Content-Disposition: attachment; 
	filename="0001-src-urcu-bp.c-assert-urcu_posix_assert.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbohtsj80>
X-Attachment-Id: f_mbohtsj80

RnJvbSBiYmZmODhmODA5MTc1MmVlMTlkY2E2NzJiZWMxOTdlNDljYzJlZjVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiWi4gTGl1IiA8emhpeHUubGl1QGdtYWlsLmNvbT4KRGF0ZTog
TW9uLCA5IEp1biAyMDI1IDEwOjM5OjU0ICswODAwClN1YmplY3Q6IFtQQVRDSF0gc3JjL3VyY3Ut
YnAuYzogYXNzZXJ0ID0+IHVyY3VfcG9zaXhfYXNzZXJ0CgpvdGhlcndpc2UgYnVpbGQgZmFpbGVk
IGlmIGhhcyAtRE5ERUJVRwoKU2lnbmVkLW9mZi1ieTogWi4gTGl1IDx6aGl4dS5saXVAZ21haWwu
Y29tPgoKZGlmZiAtLWdpdCBhL3NyYy91cmN1LWJwLmMgYi9zcmMvdXJjdS1icC5jCmluZGV4IDhl
OWFmZDguLmUyM2NhOTUgMTAwNjQ0Ci0tLSBhL3NyYy91cmN1LWJwLmMKKysrIGIvc3JjL3VyY3Ut
YnAuYwpAQCAtNDA5LDcgKzQwOSw3IEBAIHZvaWQgZXhwYW5kX2FyZW5hKHN0cnVjdCByZWdpc3Ry
eV9hcmVuYSAqYXJlbmEpCiAJCW5ld19jaHVua19zaXplX2J5dGVzLCAwKTsKIAlpZiAobmV3X2No
dW5rICE9IE1BUF9GQUlMRUQpIHsKIAkJLyogU2hvdWxkIG5vdCBoYXZlIG1vdmVkLiAqLwotCQlh
c3NlcnQobmV3X2NodW5rID09IGxhc3RfY2h1bmspOworCQl1cmN1X3Bvc2l4X2Fzc2VydChuZXdf
Y2h1bmsgPT0gbGFzdF9jaHVuayk7CiAJCW1lbXNldCgoY2hhciAqKSBsYXN0X2NodW5rICsgb2xk
X2NodW5rX3NpemVfYnl0ZXMsIDAsCiAJCQluZXdfY2h1bmtfc2l6ZV9ieXRlcyAtIG9sZF9jaHVu
a19zaXplX2J5dGVzKTsKIAkJbGFzdF9jaHVuay0+Y2FwYWNpdHkgPSBuZXdfY2FwYWNpdHk7Ci0t
IAoyLjQ1LjIKCg==
--000000000000c6a08906371aa2f4--
