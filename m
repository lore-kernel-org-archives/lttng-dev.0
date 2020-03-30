From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: babletrace2 graph performance considerations
Date: Mon, 30 Mar 2020 18:26:57 -0400
Message-ID: <1cc5fee9-487d-61f5-6376-8b3d40dc47f5@simark.ca>
References: <CADtyBo6B4YQ++VPhM4-cAfKYq0otJMg4zMXvQYqyNw3JsSX6Nw@mail.gmail.com>
 <9b2fe91b-4f44-3b89-eaf9-98f945384a33@simark.ca>
 <CADtyBo7EBkHsDv-=-94oFnuviFvHnYQW_R6vHv08QCfo8QTyqg@mail.gmail.com>
Reply-To: Simon Marchi <simark@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48rnBX0rWyz1Yvc
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 18:26:59 -0400 (EDT)
In-Reply-To: <CADtyBo7EBkHsDv-=-94oFnuviFvHnYQW_R6vHv08QCfo8QTyqg@mail.gmail.com>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rocky Dunlap <dunlap@ucar.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAyMC0wMy0zMCAxOjMwIHAubS4sIFJvY2t5IER1bmxhcCB3cm90ZToKPiBJbiBteSBjYXNl
IEkgaGF2ZSBDVEYgdHJhY2Ugd2hlcmUgc29tZSBhbmFseXNlcyBjYW4gYmUgcGVyZm9ybWVkIG9u
IGEgcGVyLXN0cmVhbSBiYXNpcyAobm8gbmVlZCB0byBtdXggdGhlIHN0cmVhbXMgdG9nZXRoZXIp
LsKgIEluIHRoaXMgY2FzZSwgSSB3YXMgdGhpbmtpbmcgdGhhdCBpdCB3b3VsZCBtYWtlIHNlbnNl
IHRvIHRocmVhZCBvdmVyIHRoZSBzdHJlYW1zLsKgIEhvd2V2ZXIsIEkgdGhpbmsgY2FuIGVhc2ls
eSBkbyB0aGlzIGF0IGEgbGV2ZWwgYWJvdmUgdGhlIGdyYXBoIHNpbXBseSBieSBjcmVhdGluZyBt
dWx0aXBsZSBncmFwaHMgd2hlcmUgZWFjaCBvbmUgaXMgaGFuZGxpbmcgYSBzaW5nbGUgc3RyZWFt
LsKgIEluIG15IGNhc2UgSSBhbSB0aGlua2luZyB0aGlzIHdpbGwgYmUgbW9zdGx5IEkvTyBib3Vu
ZCwgc28gSSdtIG5vdCBzdXJlIHdoYXQga2luZCBvZiBwYXlvZmYgdGhlIHRocmVhZHMgd2lsbCBn
aXZlLsKgIE92ZXJhbGwsIEkganVzdCB3YW50IHRvIG1ha2Ugc3VyZSB0aGF0IEkgYW0gbm90IGRv
aW5nIGFueXRoaW5nIHRoYXQgd291bGQsIGluIHRoZSBsb25nIHJ1biwgcHJlY2x1ZGUgdGhyZWFk
aW5nL2NvbmN1cnJlbmN5IGlmIGl0IGlzIGFkZGVkIHRvIHRoZSBncmFwaCBtb2RlbCBpdHNlbGYu
CgpDcmVhdGluZyBtdWx0aXBsZSBncmFwaHMgYW5kIGhhbmRsaW5nIGEgc2luZ2xlIHN0cmVhbSBp
biBlYWNoIHdvdWxkCndvcmssIGJ1dCBlYWNoIGdyYXBoIHdvdWxkIGVuZCB1cCByZWFkaW5nIGFu
ZCBwYXJzaW5nIHRoZSB3aGlsZSBDVEYKdHJhY2UsIHdoaWNoIGlzIG5vdCBncmVhdC4KCklmIHlv
dSBzdHJlYW1zIGFyZSBpbiBhIGRhdGEgZmlsZSBvZiB0aGVpciBvd24sIHlvdSBjb3VsZCBtb3Zl
IHRoZW0KdG8gdGhlaXIgb3duIGRpcmVjdG9yeSwgZWFjaCB3aXRoIGEgY29weSBvZiB0aGUgbWV0
YWRhdGEsIGVmZmVjdGl2ZWx5CmNyZWF0aW5nIG9uZSB0cmFjZSBmb3IgZWFjaC4gIFRoZW4gY3Jl
YXRlIG9uZSBncmFwaCBmb3IgZWFjaCB0cmFjZS4KCkkgY2FuJ3QgcmVhbGx5IHRlbGwgeW91IHJp
Z2h0IG5vdyBob3cgdG8gZGVzaWduIHlvdXIgY29tcG9uZW50cyB0byB3b3JrCndpdGggYSBmdXR1
cmUgbW9kZWwgd2hlcmUgdGhlcmUgaXMgY29uY3VycmVuY3ksIHNpbmNlIHRoYXQgbW9kZWwgZG9l
cwpub3QgZXhpc3QgeWV0IDopLgoKU2ltb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
