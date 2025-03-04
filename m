Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E32AC282D6
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741104106;
	bh=Y3Cirgad+qpNxmBaPapBaGNXCRfasqxHdRtKPinIM/8=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=OI9YlAm+B1/F3ph6LSM/YbVabA5yaVzDU6j1CxAyv+AgZItUwaxnxIrd0xjUEPBpW
	 SVL6R4FtuILvo+DbJ5FEdTyCktB2OfkT//D4UX0tDJoUVzCOb5RLIWuMcTRiNaYwPy
	 Tqz/BIu8OfYLYgoJaorqDFUJOOkX29cdD9j1qXOEWjnC0H/e5rn6jrQ8DkFw6USZZs
	 qW+eQP0FriT8483Rs2912IB/SoJEeNMkFCapoZdQpySNcq/FUbBfgmkDyAjP64DOe4
	 owhB8q8KWD7sKzS66KhBRe2qDW9z+thbViRr8+VhdcicbrIEC96XjWVu+NKn7ZLmIM
	 F20m4M/yeL+7g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Z6gRF54f0z187V;
	Tue,  4 Mar 2025 11:01:45 -0500 (EST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by lists.lttng.org (Postfix) with ESMTP id 4Z6TJ5053yz14nQ
 for <lttng-dev@lists.lttng.org>; Tue,  4 Mar 2025 03:24:52 -0500 (EST)
Received: from fangkaihit$163.com ( [39.170.47.136] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Tue, 4 Mar 2025 16:09:36 +0800 (CST)
X-Originating-IP: [39.170.47.136]
Date: Tue, 4 Mar 2025 16:09:36 +0800 (CST)
To: lttng-dev@lists.lttng.org
Subject: need help for avoiding system calls while using URCU (Userspace RCU)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-CM-CTRLMSGS: f0gtA3RyYWNlS2V5PXByZV8zMmJhZjdmMjMzMDU3Yzk3NmRjN2YwZDZkYzY2N
 TRmZg==
X-NTES-SC: AL_Qu2fA/ycuk8s4COYYekfmU4XhOw2X8S0svsu2YRUNpt4jCnr5ywyZkFMPn710d+OABKXrheYUhxT9fxWZ7B/ZYMV7o3Qa9+vkYWytdSGKJuxXQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_119227_294342907.1741075776308"
MIME-Version: 1.0
Message-ID: <5bfbaea6.79f9.19560340335.Coremail.fangkaihit@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: iCgvCgDXv6BAtcZnfs92AA--.63081W
X-CM-SenderInfo: 5idqwypdlkx3i6rwjhhfrp/1tbiXBj4IGe18UvpgAADse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Tue, 04 Mar 2025 11:01:44 -0500
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
From: =?utf-8?b?5pa56ZS0IHZpYSBsdHRuZy1kZXY=?= <lttng-dev@lists.lttng.org>
Reply-To: =?GBK?B?t73vxw==?= <fangkaihit@163.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

------=_Part_119227_294342907.1741075776308
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

RGVhciAKCkkgaGF2ZSByZWZlcmVuY2VkIHlvdXIgcHJvamVjdCwgVVJDVSAoVXNlcnNwYWNlIFJD
VSksIG9uIEdpdEh1Yiwgd2hpY2ggaXMgYmFzZWQgb24gdGhlIFFTQlIgbW9kZWwuIEhvd2V2ZXIs
IEkgbm90aWNlZCB0aGF0IHdoZW4gdXNpbmcgaXQgaW4gdXNlciBtb2RlLCBpdCBtYWtlcyBzeXN0
ZW0gY2FsbHMgdG8gZW50ZXIgdGhlIGtlcm5lbC4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIGd1
aWRhbmNlIG9uIGhvdyB0byBhZGRyZXNzIHRoaXMgaXNzdWU/IEkgYWltIHRvIGFjaGlldmUgYSBw
dXJlIHVzZXItbW9kZSBpbXBsZW1lbnRhdGlvbi4gU3BlY2lmaWNhbGx5LCBJIHdvdWxkIGFwcHJl
Y2lhdGUgYW55IGluc2lnaHRzIG9yIHN1Z2dlc3Rpb25zIG9uIGF2b2lkaW5nIHN5c3RlbSBjYWxs
cyB3aGlsZSBzdGlsbCBtYWludGFpbmluZyB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgUVNCUiBt
b2RlbCBpbiB1c2VyIHNwYWNlLiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHRpbWUgYW5k
IGFzc2lzdGFuY2UuCgoK
------=_Part_119227_294342907.1741075776308
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBkYXRhLW50ZXM9Im50ZXNfbWFpbF9ib2R5X3Jvb3QiIHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTpBcmlhbCI+PHAgc3R5
bGU9Im1hcmdpbjowOyI+RGVhciZuYnNwOzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij48c3BhbiBz
dHlsZT0iY29sb3I6IHJnYig0MiwgNDcsIDY5KTsgZm9udC1mYW1pbHk6ICZxdW90O1BpbmdGYW5n
IFNDJnF1b3Q7LCAmcXVvdDtTZWdvZSBVSSZxdW90OywgQXJpYWwsICZxdW90O01pY3Jvc29mdCBZ
YUhlaSZxdW90OywgzqLI7dHFutosIMvOzOUsICZxdW90O01hbGd1biBHb3RoaWMmcXVvdDssIHNh
bnMtc2VyaWY7IGZvbnQtc2l6ZTogMTNweDsgd2hpdGUtc3BhY2UtY29sbGFwc2U6IHByZXNlcnZl
OyI+PGI+ICAgICBJIGhhdmUgcmVmZXJlbmNlZCB5b3VyIHByb2plY3QsIFVSQ1UgKFVzZXJzcGFj
ZSBSQ1UpLCBvbiBHaXRIdWIsIHdoaWNoIGlzIGJhc2VkIG9uIHRoZSBRU0JSIG1vZGVsLiBIb3dl
dmVyLCBJIG5vdGljZWQgdGhhdCB3aGVuIHVzaW5nIGl0IGluIHVzZXIgbW9kZSwgaXQgbWFrZXMg
c3lzdGVtIGNhbGxzIHRvIGVudGVyIHRoZSBrZXJuZWwuIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlk
ZSBndWlkYW5jZSBvbiBob3cgdG8gYWRkcmVzcyB0aGlzIGlzc3VlPyBJIGFpbSB0byBhY2hpZXZl
IGEgcHVyZSB1c2VyLW1vZGUgaW1wbGVtZW50YXRpb24uCiAgICBTcGVjaWZpY2FsbHksIEkgd291
bGQgYXBwcmVjaWF0ZSBhbnkgaW5zaWdodHMgb3Igc3VnZ2VzdGlvbnMgb24gYXZvaWRpbmcgc3lz
dGVtIGNhbGxzIHdoaWxlIHN0aWxsIG1haW50YWluaW5nIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRo
ZSBRU0JSIG1vZGVsIGluIHVzZXIgc3BhY2UuCgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3Vy
IHRpbWUgYW5kIGFzc2lzdGFuY2UuPC9iPjwvc3Bhbj48L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+
PGJyPjwvcD48L2Rpdj48aW1nIHN0eWxlPSJ3aWR0aDoxcHg7aGVpZ2h0OjFweCIgc3JjPSJodHRw
czovL2NvdW50Lm1haWwuMTYzLmNvbS9iZWFjb24vd2VibWFpbC5naWY/dHlwZT13ZWJtYWlsX21h
aWx0cmFjZSZhbXA7Z3VpZD1wcmVfMzJiYWY3ZjIzMzA1N2M5NzZkYzdmMGQ2ZGM2NjU0ZmYiPg==

------=_Part_119227_294342907.1741075776308--

