From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] test: jul/log4j: use -a instead
 of '*' to disable all events
Date: Wed, 23 Sep 2015 13:15:07 -0400
Message-ID: <CA+jJMxu0q3D-e89jDdQ7bqK2N5UwAbnG0OxutnXA1qHMkfQnEA__34776.186469435$1443028589$gmane$org@mail.gmail.com>
References: <1442944534-5423-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZendR-0008FH-0o
 for lttng-dev@lists.lttng.org; Wed, 23 Sep 2015 13:15:17 -0400
Received: by ykft14 with SMTP id t14so48417474ykf.0
 for <lttng-dev@lists.lttng.org>; Wed, 23 Sep 2015 10:15:07 -0700 (PDT)
In-Reply-To: <1442944534-5423-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgU2VwIDIyLCAyMDE1IGF0IDE6NTUg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFq
b3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3VzdC9q
YXZhLWp1bC90ZXN0X2phdmFfanVsICAgICB8IDIgKy0KPiAgdGVzdHMvcmVncmVzc2lvbi91c3Qv
amF2YS1sb2c0ai90ZXN0X2phdmFfbG9nNGogfCAyICstCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jl
c3Npb24vdXN0L2phdmEtanVsL3Rlc3RfamF2YV9qdWwgYi90ZXN0cy9yZWdyZXNzaW9uL3VzdC9q
YXZhLWp1bC90ZXN0X2phdmFfanVsCj4gaW5kZXggZjlmMjQ0Yi4uYjNmOWI1MSAxMDA3NTUKPiAt
LS0gYS90ZXN0cy9yZWdyZXNzaW9uL3VzdC9qYXZhLWp1bC90ZXN0X2phdmFfanVsCj4gKysrIGIv
dGVzdHMvcmVncmVzc2lvbi91c3QvamF2YS1qdWwvdGVzdF9qYXZhX2p1bAo+IEBAIC0zNDcsNyAr
MzQ3LDcgQEAgZnVuY3Rpb24gdGVzdF9qdWxfZGlzYWJsZV9hbGwoKQo+ICAgICAgICAgZW5hYmxl
X2p1bF9sdHRuZ19ldmVudCAkU0VTU0lPTl9OQU1FICRFVkVOVF9OQU1FCj4gICAgICAgICBlbmFi
bGVfanVsX2x0dG5nX2V2ZW50ICRTRVNTSU9OX05BTUUgJEVWRU5UX05BTUUyCj4KPiAtICAgICAg
IGRpc2FibGVfanVsX2x0dG5nX2V2ZW50ICRTRVNTSU9OX05BTUUgJyonCj4gKyAgICAgICBkaXNh
YmxlX2p1bF9sdHRuZ19ldmVudCAkU0VTU0lPTl9OQU1FIC1hCj4KPiAgICAgICAgIHN0YXJ0X2x0
dG5nX3RyYWNpbmdfb2sgJFNFU1NJT05fTkFNRQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3JlZ3Jl
c3Npb24vdXN0L2phdmEtbG9nNGovdGVzdF9qYXZhX2xvZzRqIGIvdGVzdHMvcmVncmVzc2lvbi91
c3QvamF2YS1sb2c0ai90ZXN0X2phdmFfbG9nNGoKPiBpbmRleCBkNWM2NjIxLi41YzBmMDNkIDEw
MDc1NQo+IC0tLSBhL3Rlc3RzL3JlZ3Jlc3Npb24vdXN0L2phdmEtbG9nNGovdGVzdF9qYXZhX2xv
ZzRqCj4gKysrIGIvdGVzdHMvcmVncmVzc2lvbi91c3QvamF2YS1sb2c0ai90ZXN0X2phdmFfbG9n
NGoKPiBAQCAtMzQ4LDcgKzM0OCw3IEBAIGZ1bmN0aW9uIHRlc3RfbG9nNGpfZGlzYWJsZV9hbGwo
KQo+ICAgICAgICAgZW5hYmxlX2xvZzRqX2x0dG5nX2V2ZW50ICRTRVNTSU9OX05BTUUgJEVWRU5U
X05BTUUKPiAgICAgICAgIGVuYWJsZV9sb2c0al9sdHRuZ19ldmVudCAkU0VTU0lPTl9OQU1FICRF
VkVOVF9OQU1FMgo+Cj4gLSAgICAgICBkaXNhYmxlX2xvZzRqX2x0dG5nX2V2ZW50ICRTRVNTSU9O
X05BTUUgJyonCj4gKyAgICAgICBkaXNhYmxlX2xvZzRqX2x0dG5nX2V2ZW50ICRTRVNTSU9OX05B
TUUgLWEKPgo+ICAgICAgICAgc3RhcnRfbHR0bmdfdHJhY2luZ19vayAkU0VTU0lPTl9OQU1FCj4K
PiAtLQo+IDIuMS40Cj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5jLgpo
dHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
