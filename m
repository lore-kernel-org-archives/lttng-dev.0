From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: "lttng enable-channel --tracefile-size" bug
Date: Fri, 3 Jun 2016 09:17:59 -0400
Message-ID: <20160603131759.GA2819__1025.57097930021$1464959920$gmane$org@sinkpad.home.lan>
References: <CANgVouVswhgXmy=Dge5h2FA-7xsaJfDqOZ3=seG5dHjP=_4gmA@mail.gmail.com>
 <57499B75.80203@efficios.com>
 <CANgVouUbJtNjBDajia1E3+CCEg95-=tnqfzBW7ukQxQbn9N_6Q@mail.gmail.com>
 <574B4791.905@efficios.com>
 <CANgVouUiQTn-TWVAwasG5VaO6jJbTvw+d9AqZbqjgfY4Y8iiig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id CB1BFA3784
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 13:18:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CANgVouUiQTn-TWVAwasG5VaO6jJbTvw+d9AqZbqjgfY4Y8iiig@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: John Smith <whalajam@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

PiB0aGFua3MsIGp1c3Qgb25lIG1vcmUgcXVlc3Rpb24sIEkgd291bGQgdGhpbmsgdGhhdCBpdCB3
b3VsZCBiZSBtb3JlCj4gZWZmaWNpZW50IHRvIGhhdmUgbXVsdGlwbGUgc3ViLWJ1ZmZlcnMgd3Jp
dGluZyB0byBhIGZpbGUgdmVyc3VzIG9uZQo+IHN1Yi1idWZmZXIgdG8gb25lIGZpbGUsLiBPZiBj
b3Vyc2UsIHdoZW4gdGhlIGZpbGUgZ2V0cyBvdmVyd3JpdHRlbgo+IChyb2xsZWQtb3ZlciBieSB0
aGUgdHJhY2VmaWxlLWNvdW50IG9wdGlvbikgIG11bHRpcGxlIHN1Yi1idWZmZXJzIGFyZQo+IGxv
c3QuICBEbyB5b3UgaGF2ZSBhbnkgdXNlIGNhc2UgcmVjb21tZW5kYXRpb24/ICBKb2huCgpJdCBh
bGwgZGVwZW5kcyBvbiB5b3VyIHVzZS1jYXNlLCB1c3VhbGx5IHRoZSB0cmFjZWZpbGUtY291bnQg
b3B0aW9uIGlzCnVzZWQgdG8ga2VlcCBhbiByZWxhdGl2ZWx5IHNob3J0IHRpbWUtZnJhbWUgaGlz
dG9yeSBvbiBkaXNrLCBzbyB0aGUgc2l6ZQp5b3Uga2VlcCBvbiBkaXNrIGlzIGRlcGVuZGFudCBv
biBob3cgbG9uZyB5b3Ugd2FudCB0aGlzIGhpc3RvcnkgdG8gYmUKYW5kIHRoZSByYXRlIGF0IHdo
aWNoIGV2ZW50cyBhcmUgcmVjb3JkZWQuCgpUaGUgc3ViLWJ1ZmZlciBzaXplIGlzIG5vdCBkaXJl
Y3RseSByZWxhdGVkIHRvIHRoaXMgb3B0aW9uLCB3aGVuIGEKdHJhY2VmaWxlIGlzIG92ZXJ3cml0
dGVuIGFsbCBpdHMgY29udGVudCBpcyB0cnVuY2F0ZWQgcmVnYXJkbGVzcyB0aGUKbnVtYmVyIG9m
IHN1Yi1idWZmZXJzLiBTbyBoYXZpbmcgMTAgc3ViLWJ1ZmZlcnMgb2YgNGsgb3IgMSBzdWItYnVm
ZmVyIG9mCjQwayBpcyBiYXNpY2FsbHkgdGhlIHNhbWUgdGhpbmcgZm9yIHRoZSB0cmFjZWZpbGUg
cm90YXRpb24uCgpJbiB0ZXJtcyBvZiBwZXJmb3JtYW5jZSwgaGFuZGxpbmcgdGhlIHJvdGF0aW9u
IGFkZHMgc29tZSB3b3JrIGZvciB0aGUKY29uc3VtZXJkIGFmdGVyIGV4dHJhY3RpbmcgdGhlIGRh
dGEsIHNvIGlmIGl0IGlzIHRvbyBmcmVxdWVudCwgeW91IG1pZ2h0CnNlZSBtb3JlIGRpc2NhcmRl
ZCBldmVudHMuIE9uIHRoZSBvdGhlciBoYW5kLCBpZiB5b3VyIHRyYWNlZmlsZXMgYXJlCnJlYWxs
eSBiaWcsIHdoZW4geW91IG92ZXJ3cml0ZSBvbmUsIHlvdSBsb29zZSBhIGxvdCBvZiBvbGQgZGF0
YSAobW9yZSBvcgpsZXNzIG9sZCBkZXBlbmRpbmcgb24gdGhlIHRyYWNlZmlsZS1jb3VudCBvcHRp
b24pLiBTbyBpdCByZWFsbHkgaXMgYQp0cmFkZW9mZiB5b3UgaGF2ZSB0byB0aGluayBhYm91dCB3
aXRoIHlvdXIgdXNlLWNhc2UuCgpJIGhvcGUgaXQgY2xhcmlmaWVzIHRoZSBzaXR1YXRpb24uCgpU
aGFua3MsCgpKdWxpZW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0
dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
