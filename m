From: Zifei Tong <soariez@gmail.com>
Subject: GSoC 2013, "C++ probe support" project and more
Date: Fri, 19 Apr 2013 13:38:31 +0800
Message-ID: <CAJ7wx-Epdf=DV+acPKkXjbXbgPGXHOUnnfOEH_hbpnreL2z4dA__9700.22519254616$1366349983$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1UT42X-0002nE-DG
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 01:39:17 -0400
Received: by mail-vb0-f51.google.com with SMTP id x19so3201646vbf.24
	for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2013 22:39:11 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGVsbG8gYWxsLAoKSSBhbSBpbnRlcmVzdGVkIGluIHBhcnRpY2lwYXRpbmcgR1NvQyAyMDEzIHdp
dGggbHR0bmcuCgpGb3IgdGhlICJDKysgcHJvYmUgc3VwcG9ydCIgcHJvamVjdCwgSSBkaWQgc29t
ZSByZXNlYXJjaCBhbmQgZmluZCBvdXQKdGhhdCBpdCBpcyBlYXNpZXIgdGhhbiBJIHRob3VnaHQu
CgpJIG1hbmFnZWQgdG8gbWFrZSBpdCBjb21waWxlIHdpdGggY2xhbmcrKywgaGVyZSBpcyB0aGUg
Y29tbWl0OgpodHRwczovL2dpdGh1Yi5jb20vNWtnL2x0dG5nLXVzdC9jb21taXQvMGI1NDA5OGEy
Y2M2NDQzNjYyYjI4N2Q0Yjc3ZDJmMWI2MWU0Y2ZiNi4KCldoaWxlIGZvciBnKyssIHNpbmNlIGl0
IGRvZXMgbm90IHN1cHBvcnQgQydzIGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXIKKGNsYW5nKysgZG9l
cyksIGZ1cnRoZXIgd29yayBzaGFsbCBiZSBkb25lLiBBbGwgcmVtYWluaW5nIGVycm9ycyBhcmUK
cmVsYXRlZCB0byB0aGlzIHN0cnVjdCBpbml0aWFsaXplciBpc3N1ZQooaHR0cHM6Ly9naXN0Lmdp
dGh1Yi5jb20vNWtnLzU0MTc4NTApLCBjYW4gYW55b25lIHN1Z2dlc3QgYSBjbGVhbiBoYWNrCnRv
IHdvcmthcm91bmQgdGhpcz8KCkJlc2lkZXMgdGhlIEMrKyBzdXBwb3J0IHByb2plY3QsIEknZCBs
aWtlIHRvIHdvcmsgb24gdGhlICdzdHJhY2UtYWxpa2UKd3JhcHBlcicuIEl0IHRha2VzIG1lIGEg
ZmFpciBhbW91bnQgb2YgdGltZSB0byB0cnkgdGhlIGRlbW8gb2YgbHR0bmcuCkEgJ3N0cmFjZS1h
bGlrZSB3cmFwcGVyJyBpcyBtdWNoIG1vcmUgc2ltcGxlciB0byBtZS4gQ2FuIHRoaXMgYmUgZG9u
ZQpieSBhIHNpbXBsZSBzaGVsbC9weXRob24gd3JhcHBlciBvZiBsdHRuZy10b29scz8KCiJJbXBy
b3ZlbWVudCBvZiBsaWJsdHRuZy11c3QtbGliYy13cmFwcGVyJ3MgY292ZXJhZ2Ugb2YgbGliYydz
CmZ1bmN0aW9ucyIgbG9va3MgaW50ZXJlc3RpbmcgdG8gbWUsIGhvd2V2ZXIgSSBuZWVkIHNvbWUg
dGltZSB0byBiZQpmYW1pbGlhciB3aXRoIER5bmluc3QuCgpMb29raW5nIGZvcndhcmQgdG8geW91
ciByZXBseS4KClBTOiBNeSBuYW1lIGlzIFppZmVpIFRvbmcuIEkgYW0gYSBmaXJzdC15ZWFyIE1T
IHN0dWRlbnQgaW4gQ1MgZm9ybQpaaGVqaWFuZyBVbml2ZXJzaXR5IGluIENoaW5hLgotLQpCZXN0
IFJlZ2FyZHMsCuS7neWtkOmjniAoWmlmZWkgVG9uZykKQ29sbGVnZSBvZiBDb21wdXRlciBTY2ll
bmNlIGFuZCBUZWNobm9sb2d5LCBaaGVqaWFuZyBVbml2ZXJzaXR5Cgpzb2FyaWV6QGdtYWlsLmNv
bSAvIHRvbmd6aWZlaUB6anUuZWR1LmNuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cg==
