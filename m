From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Add extern C to the
 health-check	header
Date: Fri, 7 Feb 2014 03:54:26 +0000 (UTC)
Message-ID: <1517472420.20400.1391745266954.JavaMail.zimbra__11985.9537495815$1391745376$gmane$org@efficios.com>
References: <1391714036-14376-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WBcWM-0002Zz-BP
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 22:54:35 -0500
In-Reply-To: <1391714036-14376-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>, David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

QWNrZWQtYnk6IE1hdGhpZXUgRGVzbm95ZXJzIDxtYXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5j
b20+CgpUaGFua3MsCgpNYXRoaWV1CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJv
bTogIkrDqXLDqW1pZSBHYWxhcm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+
Cj4gVG86IGx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKPiBTZW50OiBUaHVyc2RheSwgRmVicnVh
cnkgNiwgMjAxNCAyOjEzOjU2IFBNCj4gU3ViamVjdDogW2x0dG5nLWRldl0gW1BBVENIIGx0dG5n
LXRvb2xzXSBBZGQgZXh0ZXJuIEMgdG8gdGhlIGhlYWx0aC1jaGVjawloZWFkZXIKPiAKPiBUaGlz
IG1ha2VzIGl0IHBvc3NpYmxlIHRvIGluY2x1ZGUgaGVhbHRoLmggaW4gYSBDKysgcHJvZ3JhbS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVh
dUBlZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbHR0bmcvaGVhbHRoLmggfCA4ICsrKysr
KysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9sdHRuZy9oZWFsdGguaCBiL2luY2x1ZGUvbHR0bmcvaGVhbHRoLmgKPiBpbmRleCA5
OTYwOTI4Li45YTdhN2ZjIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbHR0bmcvaGVhbHRoLmgKPiAr
KysgYi9pbmNsdWRlL2x0dG5nL2hlYWx0aC5oCj4gQEAgLTE5LDYgKzE5LDEwIEBACj4gICAqIElu
Yy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMw
MSBVU0EKPiAgICovCj4gIAo+ICsjaWZkZWYgX19jcGx1c3BsdXMKPiArZXh0ZXJuICJDIiB7Cj4g
KyNlbmRpZgo+ICsKPiAgc3RydWN0IGx0dG5nX2hlYWx0aDsKPiAgc3RydWN0IGx0dG5nX2hlYWx0
aF90aHJlYWQ7Cj4gIAo+IEBAIC0xMjQsNCArMTI4LDggQEAgaW50IGx0dG5nX2hlYWx0aF90aHJl
YWRfc3RhdGUoY29uc3Qgc3RydWN0Cj4gbHR0bmdfaGVhbHRoX3RocmVhZCAqdGhyZWFkKTsKPiAg
ICovCj4gIGNvbnN0IGNoYXIgKmx0dG5nX2hlYWx0aF90aHJlYWRfbmFtZShjb25zdCBzdHJ1Y3Qg
bHR0bmdfaGVhbHRoX3RocmVhZAo+ICAqdGhyZWFkKTsKPiAgCj4gKyNpZmRlZiBfX2NwbHVzcGx1
cwo+ICt9Cj4gKyNlbmRpZgo+ICsKPiAgI2VuZGlmIC8qIExUVE5HX0hFQUxUSF9IICovCj4gLS0K
PiAxLjguNS4yCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwo+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo+IAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
