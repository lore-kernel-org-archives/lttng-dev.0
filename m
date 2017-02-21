From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC PATCH lttng-ust 2/2] dl instrumentation: add
 dlmopen event, trace dlopen flags
Date: Tue, 21 Feb 2017 10:03:01 +0100
Message-ID: <20170221100301.6e409dc3__71.2355286397681$1487668399$gmane$org@free-electrons.com>
References: <1467672828-19184-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1467672828-19184-2-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.lttng.org (Postfix) with ESMTP id 3vSFCt1xrdzk5R
 for <lttng-dev@lists.lttng.org>; Tue, 21 Feb 2017 09:13:29 +0000 (UTC)
In-Reply-To: <1467672828-19184-2-git-send-email-mathieu.desnoyers@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com, alexmonthy@efficios.com
List-Id: lttng-dev@lists.lttng.org

SGVsbG8sCgpPbiBNb24sICA0IEp1bCAyMDE2IDE4OjUzOjQ4IC0wNDAwLCBNYXRoaWV1IERlc25v
eWVycyB3cm90ZToKPiBBZGQgbWlzc2luZyBkbG1vcGVuKDMpIGluc3RydW1lbnRhdGlvbiwgYW5k
IGFkZCB0aGUgImZsYWdzIiBmaWVsZCB0bwo+IGRsb3BlbiBpbnN0cnVtZW50YXRpb24uCj4gCj4g
TGluazogaHR0cDovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW4zL2Rsb3Blbi4zLmh0bWwK
PiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZm
aWNpb3MuY29tPgoKRllJLCB0aGlzIGNvbW1pdCAoN2IwZmRkODNjMTM3YmVhMWQ3MzAyZGYxYTQ1
MjUyZGZkY2NkODE3MikgYnJlYWtzIHRoZQpidWlsZCB3aXRoIHRoZSBtdXNsIEMgbGlicmFyeSwg
YmVjYXVzZSBpdCBkb2Vzbid0IGltcGxlbWVudCB0aGUKZGxtb3BlbigpIGV4dGVuc2lvbi4KClBl
cmhhcHMgdGhlcmUgc2hvdWxkIGJlIGFuIGF1dG9jb25mIHRlc3QgdG8gY2hlY2sgaWYgdGhlIEMg
bGlicmFyeQpwcm92aWRlcyBkbG1vcGVuKCkgZnVuY3Rpb25hbGl0eSBvciBub3Q/CgpCZXN0IHJl
Z2FyZHMsCgpUaG9tYXMgUGV0YXp6b25pCi0tIApUaG9tYXMgUGV0YXp6b25pLCBDVE8sIEZyZWUg
RWxlY3Ryb25zCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Zy
ZWUtZWxlY3Ryb25zLmNvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5vcmcK
aHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRl
dgo=
