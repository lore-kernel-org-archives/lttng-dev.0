From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-tools master,
 2.10-rc] Introduce "--blocking-timeout" channel parameter
Date: Mon, 12 Jun 2017 21:57:40 +0000 (UTC)
Message-ID: <397708306.11278.1497304660434.JavaMail.zimbra__19196.6529972435$1497304573$gmane$org@efficios.com>
References: <1495865859-25810-1-git-send-email-mathieu.desnoyers@efficios.com>
 <CA+jJMxs4K7XVqqdUk4CpB8=SDFh7pBAGTtNjHm6z2j0st3uxmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wmmwQ2M1gz11VM
 for <lttng-dev@lists.lttng.org>; Mon, 12 Jun 2017 21:57:42 +0000 (UTC)
In-Reply-To: <CA+jJMxs4K7XVqqdUk4CpB8=SDFh7pBAGTtNjHm6z2j0st3uxmg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

CgotLS0tLSBPbiBKdW4gMTIsIDIwMTcsIGF0IDU6MjggUE0sIEplcmVtaWUgR2FsYXJuZWF1IGpl
cmVtaWUuZ2FsYXJuZWF1QGVmZmljaW9zLmNvbSB3cm90ZToKCgo+Pgo+PiArICAgICAgIC8qIFJl
dHJ5IHRpbWVvdXQgaW4gdXNlYyAqLwo+IAo+IFRoZSB1bml0IGNvbnZlcnNpb24gaXMgY29uZnVz
aW5nIGluIHRoaXMgcGF0Y2guCj4gCj4gVGhlIHVzZXItcHJvdmlkZWQgKENMSSkgYXJndW1lbnQg
aXMgaW4gdXNlYyBhbmQgaXMgdGhlbiBjb252ZXJ0ZWQgdG8KPiBtc2VjIGJ5IHRoZSBjbGllbnQs
IGJlZm9yZSBiZWluZyB1c2VkIGFzIG1zZWMgd2l0aCBsaWJsdHRuZy1jdGwKPiBmdW5jdGlvbnMu
IFRoZW4sIGl0IGlzIHJldHJpZXZlZCBhbmQgb3V0cHV0IGFzLWlzIChpbiBtc2VjKSBoZXJlIGFu
ZAo+IGluIHRoZSBodW1hbi1yZWFkYWJsZSBsaXN0aW5nLgo+IAo+IEknbGwgbW92ZSB0aGUgdW5p
dCBjb252ZXJzaW9uIHRvIGEgc2luZ2xlIHBsYWNlIChiZWZvcmUgd2UgaGFuZC1vZmYKPiB0aGUg
ZGVsYXkgdG8gbHR0bmctdXN0KSBzaW5jZSB0aGUgY3VycmVudCBjb252ZW50aW9uIGlzIHRvIHN0
b3JlIGFuZAo+IGV4cG9zZSBhbGwgdGltZXJzIGluIHVzZWMuCj4gCgpBcyBkaXNjdXNzZWQsIHRo
ZSBDTEkgb25seSBkb2VzIGFuIG92ZXJmbG93IGNoZWNrLCBub3QgYSBjb252ZXJzaW9uLgpMZXQn
cyBzaW1wbHkgYWRkIHRoaXMgb3ZlcmZsb3cgY2hlY2sgaW4gdGhlIGxpYiB0b28sIHNvIHdlIGNh
bgpyZXR1cm4gImludmFsaWQgcGFyYW1ldGVyIiB0byB0aGUgY2FsbGVyLgoKPiBJJ2xsIGFsc28g
b3BlbiBhbiBpc3N1ZSB0byBhZGQgdGhpcyBwcm9wZXJ0eSBhcyBwYXJ0IG9mIHRoZQo+ICJzYXZl
L2xvYWQiIGZ1bmN0aW9uYWxpdHkgYmVmb3JlIHRoZSByZWFsZWFzZS4KCk9LLAoKVGhhbmtzIQoK
TWF0aGlldQoKLS0gCk1hdGhpZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
