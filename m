From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 1/6] Fix: snapshot del-output with
	name on musl
Date: Wed, 15 Jun 2016 17:18:02 -0400
Message-ID: <1466025487-26743-1-git-send-email-mjeanson__1037.57911497286$1466025534$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2F0E3A3513
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jun 2016 21:18:38 +0000 (UTC)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

U29tZSBpbXBsZW1lbnRhdGlvbnMgb2Ygc3RydG9sKCkgbGlrZSB0aGUgb25lIGluIG11c2wgd2ls
bApyZXR1cm4gRUlOVkFMIGluIHBlcnJvciB3aGVuIG5vIHZhbGlkIG51bWJlciB3YXMgZm91bmQg
aW4KdGhlIHN0cmluZy4KClNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSmVhbnNvbiA8bWplYW5zb25A
ZWZmaWNpb3MuY29tPgotLS0KIHNyYy9iaW4vbHR0bmcvY29tbWFuZHMvc25hcHNob3QuYyB8IDIg
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL3NyYy9iaW4vbHR0bmcvY29tbWFuZHMvc25hcHNob3QuYyBiL3NyYy9iaW4vbHR0bmcv
Y29tbWFuZHMvc25hcHNob3QuYwppbmRleCBkOTQ4MjI2Li4wMGFhNWI3IDEwMDY0NAotLS0gYS9z
cmMvYmluL2x0dG5nL2NvbW1hbmRzL3NuYXBzaG90LmMKKysrIGIvc3JjL2Jpbi9sdHRuZy9jb21t
YW5kcy9zbmFwc2hvdC5jCkBAIC0zNTAsNyArMzUwLDcgQEAgc3RhdGljIGludCBjbWRfZGVsX291
dHB1dChpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YpCiAKIAllcnJubyA9IDA7CiAJaWQgPSBz
dHJ0b2woYXJndlsxXSwgJm5hbWUsIDEwKTsKLQlpZiAoaWQgPT0gMCAmJiBlcnJubyA9PSAwKSB7
CisJaWYgKGlkID09IDAgJiYgKGVycm5vID09IDAgfHwgZXJybm8gPT0gRUlOVkFMKSkgewogCQly
ZXQgPSBkZWxfb3V0cHV0KFVJTlQzMl9NQVgsIG5hbWUpOwogCX0gZWxzZSBpZiAoZXJybm8gPT0g
MCAmJiAqbmFtZSA9PSAnXDAnKSB7CiAJCXJldCA9IGRlbF9vdXRwdXQoaWQsIE5VTEwpOwotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xp
c3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
