From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-modules] Update compaction instrumentation
	for 3.14.x stable kernels
Date: Sun,  7 Dec 2014 12:14:19 -0500
Message-ID: <1417972459-23428-1-git-send-email-simon.marchi__35411.1485918567$1417972503$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1XxfPZ-0006FU-Sz
 for lttng-dev@lists.lttng.org; Sun, 07 Dec 2014 12:14:22 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Q29uZGl0aW9uYWwgY29tcGlsYXRpb24gaW50cm9kdWNlZCBieSBsdHRuZy1tb2R1bGVzIGNvbW1p
dAoKICAwMDA3MzQ0NzQxZWY2NTI1OWJjNTJkZWE3MjI1OTE3M2RmYmY5NmMwCgpuZWVkcyB0byBi
ZSBhcHBsaWVkIHRvIGtlcm5lbHMgMy4xNC4yNSBhbmQgdXAgaW4gdGhlIDMuMTQueCBicmFuY2gu
CgpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBNYXJjaGkgPHNpbW9uLm1hcmNoaUBwb2x5bXRsLmNhPgpS
ZXBvcnRlZC1ieTogQmrDuHJuIEZvcnNtYW4gPGJqb3JuLmZvcnNtYW5AZ21haWwuY29tPgotLS0K
IGluc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2NvbXBhY3Rpb24uaCB8IDMgKyst
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvY29tcGFjdGlvbi5oIGIv
aW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUvY29tcGFjdGlvbi5oCmluZGV4IGVl
MjNhYTkuLjc3M2E2YWQgMTAwNjQ0Ci0tLSBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmct
bW9kdWxlL2NvbXBhY3Rpb24uaAorKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1v
ZHVsZS9jb21wYWN0aW9uLmgKQEAgLTQ2LDcgKzQ2LDggQEAgTFRUTkdfVFJBQ0VQT0lOVF9FVkVO
VF9JTlNUQU5DRShtbV9jb21wYWN0aW9uX2lzb2xhdGVfdGVtcGxhdGUsIG1tX2NvbXBhY3Rpb25f
aXMKIAlUUF9BUkdTKG5yX3NjYW5uZWQsIG5yX3Rha2VuKQogKQogCi0jaWYgKExJTlVYX1ZFUlNJ
T05fQ09ERSA+PSBLRVJORUxfVkVSU0lPTigzLDE2LDApKQorI2lmIExUVE5HX0tFUk5FTF9SQU5H
RSgzLDE0LDI1LCAzLDE1LDApIHx8IFwKKwkoTElOVVhfVkVSU0lPTl9DT0RFID49IEtFUk5FTF9W
RVJTSU9OKDMsMTYsMCkpCiBMVFROR19UUkFDRVBPSU5UX0VWRU5UKG1tX2NvbXBhY3Rpb25fbWln
cmF0ZXBhZ2VzLAogCiAJVFBfUFJPVE8odW5zaWduZWQgbG9uZyBucl9hbGwsCi0tIAoyLjEuMwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRl
diBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
