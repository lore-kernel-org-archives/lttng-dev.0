Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D19C7EE23
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684422126;
	bh=lVa9cIE+SYjPpNGgWZexn1oQvKmapNm81pqrjv+XULw=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=hQhtUEnKM5neCJhIxdtvYYUQ+61SdPsWariLupJY7Bg4yfnQyKPHLDgn7SvHQiNeV
	 m3S2uVFPXOJV/Lc2hOFJP4dVjxlRtNhQb7cStQ5qLjTLLzvwobN2xpSSlm2U71WUVm
	 h7oU88BqM45c7g6WQ/WR7mV10JcIIIlrl0uRub6KO3LL28XVB1L3iigyjNU0S290Ct
	 z9VXLWLbZeUtgFppfBIZyY4jYnJ7WsQLCQ/ucW2eegUX+PnPA/DDj5kTdY5/Cfqbwm
	 Ob1wAhoqP8ft3hqoe3WXa8bD+8Ek3XOOTMu8DFx3RThpPSksP5uchIJ8ItjAbMV8pc
	 DT1Ys5qsjWfyw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMY9932WLz1G1G;
	Thu, 18 May 2023 11:02:05 -0400 (EDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMY981fFQz1G1D
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 11:02:04 -0400 (EDT)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-510ea8d0bb5so900691a12.0
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 08:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684422063; x=1687014063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BdXi/LCmGflXCkxJh1ZU9lHPzvjICgpJuErnUE1D6w=;
 b=PAu+SE1b3A0LctjPL4+n4pIRtDl5c9k9LOHdlyvp7O1l8n5EO0eXe0uRWqG/A9sz1I
 fj803xnc0P3BKXjAb0Rm+E6Xvkbez8FK9jPD4ohEltPvuTeBNy3uDfctXRMFaoq7h1MJ
 zIpOJZwwNwlEzkVkSeZVDl2bu0hYUImrLpb/UawEHxwyvYHCin4O0Ly9D1RoJVa5/kr+
 PmgFaot3AMqdcejbKoYuH5OZ0qOnwWykbGivScmKdC1xhKFcNUVWTmGvwlMVlQ0NGWEI
 g2YKPiVsJRAtVGMSblNHmOliGZnbMy04isPIje4JiA9VPpZgsuh9+matfbXx6IcOmWmn
 u4zw==
X-Gm-Message-State: AC+VfDweJS7LspBlnK1K4TzeyMzcja9TlROTBUSxjSWq4HgS3tXl46Nt
 Q77YNhlGktH0B0D6e6hlfB7fU2TjIBZ1bVIgapAESOqK
X-Google-Smtp-Source: ACHHUZ7bey7YSw49XjVB6lpkVDSCS2ycJr5uaDajW7aLrLEKyg7C/SpUoz2y97wBSia1u+4dKr+dOFq9k3+wLKQGSnY=
X-Received: by 2002:a05:6402:14cc:b0:510:daee:46d8 with SMTP id
 f12-20020a05640214cc00b00510daee46d8mr4568051edx.5.1684422062780; Thu, 18 May
 2023 08:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
 <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
 <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
In-Reply-To: <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
Date: Thu, 18 May 2023 11:00:51 -0400
Message-ID: <CAFZh4h8rZU7Nd-6FptvsibgMXURu0EHKXeouRzNg0mLbTr9t+Q@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMTA6NDXigK9BTSBNYXRoaWV1IERlc25veWVycwo8bWF0
aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IE9uIDIwMjMtMDUtMTggMTA6
MTAsIEJyaWFuIEh1dGNoaW5zb24gd3JvdGU6Cj4gWy4uLl0KPiA+IEkgdXBkYXRlZCBteSBoZWxs
byB3b3JsZCB0byBoYXZlIGEgZnVuY3Rpb24gSSdkIGxpa2UgdG8gdXNlIHRoZQo+ID4gLS11c2Vy
c3BhY2UtcHJvYmUgbWV0aG9kIG9uIHdpdGggdGhlIHZlcnkgb3JpZ2luYWwgbmFtZSBvZgo+ID4g
J3Byb2JlX2Z1bmN0aW9uJzoKPiA+Cj4gPiAjaW5jbHVkZSA8c3RkaW8uaD4KPiA+ICNpbmNsdWRl
IDxsdHRuZy90cmFjZWYuaD4KPiA+Cj4gPiB2b2lkIHByb2JlX2Z1bmN0aW9uKGludCBpKTsKPiA+
Cj4gPiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+ID4gewo+ID4gICAgIHVuc2ln
bmVkIGludCBpOwo+ID4gICAgIHB1dHMoIkhlbGxvLCBXb3JsZCFcblByZXNzIEVudGVyIHRvIGNv
bnRpbnVlLi4uIik7Cj4gPiAgICAgLyoKPiA+ICAgICAgKiBUaGUgZm9sbG93aW5nIGdldGNoYXIo
KSBjYWxsIG9ubHkgZXhpc3RzIGZvciB0aGUgcHVycG9zZSBvZiB0aGlzCj4gPiAgICAgICogZGVt
b25zdHJhdGlvbiwgdG8gcGF1c2UgdGhlIGFwcGxpY2F0aW9uIGluIG9yZGVyIGZvciB5b3UgdG8g
aGF2ZQo+ID4gICAgICAqIHRpbWUgdG8gbGlzdCBpdHMgdHJhY2Vwb2ludHMuIFlvdSBkb24ndCBu
ZWVkIGl0IG90aGVyd2lzZS4KPiA+ICAgICAgKi8KPiA+ICAgICBnZXRjaGFyKCk7Cj4gPgo+ID4g
ICAgIGx0dG5nX3VzdF90cmFjZWYoIk51bWJlciAlZCwgc3RyaW5nICVzIiwgMjMsICJoaSB0aGVy
ZSEiKTsKPiA+ICAgICBwcmludGYoIk51bWJlciAlZCwgc3RyaW5nICVzIiwgMjMsICJoaSB0aGVy
ZSEiKTsKPiA+Cj4gPiAgICAgZm9yIChpID0gMDsgaSA8IGFyZ2M7IGkrKykgewo+ID4gICAgICAg
ICBsdHRuZ191c3RfdHJhY2VmKCJOdW1iZXIgJWQsIGFyZ3YgJXMiLCBpLCBhcmd2W2ldKTsKPiA+
ICAgICAgICAgcHJpbnRmKCJOdW1iZXIgJWQsIGFyZ3YgJXMiLCBpLCBhcmd2W2ldKTsKPiA+ICAg
ICB9Cj4gPgo+ID4gICAgIHB1dHMoIlF1aXR0aW5nIG5vdyEiKTsKPiA+Cj4gPiAgICAgcHJvYmVf
ZnVuY3Rpb24oaSk7Cj4gPgo+ID4gICAgIHJldHVybiAwOwo+ID4gfQo+ID4KPiA+IHZvaWQgcHJv
YmVfZnVuY3Rpb24oaW50IGkpIHsKPiA+Cj4gPiAgICAgbHR0bmdfdXN0X3RyYWNlZigiTnVtYmVy
ICVkLCBzdHJpbmcgJXMiLCBpICogaSwgImleMiIpOwo+ID4gICAgIHByaW50ZigiTnVtYmVyICVk
LCBzdHJpbmcgJXMiLCBpICogaSwgImleMiIpOwo+ID4KPiA+IH0KPiA+Cj4gPiAuLi4gYW5kIEkg
Z2V0IHRoZSBzYW1lIGVycm9yIGFzIGJlZm9yZSB3aGVuIEkgdHJ5IHRvIGVuYWJsZSB0aGUgcHJv
YmU6Cj4gPiAjIGx0dG5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbAo+ID4gLS11c2Vyc3BhY2UtcHJv
YmU9L3Vzci9sb2NhbC9iaW4vaGVsbG86cHJvYmVfZnVuY3Rpb24KPiA+IEVycm9yOiBNaXNzaW5n
IGV2ZW50IG5hbWUocykuCj4KPiBBcyB0aGUgZXJyb3Igc3RhdGVzLCB5b3UgYXJlIG1pc3Npbmcg
dGhlIGV2ZW50IG5hbWUuIFNlZQo+Cj4gbWFuIDEgbHR0bmctZW5hYmxlLWV2ZW50Cj4KPiAgICAg
ICAgIGx0dG5nIFtHRU5FUkFMIE9QVElPTlNdIGVuYWJsZS1ldmVudCAtLWtlcm5lbAo+ICAgICAg
ICAgICAgICAgWy0tcHJvYmU9U09VUkNFIHwgLS1mdW5jdGlvbj1TT1VSQ0UgfCAtLXN5c2NhbGwg
fAo+ICAgICAgICAgICAgICAgIC0tdXNlcnNwYWNlLXByb2JlPVNPVVJDRV0KPiAgICAgICAgICAg
ICAgIFstLWZpbHRlcj1FWFBSXSBbLS1zZXNzaW9uPVNFU1NJT05dCj4gICAgICAgICAgICAgICBb
LS1jaGFubmVsPUNIQU5ORUxdIEVWRU5UWyxFVkVOVF0uLi4KPgo+Cj4gWW91IHdpbGwgd2FudCBz
b21ldGhpbmcgbGlrZToKPgo+IGx0dG5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbCAtLXVzZXJzcGFj
ZS1wcm9iZT0vdXNyL2xvY2FsL2Jpbi9oZWxsbzpwcm9iZV9mdW5jdGlvbiBteV9wcm9iZV9mdW5j
dGlvbgo+Cj4gV2hlcmUgIm15X3Byb2JlX2Z1bmN0aW9uIiBpcyB0aGUgZXZlbnQgbmFtZSB0aGF0
IHdpbGwgYXBwZWFyIGluIHRoZSBjb2xsZWN0ZWQgdHJhY2VzLgoKV293ISAgSSBtdXN0IG5vdCBo
YXZlIHdva2VuIHVwIHRoaXMgbW9ybmluZyBoYSwgaGEuICBUaGFua3MgZm9yIHRoYXQhClRoZSBl
dmVudCBpcyBlbmFibGVkIG5vdy4gIEhvcGUgdG8gYWN0dWFsbHkgZ2V0IHRyYWNpbmcgZGF0YSBu
b3cuCgpSZWdhcmRzLAoKQnJpYW4KCj4KPiBUaGFua3MsCj4KPiBNYXRoaWV1Cj4KPiAtLQo+IE1h
dGhpZXUgRGVzbm95ZXJzCj4gRWZmaWNpT1MgSW5jLgo+IGh0dHBzOi8vd3d3LmVmZmljaW9zLmNv
bQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
