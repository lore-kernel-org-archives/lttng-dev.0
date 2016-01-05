From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH babeltrace v3] Do not use g_list_free_full
Date: Tue, 5 Jan 2016 16:16:32 -0500
Message-ID: <CA+jJMxsJutE6rw1U-qwMWtVN-P=ULayk9vx9wvecPND6PZbZzA__18842.702828306$1452028644$gmane$org@mail.gmail.com>
References: <1451943430-7346-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1451945063-9730-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f170.google.com ([209.85.223.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aGYy6-0006th-4A
 for lttng-dev@lists.lttng.org; Tue, 05 Jan 2016 16:16:40 -0500
Received: by mail-io0-f170.google.com with SMTP id q21so199551426iod.0
 for <lttng-dev@lists.lttng.org>; Tue, 05 Jan 2016 13:16:38 -0800 (PST)
In-Reply-To: <1451945063-9730-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3RlciwgdGhhbmtzIQoKSsOpcsOpbWllCgpPbiBNb24sIEphbiA0LCAyMDE2
IGF0IDU6MDQgUE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVm
ZmljaW9zLmNvbT4gd3JvdGU6Cj4gdjM6IHdlIHN1cHBvcnQgZnJvbSAyLjIyIG5vdCAyLjI4Lgo+
IC0tCj4KPiBCYWJlbHRyYWNlIHN1cHBvcnQgZ2xpYiBhbGwgdGhlIHdheSBiYWNrIHRvIDIuMjIg
YW5kIGdfbGlzdF9mcmVlX2Z1bGwKPiBleGlzdHMgZnJvbSAyLjI4LjAgKGJhY2twb3J0ZWQgdG8g
Mi4yNy4yKSBvbmx5Lgo+Cj4gVGhlIHJlcGxhY2VtZW50IGlzIHRoZSBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGZvdW5kIGluIG1vZGVybiBnbGliLgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
UmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBm
b3JtYXRzL2N0Zi9pci92aXNpdG9yLmMgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZm9ybWF0cy9jdGYvaXIv
dmlzaXRvci5jIGIvZm9ybWF0cy9jdGYvaXIvdmlzaXRvci5jCj4gaW5kZXggOWI2NWVkNS4uNzA0
YTgwNCAxMDA2NDQKPiAtLS0gYS9mb3JtYXRzL2N0Zi9pci92aXNpdG9yLmMKPiArKysgYi9mb3Jt
YXRzL2N0Zi9pci92aXNpdG9yLmMKPiBAQCAtNzI0LDcgKzcyNCw4IEBAIGVuZDoKPiAgICAgICAg
ICAgICAgICAgZ19mcmVlKG5hbWVfY29weSk7Cj4gICAgICAgICB9Cj4gICAgICAgICBpZiAocGF0
aF90b2tlbnMpIHsKPiAtICAgICAgICAgICAgICAgZ19saXN0X2ZyZWVfZnVsbChwYXRoX3Rva2Vu
cywgZnJlZSk7Cj4gKyAgICAgICAgICAgICAgIGdfbGlzdF9mb3JlYWNoKHBhdGhfdG9rZW5zLCAo
R0Z1bmMpIGZyZWUsIE5VTEwpOwo+ICsgICAgICAgICAgICAgICBnX2xpc3RfZnJlZShwYXRoX3Rv
a2Vucyk7Cj4gICAgICAgICB9Cj4gICAgICAgICByZXR1cm4gcmV0Owo+ICBlcnJvcjoKPiAtLQo+
IDIuNS4wCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpodHRwOi8v
d3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3Jn
Cmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
