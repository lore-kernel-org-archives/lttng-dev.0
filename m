From: David Goulet <dgoulet@efficios.com>
Subject: [RFC] Java JUL tracing ABI/API for LTTng-Tools
Date: Thu, 12 Sep 2013 11:07:00 -0400
Message-ID: <5231D894.8070707__36998.9253384576$1378998502$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060006080801030404030400"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VK8U9-0002p2-Ni
	for lttng-dev@lists.lttng.org; Thu, 12 Sep 2013 11:07:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 51346A1D79
	for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2013 15:06:46 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id hEgE4LiYPIQc for <lttng-dev@lists.lttng.org>;
	Thu, 12 Sep 2013 15:06:45 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id C21E1A1DA0
	for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2013 15:06:45 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z4ud90-dCRPJ for <lttng-dev@lists.lttng.org>;
	Thu, 12 Sep 2013 15:06:45 +0000 (UTC)
Received: from 127.0.0.1 (cable-10.246.173-146.electronicbox.net
	[173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id 060CBA1D79
	for <lttng-dev@lists.lttng.org>; Thu, 12 Sep 2013 15:06:44 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------060006080801030404030400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tiny RFC! :)

Hopefully, the change is not that big in lttng-tools to support a new Java
domain and this RFC sums it up in terms of *public* changes.

Cheers!
David

--------------060006080801030404030400
Content-Type: text/plain;
 name="XXXX-java-jul-lttng-tools-api.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="XXXX-java-jul-lttng-tools-api.txt"

UkZDIC0gSmF2YSBKVUwgTFRUbmcgVG9vbHMgQVBJL0FCSQoKQXV0aG9yOiBEYXZpZCBHb3Vs
ZXQgPGRnb3VsZXRAZWZmaWNpb3MuY29tPgoKVmVyc2lvbjoKCS0gdjAuMTogMTAvMDkvMjAx
MwoJCSogSW5pdGlhbCBwcm9wb3NhbAoKSW50cm9kdWN0aW9uCi0tLS0tLS0tLS0KClRoaXMg
cHJvcG9zYWwgZGV0YWlscyB0aGUgQVBJL0FCSSBmb3IgSmF2YSBKVUwgdHJhY2luZyBpbiBM
VFRuZy1Ub29scyBmb3IgdGhlCnB1YmxpYyBwYXJ0LgoKTFRUbmcgQUJJCi0tLS0tLS0tLQoK
TG9jYXRlZCBpbiBpbmNsdWRlL2x0dG5nL2x0dG5nLmgsIGEgbmV3IGRvbWFpbiBpcyBpbnRy
b2R1Y2VkLiBUaGUgSmF2YSBKVUwKZG9tYWluLiBUaGUgb25seSBjaGFuZ2UgdG8gdGhlIEFC
SSBpcyB0aGF0IGEgbmV3IHZhbHVlIGlzIGFkZGVkLgoKZW51bSBsdHRuZ19kb21haW5fdHlw
ZSB7CglMVFROR19ET01BSU5fS0VSTkVMICAgICAgICAgICAgICAgICAgID0gMSwKCUxUVE5H
X0RPTUFJTl9VU1QgICAgICAgICAgICAgICAgICAgICAgPSAyLAoJTFRUTkdfRE9NQUlOX0pB
VkFfSlVMICAgICAgICAgICAgICAgICA9IDMsCS8qIE5FVyBWQUxVRSAqLwp9CgpGb3IgdGhp
cyBuZXcgZG9tYWluLCBjcmVhdGluZyBhIG5ldyBldmVudCBpcyBzbGlnaHRseSBkaWZmZXJl
bnQgaW4gdGVybXMgb2YKbmVlZGVkIGF0dHJpYnV0ZXMuIFRoZSBmb2xsb3dpbmcgZmllbGRz
IGluIHRoZSBsdHRuZ19ldmVudCBkYXRhIHN0cnVjdHVyZSBhcmUKSUdOT1JFRCBzaW5jZSB0
aGV5IGNhbid0IGJlIGFwcGxpZWQgdG8gSmF2YSB0cmFjaW5nLgoKKiBlbnVtIGx0dG5nX2V2
ZW50X3R5cGUgdHlwZTsKKiBlbnVtIGx0dG5nX2xvZ2xldmVsX3R5cGUgbG9nbGV2ZWxfdHlw
ZTsKKiBpbnQgbG9nbGV2ZWwKKiB1bmlvbiBhdHRyCgpGdXJ0aGVybW9yZSwgYWRkaW5nIGNv
bnRleHQgYW5kIGZpbHRlciBpcyBub3QgcG9zc2libGUuIEZ1dHVyZSB3b3JrIGNhbiBwb3Nz
aWJseQpzdXBwb3J0IGZpbHRlcnMgc2luY2UgSlVMIG9mZmVycyBmaWx0ZXJpbmcgcG9zc2li
aWxpdGllcy4KCkxUVG5nIENvbW1hbmQgTGluZQotLS0tLS0tLS0tLS0tLS0tLS0KCkluIHRl
cm1zIG9mIGNvbW1hbmQgbGluZSBuZXcgb3B0aW9uLCB0aGUgSmF2YSBKVUwgZG9tYWluIG9w
dGlvbiBpcyBhZGRlZC4gQSBuZXcKb3B0aW9uIGZvciB0aGF0IGRvbWFpbiBpcyBhdmFpbGFi
bGUgaW4gdGhlIFVJIHRvIHNlbGVjdCB0aGF0IHBhcnRpY3VsYXIgZG9tYWluLgoKJCBsdHRu
ZyBlbmFibGUtZXZlbnQgLS1qYXZhLWp1bCAoc2hvcnQ6IC1qKQoKTm93LCB0aGUgY29uY2Vw
dCBvZiAiZXZlbnQiIGlzIE5PVCBkaXJlY3RseSBtYXBwZWQgdG8gbG9nIGNhbGxzaXRlIGlu
IEpVTCBidXQgdG8KYSBMb2dnZXJbMV0gbmFtZS4gVGh1cywgY29tbWFuZHMgdXNpbmcgImV2
ZW50IG5hbWUiIGlzIGEgICJsb2dnZXIgbmFtZSIgZm9yIHRoZQpKVUwgZG9tYWluLiBGb3Ig
aW5zdGFuY2UsIHRoaXMgZm9sbG93aW5nIGNvbW1hbmQgZW5hYmxlcyB0aGUgIkEiIExvZ2dl
ciBvYmplY3QKaW4gSmF2YSBhcHBsaWNhdGlvbi4KCiQgbHR0bmcgZW5hYmxlLWV2ZW50IC1q
IEEKClNhbWUgZ29lcyBmb3IgdGhlIGxpc3QgY29tbWFuZCwgaXQgbGlzdHMgYXZhaWxhYmxl
IHJlZ2lzdGVyZWQgTG9nZ2VyIHdoZW4gdXNlZAp3aXRoIHRoZSAtaiBvcHRpb24uCgpSZWZl
cmVuY2VzCi0tLS0tLS0tLS0KWzFdIGh0dHA6Ly9kb2NzLm9yYWNsZS5jb20vamF2YXNlLzcv
ZG9jcy9hcGkvamF2YS91dGlsL2xvZ2dpbmcvTG9nZ2VyLmh0bWwK
--------------060006080801030404030400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------060006080801030404030400--
