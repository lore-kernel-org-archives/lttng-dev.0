From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Subject: Re: [RFC PATCH CTF 1/3] Clarify that unlisted enum
 values are implementation-defined
Date: Thu, 23 Apr 2020 18:51:09 -0400
Message-ID: <CA+jJMxvqe5sYq3f7kDMthTfiC7oNR1Awok-R2CdKJgRHowuXTA@mail.gmail.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-2-mathieu.desnoyers@efficios.com>
Reply-To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?=
 <jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 497XcF0Qv8z1jJh
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 18:51:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 226A628C6B4
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 18:51:50 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Zjc2xQLAaJ1S for <lttng-dev@lists.lttng.org>;
 Thu, 23 Apr 2020 18:51:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F81A28C906
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 18:51:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rEsymsfV9SZB for <lttng-dev@lists.lttng.org>;
 Thu, 23 Apr 2020 18:51:47 -0400 (EDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by mail.efficios.com (Postfix) with ESMTPSA id 0A14728C64F
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 18:51:47 -0400 (EDT)
Received: by mail-lf1-f41.google.com with SMTP id t11so6098768lfe.4
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 15:51:46 -0700 (PDT)
In-Reply-To: <20200423205226.496-2-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: diamon-discuss@linuxfoundation.org, Jeremie Galarneau <jgalar@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Philippe Proulx <pproulx@efficios.com>, =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <gbastien+lttng@versatic.net>
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCAyMyBBcHIgMjAyMCBhdCAxNjo1MiwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUu
ZGVzbm95ZXJzQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBHZW5ldmnDqHZlIEJhc3Rp
ZW4gPGdiYXN0aWVuK2x0dG5nQHZlcnNhdGljLm5ldD4KPgo+IFNpZ25lZC1vZmYtYnk6IEdlbmV2
acOodmUgQmFzdGllbiA8Z2Jhc3RpZW4rbHR0bmdAdmVyc2F0aWMubmV0Pgo+IFNpZ25lZC1vZmYt
Ynk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+Cj4g
LS0tCj4gIGNvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDMgKysrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9jb21tb24tdHJh
Y2UtZm9ybWF0LXNwZWNpZmljYXRpb24ubWQgYi9jb21tb24tdHJhY2UtZm9ybWF0LXNwZWNpZmlj
YXRpb24ubWQKPiBpbmRleCBmZDQ5ZTU5Li5mNWZlYTUxIDEwMDY0NAo+IC0tLSBhL2NvbW1vbi10
cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZAo+ICsrKyBiL2NvbW1vbi10cmFjZS1mb3JtYXQt
c3BlY2lmaWNhdGlvbi5tZAo+IEBAIC00NjQsNiArNDY0LDkgQEAgZW51bSB7Cj4gIH0KPiAgfn5+
Cj4KPiArVGhlIG1hcHBpbmdzIGluIHRoZSBlbnVtZXJhdGlvbiB0eXBlIGRvIG5vdCBoYXZlIHRv
IGJlIGV4aGF1c3RpdmUuCj4gK1VubGlzdGVkIHZhbHVlcyBhcmUgaW1wbGVtZW50YXRpb24gZGVm
aW5lZC4KPiArCgpUaGlzIGlzIHRvbyB2YWd1ZSB0byBiZSB1c2VmdWwga25vd2luZyB0aGF0IHRo
ZSBtYWluIHJhdGlvbmFsZSBmb3IgdGhpcwpjaGFuZ2UgaXMgdG8gYWxsb3cgZW51bXMgdG8gZXhw
cmVzcyBzb21lIHR5cGUgb2YgYml0ZmllbGQgb2YgZmxhZ3MKaW4gdGhlIHRyYWNlciBhbmQgcmVh
ZGVycyBbMV0uCgpXaGF0IGlzIHRoZSBtZWFuaW5nIG9mIGFuIHVubWFwcGVkIHZhbHVlPyBUaGlz
IHNlY3Rpb24gc2hvdWxkIGF0CmxlYXN0IGRlc2NyaWJlIHRoZSBjb3JyZWN0IGludGVycHJldGF0
aW9uIG9mIHVubWFwcGVkIHZhbHVlcyBhcyBmbGFncwphbmQgd2hlbiBpdCBpcyBhcHByb3ByaWF0
ZSB0byBkbyBzby4KClRoYW5rcywKSsOpcsOpbWllCgpbMV0gaHR0cHM6Ly9yZXZpZXcubHR0bmcu
b3JnL2MvYmFiZWx0cmFjZS8rLzMwNDUKCj4gICMjIyA0LjIgQ29tcG91bmQgdHlwZXMKPgo+ICBD
b21wb3VuZCBhcmUgYWdncmVnYXRpb24gb2YgdHlwZSBkZWNsYXJhdGlvbnMuIENvbXBvdW5kIHR5
cGVzIGluY2x1ZGUKPiAtLQo+IDIuMTEuMAo+CgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZm
aWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
