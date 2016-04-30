From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-modules v7 1/5] Add
	ctf_integer_bitfield_type
Date: Sat, 30 Apr 2016 11:09:26 -0400
Message-ID: <1462028970-16870-2-git-send-email-jdesfossez__26011.2622906037$1462029001$gmane$org@efficios.com>
References: <1462028970-16870-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com (albert.ini-tech.com [192.99.35.19])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 70A6CA331C
 for <lttng-dev@lists.lttng.org>; Sat, 30 Apr 2016 15:09:37 +0000 (UTC)
In-Reply-To: <1462028970-16870-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

U2lnbmVkLW9mZi1ieTogSnVsaWVuIERlc2Zvc3NleiA8amRlc2Zvc3NlekBlZmZpY2lvcy5jb20+
CkFja2VkLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3Mu
Y29tPgotLS0KIHByb2Jlcy9sdHRuZy1ldmVudHMtd3JpdGUuaCB8IDggKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9wcm9iZXMvbHR0bmctZXZl
bnRzLXdyaXRlLmggYi9wcm9iZXMvbHR0bmctZXZlbnRzLXdyaXRlLmgKaW5kZXggNWRiNjZlYi4u
ODc3NDFhMSAxMDA2NDQKLS0tIGEvcHJvYmVzL2x0dG5nLWV2ZW50cy13cml0ZS5oCisrKyBiL3By
b2Jlcy9sdHRuZy1ldmVudHMtd3JpdGUuaApAQCAtMjIsNiArMjIsMTAgQEAKICNkZWZpbmUgY3Rm
X2ludGVnZXIoX3R5cGUsIF9pdGVtLCBfc3JjKQkJCQlcCiAJX2N0Zl9pbnRlZ2VyX2V4dChfdHlw
ZSwgX2l0ZW0sIF9zcmMsIF9fQllURV9PUkRFUiwgMTAsIDAsIDApCiAKKyN1bmRlZiBjdGZfaW50
ZWdlcl9iaXRmaWVsZAorI2RlZmluZSBjdGZfaW50ZWdlcl9iaXRmaWVsZChfdHlwZSwgX2l0ZW0s
IF9zcmMpCQkJXAorCV9jdGZfaW50ZWdlcl9leHQoX3R5cGUsIF9pdGVtLCBfc3JjLCBfX0xJVFRM
RV9FTkRJQU4sIDEwLCAwLCAwKQorCiAjdW5kZWYgY3RmX2ludGVnZXJfaGV4CiAjZGVmaW5lIGN0
Zl9pbnRlZ2VyX2hleChfdHlwZSwgX2l0ZW0sIF9zcmMpCQkJXAogCV9jdGZfaW50ZWdlcl9leHQo
X3R5cGUsIF9pdGVtLCBfc3JjLCBfX0JZVEVfT1JERVIsIDE2LCAwLCAwKQpAQCAtMTQ1LDYgKzE0
OSwxMCBAQAogI2RlZmluZSBjdGZfaW50ZWdlcl90eXBlKF90eXBlLCBfc3JjKQkJCQkJXAogCWN0
Zl9pbnRlZ2VyKF90eXBlLCB1bnVzZWQsIF9zcmMpCiAKKyN1bmRlZiBjdGZfaW50ZWdlcl9iaXRm
aWVsZF90eXBlCisjZGVmaW5lIGN0Zl9pbnRlZ2VyX2JpdGZpZWxkX3R5cGUoX3R5cGUsIF9zcmMp
CQkJCVwKKwljdGZfaW50ZWdlcl9iaXRmaWVsZChfdHlwZSwgdW51c2VkLCBfc3JjKQorCiAjdW5k
ZWYgY3RmX2ludGVnZXJfaGV4X3R5cGUKICNkZWZpbmUgY3RmX2ludGVnZXJfaGV4X3R5cGUoX3R5
cGUsIF9zcmMpCQkJCVwKIAljdGZfaW50ZWdlcl9oZXgoX3R5cGUsIHVudXNlZCwgX3NyYykKLS0g
CjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
dHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9s
aXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
