From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v3] Update: kvm
 instrumentation	for ubuntu 4.13.0-38
Date: Fri, 23 Mar 2018 18:03:42 -0400 (EDT)
Message-ID: <1889599385.3895.1521842622168.JavaMail.zimbra__41480.8918875225$1521842509$gmane$org@efficios.com>
References: <b96ac777-0b5a-ae74-34fb-0a296491c1cd@efficios.com>
 <20180323172803.26196-1-khalid.elmously@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 407HcH4Mtvzx5b
 for <lttng-dev@lists.lttng.org>; Fri, 23 Mar 2018 18:03:43 -0400 (EDT)
In-Reply-To: <20180323172803.26196-1-khalid.elmously@canonical.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Khalid Elmously <khalid.elmously@canonical.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

LS0tLS0gT24gTWFyIDIzLCAyMDE4LCBhdCAxOjI4IFBNLCBLaGFsaWQgRWxtb3VzbHkga2hhbGlk
LmVsbW91c2x5QGNhbm9uaWNhbC5jb20gd3JvdGU6Cgo+IFN0YXJ0aW5nIGZyb20gNC4xMy4wLTM4
IHRoZSB1YnVudHUga2VybmVsIGJhY2twb3J0IGEga3ZtIGluc3RydW1lbnRhdGlvbgo+IGNoYW5n
ZSBpbnRyb2R1Y2VkIGluIDQuMTUgd2hpY2ggYWZmZWN0cyB0aGUgcHJvdG90eXBlIG9mIHRoZSBr
dm1fbW1pbyBldmVudC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBLaGFsaWQgRWxtb3VzbHkgPGtoYWxp
ZC5lbG1vdXNseUBjYW5vbmljYWwuY29tPgo+IC0tLQo+IGluc3RydW1lbnRhdGlvbi9ldmVudHMv
bHR0bmctbW9kdWxlL2t2bS5oIHwgMSArCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
Cj4gCj4gZGlmZiAtLWdpdCBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2
bS5oCj4gYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0uaAo+IGluZGV4
IDhmOWExMzIuLmE1OTgyYzkgMTAwNjQ0Cj4gLS0tIGEvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9s
dHRuZy1tb2R1bGUva3ZtLmgKPiArKysgYi9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1v
ZHVsZS9rdm0uaAo+IEBAIC05Miw2ICs5Miw3IEBAIExUVE5HX1RSQUNFUE9JTlRfRVZFTlQoa3Zt
X2Fja19pcnEsCj4gCXx8IExUVE5HX0tFUk5FTF9SQU5HRSg0LDEsNTAsIDQsMiwwKSBcCj4gCXx8
IExUVE5HX0tFUk5FTF9SQU5HRSgzLDE2LDUyLCAzLDE3LDApIFwKPiAJfHwgTFRUTkdfS0VSTkVM
X1JBTkdFKDMsMiw5NywgMywzLDApIFwKPiArCXx8IExUVE5HX1VCVU5UVV9LRVJORUxfUkFOR0Uo
NCwxMywxNiwzOCwgNCwxNCwwLDApIFwKPiAJfHwgTFRUTkdfREVCSUFOX0tFUk5FTF9SQU5HRSg0
LDksNjUsMCwzLDAsIDQsMTAsMCwwLDAsMCkgXAo+IAl8fCBMVFROR19GRURPUkFfS0VSTkVMX1JB
TkdFKDQsMTQsMTMsMzAwLCA0LDE1LDAsMCkpCgpUaGUgbWVzc2FnZSBpcyBpbiBiYXNlNjQgSSB0
aGluay4gQ2FuIHlvdSByZXNlbmQgaXQgaW4gcGxhaW4gdGV4dCA/CgpUaGFua3MsCgpNYXRoaWV1
Cgo+IAo+IC0tCj4gMi4xNC4xCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cj4gbHR0bmctZGV2QGxpc3Rz
Lmx0dG5nLm9yZwo+IGh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0
aW5mby9sdHRuZy1kZXYKCi0tIApNYXRoaWV1IERlc25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6
Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9y
ZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmct
ZGV2Cg==
