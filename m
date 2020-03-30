From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: bt2 python - accessing component instances added to
 graph
Date: Mon, 30 Mar 2020 09:45:30 -0400
Message-ID: <f07941b7-51ae-0f42-2a9b-abcf82e299de@simark.ca>
References: <CADtyBo4tQxYBFZnk6dqTSkU4OjW2Fxmx0xJrP=ADaCz_YUXf1g@mail.gmail.com>
Reply-To: Simon Marchi <simark@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48rYcq2p7Fz1Ybh
 for <lttng-dev@lists.lttng.org>; Mon, 30 Mar 2020 09:45:31 -0400 (EDT)
In-Reply-To: <CADtyBo4tQxYBFZnk6dqTSkU4OjW2Fxmx0xJrP=ADaCz_YUXf1g@mail.gmail.com>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rocky Dunlap <dunlap@ucar.edu>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

T24gMjAyMC0wMy0zMCAxOjI0IGEubS4sIFJvY2t5IER1bmxhcCB2aWEgbHR0bmctZGV2IHdyb3Rl
Ogo+IEkgbm90aWNlZCB0aGF0IHdoZW4gSSBhZGQgYSBjb21wb25lbnQgdG8gYSBidDIgZ3JhcGgs
IGUuZy46Cj4gCj4gc2luayA9IGcuYWRkX2NvbXBvbmVudChTaW5nbGVQRVRTaW5rLCAic2luayIr
c3RyKGlkeCkpCj4gCj4gVGhlIHJldHVybiB2YWx1ZSAic2luayIgaXMgbm90IGFjdHVhbGx5IGFu
IGluc3RhbmNlIG9mIFNpbmdsZVBFVFNpbmsgKHdoaWNoIGhhcyBiZWVuIGRlZmluZWQgYXMgYSBs
b2NhbCBQeXRob24gY2xhc3MpLsKgIEhvdyBkbyBJIGdldCB0byB0aGUgaW5zdGFuY2Ugb2YgU2lu
Z2xlUEVUU2luayB0aGF0IHdhcyBjcmVhdGVkPwoKSWYgSSB1bmRlcnN0YW5kIHlvdXIgcXVlc3Rp
b24gY29ycmVjdGx5OiB0aGlzIGlzIGFjdHVhbGx5IG9uIHB1cnBvc2UgdG8gcHJlc2VydmUKZW5j
YXBzdWxhdGlvbiBvZiBlYWNoIGNvbXBvbmVudDogdGhlIHVzZXIgb2YgdGhlIGdyYXBoIGhhcyB0
aGUgY29udHJvbCBvbiB0aGUKY29tcG9uZW50IHdoZW4gY3JlYXRpbmcgaXQsIGl0IGNhbiBwYXNz
IHBhcmFtZXRlcnMgdG8gaXQuICBCdXQgYWZ0ZXIgdGhhdCwgaXQKc2hvdWxkIG5vdCBiZSBhYmxl
IHRvIGdvIHBsYXkgd2l0aCB0aGUgaW50ZXJuYWxzIG9mIHRoZSBjb21wb25lbnQuICBUaGUgYHNl
bGZgCm9iamVjdCB0aGF0IGhhcyBhY2Nlc3MgdG8gdGhlIGNvbXBvbmVudCdzIHN0YXRlIGlzIG9u
bHkgYXZhaWxhYmxlIHdoZW4gdGhlCmNvbXBvbmVudCdzIG1ldGhvZHMgYXJlIGNhbGxlZC4KClNv
IHdoZW4gdGhlIHVzZXIgb2YgdGhlIGdyYXBoIGFkZHMgYSBjb21wb25lbnQsIGl0IG9ubHkgcmVj
ZWl2ZXMgYSBnZW5lcmljCmNvbXBvbmVudCBvYmplY3QsIHdoaWNoIGNhbiBvbmx5IGJlIHVzZWQg
dG8gYWNjZXNzIHB1YmxpYyBwcm9wZXJ0aWVzIChpbmNsdWRpbmcKYSBwdWJsaWMgdmlldyBvZiBp
dHMgcG9ydHMsIHRoYXQgeW91IGNhbiB1c2UgdG8gY29ubmVjdCB0aGVtKS4KCk9mIGNvdXJzZSwg
eW91IGNhbiBhbHdheXMgZ2V0IGFyb3VuZCB0aGlzIHdpdGggYSBnbG9iYWwgdmFyaWFibGUsIGRv
aW5nIGxpa2UKdGhpcyBpbiB0aGUgY29tcG9uZW50J3MgaW5pdDoKCiAgZ2xvYmFsIG15X2NvbXBv
bmVudAogIG15X2NvbXBvbmVudCA9IHNlbGYKCkJ1dCBob3BlZnVsbHkgeW91IHdvbid0IG5lZWQg
dG8uICBJZiB5b3UgZXhwbGFpbiB3aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIGFjaGlldmUsCndlIGNh
biBzZWUgaWYgdGhlcmUncyBhIHByb3BlciB3YXkgdG8gZG8gaXQgdXNpbmcgdGhlIGV4aXN0aW5n
IEFQSS4KClNpbW9uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRw
czovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
