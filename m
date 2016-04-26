From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.17
Date: Tue, 26 Apr 2016 21:09:06 +0000 (UTC)
Message-ID: <606375824.70365.1461704946795.JavaMail.zimbra__48616.5475602776$1461704975$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 6097EA330C
 for <lttng-dev@lists.lttng.org>; Tue, 26 Apr 2016 21:09:11 +0000 (UTC)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

SGksCgpFdmVuIHRob3VnaCB0aGUgdXJjdSBzdGFibGUtMC43IGJyYW5jaCB3YXMgc3VwcG9zZWQg
dG8gYmUgZW5kCm9mIGxpZmUsIHRoZXJlIGlzIG9uZSBsYXN0IGltcG9ydGFudCBmaXggZm9yIHRo
ZSB1cmN1LXNpZ25hbCBmbGF2b3IKdGhhdCB3YXMgc2l0dGluZyBpbiB0aGF0IGJyYW5jaCB0aGF0
IEkgd291bGQgbGlrZSB0byByZWxlYXNlCmJlZm9yZSB0YWtpbmcgaXQgYXdheSBmb3IgZ29vZC4g
QWxsIHRoZSBnb29kIHpvbWJpZSBtb3ZpZXMgc3RhcnQKbGlrZSB0aGlzLCByaWdodCA/CgpsaWJ1
cmN1IGlzIGEgTEdQTHYyLjEgdXNlcnNwYWNlIFJDVSAocmVhZC1jb3B5LXVwZGF0ZSkgbGlicmFy
eS4gVGhpcwpkYXRhIHN5bmNocm9uaXphdGlvbiBsaWJyYXJ5IHByb3ZpZGVzIHJlYWQtc2lkZSBh
Y2Nlc3Mgd2hpY2ggc2NhbGVzCmxpbmVhcmx5IHdpdGggdGhlIG51bWJlciBvZiBjb3Jlcy4gSXQg
ZG9lcyBzbyBieSBhbGxvd2luZyBtdWx0aXBsZQpjb3BpZXMgb2YgYSBnaXZlbiBkYXRhIHN0cnVj
dHVyZSB0byBsaXZlIGF0IHRoZSBzYW1lIHRpbWUsIGFuZCBieQptb25pdG9yaW5nIHRoZSBkYXRh
IHN0cnVjdHVyZSBhY2Nlc3NlcyB0byBkZXRlY3QgZ3JhY2UgcGVyaW9kcyBhZnRlcgp3aGljaCBt
ZW1vcnkgcmVjbGFtYXRpb24gaXMgcG9zc2libGUuCgpsaWJ1cmN1LWNkcyBwcm92aWRlcyBlZmZp
Y2llbnQgZGF0YSBzdHJ1Y3R1cmVzIGJhc2VkIG9uIFJDVSBhbmQKbG9jay1mcmVlIGFsZ29yaXRo
bXMuIFRob3NlIHN0cnVjdHVyZXMgaW5jbHVkZSBoYXNoIHRhYmxlcywgcXVldWVzLApzdGFja3Ms
IGFuZCBkb3VibHktbGlua2VkIGxpc3RzLgoKQ2hhbmdlbG9nOgoyMDE2LTA0LTI2IFVzZXJzcGFj
ZSBSQ1UgMC43LjE3CiAgICAgICAgKiBGaXg6IHVyY3Utc2lnbmFsOiBzbXBfbWJfbWFzdGVyKCkg
bmVlZHMgcmVnaXN0cnkgbG9jawoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vbGlidXJjdS5vcmcK
R2l0IHJlcG9zaXRvcnk6IGdpdDovL2dpdC5saWJ1cmN1Lm9yZy91cmN1LmdpdAoKLS0gCk1hdGhp
ZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
