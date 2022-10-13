Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C74FC433FE
	for <lttng-dev@archiver.kernel.org>; Thu, 13 Oct 2022 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665657777;
	bh=ZKb018j5reKjU4aOeqTVGYyPE1YVZhHuiiWfCGaeDwY=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=icJJdGwYeF1pxyJWO7Z+gnFKmCw64cXLKcWAnlQb4dlnmaQXggMQtkQKDDQJqO8N0
	 g5I3KqQKd0DXy8CxPcRQ6yT8dHu9ZXGmPZtALEuMYv/BTVxd7UlioBIL25Z6RcI6oY
	 +Qsl3hhT4KdltaGMdI+nJk5AuKIlm0aTGvMfTBEUk/fKlMNPUOxUJAC4ybVDfJsbcN
	 Z5KIZ57Id/rCkDobJka0l2XTtY0MO1n/9NPosq4nUHxx2DqpzRfn5ODXZjco/XFKqx
	 0v6ExIPQXYzaVtfXdnBow/Re1PepeQLM4Jqqm6OKC9B0wkyv1g414H5yHYZlI+ii+l
	 XTojLvcrCgrCg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Mp5hK0n1Mz748;
	Thu, 13 Oct 2022 06:42:57 -0400 (EDT)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by lists.lttng.org (Postfix) with ESMTPS id 4Mnqjm2Pf6z4Ys
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2022 20:13:16 -0400 (EDT)
Received: by mail-pl1-x636.google.com with SMTP id 10so420093pli.0
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2022 17:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2igqpfazEoFMFh65Z3F1X5z/ki/vr4svWZcEIbA+TQk=;
 b=kJ7V6eevAUUrdvcisNsBc7gVYDB6SaSIKVrwUWTDEuBdEvnA7/PdkGvCq17hIh0JY5
 i/4hATcKTaC5NzqwXC2sjCv+gcUl0DwP7yrDyEnxjtypue0Fs6QYO8aSEdpEsK9xF1OS
 baBexkcD7OimCXd6YaQ0K6dyuCGhSQ/A942a5hSIyrigwvUAC+cxT+djDgLr9pcPDniy
 6ekljqb1NSAVqstjmr1EFV1eTJtoTt49CpR2UL29txqV0MnupUX155Lo/LC0DmwCcZnf
 3nYzi61JCrhC1khj/kfLbVM2AcN/G8+l8ud5aDCylILLiUjFIlr3rdlP2ebbsRLs0Gcs
 Kd0A==
X-Gm-Message-State: ACrzQf2sOKy8Llsgn9gHo7pS4o2xgXQYM1OHX8rcmpwHrn/B11SOeXc/
 ve5uX5mxPp3Bu1H4GSrOP3LMeTCRtTstHZ11XUk=
X-Google-Smtp-Source: AMsMyM7T5Cz12bSgeCVcys1o28AjshIHyjQx7gQh4is1tI7wm0lXKjZMMoAH6LP4uMmkvZPxQWURRoJ0pgG2IE7QVwI=
X-Received: by 2002:a17:902:b092:b0:17b:833e:74f7 with SMTP id
 p18-20020a170902b09200b0017b833e74f7mr32276806plr.149.1665619994949; Wed, 12
 Oct 2022 17:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221007003918.344922-1-alistair.francis@opensource.wdc.com>
 <20221007003918.344922-2-alistair.francis@opensource.wdc.com>
 <Y0a+yByE6vUtFc2P@efficios.com>
In-Reply-To: <Y0a+yByE6vUtFc2P@efficios.com>
Date: Thu, 13 Oct 2022 10:12:48 +1000
Message-ID: <CAKmqyKM=EN0NnKPcysDdUk+yPR6D=69G8pLTkrUYKHGj_47cpw@mail.gmail.com>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: Alistair Francis <alistair.francis@opensource.wdc.com>,
 lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 13 Oct 2022 06:42:55 -0400
Subject: Re: [lttng-dev] [PATCH lttng-tools 2/2] Tests: select_poll_epoll:
 Add support for _time64
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
From: Alistair Francis via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gV2VkLCBPY3QgMTIsIDIwMjIgYXQgMTE6MTkgUE0gSsOpcsOpbWllIEdhbGFybmVhdQo8amVy
ZW1pZS5nYWxhcm5lYXVAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgT2N0IDA3LCAy
MDIyIGF0IDEwOjM5OjE4QU0gKzEwMDAsIEFsaXN0YWlyIEZyYW5jaXMgdmlhIGx0dG5nLWRldiB3
cm90ZToKPgo+IEhpIEFsaXN0YWlyLAo+Cj4gVGhlIGZpcnN0IHBhdGNoIGlzIGdvb2QsIEknbGwg
bWVyZ2UgaXQgaW4gbWFzdGVyLgo+IFNvbWUgY29tbWVudHMgb24gdGhpcyBwYXRjaCBmb2xsb3cu
CgpUaGFua3MhCgo+Cj4gPiBGcm9tOiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lz
QHdkYy5jb20+Cj4gPgo+ID4gQWRkIHN1cHBvcnQgZm9yIHRoZSAgNjQtYml0IHRpbWVfdCBzeXNj
YWxscyBTWVNfcHBvbGxfdGltZTY0Cj4gPiBhbmQgU1lTX3BzZWxlY3Q2X3RpbWU2NC4KPiA+Cj4g
PiBUaGVzZSBhcmUgdGhlIHN5c2NhbGxzIHRoYXQgZXhpc3QgMzItYml0IHBsYXRmb3JtcyBzaW5j
ZSB0aGUgNS4xIGtlcm5lbC4KPiA+IDMyLWJpdCBwbGF0Zm9ybXMgd2l0aCBhIDY0LWJpdCB0aW1l
X3Qgb25seSBoYXZlIHRoZXNlIGFuZCBkb24ndCBoYXZlIHRoZQo+ID4gb3JpZ2luYWwgc3lzY2Fs
bHMgKHN1Y2ggYXMgMzItYml0IFJJU0MtVikuCj4gPgo+ID4gRml4ZXM6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9sdHRuZy9sdHRuZy10b29scy9wdWxsLzE2Mgo+ID4gU2lnbmVkLW9mZi1ieTogQWxpc3Rh
aXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgo+ID4gLS0tCj4gPiAgdGVzdHMv
cmVncmVzc2lvbi9rZXJuZWwvc2VsZWN0X3BvbGxfZXBvbGwuY3BwIHwgNTMgKysrKysrKysrKysr
KysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jlc3Npb24va2VybmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcCBi
L3Rlc3RzL3JlZ3Jlc3Npb24va2VybmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcAo+ID4gaW5kZXgg
YzBiNjg4MjE3Li40YTZkMzk0ZjQgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0cy9yZWdyZXNzaW9uL2tl
cm5lbC9zZWxlY3RfcG9sbF9lcG9sbC5jcHAKPiA+ICsrKyBiL3Rlc3RzL3JlZ3Jlc3Npb24va2Vy
bmVsL3NlbGVjdF9wb2xsX2Vwb2xsLmNwcAo+ID4gQEAgLTUsNiArNSw3IEBACj4gPiAgICoKPiA+
ICAgKi8KPiA+Cj4gPiArI2luY2x1ZGUgPGVycm5vLmg+Cj4gPiAgI2luY2x1ZGUgPGZjbnRsLmg+
Cj4gPiAgI2luY2x1ZGUgPGxpbWl0cy5oPgo+ID4gICNpbmNsdWRlIDxwb2xsLmg+Cj4gPiBAQCAt
NDU2LDggKzQ1NywyMiBAQCB2b2lkIHBwb2xsX2Zkc19idWZmZXJfb3ZlcmZsb3coCj4gPiAgICAg
ICB1ZmRzWzBdLmZkID0gd2FpdF9mZDsKPiA+ICAgICAgIHVmZHNbMF0uZXZlbnRzID0gUE9MTElO
fFBPTExQUkk7Cj4gPgo+ID4gKyNpZmRlZiBTWVNfcHBvbGxfdGltZTY0Cj4gPiArICAgICAvKgo+
ID4gKyAgICAgICogQXMgdGhlcmUgaXMgbm8gdGltZW91dCB2YWx1ZSwgd2UgZG9uJ3QgY29udmVy
dCB0by9mcm9tCj4gPiArICAgICAgKiA2NC8zMi1iaXQgdGltZV90Lgo+ID4gKyAgICAgICovCj4g
PiArICAgICByZXQgPSBzeXNjYWxsKFNZU19wcG9sbF90aW1lNjQsIHVmZHMsIDEwMCwgTlVMTCwg
TlVMTCk7Cj4gPiArICAgICBpZiAocmV0ID09IDAgfHwgZXJybm8gIT0gRU5PU1lTKSB7Cj4gPiAr
ICAgICAgICAgICAgIGdvdG8gcHBvbGxfZmRzX2J1ZmZlcl9vdmVyZmxvd19kb25lOwo+ID4gKyAg
ICAgfQo+ID4gKyNlbmRpZgo+ID4gKwo+Cj4gVGhpcyByZXN1bHRzIGluIHRoZSBmb2xsb3dpbmcg
d2FybmluZyB3aGVuIGJ1aWxkaW5nIGZvciBhbiBhcmNoaXRlY3R1cmUKPiB0aGF0IGRvZXNuJ3Qg
aGF2ZSBTWVNfcHBvbGxfdGltZTY0IGRlZmluZWQ6Cj4KPiBsYWJlbCDigJhwcG9sbF9mZHNfYnVm
ZmVyX292ZXJmbG93X2RvbmXigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWxhYmVs
XQo+IHBwb2xsX2Zkc19idWZmZXJfb3ZlcmZsb3dfZG9uZToKPiBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KPiBzZWxlY3RfcG9sbF9lcG9sbC5jcHA6IEluIGZ1bmN0aW9uIOKAmHZvaWQg
cHBvbGxfZmRzX3Vsb25nX21heChGSUxFKinigJk6CgpBcmdoLCBJJ2xsIGZpeCB0aGlzCgo+Cj4K
PiBBbHNvLCBpdCBpcyBteSB1bmRlcnN0YW5kaW5nIHRoYXQgYm90aCBzeXNjYWxscyBjYW4gYmUg
YXZhaWxhYmxlIG9uIHNvbWUKPiBwbGF0Zm9ybXMuIEluIHRoYXQgY2FzZSwgaXQgd291bGQgbWFr
ZSBzZW5zZSB0byBhZGQgdGhlbSBhcyBzZXBhcmF0ZQo+IHRlc3RzIGFuZCBza2lwIHRlc3RzIHRo
YXQgdGFyZ2V0IG5vbi1leGlzdGFudCBzeXNjYWxscy4KClNvIGFsbCAzMi1iaXQgcGxhdGZvcm1z
IHNpbmNlIHRoZSA1LjEgKG9yIDUuND8pIGtlcm5lbCBoYXZlIGJvdGggc3lzY2FsbHMuCgpGcm9t
IG15IHVuZGVyc3RhbmRpbmcgdGhlIG9yaWdpbmFsIHN5c2NhbGxzIHdpbGwgYmUgcmVtb3ZlZCBv
biAzMi1iaXQKcGxhdGZvcm1zIGF0IHNvbWUgcG9pbnQgKGJlZm9yZSAyMDM4KSBhbmQgdGhlcmUg
d2lsbCBvbmx5IGJlICpfdGltZTY0CnZhcmlhbnRzLgoKSWYgeW91IHdhbnQgSSBjYW4gY29weSB0
aGUgdGVzdHMgdG8gdGVzdCBib3RoIHN5c2NhbGwgdHlwZXMsIGJ1dCBJCmRvbid0IHRoaW5rIHRo
YXQncyBuZWNlc3NhcnkuCgpBbGlzdGFpcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
