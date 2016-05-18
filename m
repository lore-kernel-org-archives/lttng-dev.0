From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: initialize the cur_event
 variable before using it
Date: Wed, 18 May 2016 15:22:30 -0400
Message-ID: <CA+jJMxvw1j+ky=RAxBQHU9r+ZrEoWnUA6BSht17HStqer-54SQ__47249.6371636682$1463599362$gmane$org@mail.gmail.com>
References: <1463500367-23547-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f68.google.com (mail-qg0-f68.google.com
 [209.85.192.68])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C0640A35A6
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 19:22:31 +0000 (UTC)
Received: by mail-qg0-f68.google.com with SMTP id e35so5023774qge.1
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 12:22:31 -0700 (PDT)
In-Reply-To: <1463500367-23547-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFR1ZSwgTWF5IDE3LCAyMDE2IGF0IDExOjUy
IEFNLCBKb25hdGhhbiBSYWpvdHRlCjxqb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5j
b20+IHdyb3RlOgo+IENJRCAxMjQzMDQxICgjMSBvZiAxKTogVW5pbml0aWFsaXplZCBzY2FsYXIg
dmFyaWFibGUgKFVOSU5JVCkKPiB1bmluaXRfdXNlX2luX2NhbGw6IFVzaW5nIHVuaW5pdGlhbGl6
ZWQgZWxlbWVudCBvZiBhcnJheSAqY3VyX2V2ZW50Lm5hbWUgd2hlbgo+IGNhbGxpbmcgc3RyY21w
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gUmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1q
dWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2xpc3Qu
YyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdp
dCBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvbGlzdC5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5k
cy9saXN0LmMKPiBpbmRleCAwZGQ3NGU1Li40MThmY2NmIDEwMDY0NAo+IC0tLSBhL3NyYy9iaW4v
bHR0bmcvY29tbWFuZHMvbGlzdC5jCj4gKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9saXN0
LmMKPiBAQCAtNjIxLDYgKzYyMSw4IEBAIHN0YXRpYyBpbnQgbWlfbGlzdF91c3RfZXZlbnRfZmll
bGRzKHN0cnVjdCBsdHRuZ19ldmVudF9maWVsZCAqZmllbGRzLCBpbnQgY291bnQsCj4gICAgICAg
ICBpbnQgZXZlbnRfZWxlbWVudF9vcGVuID0gMDsKPiAgICAgICAgIHN0cnVjdCBsdHRuZ19ldmVu
dCBjdXJfZXZlbnQ7Cj4KPiArICAgICAgIG1lbXNldCgmY3VyX2V2ZW50LCAwLCBzaXplb2YoY3Vy
X2V2ZW50KSk7Cj4gKwo+ICAgICAgICAgLyogT3BlbiBkb21haW5zIGVsZW1lbnQgKi8KPiAgICAg
ICAgIHJldCA9IG1pX2x0dG5nX2RvbWFpbnNfb3Blbih3cml0ZXIpOwo+ICAgICAgICAgaWYgKHJl
dCkgewo+IC0tCj4gMi43LjQKPgoKCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJ
bmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGlu
Zm8vbHR0bmctZGV2Cg==
