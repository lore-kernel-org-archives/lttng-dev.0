From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH babeltrace] ctf-writer: Add support for
 the cpu_id field
Date: Tue, 03 Jun 2014 09:39:56 +0200
Message-ID: <538D7BCC.7080800__4825.37830616838$1401781247$gmane$org@linutronix.de>
References: <1401178102-9731-1-git-send-email-bigeasy@linutronix.de>
 <CA+jJMxt4+T0iLx0EJHJz9Fm1oSxiJ6B1oOuwQ+BsQaLCBT_bxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>) id 1WrjKE-0005UZ-OA
 for lttng-dev@lists.lttng.org; Tue, 03 Jun 2014 03:40:03 -0400
In-Reply-To: <CA+jJMxt4+T0iLx0EJHJz9Fm1oSxiJ6B1oOuwQ+BsQaLCBT_bxQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?B?SsOpcsOpbWllIEdhbGFybmVhdQ==?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

T24gMDYvMDIvMjAxNCAwNzowOCBQTSwgSsOpcsOpbWllIEdhbGFybmVhdSB3cm90ZToKPiBIaSBT
ZWJhc3RpYW4sCgpIaSBKw6lyw6ltaWUsCgo+IEknZCBwcmVmZXIgd2UgcHJvdmlkZSBhIGdlbmVy
aWMgd2F5IG9mIGFkZGluZyBmaWVsZHMgdG8gdGhlIHBhY2tldAo+IGNvbnRleHQuIFNvbWV0aGlu
ZyBha2luIHRvIHdoYXQncyBwcm92aWRlZCBmb3Igc3RydWN0dXJlcyB3aGljaCB3b3VsZAo+IGxl
dCB1c2VycyBkZWZpbmUgYXJiaXRyYXJ5IHBhY2tldCBjb250ZXh0IGZpZWxkcy4KPiAKPiBJIHBy
b3Bvc2UgYWRkaW5nCj4gCj4gaW50IGJ0X2N0Zl9zdHJlYW1fY2xhc3NfYWRkX3BhY2tldF9jb250
ZXh0X2ZpZWxkKGNvbnN0IGNoYXIKPiAqZmllbGRfbmFtZSwgc3RydWN0IGJ0X2N0Zl9maWVsZF90
eXBlICpmaWVsZF90eXBlKTsKPiAKPiBhbmQKPiAKPiBzdHJ1Y3QgYnRfY3RmX2ZpZWxkICpidF9j
dGZfc3RyZWFtX2dldF9wYWNrZXRfY29udGV4dF9maWVsZChjb25zdCBjaGFyCj4gKmZpZWxkX25h
bWUpOwo+IAo+IEknbSBvcGVuIHRvIGJldHRlciBuYW1pbmcgc3VnZ2VzdGlvbnMsIGJ1dCBob3Bl
ZnVsbHkgSSdtIGdldHRpbmcgdGhlCj4gZnVuY3Rpb25hbGl0eSBhY3Jvc3MuCj4gCj4gVGhvdWdo
dHM/Ckxvb2tzIGxpa2UgYSBmZXcgbGluZXMgbW9yZSB0aGFuIHdoYXQgSSBob3BlZCBmb3IuIExl
dCBtZSB0cnkgeW91ciB3YXkuClNvIHdoYXQgeW91IHN1Z2dlc3QgaXMgc29tZXRoaW5nIGxpa2Ug
dGhhdDoKCi0tLQpzdHJ1Y3QgYnRfY3RmX2ZpZWxkX3R5cGUgKmNwdV9udW07CgpjcHVfbnVtID0g
YnRfY3RmX2ZpZWxkX3R5cGVfaW50ZWdlcl9jcmVhdGUoMzEpOwoKYnRfY3RmX2ZpZWxkX3NpZ25l
ZF9pbnRlZ2VyX3NldF92YWx1ZShjcHVfbnVtLCAyKTsKYnRfY3RmX3N0cmVhbV9jbGFzc19hZGRf
cGFja2V0X2NvbnRleHRfZmllbGQoImNwdSIsIGNwdV9udW0pOwoKLS0tCgphbmQgdGhlbiBJIHRy
eSB0byBjaGFuZ2UgdGhlIENQVSBudW1iZXIgSSBoYXZlIHRvCmJ0X2N0Zl9maWVsZF9zaWduZWRf
aW50ZWdlcl9zZXRfdmFsdWUoKSArIGZsdXNoIGxpa2UgSSBkaWQgYmVmb3JlLApyaWdodD8KRm9y
IHRoYXQgdG8gd29yayBJIHdvdWxkIGhhdmUgdG8ga2VlcCBhbiBhcnJheSBvZiBldmVyeXRoaW5n
IHRoYXQgY2FtZQp2aWEgYnRfY3RmX3N0cmVhbV9jbGFzc19hZGRfcGFja2V0X2NvbnRleHRfZmll
bGQoKSBhbmQgYXR0YWNoIHRvIHN0cnVjdApidF9jdGZfc3RyZWFtICBzbyBJIGhhdmUgdGhvc2Ug
ZmllbGRzIGluIGluaXRfcGFja2V0X2NvbnRleHQoKS4KCklzIHRoaXMgd2hhdCB5b3UgaGFkIGlu
IG1pbmQ/Cgo+IAo+IErDqXLDqW1pZQoKU2ViYXN0aWFuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4v
bGlzdGluZm8vbHR0bmctZGV2Cg==
