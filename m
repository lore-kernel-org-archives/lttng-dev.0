From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH 1/3] tests/lib/Makefile.am: Remove
 test_seek_empty_packet and test_seek_big_trace from SCRIPT_LIST
Date: Wed, 27 Apr 2016 23:04:30 -0400
Message-ID: <e2a89f7d42d3628541f53cae8ca478ac__5603.95410652763$1461812695$gmane$org@simark.ca>
References: <1461811940-8336-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 846DBA32BC
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 03:04:33 +0000 (UTC)
Received: from simark.ca (localhost [127.0.0.1])
 by simark.ca (Postfix) with ESMTP id 85D191E1B0
 for <lttng-dev@lists.lttng.org>; Wed, 27 Apr 2016 23:04:30 -0400 (EDT)
In-Reply-To: <1461811940-8336-1-git-send-email-simon.marchi@polymtl.ca>
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

T24gMjAxNi0wNC0yNyAyMjo1MiwgU2ltb24gTWFyY2hpIHdyb3RlOgo+IFNpbmNlIHRoZXNlIGZp
bGVzIGFyZSBnZW5lcmF0ZWQgYnkgYXV0b2NvbmYsIHRoZXkgc2hvdWxkbid0IGJlIGluY2x1ZGVk
Cj4gaW4gU0NSSVBUX0xJU1QsIHdoaWNoIGlzIHRoZSBsaXN0IG9mIHNjcmlwdHMgdG8gY29weSBm
cm9tIHRoZSBzb3VyY2UKPiBkaXJlY3RvcnkgdG8gdGhlIGJ1aWxkIGRpcmVjdG9yeS4gIFRoaXMg
Z2V0cyByaWQgb2YgdGhlc2Ugd2FybmluZ3Mgd2hlbgo+IGJ1aWxkaW5nOgo+IAo+ICAgY3A6IGNh
bm5vdCBzdGF0Cj4gJy9ob21lL3NpbWFyay9zcmMvYmFiZWx0cmFjZS90ZXN0cy9saWIvdGVzdF9z
ZWVrX2JpZ190cmFjZSc6IE5vIHN1Y2gKPiBmaWxlIG9yIGRpcmVjdG9yeQo+ICAgY3A6IGNhbm5v
dCBzdGF0Cj4gJy9ob21lL3NpbWFyay9zcmMvYmFiZWx0cmFjZS90ZXN0cy9saWIvdGVzdF9zZWVr
X2VtcHR5X3BhY2tldCc6IE5vCj4gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+IAo+IFNpZ25lZC1v
ZmYtYnk6IFNpbW9uIE1hcmNoaSA8c2ltb24ubWFyY2hpQHBvbHltdGwuY2E+Cj4gLS0tCj4gIHRl
c3RzL2xpYi9NYWtlZmlsZS5hbSB8IDQgKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2xpYi9NYWtlZmls
ZS5hbSBiL3Rlc3RzL2xpYi9NYWtlZmlsZS5hbQo+IGluZGV4IGUyM2JjYzEuLmEwOGNiZjYgMTAw
NjQ0Cj4gLS0tIGEvdGVzdHMvbGliL01ha2VmaWxlLmFtCj4gKysrIGIvdGVzdHMvbGliL01ha2Vm
aWxlLmFtCj4gQEAgLTQxLDkgKzQxLDcgQEAgdGVzdF9idF92YWx1ZXNfU09VUkNFUyA9IHRlc3Rf
YnRfdmFsdWVzLmMKPiAgdGVzdF9jdGZfaXJfcmVmX1NPVVJDRVMgPSB0ZXN0X2N0Zl9pcl9yZWYu
Ywo+ICB0ZXN0X2J0X2N0Zl9maWVsZF90eXBlX3ZhbGlkYXRpb25fU09VUkNFUyA9IAo+IHRlc3Rf
YnRfY3RmX2ZpZWxkX3R5cGVfdmFsaWRhdGlvbi5jCj4gCj4gLVNDUklQVF9MSVNUID0gdGVzdF9z
ZWVrX2JpZ190cmFjZSBcCj4gLQl0ZXN0X3NlZWtfZW1wdHlfcGFja2V0IFwKPiAtCXRlc3RfY3Rm
X3dyaXRlcl9jb21wbGV0ZQo+ICtTQ1JJUFRfTElTVCA9IHRlc3RfY3RmX3dyaXRlcl9jb21wbGV0
ZQo+ICBFWFRSQV9ESVNUID0gdGVzdF9zZWVrX2JpZ190cmFjZS5pbiB0ZXN0X3NlZWtfZW1wdHlf
cGFja2V0LmluCj4gIENMRUFORklMRVM9IHRlc3Rfc2Vla19iaWdfdHJhY2UgdGVzdF9zZWVrX2Vt
cHR5X3BhY2tldAoKU29ycnksIGZvcmdvdCB0byBtZW50aW9uIHRoYXQgdGhpcyBzZXJpZXMgaXMg
bWVhbnQgZm9yIGJhYmVsdHJhY2UuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
