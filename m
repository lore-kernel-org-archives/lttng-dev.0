Return-Path: <SRS0=ImaU=FB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93247C2D0E4
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 06:40:33 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0808F221FD
	for <lttng-dev@archiver.kernel.org>; Fri, 27 Nov 2020 06:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="h6/a/NEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0808F221FD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Cj4kj3b3lz1PGj;
	Fri, 27 Nov 2020 01:40:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1606459230;
	bh=UoCfGtDJ2FDt8tg/XgEcyWLooW9uuu9MNvOQcltQ3fk=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=h6/a/NEAXjeN1UgZY2d9LpwjmmloGsAt3ZHT70L0qP41Tqp3LuoWkaHQdW+8s8irV
	 xfUESlbT39WCHSS2Nj2ncX76iaqUlQGyS5cUdCaWHI9lp82pWLNzXAMO5hw8vDoiCl
	 DvZ74sOWMYG0xLaVfUKXxrcN66KMamh9PoeEua8+/9IRl2eFdCiJ05EFXWikJmwNl6
	 89z0sF58RT6piW+KqetaKr/Wnl0IzIsyLD7AZ3v4CDhawmHs66ONJVQVZ63b2Ozm0A
	 Xk2TFDKp3ZCBldHjvWAM4CI1XVeOQRrMDT9iawhaNG1VLpnP1GDtPgFWtBHgvLV/wz
	 HBW0C1iOrd9BA==
Received: from zg8tmtm4lje5ny4xodqumjaa.icoremail.net
 (zg8tmtm4lje5ny4xodqumjaa.icoremail.net [138.197.184.20])
 by lists.lttng.org (Postfix) with SMTP id 4Cj4kf6rb5z1PW6
 for <lttng-dev@lists.lttng.org>; Fri, 27 Nov 2020 01:40:26 -0500 (EST)
Received: by ajax-webmail-mail-app2 (Coremail) ; Fri, 27 Nov 2020 14:39:28
 +0800 (GMT+08:00)
X-Originating-IP: [125.119.251.159]
Date: Fri, 27 Nov 2020 14:39:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: lttng-dev@lists.lttng.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
MIME-Version: 1.0
Message-ID: <40a80cf.2b99.176086d97b1.Coremail.xiongyuhua@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgD3dKAhn8BfxlvTAA--.49444W
X-CM-SenderInfo: qtrviiiqurjio62m3hxhgxhubq/1tbiAwMRDVNG3AreyQAAsI
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbQIS07vEb7Iv0x
 C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
 bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
 CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
 z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wCS07vE84ACjcxK6I8E87Iv67AKxVW0oV
 Cq3wCS07vE84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DMIAIbVAS0I0E0xvYzxvE52x0
 82IY62kv0487MIAIbVAqx4xG64xvF2IEw4CE5I8CrVC2j2WlV2xY6cIj6xIIjxv20xvE14
 v26r1j6r18MIAIbVAv7VC2z280aVAFwI0_Jr0_Gr1lV2xY6cvjeVCFs4IE7xkEbVWUJVW8
 JwCS07vE7I0Y64k_MIAIbVCY02Avz4vE14v_GF1lV2xY6xkI7II2jI8vz4vEwIxGrwCS07
 vE4x8a6x804xWlV2xY6xC20s026xCaFVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v2
 6r106r1rMIAIbVC20s026x8GjcxK67AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUJV
 WUXwCS07vEIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIAIbVCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z2
 80aVAFwI0_Jr0_Gr1lV2xY6IIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kfnx
 nUU==
Subject: [lttng-dev] Some confusion about cpu usage of the lttng-consumerd
 process
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
From: =?utf-8?b?54aK5q+T5Y2OIHZpYSBsdHRuZy1kZXY=?= <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?B?54aK5q+T5Y2O?= <xiongyuhua@zju.edu.cn>
Content-Type: multipart/mixed; boundary="===============6373151153613271891=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6373151153613271891==
Content-Type: multipart/alternative; 
	boundary="----=_Part_35771_407322384.1606459168689"

------=_Part_35771_407322384.1606459168689
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGnvvIxkZWFyLgoKCgoKSSBoYXZlIGJlZW4gdXNpbmcgbHR0bmcgdG8gbW9uaXRvciBteSBzZXJ2
ZXIgdGhlc2UgZGF5c++8jGJ1dCBJIGZvdW5kIHNvbWV0aGluZyBpbnRlcmVzdGluZy4KClRoZSBj
cHUgdXNhZ2Ugb2YgbHR0bmcgdmFyaWVzIHdpdGggdGhlIG51bWJlciBvZiBjcHUgY29yZXMgb2Yg
dGhlIHNlcnZlci4KCgoKCk9uIHRoZSBzZXJ2ZXIsIEkgY3JlYXRlIGEgdHJhY2luZyBzZXNzaW9u
IGluIGxpdmUgbW9kZSwgdXNpbmcgImx0dG5nIGNyZWF0ZSBteS1zZXNzaW9uIC0tbGl2ZSIuIAoK
VGhlbixJIFN0YXJ0IHRoZSBiYWJlbHRyYWNlMiBhbmQgY29uZmlndXJlIGl0IHRvIGNvbm5lY3Qg
dG8gdGhlIHJlbGF5IGRhZW1vbix1c2luZyAiLS1pbnB1dC1mb3JtYXQ9bHR0bmctbGl2ZSIgbW9k
ZS4KCkkgdXNlZCA1IGNsb3VkIHNlcnZlcnPvvIwxY29yZTRHIDJjb3JlOEcgNGNvcmUxNkcgOGNv
cmUxNkcgOGNvcmUxNkcuCgpBbmQsdGhlIHNhbWUgdGVzdCBzY3JpcHQgd2FzIGV4ZWN1dGVkIGFi
b3ZlIHRvIHByb3ZpZGUgdGhlIHNhbWUgd29ya2xvYWQuCgoKCgpBcyB3ZSBhbGwga25vdyxsdHRu
ZyBoYXMgNSBwcm9jZXNzZXMsCgoxLmx0dG5nLXJ1bmFzICAgIC0tZGFlbW9uaXplCgoyLmx0dG5n
LXJ1bmFzICAgICAgLWsgLS1jb25zdW1lcmQtY21kLXNvY2sgL3Zhci9ydW4vbHR0bmcva2NvbnN1
bWVyZC9jb21tYW5kIC0tY29uc3VtZXJkLWVyci1zb2NrIC92YXIvcnVuL2x0dG5nL2tjb25zdW1l
cmQvZXJyb3IgLS1ncm91cCB0cmFjaW5nCgozLmx0dG5nLXNlc3Npb25kIC0tZGFlbW9uaXplCgo0
Lmx0dG5nLXJlbGF5ZCAtTCB0Y3A6Ly9sb2NhbGhvc3Q6NTM0NAoKNS5sdHRuZy1jb25zdW1lcmQg
IC1rIC0tY29uc3VtZXJkLWNtZC1zb2NrIC92YXIvcnVuL2x0dG5nL2tjb25zdW1lcmQvY29tbWFu
ZCAtLWNvbnN1bWVyZC1lcnItc29jayAvdmFyL3J1bi9sdHRuZy9rY29uc3VtZXJkL2Vycm9yIC0t
Z3JvdXAgdHJhY2luZwoKCgoKVGhlIENQVSB1c2FnZSBvZiB0aGUgZmlyc3QgZm91ciBwcm9jZXNz
ZXMgaXMgYmVsb3cgMiUgb24gdGhlIDUgc2VydmVycyxidXQgdGhlIGx0dG5nLWNvbnN1bWVyZCBw
cm9jZXNzIGlzIGRpZmZlcmVudC4KCk9uIDEtY29yZeOAgTItY29yZeOAgTQtY29yZSBzZXJ2ZXJz
77yMdGhlIENQVSB1c2FnZSBvZiB0aGUgbHR0bmctY29uc3VtZXJkIHByb2Nlc3MgaXMgYmVsb3cg
MiUuCgpCdXQgb24gdHdvIDgtY29yZSBtYWNoaW5lcywgdGhlIGNwdSB1c2FnZSBvZiB0aGUgbHR0
bmctY29uc3VtZXJkIHByb2Nlc3MgcmVhY2hlZCAxMCUgb3IgbW9yZS4KCgoKCkFuZCx0aGUgY3B1
IHVzYWdlIG9mIHRoZSBiYWJlbHRyYWNlIHByb2Nlc3MgaXMgbm90IG11Y2ggZGlmZmVyZW50LGp1
c3QgdGhlIGNwdSB1c2FnZSBvZiB0aGUgbHR0bmctY29uc3VtZXJkIHByb2Nlc3MgdmFyaWVzIHdp
dGggdGhlIG51bWJlciBvZiBjcHUgY29yZXMgb2YgdGhlIHNlcnZlci4KCgoKCldoeSBpdCBpcyBs
aWtlIHRoaXPvvJ9Ib3cgc2hvdWxkIHRoaXMgcGhlbm9tZW5vbiBiZSBhbmFseXplZD8KCgoKCgpM
b29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4KCgp0aGFua3MsCnl1aHVhCgoKCgoKCg==
------=_Part_35771_407322384.1606459168689
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PHA+Cgk8c3BhbiBzdHlsZT0iZm9udC1zaXplOjE0cHg7d2hpdGUtc3BhY2U6bm9ybWFsOyI+SGnv
vIxkZWFyLjwvc3Bhbj4KPC9wPgo8cD4KCTxzcGFuIHN0eWxlPSJmb250LXNpemU6MTRweDt3aGl0
ZS1zcGFjZTpub3JtYWw7Ij48YnI+Cjwvc3Bhbj4KPC9wPgo8cD4KCUkgaGF2ZSBiZWVuIHVzaW5n
IGx0dG5nIHRvIG1vbml0b3IgbXkgc2VydmVyIHRoZXNlIGRheXPvvIxidXQgSSBmb3VuZCBzb21l
dGhpbmcgaW50ZXJlc3RpbmcuCjwvcD4KPHA+CglUaGUgY3B1IHVzYWdlIG9mIGx0dG5nIHZhcmll
cyB3aXRoIHRoZSBudW1iZXIgb2YgY3B1IGNvcmVzIG9mIHRoZSBzZXJ2ZXIuCjwvcD4KPHA+Cgk8
YnI+CjwvcD4KPHA+CglPbiB0aGUgc2VydmVyLCBJIGNyZWF0ZSBhIHRyYWNpbmcgc2Vzc2lvbiBp
biBsaXZlIG1vZGUsIHVzaW5nICJsdHRuZyBjcmVhdGUgbXktc2Vzc2lvbiAtLWxpdmUiLiZuYnNw
Owo8L3A+CjxwPgoJVGhlbixJIFN0YXJ0IHRoZSBiYWJlbHRyYWNlMiBhbmQgY29uZmlndXJlIGl0
IHRvIGNvbm5lY3QgdG8gdGhlIHJlbGF5IGRhZW1vbix1c2luZyAiLS1pbnB1dC1mb3JtYXQ9bHR0
bmctbGl2ZSIgbW9kZS4KPC9wPgo8cD4KCUkgdXNlZCA1IGNsb3VkIHNlcnZlcnPvvIwxY29yZTRH
IDJjb3JlOEcgNGNvcmUxNkcgOGNvcmUxNkcgOGNvcmUxNkcuCjwvcD4KPHA+CglBbmQsdGhlIHNh
bWUgdGVzdCBzY3JpcHQgd2FzIGV4ZWN1dGVkIGFib3ZlIHRvIHByb3ZpZGUgdGhlIHNhbWUgd29y
a2xvYWQuCjwvcD4KPHA+Cgk8YnI+CjwvcD4KPHA+CglBcyB3ZSBhbGwga25vdyxsdHRuZyBoYXMg
NSBwcm9jZXNzZXMsCjwvcD4KPHA+CgkxLmx0dG5nLXJ1bmFzJm5ic3A7ICZuYnNwOyAtLWRhZW1v
bml6ZQo8L3A+CjxwPgoJMi5sdHRuZy1ydW5hcyZuYnNwOyAmbmJzcDsgJm5ic3A7IC1rIC0tY29u
c3VtZXJkLWNtZC1zb2NrIC92YXIvcnVuL2x0dG5nL2tjb25zdW1lcmQvY29tbWFuZCAtLWNvbnN1
bWVyZC1lcnItc29jayAvdmFyL3J1bi9sdHRuZy9rY29uc3VtZXJkL2Vycm9yIC0tZ3JvdXAgdHJh
Y2luZwo8L3A+CjxwPgoJMy5sdHRuZy1zZXNzaW9uZCAtLWRhZW1vbml6ZQo8L3A+CjxwPgoJNC5s
dHRuZy1yZWxheWQgLUwgdGNwOi8vbG9jYWxob3N0OjUzNDQKPC9wPgo8cD4KCTUubHR0bmctY29u
c3VtZXJkJm5ic3A7IC1rIC0tY29uc3VtZXJkLWNtZC1zb2NrIC92YXIvcnVuL2x0dG5nL2tjb25z
dW1lcmQvY29tbWFuZCAtLWNvbnN1bWVyZC1lcnItc29jayAvdmFyL3J1bi9sdHRuZy9rY29uc3Vt
ZXJkL2Vycm9yIC0tZ3JvdXAgdHJhY2luZwo8L3A+CjxwPgoJPGJyPgo8L3A+CjxwPgoJVGhlIENQ
VSB1c2FnZSBvZiB0aGUgZmlyc3QgZm91ciBwcm9jZXNzZXMgaXMgYmVsb3cgMiUgb24gdGhlIDUg
c2VydmVycyxidXQgdGhlIGx0dG5nLWNvbnN1bWVyZCBwcm9jZXNzIGlzIGRpZmZlcmVudC4KPC9w
Pgo8cD4KCU9uIDEtY29yZeOAgTItY29yZeOAgTQtY29yZSBzZXJ2ZXJz77yMdDxzcGFuIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpub3JtYWw7Ij5oZSBDUFUgdXNhZ2Ugb2YgdGhlIDxzcGFuIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpub3JtYWw7Ij5sdHRuZy1jb25zdW1lcmQgcHJvY2Vzczwvc3Bhbj4gaXMgYmVs
b3cgMiUuPC9zcGFuPgo8L3A+CjxwPgoJPHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOm5vcm1hbDsi
PkJ1dCBvbiB0d28gOC1jb3JlIG1hY2hpbmVzLCB0aGUgY3B1IHVzYWdlIG9mIHRoZSBsdHRuZy1j
b25zdW1lcmQgcHJvY2VzcyByZWFjaGVkIDEwJSBvciBtb3JlLjwvc3Bhbj4KPC9wPgo8cD4KCTxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpub3JtYWw7Ij48YnI+Cjwvc3Bhbj4KPC9wPgo8cD4KCTxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTpub3JtYWw7Ij5BbmQsdGhlIGNwdSB1c2FnZSBvZiB0aGUg
YmFiZWx0cmFjZSBwcm9jZXNzIGlzIG5vdCBtdWNoIGRpZmZlcmVudCxqdXN0IHRoZSBjcHUgdXNh
Z2Ugb2YgdGhlIGx0dG5nLWNvbnN1bWVyZCBwcm9jZXNzIHZhcmllcyB3aXRoIHRoZSBudW1iZXIg
b2YgY3B1IGNvcmVzIG9mIHRoZSBzZXJ2ZXIuPC9zcGFuPgo8L3A+CjxwPgoJPHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOm5vcm1hbDsiPjxicj4KPC9zcGFuPgo8L3A+CjxwPgoJPHNwYW4gc3R5bGU9
IndoaXRlLXNwYWNlOm5vcm1hbDsiPldoeSBpdCBpcyBsaWtlIHRoaXPvvJ9Ib3cgc2hvdWxkIHRo
aXMgcGhlbm9tZW5vbiBiZSBhbmFseXplZD88YnI+Cjwvc3Bhbj4KPC9wPgo8cD4KCTxzcGFuIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpub3JtYWw7Ij48YnI+Cjwvc3Bhbj4KPC9wPgo8cD4KCUxvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIHJlcGx5Lgo8L3A+CjxwPgoJPGJyPgp0aGFua3MsPGJyPgp5dWh1YTxi
cj4KPC9wPgo8cD4KCTxicj4KPC9wPgo8cD4KCTxicj4KPC9wPg==
------=_Part_35771_407322384.1606459168689--


--===============6373151153613271891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6373151153613271891==--

