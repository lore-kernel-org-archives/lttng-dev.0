Return-Path: <SRS0=IcvV=6V=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCAC38A24
	for <lttng-dev@archiver.kernel.org>; Thu,  7 May 2020 13:04:45 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD7820870
	for <lttng-dev@archiver.kernel.org>; Thu,  7 May 2020 13:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="oXOIAdIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD7820870
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49HtwC0Gdvz1wZh;
	Thu,  7 May 2020 09:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1588856683;
	bh=zPsknhK4tdKsdO3zqpIZAUixDAuFL4sdxJY8hTfYMZM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oXOIAdItTT9rAXmDzu66TJWMLnWKw66qj+GGhOODYY6uN5SrrSkz0hpgXG3jyaVTZ
	 D5inveUhli3jdULnGRHxQG1uF7FVUCoTdXwHIbVWEkiMS/anomAbo5eAeqf1Z6ugaA
	 MVkfdO2XyZf0khsDR15A84aY+VEoCBS/J/08gMe65tDm95SgsHTq0CGdl1k2ztAy2D
	 cnfauxiqSc8BwKpzvNtJ/Gc00lKPP5ZkBcPOHwGgq4/aaKlB5/C95Q8zxr6/odhmk6
	 WQKRPZy7I4NoObPECIGcl7UP5YrxGhXDXHrV525xCiO24GnrFwDS1TmA7zBYEJOZ8Q
	 XtLBmCq3PA+VQ==
Received: from aliyun-sdnproxy-1.icoremail.net (aliyun-cloud.icoremail.net
 [47.90.88.95])
 by lists.lttng.org (Postfix) with SMTP id 49Hj6w6B1Bz1wbC
 for <lttng-dev@lists.lttng.org>; Thu,  7 May 2020 01:43:20 -0400 (EDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Thu, 7 May 2020 13:23:10
 +0800 (GMT+08:00)
X-Originating-IP: [223.104.10.226]
Date: Thu, 7 May 2020 13:23:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: lttng-dev <lttng-dev@lists.lttng.org>, 
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: "ychen@northwestern.edu" <ychen@northwestern.edu>, 
 =?UTF-8?Q?list=E5=BE=90=E7=AB=8B=E6=81=92?= <245038403@qq.com>, 
 "Shopping Ruan" <rlq1969612634@gmail.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
MIME-Version: 1.0
Message-ID: <1bb0377a.88648.171ed966cd8.Coremail.xiongyuhua@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHf3g_m7NeoZT2AA--.17949W
X-CM-SenderInfo: qtrviiiqurjio62m3hxhgxhubq/1tbiAwMNDVNG2-WETAAAsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbdvS07vEb7Iv0x
 C_Ar1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
 bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
 CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
 z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
 xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
 07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
 AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
 6r4UMIAIbVCjxxvEw4WlV2xY6xkFs20EY4vE44CYbxCE4x80FwCS07vEc2IjII80xcxEwV
 AKI48JMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY6I8I3I0E
 5I8CrVAFwI0_JrI_JrWlV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zVAF1VAY17
 CE14v26r126r1DMIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY6xIIjxv2
 0xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIAIbV
 CI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
 cSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Thu, 07 May 2020 09:04:41 -0400
Subject: [lttng-dev] questions about mapping from file names to
 corresponding inode
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
Content-Type: multipart/mixed; boundary="===============9179873678441694531=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200507052310.H1g9cubv3ZSw_PYlgECnlmdaJ3QD5UT_-iwCxobcXvI@z>

--===============9179873678441694531==
Content-Type: multipart/alternative; 
	boundary="----=_Part_1800357_1539407283.1588828990680"

------=_Part_1800357_1539407283.1588828990680
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGnvvIwKCkkgd2FudCB0byBrbm93IHdoZXRoZXIgbHR0bmcgdHJhY2UgZGF0YSB3aWxsIHByb3Zp
ZGUgbWFwcGluZyBmcm9tIGZpbGUgbmFtZXMgdG8gY29ycmVzcG9uZGluZyBpbm9kZS4KCkkgcmVm
ZXJlZCBzb21lIGRhdGEgcGFyc2VkIGJ5IGJhYmVsdHJhY2XvvIxhbmQgZm91bmQgdGhhdCBpbnRl
cm5hbCBrZXJuZWwgdHJhY2Vwb2ludHMgbGlrZSB3cml0ZWJhY2tfZGlydHlfaW5vZGVfc3RhcnTj
gIFqYmQyX3N1Ym1pdF9pbm9kZV9kYXRhIGFuZCBsdHRuZ19zdGF0ZWR1bXBfdm1fbWFwIGNhbiBw
cm92aWRlIGlub2RlIHBhcmFtZXRlci5CdXQgSSBkb27igJl0IGtub3cgdGhlIG1lYW5pbmcgb2Yg
dGhlc2UgdHJhY2Vwb2ludHMgbWVudGlvbmVkIGFib3ZlLCBhbmQgaXQgc2VlbXMgdG8gaGF2ZSBs
aXR0bGUgdG8gZG8gd2l0aCB0aGUgbWFwcGluZyB3ZSBuZWVkLkkgd2FudCB0byBrbm93IHdoaWNo
IHRyYWNlcG9pbnQgd2lsbCByZWNvcmQgdGhlIG1hcHBpbmcuCgpJbiBhZGRpdGlvbiwgSSBmb3Vu
ZCB0aGUgZ2V0X2lub2RlX2Zyb21fZmQoKSBmdW5jdGlvbiBhdCBsdHRuZy11cHJvYmVzLmMuSXQg
c2VlbXMgdG8gcHJvdmlkZSBzb21lIGhpbnRzLCBjYW4gdGhpcyBmdW5jdGlvbiBwcm92aWRlIHRo
ZSBtYXBwaW5nIGluZm9ybWF0aW9uIHdlIHdhbnQ/SWYgc28sIGhvdyBzaG91bGQgSSB1c2UgaXQg
dG8gZ2V0IHRoZSBkYXRhLgoKCgpMb29raW5nIGZvcndhcmQgdG8geW91ciByZXBseS4KCgoKCnRo
YW5rcywKCnl1aHVhCgoKLS0tLS0tLS0tLS0tLS0tLS0tCll1aHVhIFhpb25nCkxhYiBmb3IgSW50
ZXJuZXQgYW5kIFNlY3VyaXR5IFRlY2hub2xvZ3kKU2Nob29sIG9mIENvbXB1dGVyIFNjaWVuY2Ug
YW5kIFRlY2hub2xvZ3kKWmhlamlhbmcgVW5pdmVyc2l0eQpIYW5nemhvdSwgMzEwMDA3LCBQLlIu
IENoaW5hCg==
------=_Part_1800357_1539407283.1588828990680
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

SGnvvIw8YnI+Cjxicj4KSSB3YW50IHRvIGtub3cgd2hldGhlciBsdHRuZyB0cmFjZSBkYXRhIHdp
bGwgcHJvdmlkZSBtYXBwaW5nIGZyb20gZmlsZSBuYW1lcyB0byBjb3JyZXNwb25kaW5nIGlub2Rl
Ljxicj4KPGJyPgpJIHJlZmVyZWQgc29tZSBkYXRhIHBhcnNlZCBieSBiYWJlbHRyYWNl77yMYW5k
IGZvdW5kIHRoYXQgaW50ZXJuYWwga2VybmVsIHRyYWNlcG9pbnRzIGxpa2Ugd3JpdGViYWNrX2Rp
cnR5X2lub2RlX3N0YXJ044CBamJkMl9zdWJtaXRfaW5vZGVfZGF0YSBhbmQgbHR0bmdfc3RhdGVk
dW1wX3ZtX21hcCBjYW4gcHJvdmlkZSBpbm9kZSBwYXJhbWV0ZXIuQnV0IEkgZG9u4oCZdCBrbm93
IHRoZSBtZWFuaW5nIG9mIHRoZXNlIHRyYWNlcG9pbnRzIG1lbnRpb25lZCBhYm92ZSwgYW5kIGl0
IHNlZW1zIHRvIGhhdmUgbGl0dGxlIHRvIGRvIHdpdGggdGhlIG1hcHBpbmcgd2UgbmVlZC5JIHdh
bnQgdG8ga25vdyB3aGljaCB0cmFjZXBvaW50IHdpbGwgcmVjb3JkIHRoZSBtYXBwaW5nLjxicj4K
PGJyPgpJbiBhZGRpdGlvbiwgSSBmb3VuZCB0aGUgZ2V0X2lub2RlX2Zyb21fZmQoKSBmdW5jdGlv
biBhdCA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctbW9kdWxlcy9ibG9i
L21hc3Rlci9zcmMvcHJvYmVzL2x0dG5nLXVwcm9iZXMuYyIgdGFyZ2V0PSJfYmxhbmsiPmx0dG5n
LXVwcm9iZXMuYzwvYT4uSXQgc2VlbXMgdG8gcHJvdmlkZSBzb21lIGhpbnRzLCBjYW4gdGhpcyBm
dW5jdGlvbiBwcm92aWRlIHRoZSBtYXBwaW5nIGluZm9ybWF0aW9uIHdlIHdhbnQ/SWYgc28sIGhv
dyBzaG91bGQgSSB1c2UgaXQgdG8gZ2V0IHRoZSBkYXRhLjxicj4KPGJyPgo8cD4KCUxvb2tpbmcg
Zm9yd2FyZCB0byB5b3VyIHJlcGx5Lgo8L3A+CjxwPgoJPGJyPgo8L3A+CjxwPgoJdGhhbmtzLAo8
L3A+CjxwPgoJeXVodWEKPC9wPgo8cD4KCTwvcD48ZGl2IHN0eWxlPSJmb250LXNpemU6MTRweDt3
aGl0ZS1zcGFjZTpub3JtYWw7Ij4KCQk8YnI+Ci0tLS0tLS0tLS0tLS0tLS0tLTxicj4KWXVodWEg
WGlvbmc8YnI+CkxhYiBmb3IgSW50ZXJuZXQgYW5kIFNlY3VyaXR5IFRlY2hub2xvZ3k8YnI+ClNj
aG9vbCBvZiBDb21wdXRlciBTY2llbmNlIGFuZCBUZWNobm9sb2d5PGJyPgpaaGVqaWFuZyBVbml2
ZXJzaXR5PGJyPgpIYW5nemhvdSwgMzEwMDA3LCBQLlIuIENoaW5hPGJyPgoJPC9kaXY+Cg==
------=_Part_1800357_1539407283.1588828990680--


--===============9179873678441694531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============9179873678441694531==--

