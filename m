From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.8.6 - Isseki Nicho
Date: Mon, 9 Jan 2017 16:46:29 -0500
Message-ID: <CA+jJMxvghCukkyauFzjvV0uV-KMKc0aa5dSPBD9SMLqhXg_dKw__38268.5921540999$1483998412$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x22a.google.com (mail-vk0-x22a.google.com
 [IPv6:2607:f8b0:400c:c05::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 3ty7zz3dwbzk97
 for <lttng-dev@lists.lttng.org>; Mon,  9 Jan 2017 21:47:43 +0000 (UTC)
Received: by mail-vk0-x22a.google.com with SMTP id t8so15944554vke.3
 for <lttng-dev@lists.lttng.org>; Mon, 09 Jan 2017 13:46:30 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgc2l4dGggYnVnLWZpeCByZWxlYXNl
IG9mIExUVG5nLVRvb2xzIDIuOC4KVGhpcyByZWxlYXNlIGFkZHJlc3NlcyBhIG51bWJlciBvZiBp
c3N1ZXMgbGlzdGVkIGJlbG93LgoKMjAxNy0wMS0wOSBsdHRuZy10b29scyAyLjguNiAoTmF0aW9u
YWwgQ2Fzc291bGV0IERheSkKICAgICAgICAqIEZpeDogY29uc3VtZXJkOiBvcmRlciBvZiBtZXRh
ZGF0YSBjYWNoZSB2cyBzdHJlYW0gbG9jawogICAgICAgICogRml4OiBhZGQgbWlzc2luZyByY3Vf
YmFycmllciBiZWZvcmUgZGFlbW9uIHRlYXJkb3duCiAgICAgICAgKiBGaXg6IEFkZCBtaXNzaW5n
IHB0aHJlYWQuaCBpbmNsdWRlCiAgICAgICAgKiBGaXg6IHN1cHBvcnQgZm9yIG9sZGVyIHZlcnNp
b25zIG9mIEJhYmVsdHJhY2UgaW4gdGVzdCBzY3JpcHQKICAgICAgICAqIEZpeDogcmV2ZXJzZSBj
aGFubmVsIGFuZCBtZXRhZGF0YSBjYWNoZSBsb2NrIG5lc3Rpbmcgb3JkZXIKCkl0IGFsc28gaW5j
bHVkZXMgdGhlIGZvbGxvd2luZyBmaXhlcyBmcm9tIDIuOC41LCB3aGljaCB3YXMgcmVsZWFzZWQK
b3ZlciB0aGUgd2Vlay1lbmQ6CgoyMDE3LTAxLTA3IGx0dG5nLXRvb2xzIDIuOC41IChOYXRpb25h
bCBCb2JibGVoZWFkIERheSkKICAgICAgICAqIEZpeDogb25seSBsb2NrIHRoZSBtZXRhZGF0YV9j
YWNoZSBpbiB1c2Vyc3BhY2UgY29uc3VtZXJzCiAgICAgICAgKiBGaXg6IGxvY2sgbmVzdGluZyBv
cmRlciByZXZlcnNlZAoKQXMgYWx3YXlzLCBwbGVhc2UgcmVwb3J0IGFueSBpc3N1ZSB5b3UgbWF5
IGVuY291bnRlciB0byBidWdzLmx0dG5nLm9yZwpvciBvbiB0aGlzIG1haWxpbmcgbGlzdC4KClBy
b2plY3Qgd2Vic2l0ZTogaHR0cHM6Ly9sdHRuZy5vcmcKCkRvd25sb2FkIGxpbms6Cmh0dHBzOi8v
bHR0bmcub3JnL2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIuOC42LnRhci5iejIKCkdQ
RyBzaWc6Cmh0dHBzOi8vbHR0bmcub3JnL2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xzLTIu
OC42LnRhci5iejIuYXNjCgotLSAKSsOpcsOpbWllIEdhbGFybmVhdQpFZmZpY2lPUyBJbmMuCmh0
dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
