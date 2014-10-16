From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: preserve example files'
 timestamps when copying
Date: Thu, 16 Oct 2014 13:48:49 +0000 (UTC)
Message-ID: <370711573.10362.1413467329274.JavaMail.zimbra__26560.9994101853$1413467386$gmane$org@efficios.com>
References: <1413467119-18187-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XelQL-0008Sc-7i
 for lttng-dev@lists.lttng.org; Thu, 16 Oct 2014 09:49:02 -0400
In-Reply-To: <1413467119-18187-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4g
RnJvbTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5j
b20+Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBDYzogIm1hdGhpZXUgZGVzbm95
ZXJzIiA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3MuY29tPiwgIkrDqXLDqW1pZSBHYWxhcm5l
YXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4gU2VudDogVGh1cnNkYXksIE9j
dG9iZXIgMTYsIDIwMTQgMzo0NToxOSBQTQo+IFN1YmplY3Q6IFtQQVRDSCBsdHRuZy11c3RdIEZp
eDogcHJlc2VydmUgZXhhbXBsZSBmaWxlcycgdGltZXN0YW1wcyB3aGVuIGNvcHlpbmcKPiAKPiBU
aGlzIGZpeGVzIGFuIGlzc3VlIHdoZXJlIGV4YW1wbGVzIHdlcmUgYWx3YXlzIGJlaW5nIHJlYnVp
bHQKPiB3aGVuIHBlcmZvcm1pbmcgYW4gb3V0IG9mIHRyZWUgYnVpbGQgc2luY2UgdGhlIGV4YW1w
bGVzIHdlcmUKPiBiZWluZyBjb3BpZWQgdG8gdGhlIGJ1aWxkIGRpcmVjdG9yeSB3aXRoIGEgdGlt
ZXN0YW1wIG1vcmUKPiByZWNlbnQgdGhhbiB0aGUgYWxyZWFkeS1idWlsdCBleGFtcGxlIG9iamVj
dHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxh
cm5lYXVAZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBkb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0gfCAy
ICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9kb2MvZXhhbXBsZXMvTWFrZWZpbGUuYW0gYi9kb2MvZXhhbXBsZXMvTWFr
ZWZpbGUuYW0KPiBpbmRleCBmYmFiYjhlLi42ZjBhMzFhIDEwMDY0NAo+IC0tLSBhL2RvYy9leGFt
cGxlcy9NYWtlZmlsZS5hbQo+ICsrKyBiL2RvYy9leGFtcGxlcy9NYWtlZmlsZS5hbQo+IEBAIC01
Nyw3ICs1Nyw3IEBAIGVuZGlmCj4gIGFsbC1sb2NhbDoKPiAgCUBpZiBbIHgiJChzcmNkaXIpIiAh
PSB4IiQoYnVpbGRkaXIpIiBdOyB0aGVuIFwKPiAgCQlmb3Igc3ViZGlyIGluICQoU1VCRElSU19Q
Uk9YWSkgJChTVUJESVJTX0pVTCk7IGRvIFwKPiAtCQkJY3AgLWZSICQoc3JjZGlyKS8kJHN1YmRp
ciAkKGJ1aWxkZGlyKTsgXAo+ICsJCQljcCAtcGZSICQoc3JjZGlyKS8kJHN1YmRpciAkKGJ1aWxk
ZGlyKTsgXAo+ICAJCWRvbmU7IFwKPiAgCWZpOyBcCj4gIAlpZiBbIHgiJChzaGVsbCBlY2hvICIk
KHRvcF9zcmNkaXIpIiB8IGdyZXAgIl4vIiB8IHdjIC1sKSIgPSB4IjEiIF07IHRoZW4gXAo+IC0t
Cj4gMi4xLjIKPiAKPiAKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
