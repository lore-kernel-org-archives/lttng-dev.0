Return-Path: <SRS0=8KW7=PH=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70377C433FE
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Oct 2021 21:13:47 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C81060174
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Oct 2021 21:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C81060174
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4HYmgs4LCFz1RwP;
	Tue, 19 Oct 2021 17:13:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1634678025;
	bh=DgjH1N1geVW0PqRXRTrbisRqaLWHW6I/exxls5bvIfc=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Vy2VoGHYKjaI/NOOqLTUERDefD2dVM/rGBmocJIFMOe8TpRs8AJPV6Ol1Fkyt/qkm
	 23xOGm2EKUfUPjYvkEztb8tt7KHnJVOQFbiaunbA9BOm+2/FYco65FliPQ/bnm2GzN
	 oi0rZAe9+9KAWnaRVxEX+FspknAkpw+cvUg2DvCx2zT1GR4HvWWRjSHHpHKxC39JYB
	 Cy7R7sr+ZLLARJxdKIyxADUWm5Qksub7D0U2BmnvRGa8rJxflHFpBEQ0AjXJKUhDbU
	 qAVl9sZxxmT42ku+fF4vz7phjrzLMmkxaaksHgKn3p389NUDU1nT0C0Nf3Wg1w2sYL
	 NCq1ABWBQhn2Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4HYmgl2zbnz1SFm
 for <lttng-dev@lists.lttng.org>; Tue, 19 Oct 2021 17:13:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2BAB238E348
 for <lttng-dev@lists.lttng.org>; Tue, 19 Oct 2021 17:13:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SfGXA8WLw4_v; Tue, 19 Oct 2021 17:13:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D48E638DFEF;
 Tue, 19 Oct 2021 17:13:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D48E638DFEF
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 01ukrwal30yC; Tue, 19 Oct 2021 17:13:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id CCEEF38DFEE;
 Tue, 19 Oct 2021 17:13:32 -0400 (EDT)
Date: Tue, 19 Oct 2021 17:13:32 -0400 (EDT)
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>, 
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <636357466.21397.1634678012810.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - GC95 (Linux)/8.8.15_GA_4156)
Thread-Index: Kc5n48yoKxWau7Qt62hvyg9Mt1QgtQ==
Thread-Topic: LTTng-tools 2.13.1 - =?utf-8?Q?Nordicit=C3=A9?=
Subject: [lttng-dev] =?utf-8?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E1_-_Nor?=
 =?utf-8?q?dicit=C3=A9?=
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgYWxsLCAKCldlIGhhdmUganVzdCByZWxlYXNlZCB0aGUgZmlyc3QgYnVnLWZpeCByZWxlYXNl
IG9mIExUVG5nLXRvb2xzIDIuMTMgLSBOb3JkaWNpdMOpLiAKVGhpcyByZWxlYXNlIGFkZHJlc3Nl
cyBhIG51bWJlciBvZiBpc3N1ZXMgbGlzdGVkIGJlbG93LiAKCjIwMjEtMTAtMTggbHR0bmctdG9v
bHMgMi4xMy4xIChOYXRpb25hbCBDaG9jb2xhdGUgQ3VwY2FrZSBEYXkpIAoqIEZpeDogdXN0OiBh
cHAgc3R1Y2sgb24gcmVjdiBtZXNzYWdlIGR1cmluZyBVU1QgY29tbSB0aW1lb3V0IHNjZW5hcmlv
IAoqIEZpeDogdXN0OiBVU1QgY29tbXVuaWNhdGlvbiBjYW4gcmV0dXJuIC1FQUdBSU4gCiogRml4
OiB1c3Q6IHNlZ2ZhdWx0IG9uIGx0dG5nIHN0YXJ0IG9uIGZpbHRlciBieXRlY29kZSBjb3B5IAoq
IEZpeDogc2Vzc2lvbmQ6IHByZXZpb3VzbHkgY3JlYXRlZCBjaGFubmVsIGNhbm5vdCBiZSBlbmFi
bGVkIAoqIEJ1aWxkIGZpeDogTWlzc2luZyBtZXNzYWdlIGluIExUVE5HX0RFUFJFQ0FURUQgaW52
b2NhdGlvbiAKKiBGaXg6IG5vdGlmaWNhdGlvbi10aHJlYWQ6IGhhbmRsaW5nIGV2ZW50IGZyb20g
YSByZW1vdmVkIHRyYWNlciBldmVudCBzcmMgCiogaW5jbHVkZTogYWRkIG1pc3NpbmcgImV4dGVy
biIgCiogaW5jbHVkZTogcmVtb3ZlIHNwdXJpb3VzIHNwYWNlcyBpbiBjb25kaXRpb24vc2Vzc2lv
bi1yb3RhdGlvbi5oIAoqIHRlc3RzOiBmaXggaGVhZGVyIG9mIHJlZ3Jlc3Npb24vdXN0L2dldGNw
dS1vdmVycmlkZS9ydW4tZ2V0Y3B1LW92ZXJyaWRlIAoqIGZpeDogd3JvbmcgZGVmaW5lIHVzZWQg
Zm9yIEdDQyB2ZXJzaW9uIGNoZWNrIAoqIEZpeDogdXNlcnNwYWNlLXByb2JlOiB1bnJlcG9ydGVk
IGVycm9yIG9uIHN0cmluZyBjb3B5IGVycm9yIAoqIEZpeDogdXNlcnNwYWNlLXByb2JlOiB0cnVu
Y2F0aW5nIGJpbmFyeSBwYXRoIGZvciBTRFQgCiogRml4OiBsdHRuZzogYWRkLXRyaWdnZXI6IGRv
bid0IHByb3ZpZGUgYSBkZWZhdWx0IGV2ZW50IHJ1bGUgdHlwZSAKKiBGaXg6IHN0YXRlbWVudHMg
d2l0aCBzaWRlLWVmZmVjdHMgaW4gYXNzZXJ0IHN0YXRlbWVudHMgCiogRml4OiBsdHRuZ190cmFj
ZV9hcmNoaXZlX2xvY2F0aW9uX3NlcmlhbGl6ZSBpcyBjYWxsZWQgb24gZnJlZWQgbWVtb3J5IAoq
IEZpeDogc2Vzc2lvbmQ6IHVzdCBzZXNzaW9uIGlzIGluYWN0aXZlIGR1cmluZyB1c3RfYXBwX2ds
b2JhbF91cGRhdGUgCiogRml4OiBjb21tb246IGVycm9yIHF1ZXJ5IGZvciB0cmlnZ2VyIGFjdGlv
biBwcm90b2NvbCBlcnJvciAKKiBGaXg6IGNvbW1vbjogdW4taGlkZSB0d28gcmF0ZSBwb2xpY3kg
ZnVuY3Rpb25zIAoqIEZpeDogaW5jbHVkZTogcmVtb3ZlIHVubmVlZGVkIGRlY2xhcmF0aW9uIG9m
IGx0dG5nX3Nlc3Npb25fZGVzY3JpcHRvcl9nZXRfc2Vzc2lvbl9uYW1lIAoqIEZpeDogVGVzdHM6
IHJhY2UgY29uZGl0aW9uIGluIHRlc3RfbnNfY29udGV4dHNfY2hhbmdlIAoqIEZpeDogVGVzdHM6
IHJhY2UgY29uZGl0aW9uIGluIHRlc3RfZXZlbnRfdHJhY2tlciAKKiBGaXg6IG1hbjogbHR0bmct
cm90YXRlOiB0cmFjZSBmaWxlIGNvdW50L3NpemUgbGltaXRhdGlvbiBkb2VzIG5vdCBhcHBseSAK
KiBGaXg6IHJ1bmFzOiBsZXNzLXRoYW4temVybyBjb21wYXJpc29uIG9mIGFuIHVuc2lnbmVkIHZh
bHVlIAoqIEZpeDogcnVuYXM6IHN1cHBsZW1lbnRhcnkgZ3JvdXBzIGFyZSBpZ25vcmVkIG9uIGx0
dG5nIHNhdmUgCiogRG9jczogbHR0bmctZXZlbnQtcnVsZSg3KTogLS1leGNsdWRlIGRvZXMgbm90
IGV4aXN0LCB1c2UgLS1leGNsdWRlLW5hbWUgCiogc2Vzc2lvbmQ6IGxvZ2dpbmcgdHlwbzoge3Ry
aWdlciwgdHJpZ2dnZXJ9IC0+IHRyaWdnZXIgCiogRml4OiBsdHRuZzogZnJlZSBzZXNzaW9ucyBp
biBjbWRfZGVzdHJveSAKKiBGaXg6IGx0dG5nOiBmcmVlIGRvbWFpbnMgYW5kIGNoYW5uZWxzIGlu
IGdldF9zZXNzaW9uX3N0YXRzX3N0ciAKCkFzIGFsd2F5cywgcGxlYXNlIHJlcG9ydCBhbnkgaXNz
dWUgeW91IG1heSBlbmNvdW50ZXIgdG8gYnVncy5sdHRuZy5vcmcgCm9yIG9uIHRoaXMgbWFpbGlu
ZyBsaXN0LiAKClByb2plY3Qgd2Vic2l0ZTogaHR0cHM6Ly9sdHRuZy5vcmcgCgpEb3dubG9hZCBs
aW5rOiAKaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdG9vbHMvbHR0bmctdG9vbHMtMi4x
My4xLnRhci5iejIgCgpHUEcgc2lnbmF0dXJlOiAKaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0
bmctdG9vbHMvbHR0bmctdG9vbHMtMi4xMy4xLnRhci5iejIuYXNjCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0
bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
