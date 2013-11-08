From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Using userspace tracepoints with icc
Date: Fri, 8 Nov 2013 13:55:46 +0000 (UTC)
Message-ID: <246183477.63073.1383918946763.JavaMail.zimbra__935.535311191593$1383918991$gmane$org@efficios.com>
References: <527C6D8D.1010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VemXN-0005LS-DI
	for lttng-dev@lists.lttng.org; Fri, 08 Nov 2013 08:55:51 -0500
In-Reply-To: <527C6D8D.1010103@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?Q?Rapha=C3=ABl?= Beamonte <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJSYXBoYcOrbCBCZWFtb250ZSIg
PHJhcGhhZWwuYmVhbW9udGVAZ21haWwuY29tPgo+IFRvOiBsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDcsIDIwMTMgMTE6NTA6MjEgUE0KPiBTdWJq
ZWN0OiBbbHR0bmctZGV2XSBVc2luZyB1c2Vyc3BhY2UgdHJhY2Vwb2ludHMgd2l0aCBpY2MKPiAK
PiBIZWxsbyBmb2xrcywKPiAKPiBBIGZldyB3ZWVrcyBhZ28sIEkgd2FzIHdvcmtpbmcgb24gYW4g
YXBwbGljYXRpb24gd2hpY2ggdXNlZCBpY2MgKHRoZQo+IEludGVsIEMgQ29tcGlsZXIpIHRvIGNv
bXBpbGUgaXRzIHNvdXJjZXMuIEkgd2FudGVkIHRvIHRyYWNlIGl0IGJ1dAo+IHdhc24ndCBhYmxl
IHRvIGNvbXBpbGUgd2l0aCB0aGUgdHJhY2Vwb2ludHMsIHRoZSAiLmMiIGZpbGUgd2FzIHNwYXdu
aW5nCj4gYSAiOiBpbnRlcm5hbCBlcnJvcjogYmFja2VuZCBzaWduYWwiIGZyb20gaWNjLiBTdGls
bCwgdGhlcmUgaXMgYQo+IHdvcmthcm91bmQgdG8gYmUgYWJsZSB0byB0cmFjZS4KPiAKPiBVc2lu
ZyBnY2MgdG8gY29tcGlsZSB0aGUgdHJhY2Vwb2ludHMgKG9yIHVzaW5nIHRoZSBvYmplY3QgZmls
ZSBnZW5lcmF0ZWQKPiBieSBsdHRuZy1nZW4tdHAsIHdoaWNoIHVzZXMgZ2NjKSBhbmQgbGlua2lu
ZyB0aGUgb2JqZWN0IGZpbGUgdG8gdGhlCj4gYXBwbGljYXRpb24gd29ya2VkIGxpa2UgYSBjaGFy
bS4gSXQgaXMgbm90IHRoZSBiZXN0IHdheSBhcyBpdCBmb3JjZXMgdG8KPiB1c2UgdHdvIGRpZmZl
cmVudCBjb21waWxlcnMsIGJ1dCBpdCBzdGlsbCBhbGxvd3MgdG8gdHJhY2UuCj4gCj4gSnVzdCB0
aG91Z2h0IEknZCBzaGFyZSB0aGlzIHdvcmthcm91bmQgaWYgc29tZW9uZSBlbHNlIHNlYXJjaCBo
b3cgdG8gdXNlCj4gTFRUbmctVVNUIHdpdGggaWNjLgoKWW91IG1pZ2h0IHdhbnQgdG8gcmVwb3J0
IHRoaXMgaW50ZXJuYWwgY29tcGlsZXIgZXJyb3IgdG8gdGhlIEludGVsIGZvbGtzIHJlc3BvbnNp
YmxlIGZvciBpY2MuCgpUaGFua3MsCgpNYXRoaWV1Cgo+IAo+IFJhcGhhw6tsCj4gCj4gCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYg
bWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+IAoKLS0gCk1hdGhp
ZXUgRGVzbm95ZXJzCkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWls
aW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
