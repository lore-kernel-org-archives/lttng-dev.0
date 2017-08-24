From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: wrong use of the
 relay_streams_sent in snapshot
Date: Thu, 24 Aug 2017 15:35:34 -0400
Message-ID: <516484ad-49e6-d89f-f8c1-6a1326c4def2__36518.3360212997$1503603353$gmane$org@efficios.com>
References: <1503521333-4905-1-git-send-email-jdesfossez@efficios.com>
 <165346610.15437.1503587759926.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xdZJn0pgSz15Tv
 for <lttng-dev@lists.lttng.org>; Thu, 24 Aug 2017 19:35:36 +0000 (UTC)
In-Reply-To: <165346610.15437.1503587759926.JavaMail.zimbra@efficios.com>
Content-Language: fr-classic
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

PiBJZiB5b3UgcmVtb3ZlIHRoaXMsIEkgdGhpbmsgdGhlIHN0cmVhbXMgd2lsbCBuZXZlciBnZXQg
cHVibGlzaGVkCj4gd2l0aGluIHRoZSByZWxheWQuIChwdWJsaXNoX2Nvbm5lY3Rpb25fbG9jYWxf
c3RyZWFtcygpKS4gSXMgdGhpcwo+IGFuIGV4cGVjdGVkIHNpZGUtZWZmZWN0ID8gSXQgc2hvdWxk
IGJlIGRvY3VtZW50ZWQgaW4gdGhlIGNoYW5nZWxvZy4KPiBNeSBndWVzcyBpcyB0aGF0IHdlIGlu
ZGVlZCBkb24ndCB3YW50IHRvIHB1Ymxpc2ggdGhlIHNuYXBzaG90Cj4gc3RyZWFtcyB0byB0aGUg
dmlld2Vycy4KSW5kZWVkLCBhIHNuYXBzaG90IHNlc3Npb24gY2Fubm90IGJlIGEgbGl2ZSBzZXNz
aW9uLCBzbyB3ZSBkb24ndAp3YW50L25lZWQgdG8gcHVibGlzaCB0aG9zZSBzdHJlYW1zLiBBbHNv
LCBzZW5kaW5nIHRoaXMgbWVzc2FnZSBldmVyeQp0aW1lIHdlIHNlbmQgYSBzdHJlYW0gaXMgYSB3
cm9uZyB1c2FnZSBvZiB0aGUgY29tbWFuZC4KCj4gVGhlIHJlYXNvbiBmb3IgZG9pbmcgdGhpcyBj
aGFuZ2Ugc2hvdWxkIGFsc28gYmUgZG9jdW1lbnRlZC4gV2hhdAo+IGJlaGF2aW9yIGlzIHVud2Fu
dGVkIGhlcmUgZnJvbSBhIHJlbGF5ZCBwZXJzcGVjdGl2ZSA/CldlIGFyZSBzZW5kaW5nIHRoaXMg
bWVzc2FnZSB0byB0aGUgcmVsYXkgKGFuZCB3YWl0aW5nIGZvciB0aGUKY29uZmlybWF0aW9uKSBi
ZWZvcmUgdGFraW5nIHRoZSBzbmFwc2hvdCBvZiBlYWNoIHN0cmVhbS4gU28sIGluIGFkZGl0aW9u
CnRvIGJlaW5nIHdyb25nIGFuZCB1c2VsZXNzLCBpdCBhZGRzIGEgY29uc2lkZXJhYmxlIGRlbGF5
IGJlZm9yZSB0YWtpbmcKdGhlIHNuYXBzaG90IG9mIGVhY2ggc3RyZWFtLgoKRG8geW91IGFncmVl
ID8KClRoYW5rcywKCkp1bGllbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
