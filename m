From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Listing live sessions after a session is destroyed
Date: Thu, 30 Oct 2014 14:41:22 -0400
Message-ID: <CA+jJMxs-gDcAqBBvwfRQA40uLjmdXZTBJCyafp+8vTN=BZZnJA__6097.87973012335$1414694537$gmane$org@mail.gmail.com>
References: <D381217948BF4C45AF756AFC995BEB9F1C2EBF68@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Xjuf3-0004mn-2b
 for lttng-dev@lists.lttng.org; Thu, 30 Oct 2014 14:41:31 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so5007495lab.13
 for <lttng-dev@lists.lttng.org>; Thu, 30 Oct 2014 11:41:22 -0700 (PDT)
In-Reply-To: <D381217948BF4C45AF756AFC995BEB9F1C2EBF68@eusaamb103.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Marc=2DAndr=C3=A9_Laperle?= <marc-andre.laperle@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gV2VkLCBPY3QgMjksIDIwMTQgYXQgNTozOSBQTSwgTWFyYy1BbmRyw6kgTGFwZXJsZQo8bWFy
Yy1hbmRyZS5sYXBlcmxlQGVyaWNzc29uLmNvbT4gd3JvdGU6Cj4gSSBoYXZlIGEgdmlld2VyIGNv
bm5lY3RlZCB0byByZWxheWQgYW5kIGF0dGFjaGVkIHRvIGEgc2Vzc2lvbiBuYW1lZCAibGl2ZSIu
Cj4gVGhlIHNlc3Npb24gaXMgc3RhcnRlZCB0aGVuIGRlc3Ryb3llZC4gVGhlbiBJIGxpc3QgdGhl
IHNlc3Npb25zIHVzaW5nIHRoZQo+IHNhbWUgdmlld2VyIGFuZCBpdCByZXR1cm5zIHRoZSBkZXN0
cm95ZWQgc2Vzc2lvbi4gSWYgSSB0cnkgdG8gYXR0YWNoIHRvIGl0LAo+IGl0IHJldHVybnMgYSBz
dGF0dXMgTFRUTkdfVklFV0VSX0FUVEFDSF9BTFJFQURZLiBJIHRoaW5rIHRoaXMgc2Vzc2lvbiBz
aG91bGQKPiBub3QgYmUgbGlzdGVkIG9yIHRoZXJlIHNob3VsZCBiZSBhIHN0YXR1cyB0aGF0IGlu
ZGljYXRlcyB0aGF0IHRoZSBzZXNzaW9uCgpIaSBNYXJjLUFuZHLDqSwKClRoYXQgZG9lcyBsb29r
IGxpa2UgYSBidWcuIFdvdWxkIHlvdSBtaW5kIG9wZW5pbmcgYSBidWcgb24KYnVncy5sdHRuZy5v
cmcgZGVzY3JpYmluZyB0aGUgc3RlcHMgeW91IHRha2UgYWxvbmcgd2l0aCB0aGUgYmFiZWx0cmFj
ZQooYXNzdW1pbmcgdGhpcyBpcyB0aGUgdmlld2VyIHlvdSBhcmUgdXNpbmcpIGFuZCByZWxheWQg
dmVyYm9zZSBsb2dzPwoobGF1bmNoIGJvdGggd2l0aCAtdnZ2KQoKPiBkb2Vzbid0IGV4aXN0IGFu
eW1vcmUuIE9yIGlzIGl0IGV4cGVjdGVkIHRoYXQgSSBjcmVhdGUgYSBuZXcgdmlld2VyIGJlZm9y
ZQo+IGxpc3RpbmcgdGhlIHNlc3Npb25zIGFnYWluPwoKV2hhdCBkbyB5b3UgbWVhbiBieSAiY3Jl
YXRpbmcgYSBuZXcgdmlld2VyIj8KClJlZ2FyZHMsCkrDqXLDqW1pZQoKPgo+IFRoYW5rIHlvdSBm
b3IgdGhlIGhlbHAhCj4gTWFyYy1BbmRyZQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwo+IGh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxp
c3RzLmx0dG5nLm9yZwpodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
