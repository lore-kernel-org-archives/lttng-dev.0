From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] FIX: Align buffers on 4 bytes for 64bit
	access
Date: Thu, 15 May 2014 15:36:51 -0400
Message-ID: <CA+jJMxt=fh0FW7VNmpnZwrZ9JtBhAAGuJKbrxDrEKt+nSw95FQ__47983.3814817995$1400182687$gmane$org@mail.gmail.com>
References: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Wl1Sc-0004D0-Uk
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 15:37:04 -0400
Received: by mail-qg0-f52.google.com with SMTP id a108so2605582qge.11
 for <lttng-dev@lists.lttng.org>; Thu, 15 May 2014 12:36:51 -0700 (PDT)
In-Reply-To: <1400144250-26852-1-git-send-email-rongqing.li@windriver.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: rongqing.li@windriver.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVGh1LCBNYXkgMTUsIDIwMTQgYXQgNDo1NyBBTSwgIDxyb25ncWluZy5saUB3aW5kcml2ZXIu
Y29tPiB3cm90ZToKPiBGcm9tOiBGcmVkcmlrIE1hcmtzdHLDtm0gPGZyZWRyaWsubWFya3N0cm9t
QGdtYWlsLmNvbT4KPgo+IFNpZ25lZC1vZmYtYnk6IEZyZWRyaWsgTWFya3N0cuaemm0gPGZyZWRy
aWsubWFya3N0cm9tQGdtYWlsLmNvbT4KPiAtLS0KPiAgZm9ybWF0cy9jdGYvbWV0YWRhdGEvb2Jq
c3RhY2suYyB8ICAgIDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2Zvcm1hdHMvY3RmL21ldGFkYXRhL29ianN0YWNrLmMgYi9mb3JtYXRzL2N0
Zi9tZXRhZGF0YS9vYmpzdGFjay5jCj4gaW5kZXggOWUyNjRhNC4uOTY0M2I5YiAxMDA2NDQKPiAt
LS0gYS9mb3JtYXRzL2N0Zi9tZXRhZGF0YS9vYmpzdGFjay5jCj4gKysrIGIvZm9ybWF0cy9jdGYv
bWV0YWRhdGEvb2Jqc3RhY2suYwo+IEBAIC0xMTgsNiArMTE4LDggQEAgdm9pZCAqb2Jqc3RhY2tf
YWxsb2Moc3RydWN0IG9ianN0YWNrICpvYmpzdGFjaywgc2l6ZV90IGxlbikKPiAgICAgICAgIHN0
cnVjdCBvYmpzdGFja19ub2RlICpsYXN0X25vZGU7Cj4gICAgICAgICB2b2lkICpwOwo+Cj4gKyAg
ICAgICBsZW4gPSAobGVuICsgMykgJiB+MzsKClBsZWFzZSB1c2UgdGhlICJBTElHTiIgbWFjcm8g
ZGVmaW5lZCBpbiBpbmNsdWRlL2JhYmVsdHJhY2UvYWxpZ24uaC4KbGVuID0gQUxJR04obGVuLCBz
aXplb2YodW5zaWduZWQgbG9uZykpCgpBbHNvLCB0aGUgImRhdGEiIG1lbWJlciBpbiBzdHJ1Y3Qg
b2Jqc3RhY2tfbm9kZSBzaG91bGQgYmUgYWxpZ25lZC4KCnN0cnVjdCBvYmpzdGFja19ub2RlIHsK
ICBzdHJ1Y3QgYnRfbGlzdF9oZWFkIG5vZGU7CiAgc2l6ZV90IGxlbjsKICBzaXplX3QgdXNlZF9s
ZW47CiAgY2hhciBfX2F0dHJpYnV0ZV9fICgoYWxpZ25lZCAoc2l6ZW9mKHVuc2lnbmVkIGxvbmcp
KSkpIGRhdGFbXTsKfTsKClRoYW5rcyBmb3IgYnJpbmdpbmcgdGhlIHByb2JsZW0gdG8gb3VyIGF0
dGVudGlvbiEgSSdsbCB3YWl0IGZvciBhIHYyLgoKUmVnYXJkcywKSsOpcsOpbWllCgo+ICsKPiAg
ICAgICAgIC8qIEdldCBsYXN0IG5vZGUgKi8KPiAgICAgICAgIGxhc3Rfbm9kZSA9IGJ0X2xpc3Rf
ZW50cnkob2Jqc3RhY2stPmhlYWQucHJldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgb2Jqc3RhY2tfbm9kZSwgbm9kZSk7Cj4gLS0KPiAxLjcuMTAuNAo+Cj4KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0dG5nLWRldiBtYWlsaW5n
IGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cDovL2xpc3RzLmx0dG5nLm9y
Zy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2CgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
