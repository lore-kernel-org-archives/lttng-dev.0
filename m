From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Thu, 1 Jun 2017 18:26:03 -0400
Message-ID: <CA+jJMxvUXUDVFMwYHX=ZxoK=K6OiFEwSvMMCVpw2uHebZwXgZQ__35760.9209990644$1496356502$gmane$org@mail.gmail.com>
References: <A82E93B1-509F-424C-B36F-7011D685BDC9@gmail.com>
 <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
 <CAA85PfLgiW329AhYcSbup+8jBz=25-pEM7LUC962ucUc3M6Gkw@mail.gmail.com>
 <CA+jJMxs-d6vZ4Q3t6UvDeqOqwYyyoVHtqrEw1uGuomovB_ohLw@mail.gmail.com>
 <eb2eec76-8ad8-bea2-5933-629ac1f1df07@efficios.com>
 <CA+jJMxs2=ua4LsaPS9DqBGY6gdLQqjCaibhnPYLt5k9d7Ke42Q@mail.gmail.com>
 <019415e6-017c-09b9-7f4a-0df71b51fc1a@efficios.com>
 <CA+jJMxvnbQuvPTR0uWw=XNXR-FARxyErDJhkND9kUwDUrLvNzQ@mail.gmail.com>
 <9EB290C2-A968-4B16-9A1D-AA7BC38E2DE5@gmail.com>
 <CA+jJMxuYV8nN0kgseMnO6Psgpk_XYsndyM93Rus5xv4Z-GX1_w@mail.gmail.com>
 <EF993367-57FA-41C2-A147-A9A7BC1439D6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 by lists.lttng.org (Postfix) with ESMTPS id 3wf25l3gCXz12Sc
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 22:27:23 +0000 (UTC)
Received: by mail-yw0-x241.google.com with SMTP id p144so3616755ywp.2
 for <lttng-dev@lists.lttng.org>; Thu, 01 Jun 2017 15:26:04 -0700 (PDT)
In-Reply-To: <EF993367-57FA-41C2-A147-A9A7BC1439D6@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?D=C3=A1vid_Beck?= <david.beck.priv@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMSBKdW5lIDIwMTcgYXQgMTg6MDMsIETDoXZpZCBCZWNrIDxkYXZpZC5iZWNrLnByaXZAZ21h
aWwuY29tPiB3cm90ZToKPgo+Cj4gSSBoYWQgYSBxdWljayBsb29rIGludG8gdGhpcyBwdWxsIHJl
cXVlc3QgYW5kIEkgaGF2ZW7igJl0IGZvdW5kIGhvdyB0aGlzCj4gcmVsYXRlcyB0aGUgaXNzdWVz
IEkgZm91bmQ6Cj4KPiAxLCBIT1NUX05BTUVfTUFYIHdhcyBub3QgZGVmaW5lZAo+IDIsIGVycm5v
Lmggd2FzIG5lZWRlZCBvbiBNYWMKPgo+IE1heSBiZSBpdCBpcyBvbmx5IG15IGxhY2sgb2YgYXV0
byB0b29scyBrbm93bGVkZ2UsIEkgZG9u4oCZdCBrbm93LiBBbnl3YXlzLAo+IHRoYW5rIHlvdSBh
Z2Fpbi4KPgo+Cj4gSW5kZWVkLCBpdCBkb2Vzbid0IGZpeCB0aG9zZSBpc3N1ZXMgZGlyZWN0bHk7
IGl0IGRpc2FibGVzIHRoZSBidWlsZCBvZgo+IGV2ZXJ5dGhpbmcgZXhjZXB0IHRoZSBsdHRuZy1y
ZWxheWQgb24gbWFjT1MgaW4gdGhlIGRlZmF1bHQgYnVpbGQKPiBjb25maWd1cmF0aW9uLgo+Cj4K
PiBJIHNlZS4gQnV0IHRoZSBmaXhlcyBJIHNlbnQgeW91IGFyZSBhY3R1YWxseSBmaXhpbmcgdGhl
IGJ1aWxkIG9mIHJlbGF5ZC4KCllvdXIgcGF0Y2ggYWZmZWN0cyB0d28gZmlsZXM6CgpzcmMvYmlu
L2x0dG5nL2NvbW1hbmRzL3ZpZXcuYwp3aGljaCBpcyBwYXJ0IG9mIHRoZSBsdHRuZyBjbGllbnQg
YW5kIG5vdCB1c2VkIGVsc2V3aGVyZS4gVGhlIGNsaWVudAppcyBub3QgYnVpbHQgb24gbWFjT1Mg
YW55bW9yZSAoYXMgcGVyIHRoZSBQUikuCgpJIHdvbid0IG1lcmdlIHRoYXQgcGFydCB1bmxlc3Mg
c29tZW9uZSBjb25maXJtcyB0aGUgdG9vbGNoYWluIHdvcmtzIG9uIG1hY09TLgoKc3JjL2NvbW1v
bi9jb21wYXQvdGltZS5oClRoaXMgZml4IGxvb2tzIGdvb2QsIGJ1dCBJJ2xsIGhhdmUgdG8gbG9v
ayBpbnRvIGl0IHNpbmNlIGNpLmx0dG5nLm9yZwpidWlsZHMgdGhlIGx0dG5nLXJlbGF5ZCBvbiBt
YWNPUy4gUGVyaGFwcyBhIHN5c3RlbSBoZWFkZXIgY2hhbmdlZApzaW5jZSBiZXR3ZWVuIDEwLjEx
LjYgYW5kIDEwLjEyLjUgKHdoaWNoIEkgdGhpbmsgaXMgd2hhdCB0aGUgQ0kgaXMKcnVubmluZyku
CgpKw6lyw6ltaWUKCj4KPiBJIGRvbuKAmXQgdW5kZXJzdGFuZCBob3cgdGhpcyBQUiBoZWxwcyB0
aGVuLgo+Cj4gSSdtIG5vdCBzdXJlIGl0IGlzIHdvcnRoIGFkZHJlc3NpbmcgdGhlIGJ1aWxkIGlz
c3VlcywgZXhjZXB0IGlmCj4gc29tZW9uZSBjYW4gY29uZmlybSB3aGV0aGVyIG9yIG5vdCB0aGUg
cmVzdCBvZiB0aGUgdG9vbGNoYWluIGFjdHVhbGx5Cj4gd29ya3Mgb24gbWFjT1MuCj4KPgoKCgot
LSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3Mu
Y29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5n
LWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3Rz
Lmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
