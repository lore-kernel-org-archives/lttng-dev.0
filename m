From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.8.0-rc2 (Linux user-space tracer)
Date: Tue, 26 Apr 2016 20:34:56 +0000 (UTC)
Message-ID: <1068388764.70256.1461702896620.JavaMail.zimbra__41287.2101217092$1461702923$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 795ACA32F1
 for <lttng-dev@lists.lttng.org>; Tue, 26 Apr 2016 20:35:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 712773402E1
 for <lttng-dev@lists.lttng.org>; Tue, 26 Apr 2016 20:35:02 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id fEvzl4WpWvvJ for <lttng-dev@lists.lttng.org>;
 Tue, 26 Apr 2016 20:34:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EC7E034031D
 for <lttng-dev@lists.lttng.org>; Tue, 26 Apr 2016 20:34:56 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id hKTBG1gg61_R for <lttng-dev@lists.lttng.org>;
 Tue, 26 Apr 2016 20:34:56 +0000 (UTC)
Received: from evm-mail-1.efficios.com (evm-mail-1.efficios.com [78.47.125.74])
 by mail.efficios.com (Postfix) with ESMTP id CDA7C3402E1
 for <lttng-dev@lists.lttng.org>; Tue, 26 Apr 2016 20:34:56 +0000 (UTC)
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

SGksCgpJIGhlcmVieSBhbm5vdW5jZSB0aGUgc2Vjb25kIHJlbGVhc2UgY2FuZGlkYXRlIG9mIHRo
ZSBMVFRuZyB1c2VyLXNwYWNlCnRyYWNlciAyLjguIFRoZSBtYWluIGNoYW5nZXMgYXJlIHRoZSBy
ZW5hbWluZyBvZiBzdGF0ZWR1bXAgZXZlbnQgYW5kCmZpZWxkIG5hbWVzIHJlbGF0ZWQgdG8gZHlu
YW1pYyBsb2FkZXIgaW5zdHJ1bWVudGF0aW9uLCBhbmQgdGhlCmFkZGl0aW9uIG9mIGEgaXNfcGlj
IGZpZWxkIHRvIHN0YXRlZHVtcCBkeW5hbWljIGxvYWRlciBldmVudHMuCklmIHlvdXIgdHJhY2Ug
YW5hbHlzaXMgZGVwZW5kcyBvbiB0aG9zZSBldmVudCBuYW1lcyBhbmQgZmllbGQgbmFtZXMsCnBs
ZWFzZSB1cGRhdGUgdGhlbSBhY2NvcmRpbmdseS4KCldlIGhhdmUgYWxzbyBleHRlbmRlZCB0aGUg
bWFuIHBhZ2VzLCBhbmQgdGhlcmUgaXMgbm93IGEgZGVwZW5kZW5jeSBvbgpBc2NpaURvYyB0byBi
dWlsZCB0aGUgZG9jdW1lbnRhdGlvbi4gVGhlIHJlc3QgaXMgcHJldHR5IG11Y2gganVzdApidWdm
aXhlcy4KCkxUVG5nLVVTVCwgdGhlIExpbnV4IFRyYWNlIFRvb2xraXQgTmV4dCBHZW5lcmF0aW9u
IFVzZXJzcGFjZSBUcmFjZXIsCmlzIGEgbG93LW92ZXJoZWFkIGFwcGxpY2F0aW9uIHRyYWNlci4g
VGhlIGxpYnJhcnkgImxpYmx0dG5nLXVzdCIgZW5hYmxlcwp0cmFjaW5nIG9mIGFwcGxpY2F0aW9u
cyBhbmQgbGlicmFyaWVzLgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vbHR0bmcub3JnCkRvY3Vt
ZW50YXRpb246IGh0dHA6Ly9sdHRuZy5vcmcvZG9jcwpEb3dubG9hZCBsaW5rOiBodHRwOi8vbHR0
bmcub3JnL2Rvd25sb2FkCgpDaGFuZ2Vsb2c6CjIwMTYtMDQtMjYgbHR0bmctdXN0IDIuOC4wLXJj
MgogICAgICAgICogRG9jOiBVcGRhdGUgUkVBRE1FLm1kCiAgICAgICAgKiBGaXg6IGp1bCBhbmQg
bG9nNGogYWdlbnRzIG1ha2VmaWxlIG1pc3NpbmcgbGluZSBhbmQgaW5kZW50YXRpb24KICAgICAg
ICAqIEZpeDogcmUtaW50cm9kdWNlIGV4cG9ydGVkIHN5bWJvbHMKICAgICAgICAqIERvYzogdXBk
YXRlIG1hbnBhZ2VzIGZvciBzb2luZm8vc29wYXRoIG5hbWUgY2hhbmdlCiAgICAgICAgKiBSZW5h
bWUgc3RhdGVkdW1wIGFuZCBkbCBldmVudHMgYW5kIGZpZWxkcwogICAgICAgICogVGVzdHM6IGxp
c3QgdXN0LWVsZiB0ZXN0IGRhdGEgZXhwbGljaXRseSBpbiBFWFRSQV9ESVNUCiAgICAgICAgKiBU
ZXN0czogYWRkIHRlc3RzIGZvciBsdHRuZ191c3RfZWxmX2lzX3BpYwogICAgICAgICogQWRkIGlz
X3BpYyBmaWVsZCB0byBzdGF0ZWR1bXAgc29pbmZvIGV2ZW50CiAgICAgICAgKiBGaXg6IGFkZCBj
b21tb24gamFyIHRvIGx0dG5nLXVzdC1hZ2VudC1hbGwgZGVwZW5kZW5jaWVzCiAgICAgICAgKiBG
aXg6IGFkZCB2ZXJzaW9uIHRvIGx0dG5nLXVzdC1hZ2VudC1hbGwgamFyIGZpbGUKICAgICAgICAq
IEZpeDogcmVuYW1lIGxpYmx0dG5nLXVzdC1hZ2VudCB0byBsdHRuZy11c3QtYWdlbnQtYWxsCiAg
ICAgICAgKiBGaXg6IHJlLWFkZCBsaWJsdHRuZy11c3QtYWdlbnQuamFyCiAgICAgICAgKiBGaXg6
IGx0dG5nIGphdmEgYWdlbnQ6IGRpc3Bvc2UgaXMgbm9uLXN0YXRpYwogICAgICAgICogZG9jL21h
bjogbHR0bmctdXN0KDMpOiBhZGQgdHJhY2luZyBjb250cm9sIHRvIGV4YW1wbGUKICAgICAgICAq
IGRvYy9tYW46IGx0dG5nLXVzdCgzKTogc3BsaXQgZXhhbXBsZSBmaWxlcyBpbiBzdWJzZWN0aW9u
cwogICAgICAgICogZG9jL21hbi9jb21tb24tY29weXJpZ2h0czogYWRkIG1pc3NpbmcgVEhBTktT
IHNlY3Rpb24KICAgICAgICAqIGRvYy9tYW46IGx0dG5nLXVzdCgzKTogYWRkIG1pc3NpbmcgRU5W
SVJPTk1FTlQgVkFSSUFCTEVTIHNlY3Rpb24KICAgICAgICAqIGRvYy9tYW46IGRvIG5vdCB1c2Ug
bWFjcm9zIGluIHRoZSBOQU1FIHNlY3Rpb24KICAgICAgICAqIGRvYy9tYW46IHJlbW92ZSBkdXBs
aWNhdGUgY29weXJpZ2h0cyBzZWN0aW9uCiAgICAgICAgKiBSRUFETUUubWQ6IGJvbGRlbiBkZXBl
bmRlbmNpZXMgYW5kIHVwZGF0ZSBsaW5rcwogICAgICAgICogUkVBRE1FLm1kOiBzcGxpdCByZXF1
aXJlZCBhbmQgb3B0aW9uYWwgZGVwZW5kZW5jaWVzCiAgICAgICAgKiBDb252ZXJ0IG1hbiBwYWdl
cyB0byBBc2NpaURvYwogICAgICAgICogRml4OiByZW1vdmUgZGVhZCBjb2RlIGZyb20gZmlsdGVy
IGludGVycHJldGVyCiAgICAgICAgKiBGaXg6IGNvbnZleSBlbnVtIHZhbHVlIHNpZ25lZG5lc3Mg
aW50byBtZXRhZGF0YQoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDov
L3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1k
ZXYK
