From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: LTTng and multiple kernels
Date: Wed, 12 Oct 2016 14:31:32 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFDB7DF18BA__29210.7308902361$1476282774$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx.drdc-rddc.gc.ca (fw.drenet.dnd.ca [131.136.242.1])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id 90D73A4439
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2016 14:34:05 +0000 (UTC)
Content-Language: fr-FR
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

ICAgQXNzdW1lIHdlIGhhdmUgdGhpcyBzeXN0ZW0gd2l0aCBhIGNob2ljZSBvZiBrZXJuZWxzIGF0
IGJvb3QgdGltZSAoZm9yIGluc3RhbmNlLCBiZXR3ZWVuIDIuNi4xOCwgMi42LjE4LTEyOC5lbDUs
IGFuZCAyLjYuMTgtZ3JzZWMpLiAgRG8gd2UgbmVlZCB0byBkbyBtdWx0aXBsZSBMVFRuZyBidWls
ZHM/ICBGb3Igc29tZSBwYWNrYWdlcyBvbmx5LCBtYXliZSAoZS5nLiwgbHR0bmctbW9kdWxlcyk/
ICBJZiBzbywgY2FuIHRoZXkgY29oYWJpdCB3aXRob3V0IHRyb3VibGUsIG9yIHdpbGwgd2UgbmVl
ZCB0byBydW4gc29tZSBzb3J0IG9mIExUVG5nLWZpeGluZyBzY3JpcHQgZXZlcnkgdGltZSB3ZSBz
d2l0Y2gga2VybmVscz8NCg0KRGFuaWVsIFUuIFRoaWJhdWx0LCBNLlNjLsKyDQoNCkluZm9ybWF0
aWNpZW4gc2NpZW50aWZpcXVlLCBDTUUtUFNDLCBDZW50cmUgZGUgcmVjaGVyY2hlcyBkZSBWYWxj
YXJ0aWVyDQpSZWNoZXJjaGUgZXQgZMOpdmVsb3BwZW1lbnQgcG91ciBsYSBkw6lmZW5zZSBDYW5h
ZGEgLyBHb3V2ZXJuZW1lbnQgZHUgQ2FuYWRhDQpkYW5pZWwudGhpYmF1bHRAZHJkYy1yZGRjLmdj
LmNhIC8gVMOpbDogNDE4LTg0NC00MDAweDQyNDUgVMOpbMOpYzogNDE4LTg0NC00NTM4DQpkYW5p
ZWwudGhpYmF1bHRAZm9yY2VzLmdjLmNhIC8gVMOpbDogNDE4LTg0NC00MDAweDQyNDUgVMOpbMOp
YzogNDE4LTg0NC00NTM4DQoNCkNvbXB1dGVyIFNjaWVudGlzdCwgTUNDUy1TUEMsIFZhbGNhcnRp
ZXIgUmVzZWFyY2ggQ2VudHJlIA0KRGVmZW5jZSBSZXNlYXJjaCBhbmQgRGV2ZWxvcG1lbnQgQ2Fu
YWRhwqAvIEdvdmVybm1lbnQgb2YgQ2FuYWRhDQpkYW5pZWwudGhpYmF1bHRAZHJkYy1yZGRjLmdj
LmNhIC8gVGVsOiA0MTgtODQ0LTQwMDB4NDI0NSBGYXg6IDQxOC04NDQtNDUzOA0KZGFuaWVsLnRo
aWJhdWx0QGZvcmNlcy5nYy5jYSAvIFRlbDogNDE4LTg0NC00MDAweDQyNDUgRmF4OiA0MTgtODQ0
LTQ1MzgNCg0KRFJEQyBpcyBhbiBhZ2VuY3kgb2YgdGhlIERlcGFydG1lbnQgb2YgTmF0aW9uYWwg
RGVmZW5jZSAvIFJEREMgZXN0IHVuZSBhZ2VuY2UgZHUgbWluaXN0w6hyZSBkZSBsYSBEw6lmZW5z
ZSBuYXRpb25hbGUNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
