From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.3.3
Date: Mon, 6 Jun 2016 16:28:20 -0400
Message-ID: <CA+jJMxuAturULOu6POpeY6cLfHnbvjDJCRmKe97g35i58bHiiA__45053.76578677$1465244914$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f66.google.com (mail-qg0-f66.google.com
 [209.85.192.66])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 5C928A37EB
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jun 2016 20:28:21 +0000 (UTC)
Received: by mail-qg0-f66.google.com with SMTP id z67so7620765qgz.1
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jun 2016 13:28:21 -0700 (PDT)
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

SGkgYWxsLAoKV2UgYXJlIHJlbGVhc2luZyBCYWJlbHRyYWNlIDEuMy4zLCB3aGljaCBpcyBhIGJ1
Z2ZpeCByZWxlYXNlLgoKQmFiZWx0cmFjZSBpcyBhbiBvcGVuIHNvdXJjZSB0cmFjZSBmb3JtYXQg
Y29udmVydGVyLgoKVGhlIEJhYmVsdHJhY2UgcHJvamVjdCBwcm92aWRlcyBhIGxpYnJhcnksIFB5
dGhvbiBiaW5kaW5ncyBmb3IgdGhpcwpsaWJyYXJ5LCBhcyB3ZWxsIGFzIGEgaGFuZHkgY29tbWFu
ZC1saW5lIHRvb2zigJRhcHRseSBuYW1lZApiYWJlbHRyYWNl4oCUd2hpY2ggbWFrZXMgaXQgdmVy
eSBlYXN5IHRvIHZpZXcgYW5kIGNvbnZlcnQgdHJhY2VzLgoKQmFiZWx0cmFjZSBpcyBhbHNvIHRo
ZSByZWZlcmVuY2UgcGFyc2VyIGltcGxlbWVudGF0aW9uIG9mIHRoZSBDb21tb24KVHJhY2UgRm9y
bWF0IChDVEYpLCBhIHZlcnkgdmVyc2F0aWxlIHRyYWNlIGZvcm1hdC4KCjIwMTYtMDYtMDYgYmFi
ZWx0cmFjZSAxLjMuMyAoTmF0aW9uYWwgWW8tWW8gRGF5KQogICAgICAgICogRml4OiB1bmRlZmlu
ZWQgYml0IHNoaWZ0IG9wZXJhdGlvbiB3aGVuIHByaW50aW5nIG9jdGFsIG51bWJlcnMKICAgICAg
ICAqIERvY3M6IGNoYW5nZSAtLWNsb2NrLXJhdyB0byAtLWNsb2NrLWN5Y2xlcwogICAgICAgICog
Rml4OiBzZWdtZW50YXRpb24gZmF1bHQgd2l0aCBtdWx0aS10cmFjZSBoYXZpbmcgbm9uLWNvcnJl
bGF0ZWQgY2xvY2tzCiAgICAgICAgKiBGaXg6IGN0Zi10ZXh0OiBzaWduZWQgYmFzZSA4LCAxNiBw
cmludG91dAogICAgICAgICogRml4OiByZXNwZWN0IHNpZ25lZCBpbnRlZ2VycycgbGVuZ3RoIHdo
ZW4gcHJpbnRpbmcgaW4gaGV4IGJhc2UKICAgICAgICAqIEZpeDogcmV0dXJuIGV2ZW50IHRpbWVz
dGFtcCBpbiBfdGltZXN0YW1wX2F0X3BvcwogICAgICAgICogRml4OiBsdHRuZy1saXZlIGZsdXNo
IHdoZW4gb3V0cHV0IHRvIGZpbGUKICAgICAgICAqIEZpeDogbHR0bmctbGl2ZSB1c2UgZ19mcmVl
IHJhdGhlciB0aGFuIGZyZWUKICAgICAgICAqIEZpeDogbHR0bmctbGl2ZSBkYXRhX3NpemUgYW5k
IHZlcnNpb24gZW5kaWFubmVzcwoKUHJvamVjdCB3ZWJzaXRlOiBodHRwOi8vZGlhbW9uLm9yZy9i
YWJlbHRyYWNlLwpEb3dubG9hZCBsaW5rOiBodHRwOi8vd3d3LmVmZmljaW9zLmNvbS9maWxlcy9i
YWJlbHRyYWNlL2JhYmVsdHJhY2UtMS4zLjMudGFyLmJ6MgpDVEYgc3BlY2lmaWNhdGlvbjogaHR0
cDovL2RpYW1vbi5vcmcvY3RmLwoKLS0gCkrDqXLDqW1pZSBHYWxhcm5lYXUKRWZmaWNpT1MgSW5j
LgpodHRwOi8vd3d3LmVmZmljaW9zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5s
dHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZv
L2x0dG5nLWRldgo=
