Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ABBC433ED
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 16:40:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1736A610CC
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 16:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1736A610CC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmFq25kLbz1sC2;
	Thu, 20 May 2021 12:40:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621528847;
	bh=5+A0aqEncreSGFZSDkykLjzPvJS9KeLt5E88KWR/Qgg=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CdIfdtSFQxmoI08x009QpAPlOarI+OIjRccUBotoRYQuVe0pZ2hoC3HD0UoKd0AY3
	 t2wjbEu9ZjHMQKSKb3SCV9wj1i6McDQQOeV4eRJuq1PWoI/fpQRb66bIodVWnjoiKu
	 00Kj7Z1qCW8O14hChXNaXSx9eFD4YI/OzB/b+DJulkJvZL249Q6tGB/BnhT2wFjvOU
	 aZ/bfVJb64wXy/60UkX4jgSndSLHSSgtMWLXCK7bppuxrGlvjsEyWFDsQoyn62aiUS
	 vPvbJ8sagVy+w1P0voYUJvu+0Hmw92EHOe4cr1PUV7YOsF++RUR49B6ADQHVtANt5o
	 9aEoeETfQFPCQ==
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmFq05Dwjz1rdV
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 12:40:44 -0400 (EDT)
Received: by mail-ot1-x332.google.com with SMTP id
 d3-20020a9d29030000b029027e8019067fso15380101otb.13
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 09:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J9Y4TLoWmLEqNT4hm15Z8+q7EPXhQg9NKQ6HmuZOhqY=;
 b=blovLiRKm5j8pklyuk78GPTIzB/5daoXpbHt1yCDue3O4mBmyfMdNIQ5zx64XQWIju
 vRMi3oz4eYVMyJMnBYyZFN0j/ZiTVRKm4LKTVORxMIbfI7aortG8Bn7sAKDduv6dSDt9
 hIIVlV5AiWIbm07DepRljTGAQ7usSSQ2oRwWhUKrBtmrJN6WaQ0153QJSxbc+hM9+MdO
 Vdc9Oa/Zovd212p/X45U9piVGkeyu4Fr6GjdS6om99TxNBysnEWDFaLV8BRYZm2mruCR
 dX81zzO7zeVdcKIolYzoTpqY9tqS0i4Npl2ixaBKHOB9lMdMSHZQmafuLo9HapKSveV9
 dt2A==
X-Gm-Message-State: AOAM530VodL70p9aEekNnnXBsu/7Z+UNPg1WgpAeePl5kWEcQ6KF8v3f
 VpVR0HPvHppCoCkTRMpDkaWg10S1NNi1GQGewMM=
X-Google-Smtp-Source: ABdhPJyd/bkD9aXAX2Qyiwi6XIYAEMLxKz8ptL4c0azbcG2QqfyKVQlL8u1iH7vrZbk8flhXKZ9lk9ykhnApCbwNJHs=
X-Received: by 2002:a05:6830:51:: with SMTP id
 d17mr4600772otp.75.1621528843865; 
 Thu, 20 May 2021 09:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroPf5mcRMvfewsT6SQsWG0RKg6GcV8=T8BupxbooHT2=aA@mail.gmail.com>
 <d7833098-93b8-712a-460a-da8ed7a3d044@efficios.com>
In-Reply-To: <d7833098-93b8-712a-460a-da8ed7a3d044@efficios.com>
Date: Thu, 20 May 2021 18:40:32 +0200
Message-ID: <CADYdroOcJkQkEZgCJa=aTwpiHZ6qHNU81wQnu=+smLoXuSB8og@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: multipart/mixed; boundary="000000000000bbb39105c2c59a63"
Subject: Re: [lttng-dev] 2.13-rc2 fails to build with buildroot crosscompiler
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000bbb39105c2c59a63
Content-Type: text/plain; charset="UTF-8"

Am Do., 20. Mai 2021 um 16:37 Uhr schrieb Michael Jeanson
<mjeanson@efficios.com>:
>
> On 2021-05-20 9:52 a.m., Norbert Lange via lttng-dev wrote:
> > Hello,
> >
> > many tests fail to build, apparently because transitive dependencies
> > are not found.
> > I managed to patch out building the test sub-directory, at which
> > points the errors are gone,
> > I dont know how to fix it with automake, seems like
> > /tmp/ZBuild/build/lttng-libust-2.13.0-rc2/src/lib/lttng-ust/.libs
> > should be added to library search paths.
> >
> > Norbert
>
> The libtool integration with autotools should be handling these transitive
> dependencies but somehow doesn't seem to work in your environment. A
> workaround could be to add the liblttng-ust-common.la file to all the test file:///home/noppl/git/buildroot/0001-package-lttng-bump-to-2.13rc2-WIP.patch

 > binaries _LDADD where liblttng-ust.la is already present, for example:
>
> ust_fields_compatapi1_LDADD = \
>         $(top_builddir)/src/lib/lttng-ust/liblttng-ust.la \
>         $(top_builddir)/src/lib/lttng-ust-common/liblttng-ust-common.la \
>         $(DL_LIBS)
>
> Can you check if this works?

I suppose it would, but there are many many of these errors also by
linking libraries build in the test directory, would cost some time
and I am not able to triage automake/libtool issues.
Is that the solution upstream wants to use?

I attached a patch for https://buildroot.org/ to pick the current
lttng rc2. using buildroot is easy (but timeconsuming if you build the
cross-compiler aswell):

make O=/tmp/build defconfig
make O=/tmp/build menuconfig

Pick your hosts/prefered architecture in Target options
In toolchain menu pick kernel headers + c library type (glibc for me)

Enable:
Target packages -> Libraries -> Other -> lttng-libust
Target packages -> Debugging, profiling and benchmark -> lttng-tools

Then
make O=/tmp/build

Norbert

--000000000000bbb39105c2c59a63
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-package-lttng-bump-to-2.13rc2-WIP.patch"
Content-Disposition: attachment; 
	filename="0001-package-lttng-bump-to-2.13rc2-WIP.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kox48v160>
X-Attachment-Id: f_kox48v160

RnJvbSAwZTUyNjZkODI2ZTdmY2JkZDNlMDk5NzdmNThiZmZmODJlOGQ3NDc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOb3JiZXJ0IExhbmdlIDxub2xhbmdlNzlAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDIwIE1heSAyMDIxIDE4OjExOjQ0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gcGFj
a2FnZS9sdHRuZzogYnVtcCB0byAyLjEzcmMyIChXSVApCgotLS0KIHBhY2thZ2UvbHR0bmctbGli
dXN0L2x0dG5nLWxpYnVzdC5oYXNoIHwgNCArKy0tCiBwYWNrYWdlL2x0dG5nLWxpYnVzdC9sdHRu
Zy1saWJ1c3QubWsgICB8IDIgKy0KIHBhY2thZ2UvbHR0bmctdG9vbHMvbHR0bmctdG9vbHMuaGFz
aCAgIHwgNCArKy0tCiBwYWNrYWdlL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLm1rICAgICB8IDIg
Ky0KIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3BhY2thZ2UvbHR0bmctbGlidXN0L2x0dG5nLWxpYnVzdC5oYXNoIGIvcGFja2Fn
ZS9sdHRuZy1saWJ1c3QvbHR0bmctbGlidXN0Lmhhc2gKaW5kZXggNDBiZDg3MGU4Ni4uMmY1OGRi
MmJmNSAxMDA2NDQKLS0tIGEvcGFja2FnZS9sdHRuZy1saWJ1c3QvbHR0bmctbGlidXN0Lmhhc2gK
KysrIGIvcGFja2FnZS9sdHRuZy1saWJ1c3QvbHR0bmctbGlidXN0Lmhhc2gKQEAgLTEsNSArMSw1
IEBACi0jIEZyb20gaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdXN0L2x0dG5nLXVzdC0y
LjEyLjEudGFyLmJ6Mi5zaGEyNTYKLXNoYTI1NiAgNDhhMzk0OGIxNjgxOTUxMjNhNzQ5ZDIyODE4
ODA5YmQyNTEyN2JiNWYxYTY2NDU4YzNjMDEyYjIxMGQyYTA1MSAgbHR0bmctdXN0LTIuMTIuMS50
YXIuYnoyCisjIEZyb20gaHR0cHM6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdXN0L2x0dG5nLXVz
dC0yLjEzLjAtcmMyLnRhci5iejIuc2hhMjU2CitzaGEyNTYgIDUxYTJiZDJlN2NiMTViNGZiMTEw
ZmM2Y2VlYjExODI1NjY4OGM0YjFkYTFkYWRmYWJkYjFkZTlmMDc5ZmQ4Y2YgIGx0dG5nLXVzdC0y
LjEzLjAtcmMyLnRhci5iejIKIAogIyBIYXNoIGZvciBsaWNlbnNlIGZpbGUKIHNoYTI1NiAgNzQx
MjVhODRjMjE2NjMwMDc3Njk4MDE2NmUyOWRlNDBkNWY5OGQxYTc1ZTQ4N2YwYmJjMGMwM2I0Y2Qy
MzQyZSAgQ09QWUlORwpkaWZmIC0tZ2l0IGEvcGFja2FnZS9sdHRuZy1saWJ1c3QvbHR0bmctbGli
dXN0Lm1rIGIvcGFja2FnZS9sdHRuZy1saWJ1c3QvbHR0bmctbGlidXN0Lm1rCmluZGV4IDYwOGU4
NzgxYjEuLmQ5OTU3NzUwNGEgMTAwNjQ0Ci0tLSBhL3BhY2thZ2UvbHR0bmctbGlidXN0L2x0dG5n
LWxpYnVzdC5taworKysgYi9wYWNrYWdlL2x0dG5nLWxpYnVzdC9sdHRuZy1saWJ1c3QubWsKQEAg
LTUsNyArNSw3IEBACiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwogCiBMVFROR19MSUJVU1RfU0lU
RSA9IGh0dHA6Ly9sdHRuZy5vcmcvZmlsZXMvbHR0bmctdXN0Ci1MVFROR19MSUJVU1RfVkVSU0lP
TiA9IDIuMTIuMQorTFRUTkdfTElCVVNUX1ZFUlNJT04gPSAyLjEzLjAtcmMyCiBMVFROR19MSUJV
U1RfU09VUkNFID0gbHR0bmctdXN0LSQoTFRUTkdfTElCVVNUX1ZFUlNJT04pLnRhci5iejIKIExU
VE5HX0xJQlVTVF9MSUNFTlNFID0gTEdQTC0yLjEsIE1JVCAoc3lzdGVtIGhlYWRlcnMpLCBHUEwt
Mi4wIChsaWJsdHRuZy11c3QtY3RsL3VzdGN0bC5jIHVzZWQgYnkgbHR0bmctc2Vzc2lvbmQpCiBM
VFROR19MSUJVU1RfTElDRU5TRV9GSUxFUyA9IENPUFlJTkcKZGlmZiAtLWdpdCBhL3BhY2thZ2Uv
bHR0bmctdG9vbHMvbHR0bmctdG9vbHMuaGFzaCBiL3BhY2thZ2UvbHR0bmctdG9vbHMvbHR0bmct
dG9vbHMuaGFzaAppbmRleCBhOTRlY2M0YTM1Li5kMDBhYjEzM2M3IDEwMDY0NAotLS0gYS9wYWNr
YWdlL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLmhhc2gKKysrIGIvcGFja2FnZS9sdHRuZy10b29s
cy9sdHRuZy10b29scy5oYXNoCkBAIC0xLDUgKzEsNSBAQAotIyBGcm9tIGh0dHBzOi8vbHR0bmcu
b3JnL2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuMTIuMy50YXIuYnoyLnNoYTI1Ngot
c2hhMjU2ICAyODkwZGEyMzBlZGQ1MjNmY2Y0OTdlOWViMjgxMzNiNzYwNmQ2NGZhMDFiY2JmZmFk
YmZjYmE0MjEwNGRiMTUzICBsdHRuZy10b29scy0yLjEyLjMudGFyLmJ6MgorIyBGcm9tIGh0dHBz
Oi8vbHR0bmcub3JnL2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuMTMuMC1yYzIudGFy
LmJ6Mi5zaGEyNTYKK3NoYTI1NiAgNWMyNmQzOTYzNGFkYjAwZThlOTUzYzNjYWY0ZGZjYjliYTMx
YzUxMGNmMjEzOTU2MjliNzQxZmEzMzhlMWIwOCAgbHR0bmctdG9vbHMtMi4xMy4wLXJjMi50YXIu
YnoyCiAKICMgTG9jYWxseSBjb21wdXRlZAogc2hhMjU2ICAwNjhlNTVjN2RiZTU5NzQwMDE5OWFl
ZTc1YWM1ZTcxYmRiMmNhODhjNGM5YTRjZmE4ZTFmYmM2MWY5MzNlZGE1ICBMSUNFTlNFCmRpZmYg
LS1naXQgYS9wYWNrYWdlL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLm1rIGIvcGFja2FnZS9sdHRu
Zy10b29scy9sdHRuZy10b29scy5tawppbmRleCA4Nzg5ZGVkMzMzLi5mMWIxYzcyMTdiIDEwMDY0
NAotLS0gYS9wYWNrYWdlL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLm1rCisrKyBiL3BhY2thZ2Uv
bHR0bmctdG9vbHMvbHR0bmctdG9vbHMubWsKQEAgLTQsNyArNCw3IEBACiAjCiAjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwogCi1MVFROR19UT09MU19WRVJTSU9OID0gMi4xMi4zCitMVFROR19UT09M
U19WRVJTSU9OID0gMi4xMy4wLXJjMgogTFRUTkdfVE9PTFNfU0lURSA9IGh0dHBzOi8vbHR0bmcu
b3JnL2ZpbGVzL2x0dG5nLXRvb2xzCiBMVFROR19UT09MU19TT1VSQ0UgPSBsdHRuZy10b29scy0k
KExUVE5HX1RPT0xTX1ZFUlNJT04pLnRhci5iejIKIExUVE5HX1RPT0xTX0lOU1RBTExfU1RBR0lO
RyA9IFlFUwotLSAKMi4zMC4yCgo=
--000000000000bbb39105c2c59a63
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--000000000000bbb39105c2c59a63--
