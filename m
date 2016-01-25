From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: test: use load_path
	instead of $1
Date: Mon, 25 Jan 2016 16:12:08 -0500
Message-ID: <CA+jJMxs==hYefY1XwzdaOL1TVoOxULk4kezk0bUYZcSV+pRcQw__15104.8771258958$1453756396$gmane$org@mail.gmail.com>
References: <1452796842-31174-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f195.google.com ([209.85.223.195])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1aNoQo-0004BO-6f
 for lttng-dev@lists.lttng.org; Mon, 25 Jan 2016 16:12:16 -0500
Received: by mail-io0-f195.google.com with SMTP id k127so14618440iok.1
 for <lttng-dev@lists.lttng.org>; Mon, 25 Jan 2016 13:12:14 -0800 (PST)
In-Reply-To: <1452796842-31174-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIFRodSwgSmFuIDE0LCAyMDE2IGF0IDE6NDAg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gJDEgaXMgdXNlZCBmb3IgdGFwIGNvbmRpdGlvbiBjaGVja2luZyBub3QgdGhl
IGxvYWQgcGF0aC4KPgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90dGUgPGpvbmF0aGFu
LnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgdGVzdHMvdXRpbHMvdXRpbHMu
c2ggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3V0aWxzL3V0aWxzLnNoIGIvdGVzdHMvdXRpbHMvdXRp
bHMuc2gKPiBpbmRleCAzNTIwNzkyLi40MmIzNDQxIDEwMDY0NAo+IC0tLSBhL3Rlc3RzL3V0aWxz
L3V0aWxzLnNoCj4gKysrIGIvdGVzdHMvdXRpbHMvdXRpbHMuc2gKPiBAQCAtMzYyLDcgKzM2Miw3
IEBAIGZ1bmN0aW9uIHN0YXJ0X2x0dG5nX3Nlc3Npb25kX29wdCgpCj4gICAgICAgICBpZiBbIC16
ICQocGdyZXAgLS1mdWxsIGx0LSRTRVNTSU9ORF9CSU4pIF07IHRoZW4KPiAgICAgICAgICAgICAg
ICAgIyBIYXZlIGEgbG9hZCBwYXRoID8KPiAgICAgICAgICAgICAgICAgaWYgWyAtbiAiJGxvYWRf
cGF0aCIgXTsgdGhlbgo+IC0gICAgICAgICAgICAgICAgICAgICAgICRESVIvLi4vc3JjL2Jpbi9s
dHRuZy1zZXNzaW9uZC8kU0VTU0lPTkRfQklOIC0tbG9hZCAiJDEiIC0tYmFja2dyb3VuZCAtLWNv
bnN1bWVyZDMyLXBhdGg9IiRESVIvLi4vc3JjL2Jpbi9sdHRuZy1jb25zdW1lcmQvbHR0bmctY29u
c3VtZXJkIiAtLWNvbnN1bWVyZDY0LXBhdGg9IiRESVIvLi4vc3JjL2Jpbi9sdHRuZy1jb25zdW1l
cmQvbHR0bmctY29uc3VtZXJkIgo+ICsgICAgICAgICAgICAgICAgICAgICAgICRESVIvLi4vc3Jj
L2Jpbi9sdHRuZy1zZXNzaW9uZC8kU0VTU0lPTkRfQklOIC0tbG9hZCAiJGxvYWRfcGF0aCIgLS1i
YWNrZ3JvdW5kIC0tY29uc3VtZXJkMzItcGF0aD0iJERJUi8uLi9zcmMvYmluL2x0dG5nLWNvbnN1
bWVyZC9sdHRuZy1jb25zdW1lcmQiIC0tY29uc3VtZXJkNjQtcGF0aD0iJERJUi8uLi9zcmMvYmlu
L2x0dG5nLWNvbnN1bWVyZC9sdHRuZy1jb25zdW1lcmQiCj4gICAgICAgICAgICAgICAgIGVsc2UK
PiAgICAgICAgICAgICAgICAgICAgICAgICAkRElSLy4uL3NyYy9iaW4vbHR0bmctc2Vzc2lvbmQv
JFNFU1NJT05EX0JJTiAtLWJhY2tncm91bmQgLS1jb25zdW1lcmQzMi1wYXRoPSIkRElSLy4uL3Ny
Yy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNvbnN1bWVyZCIgLS1jb25zdW1lcmQ2NC1wYXRo
PSIkRElSLy4uL3NyYy9iaW4vbHR0bmctY29uc3VtZXJkL2x0dG5nLWNvbnN1bWVyZCIKPiAgICAg
ICAgICAgICAgICAgZmkKPiAtLQo+IDIuNS4wCj4KCgoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUK
RWZmaWNpT1MgSW5jLgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRu
Zy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
