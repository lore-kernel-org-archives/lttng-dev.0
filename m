From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: lttng-track on userspace channel
Date: Wed, 31 May 2017 23:28:45 +0000
Message-ID: <CY4PR12MB191256DF4AFE069B55B133FB9BF10__25483.7562483319$1496340020$gmane$org@CY4PR12MB1912.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0074.outbound.protection.outlook.com [104.47.34.74])
 by lists.lttng.org (Postfix) with ESMTPS id 3wdtzY4bzqz11m2
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 17:06:32 +0000 (UTC)
Content-Language: en-US
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

SSBhbSB1c2luZyBsdHRuZyAyLjkuNC4KCkkgaGF2ZSBhIHNlcnZlciBkYXRhYmFzZSBkYWVtb24g
d2l0aCBtYW55IHRocmVhZHMgYW5kIEkgd291bGQgbGlrZSB0byB0cmFjayBldmVudHMgb24gYSBz
bWFsbGVyIHN1YnNldCBvZiB0aG9zZSB0aHJlYWRzLgpJIG5vdGljZWQgdGhhdCBvbiB0aGUga2Vy
bmVsIGNoYW5uZWwgSSBjYW4gdXNlIGx0dG5nIHRyYWNrIC0tcGlkPTEyMywxMjQsMTI1CgphbmQg
dGhpcyB3aWxsIHRyYWNlIGtlcm5lbCBldmVudHMgZm9yIGp1c3QgdGhvc2UgVElEUyAoaW4gc3Bp
dGUgb2YgdGhlIGRvY3VtZW50YXRpb24gc2F5aW5nIGl0IHdpbGwgdHJhY2sgd2hvbGUgcGlkcyku
CkJ1dCBJIGFtIGhhcHB5IGJlY2F1c2UgdGlkIHRyYWNraW5nIGlzIHdoYXQgSSB3YW50LgoKSG93
ZXZlciwgaXMgdGhlcmUgYW4gZXF1aXZhbGVudCB3YXkgdG8gdHJhY2sgY2VydGFpbiB0aWRzIG9u
IHRoZSB1c2Vyc3BhY2UgY2hhbm5lbD8gIEkgZmluZCB0aGF0IGlmIEkgdXNlCiAgICBsdHRuZyB0
cmFjayAtdSAtLXBpZD14eHgKaXQganVzdCB0cmFja3MgYWxsIHRoZSB0aWRzIHVuZGVyIHRoYXQg
cGlkLgoKSGVyZSBpcyBteSBzY3JpcHQgKHdoZXJlIDc5NjUzIGlzIGEgc2luZ2xlIHRpZCkuICBJ
biB0aGlzIGNhc2UgaXQgdHJhY2VzIG9ubHkga2VybmVsIGV2ZW50cyBvbiB0aGF0IHRpZC4KLS0t
LS0tLS0tLS0KbHR0bmcgY3JlYXRlCmx0dG5nIGVuYWJsZS1jaGFubmVsIHUgLXUgLS1udW0tc3Vi
YnVmIDY0IC0tc3ViYnVmLXNpemUgNTEyawpsdHRuZyBlbmFibGUtY2hhbm5lbCBrIC1rIC0tbnVt
LXN1YmJ1ZiA2NCAtLXN1YmJ1Zi1zaXplIDUxMmsKbHR0bmcgYWRkLWNvbnRleHQgLWsgLWMgayAt
dCB0aWQgLXQgcGlkCmx0dG5nIGFkZC1jb250ZXh0IC11IC1jIHUgLXQgdnRpZCAtdCB2cGlkCmx0
dG5nIGVuYWJsZS1ldmVudCAtdSAtYyB1IC1hCmx0dG5nIGVuYWJsZS1ldmVudCAtayAtYyBrIC0t
c3lzY2FsbCBmdXRleApsdHRuZyB0cmFjayAtayAtLXBpZD03OTY1MwpsdHRuZyB0cmFjayAtdSAt
LXBpZD03OTY1MwpsdHRuZyBzdGFydApzbGVlcCAxLjAKbHR0bmcgc3RvcApsdHRuZyBkZXN0cm95
CgotLSBUb20gRGVuZWF1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpo
dHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
Cg==
