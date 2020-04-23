From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RFC PATCH CTF 0/3] Common Trace Format Updates
 (upcoming 1.8.3)
Date: Thu, 23 Apr 2020 16:52:23 -0400
Message-ID: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 497Tyd0j2jz1jMP
 for <lttng-dev@lists.lttng.org>; Thu, 23 Apr 2020 16:52:40 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: gbastien+lttng@versatic.net, matthew.khouzam@ericsson.com, diamon-discuss@linuxfoundation.org, pproulx@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

SGksCgpXZSBub3RpY2VkIGEgZmV3IHVuc3BlY2lmaWVkIGFyZWFzIGluIHRoZSBDVEYgMS44LjIg
c3BlY2lmaWNhdGlvbiB3aGljaApyZXF1aXJlIHNvbWUgY2xhcmlmaWNhdGlvbnMuIFdlIHRoZXJl
Zm9yZSBwbGFuIHRvIGRvIGEgMS44LjMgcmVsZWFzZSBvZgp0aGUgc3BlY2lmaWNhdGlvbiBpbmNs
dWRpbmcgdGhvc2UgY2hhbmdlcy4KClJldmlldyBpcyB3ZWxjb21lLAoKVGhhbmtzLAoKTWF0aGll
dQoKR2VuZXZpw6h2ZSBCYXN0aWVuICgxKToKICBDbGFyaWZ5IHRoYXQgdW5saXN0ZWQgZW51bSB2
YWx1ZXMgYXJlIGltcGxlbWVudGF0aW9uLWRlZmluZWQKCk1hdGhpZXUgRGVzbm95ZXJzICgyKToK
ICBDbGFyaWZ5IG1vbm90b25pY2l0eSByZXF1aXJlbWVudCBvbiB0aW1lc3RhbXAgYmVnaW4KICBD
bGFyaWZ5IHRoYXQgdGltZXN0YW1wIGJlZ2luL2VuZCBuZWVkIHRvIGJlIGNvbXBsZXRlIGNsb2Nr
IHZhbHVlcwoKIGNvbW1vbi10cmFjZS1mb3JtYXQtc3BlY2lmaWNhdGlvbi5tZCB8IDIwICsrKysr
KysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkKCi0tIAoyLjExLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5n
Lm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0
bmctZGV2Cg==
