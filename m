From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Thu, 1 Jun 2017 17:59:51 -0400
Message-ID: <CA+jJMxuYV8nN0kgseMnO6Psgpk_XYsndyM93Rus5xv4Z-GX1_w__13059.89850448$1496354631$gmane$org@mail.gmail.com>
References: <A82E93B1-509F-424C-B36F-7011D685BDC9@gmail.com>
 <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
 <CAA85PfLgiW329AhYcSbup+8jBz=25-pEM7LUC962ucUc3M6Gkw@mail.gmail.com>
 <CA+jJMxs-d6vZ4Q3t6UvDeqOqwYyyoVHtqrEw1uGuomovB_ohLw@mail.gmail.com>
 <eb2eec76-8ad8-bea2-5933-629ac1f1df07@efficios.com>
 <CA+jJMxs2=ua4LsaPS9DqBGY6gdLQqjCaibhnPYLt5k9d7Ke42Q@mail.gmail.com>
 <019415e6-017c-09b9-7f4a-0df71b51fc1a@efficios.com>
 <CA+jJMxvnbQuvPTR0uWw=XNXR-FARxyErDJhkND9kUwDUrLvNzQ@mail.gmail.com>
 <9EB290C2-A968-4B16-9A1D-AA7BC38E2DE5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 by lists.lttng.org (Postfix) with ESMTPS id 3wf1WX0Xcdz12MD
 for <lttng-dev@lists.lttng.org>; Thu,  1 Jun 2017 22:01:11 +0000 (UTC)
Received: by mail-yw0-x242.google.com with SMTP id y64so3590229ywe.0
 for <lttng-dev@lists.lttng.org>; Thu, 01 Jun 2017 14:59:53 -0700 (PDT)
In-Reply-To: <9EB290C2-A968-4B16-9A1D-AA7BC38E2DE5@gmail.com>
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

T24gMSBKdW5lIDIwMTcgYXQgMTc6MzAsIETDoXZpZCBCZWNrIDxkYXZpZC5iZWNrLnByaXZAZ21h
aWwuY29tPiB3cm90ZToKPiBIaSBKw6lyw6ltaWUsCj4KPiBTb3VuZHMgZ3JlYXQsIHRoYW5rIHlv
dSEKPgo+IEkgaGFkIGEgcXVpY2sgbG9vayBpbnRvIHRoaXMgcHVsbCByZXF1ZXN0IGFuZCBJIGhh
dmVu4oCZdCBmb3VuZCBob3cgdGhpcyByZWxhdGVzIHRoZSBpc3N1ZXMgSSBmb3VuZDoKPgo+IDEs
IEhPU1RfTkFNRV9NQVggd2FzIG5vdCBkZWZpbmVkCj4gMiwgZXJybm8uaCB3YXMgbmVlZGVkIG9u
IE1hYwo+Cj4gTWF5IGJlIGl0IGlzIG9ubHkgbXkgbGFjayBvZiBhdXRvIHRvb2xzIGtub3dsZWRn
ZSwgSSBkb27igJl0IGtub3cuIEFueXdheXMsIHRoYW5rIHlvdSBhZ2Fpbi4KCkluZGVlZCwgaXQg
ZG9lc24ndCBmaXggdGhvc2UgaXNzdWVzIGRpcmVjdGx5OyBpdCBkaXNhYmxlcyB0aGUgYnVpbGQg
b2YKZXZlcnl0aGluZyBleGNlcHQgdGhlIGx0dG5nLXJlbGF5ZCBvbiBtYWNPUyBpbiB0aGUgZGVm
YXVsdCBidWlsZApjb25maWd1cmF0aW9uLgoKSSdtIG5vdCBzdXJlIGl0IGlzIHdvcnRoIGFkZHJl
c3NpbmcgdGhlIGJ1aWxkIGlzc3VlcywgZXhjZXB0IGlmCnNvbWVvbmUgY2FuIGNvbmZpcm0gd2hl
dGhlciBvciBub3QgdGhlIHJlc3Qgb2YgdGhlIHRvb2xjaGFpbiBhY3R1YWxseQp3b3JrcyBvbiBt
YWNPUy4KClRoYW5rcywKSsOpcsOpbWllCgo+Cj4gQmVzdCwgRGF2aWQKPgo+Cj4+IE9uIDAxIEp1
biAyMDE3LCBhdCAyMjowMiwgSsOpcsOpbWllIEdhbGFybmVhdSA8amVyZW1pZS5nYWxhcm5lYXVA
ZWZmaWNpb3MuY29tPiB3cm90ZToKPj4KPj4gSGkgRGF2aWQsCj4+Cj4+IFRoZSBwdWxsIHJlcXVl
c3QgTWljaGFlbCByZWZlcmVuY2VkIHdhcyBtZXJnZWQgYW5kIHlvdXIgaXNzdWUgc2hvdWxkCj4+
IGJlIHJlc29sdmVkIGluIGJvdGggdGhlIG1hc3RlciBhbmQgc3RhYmxlLTIuMTAgYnJhbmNoZXMu
Cj4+Cj4+IErDqXLDqW1pZQo+Pgo+PiBPbiAyNCBNYXkgMjAxNyBhdCAxNDowNiwgTWljaGFlbCBK
ZWFuc29uIDxtamVhbnNvbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+Pj4gT24gMjAxNy0wNS0yNCAx
MToxMSwgSsOpcsOpbWllIEdhbGFybmVhdSB3cm90ZToKPj4+Pgo+Pj4+IEdvb2QgaWRlYSEgSXQg
d2lsbCBjZXJ0YWlubHkgYmUgbGVzcyBlcnJvci1wcm9uZS4KPj4+Pgo+Pj4KPj4+IEkgYWRkZWQg
aXQgdG8gdGhpcyBbMV0gcHVsbCByZXF1ZXN0IHNpbmNlIGl0J3MgYnVpbGQgc3lzdGVtIHJlbGF0
ZWQuIEl0Cj4+PiB3YXMgdGVzdGVkIG9uIG1hY09TIDEwLjEyLjQuCj4+Pgo+Pj4gTWljaGFlbAo+
Pj4KPj4+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vbHR0bmcvbHR0bmctdG9vbHMvcHVsbC85MQo+
Pj4KPj4KPj4KPj4KPj4gLS0KPj4gSsOpcsOpbWllIEdhbGFybmVhdQo+PiBFZmZpY2lPUyBJbmMu
Cj4+IGh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5n
LWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
