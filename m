From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2 1/4] Save registration time
 for app
Date: Fri, 6 Sep 2019 11:37:25 -0400
Message-ID: <CA+jJMxvvBZVTaMSEN1KnPwo+Fb35Wen3u4qm+31rtL2D9LPPNQ__47824.6498199709$1567784307$gmane$org@mail.gmail.com>
References: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46Q1st4bxhzsDf
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 11:38:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 07AAF32C093
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 11:38:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id MUoRqf3y32G0 for <lttng-dev@lists.lttng.org>;
 Fri,  6 Sep 2019 11:38:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id BC99E32C08D
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 11:38:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id SKgU-oqJCxXi for <lttng-dev@lists.lttng.org>;
 Fri,  6 Sep 2019 11:38:03 -0400 (EDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by mail.efficios.com (Postfix) with ESMTPSA id 6A0DB32C07D
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 11:38:03 -0400 (EDT)
Received: by mail-lf1-f49.google.com with SMTP id j4so5411252lfh.8
 for <lttng-dev@lists.lttng.org>; Fri, 06 Sep 2019 08:38:03 -0700 (PDT)
In-Reply-To: <20190813202519.31043-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciBhbmQgc3RhYmxlLTIuMTEuIFRoYW5rcyEKCkrDqXLDqW1pZQoKT24g
VHVlLCAxMyBBdWcgMjAxOSBhdCAxNjoyNSwgSm9uYXRoYW4gUmFqb3R0ZQo8am9uYXRoYW4ucmFq
b3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IFJldXNlIHRoZSByZWdpc3RyYXRp
b24gdGltZSBmb3IgcGF0aCBnZW5lcmF0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
UmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBz
cmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYyB8IDcgKysrLS0tLQo+ICBzcmMvYmluL2x0
dG5nLXNlc3Npb25kL3VzdC1hcHAuaCB8IDUgKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jpbi9sdHRu
Zy1zZXNzaW9uZC91c3QtYXBwLmMgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuYwo+
IGluZGV4IDRiZWU1MDQ5Ni4uNDQzMjMyZTc5IDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4vbHR0bmct
c2Vzc2lvbmQvdXN0LWFwcC5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3QtYXBw
LmMKPiBAQCAtMTgzMSwxNSArMTgzMSwxMiBAQCBzdGF0aWMgdm9pZCBzaGFkb3dfY29weV9jaGFu
bmVsKHN0cnVjdCB1c3RfYXBwX2NoYW5uZWwgKnVhX2NoYW4sCj4gIHN0YXRpYyB2b2lkIHNoYWRv
d19jb3B5X3Nlc3Npb24oc3RydWN0IHVzdF9hcHBfc2Vzc2lvbiAqdWFfc2VzcywKPiAgICAgICAg
ICAgICAgICAgc3RydWN0IGx0dF91c3Rfc2Vzc2lvbiAqdXNlc3MsIHN0cnVjdCB1c3RfYXBwICph
cHApCj4gIHsKPiAtICAgICAgIHRpbWVfdCByYXd0aW1lOwo+ICAgICAgICAgc3RydWN0IHRtICp0
aW1laW5mbzsKPiAgICAgICAgIGNoYXIgZGF0ZXRpbWVbMTZdOwo+ICAgICAgICAgaW50IHJldDsK
PiAgICAgICAgIGNoYXIgdG1wX3NobV9wYXRoW1BBVEhfTUFYXTsKPgo+IC0gICAgICAgLyogR2V0
IGRhdGUgYW5kIHRpbWUgZm9yIHVuaXF1ZSBhcHAgcGF0aCAqLwo+IC0gICAgICAgdGltZSgmcmF3
dGltZSk7Cj4gLSAgICAgICB0aW1laW5mbyA9IGxvY2FsdGltZSgmcmF3dGltZSk7Cj4gKyAgICAg
ICB0aW1laW5mbyA9IGxvY2FsdGltZSgmYXBwLT5yZWdpc3RyYXRpb25fdGltZSk7Cj4gICAgICAg
ICBzdHJmdGltZShkYXRldGltZSwgc2l6ZW9mKGRhdGV0aW1lKSwgIiVZJW0lZC0lSCVNJVMiLCB0
aW1laW5mbyk7Cj4KPiAgICAgICAgIERCRzIoIlNoYWRvdyBjb3B5IG9mIHNlc3Npb24gaGFuZGxl
ICVkIiwgdWFfc2Vzcy0+aGFuZGxlKTsKPiBAQCAtMzM3Niw2ICszMzczLDggQEAgdm9pZCB1c3Rf
YXBwX2FkZChzdHJ1Y3QgdXN0X2FwcCAqYXBwKQo+ICAgICAgICAgYXNzZXJ0KGFwcCk7Cj4gICAg
ICAgICBhc3NlcnQoYXBwLT5ub3RpZnlfc29jayA+PSAwKTsKPgo+ICsgICAgICAgYXBwLT5yZWdp
c3RyYXRpb25fdGltZSA9IHRpbWUoTlVMTCk7Cj4gKwo+ICAgICAgICAgcmN1X3JlYWRfbG9jaygp
Owo+Cj4gICAgICAgICAvKgo+IGRpZmYgLS1naXQgYS9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3Vz
dC1hcHAuaCBiL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvdXN0LWFwcC5oCj4gaW5kZXggYjkwZmY0
YmNlLi5kOTI3OWYwZTQgMTAwNjQ0Cj4gLS0tIGEvc3JjL2Jpbi9sdHRuZy1zZXNzaW9uZC91c3Qt
YXBwLmgKPiArKysgYi9zcmMvYmluL2x0dG5nLXNlc3Npb25kL3VzdC1hcHAuaAo+IEBAIC0yOTgs
NiArMjk4LDExIEBAIHN0cnVjdCB1c3RfYXBwIHsKPiAgICAgICAgICAqIHRvIGEgbmVnYXRpdmUg
dmFsdWUgaW5kaWNhdGluZyB0aGF0IHRoZSBhZ2VudCBhcHBsaWNhdGlvbiBpcyBnb25lLgo+ICAg
ICAgICAgICovCj4gICAgICAgICBpbnQgYWdlbnRfYXBwX3NvY2s7Cj4gKyAgICAgICAvKgo+ICsg
ICAgICAgICogVGltZSBhdCB3aGljaCB0aGUgYXBwIGlzIHJlZ2lzdHJlZC4KPiArICAgICAgICAq
IFVzZWQgZm9yIHBhdGggY3JlYXRpb24KPiArICAgICAgICAqLwo+ICsgICAgICAgdGltZV90IHJl
Z2lzdHJhdGlvbl90aW1lOwo+ICB9Owo+Cj4gICNpZmRlZiBIQVZFX0xJQkxUVE5HX1VTVF9DVEwK
PiAtLQo+IDIuMTcuMQo+CgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
