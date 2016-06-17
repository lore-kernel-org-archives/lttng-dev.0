From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 0/4] Allow discard buffers in
	snapshot sessions
Date: Fri, 17 Jun 2016 18:16:20 -0400
Message-ID: <CA+jJMxs4pmu8wGtNzc0Q1fGVCuKFiOjvf5Hs4eXNWn0TcjJZeA__28645.7307207913$1466201804$gmane$org@mail.gmail.com>
References: <1461165600-17288-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7D007A0398
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2016 22:16:21 +0000 (UTC)
Received: by mail-qk0-f194.google.com with SMTP id b136so13930410qkg.2
 for <lttng-dev@lists.lttng.org>; Fri, 17 Jun 2016 15:16:21 -0700 (PDT)
In-Reply-To: <1461165600-17288-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkIGluIG1hc3Rlciwgd2l0aCB0aGUgZml4IGJhY2twb3J0ZWQgdG8gc3RhYmxlLTIuOCBh
bmQgc3RhYmxlLTIuNy4KClRoYW5rcyEKSsOpcsOpbWllCgpPbiBXZWQsIEFwciAyMCwgMjAxNiBh
dCAxMToxOSBBTSwgTWF0aGlldSBEZXNub3llcnMKPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbT4gd3JvdGU6Cj4gVGhpcyBwYXRjaHNldCBhbGxvd3MgdXNlcnMgdG8gb3ZlcnJpZGUgdGhl
IGNoYW5uZWwgbW9kZQo+IChkaXNjYXJkL292ZXJ3cml0ZSkgZm9yIHNuYXBzaG90IHNlc3Npb25z
IGZvciBib3RoIGx0dG5nLXVzdCBhbmQgbHR0bmcKPiBrZXJuZWwgdHJhY2luZy4gUHJldmlvdXNs
eSwgc25hcHNob3Qgc2Vzc2lvbnMgd2VyZSBlbmZvcmNpbmcgb3ZlcndyaXRlCj4gYnVmZmVyIHR5
cGVzLgo+Cj4gVGhhbmtzLAo+Cj4gTWF0aGlldQo+Cj4gTWF0aGlldSBEZXNub3llcnMgKDQpOgo+
ICAgRml4OiB2YWxpZGF0ZSBudW1iZXIgb2Ygc3ViYnVmZmVycyBhZnRlciB0d2Vha2luZyBwcm9w
ZXJ0aWVzCj4gICBBbGxvdyBjaGFubmVsIG1vZGUgb3ZlcnJpZGUgaW4gc25hcHNob3Qgc2Vzc2lv
bnMKPiAgIHRlc3RzOiB0ZXN0IGtlcm5lbCBzbmFwc2hvdCB3aXRoIGRpc2NhcmQgYnVmZmVycwo+
ICAgdGVzdHM6IHRlc3QgdXN0IHNuYXBzaG90IHdpdGggZGlzY2FyZCBidWZmZXJzCj4KPiAgaW5j
bHVkZS9sdHRuZy9jaGFubmVsLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiAgc3Jj
L2Jpbi9sdHRuZy1zZXNzaW9uZC9jaGFubmVsLmMgICAgICAgICAgICAgfCAgNTUgKysrKysrKysr
LQo+ICBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NtZC5jICAgICAgICAgICAgICAgICB8ICAxMCAt
LQo+ICBzcmMvYmluL2x0dG5nL2NvbW1hbmRzL2NyZWF0ZS5jICAgICAgICAgICAgICB8ICAgMiAr
LQo+ICBzcmMvY29tbW9uL2RlZmF1bHRzLmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
LQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3NuYXBzaG90cy90ZXN0X2tlcm5lbCB8ICA5NCAr
KysrKysrKysrKysrKysrLQo+ICB0ZXN0cy9yZWdyZXNzaW9uL3Rvb2xzL3NuYXBzaG90cy91c3Rf
dGVzdCAgICB8IDE1MCArKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgdGVzdHMvdXRpbHMv
dXRpbHMuc2ggICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzAgKysrKysrCj4gIDggZmlsZXMg
Y2hhbmdlZCwgMzIxIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjEu
NAo+CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5l
ZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBz
Oi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
