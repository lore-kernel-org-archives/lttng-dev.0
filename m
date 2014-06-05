From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Debian specific userspace RCU configure override
Date: Thu, 5 Jun 2014 19:11:16 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359B9A4B__31317.5734169365$1401996292$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD359B89C8@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <161918991.27343.1401990893978.JavaMail.zimbra@efficios.com>
 <48CF5AC71E61DB46B70D0F388054EFFD359B99F4@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <385986525.27497.1401994835470.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Wsd4N-0003Yy-BI
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 15:11:28 -0400
In-Reply-To: <385986525.27497.1401994835470.JavaMail.zimbra@efficios.com>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

LS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQpEZcKgOiBNYXRoaWV1IERlc25veWVycyBbbWFp
bHRvOm1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbV0gDQpFbnZvecOpwqA6IDUganVpbiAy
MDE0IDE1OjAxDQoNCj4+Pj4gICAgVGhlIG1ha2UgZXJyb3Igb2NjdXJzIGR1cmluZyB0aGUgQ0NM
RCBvZiBsaWJyaW5nYnVmZmVyLmxhLg0KDQogICBDb3JyZWN0aW9uOiBpdCBvY2N1cnMgZHVyaW5n
IHRoZSBDQyBvZiBsaWJyaW5nYnVmZmVyX2xhLXJpbmdfYnVmZmVyX2Zyb250ZW5kLmxvDQoNCj4+
ICAgIEJvdGggL3Vzci9sb2NhbC9pbmNsdWRlL3VyY3UvY29uZmlnLmggYW5kIC91c3Ivc3JjL3Vz
ZXJzcGFjZS1yY3UtMC44LjAvdXJjdS9jb25maWcuaCBoYXZlICcjZGVmaW5lDQo+PiAgICBDT05G
SUdfUkNVX0FSTV9IQVZFX0RNQiAxJy4gIFNvIGRvZXMgL3Vzci9zcmMvdXNlcnNwYWNlLXJjdS0w
LjguMC9jb25maWcuaC4gIFRoZSBvbmx5IGNvbmZpZy5oICpub3QqIHRvIGhhdmUNCj4+ICAgIHRo
YXQgI2RlZmluZSBpcyAvdXNyL3NyYy9sdHRuZy11c3QtMi4zLjAvY29uZmlnLmguICBDb3VsZCBp
dCBiZSB0aGUgbGlicmluZ2J1ZmZlciBtYWtlIHVzZWQgdGhlIGxhdHRlcj8NCj4NCj4gVGhpcyBk
ZWZpbmUgaXMgc3BlY2lmaWMgdG8gdXJjdSBjb25maWcuaC4gSXQgZG9lcyBub3QgKGFuZCBzaG91
bGQgbm90KSBleGlzdCBpbiBVU1QgY29uZmlnLmguDQo+DQo+IE1hdGhpZXUNCg0KICAgSW5kZWVk
LiAgSSB0cmllZCBhZGRpbmcgdGhlICNkZWZpbmUgbWFudWFsbHkgdG8gL3Vzci9zcmMvbHR0bmct
dXN0LTIuMy4wL2NvbmZpZy5oIGJlZm9yZSBydW5uaW5nIG1ha2UgYWdhaW4uICBJdCBmYWlsZWQg
aW4gcHJlY2lzZWx5IHRoZSBzYW1lIHdheS4gIFRoaXMgY29uZmlybXMgdGhlIHByb2JsZW0gaXMg
bm90IHdpdGggY29uZmlnLmguDQoNCkRhbmllbCBVLiBUaGliYXVsdA0KUHJvdGVjdGlvbiBkZXMg
c3lzdMOobWVzIGV0IGNvbnRyZW1lc3VyZXMgKFBTQykgfCBTeXN0ZW1zIFByb3RlY3Rpb24gJiBD
b3VudGVybWVhc3VyZXMgKFNQQykNCkN5YmVyIHPDqWN1cml0w6kgcG91ciBsZXMgbWlzc2lvbnMg
ZXNzZW50aWVsbGVzIChDTUUpIHwgTWlzc2lvbiBDcml0aWNhbCBDeWJlciBTZWN1cml0eSAoTUND
UykNClJEREMgLSBDZW50cmUgZGUgcmVjaGVyY2hlcyBkZSBWYWxjYXJ0aWVyIHwgRFJEQyAtIFZh
bGNhcnRpZXIgUmVzZWFyY2ggQ2VudHJlDQoyNDU5IHJvdXRlIGRlIGxhIEJyYXZvdXJlDQpRdcOp
YmVjIFFDICBHM0ogMVg1DQpDQU5BREENClZveCA6ICg0MTgpIDg0NC00MDAwIHg0MjQ1DQpGYXgg
OiAoNDE4KSA4NDQtNDUzOA0KTkFDIDogOTE4ViBRU0RKIDxodHRwOi8vd3d3LnRyYXZlbGdpcy5j
b20vbWFwLmFzcD9hZGRyPTkxOFYlMjBRU0RKPg0KR291dmVybmVtZW50IGR1IENhbmFkYSB8IEdv
dmVybm1lbnQgb2YgQ2FuYWRhDQo8aHR0cDovL3d3dy52YWxjYXJ0aWVyLmRyZGMtcmRkYy5nYy5j
YS8+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
