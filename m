From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: save: close fd of
	configuration file
Date: Tue, 18 Oct 2016 18:13:22 -0400
Message-ID: <44dcc94a-bee7-cfd0-1c79-4b2dd3998035__32871.8243785717$1476828828$gmane$org@efficios.com>
References: <1476828593-8761-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C1816A43AC
 for <lttng-dev@lists.lttng.org>; Tue, 18 Oct 2016 22:15:25 +0000 (UTC)
In-Reply-To: <1476828593-8761-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

SGksCgpUaGlzIHNob3VsZCBiZSBiYWNrcG9ydGVkIHRvIDIuOSwyLjgsMi43LgoKVGhhbmtzCgpP
biAyMDE2LTEwLTE4IDA2OjA5IFBNLCBKb25hdGhhbiBSYWpvdHRlIHdyb3RlOgo+IFNpZ25lZC1v
ZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9z
LmNvbT4KPiAtLS0KPiAgIHNyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc2F2ZS5jICAgICAgfCA3ICsr
KysrKysKPiAgIHNyYy9jb21tb24vY29uZmlnL3Nlc3Npb24tY29uZmlnLmggfCA0ICsrLS0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQvc2F2ZS5jIGIvc3JjL2Jpbi9sdHRuZy1z
ZXNzaW9uZC9zYXZlLmMKPiBpbmRleCA5YWM3NzEyLi4xYTg3OWIyIDEwMDY0NAo+IC0tLSBhL3Ny
Yy9iaW4vbHR0bmctc2Vzc2lvbmQvc2F2ZS5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy1zZXNzaW9u
ZC9zYXZlLmMKPiBAQCAtMjA1Myw2ICsyMDUzLDEzIEBAIGVuZDoKPiAgIAkJfQo+ICAgCX0KPiAg
IAo+ICsJaWYgKGZpbGVfb3BlbmVkKSB7Cj4gKwkJcmV0ID0gY2xvc2UoZmQpOwo+ICsJCWlmIChy
ZXQpIHsKPiArCQkJUEVSUk9SKCJDbG9zaW5nIFhNTCBzZXNzaW9uIGNvbmZpZ3VyYXRpb24iKTsK
PiArCQl9Cj4gKwl9Cj4gKwo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiBkaWZmIC0tZ2l0
IGEvc3JjL2NvbW1vbi9jb25maWcvc2Vzc2lvbi1jb25maWcuaCBiL3NyYy9jb21tb24vY29uZmln
L3Nlc3Npb24tY29uZmlnLmgKPiBpbmRleCBjNjQzOWY3Li5mNDhmZjc0IDEwMDY0NAo+IC0tLSBh
L3NyYy9jb21tb24vY29uZmlnL3Nlc3Npb24tY29uZmlnLmgKPiArKysgYi9zcmMvY29tbW9uL2Nv
bmZpZy9zZXNzaW9uLWNvbmZpZy5oCj4gQEAgLTg1LDggKzg1LDggQEAgaW50IGNvbmZpZ19wYXJz
ZV92YWx1ZShjb25zdCBjaGFyICp2YWx1ZSk7Cj4gICAvKgo+ICAgICogQ3JlYXRlIGFuIGluc3Rh
bmNlIG9mIGEgY29uZmlndXJhdGlvbiB3cml0ZXIuCj4gICAgKgo+IC0gKiBmZF9vdXRwdXQgRmls
ZSB0byB3aGljaCB0aGUgWE1MIGNvbnRlbnQgbXVzdCBiZSB3cml0dGVuLiBUaGUgZmlsZSB3aWxs
IGJlCj4gLSAqIGNsb3NlZCBvbmNlIHRoZSBjb25maWdfd3JpdGVyIGhhcyBiZWVuIGRlc3Ryb3ll
ZC4KPiArICogZmRfb3V0cHV0IEZpbGUgdG8gd2hpY2ggdGhlIFhNTCBjb250ZW50IG11c3QgYmUg
d3JpdHRlbi4gZmRfb3V0cHV0IGlzCj4gKyAqIG93bmVkIGJ5IHRoZSBjYWxsZXIuCj4gICAgKgo+
ICAgICogaW5kZW50IElmIG90aGVyIHRoYW4gMCB0aGUgWE1MIHdpbGwgYmUgcHJldHR5IHByaW50
ZWQKPiAgICAqIHdpdGggaW5kZW50YXRpb24gYW5kIG5ld2xpbmUuCgotLSAKSm9uYXRoYW4gUi4g
SnVsaWVuCkVmZmljaW9zCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
