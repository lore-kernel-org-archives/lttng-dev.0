From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: Unable to use libbabeltrace for trace reading in C
 program
Date: Tue, 23 Feb 2016 19:13:05 -0500
Message-ID: <20160224001305.GB14724__22804.7512741343$1456272859$gmane$org@sinkpad>
References: <CE3666D6-C823-40D2-914A-83E17C0FDAA1@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1aYN57-0001oI-W4
 for lttng-dev@lists.lttng.org; Tue, 23 Feb 2016 19:13:30 -0500
Content-Disposition: inline
In-Reply-To: <CE3666D6-C823-40D2-914A-83E17C0FDAA1@inria.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexis Martin <alexis.martin@inria.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgo+IEhpLAo+IAo+IEnigJltIHRyeWluZyB0byB1c2UgdGhlIGJhYmVsdHJhY2UgbGlicmFy
eSB0byBiZSBhYmxlIHRvIGxvYWQgYW5kIHJlYWQgYSBDVEYgdHJhY2UgaW4gYSBDIHByb2dyYW0u
Cj4gCj4gRnJvbSB0aGUgZG9jOgo+IAo+ID4gSW4gb3JkZXIgdG8gdXNlIGxpYmJhYmVsdHJhY2Ug
dG8gcmVhZCBhIHRyYWNlLCB0aGUgZmlyc3Qgc3RlcCBpcyB0byBjcmVhdGUgYQo+ID4gY29udGV4
dCBzdHJ1Y3R1cmUgYW5kIHRvIGFkZCBhIHRyYWNlIHRvIGl0LiBUaGlzIGlzIGRvbmUgdXNpbmcg
dGhlCj4gPiBidF9jb250ZXh0X2NyZWF0ZSgpIGFuZCBidF9jb250ZXh0X2FkZF90cmFjZSgpIGZ1
bmN0aW9ucy4gQXMgbG9uZyBhcyB0aGlzCj4gPiBjb250ZXh0IHN0cnVjdHVyZSBpcyBhbGxvY2F0
ZWQgYW5kIHRoZSB0cmFjZSBpcyB2YWxpZCwgdGhlIHRyYWNlIGNhbiBiZQo+ID4gbWFuaXB1bGF0
ZWQgYnkgdGhlIGxpYnJhcnkuCj4gCj4gCj4gQnV0IGZvciBhIHNpbXBsZSBwcm9ncmFtIGxpa2Ug
dGhpczoKPiAKPiA+ICNpbmNsdWRlIDxzdGRpby5oPgo+ID4gI2luY2x1ZGUgPGJhYmVsdHJhY2Uv
Y29udGV4dC5oPgo+ID4gCj4gPiBpbnQgbWFpbih2b2lkKXsKPiA+IAo+ID4gICAgIHN0cnVjdCBi
dF9jb250ZXh0ICpjdHggPSBidF9jb250ZXh0X2NyZWF0ZSgpOwo+ID4gICAgIAo+ID4gICAgIGlu
dCByZXQgPSBidF9jb250ZXh0X2FkZF90cmFjZShjdHgsICIvaG9tZS9hbGV4L3RyYWNlL2ZmbXBl
Zy9rZXJuZWwvIiwgImN0ZiIsIE5VTEwsIE5VTEwsIE5VTEwpOwo+ID4gCj4gPiAgICAgcmV0dXJu
IHJldDsKPiA+IAo+ID4gfQo+IAo+IAo+IEkgZ290IHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2Fn
ZToKPiAKPiA+IFtlcnJvcl0gW0NvbnRleHRdIEZvcm1hdCAiY3RmIiB1bmtub3duLgoKSXQgc291
bmRzIGxpa2UgYSBsaW5raW5nIHByb2JsZW0sIHRyeSB0byBjb21waWxlIHdpdGggdGhpcywgaXQg
c2hvdWxkCndvcms6CmdjYyAtbyBhIGEuYyAtbGJhYmVsdHJhY2UgLVdsLC0tbm8tYXMtbmVlZGVk
IC1sYmFiZWx0cmFjZS1jdGYKCkkgZG9uJ3Qga25vdyBpZiB0aGVyZSBpcyBhIGNsZWFuZXIgc29s
dXRpb24sIG90aGVycyB3aWxsIGtub3cuCgpCYWJlbHRyYWNlIGRpc2NvdmVycyBpdHMgc3VwcG9y
dGVkIGZvcm1hdHMgd2l0aCB0aGUgbGlicmFyaWVzIGxvYWRlZAp3aGVuIHRoZSBwcm9ncmFtIHN0
YXJ0cy4KCkp1bGllbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
