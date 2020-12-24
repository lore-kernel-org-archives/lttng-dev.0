Return-Path: <SRS0=MAad=F4=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B32C433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 24 Dec 2020 02:55:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3909E224B1
	for <lttng-dev@archiver.kernel.org>; Thu, 24 Dec 2020 02:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3909E224B1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4D1ZSx1vsWzHYy;
	Wed, 23 Dec 2020 21:55:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608778545;
	bh=K3YmI/lQb09JGFjfjG1j2FQ2wdPvMCiASwvEVQtinSM=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=EnfIQvQQxu/5XzEGEMUqzyHNccdqTY4snJc81tSF+fmC7ZPB7n1v54ub1+KJejJfo
	 WoONwTs7YK2PFiz4WQO3mkiVk497pTtECdnfppHM2e/5fO67i0OZuEIHm/DES2RoLw
	 aD6L7Xt22oIlVPbxFDKxHSYTXiNSHgK7Z5cfCr7KsPq9rgJgTqz5wefrYOKo2Uvz8+
	 7mhFrBE25dOKi2zxmy51+Vn3yWVRT69o4D3kGmTC1KJt97PrZKBBmwsqeYpUA4j46X
	 osSvTZLMRnVbnYpq7Zu8lk3fFxvA4nQ55R3xdqz1X68pFpsIJgARyx8et1F+pXRE5A
	 TLD6cYLU82iNQ==
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by lists.lttng.org (Postfix) with ESMTPS id 4D1ZSt4nRDzHc2
 for <lttng-dev@lists.lttng.org>; Wed, 23 Dec 2020 21:55:42 -0500 (EST)
X-QQ-FEAT: S54bDEqq0JaSLOY95tACe/jycl+4/NdX6X3m+AfaZghay4d4jC/a+7q/i20gq
 UtCrPkp3yKdwq46qDAi6ME8ETYwPtwNQVbhyNIWm4jow0qlOI0PUdBgJw9bUicsD3bm78Bs
 c/oQI1FHlVCw7fiMOyAZyqAM82br04qEXJggP3T2T4yVBwDbk+jl8/VBAmfNj7tOLky7hO6
 DFCuMsTQXL3kfdQdjlYEdS12ys8tIfO9WWwkkgBIrtMjlgKjlEeFdf2u1zeU113aZyD9+WZ
 0gvdG4J9vlZjV+YgkuhoxI8eo=
X-QQ-SSF: 00000000000000F000000000000000Z
X-QQ-XMAILINFO: M9VrpnxHakLFwSmXs0lwwCjoXwI+RJqUnrYat6jTB0VeVa3/TOVgEvc+qXJcxz
 vMBEE0p/ADvvnUe/aapg4jxzx6m3cVy1bcpFsKWcQAWH+n6J+EmOLlPjG5VRajpQSx22mRq/hyyJi
 /kOFutJ/afmWfCVyjT3jKkuJTOvkl9ta4LZkeBiEDgFFZG6VquLWWX4hliCfvDfA7HCylpznqsC8q
 TFGlNKpYIGO2v9ucUmBMx72n0/74gE/tjbJtc/BkhSZ3qLz2zik0DGnWxJ7eTNx2JuNgQmhCb+bvZ
 jkRXYG7/CF73nM0aHZygoiCm9dXbVY0X77CS7ePHNLRXKmzev7wupr4d1pqpBH2TJC83leCqtZSXa
 G7TkmVm3wyQIveGnyAIOY34cm+snXGbhqusd+foW7cXX8NwrjMV6gUYCz2N6R92L/hLwsTt+4BlaR
 I6Pw4n4asYO+tQyngiimVS2Vr18kjJUmYiAzQwYDoln5ZoNpEyDEAHvxXLCERHrcqvDjlHlO47AHx
 lTq3YiqvuO3tiGxcuWzDsVjDDS5fyKP81DJdanwqYQuQ0f/BJhAsjDFKrX5/K3HqBvNKqNfmbYisE
 70PIhu8AtbzVGbufH92IWFPdicALGJ1HlpDpdpe00grzIYdeEkp4i+oFxstKps2MqhmRU4s1TvkmB
 PktOICy86O86dbLs00UJ3j7EkA+csSfmHdph3TnQ1xRT0rlup7LYN9ORY0SNi6TLUesgQrhF83YNj
 nkYddpjh50GBPag==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 115.200.158.84
X-QQ-STYLE: 
X-QQ-mid: webmail626t1608778537t3696834
To: "=?ISO-8859-1?B?bHR0bmctZGV2?=" <lttng-dev@lists.lttng.org>
Mime-Version: 1.0
Date: Thu, 24 Dec 2020 10:55:37 +0800
X-Priority: 3
Message-ID: <tencent_13C276218B5808AF7848BFEF00E8B4AB3A05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 24 Dec 2020 10:55:39 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
Subject: [lttng-dev] Enamebling namespace contexts
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
Content-Type: multipart/mixed; boundary="===============6471010855388602513=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.

--===============6471010855388602513==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_5FE40329_11E86938_2835D9DF"
Content-Transfer-Encoding: 8Bit

This is a multi-part message in MIME format.

------=_NextPart_5FE40329_11E86938_2835D9DF
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGksDQoNCg0KVGhJIGZvdW5kIHRoYXQgbHR0bmcgaXMgd29ya2luZyBvbiBjb250YWluZXIg
YXdhcmVuZXNzIGluIHRoaXMgc2xpZGVzOiBodHRwczovL2FyY2hpdmUuZm9zZGVtLm9yZy8y
MDE5L3NjaGVkdWxlL2V2ZW50L2NvbnRhaW5lcnNfbHR0bmcvYXR0YWNobWVudHMvc2xpZGVz
LzM0MTkvZXhwb3J0L2V2ZW50cy9hdHRhY2htZW50cy9jb250YWluZXJzX2x0dG5nL3NsaWRl
cy8zNDE5L2x0dG5nX2NvbnRhaW5lcnNfZm9zZGVtMTkucGRmDQoNCg0KT24gcGFnZSAjMTMs
IHRoZXJlIGlzIGEgY29tbWFuZDombmJzcDsgbHR0bmcgYWRkLWNvbnRleHQgLWsgLXQgcHJv
Y25hbWUgLXQgcGlkIC10IHZwaWQgLXQgdGlkIC10IHZ0aWQgLXQgcGlkX25zLCB3aGVyZSBw
aWRfbnMgYW5kIG90aGVyIG5hbWVzcGFjZSBpZGVudGlmaWVycyBhcmUgdmVyeSB1c2VmdWwg
Zm9yIHRyYWNpbmcgY29udGFpbmVycy4gSG93ZXZlciwgaXQgc2VlbXMgbGlrZSB0aGF0IGx0
dG5nIG9mIGN1cnJlbnQgdmVyc2lvbiBkb2Vzbid0IHN1cHBvcnQgYWRkaW5nIGNvbnRleHQg
cGlkX25zKEVycm9yOiBVbmtub3duIGNvbnRleHQgdHlwZSBwaWRfbnMpLiBEbyB5b3Uga25v
dyBob3cgdG8gZW5hYmxlIHRoZXNlIGZlYXR1cmVzPw0KDQoNClRoYW5rcyBhIGxvdC4NCkJ0
dywgaGF2ZSBhIG5pY2UgaG9saWRheSENCg0KDQpTZXJpY2E=

------=_NextPart_5FE40329_11E86938_2835D9DF
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj48ZGl2PkhpLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
VGhJIGZvdW5kIHRoYXQgbHR0bmcgaXMgd29ya2luZyBvbiBjb250YWluZXIgYXdhcmVuZXNz
IGluIHRoaXMgc2xpZGVzOiBodHRwczovL2FyY2hpdmUuZm9zZGVtLm9yZy8yMDE5L3NjaGVk
dWxlL2V2ZW50L2NvbnRhaW5lcnNfbHR0bmcvYXR0YWNobWVudHMvc2xpZGVzLzM0MTkvZXhw
b3J0L2V2ZW50cy9hdHRhY2htZW50cy9jb250YWluZXJzX2x0dG5nL3NsaWRlcy8zNDE5L2x0
dG5nX2NvbnRhaW5lcnNfZm9zZGVtMTkucGRmPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5P
biBwYWdlICMxMywgdGhlcmUgaXMgYSBjb21tYW5kOiZuYnNwOyBsdHRuZyBhZGQtY29udGV4
dCAtayAtdCBwcm9jbmFtZSAtdCBwaWQgLXQgdnBpZCAtdCB0aWQgLXQgdnRpZCAtdCBwaWRf
bnMsIHdoZXJlIHBpZF9ucyBhbmQgb3RoZXIgbmFtZXNwYWNlIGlkZW50aWZpZXJzIGFyZSB2
ZXJ5IHVzZWZ1bCBmb3IgdHJhY2luZyBjb250YWluZXJzLiBIb3dldmVyLCBpdCBzZWVtcyBs
aWtlIHRoYXQgbHR0bmcgb2YgY3VycmVudCB2ZXJzaW9uIGRvZXNuJ3Qgc3VwcG9ydCBhZGRp
bmcgY29udGV4dCBwaWRfbnMoRXJyb3I6IFVua25vd24gY29udGV4dCB0eXBlIHBpZF9ucyku
IERvIHlvdSBrbm93IGhvdyB0byBlbmFibGUgdGhlc2UgZmVhdHVyZXM/PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGFua3MgYSBsb3QuPC9kaXY+PGRpdj5CdHcsIGhhdmUgYSBuaWNl
IGhvbGlkYXkhPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5TZXJpY2E8L2Rpdj48L2Rpdj4=

------=_NextPart_5FE40329_11E86938_2835D9DF--




--===============6471010855388602513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6471010855388602513==--



