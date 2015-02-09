From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tool 1/2] Fix: test: java-jul:missing
 static test files for dist and out of tree build
Date: Mon, 9 Feb 2015 15:56:08 -0500
Message-ID: <CA+jJMxs8koXBS2acHqoFAe9gYuKdXsDxscRejMG_oVFGL7+MAA__21801.2830162936$1423515407$gmane$org@mail.gmail.com>
References: <1422655497-12445-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1YKvNO-0001Ah-Cq
 for lttng-dev@lists.lttng.org; Mon, 09 Feb 2015 15:56:18 -0500
Received: by mail-qa0-f46.google.com with SMTP id n4so2680197qaq.5
 for <lttng-dev@lists.lttng.org>; Mon, 09 Feb 2015 12:56:09 -0800 (PST)
In-Reply-To: <1422655497-12445-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Qm90aCBwYXRjaGVzIG1lcmdlZCwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBGcmksIEphbiAzMCwg
MjAxNSBhdCA1OjA0IFBNLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5yYWpvdHRlLWp1bGll
bkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUg
PGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgdGVzdHMvcmVn
cmVzc2lvbi91c3QvamF2YS1qdWwvTWFrZWZpbGUuYW0gfCAxMyArKysrKysrKy0tLS0tCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvcmVncmVzc2lvbi91c3QvamF2YS1qdWwvTWFrZWZpbGUuYW0gYi90ZXN0cy9y
ZWdyZXNzaW9uL3VzdC9qYXZhLWp1bC9NYWtlZmlsZS5hbQo+IGluZGV4IDQ0NDZjNTIuLjI4NmUz
ZGYgMTAwNjQ0Cj4gLS0tIGEvdGVzdHMvcmVncmVzc2lvbi91c3QvamF2YS1qdWwvTWFrZWZpbGUu
YW0KPiArKysgYi90ZXN0cy9yZWdyZXNzaW9uL3VzdC9qYXZhLWp1bC9NYWtlZmlsZS5hbQo+IEBA
IC0xLDQgKzEsMyBAQAo+IC1pZiBCVUlMRF9KQVZBX0FHRU5UCj4KPiAgbm9pbnN0X1NDUklQVFMg
PSB0ZXN0X2phdmFfanVsIEpUZXN0TFRUbmcuamF2YQo+ICBFWFRSQV9ESVNUID0gdGVzdF9qYXZh
X2p1bCBKVGVzdExUVG5nLmphdmEKPiBAQCAtMTEsMjAgKzEwLDI1IEBAIGVuZGlmCj4KPiAgQUdF
TlRfSkFSX0ZJTEU9JChqYXZhX2FnZW50X2phcl9wYXRoKQo+Cj4gLWFsbC1sb2NhbDogSlRlc3RM
VFRuZy5jbGFzcwo+Cj4gKyMgU3RpbGwgbmVlZCB0byBjb3B5IHRlc3QgZmlsZXMgaW4gY2FzZSBv
ZiBvdXQgb2YgdHJlZSBidWlsZAo+ICtpZiBCVUlMRF9KQVZBX0FHRU5UCj4gK2FsbC1sb2NhbDog
c3RhdGljX2ZpbGUgSlRlc3RMVFRuZy5jbGFzcwo+ICAlLmNsYXNzOiAlLmphdmEKPiAgICAgICAg
ICQoSkNDKSAtZCAiJChidWlsZGRpcikiIC1jcCAiJChBR0VOVF9KQVJfRklMRSk6LiIgJDwKPiAr
ZWxzZQo+ICthbGwtbG9jYWw6IHN0YXRpY19maWxlCj4gK2VuZGlmICMgQlVJTERfSkFWQV9BR0VO
VAo+Cj4gLUpUZXN0TFRUbmcuY2xhc3M6IEpUZXN0TFRUbmcuamF2YQo+Cj4gLWFsbC1sb2NhbDoK
PiArc3RhdGljX2ZpbGU6Cj4gICAgICAgICBAaWYgWyB4IiQoc3JjZGlyKSIgIT0geCIkKGJ1aWxk
ZGlyKSIgXTsgdGhlbiBcCj4gICAgICAgICAgICAgICAgIGZvciBzY3JpcHQgaW4gJChFWFRSQV9E
SVNUKTsgZG8gXAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNwIC1mICQoc3JjZGlyKS8kJHNj
cmlwdCAkKGJ1aWxkZGlyKTsgXAo+ICAgICAgICAgICAgICAgICBkb25lOyBcCj4gICAgICAgICBm
aQo+Cj4gKwo+ICBjbGVhbi1sb2NhbDoKPiAgICAgICAgIHJtIC1mICouY2xhc3MKPiAgICAgICAg
IEBpZiBbIHgiJChzcmNkaXIpIiAhPSB4IiQoYnVpbGRkaXIpIiBdOyB0aGVuIFwKPiBAQCAtMzMs
NCArMzcsMyBAQCBjbGVhbi1sb2NhbDoKPiAgICAgICAgICAgICAgICAgZG9uZTsgXAo+ICAgICAg
ICAgZmkKPgo+IC1lbmRpZiAjIEJVSUxEX0pBVkFfQUdFTlQKPiAtLQo+IDEuOS4xCj4KCgoKLS0g
CkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNv
bQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
