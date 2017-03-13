From: Douglas Graham <douglas.graham@ericsson.com>
Subject: Re: Setenv/getenv are not thread-safe; whose bug is it?
Date: Mon, 13 Mar 2017 00:21:46 +0000
Message-ID: <HE1PR07MB09535F02D666D99BB7221713F0250__49028.3827567056$1489364531$gmane$org@HE1PR07MB0953.eurprd07.prod.outlook.com>
References: <HE1PR07MB095321C916B1298B997744F6F0200@HE1PR07MB0953.eurprd07.prod.outlook.com>
 <1656612379.3244.1489188755549.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sessmg22.ericsson.net (sessmg22.ericsson.net [193.180.251.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3vhJTJ0LXPzwHp
 for <lttng-dev@lists.lttng.org>; Mon, 13 Mar 2017 00:21:55 +0000 (UTC)
In-Reply-To: <1656612379.3244.1489188755549.JavaMail.zimbra@efficios.com>
Content-Language: en-US
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

PiBUaGFua3MgYSBsb3QgZm9yIHRoZSB2ZXJ5IHRob3JvdWdoIGJ1dCByZXBvcnQhDQo+IEkganVz
dCBwcmVwYXJlZCBhIHBhdGNoIGZvciB5b3Ugc2VudCBpbiBhIHNlcGFyYXRlIHRocmVhZDoNCj4g
IltQQVRDSCBsdHRuZy11c3RdIEZpeDogcmFjZSBiZXR3ZWVuIGx0dG5nLXVzdCBnZXRlbnYoKSBh
bmQgYXBwbGljYXRpb24gc2V0ZW52KCkiDQo+IENhbiB5b3UgZ2l2ZSBpdCBhIHRyeSBhbmQgbGV0
IG1lIGtub3cgaWYgaXQgZml4ZXMgdGhpbmdzIG9uIHlvdXIgc2lkZSA/DQoNClRoYW5rcyBmb3Ig
dGhlIHF1aWNrIHR1cm5hcm91bmQgTWF0aGlldSEgIA0KDQpJIGRvbid0IGtub3cgaG93IHdlIGJ1
aWxkIGx0dG5nIGJ1dCBJIGhhdmUgcGFzc2VkIHRoaXMgaW5mb3JtYXRpb24gYWxvbmcgdG8gdGhl
IHRlYW0gdGhhdCBkb2VzLCBhc2tpbmcgdGhhdCB0aGV5IHByb3ZpZGUgbWUgYSBsaWJyYXJ5IHdp
dGggdGhpcyBwYXRjaCBhcHBsaWVkIGZvciB1cyB0byB0ZXN0LiAgSSdsbCBsZXQgeW91IGtub3cg
aG93IGl0IGxvb2tzIHdoZW4gd2UgZ2V0IHRoZXJlLg0KDQpSZWdhcmRzLA0KRG91Zw0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxp
bmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3Jn
L2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
