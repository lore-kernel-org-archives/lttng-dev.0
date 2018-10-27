From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: update kvm
 instrumentation for SLES12 SP2 LTSS >= 4.4.121-92.92
Date: Sat, 27 Oct 2018 03:46:13 -0400 (EDT)
Message-ID: <1009348616.1363.1540626373540.JavaMail.zimbra__46561.3707936884$1540626266$gmane$org@efficios.com>
References: <20181026220117.10706-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42htGN5V9Tzl8S
 for <lttng-dev@lists.lttng.org>; Sat, 27 Oct 2018 03:46:20 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E95AF246E41
 for <lttng-dev@lists.lttng.org>; Sat, 27 Oct 2018 03:46:13 -0400 (EDT)
In-Reply-To: <20181026220117.10706-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

TWVyZ2VkLCB0aGFua3MhCgpNYXRoaWV1CgotLS0tLSBPbiBPY3QgMjYsIDIwMTgsIGF0IDExOjAx
IFBNLCBNaWNoYWVsIEplYW5zb24gbWplYW5zb25AZWZmaWNpb3MuY29tIHdyb3RlOgoKPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWNoYWVsIEplYW5zb24gPG1qZWFuc29uQGVmZmljaW9zLmNvbT4KPiAtLS0K
PiBpbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0uaCB8IDMgKystCj4gMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1n
aXQgYS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL2x0dG5nLW1vZHVsZS9rdm0uaAo+IGIvaW5zdHJ1
bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKPiBpbmRleCA4ODdmZTZmLi5mNGJl
ZTY5IDEwMDY0NAo+IC0tLSBhL2luc3RydW1lbnRhdGlvbi9ldmVudHMvbHR0bmctbW9kdWxlL2t2
bS5oCj4gKysrIGIvaW5zdHJ1bWVudGF0aW9uL2V2ZW50cy9sdHRuZy1tb2R1bGUva3ZtLmgKPiBA
QCAtODUsNyArODUsOCBAQCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKGt2bV9hY2tfaXJxLAo+IAl7
IEtWTV9UUkFDRV9NTUlPX1dSSVRFLCAid3JpdGUiIH0KPiAKPiAKPiAtI2lmIChMVFROR19TTEVf
S0VSTkVMX1JBTkdFKDQsNCwxMzEsOTQsMCwwLCA0LDUsMCwwLDAsMCkpCj4gKyNpZiAoTFRUTkdf
U0xFX0tFUk5FTF9SQU5HRSg0LDQsMTIxLDkyLDkyLDAsIDQsNCwxMjIsMCwwLDApIFwKPiArCXx8
IExUVE5HX1NMRV9LRVJORUxfUkFOR0UoNCw0LDEzMSw5NCwwLDAsIDQsNSwwLDAsMCwwKSkKPiAK
PiBMVFROR19UUkFDRVBPSU5UX0VWRU5UKGt2bV9tbWlvLAo+IAlUUF9QUk9UTyhpbnQgdHlwZSwg
aW50IGxlbiwgdTY0IGdwYSwgdTY0IHZhbCksCj4gLS0KPiAyLjE3LjEKCi0tIApNYXRoaWV1IERl
c25veWVycwpFZmZpY2lPUyBJbmMuCmh0dHA6Ly93d3cuZWZmaWNpb3MuY29tCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBtYWlsaW5nIGxp
c3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5nLm9yZy9jZ2kt
YmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
