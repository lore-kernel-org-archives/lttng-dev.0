Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A69C77B7D
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 19:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684436934;
	bh=Zdx7DrMydN26ztCH6xL8o44EsG0SA2P4r/K6o05aqNc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TrxpLjecaPM18COwyt++pTbZHyYvk6nN+cnnV0l6MY1uBKtB1kW+UI9TtZYWElo4I
	 NuImFTXrgcnHOLTSABEcBaEvSSxxMb+WqxDkwSH8TO0CTFXxatkRVdbq18ONYhBeWX
	 uHtLuPJQ5rNhkg2H1BbzGGE0eDHIXghDLm2HEZwl5QCxVuwsH0tiabemGJzotoWf2b
	 qOwYw3DQQKPBJsdEUIWEzGZDeKFAnld6wxrxZ5y225LfrGye1F5jR5PqsB2RAxil6X
	 NzE2toBNO2LQuzR8f7JD8O98TLPHWPn4WyM1st6qv2NhD7oDYhA44cHBY37FLLivx3
	 lNVVPzYzfzsHg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMfdy40qNz1G76;
	Thu, 18 May 2023 15:08:54 -0400 (EDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMfdx2yYnz1G74
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 15:08:53 -0400 (EDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-510b6a24946so4392793a12.0
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 12:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684436872; x=1687028872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGIrnS2XqpGWmxB0qnxwBj5B7SXKaMYVKAps2mQTNKE=;
 b=aKRiaKiW9NH1KTjisLXeolE9+Ob7yzjdAKwdw1nAjfeoD384VuRvQdudypOUIPaN9Q
 ZcSVl4C7ml8PG2hGCleX925IaG2XPXej/SFq3boWTPD2BjIzpYe/oCh6l6w3t+zi2W7p
 p88umwoX7MknA4SMsioeKy8zSugcqB2dV8vFBsSMdG2g+aoMMWu5SMMz9E85aRsbN26j
 h9ZzqTP0XiPd/R9Qs2E4v/+xaD+FaKczg7pOK01nBkFjaQKFGTlknOCRzNHzkX0uAWqO
 lve9pzKuI9kea8WhbIEZLM79spqFeVvMZCgSSKr/oBk4KWIyf2kQRWi0arUNM4G8rI59
 2cIw==
X-Gm-Message-State: AC+VfDzZteu60YTsUecwWzdEELO7NXeGI/tdl6medfSFH7r1OoN1IzG2
 WaQTiUxvuBr71NahmhhTEv/PsevNNi9Z+cdNtAI=
X-Google-Smtp-Source: ACHHUZ5+Vldbiimvjwfd/l+OBUsD2K4VaO80GiIDpKPEaOrGIkUwAm1Aqzk9/M5zZ+iq/Ni/R8UCOs0o+LLLh4FzxVk=
X-Received: by 2002:aa7:c74c:0:b0:510:e756:3a1e with SMTP id
 c12-20020aa7c74c000000b00510e7563a1emr2601845eds.11.1684436871887; Thu, 18
 May 2023 12:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
 <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
 <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
 <CAFZh4h8rZU7Nd-6FptvsibgMXURu0EHKXeouRzNg0mLbTr9t+Q@mail.gmail.com>
 <CAFZh4h_Z6ZrYLV+F7rD_yvr70L_Ryp9GS0Sv12bj0k5QASTXHA@mail.gmail.com>
 <c6d06421-366d-2464-abd3-06cb43dfddeb@efficios.com>
In-Reply-To: <c6d06421-366d-2464-abd3-06cb43dfddeb@efficios.com>
Date: Thu, 18 May 2023 15:07:40 -0400
Message-ID: <CAFZh4h-aD==niaWF9Y=Z=bNm7vsUCWfaxkTBXAewyFXWVndCTg@mail.gmail.com>
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

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMzowM+KAr1BNIE1hdGhpZXUgRGVzbm95ZXJzCjxtYXRo
aWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+Cj4gT24gMjAyMy0wNS0xOCAxNDo1
OCwgQnJpYW4gSHV0Y2hpbnNvbiB3cm90ZToKPiA+IE9uIFRodSwgTWF5IDE4LCAyMDIzIGF0IDEx
OjAw4oCvQU0gQnJpYW4gSHV0Y2hpbnNvbiA8Yi5odXRjaG1hbkBnbWFpbC5jb20+IHdyb3RlOgo+
ID4+Cj4gPj4gT24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMTA6NDXigK9BTSBNYXRoaWV1IERlc25v
eWVycwo+ID4+IDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOgo+ID4+Pgo+
ID4+PiBPbiAyMDIzLTA1LTE4IDEwOjEwLCBCcmlhbiBIdXRjaGluc29uIHdyb3RlOgo+ID4+PiBb
Li4uXQo+ID4+Pj4gSSB1cGRhdGVkIG15IGhlbGxvIHdvcmxkIHRvIGhhdmUgYSBmdW5jdGlvbiBJ
J2QgbGlrZSB0byB1c2UgdGhlCj4gPj4+PiAtLXVzZXJzcGFjZS1wcm9iZSBtZXRob2Qgb24gd2l0
aCB0aGUgdmVyeSBvcmlnaW5hbCBuYW1lIG9mCj4gPj4+PiAncHJvYmVfZnVuY3Rpb24nOgo+ID4+
Pj4KPiA+Pj4+ICNpbmNsdWRlIDxzdGRpby5oPgo+ID4+Pj4gI2luY2x1ZGUgPGx0dG5nL3RyYWNl
Zi5oPgo+ID4+Pj4KPiA+Pj4+IHZvaWQgcHJvYmVfZnVuY3Rpb24oaW50IGkpOwo+ID4+Pj4KPiA+
Pj4+IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCj4gPj4+PiB7Cj4gPj4+PiAgICAg
IHVuc2lnbmVkIGludCBpOwo+ID4+Pj4gICAgICBwdXRzKCJIZWxsbywgV29ybGQhXG5QcmVzcyBF
bnRlciB0byBjb250aW51ZS4uLiIpOwo+ID4+Pj4gICAgICAvKgo+ID4+Pj4gICAgICAgKiBUaGUg
Zm9sbG93aW5nIGdldGNoYXIoKSBjYWxsIG9ubHkgZXhpc3RzIGZvciB0aGUgcHVycG9zZSBvZiB0
aGlzCj4gPj4+PiAgICAgICAqIGRlbW9uc3RyYXRpb24sIHRvIHBhdXNlIHRoZSBhcHBsaWNhdGlv
biBpbiBvcmRlciBmb3IgeW91IHRvIGhhdmUKPiA+Pj4+ICAgICAgICogdGltZSB0byBsaXN0IGl0
cyB0cmFjZXBvaW50cy4gWW91IGRvbid0IG5lZWQgaXQgb3RoZXJ3aXNlLgo+ID4+Pj4gICAgICAg
Ki8KPiA+Pj4+ICAgICAgZ2V0Y2hhcigpOwo+ID4+Pj4KPiA+Pj4+ICAgICAgbHR0bmdfdXN0X3Ry
YWNlZigiTnVtYmVyICVkLCBzdHJpbmcgJXMiLCAyMywgImhpIHRoZXJlISIpOwo+ID4+Pj4gICAg
ICBwcmludGYoIk51bWJlciAlZCwgc3RyaW5nICVzIiwgMjMsICJoaSB0aGVyZSEiKTsKPiA+Pj4+
Cj4gPj4+PiAgICAgIGZvciAoaSA9IDA7IGkgPCBhcmdjOyBpKyspIHsKPiA+Pj4+ICAgICAgICAg
IGx0dG5nX3VzdF90cmFjZWYoIk51bWJlciAlZCwgYXJndiAlcyIsIGksIGFyZ3ZbaV0pOwo+ID4+
Pj4gICAgICAgICAgcHJpbnRmKCJOdW1iZXIgJWQsIGFyZ3YgJXMiLCBpLCBhcmd2W2ldKTsKPiA+
Pj4+ICAgICAgfQo+ID4+Pj4KPiA+Pj4+ICAgICAgcHV0cygiUXVpdHRpbmcgbm93ISIpOwo+ID4+
Pj4KPiA+Pj4+ICAgICAgcHJvYmVfZnVuY3Rpb24oaSk7Cj4gPj4+Pgo+ID4+Pj4gICAgICByZXR1
cm4gMDsKPiA+Pj4+IH0KPiA+Pj4+Cj4gPj4+PiB2b2lkIHByb2JlX2Z1bmN0aW9uKGludCBpKSB7
Cj4gPj4+Pgo+ID4+Pj4gICAgICBsdHRuZ191c3RfdHJhY2VmKCJOdW1iZXIgJWQsIHN0cmluZyAl
cyIsIGkgKiBpLCAiaV4yIik7Cj4gPj4+PiAgICAgIHByaW50ZigiTnVtYmVyICVkLCBzdHJpbmcg
JXMiLCBpICogaSwgImleMiIpOwo+ID4+Pj4KPiA+Pj4+IH0KPiA+Pj4+Cj4gPj4+PiAuLi4gYW5k
IEkgZ2V0IHRoZSBzYW1lIGVycm9yIGFzIGJlZm9yZSB3aGVuIEkgdHJ5IHRvIGVuYWJsZSB0aGUg
cHJvYmU6Cj4gPj4+PiAjIGx0dG5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbAo+ID4+Pj4gLS11c2Vy
c3BhY2UtcHJvYmU9L3Vzci9sb2NhbC9iaW4vaGVsbG86cHJvYmVfZnVuY3Rpb24KPiA+Pj4+IEVy
cm9yOiBNaXNzaW5nIGV2ZW50IG5hbWUocykuCj4gPj4+Cj4gPj4+IEFzIHRoZSBlcnJvciBzdGF0
ZXMsIHlvdSBhcmUgbWlzc2luZyB0aGUgZXZlbnQgbmFtZS4gU2VlCj4gPj4+Cj4gPj4+IG1hbiAx
IGx0dG5nLWVuYWJsZS1ldmVudAo+ID4+Pgo+ID4+PiAgICAgICAgICBsdHRuZyBbR0VORVJBTCBP
UFRJT05TXSBlbmFibGUtZXZlbnQgLS1rZXJuZWwKPiA+Pj4gICAgICAgICAgICAgICAgWy0tcHJv
YmU9U09VUkNFIHwgLS1mdW5jdGlvbj1TT1VSQ0UgfCAtLXN5c2NhbGwgfAo+ID4+PiAgICAgICAg
ICAgICAgICAgLS11c2Vyc3BhY2UtcHJvYmU9U09VUkNFXQo+ID4+PiAgICAgICAgICAgICAgICBb
LS1maWx0ZXI9RVhQUl0gWy0tc2Vzc2lvbj1TRVNTSU9OXQo+ID4+PiAgICAgICAgICAgICAgICBb
LS1jaGFubmVsPUNIQU5ORUxdIEVWRU5UWyxFVkVOVF0uLi4KPiA+Pj4KPiA+Pj4KPiA+Pj4gWW91
IHdpbGwgd2FudCBzb21ldGhpbmcgbGlrZToKPiA+Pj4KPiA+Pj4gbHR0bmcgZW5hYmxlLWV2ZW50
IC0ta2VybmVsIC0tdXNlcnNwYWNlLXByb2JlPS91c3IvbG9jYWwvYmluL2hlbGxvOnByb2JlX2Z1
bmN0aW9uIG15X3Byb2JlX2Z1bmN0aW9uCj4gPj4+Cj4gPj4+IFdoZXJlICJteV9wcm9iZV9mdW5j
dGlvbiIgaXMgdGhlIGV2ZW50IG5hbWUgdGhhdCB3aWxsIGFwcGVhciBpbiB0aGUgY29sbGVjdGVk
IHRyYWNlcy4KPiA+Pgo+ID4+IFdvdyEgIEkgbXVzdCBub3QgaGF2ZSB3b2tlbiB1cCB0aGlzIG1v
cm5pbmcgaGEsIGhhLiAgVGhhbmtzIGZvciB0aGF0IQo+ID4+IFRoZSBldmVudCBpcyBlbmFibGVk
IG5vdy4gIEhvcGUgdG8gYWN0dWFsbHkgZ2V0IHRyYWNpbmcgZGF0YSBub3cuCj4gPgo+ID4gV2Vs
bCwgSSBndWVzcyB3ZSBqdXN0IGhhdmUgdGhlIGFwcCB0aGF0IHRod2FydHMgYWxsIGF0dGVtcHRz
IGF0IHRyYWNpbmcuCj4gPgo+ID4gSSBkaWQgYSBkeW5hbWljIHByb2JlIG9uIHNldmVyYWwgZnVu
Y3Rpb25zIHRoYXQgc2hvdWxkIGJlIGdldHRpbmcKPiA+IGNhbGxlZCBsaWtlIGNyYXp5IGFuZCBh
Z2FpbiBJIGdldCBubyB0cmFjaW5nIGRhdGEuCj4gPgo+ID4gVHJpZWQgaXQgd2l0aCBteSBoZWxs
byB3b3JsZCBleGFtcGxlIGFib3ZlIGFmdGVyIE1hdGhpZXUgc2V0IG1lCj4gPiBzdHJhaWdodCBv
biB0aGUgZXZlbnQgc3ludGF4IGFuZCBpdCB3b3Jrcy4KPiA+Cj4gPiBJIHNhdyB0aGlzIGNvbW1l
bnQgaW4gdGhlIGRvY3VtZW50YXRpb24gIkFzIG9mIHRoaXMgdmVyc2lvbiwgb25seSBVU0RUCj4g
PiBwcm9iZXMgdGhhdCBhcmUgbm90IHN1cnJvdW5kZWQgYnkgYSByZWZlcmVuY2UgY291bnRlciAo
c2VtYXBob3JlKSBhcmUKPiA+IHN1cHBvcnRlZC4iCj4gPgo+ID4gSSBkb24ndCBrbm93IHRoYXQg
SSBjYW4gc2F5IHRoYXQgdGhpcyBmdW5jdGlvbiBJJ20gcHJvYmluZyBpc24ndAo+ID4gInN1cnJv
dW5kZWQiIGJ5IGEgcmVmZXJlbmNlIGNvdW50ZXIsIGl0J3MgaW4gYSBsYXJnZSBtdWx0aS10aHJl
YWRlZAo+ID4gYXBwbGljYXRpb24gc28gSSBndWVzcyBpdCdzIHBvc3NpYmxlLgo+ID4KPiA+IFNp
Z2gsIEknbSBzdHJpa2luZyBvdXQgZXZlcnkgd2hpY2ggd2F5Lgo+ID4KPiA+IE5vIG9mZmVuc2Ug
KHNpbmNlIHRoaXMgaXMgbHR0bmcgbGlzdCAtIHBsZWFzZSBkb24ndCBmbGFtZSBtZSAuLi4gSQo+
ID4gd2FudC9uZWVkIGx0dG5nKSwgYnV0IEkgdGhpbmsgSSdtIGdvaW5nIHRvIHRyeSBqdXN0IHN0
cmFpZ2h0IGtwcm9iZXMKPiA+IGFuZCB1cHJvYmVzIGFuZCBzZWUgaWYgdHJhY2UgY29tcGFzcyBj
YW4gc2hvdyB0aG9zZSB0cmFjZXMgaW4gYW4KPiA+IGF0dGVtcHQgdG8gZ2V0ICJzb21ldGhpbmcv
YW55dGhpbmciIHdvcmtpbmcuCj4KPiBJZiB5b3UgYXR0YWNoIHRvIGFuIEVMRiBzeW1ib2wgKGZ1
bmN0aW9uKSwgdGhlbiB0aGVyZSBpcyBubyBVU0RUIGluCj4gcGxheSwgc28gaXQgc2hvdWxkIG5v
dCBiZSByZWxhdGVkIHRvIHRoZSBpc3N1ZSB5b3UgaGF2ZS4KClRoYXQgaXMgd2hhdCBJIHdhcyB0
aGlua2luZyB3aGljaCBpcyB3aHkgSSB3YW50ZWQgdG8gdHJ5IGl0LgoKPgo+IEJ1dCBpZiB5b3Vy
IGZ1bmN0aW9ucyBoYXBwZW4gdG8gYmUgaW5saW5lZCwgdGhlbiB0aGVyZSB3aWxsIGJlIG5vdGhp
bmcKPiB0byBhdHRhY2ggdG8uIFBlcmhhcHMgdGhpcyBpcyB3aGF0IGhhcHBlbnMgdGhlcmUgPwoK
SSBkb24ndCBzZWUgYW55IGV2aWRlbmNlIG9mIGFueXRoaW5nIGJlaW5nIGlubGluZWQgaW4gdGhp
cyBtb2R1bGUuICBJCmdyZXBwZWQgdGhlIGNvZGUgdG8gdmVyaWZ5LgoKQmFjayB0byBiZWluZyBz
dHVtcGVkL3N0dWNrLgoKQgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
