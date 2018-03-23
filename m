From: Khalid Elmously <khalid.elmously@canonical.com>
Subject: Re: [PATCH lttng-modules v2] Update: kvm
 instrumentation for ubuntu 4.13.0-38
Date: Fri, 23 Mar 2018 13:25:04 -0400
Message-ID: <20180323172502.spffualjqv7souf5__12648.7222420566$1521825868$gmane$org@kbuntu>
References: <b96ac777-0b5a-ae74-34fb-0a296491c1cd@efficios.com>
 <20180323155502.25625-1-khalid.elmously@canonical.com>
 <1493329339.3594.1521825088319.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.lttng.org (Postfix) with ESMTP id 4079Qt2sgYzxkc
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 13:25:09 -0400 (EDT)
Received: from mail-qt0-f198.google.com ([209.85.216.198])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <khalid.elmously@canonical.com>)
 id 1ezQRA-000546-By
 for lttng-dev@lists.lttng.org; Fri, 23 Mar 2018 17:25:08 +0000
Received: by mail-qt0-f198.google.com with SMTP id j8so8304325qti.23
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 10:25:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1493329339.3594.1521825088319.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMjAxOC0wMy0yMyAxMzoxMToyOCAsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOgo+IC0tLS0t
IE9uIE1hciAyMywgMjAxOCwgYXQgMTE6NTUgQU0sIEtoYWxpZCBFbG1vdXNseSBraGFsaWQuZWxt
b3VzbHlAY2Fub25pY2FsLmNvbSB3cm90ZToKPiAKPiA+IFN0YXJ0aW5nIGZyb20gNC4xMy4wLTM4
IHRoZSB1YnVudHUga2VybmVsIGJhY2twb3J0IGEga3ZtIGluc3RydW1lbnRhdGlvbgo+ID4gY2hh
bmdlIGludHJvZHVjZWQgaW4gNC4xNSB3aGljaCBhZmZlY3RzIHRoZSBwcm90b3R5cGUgb2YgdGhl
IGt2bV9tbWlvIGV2ZW50Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBLaGFsaWQgRWxtb3VzbHkg
PGtoYWxpZC5lbG1vdXNseUBjYW5vbmljYWwuY29tPgo+ID4gLS0tCj4gPiBpbnN0cnVtZW50YXRp
b24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0uaCB8IDIgKysKPiA+IDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9ldmVu
dHMvbHR0bmctbW9kdWxlL2t2bS5oCj4gPiBiL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmct
bW9kdWxlL2t2bS5oCj4gPiBpbmRleCA4ZjlhMTMyLi5jNDE5ZjljIDEwMDY0NAo+ID4gLS0tIGEv
aW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKPiA+ICsrKyBiL2luc3Ry
dW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2bS5oCj4gPiBAQCAtOTIsNiArOTIsOCBA
QCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKGt2bV9hY2tfaXJxLAo+ID4gCXx8IExUVE5HX0tFUk5F
TF9SQU5HRSg0LDEsNTAsIDQsMiwwKSBcCj4gPiAJfHwgTFRUTkdfS0VSTkVMX1JBTkdFKDMsMTYs
NTIsIDMsMTcsMCkgXAo+ID4gCXx8IExUVE5HX0tFUk5FTF9SQU5HRSgzLDIsOTcsIDMsMywwKSBc
Cj4gPiArCXx8IExUVE5HX1VCVU5UVV9LRVJORUxfUkFOR0UoNCwxMywxNiwzOCwgNCwxNCwwLDAp
IFwKPiA+ICsJfHwgTFRUTkdfVUJVTlRVX0tFUk5FTF9SQU5HRSg0LDE0LDAsMCwgNCwxNSwwLDAp
IFwKPiAKPiBJcyBpdCByZWFsbHkgYWxsIFVidW50dSBrZXJuZWxzIGZyb20gNC4xNC4wIHRvIDQu
MTUuMCB0aGF0Cj4gYXJlIGFmZmVjdGVkID8gSSBzdXNwZWN0IHRoYXQgaXQgZG9lcyBub3Qgc3Rh
cnQgYXQgLjAuCj4gCgpUaGFua3MuIFRoZSB0aGlyZCBudW1iZXIgKDAgaW4gdGhpcyBjYXNlKSBj
b21lcyBmcm9tIHRoZSB1cHN0cmVhbSBsaW51eC1zdGFibGUgdmVyc2lvbiBudW1iZXIuIElmIGEg
VWJ1bnR1IDQuMTQueC55IGtlcm5lbCB3ZXJlIGV2ZXIgdG8gZXhpc3QsIGl0IGNvdWxkIGNvbmNl
aXZhYmx5IHN0YXJ0IGF0IHggPSAwIGlmIGl0IHdhcyBiYXNlZCBkaXJlY3RseSBvbiBMaW51cycg
NC4xNCB0YWcuCgpUaGF0IGJlaW5nIHNhaWQsIGEgVWJ1bnR1IDQuMTQueC55IGtlcm5lbCBpcyBv
bmx5IGh5cG90aGV0aWNhbCBhcyBmYXIgYXMgSSBrbm93IGFuZCBwcm9iYWJseSB3b24ndCBldmVy
IGV4aXN0IHNvIEkgaGF2ZSBubyBpc3N1ZSB3aXRoIHNpbXBseSBpZ25vcmluZyBVYnVudHUgNC4x
NC54LnkgYWx0b2dldGhlci4KClNlbmRpbmcgYSB2MyBzaG9ydGx5LCB0aGFua3MuCgpLaGFsaWQu
CgoKCj4gVGhhbmtzLAo+IAo+IE1hdGhpZXUKPiAKPiA+IAl8fCBMVFROR19ERUJJQU5fS0VSTkVM
X1JBTkdFKDQsOSw2NSwwLDMsMCwgNCwxMCwwLDAsMCwwKSBcCj4gPiAJfHwgTFRUTkdfRkVET1JB
X0tFUk5FTF9SQU5HRSg0LDE0LDEzLDMwMCwgNCwxNSwwLDApKQo+ID4gCj4gPiAtLQo+ID4gMi4x
NC4xCj4gPiAKPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCj4gPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8v
bHR0bmctZGV2Cj4gCj4gLS0gCj4gTWF0aGlldSBEZXNub3llcnMKPiBFZmZpY2lPUyBJbmMuCj4g
aHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9s
dHRuZy1kZXYK
