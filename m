From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Test: prevent the spawning
	of a daemonized sessiond
Date: Thu, 10 Mar 2016 11:49:20 -0500
Message-ID: <CA+jJMxvTCO4fej=ma599nFXmBjULuOeLMsGeuvc1ZYiQY3HU2g__38319.4501315758$1457628590$gmane$org@mail.gmail.com>
References: <495428957.19719.1457475555452.JavaMail.zimbra@efficios.com>
 <1457476659-19530-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id AA608A0A5C
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 16:49:21 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id m184so8719322iof.3
 for <lttng-dev@lists.lttng.org>; Thu, 10 Mar 2016 08:49:21 -0800 (PST)
In-Reply-To: <1457476659-19530-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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

TWVyZ2VkIGluIG1hc3Rlciwgc3RhYmxlLTIuNyBhbmQgc3RhYmxlLTIuNi4gVGhhbmtzIQoKSsOp
csOpbWllCgpPbiBUdWUsIE1hciA4LCAyMDE2IGF0IDU6MzcgUE0sIEpvbmF0aGFuIFJham90dGUK
PGpvbmF0aGFuLnJham90dGUtanVsaWVuQGVmZmljaW9zLmNvbT4gd3JvdGU6Cj4gU2V0cyB0aGUg
ZGVmYXVsdCBsdHRuZy1zZXNzaW9uZCBwYXRoIHRvIC9iaW4vdHJ1ZSB0byBwcmV2ZW50IHRoZSBz
cGF3bmluZwo+IG9mIGEgZGFlbW9uaXplZCBzZXNzaW9uZC4gVGhpcyBpcyBuZWNlc3Nhcnkgc2lu
Y2UgJ2x0dG5nIGNyZWF0ZScgd2lsbCBzcGF3bgo+IGl0cyBvd24gc2Vzc2lvbmQgaWYgbm9uZSBp
cyBydW5uaW5nLiBJdCBhbHNvIG1ha2Ugc3VyZSB0aGF0ICdsdHRuZyBjcmVhdGUnCj4gZmFpbHMg
d2hlbiBubyBzZXNzaW9uZCBpcyBydW5uaW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
UmFqb3R0ZSA8am9uYXRoYW4ucmFqb3R0ZS1qdWxpZW5AZWZmaWNpb3MuY29tPgo+IC0tLQo+ICB0
ZXN0cy91dGlscy91dGlscy5zaCB8IDYgKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS90ZXN0cy91dGlscy91dGlscy5zaCBiL3Rlc3RzL3V0
aWxzL3V0aWxzLnNoCj4gaW5kZXggZGEyM2Y3YS4uMGQ1YzMzZSAxMDA2NDQKPiAtLS0gYS90ZXN0
cy91dGlscy91dGlscy5zaAo+ICsrKyBiL3Rlc3RzL3V0aWxzL3V0aWxzLnNoCj4gQEAgLTMzLDYg
KzMzLDEyIEBAIEtFUk5FTF9QQVRDSExFVkVMX1ZFUlNJT049MjcKPiAgIyBzeXN0ZW1zLiBTcGVj
aWFsaXplZCB0ZXN0cyBzaG91bGQgdGVzdCB0aG9zZSBjb3JuZXItY2FzZXMuCj4gIGV4cG9ydCBM
VFROR19VU1RfUkVHSVNURVJfVElNRU9VVD0tMQo+Cj4gKyMgV2Ugc2V0IHRoZSBkZWZhdWx0IGx0
dG5nLXNlc3Npb25kIHBhdGggdG8gL2Jpbi90cnVlIHRvIHByZXZlbnQgdGhlIHNwYXduaW5nCj4g
KyMgb2YgYSBkYWVtb25pemVkIHNlc3Npb25kLiBUaGlzIGlzIG5lY2Vzc2FyeSBzaW5jZSAnbHR0
bmcgY3JlYXRlJyB3aWxsIHNwYXduCj4gKyMgaXRzIG93biBzZXNzaW9uZCBpZiBub25lIGlzIHJ1
bm5pbmcuIEl0IGFsc28gbWFrZSBzdXJlIHRoYXQgJ2x0dG5nIGNyZWF0ZScKPiArIyBmYWlscyB3
aGVuIG5vIHNlc3Npb25kIGlzIHJ1bm5pbmcuCj4gK2V4cG9ydCBMVFROR19TRVNTSU9ORF9QQVRI
PSIvYmluL3RydWUiCj4gKwo+ICBzb3VyY2UgJFRFU1RESVIvdXRpbHMvdGFwL3RhcC5zaAo+Cj4g
IGZ1bmN0aW9uIHByaW50X29rICgpCj4gLS0KPiAyLjcuMAo+CgoKCi0tIApKw6lyw6ltaWUgR2Fs
YXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlz
dApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1i
aW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
