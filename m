Return-Path: <SRS0=3dpV=FU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AE5C4361B
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Dec 2020 13:20:12 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04CB233A1
	for <lttng-dev@archiver.kernel.org>; Wed, 16 Dec 2020 13:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04CB233A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Cwwj53vXkzFBW;
	Wed, 16 Dec 2020 08:20:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608124810;
	bh=L8zJ9gJHP6lB2llHivrscNCTKfRm7pVz9ranaHNT1Cc=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=CoTxFtWf1k+/9KBam4W+HMErnBYrNYrz0Mdc6E6NX2gMxs8x1LYxc6OduyqIhCxFM
	 EkMNguZpNJjrcb7XrFF9J1z8FBqx7YVgIP+j4WCgVjOv5ReAquZdhOuAjQm5mFZ3fj
	 3eUkqRHMkoodUbOAtE0LUzULHnW2wv2R2W2zCEdSFCXxd3QgGzhDHDW8m/zScbG7wE
	 kDVuQkq3NNCw8ehs+YrCp541tlmE1ZGK1DoWtPvvDn5JT0odWey2BjAYsrlvmKkpuG
	 3G+z2mFElUKkPfYro/bi4a1LgyZj7b0ZLgOXuPzYyGfkFfv+tlcEjAav8WoLGLOhrp
	 vy5h4Nq3Z5mxQ==
Received: from qq.com (smtpbg414.qq.com [113.96.223.80])
 by lists.lttng.org (Postfix) with ESMTPS id 4CwqSY6CwrzF6q
 for <lttng-dev@lists.lttng.org>; Wed, 16 Dec 2020 04:23:57 -0500 (EST)
X-QQ-FEAT: JDiT06roKfPGyA1r+urimRKp5sKswq1yWmlsPvcgbJy9HIUwmF0YQi2OSjZwz
 2ohvBDSULaZ65/hvA5rlP3wiGbtNiSJWw0LhkNYCwVjVVO32DgmLxetoCCujk0MrFOVaZ6A
 5CcMhmpjYmQ67jspreWbR6xRe3lHSB2q5khn6tiSD0CqNQkbSnZh9ZMV3ifArPalwlXGq8e
 Iiiztk1VTsbrhC0aItsz7b8bQ+eT1HTWcFQP4haWYHGniwBtwKWkaoK2Ob5Vol6DyhTH4S2
 AZwRP3q21LaWw1
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: MxY10AfoFGna3TxMPGu+/W6zGGPPelIQweheL9cwdXhpfLppE9yuKP2WJutB0u
 ixzFJv49dpwMSr1G7EcX7Fnpk/t4lImi8pgGgRfm2SObZ13UUL2q4W+yJfgxZxaoXDNEj1naFIoav
 wJg0QHty0YlUojqynacROqb+mF8qDoIXfQQsCxEJuiugmZ9Zq8hQFdAAOGPgKPl1A2lmMUosTk7GF
 At1sSgiiG1djlL7Ae0Wopwn4c4LOAWqxk5jtTbQ9Xyf7CzJFJJxFwCaUThA2LpRbPyedQGxf+91NA
 3zNe1XOBGVNwO66JvGCFy3GdQHfvR4obKvmmC/Y6ZJO11UzqIOKjbcHfAy1ENYYfwREsQqe7CSzjw
 sghI2JtzXnalLDOeGjOm7QnzcaCkJCqQ7KTt5KJuw5TEIrT7cJlgjZ3y0hmyZ97UzmUnycn4o8Y94
 NjdIYY2yFM6R66PZvMCEr7Ye0EYPeSGcCi4qpWca87ZIMnD+LE18zvrp4YZdtj6ujM+f2uoaBbiP5
 eQGO0tiTKEymDa70jHB5SyiJJt4gAOhuXuu8o8O5AAylCkR2f2tOm+Kl8jp/pWk8gL9pPa+b63924
 VZqLf8O6THgn+fcEzpl9/1sd+/eeUYKwcRvPZGWMUzZjtaBFjMgISXhlcbeCHuPNC0aaVWALv0DsW
 qjFj+r6d6bvjk3BthC76nrAY3Fg7pZ2P8SKIY3twZyeuuUAtqxz/IxFqnZYaeHlY9RJqsjrRV2cRF
 dV/D6vIWxrRzI8FTcHOdBFElQt3+KJ/3jMq4=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 122.224.12.137
X-QQ-STYLE: 
X-QQ-mid: webmail626t1608110395t1205768
To: "=?ISO-8859-1?B?bHR0bmctZGV2?=" <lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Date: Wed, 16 Dec 2020 17:19:55 +0800
X-Priority: 3
Message-ID: <tencent_8F00E9F4A97AC396358B4008BF78437FE105@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Wed, 16 Dec 2020 17:19:57 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
X-Mailman-Approved-At: Wed, 16 Dec 2020 08:20:07 -0500
Subject: [lttng-dev] Possibilities to customize lttng tracepoints in kernel
 space
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Serica via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: =?ISO-8859-1?B?U2VyaWNh?= <serica_law@qq.com>
Content-Type: multipart/mixed; boundary="===============1926354357501535707=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.

--===============1926354357501535707==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_5FD9D13B_112C8678_6C2149B2"
Content-Transfer-Encoding: 8Bit

This is a multi-part message in MIME format.

------=_NextPart_5FD9D13B_112C8678_6C2149B2
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNCg0KSSBzZW5kIHRoaXMgZW1haWwgdG8gY29uc3VsdCB0aGF0IHdoZXRoZXIgaXQg
aXMgcG9zc2libGUgdG8gY3VzdG9taXplIGx0dG5nIHRyYWNlcG9pbnRzIGluIGtlcm5lbCBz
cGFjZS4gSSBoYXZlIGxlYXJudCB0aGF0IGx0dG5nIGxldmVyYWdlcyBsaW51eCB0cmFjZXBv
aW50IHRvIGNvbGxlY3QgYXVkaXQgbG9ncyBsaWtlIHN5c3RlbSBjYWxscy4gQWxzbywgSSBo
YXZlIGZvdW5kIHRoYXQgdXNlciBjYW4gZGVmaW5lIHRoZWlyIGN1c3RvbWl6ZWQgdHJhY2Vw
b2ludHMgaW4gdXNlciBzcGFjZSBieSB1c2luZyBsdHRuZy11c3Qgc28gdGhhdCB0aGV5IGNh
biB0cmFjZSB0aGVpciB1c2VyIGFwcGxpY2F0aW9ucy4NCg0KDQpJcyBpdCBwb3NzaWJsZSBm
b3IgbHR0bmcgdXNlcnMgdG8gY3VzdG9taXplIHRoZSBleGlzdGluZyB0cmFjZXBvaW50cyBp
biBrZXJuZWwgc3BhY2U/IEZvciBleGFtcGxlLCBhZnRlciB0aGUgc3lzdGVtIGNhbGwgc3lz
X2Nsb25lLCBvciByZWFkLCBjYWxsZWQgYW5kIHRoZW4gY29sbGVjdGVkIGJ5IGx0dG5nLCBJ
IHdhbnQgdG8gcHJvY2VzcyBzb21lIGRhdGEgKCBlLmcuLCB0aGUgcmV0dXJuIHZhbHVlIG9m
IHRoZSBzeXNjYWxsICksIGFuZCBwbGFjZSB0aGUgcmVzdWx0IGluIGEgbmV3IGZpZWxkIGlu
IHRoZSBhdWRpdCBsb2cgKCBvciB1c2luZyBhbm90aGVyIGFwcHJvYWNoLCBieSBlbWl0dGlu
ZyBhIG5ldyB0eXBlIG9mIGV2ZW50IGluIHRoZSBhdWRpdCBsb2cgKSwgYW5kIGxhdGVyIHdo
ZW4gcGFyc2VkIGJ5IGJhYmVsdHJhY2UsIHdlIGNhbiBzZWUgdGhlIG5ld2x5LWFkZGVkIGZp
ZWxkIG9yIGV2ZW50IGluIHRoZSBwYXJzZWQgcmVzdWx0Lg0KDQoNCkxvb2tpbmcgZm9yd2Fy
ZCB0byB5b3VyIHJlcGx5Lg0KDQoNCkJlc3Qgd2lzaGVzLA0KDQoNClNlcmljYQ==

------=_NextPart_5FD9D13B_112C8678_6C2149B2
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj5IaSw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2Vu
ZCB0aGlzIGVtYWlsIHRvIGNvbnN1bHQgdGhhdCB3aGV0aGVyIGl0IGlzIHBvc3NpYmxlIHRv
IGN1c3RvbWl6ZSBsdHRuZyB0cmFjZXBvaW50cyBpbiBrZXJuZWwgc3BhY2UuIEkgaGF2ZSBs
ZWFybnQgdGhhdCBsdHRuZyBsZXZlcmFnZXMgbGludXggdHJhY2Vwb2ludCB0byBjb2xsZWN0
IGF1ZGl0IGxvZ3MgbGlrZSBzeXN0ZW0gY2FsbHMuIEFsc28sIEkgaGF2ZSBmb3VuZCB0aGF0
IHVzZXIgY2FuIGRlZmluZSB0aGVpciBjdXN0b21pemVkIHRyYWNlcG9pbnRzIGluIHVzZXIg
c3BhY2UgYnkgdXNpbmcgbHR0bmctdXN0IHNvIHRoYXQgdGhleSBjYW4gdHJhY2UgdGhlaXIg
dXNlciBhcHBsaWNhdGlvbnMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JcyBpdCBwb3Nz
aWJsZSBmb3IgbHR0bmcgdXNlcnMgdG8gY3VzdG9taXplIHRoZSBleGlzdGluZyB0cmFjZXBv
aW50cyBpbiBrZXJuZWwgc3BhY2U/IEZvciBleGFtcGxlLCBhZnRlciB0aGUgc3lzdGVtIGNh
bGwgc3lzX2Nsb25lLCBvciByZWFkLCBjYWxsZWQgYW5kIHRoZW4gY29sbGVjdGVkIGJ5IGx0
dG5nLCBJIHdhbnQgdG8gcHJvY2VzcyBzb21lIGRhdGEgKCBlLmcuLCB0aGUgcmV0dXJuIHZh
bHVlIG9mIHRoZSBzeXNjYWxsICksIGFuZCBwbGFjZSB0aGUgcmVzdWx0IGluIGEgbmV3IGZp
ZWxkIGluIHRoZSBhdWRpdCBsb2cgKCBvciB1c2luZyBhbm90aGVyIGFwcHJvYWNoLCBieSBl
bWl0dGluZyBhIG5ldyB0eXBlIG9mIGV2ZW50IGluIHRoZSBhdWRpdCBsb2cgKSwgYW5kIGxh
dGVyIHdoZW4gcGFyc2VkIGJ5IGJhYmVsdHJhY2UsIHdlIGNhbiBzZWUgdGhlIG5ld2x5LWFk
ZGVkIGZpZWxkIG9yIGV2ZW50IGluIHRoZSBwYXJzZWQgcmVzdWx0LjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+TG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkuPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5CZXN0IHdpc2hlcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNl
cmljYTwvZGl2Pg==

------=_NextPart_5FD9D13B_112C8678_6C2149B2--




--===============1926354357501535707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1926354357501535707==--



