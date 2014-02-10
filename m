From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: Define
 __STDC_LIMIT_MACROS	to fix C++ builds
Date: Mon, 10 Feb 2014 17:55:28 +0000 (UTC)
Message-ID: <940168140.22070.1392054927992.JavaMail.zimbra__6863.1533570171$1392054995$gmane$org@efficios.com>
References: <2121067902.21017.1391874228506.JavaMail.zimbra@efficios.com>
	<1392048262-17049-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WCv4t-0000vm-JS
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 12:55:37 -0500
In-Reply-To: <1392048262-17049-1-git-send-email-jeremie.galarneau@efficios.com>
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
b20+CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkrDqXLDqW1pZSBHYWxh
cm5lYXUiIDxqZXJlbWllLmdhbGFybmVhdUBlZmZpY2lvcy5jb20+Cj4gVG86IGx0dG5nLWRldkBs
aXN0cy5sdHRuZy5vcmcKPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDEwLCAyMDE0IDExOjA0OjIy
IEFNCj4gU3ViamVjdDogW2x0dG5nLWRldl0gW1BBVENIIGx0dG5nLXRvb2xzIHYyXSBGaXg6IERl
ZmluZSBfX1NURENfTElNSVRfTUFDUk9TCXRvIGZpeCBDKysgYnVpbGRzCj4gCj4gTmVjZXNzYXJ5
IHRvIGluY2x1ZGUgdGhlIGZpeGVkLXdpZHRoIHR5cGUgbGltaXRzIG9uIGdsaWJjIHZlcnNpb25z
Cj4gb2xkZXIgdGhhbiAyLjE4IHdoZW4gYnVpbGRpbmcgd2l0aCBhIEMrKyBjb21waWxlci4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBKw6lyw6ltaWUgR2FsYXJuZWF1IDxqZXJlbWllLmdhbGFybmVhdUBl
ZmZpY2lvcy5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbHR0bmcvbHR0bmcuaCB8IDEwICsrKysrKysr
KysKPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9sdHRuZy9sdHRuZy5oIGIvaW5jbHVkZS9sdHRuZy9sdHRuZy5oCj4gaW5kZXggMThk
ZWMyYS4uZjBiZTIyNCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2x0dG5nL2x0dG5nLmgKPiArKysg
Yi9pbmNsdWRlL2x0dG5nL2x0dG5nLmgKPiBAQCAtMjMsNyArMjMsMTcgQEAKPiAgI2RlZmluZSBM
VFROR19ICj4gIAo+ICAjaW5jbHVkZSA8bGltaXRzLmg+Cj4gKy8qCj4gKyAqIE5lY2Vzc2FyeSB0
byBpbmNsdWRlIHRoZSBmaXhlZCB3aWR0aCB0eXBlIGxpbWl0cyBvbiBnbGliYyB2ZXJzaW9ucyBv
bGRlcgo+ICsgKiB0aGFuIDIuMTggd2hlbiBidWlsZGluZyB3aXRoIGEgQysrIGNvbXBpbGVyLgo+
ICsgKi8KPiArI2lmbmRlZiBfX1NURENfTElNSVRfTUFDUk9TCj4gKyNkZWZpbmUgX19TVERDX0xJ
TUlUX01BQ1JPUwo+ICsjaW5jbHVkZSA8c3RkaW50Lmg+Cj4gKyN1bmRlZiBfX1NURENfTElNSVRf
TUFDUk9TCj4gKyNlbHNlIC8qICNpZm5kZWYgX19TVERDX0xJTUlUX01BQ1JPUyAqLwo+ICAjaW5j
bHVkZSA8c3RkaW50Lmg+Cj4gKyNlbmRpZiAvKiAjZWxzZSAjaWZuZGVmIF9fU1REQ19MSU1JVF9N
QUNST1MgKi8KPiAgI2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ICAKPiAgLyogRXJyb3IgY29kZXMg
dGhhdCBjYW4gYmUgcmV0dXJuZWQgYnkgQVBJIGNhbGxzICovCj4gLS0KPiAxLjguNS40Cj4gCj4g
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHA6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+IAoKLS0g
Ck1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
