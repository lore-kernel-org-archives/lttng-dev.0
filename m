From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RFC v2] Add kmalloc failover to vmalloc
Date: Thu, 21 Sep 2017 14:43:19 -0400
Message-ID: <73494ae7-dd98-4069-6b2c-49fad21698ca__49148.2646241367$1506019409$gmane$org@efficios.com>
References: <1506018582-22403-1-git-send-email-mjeanson@efficios.com>
 <1705207820.15923.1506019177110.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xylqX6XbdzC4C
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 18:43:20 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 419FF34020B
 for <lttng-dev@lists.lttng.org>; Thu, 21 Sep 2017 18:44:16 +0000 (UTC)
In-Reply-To: <1705207820.15923.1506019177110.JavaMail.zimbra@efficios.com>
Content-Language: en-CA
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNy0wOS0yMSAxNDozOSwgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6Cj4gLS0tLS0gT24g
U2VwIDIxLCAyMDE3LCBhdCAyOjI5IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNp
b3MuY29tIHdyb3RlOgo+IAo+PiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBrdm1hbGxvYyBo
ZWxwZXJzIGludHJvZHVjZWQgaW4ga2VybmVsIDQuMTIuCj4+Cj4+IEl0IHdpbGwgZ3JhY2VmdWxs
eSBmYWlsb3ZlciBtZW1vcnkgYWxsb2NhdGlvbnMgb2YgbW9yZSB0aGFuIG9uZSBwYWdlIHRvCj4+
IHZtYWxsb2MgZm9yIHN5c3RlbXMgdW5kZXIgaGlnaCBtZW1vcnkgcHJlc3N1cmUgb3IgZnJhZ21l
bnRhdGlvbi4KPj4KPj4gSSBvbmx5IHVzZWQgaXQgaW4gbHR0bmctZXZlbnRzLmMgYXMgYSBQT0Ms
IG1vc3QgYWxsb2NhdGlvbnMgZml0IGludG8gYQo+PiBzaW5nbGUgcGFnZSBzbyBJJ20gbm90IHN1
cmUgaG93IHVzZWZ1bCB0aGlzIGFjdHVhbGx5IGlzLgo+Pgo+PiBUaG91Z2h0cz8KPiAKPiBKdXN0
IHVwZGF0ZSB0aGUgY2hhbmdlbG9nIHRvIHNwZWNpZnkgd2h5IHdlIG5lZWQgdGhpcyBmb3Igc3Ry
dWN0IGx0dG5nX3Nlc3Npb24KPiAofjMya0IpLCBhbmQgeW91IGNhbiBzdWJtaXQgaXQgZm9yIGdv
b2Qgd2l0aCBhICJGaXg6ICIgdGFnLgoKSSdtIG5vdCBzdXJlIGl0IHNob3VsZCBiZSBhIGZpeCwg
Zm9yIHRoaXMgdG8gYmUgb2YgYW55IHVzZSBhbGwgdGhlIG90aGVyCmFsbG9jYXRpb25zIGJpZ2dl
ciB0aGFuIFBBR0VfU0laRSBzaG91bGQgYWxzbyB1c2UgaXQuIE90aGVyd2lzZSwgdGhlCnNlc3Np
b24gYWxsb2NhdGlvbiB3aWxsIHN1Y2NlZWQgYnV0IHRoZSBuZXh0IHNpemVhYmxlIGFsbG9jYXRp
b24gd2lsbApzdGlsbCBmYWlsLgoKPiAKPiBUaGFua3MsCj4gCj4gTWF0aGlldQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBs
aXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dp
LWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
