From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 0/4] Initial tools namespace support
Date: Tue,  6 Mar 2018 15:53:48 -0500
Message-ID: <1520369632-10953-1-git-send-email-mjeanson__38161.3432350152$1520369591$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 3zwpsh1hj2zqvH
 for <lttng-dev@lists.lttng.org>; Tue,  6 Mar 2018 15:54:00 -0500 (EST)
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

VGhpcyBwYXRjaCBzZXQgaW1wbGVtZW50cyBuYW1lc3BhY2UgcmVsYXRlZCBjb250ZXh0cyBhbmQg
c3RhdGVkdW1wCmV2ZW50cyB3aGljaCB3aWxsIGJlIHJlcXVpcmVkIHRvIGFkZCBMaW51eCBjb250
YWluZXJzIHN1cHBvcnQgaW4Kb3VyIGNvbnRyb2wgYW5kIGFuYWx5c2lzIHRvb2xzLgoKVG8gdGVz
dCB0aGlzIHlvdSdsbCBuZWVkIHRoZSBjb3JyZXNwb25kaW5nIGx0dG5nLW1vZHVsZXMgYW5kIGx0
dG5nLXVzdApwYXRjaHNldC4KCk1pY2hhZWwgSmVhbnNvbiAoNCk6CiAgUkZDOiBBZGQga2VybmVs
IG5hbWVzcGFjZSBjb250ZXh0cwogIFJGQzogQWRkIHVzZXJzcGFjZSBuYW1lc3BhY2UgY29udGV4
dHMKICBSRkM6IEFkZCBrZXJuZWwgdWlkL2dpZCBjb250ZXh0cwogIFJGQzogQWRkIHVzZXJzcGFj
ZSB1aWQvZ2lkIGNvbnRleHRzCgogaW5jbHVkZS9sdHRuZy9ldmVudC5oICAgICAgICAgICAgICAg
ICAgfCAxOSArKysrKysrCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL2NvbnRleHQuYyAgICAgICB8
IDU3ICsrKysrKysrKysrKysrKysrKysrCiBzcmMvYmluL2x0dG5nLXNlc3Npb25kL3NhdmUuYyAg
ICAgICAgICB8IDk2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHNyYy9iaW4v
bHR0bmctc2Vzc2lvbmQvdHJhY2UtdXN0LmMgICAgIHwgMzkgKysrKysrKysrKysrKysKIHNyYy9i
aW4vbHR0bmcvY29tbWFuZHMvYWRkX2NvbnRleHQuYyAgIHwgMzggKysrKysrKysrKysrKysKIHNy
Yy9jb21tb24vY29uZmlnL2NvbmZpZy1zZXNzaW9uLWFiaS5oIHwgMTkgKysrKysrKwogc3JjL2Nv
bW1vbi9jb25maWcvc2Vzc2lvbi1jb25maWcuYyAgICAgfCA3NiArKysrKysrKysrKysrKysrKysr
KysrKysrKysKIHNyYy9jb21tb24vbHR0bmcta2VybmVsLmggICAgICAgICAgICAgIHwgMTkgKysr
KysrKwogOCBmaWxlcyBjaGFuZ2VkLCAzNjMgaW5zZXJ0aW9ucygrKQoKLS0gCjIuNy40CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFp
bGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5v
cmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
