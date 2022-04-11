Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D1C433F5
	for <lttng-dev@archiver.kernel.org>; Mon, 11 Apr 2022 02:45:44 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KcCs24Nczz45C;
	Sun, 10 Apr 2022 22:45:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649645143;
	bh=TNNzfoqI2JgIwmSu+hyiL8IzTtCxVEbLjqvpcI4u9pA=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=crMxbGBTszYkYbM+p/bsd6dDHGm9STpkgJY4lNoGf8p/u03hv3OY7BYqPvucQPGDx
	 kuRBek7qBwm/Pfhr7kg8yc51TlzzNBAC8UCeZr9+EalY0L5IsbAK/nwdXKSfIgAwH6
	 /EhpayhWKi/cCiM+4Z0sNhpHCnY6Iz4QVQnKNKgqaaW6Nw8z+ioI/ewHWe7W2Y7T1d
	 BYgGgUQI2k0MFAfJg/UI3iwx6V7Yq7kOsNRb82C1dDyAkV8ZJNTdwj6r5h4YMF0ifQ
	 N7wbHSOKEIV0jGHSmsg89Z7Jmn4AWvorwTsv9dAUvVfx4TqGplgz0o9qWo/wrr6JbV
	 Lmu4aRvBIZLDQ==
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net
 (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
 by lists.lttng.org (Postfix) with SMTP id 4KcCs00pyfz42w
 for <lttng-dev@lists.lttng.org>; Sun, 10 Apr 2022 22:45:39 -0400 (EDT)
Received: by ajax-webmail-mail-app3 (Coremail) ; Mon, 11 Apr 2022 10:37:11
 +0800 (GMT+08:00)
X-Originating-IP: [125.119.248.59]
Date: Mon, 11 Apr 2022 10:37:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: lttng-dev@lists.lttng.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <662b3839.f16c8.17f6a594d6d.Coremail.xiongyuhua@zju.edu.cn>
References: <662b3839.f16c8.17f6a594d6d.Coremail.xiongyuhua@zju.edu.cn>
MIME-Version: 1.0
Message-ID: <5e30d946.3b14.180167b76a4.Coremail.xiongyuhua@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgBnFvJYlFNiwu7XAQ--.32875W
X-CM-SenderInfo: qtrviiiqurjio62m3hxhgxhubq/1tbiAwIRDVNG3GSD+QAAsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Subject: [lttng-dev] Question about Open Source License
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
From: =?utf-8?b?54aK5q+T5Y2OIHZpYSBsdHRuZy1kZXY=?= <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Content-Type: multipart/mixed; boundary="===============4628498663291281810=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4628498663291281810==
Content-Type: multipart/alternative; 
	boundary="----=_Part_50006_1569064859.1649644631716"

------=_Part_50006_1569064859.1649644631716
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGnvvZ4KCkkgd3JvdGUgYSBCYWJlbHRyYWNlIFBsdWdpbiBteXNlbGYsIGl0J3Mgc2luayBjb21w
b25lbnQgY2xhc3MuCkl0IG1haW5seSBvYnRhaW5zIHRoZSByZWFkYWJsZSBsb2cgZGF0YSBvZiBs
dHRuZyBmcm9tIGJhYmVsdHJhY2UsIGFuZCBJIHdyYXAgdGhlIGRhdGEgaW50byBhIGZvcm1hdCB0
aGF0IEkgY3VzdG9taXpl77yMdGhlbiBwcmludHMgaXQgb3V0IChJIHByaW50IHRoZSBkYXRhIGlu
dG8gdGhlIHNvY2tldCwgYW5kIHNlbmQgdGhlIGRhdGEgdG8gb3RoZXIgaG9zdHMgdGhyb3VnaCB0
aGUgc29ja2V0KS4gQW5kIEkgd291bGQgbGlrZSB0byBhc2sgd2hhdCBPcGVuIFNvdXJjZSBMaWNl
bnNlIGRvZXMgdGhpcyBwbHVnaW4gbmVlZCB0byBmb2xsb3c/CgpMb29raW5nIGZvcndhcmQgdG8g
eW91ciByZXBseSEKCnRoYW5rcywKCll1aHVh
------=_Part_50006_1569064859.1649644631716
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PHA+CglIae+9ngo8L3A+CjxwPgoJSSB3cm90ZSBhIEJhYmVsdHJhY2UgUGx1Z2luIG15c2VsZiwg
aXQncyBzaW5rIGNvbXBvbmVudCBjbGFzcy48YnI+Ckl0IG1haW5seSBvYnRhaW5zIHRoZSByZWFk
YWJsZSBsb2cgZGF0YSBvZiBsdHRuZyBmcm9tIGJhYmVsdHJhY2UsIGFuZCBJIHdyYXAgdGhlIGRh
dGEgaW50byBhIGZvcm1hdCB0aGF0IEkgY3VzdG9taXpl77yMdGhlbiBwcmludHMgaXQgb3V0IChJ
IHByaW50IHRoZSBkYXRhIGludG8gdGhlIHNvY2tldCwgYW5kIHNlbmQgdGhlIGRhdGEgdG8gb3Ro
ZXIgaG9zdHMgdGhyb3VnaCB0aGUgc29ja2V0KS4gQW5kJm5ic3A7SSB3b3VsZCBsaWtlIHRvIGFz
ayB3aGF0Jm5ic3A7PHN0cm9uZz5PcGVuIFNvdXJjZSBMaWNlbnNlPC9zdHJvbmc+IGRvZXMgdGhp
cyBwbHVnaW4gbmVlZCB0byBmb2xsb3c/CjwvcD4KPHA+CglMb29raW5nIGZvcndhcmQgdG8geW91
ciByZXBseSEKPC9wPgo8cD4KCXRoYW5rcywKPC9wPgo8cD4KCVl1aHVhCjwvcD4=
------=_Part_50006_1569064859.1649644631716--


--===============4628498663291281810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4628498663291281810==--

