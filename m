From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.4.4
Date: Wed, 31 Jan 2018 22:23:08 -0500
Message-ID: <CA+jJMxtRS2vTvPpom+CB87jYiVx6f7SLtm6mBCbcRt01T8Vffw__13663.4111441255$1517455327$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x22c.google.com (mail-yw0-x22c.google.com
 [IPv6:2607:f8b0:4002:c05::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 3zX56v0GzBzCtw
 for <lttng-dev@lists.lttng.org>; Thu,  1 Feb 2018 03:23:34 +0000 (UTC)
Received: by mail-yw0-x22c.google.com with SMTP id x24so9344802ywj.0
 for <lttng-dev@lists.lttng.org>; Wed, 31 Jan 2018 19:23:34 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKVG9kYXkgd2UgYXJlIHJlbGVhc2luZyB0aGUgZm91cnRoIGJ1Zy1maXggcmVsZWFz
ZSBvZiBCYWJlbHRyYWNlIDEuNC40LgpUaGlzIHJlbGVhc2UgYWRkcmVzc2VzIGEgbnVtYmVyIG9m
IGlzc3VlcyBsaXN0ZWQgYmVsb3cuCgoyMDE4LTAxLTMxIGJhYmVsdHJhY2UgMS40LjQgKEdvcmls
bGEgU3VpdCBEYXkpCiAgICAgICAgKiBGaXg6IHNpZ25lZG5lc3MgZXJyb3IgaW4gcHl0aG9uIGNv
bXBsZW1lbnRzCiAgICAgICAgKiBGaXg6IGhhbmRsZSBwYWNrZXRfc2VlayBlcnJvcnMKICAgICAg
ICAqIEZpeDogcHJldmVudCBjYWxsaW5nIGFkZGluZyB0aGUgc2FtZSB0cmFjZSByZWN1cnNpdmVs
eQogICAgICAgICogRml4OiBNYWtlIHN1cmUgd2UgaGF2ZSBhbGwgdGhlIG1ldGFkYXRhIHN0cmVh
bXMgYmVmb3JlCmFkZGluZyBuZXcgdHJhY2VzCiAgICAgICAgKiBBZGQgbWlzc2luZyBkZWJ1Z2dp
bmcgaW5mb3JtYXRpb24gaW4gdGhlIGxpdmUgcGx1Z2luCiAgICAgICAgKiBGaXg6IHNldCBzdHJl
YW0gaWQgaW4gSFVQIGNhc2UKICAgICAgICAqIEZpeDogVXNlIGxpc3QgcmF0aGVyIHRoYW4gcHRy
IGFycmF5IGZvciB0cmFjZSBzdHJlYW1zCiAgICAgICAgKiBGaXg6IGxlYWsgb2Ygc3RyZWFtcwog
ICAgICAgICogRml4OiBoYW5kbGUgMCBzZXNzaW9uIGNhc2UgaW4gYXNrIG5ldyBzdHJlYW1zCiAg
ICAgICAgKiBGaXg6IGJyZWFrIGxvb3Agb24gZ2V0dGluZyBtZXRhZGF0YSBlcnJvcgogICAgICAg
ICogRml4OiByZXR1cm4gZXJyb3Igb24gYXNrX25ld19zdHJlYW0gd2hlbiBzaG91bGQgcXVpdAog
ICAgICAgICogRml4OiBkb24ndCBhY2Nlc3MgbWlzc2luZyBjdGYgdHJhY2Ugd2hlbiBnZXR0aW5n
IG1ldGFkYXRhCiAgICAgICAgKiBGaXg6IGx0dG5nLWxpdmUgZGlzY2FyZGVkIGV2ZW50IGNvdW50
IGFmdGVyIGluYWN0aXZpdHkKICAgICAgICAqIEZpeDogdGltZWdtIGNvbXBhdCBvbiBTb2xhcmlz
CiAgICAgICAgKiBsdHRuZy1saXZlOiBwcmludCBkaXNjYXJkZWQgZXZlbnQgYW5kIHBhY2tldCBs
b3N0IHdhcm5pbmdzIG9uIHN0ZGVycgoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vZGlhbW9uLm9y
Zy9iYWJlbHRyYWNlLwpEb3dubG9hZCBsaW5rOiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbS9maWxl
cy9iYWJlbHRyYWNlL2JhYmVsdHJhY2UtMS40LjQudGFyLmJ6MgpDVEYgc3BlY2lmaWNhdGlvbjog
aHR0cDovL2RpYW1vbi5vcmcvY3RmLwoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9T
IEluYy4KaHR0cDovL3d3dy5lZmZpY2lvcy5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlz
dHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYK
