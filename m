From: "Zvi Vered" <veredz72@gmail.com>
Subject: Using LTTng to monitr several thread in one process
	(under vanilla 3.4.7)
Date: Fri, 16 Aug 2013 22:29:53 +0300
Message-ID: <FF6E89F18E7D48F8A07EEA74C1E66CC5__1173.41220980069$1376681475$gmane$org@ZviVeredPC>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f179.google.com ([74.125.82.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <veredz72@gmail.com>) id 1VAPj1-00048P-VQ
	for lttng-dev@lists.lttng.org; Fri, 16 Aug 2013 15:30:25 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so1956066wes.24
	for <lttng-dev@lists.lttng.org>; Fri, 16 Aug 2013 12:30:13 -0700 (PDT)
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

SGVsbG8sCgpJ4oCZbSB1c2luZyB2YW5pbGxhIDMuNC43IG9uIGFuIEludGVsJ3MgSXZ5LUJyaWRn
ZSAgUEMxMDQuClRoZSBhcHBsaWNhdGlvbiAoY29tcGlsZWQgYW5kIGJ1aWx0IHdpdGggaW50ZWwg
Y29tcGlsZXIpIGNvbnRhaW5zIDggdGhyZWFkcy4KCk15IGdvYWwgaXQgdG8gdXNlICDigJxMVFRu
ZyBQcm9qZWN04oCdIHRvIGRpc3BsYXkgYWxsIHRocmVhZHMgb24gYSBncmFwaC4KRWFjaCB0aHJl
YWQgd2lsbCBoYXZlIGl0cyBvd24g4oCcbGluZeKAnSBhbmQgSSB3aWxsIGJlIGFibGUgdG8gc2Vl
IHdoZW4gdGhlIENQVSAKaXMgaWRsZSBhbmQgd2hlbiBhIHNwZWNpZmljIHRocmVhZCB3b3Jrcy4K
CkluIG15IFBDMTA0LCBJbnRlbOKAmXMgSXZ5LUJyaWRnZSBoYXMgNCBjb3Jlcy4gTFRUbmcgaGFz
IHRvIGtub3cgb24gd2hpY2ggY29yZSAKYSB0aHJlYWQgaXMgY3VycmVudGx5IHJ1bm5pbmcuCgpJ
cyBpdCBwb3NzaWJsZSB0byBkbyBzdWNoIHRoaW5ncyB3aXRoIEx0dG5nID8KSSBhc2tlZCB0aGlz
IHF1ZXN0aW9uIGxvbmcgdGltZSBhZ28gYW5kIHRoZSBhbnN3ZXIgd2FzIC0gbm8KCklmIHllcywg
c2hvdWxkIEkgcGF0Y2ggdGhlIGtlcm5lbCBmb3IgdGhpcyBwdXJwb3NlID8KClRoYW5rcywKWnZp
a2EKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRu
Zy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
