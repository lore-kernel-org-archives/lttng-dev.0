From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace 1.5] Use trace->trace_id for
 check to remove trace from bt_ctx
Date: Tue, 3 Jul 2018 16:07:56 -0400
Message-ID: <CA+jJMxvMnf1k7EXu6kfenp42yrE63Ex--y-VXWdHaytKcrDLeA__26491.6913737126$1530648408$gmane$org@mail.gmail.com>
References: <20180703162854.27550-1-jonathan.rajotte-julien@efficios.com>
 <20180703183356.GB19455@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 41KwDS4Lynz19B5
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 16:08:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9DECD23047B
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 16:08:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id PXYLnLZdruDD for <lttng-dev@lists.lttng.org>;
 Tue,  3 Jul 2018 16:08:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 17832230476
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 16:08:39 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id HmCWmybMwxWU for <lttng-dev@lists.lttng.org>;
 Tue,  3 Jul 2018 16:08:39 -0400 (EDT)
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
 [209.85.215.41])
 by mail.efficios.com (Postfix) with ESMTPSA id B55DD23046C
 for <lttng-dev@lists.lttng.org>; Tue,  3 Jul 2018 16:08:38 -0400 (EDT)
Received: by mail-lf0-f41.google.com with SMTP id y127-v6so2581818lfc.8
 for <lttng-dev@lists.lttng.org>; Tue, 03 Jul 2018 13:08:38 -0700 (PDT)
In-Reply-To: <20180703183356.GB19455@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIHN0YWJsZS0xLjUuIEkgaGF2ZSBhZGRyZXNzZWQgdGhlIHByb2JsZW0geW91IG1l
bnRpb25lZApyZWdhcmRpbmcgdGhlIHRyYWNlX2lkLgoKVGhhbmtzIQpKw6lyw6ltaWUKCk9uIDMg
SnVseSAyMDE4IGF0IDE0OjMzLCBKb25hdGhhbiBSYWpvdHRlLUp1bGllbgo8am9uYXRoYW4ucmFq
b3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPiB3cm90ZToKPiBPbiBUdWUsIEp1bCAwMywgMjAxOCBh
dCAxMjoyODo1NFBNIC0wNDAwLCBKb25hdGhhbiBSYWpvdHRlIHdyb3RlOgo+PiBDb21taXQgYjll
NjQ5OGRmOGIzZTdjMmFkMzEyZGNjZGRmOWYxYTVlMTgxNjQ4ZSByZW1vdmUgdGhlIGV4aXN0ZW5j
ZQo+PiBndWFyYW50ZWUgb2YgdGhlIHRyYWNlX2lkIGhhc2ggdGFibGUga2V5IGJ5IG1vdmluZyB0
aGUgdHJhY2UtPmluX3VzZQo+PiBhc3NpZ25hdGlvbiBiZWZvcmUgdGhlIGFzc2lnbmF0aW9uIG9m
IHRyYWNlX2lkIGFuZCBpbnNlcnRpb24gaW50bwo+PiB0aGUgaGFzaCB0YWJsZS4KPj4KPj4gVXNl
IHRoZSB0cmFkZV9pZCBmaWVsZCB2YWx1ZSB0byB2YWxpZGF0ZSBpZiBpdCBzaG91bGQgYmUKPj4g
cmVtb3ZlZCBmcm9tIHRoZSBoYXNoIHRhYmxlLgo+PiBBIE5VTEwgdHJhY2VfaWQgZmllbGQgaW5k
aWNhdGVzIHRoYXQgbm8gaW5zZXJ0aW9uIHdhcyBwZXJmb3JtZWQuCj4KPiBUaGlzIGlzIG5vdCB0
cnVlIHNpbmNlIHRyYWNlX2lkIHN0YXJ0IGF0IHplcm8uIEEgc29sdXRpb24gdG8gdGhpcyBpcyB0
byBzdGFydAo+IHRoZSB0cmFjZV9pZCBudW1iZXJpbmcgYSAxLgo+Cj4+Cj4+IFRoaXMgaXMgbW9z
dGx5IGEgd29ya2Fyb3VuZCB0byBhIHByb2JsZW0gZm91bmQgaW4sIGF0IGxlYXN0LCBnbGliLTIu
MjgKPj4gd2hlcmUgdGhlIGdfaGFzaF90YWJsZV9sb29rdXBfbm9kZSBhYm9ydCBvbiBhIFNJR0ZQ
RSBzaWduYWwgZHVlIHRvCj4+IG1vZHVsbyBieSB6ZXJvLiBUaGUgZXhhY3QgY2F1c2UgZm9yIHRo
aXMgaXMgdW5rbm93biBmb3Igbm93IFsxXS4KPj4gVGhlcmUgaXMgbGl0dGxlIHJlYXNvbiBmb3Ig
Im1vZCIgdG8gYmUgMCBhdCB0aGF0IHBvaW50IGFzIGV4cGxhaW5lZCBpbgo+PiB0aGUgYnVnIHJl
cG9ydC4KPj4KPj4gQ3VycmVudGx5IHVuYWJsZSB0byByZXByb2R1Y2UuCj4+Cj4+IFsxXSBodHRw
czovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTEwNzQ0MDEKPj4KPj4gU2ln
bmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZm
aWNpb3MuY29tPgo+PiAtLS0KPj4gIGZvcm1hdHMvbHR0bmctbGl2ZS9sdHRuZy1saXZlLWNvbW0u
YyB8IDIgKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxpdmUtY29tbS5j
IGIvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxpdmUtY29tbS5jCj4+IGluZGV4IDA1NWIxYzMw
Li45NDFkNWMyZiAxMDA2NDQKPj4gLS0tIGEvZm9ybWF0cy9sdHRuZy1saXZlL2x0dG5nLWxpdmUt
Y29tbS5jCj4+ICsrKyBiL2Zvcm1hdHMvbHR0bmctbGl2ZS9sdHRuZy1saXZlLWNvbW0uYwo+PiBA
QCAtMTQ2Niw3ICsxNDY2LDcgQEAgaW50IGRlbF90cmFjZXMoZ3BvaW50ZXIga2V5LCBncG9pbnRl
ciB2YWx1ZSwgZ3BvaW50ZXIgdXNlcl9kYXRhKQo+PiAgICAgICAgICAgICAgIGx2c3RyZWFtLT5p
bl90cmFjZSA9IDA7Cj4+ICAgICAgICAgICAgICAgYnRfbGlzdF9kZWwoJmx2c3RyZWFtLT50cmFj
ZV9zdHJlYW1fbm9kZSk7Cj4+ICAgICAgIH0KPj4gLSAgICAgaWYgKHRyYWNlLT5pbl91c2UpIHsK
Pj4gKyAgICAgaWYgKHRyYWNlLT5pbl91c2UgJiYgdHJhY2UtPnRyYWNlX2lkKSB7Cj4+ICAgICAg
ICAgICAgICAgcmV0ID0gYnRfY29udGV4dF9yZW1vdmVfdHJhY2UoYnRfY3R4LCB0cmFjZS0+dHJh
Y2VfaWQpOwo+PiAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgZnByaW50ZihzdGRlcnIsICJbZXJyb3JdIHJlbW92aW5nIHRyYWNlIGZyb20gY29udGV4
dFxuIik7Cj4+IC0tCj4+IDIuMTcuMQo+Pgo+Cj4gLS0KPiBKb25hdGhhbiBSYWpvdHRlLUp1bGll
bgo+IEVmZmljaU9TCgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0
cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcu
b3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRu
Zy1kZXYK
