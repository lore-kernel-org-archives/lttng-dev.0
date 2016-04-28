From: Yuxin Ren <ryx@gwmail.gwu.edu>
Subject: Re: Question about lock in synchronize_rcu
	implementation of URCU
Date: Wed, 27 Apr 2016 22:18:04 -0400
Message-ID: <CAAKbDrfRMKzu6brHG=pfm0mu_Oy1afVZ94zDCiN7Y0w5o+SMZQ__1853.91183845258$1461809905$gmane$org@mail.gmail.com>
References: <CAAKbDrfmcqEE7_6p_J0DPVO85yDGJ0GCbi5k9Lm19g4VaLgOWw@mail.gmail.com>
 <20160428020803.GN4967@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com
 [209.85.215.52])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id AC624A32BC
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 02:18:05 +0000 (UTC)
Received: by mail-lf0-f52.google.com with SMTP id j11so78374647lfb.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 19:18:05 -0700 (PDT)
In-Reply-To: <20160428020803.GN4967@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

QXMgdGhleSBkb24ndCBjdXJyZW50bHkgcGVyZm9ybSBncmFjZSBwZXJpb2QsIHdoeSBkbyB3ZSB1
c2UgdGhlIHJjdV9ncF9sb2NrPwoKVGhhbmsgeW91LgpZdXhpbgoKT24gV2VkLCBBcHIgMjcsIDIw
MTYgYXQgMTA6MDggUE0sIFBhdWwgRS4gTWNLZW5uZXkKPHBhdWxtY2tAbGludXgudm5ldC5pYm0u
Y29tPiB3cm90ZToKPiBPbiBXZWQsIEFwciAyNywgMjAxNiBhdCAwOTozNDoxNlBNIC0wNDAwLCBZ
dXhpbiBSZW4gd3JvdGU6Cj4+IEhpLAo+Pgo+PiBJIGFtIGxlYXJuaW5nIHRoZSBVUkNVIGNvZGUu
Cj4+Cj4+IFdoeSBkbyB3ZSBuZWVkIHJjdV9ncF9sb2NrIGluIHN5bmNocm9uaXplX3JjdT8KPj4g
aHR0cHM6Ly9naXRodWIuY29tL3VyY3UvdXNlcnNwYWNlLXJjdS9ibG9iL21hc3Rlci91cmN1LmMj
TDQwMQo+Pgo+PiBJbiB0aGUgY29tbWVudCwgaXQgc2F5cyB0aGlzIGxvY2sgZW5zdXJlcyBtdXR1
YWwgZXhjbHVzaW9uIGJldHdlZW4KPj4gdGhyZWFkcyBjYWxsaW5nIHN5bmNocm9uaXplX3JjdSgp
Lgo+PiBCdXQgb25seSB0aGUgZmlyc3QgdGhyZWFkIGFkZGVkIHRvIHdhaXRlciBxdWV1ZSBjYW4g
cHJvY2VlZCB0byBkZXRlY3QKPj4gZ3JhY2UgcGVyaW9kLgo+PiBIb3cgY2FuIG11bHRpcGxlIHRo
cmVhZHMgY3VycmVudGx5IHBlcmZvcm0gdGhlIGdyYWNlIHRocmVhZD8KPgo+IFRoZXkgZG9uJ3Qg
Y29uY3VycmVudGx5IHBlcmZvcm0gZ3JhY2UgcGVyaW9kcywgYW5kIGl0IHdvdWxkIGJlIHdhc3Rl
ZnVsCj4gZm9yIHRoZW0gdG8gZG8gc28uICBJbnN0ZWFkLCB0aGUgZmlyc3Qgb25lIHBlcmZvcm1z
IHRoZSBncmFjZSBwZXJpb2QsCj4gYW5kIGFsbCB0aGF0IHdlcmUgd2FpdGluZyBhdCB0aGUgdGlt
ZSBpdCBzdGFydGVkIGdldCB0aGUgYmVuZWZpdCBvZiB0aGF0Cj4gc2FtZSBncmFjZSBwZXJpb2Qu
Cj4KPiBBbnkgdGhhdCBhcnJpdmVkIGFmdGVyIHRoZSBmaXJzdCBncmFjZSBwZXJpb2QgcGVyZm9y
bXMgdGhlIGZpcnN0Cj4gZ3JhY2UgcGVyaW9kIGFyZSBzZXJ2ZWQgYnkgd2hpY2hldmVyIG9mIHRo
ZW0gcGVyZm9ybXMgdGhlIHNlY29uZAo+IGdyYWNlIHBlcmlvZC4KPgo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhhbngsIFBhdWwKPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRu
Zy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
