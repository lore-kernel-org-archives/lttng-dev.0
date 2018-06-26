From: =?GBK?B?0eLPqw==?= <jielan2@163.com>
Subject: How to get the sequence element by using babeltrace c
	API ?
Date: Tue, 26 Jun 2018 17:35:43 +0800 (CST)
Message-ID: <7a52ddf5.cbc5.1643b72e5d1.Coremail.jielan2__8199.11554358459$1530006598$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4884437778284521983=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from m13-143.163.com (m13-143.163.com [220.181.13.143])
 by lists.lttng.org (Postfix) with ESMTP id 41FLsx5cQxz19rS
 for <lttng-dev@lists.lttng.org>; Tue, 26 Jun 2018 05:51:45 -0400 (EDT)
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
List-Id: lttng-dev@lists.lttng.org

--===============4884437778284521983==
Content-Type: multipart/alternative;
	boundary="----=_Part_191920_1009312807.1530005743057"

------=_Part_191920_1009312807.1530005743057
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGVsbG8sCkkgZm91bmQgdGhlIGVtYWlsIGFkZHJlc3MgdmlhIEdvb2dsZSwgSSBzaW5jZXJlbHkg
aG9wZSB0aGF0IGl0IHdpbGwgbm90IGRpc3R1cmIgeW91LiA6KQogSSdtIHVzaW5nIGJhYmVsdHJh
Y2UgQVBJIGluIEMuIEkgd291bGQgbGlrZSB0byBrbm93IGlmIHRoZXJlJ3MgYW4gQVBJIHRvIGdl
dCB0aGUgc2VxdWVuY2UgaXRlbXMgd2hlbiB0aGUgY3RmIHR5cGUgaXMgQ1RGX1RZUEVfU0VRVUVO
Q0UuIEkgdHJpZWQgdGhlIGJ0X2N0Zl9nZXRfaW5kZXgoKSwgYnV0IGl0IHJldHVybnMgYSBidF9k
ZWZpbml0aW9uKiwgSSBkb24ndCBrbm93IGhvdyB0byBnZXQgdGhlIGNoYXIgZWxlbWVudHMgb2Yg
dGhlIHNlcXVlbmNlIGluIHRoZSBmaWVsZC4gQ291bGQgeW91IGdpdmUgbWUgc29tZSBzdWdnZXN0
aW9ucz8gVGhhbmtzIHZlcnkgbXVjaCEKCgoKCkJSLApUaW5hCgoKCgoKCgo=
------=_Part_191920_1009312807.1530005743057
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXY+SGVsbG8sPC9kaXY+PGRpdj5JIGZvdW5kIHRoZSBlbWFp
bCBhZGRyZXNzIHZpYSBHb29nbGUsIEkmbmJzcDtzaW5jZXJlbHkgaG9wZSB0aGF0IGl0Jm5ic3A7
d2lsbCBub3QmbmJzcDtkaXN0dXJiIHlvdS4gOik8L2Rpdj48ZGl2PiZuYnNwO0knbSB1c2luZyBi
YWJlbHRyYWNlIEFQSSZuYnNwO2luIEMuIEkgd291bGQgbGlrZSB0byBrbm93IGlmIHRoZXJlJ3Mg
YW4gQVBJIHRvIGdldCB0aGUgPGVtPnNlPC9lbT5xdWVuY2UgaXRlbXMgd2hlbiB0aGUgY3RmIHR5
cGUgaXMgQ1RGX1RZUEVfU0VRVUVOQ0UuIEkgdHJpZWQgdGhlIGJ0X2N0Zl9nZXRfaW5kZXgoKSwg
YnV0IGl0IHJldHVybnMgYSBidF9kZWZpbml0aW9uKiwgSSBkb24ndCBrbm93IGhvdyB0byBnZXQg
dGhlIGNoYXIgZWxlbWVudHMgb2YgdGhlIHNlcXVlbmNlIGluIHRoZSBmaWVsZC4gQ291bGQgeW91
IGdpdmUgbWUgc29tZSBzdWdnZXN0aW9ucz8gVGhhbmtzIHZlcnkgbXVjaCE8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJSLDwvZGl2PjxkaXY+VGluYTwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjwv
ZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxwPiZuYnNwOzwvcD48L3Nw
YW4+
------=_Part_191920_1009312807.1530005743057--


--===============4884437778284521983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4884437778284521983==--
