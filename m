From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu lfht and free listing
Date: Fri, 10 Jun 2016 18:22:16 +0000 (UTC)
Message-ID: <149868690.33139.1465582936951.JavaMail.zimbra__35513.7967890643$1465582963$gmane$org@efficios.com>
References: <BF41A9C3-FD22-4AF7-80DC-C172C252B92C@indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 87993A3816
 for <lttng-dev@lists.lttng.org>; Fri, 10 Jun 2016 18:22:21 +0000 (UTC)
In-Reply-To: <BF41A9C3-FD22-4AF7-80DC-C172C252B92C@indiana.edu>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gSnVuIDEwLCAyMDE2LCBhdCA2OjU4IEFNLCBEJ0FsZXNzYW5kcm8sIEx1a2UgSyBs
ZGFsZXNzYUBpbmRpYW5hLmVkdSB3cm90ZToKCj4gSGkgTGlzdCwKPiAKPiBJcyBpdCBzYWZlIHRv
IGZyZWUgbGlzdCBhbmQgcmV1c2UgaGFzaCB0YWJsZSBub2RlcyAoY2RzX2xmaHRfbm9kZSBzdHJ1
Y3R1cmVzCj4gdXNlZCBpbiBjZHNfbGZodF9hZGRfcmVwbGFjZSwgY2RzX2xmaHRfaXRlcl9nZXRf
bm9kZS9jZHNfbGZodF9kZWwpIHdpdGhvdXQKPiBnb2luZyB0aHJvdWdoIGEgc3luY2hyb25pemVf
cmN1KCkgYmFycmllcj8KCkhpLAoKTm8sIGl0IGlzIG5vdCBzYWZlLgoKRnJvbSByY3VsZmhhc2gu
aDoKCmNkc19sZmh0X2RlbDoKCiAqIEFmdGVyIHN1Y2Nlc3NmdWwgcmVtb3ZhbCwgYSBncmFjZSBw
ZXJpb2QgbXVzdCBiZSB3YWl0ZWQgZm9yIGJlZm9yZQogKiBmcmVlaW5nIHRoZSBtZW1vcnkgcmVz
ZXJ2ZWQgZm9yIG9sZCBub2RlICh3aGljaCBjYW4gYmUgYWNjZXNzZWQgd2l0aAogKiBjZHNfbGZo
dF9pdGVyX2dldF9ub2RlKS4KCmNkc19sZmh0X2FkZF9yZXBsYWNlOgoKICogQWZ0ZXIgc3VjY2Vz
c2Z1bCByZXBsYWNlbWVudCwgYSBncmFjZSBwZXJpb2QgbXVzdCBiZSB3YWl0ZWQgZm9yIGJlZm9y
ZQogKiBmcmVlaW5nIHRoZSBtZW1vcnkgcmVzZXJ2ZWQgZm9yIHRoZSByZXR1cm5lZCBub2RlLgoK
Y2RzX2xmaHRfcmVwbGFjZToKCiAqIEFmdGVyIHN1Y2Nlc3NmdWwgcmVwbGFjZW1lbnQsIGEgZ3Jh
Y2UgcGVyaW9kIG11c3QgYmUgd2FpdGVkIGZvciBiZWZvcmUKICogZnJlZWluZyB0aGUgbWVtb3J5
IHJlc2VydmVkIGZvciB0aGUgb2xkIG5vZGUgKHdoaWNoIGNhbiBiZSBhY2Nlc3NlZAogKiB3aXRo
IGNkc19sZmh0X2l0ZXJfZ2V0X25vZGUpLgoKWW91IGNhbiBlaXRoZXIgaW52b2tlIHN5bmNocm9u
aXplX3JjdSgpIGJlZm9yZSByZS11c2luZyBvciBmcmVlaW5nCnRoZSByZW1vdmVkIG5vZGUsIG9y
IHVzZSB0aGUgY2FsbF9yY3UoKSBvciBkZWZlcl9yY3UoKSBtZWNoYW5pc21zIHRvCmRlZmVyIHJl
Y2xhaW0gYWZ0ZXIgYSBncmFjZSBwZXJpb2QgKGhhbmRsZWQgYnkgd29ya2VyIHRocmVhZHMpLgoK
VGhhbmtzLAoKTWF0aGlldQoKPiAKPiBUaGFua3MsCj4gTHVrZQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+
IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgotLSAKTWF0aGlldSBEZXNub3llcnMKRWZm
aWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
