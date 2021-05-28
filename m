Return-Path: <SRS0=DF34=KX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0539C47087
	for <lttng-dev@archiver.kernel.org>; Fri, 28 May 2021 15:27:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F48C61378
	for <lttng-dev@archiver.kernel.org>; Fri, 28 May 2021 15:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F48C61378
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fs7qB3Njkz3kv;
	Fri, 28 May 2021 11:27:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622215671;
	bh=GLMYwuhaYW30ipsSyQXOj57O2gKi/bDCMAoE5FHtMKw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gtvMeQwSFzW9ACVl7spSBIiZpG5FrUCW+UAo+if0YFAYzxwUcMeM4hgwxztItSiP6
	 iu0Xh82QR/XQkvTL08aR6gf1S/gCFUzT1InfAo0kDVx9QGlzPr+4dkg4AKXsOqY0oU
	 bs9n6iOWSQ1J30ZPw8Rd1ORSoo+r+1tWkCmERiXQnVncI2BgeMUGkXMnbKQ10fqp/O
	 lUvOhWk2hfNaCYRXT8/BURVsZvdlA5/FJ7Sk8k9Fgi9CG34vtPH99IOxWkjApS1azQ
	 B0WPiJmqx7tGxDOc92IO6cT6X71ZZ4E0ZqIB8Rp2tvmieOQPkEglFae5ImEFwuEMxV
	 iLoU2sCfJd91w==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fs7q803gfz3kr
 for <lttng-dev@lists.lttng.org>; Fri, 28 May 2021 11:27:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AFA72286834;
 Fri, 28 May 2021 11:27:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8xmsk5Bem7EK; Fri, 28 May 2021 11:27:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 66E36286833;
 Fri, 28 May 2021 11:27:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 66E36286833
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MOlGnY1Z_Gh8; Fri, 28 May 2021 11:27:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 586C52866AF;
 Fri, 28 May 2021 11:27:41 -0400 (EDT)
Date: Fri, 28 May 2021 11:27:41 -0400 (EDT)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1859733749.1984.1622215661297.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210527211122.2462-1-mathieu.desnoyers@efficios.com>
References: <20210527211122.2462-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4026)
Thread-Topic: list_lttng_agent_events: unbalanced RCU read-side lock on error
Thread-Index: NfsV5wDY/MOwM1zebyboYpOdS0neUg==
Subject: Re: [lttng-dev] [PATCH lttng-tools stable-2.12] Fix:
 list_lttng_agent_events: unbalanced RCU read-side lock on error
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

TWVyZ2VkIGluIHN0YWJsZS0yLjEyIGFuZCBzdGFibGUtMi4xMS4KClRoYW5rcyEKSsOpcsOpbWll
CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIk1hdGhpZXUgRGVzbm95ZXJz
IiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IFRvOiBqZ2FsYXJAZWZmaWNpb3Mu
Y29tCj4gQ2M6ICJsdHRuZy1kZXYiIDxsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnPiwgIk1hdGhp
ZXUgRGVzbm95ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPgo+IFNlbnQ6IFRo
dXJzZGF5LCBNYXkgMjcsIDIwMjEgNToxMToyMiBQTQo+IFN1YmplY3Q6IFtQQVRDSCBsdHRuZy10
b29scyBzdGFibGUtMi4xMl0gRml4OiBsaXN0X2x0dG5nX2FnZW50X2V2ZW50czogdW5iYWxhbmNl
ZCBSQ1UgcmVhZC1zaWRlIGxvY2sgb24gZXJyb3IKCj4gVGhlIGVycm9yIGxhYmVsIGp1bXBzIHRv
IHRoZSBlbmQgbGFiZWwgd2hpY2ggcmVsZWFzZXMgdGhlIFJDVSByZWFkLXNpZGUKPiBsb2NrLiBU
aGVyZSBhcmUgbWFueSBlcnJvciBwYXRocyBpbiB0aGlzIGZ1bmN0aW9uIHdoaWNoIGdvdG8gZXJy
b3IKPiB3aXRob3V0IGhvbGRpbmcgdGhlIFJDVSByZWFkLXNpZGUgbG9jaywgdGh1cyBjYXVzaW5n
IHVuYmFsYW5jZWQgUkNVCj4gcmVhZC1zaWRlIGxvY2suCj4gCj4gVGhlcmUgaXMgbm8gcG9pbnQg
aW4ga2VlcGluZyBzbyBzaG9ydCBSQ1UgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zLAo+IHNv
IGNvdmVyIHRoZSBlbnRpcmUgZnVuY3Rpb24gd2l0aCBhIHNpbmdsZSByZWFkLXNpZGUgY3JpdGlj
YWwgc2VjdGlvbi4KPiAKPiBbIEFwcGxpZXMgdG8gc3RhYmxlLTIuMTIgYW5kIHBvc3NpYmx5IHBy
aW9yIHZlcnNpb25zLiBEb2VzIF9ub3RfIGFwcGx5Cj4gIHRvIHN0YWJsZS0yLjEzKy4gXQo+IAo+
IFNpZ25lZC1vZmYtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZp
Y2lvcy5jb20+Cj4gQ2hhbmdlLUlkOiBJNWIyMGMyMjlhNWRmMjJkMjJlY2ZkYzY0ZGJiYjg3ZWUx
MTg2NDlkMgo+IC0tLQo+IHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMgfCA0IC0tLS0KPiAx
IGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9s
dHRuZy1zZXNzaW9uZC9jbWQuYyBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvY21kLmMKPiBpbmRl
eCBiNjA4ZGYxZTEuLmViNWRhMWI3NiAxMDA2NDQKPiAtLS0gYS9zcmMvYmluL2x0dG5nLXNlc3Np
b25kL2NtZC5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC9jbWQuYwo+IEBAIC01MTAs
NyArNTEwLDYgQEAgc3RhdGljIGludCBsaXN0X2x0dG5nX2FnZW50X2V2ZW50cyhzdHJ1Y3QgYWdl
bnQgKmFndCwKPiAKPiAJcmN1X3JlYWRfbG9jaygpOwo+IAluYl9ldmVudCA9IGx0dG5nX2h0X2dl
dF9jb3VudChhZ3QtPmV2ZW50cyk7Cj4gLQlyY3VfcmVhZF91bmxvY2soKTsKPiAJaWYgKG5iX2V2
ZW50ID09IDApIHsKPiAJCXJldCA9IG5iX2V2ZW50Owo+IAkJKnRvdGFsX3NpemUgPSAwOwo+IEBA
IC01MjQsNyArNTIzLDYgQEAgc3RhdGljIGludCBsaXN0X2x0dG5nX2FnZW50X2V2ZW50cyhzdHJ1
Y3QgYWdlbnQgKmFndCwKPiAJICogVGhpcyBpcyBvbmx5IHZhbGlkIGJlY2F1c2UgdGhlIGNvbW1h
bmRzIHdoaWNoIGFkZCBldmVudHMgYXJlCj4gCSAqIHByb2Nlc3NlZCBpbiB0aGUgc2FtZSB0aHJl
YWQgYXMgdGhlIGxpc3RpbmcuCj4gCSAqLwo+IC0JcmN1X3JlYWRfbG9jaygpOwo+IAljZHNfbGZo
dF9mb3JfZWFjaF9lbnRyeShhZ3QtPmV2ZW50cy0+aHQsICZpdGVyLml0ZXIsIGV2ZW50LCBub2Rl
Lm5vZGUpIHsKPiAJCXJldCA9IGluY3JlbWVudF9leHRlbmRlZF9sZW4oZXZlbnQtPmZpbHRlcl9l
eHByZXNzaW9uLCBOVUxMLCBOVUxMLAo+IAkJCQkmZXh0ZW5kZWRfbGVuKTsKPiBAQCAtNTM0LDcg
KzUzMiw2IEBAIHN0YXRpYyBpbnQgbGlzdF9sdHRuZ19hZ2VudF9ldmVudHMoc3RydWN0IGFnZW50
ICphZ3QsCj4gCQkJZ290byBlcnJvcjsKPiAJCX0KPiAJfQo+IC0JcmN1X3JlYWRfdW5sb2NrKCk7
Cj4gCj4gCSp0b3RhbF9zaXplID0gbmJfZXZlbnQgKiBzaXplb2YoKnRtcF9ldmVudHMpICsgZXh0
ZW5kZWRfbGVuOwo+IAl0bXBfZXZlbnRzID0gem1hbGxvYygqdG90YWxfc2l6ZSk7Cj4gQEAgLTU0
Nyw3ICs1NDQsNiBAQCBzdGF0aWMgaW50IGxpc3RfbHR0bmdfYWdlbnRfZXZlbnRzKHN0cnVjdCBh
Z2VudCAqYWd0LAo+IAlleHRlbmRlZF9hdCA9ICgodWludDhfdCAqKSB0bXBfZXZlbnRzKSArCj4g
CQluYl9ldmVudCAqIHNpemVvZihzdHJ1Y3QgbHR0bmdfZXZlbnQpOwo+IAo+IC0JcmN1X3JlYWRf
bG9jaygpOwo+IAljZHNfbGZodF9mb3JfZWFjaF9lbnRyeShhZ3QtPmV2ZW50cy0+aHQsICZpdGVy
Lml0ZXIsIGV2ZW50LCBub2RlLm5vZGUpIHsKPiAJCXN0cm5jcHkodG1wX2V2ZW50c1tpXS5uYW1l
LCBldmVudC0+bmFtZSwgc2l6ZW9mKHRtcF9ldmVudHNbaV0ubmFtZSkpOwo+IAkJdG1wX2V2ZW50
c1tpXS5uYW1lW3NpemVvZih0bXBfZXZlbnRzW2ldLm5hbWUpIC0gMV0gPSAnXDAnOwo+IC0tCj4g
Mi4xNy4xCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
