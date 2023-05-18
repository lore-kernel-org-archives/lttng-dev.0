Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D30C7EE23
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 19:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684436625;
	bh=IlgIGZkOaUMFQvohEBliSRXx5r+x2HM/6bvaSQxRnVA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pYjKjK0Obs6F3Xm7Hb37S8WJtvUemzC/+lhPfQtP9MJGLZ5Mt50IHCfQ6/WJWRNne
	 wS/dp9YJXwXPYe74pOsXrL42vXqBaW/PH1rIeE67K9F2IhPVVyAjt0AjxHcJcdEVqR
	 Y4sjCefNybs8jN4UxvMgZ19NU0Q06qIUNZ7oPQdNyk3cicSL4fpHgoCPC3IFGjgcwA
	 mdeVsAngiprx8EySE1KrE8vVu2BDa34f/AUJWkms6XD9VIl2rCiqEY9QAPdMpwRS53
	 DmULZZ/My7kPnuJe0tPXhAq2ubx5jd+7VAoGBaWkHiVB+OVpISvwi8C7qHhWV9/buB
	 ZZHWM/phK+lSg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMfX12StWz1G1r;
	Thu, 18 May 2023 15:03:45 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMfX00qkgz1G3r
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 15:03:44 -0400 (EDT)
Received: from [172.16.0.117] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QMfWJ4NqQz137N;
 Thu, 18 May 2023 15:03:08 -0400 (EDT)
Message-ID: <c6d06421-366d-2464-abd3-06cb43dfddeb@efficios.com>
Date: Thu, 18 May 2023 15:03:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
 <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
 <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
 <CAFZh4h8rZU7Nd-6FptvsibgMXURu0EHKXeouRzNg0mLbTr9t+Q@mail.gmail.com>
 <CAFZh4h_Z6ZrYLV+F7rD_yvr70L_Ryp9GS0Sv12bj0k5QASTXHA@mail.gmail.com>
In-Reply-To: <CAFZh4h_Z6ZrYLV+F7rD_yvr70L_Ryp9GS0Sv12bj0k5QASTXHA@mail.gmail.com>
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gMjAyMy0wNS0xOCAxNDo1OCwgQnJpYW4gSHV0Y2hpbnNvbiB3cm90ZToKPiBPbiBUaHUsIE1h
eSAxOCwgMjAyMyBhdCAxMTowMOKAr0FNIEJyaWFuIEh1dGNoaW5zb24gPGIuaHV0Y2htYW5AZ21h
aWwuY29tPiB3cm90ZToKPj4KPj4gT24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMTA6NDXigK9BTSBN
YXRoaWV1IERlc25veWVycwo+PiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiB3cm90
ZToKPj4+Cj4+PiBPbiAyMDIzLTA1LTE4IDEwOjEwLCBCcmlhbiBIdXRjaGluc29uIHdyb3RlOgo+
Pj4gWy4uLl0KPj4+PiBJIHVwZGF0ZWQgbXkgaGVsbG8gd29ybGQgdG8gaGF2ZSBhIGZ1bmN0aW9u
IEknZCBsaWtlIHRvIHVzZSB0aGUKPj4+PiAtLXVzZXJzcGFjZS1wcm9iZSBtZXRob2Qgb24gd2l0
aCB0aGUgdmVyeSBvcmlnaW5hbCBuYW1lIG9mCj4+Pj4gJ3Byb2JlX2Z1bmN0aW9uJzoKPj4+Pgo+
Pj4+ICNpbmNsdWRlIDxzdGRpby5oPgo+Pj4+ICNpbmNsdWRlIDxsdHRuZy90cmFjZWYuaD4KPj4+
Pgo+Pj4+IHZvaWQgcHJvYmVfZnVuY3Rpb24oaW50IGkpOwo+Pj4+Cj4+Pj4gaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKPj4+PiB7Cj4+Pj4gICAgICB1bnNpZ25lZCBpbnQgaTsKPj4+
PiAgICAgIHB1dHMoIkhlbGxvLCBXb3JsZCFcblByZXNzIEVudGVyIHRvIGNvbnRpbnVlLi4uIik7
Cj4+Pj4gICAgICAvKgo+Pj4+ICAgICAgICogVGhlIGZvbGxvd2luZyBnZXRjaGFyKCkgY2FsbCBv
bmx5IGV4aXN0cyBmb3IgdGhlIHB1cnBvc2Ugb2YgdGhpcwo+Pj4+ICAgICAgICogZGVtb25zdHJh
dGlvbiwgdG8gcGF1c2UgdGhlIGFwcGxpY2F0aW9uIGluIG9yZGVyIGZvciB5b3UgdG8gaGF2ZQo+
Pj4+ICAgICAgICogdGltZSB0byBsaXN0IGl0cyB0cmFjZXBvaW50cy4gWW91IGRvbid0IG5lZWQg
aXQgb3RoZXJ3aXNlLgo+Pj4+ICAgICAgICovCj4+Pj4gICAgICBnZXRjaGFyKCk7Cj4+Pj4KPj4+
PiAgICAgIGx0dG5nX3VzdF90cmFjZWYoIk51bWJlciAlZCwgc3RyaW5nICVzIiwgMjMsICJoaSB0
aGVyZSEiKTsKPj4+PiAgICAgIHByaW50ZigiTnVtYmVyICVkLCBzdHJpbmcgJXMiLCAyMywgImhp
IHRoZXJlISIpOwo+Pj4+Cj4+Pj4gICAgICBmb3IgKGkgPSAwOyBpIDwgYXJnYzsgaSsrKSB7Cj4+
Pj4gICAgICAgICAgbHR0bmdfdXN0X3RyYWNlZigiTnVtYmVyICVkLCBhcmd2ICVzIiwgaSwgYXJn
dltpXSk7Cj4+Pj4gICAgICAgICAgcHJpbnRmKCJOdW1iZXIgJWQsIGFyZ3YgJXMiLCBpLCBhcmd2
W2ldKTsKPj4+PiAgICAgIH0KPj4+Pgo+Pj4+ICAgICAgcHV0cygiUXVpdHRpbmcgbm93ISIpOwo+
Pj4+Cj4+Pj4gICAgICBwcm9iZV9mdW5jdGlvbihpKTsKPj4+Pgo+Pj4+ICAgICAgcmV0dXJuIDA7
Cj4+Pj4gfQo+Pj4+Cj4+Pj4gdm9pZCBwcm9iZV9mdW5jdGlvbihpbnQgaSkgewo+Pj4+Cj4+Pj4g
ICAgICBsdHRuZ191c3RfdHJhY2VmKCJOdW1iZXIgJWQsIHN0cmluZyAlcyIsIGkgKiBpLCAiaV4y
Iik7Cj4+Pj4gICAgICBwcmludGYoIk51bWJlciAlZCwgc3RyaW5nICVzIiwgaSAqIGksICJpXjIi
KTsKPj4+Pgo+Pj4+IH0KPj4+Pgo+Pj4+IC4uLiBhbmQgSSBnZXQgdGhlIHNhbWUgZXJyb3IgYXMg
YmVmb3JlIHdoZW4gSSB0cnkgdG8gZW5hYmxlIHRoZSBwcm9iZToKPj4+PiAjIGx0dG5nIGVuYWJs
ZS1ldmVudCAtLWtlcm5lbAo+Pj4+IC0tdXNlcnNwYWNlLXByb2JlPS91c3IvbG9jYWwvYmluL2hl
bGxvOnByb2JlX2Z1bmN0aW9uCj4+Pj4gRXJyb3I6IE1pc3NpbmcgZXZlbnQgbmFtZShzKS4KPj4+
Cj4+PiBBcyB0aGUgZXJyb3Igc3RhdGVzLCB5b3UgYXJlIG1pc3NpbmcgdGhlIGV2ZW50IG5hbWUu
IFNlZQo+Pj4KPj4+IG1hbiAxIGx0dG5nLWVuYWJsZS1ldmVudAo+Pj4KPj4+ICAgICAgICAgIGx0
dG5nIFtHRU5FUkFMIE9QVElPTlNdIGVuYWJsZS1ldmVudCAtLWtlcm5lbAo+Pj4gICAgICAgICAg
ICAgICAgWy0tcHJvYmU9U09VUkNFIHwgLS1mdW5jdGlvbj1TT1VSQ0UgfCAtLXN5c2NhbGwgfAo+
Pj4gICAgICAgICAgICAgICAgIC0tdXNlcnNwYWNlLXByb2JlPVNPVVJDRV0KPj4+ICAgICAgICAg
ICAgICAgIFstLWZpbHRlcj1FWFBSXSBbLS1zZXNzaW9uPVNFU1NJT05dCj4+PiAgICAgICAgICAg
ICAgICBbLS1jaGFubmVsPUNIQU5ORUxdIEVWRU5UWyxFVkVOVF0uLi4KPj4+Cj4+Pgo+Pj4gWW91
IHdpbGwgd2FudCBzb21ldGhpbmcgbGlrZToKPj4+Cj4+PiBsdHRuZyBlbmFibGUtZXZlbnQgLS1r
ZXJuZWwgLS11c2Vyc3BhY2UtcHJvYmU9L3Vzci9sb2NhbC9iaW4vaGVsbG86cHJvYmVfZnVuY3Rp
b24gbXlfcHJvYmVfZnVuY3Rpb24KPj4+Cj4+PiBXaGVyZSAibXlfcHJvYmVfZnVuY3Rpb24iIGlz
IHRoZSBldmVudCBuYW1lIHRoYXQgd2lsbCBhcHBlYXIgaW4gdGhlIGNvbGxlY3RlZCB0cmFjZXMu
Cj4+Cj4+IFdvdyEgIEkgbXVzdCBub3QgaGF2ZSB3b2tlbiB1cCB0aGlzIG1vcm5pbmcgaGEsIGhh
LiAgVGhhbmtzIGZvciB0aGF0IQo+PiBUaGUgZXZlbnQgaXMgZW5hYmxlZCBub3cuICBIb3BlIHRv
IGFjdHVhbGx5IGdldCB0cmFjaW5nIGRhdGEgbm93Lgo+IAo+IFdlbGwsIEkgZ3Vlc3Mgd2UganVz
dCBoYXZlIHRoZSBhcHAgdGhhdCB0aHdhcnRzIGFsbCBhdHRlbXB0cyBhdCB0cmFjaW5nLgo+IAo+
IEkgZGlkIGEgZHluYW1pYyBwcm9iZSBvbiBzZXZlcmFsIGZ1bmN0aW9ucyB0aGF0IHNob3VsZCBi
ZSBnZXR0aW5nCj4gY2FsbGVkIGxpa2UgY3JhenkgYW5kIGFnYWluIEkgZ2V0IG5vIHRyYWNpbmcg
ZGF0YS4KPiAKPiBUcmllZCBpdCB3aXRoIG15IGhlbGxvIHdvcmxkIGV4YW1wbGUgYWJvdmUgYWZ0
ZXIgTWF0aGlldSBzZXQgbWUKPiBzdHJhaWdodCBvbiB0aGUgZXZlbnQgc3ludGF4IGFuZCBpdCB3
b3Jrcy4KPiAKPiBJIHNhdyB0aGlzIGNvbW1lbnQgaW4gdGhlIGRvY3VtZW50YXRpb24gIkFzIG9m
IHRoaXMgdmVyc2lvbiwgb25seSBVU0RUCj4gcHJvYmVzIHRoYXQgYXJlIG5vdCBzdXJyb3VuZGVk
IGJ5IGEgcmVmZXJlbmNlIGNvdW50ZXIgKHNlbWFwaG9yZSkgYXJlCj4gc3VwcG9ydGVkLiIKPiAK
PiBJIGRvbid0IGtub3cgdGhhdCBJIGNhbiBzYXkgdGhhdCB0aGlzIGZ1bmN0aW9uIEknbSBwcm9i
aW5nIGlzbid0Cj4gInN1cnJvdW5kZWQiIGJ5IGEgcmVmZXJlbmNlIGNvdW50ZXIsIGl0J3MgaW4g
YSBsYXJnZSBtdWx0aS10aHJlYWRlZAo+IGFwcGxpY2F0aW9uIHNvIEkgZ3Vlc3MgaXQncyBwb3Nz
aWJsZS4KPiAKPiBTaWdoLCBJJ20gc3RyaWtpbmcgb3V0IGV2ZXJ5IHdoaWNoIHdheS4KPiAKPiBO
byBvZmZlbnNlIChzaW5jZSB0aGlzIGlzIGx0dG5nIGxpc3QgLSBwbGVhc2UgZG9uJ3QgZmxhbWUg
bWUgLi4uIEkKPiB3YW50L25lZWQgbHR0bmcpLCBidXQgSSB0aGluayBJJ20gZ29pbmcgdG8gdHJ5
IGp1c3Qgc3RyYWlnaHQga3Byb2Jlcwo+IGFuZCB1cHJvYmVzIGFuZCBzZWUgaWYgdHJhY2UgY29t
cGFzcyBjYW4gc2hvdyB0aG9zZSB0cmFjZXMgaW4gYW4KPiBhdHRlbXB0IHRvIGdldCAic29tZXRo
aW5nL2FueXRoaW5nIiB3b3JraW5nLgoKSWYgeW91IGF0dGFjaCB0byBhbiBFTEYgc3ltYm9sIChm
dW5jdGlvbiksIHRoZW4gdGhlcmUgaXMgbm8gVVNEVCBpbiAKcGxheSwgc28gaXQgc2hvdWxkIG5v
dCBiZSByZWxhdGVkIHRvIHRoZSBpc3N1ZSB5b3UgaGF2ZS4KCkJ1dCBpZiB5b3VyIGZ1bmN0aW9u
cyBoYXBwZW4gdG8gYmUgaW5saW5lZCwgdGhlbiB0aGVyZSB3aWxsIGJlIG5vdGhpbmcgCnRvIGF0
dGFjaCB0by4gUGVyaGFwcyB0aGlzIGlzIHdoYXQgaGFwcGVucyB0aGVyZSA/CgpNYXRoaWV1Cgo+
IAo+IFJlZ2FyZHMsCj4gCj4gQnJpYW4KCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJ
bmMuCmh0dHBzOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
