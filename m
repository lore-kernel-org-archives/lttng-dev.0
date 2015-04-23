From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Crash on 3.19.3 kernel
Date: Thu, 23 Apr 2015 22:33:14 +0000 (UTC)
Message-ID: <1809081385.35324.1429828394309.JavaMail.zimbra__6239.15514811433$1429828462$gmane$org@efficios.com>
References: <552FFEE4.9010101@gmail.com>
 <CAFXXi0kR3Lb_LehT-Yid6SqaLwG8ZnXqfS+dSc+4EGZde97jow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YlPgK-0001fl-Qa
 for lttng-dev@lists.lttng.org; Thu, 23 Apr 2015 18:33:25 -0400
In-Reply-To: <CAFXXi0kR3Lb_LehT-Yid6SqaLwG8ZnXqfS+dSc+4EGZde97jow@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: =?utf-8?Q?S=C3=A9bastien?= Lorrain <sebastien.lorrain01@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SXQgc2hvdWxkIGJlIGZpeGVkIG5vdywgY2FuIHlvdSBjb25maXJtID8KClRoYW5rcywKCk1hdGhp
ZXUKCi0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPiBPbiAxNiBBcHJpbCAyMDE1IGF0IDE0
OjI2LCBTw6liYXN0aWVuIExvcnJhaW4KPiA8c2ViYXN0aWVuLmxvcnJhaW4wMUBnbWFpbC5jb20+
IHdyb3RlOgo+ID4gSGVsbG8gTFRUbmcgZm9sa3MsCj4gPgo+ID4gSSdhbSB1c2luZyBBcmNobGlu
dXggd2l0aCBzdG9jayAzLjE5LjMga2VybmVsIGFuZCBJJ2FtIGV4cGVyaWVuY2luZyBhIGNyYXNo
Cj4gPiB3aXRoIHRoZSBsYXRlc3QgYW5kIGdyZWF0ZXN0IGx0dG5nLgo+ID4gSSBjb21waWxlZCBs
dHRuZy10b29scyB3aXRob3V0IFVTVCBzdXBwb3J0Lgo+ID4KPiA+ICR1bmFtZSAtYQo+ID4gTGlu
dXggcmVkd2luZCAzLjE5LjMtMy1BUkNIICMxIFNNUCBQUkVFTVBUIFdlZCBBcHIgOCAxNDoxMDow
MCBDRVNUIDIwMTUKPiA+IHg4Nl82NCBHTlUvTGludXgKPiA+Cj4gPiBIZXJlJ3MgdGhlIGNvbXBp
bGUgbG9nIG9mIGx0dG5nLW1vZHVsZXMgOgo+ID4gaHR0cDovL3Bhc3RlLnVidW50dS5jb20vMTA4
MzQwMDcvCj4gPgo+ID4gSSBub3RpY2VkIEknYW0gbWlzc2luZyAgQ09ORklHX0tBTExTWU1TX0FM
TCwgYnV0IEkgZG9uJ3Qga25vdyBpZiBpdCBpcwo+ID4gcmVhbGx5IHJlbGV2YW50IGFzIGx0dG5n
LW1vZHVsZXMgMi42IHdhcyBydW5uaW5nIGZpbmUgd2l0aG91dCBpdC4KPiA+Cj4gPiBIZXJlJ3Mg
dGhlIHN5c2xvZy9qb3VybmFsIGFmdGVyIGEgY3Jhc2ggKG9uIGEgdGVzdCBWTSkKPiA+IGh0dHA6
Ly9wYXN0ZS51YnVudHUuY29tLzEwODMzODczLwo+ID4KPiA+IEFueSBoZWxwIGluIGRlYnVnZ2lu
ZyB0aGF0IHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQhCj4gPgo+ID4gVGhhbmtzIQo+ID4g
THJvdWdlLwo+ID4gU2ViYXN0aWVuIExvcnJhaW4uCj4gCj4gCj4gSGkgU8OpYmFzdGllbiwKPiAK
PiBJIGNhbiByZXByb2R1Y2UgdGhpcyBhcyB3ZWxsLiBJIHN1Z2dlc3QgeW91IGZpbGUgYSBidWcK
PiAoaHR0cDovL2J1Z3MubHR0bmcub3JnL3Byb2plY3RzL2x0dG5nLW1vZHVsZXMpLCBzbyB0aGF0
IHRoZSBpc3N1ZSBpcwo+IHRyYWNrZWQgYW5kIGZpeGVkIGJlZm9yZSB0aGUgbmV4dCByZWxlYXNl
Lgo+IAo+IFNpbW9uCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwo+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo+IAoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3
dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
