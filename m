From: "jon bird" <jon@onasticksoftware.co.uk>
Subject: Syncing traces with NTP
Date: Tue, 4 Sep 2018 15:01:15 +0100
Message-ID: <9e0c9bef69d17f0a9ccaf9c57aa23946.squirrel__8806.34562713585$1536097200$gmane$org@monolith>
Reply-To: jon@onasticksoftware.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from claranet-outbound-smtp01.uk.clara.net
 (claranet-outbound-smtp01.uk.clara.net [195.8.89.34])
 by lists.lttng.org (Postfix) with ESMTPS id 424TXm0cBCztvJ
 for <lttng-dev@lists.lttng.org>; Tue,  4 Sep 2018 10:21:27 -0400 (EDT)
Received: from 39.169.90.146.dyn.plus.net ([146.90.169.39]:60821
 helo=mail.onasticksoftware.net)
 by relay01.mail.eu.clara.net (relay.clara.net [81.171.239.31]:10587)
 with esmtpsa (authdaemon_plain:postmaster@onasticksoftware.co.uk)
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 id 1fxBtW-0007Yh-4y  for lttng-dev@lists.lttng.org
 (return-path <jon@onasticksoftware.co.uk>); Tue, 04 Sep 2018 14:01:32 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.onasticksoftware.net (Postfix) with ESMTP id DD20D1B02A90
 for <lttng-dev@lists.lttng.org>; Tue,  4 Sep 2018 15:01:25 +0100 (BST)
Received: from mail.onasticksoftware.net ([127.0.0.1])
 by localhost (mail.onasticksoftware.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X3uqDu8O7Qmg for <lttng-dev@lists.lttng.org>;
 Tue,  4 Sep 2018 15:01:16 +0100 (BST)
Received: from monolith (localhost [127.0.0.1])
 by mail.onasticksoftware.net (Postfix) with ESMTP id E328B1B01466
 for <lttng-dev@lists.lttng.org>; Tue,  4 Sep 2018 15:01:15 +0100 (BST)
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

SGksCgpJJ20gaGF2aW5nIHNvbWUgaXNzdWVzIHRyeWluZyB0byBjb3JyZWxhdGUgdGltaW5ncyBj
cmVhdGluZyBmcm9tIGx0dG5nCndpdGggYW5vdGhlciBtYWNoaW5lLiBJbiBlc3NlbmNlLCBJJ20g
dHJ5aW5nIHRvIHBlcmZvcm0gYW4gZW5kIHRvIHRpbWluZwp0ZXN0IHdoaWNoIGludm9sdmVzIHNl
bmRpbmcgYSBVRFAgcGFja2V0IHRvIHRoZSBib3ggKHdoaWNoIGlzIHJ1bm5pbmcKbHR0bmdbMi44
XSB0byB0cmFjayB2YXJpb3VzIGV2ZW50cyksIHdoaWNoIHRoZW4gZG9lcyBzb21lIHdvcmsgb24g
dGhlCnBheWxvYWQgYW5kIHNlbmRzIGl0IGJhY2sgdG8gdGhlIG9yaWduYXRvci4gUHJpb3IgdG8g
dHJhbnNtaXNzaW9uIGFuZAphZnRlciByZWNlcHRpb24gSSBwcmludCBvdXQgdGhlIHN0YXJ0L2Vu
ZCB0aW1lcyByZXRyaWV2ZWQgZnJvbQpjbG9ja19nZXR0aW1lIHVzaW5nIENMT0NLX1JFQUxUSU1F
LgoKQm90aCBtYWNoaW5lcyBhcmUgc3luYydkIHVwIHRvIE5UUCwgSSB1c2UgIm50cHEgLXAiIHRv
IGRpc3BsYXkgdGhlIHRpbWUKb2Zmc2V0IGJldHdlZW4gdGhlIHR3byAoSSd2ZSBhbHNvIHVzZWQg
ImNsb2NrZGlmZiIgd2hpY2ggY29uZmlybXMgdGhpcwpzYW1lIG9mZnNldCkuCgpUaGVyZWZvcmUs
IG15IHRoaW5raW5nIGlzIHRoYXQgSSBzaG91bGQgYmUgYWJsZSB0byBhcHBseSB0aGlzIG9mZnNl
dCB0bwp0aGUgdGltZXN0YW1wcyBnZW5lcmF0ZWQgYnkgbHR0bmcgdG8gaGF2ZSB0aGVtIHJlZmVy
ZW5jZWQgdG8gdGhlIHNhbWUKY2xvY2suIFRoZSBpc3N1ZSBJJ20gZmluZGluZyB0aG91Z2ggaXMg
dGhhdCB0aGUgdGltZXN0YW1wcyBzZWVtcyB3aWxkZWx5Cm91dCAtIGluIHNvbWUgaW5zdGFuY2Vz
IGV2ZW4gYnkgYSAyLTMgc2Vjb25kcyAod2hlbiBJJ20gc2hvd2luZyBhbiBvZmZzZXQKYmV0d2Vl
biB0aGUgdHdvIG1hY2hpbmVzIG9mIGp1c3QgYSBmZXcgbWlsbGlzZWNvbmRzKS4KClNvIEknbSBh
IGxpdHRsZSBwdXp6bGVkIGJ5IHdoYXQgSSdtIHNlZWluZyBoZXJlIGFuZCBob3cgdG8gcHJvY2Vl
ZC4gQW55CmhlbHAgYXBwcmVjaWF0ZWQuCgpSZ3MsCgoKSm9uLgoKCj09IG1haWx0bzpqb25Ab25h
c3RpY2tzb2Z0d2FyZS5jby51ayAtIGluIHJlYWwgbGlmZSBqb24gYmlyZAo9PSAgaHR0cDovL3d3
dy5vbmFzdGlja3NvZnR3YXJlLmNvLnVrIC0gc3R1ZmYsIG9uLWEtc3RpY2sKPT0gICAibWVuIGxv
dmUgd29tZW4sIHdvbWVuIGxvdmUgY2hpbGRyZW4sIGNoaWxkcmVuIGxvdmUgaGFtc3RlcnMiCj09
ICAgIDx0ZWNobm9sb2d5IG91dCBvZiBjb250cm9sPgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
