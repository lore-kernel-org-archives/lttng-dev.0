From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: libbabeltrace: getting CTF sequence length?
Date: Tue, 20 May 2014 16:50:20 -0400
Message-ID: <CA+jJMxsS1P4ra7m_UcTy5k_ddGDea-ZzPf9wBR245_UEmHHKRg__47393.6008093462$1400619099$gmane$org@mail.gmail.com>
References: <CAB4xu_1n75_qATZ=Li19VnzGghojAOOQv+U4z9x+qVWHU154vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1WmqzS-0003z3-KM
 for lttng-dev@lists.lttng.org; Tue, 20 May 2014 16:50:34 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so1669229qcy.8
 for <lttng-dev@lists.lttng.org>; Tue, 20 May 2014 13:50:21 -0700 (PDT)
In-Reply-To: <CAB4xu_1n75_qATZ=Li19VnzGghojAOOQv+U4z9x+qVWHU154vg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBNYXkgMjAsIDIwMTQgYXQgNDozNyBQTSwgUGhpbGlwcGUgUHJvdWx4CjxlZXBwZWxp
dGVsb29wQGdtYWlsLmNvbT4gd3JvdGU6Cj4gSGVsbG8sCj4KPiBJJ20gdXNpbmcgbGliYmFiZWx0
cmFjZSBpbiBDKysuIEkgd291bGQgbGlrZSB0byBrbm93IGlmIHRoZXJlJ3MgYW4KPiBlcXVpdmFs
ZW50IG9mIGJ0X2N0Zl9nZXRfYXJyYXlfbGVuKCkgZm9yIHNlcXVlbmNlcy4gSSB0cmllZCB1c2lu
Zwo+IGJ0X2N0Zl9nZXRfZmllbGRfbGlzdCgpIGJ1dCB0aGUgcmVwb3J0ZWQgY291bnQgd2FzIDEw
LCB3aGVyZWFzIHRoZQo+IHNlcXVlbmNlIGxlbmd0aCB3YXMgcmVhbGx5IDYgKGFzIHNob3duIGJ5
IHRoZSBiYWJlbHRyYWNlIHRvb2wpLAo+IGxlYWRpbmcgdG8gYSBzZWdmYXVsdCB3aGVuIGFjY2Vz
c2luZyB0aGUgN3RoIGVsZW1lbnQuCj4KPiBMb29raW5nIGF0IHRoZSBQeXRob24gYmluZGluZywg
SSBzZWUgdGhhdCB0aGlzIGlzIHVzZWQ6Cj4KPiAgICAgY29udGFpbmVyX29mKGZpZWxkLCBzdHJ1
Y3QgZGVmaW5pdGlvbl9zZXF1ZW5jZSwgcCk7Cj4KPiBmb2xsb3dlZCBieSBidF9zZXF1ZW5jZV9s
ZW4oKS4gSG93ZXZlciwgc3RydWN0IGRlZmluaXRpb25fc2VxdWVuY2UsCj4gYnRfc2VxdWVuY2Vf
bGVuKCkgKGFuZCBidF9zZXF1ZW5jZV9pbmRleCgpKSBhcmUgbm90IGF2YWlsYWJsZSBpbgo+IHRo
ZSBBUEkuCj4KPiBTbyB3aGF0IHdvdWxkIGJlIHlvdXIgd2F5IHRvIHJlYWQgc2VxdWVuY2UgaXRl
bXM/IERvIHlvdSBoYXZlCj4gYW4gZXhhbXBsZSB1c2luZyBzdHJpY3RseSB3aGF0J3MgYXZhaWxh
YmxlIGluIC91c3IvaW5jbHVkZS9iYWJlbHRyYWNlPwo+CgpidF9jdGZfZ2V0X2ZpZWxkX2xpc3Qg
Y2FuIGJlIHVzZWQgdG8gZ2V0IHRoZSBudW1iZXIgb2YgZWxlbWVudHMsIGFsb25nCndpdGggYSBw
b2ludGVyIHRvIHRoZSBlbGVtZW50cyAodmlhIHRoZSBvdXRwdXQgcGFyYW1ldGVycykuCgpSZWdh
cmRzLApKw6lyw6ltaWUKCj4gSSdtIHVzaW5nIHRoZSBsYXRlc3QgR2l0IG1hc3RlciBvbiBBcmNo
IExpbnV4Lgo+Cj4gVGhhbmsgeW91IQo+Cj4gUGhpbGlwcGUgUHJvdWx4Cj4KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
