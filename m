From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Use get_domain_str on add
	context
Date: Mon, 4 Apr 2016 12:49:09 -0400
Message-ID: <CA+jJMxuyd6HzZNQ_98EibMrnCzho4nbkixR8cPOj7uB+=uTULg__31904.5152668425$1459788572$gmane$org@mail.gmail.com>
References: <1458339923-7955-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f194.google.com (mail-ig0-f194.google.com
 [209.85.213.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 16EBBA2F73
 for <lttng-dev@lists.lttng.org>; Mon,  4 Apr 2016 16:49:11 +0000 (UTC)
Received: by mail-ig0-f194.google.com with SMTP id kb1so7174269igb.3
 for <lttng-dev@lists.lttng.org>; Mon, 04 Apr 2016 09:49:10 -0700 (PDT)
In-Reply-To: <1458339923-7955-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkLCB0aGFua3MhCgpKw6lyw6ltaWUKCk9uIEZyaSwgTWFyIDE4LCAyMDE2IGF0IDY6MjUg
UE0sIEpvbmF0aGFuIFJham90dGUKPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gRml4ZXMgIzEwMDYKPgo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIFJham90
dGUgPGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4KPiAtLS0KPiAgc3JjL2Jp
bi9sdHRuZy9jb21tYW5kcy9hZGRfY29udGV4dC5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc3JjL2Jp
bi9sdHRuZy9jb21tYW5kcy9hZGRfY29udGV4dC5jIGIvc3JjL2Jpbi9sdHRuZy9jb21tYW5kcy9h
ZGRfY29udGV4dC5jCj4gaW5kZXggYTZkNzNhMC4uZjc3ZWRiMSAxMDA2NDQKPiAtLS0gYS9zcmMv
YmluL2x0dG5nL2NvbW1hbmRzL2FkZF9jb250ZXh0LmMKPiArKysgYi9zcmMvYmluL2x0dG5nL2Nv
bW1hbmRzL2FkZF9jb250ZXh0LmMKPiBAQCAtNjYxLDExICs2NjEsMTEgQEAgc3RhdGljIGludCBh
ZGRfY29udGV4dChjaGFyICpzZXNzaW9uX25hbWUpCj4gICAgICAgICAgICAgICAgIH0gZWxzZSB7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKG9wdF9jaGFubmVsX25hbWUpIHsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1TRygiJXMgY29udGV4dCAlcyBhZGRlZCB0byBj
aGFubmVsICVzIiwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBvcHRfa2VybmVsID8gImtlcm5lbCIgOiAiVVNUIiwgdHlwZS0+b3B0LT5zeW1ib2wsCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2V0X2RvbWFp
bl9zdHIoZG9tLnR5cGUpLCB0eXBlLT5vcHQtPnN5bWJvbCwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHRfY2hhbm5lbF9uYW1lKTsKPiAgICAgICAg
ICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTVNHKCIlcyBjb250ZXh0ICVzIGFkZGVkIHRvIGFsbCBjaGFubmVscyIsCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3B0X2tlcm5lbCA/ICJrZXJu
ZWwiIDogIlVTVCIsIHR5cGUtPm9wdC0+c3ltYm9sKQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdldF9kb21haW5fc3RyKGRvbS50eXBlKSwgdHlwZS0+
b3B0LT5zeW1ib2wpCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHN1Y2Nlc3MgPSAxOwo+ICAgICAgICAgICAgICAgICB9Cj4gLS0KPiAyLjcuMAo+
CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZp
Y2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
