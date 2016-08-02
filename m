From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: about how to trouble-shooting when lttng-sessiond
 crash happens.
Date: Tue, 2 Aug 2016 15:09:48 -0400
Message-ID: <CA+jJMxv8+_t5GXtD5iPG5fa9fc=2DCcUDqmftRS-uNuwmO=7dQ__31765.7230109491$1470165010$gmane$org@mail.gmail.com>
References: <BA3C5551E429FF4696E330920448E90B1A2D72D0@ESGSCMB101.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com
 [209.85.213.47])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 75C4DA2ABE
 for <lttng-dev@lists.lttng.org>; Tue,  2 Aug 2016 19:09:50 +0000 (UTC)
Received: by mail-vk0-f47.google.com with SMTP id w127so129925736vkh.2
 for <lttng-dev@lists.lttng.org>; Tue, 02 Aug 2016 12:09:50 -0700 (PDT)
In-Reply-To: <BA3C5551E429FF4696E330920448E90B1A2D72D0@ESGSCMB101.ericsson.se>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jenny Gu <jenny.gu@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgSmVubnksCgpMVFRuZyAyLjUgaGFzIGJlZW4gdW5zdXBwb3J0ZWQgZm9yIGEgd2hpbGUgbm93
LiBUaGUgb2xkZXN0IHN1cHBvcnRlZAp2ZXJzaW9uIGlzIExUVG5nIDIuNy4gWW91IG1heSB3YW50
IHRvIHVwZGF0ZSB0byB0aGUgbGF0ZXN0IExUVG5nIDIuOC54CnJlbGVhc2UgYW5kIHNlZSBpZiB0
aGUgcHJvYmxlbSBwZXJzaXN0cy4KCkFzIGZvciBob3cgdG8gY29sbGVjdCBhIGJhY2sgdHJhY2Us
IGlmIHlvdSBoYXZlIGNvbGxlY3RlZCBhIGNvcmUgZmlsZSwKb3BlbiBpdCBpbiBHREIgYW5kIHVz
ZToKCihnZGIpIHRocmVhZCBhcHBseSBhbGwgYnQgZnVsbAoKVGhpcyBzaG91bGQgcHJvdmlkZSB5
b3Ugd2l0aCBhIGNvbXBsZXRlIGJhY2sgdHJhY2Ugb2YgYWxsIHRocmVhZHMgYXQKdGhlIHRpbWUg
b2YgdGhlIGNyYXNoLgoKUmVnYXJkcywKSsOpcsOpbWllCgpPbiBUdWUsIEp1bCAyNiwgMjAxNiBh
dCA1OjAzIEFNLCBKZW5ueSBHdSA8amVubnkuZ3VAZXJpY3Nzb24uY29tPiB3cm90ZToKPiBIaSBh
bGwsCj4KPgo+Cj4gV2XigJlyZSBub3cgYXBwbHlpbmcgbHR0bmcgMi41IGluIG91ciBzeXN0ZW0g
YnV0IHdlIGV4cGVyaWVuY2VkIGx0dG5nLXNlc3Npb25kCj4gY3Jhc2guIENvdWxkIHlvdSBzaG93
IGhvdyB0byBkdW1wIHRoZSBiYWNrIHRyYWNlIG9mIHRoZSBjb3JlPyBUaGFua3MgdmVyeQo+IG11
Y2guCj4KPgo+Cj4gQlJzLAo+Cj4gSmVubnkuCj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gbHR0bmctZGV2IG1haWxpbmcgbGlzdAo+IGx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKPiBodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21h
aWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZm
aWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRl
dkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFu
L2xpc3RpbmZvL2x0dG5nLWRldgo=
