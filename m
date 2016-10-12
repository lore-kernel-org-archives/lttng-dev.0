From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: lttng-sessiond as a CentOS 7 service
Date: Wed, 12 Oct 2016 14:31:52 -0400
Message-ID: <8b42d686-3ddd-89d8-888b-da4ae1edc27d__20059.4299509705$1476297151$gmane$org@efficios.com>
References: <48CF5AC71E61DB46B70D0F388054EFFDB7DF18EF@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 38DFDA4464
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2016 18:33:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 40511340227
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2016 18:33:19 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id SY3lu9xYP8JA for <lttng-dev@lists.lttng.org>;
 Wed, 12 Oct 2016 18:33:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 28AD13403DE
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2016 18:33:14 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id QqcXONy83DYD for <lttng-dev@lists.lttng.org>;
 Wed, 12 Oct 2016 18:33:14 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.218.157.electronicbox.net
 [192.222.218.157])
 by mail.efficios.com (Postfix) with ESMTPSA id 0FF7C340227
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2016 18:33:14 +0000 (UTC)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFDB7DF18EF@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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
List-Id: lttng-dev@lists.lttng.org

T24gMjAxNi0xMC0xMiAxNDoyMSwgVGhpYmF1bHQsIERhbmllbCB3cm90ZToKPiBVc2luZzoKPiBs
dHRuZy1tb2R1bGVzLXN0YWJsZS0yLjgtMi44LjItZTg0MDIwNgo+IHVzZXJzcGFjZS1yY3Utc3Rh
YmxlLTAuOS02MDUxMTcwCj4gbHR0bmctdXN0LXN0YWJsZS0yLjgtY2YxODg2NQo+IGx0dG5nLXRv
b2xzLXN0YWJsZS0yLjgtMi44LjItNDgyNjJmMQo+IG9uOgo+IFJlZCBIYXQgRW50ZXJwcmlzZSBM
aW51eCBTZXJ2ZXIgcmVsZWFzZSA3LjIgKE1haXBvKSAoUkhFTCA3LjIgNjQtYml0cykKPiBLZXJu
ZWwgMy4xMC4wLTMyNy5lbDcueDg2XzY0Cj4gCj4gSSdtIGhhdmluZyB0cm91YmxlIHdpdGggbXkg
aW5zdGFsbGF0aW9uIG9mIGx0dG5nLXNlc3Npb25kIGFzIGEgc2VydmljZS4gIElmIEkgcnVuIGx0
dG5nLXNlc3Npb25kIHVzaW5nIGVpdGhlciAtYiwgLWQsIG9yIGp1c3QgLXZ2diwgaXQgd29ya3Mg
ZmluZSAoSSBjYW4gaW50ZXJyb2dhdGUgJ2x0dG5nIGxpc3QgLXUnIGZyb20gYSB0cmFjaW5nIHVz
ZXIgc2hlbGwgYW5kIGRldGVjdCB0aGUgcHJvY2VzcyB1c2luZyAncHMgLWUgfCBncmVwIHNlc3Np
b25kJykuCj4gCj4gQnV0IHdoZW4gSSBsYXVuY2ggdGhlIHNlcnZpY2UsIEkgZW5kIHVwIHdpdGgg
YSAic3VjY2Vzc2Z1bGx5IGRlYWQiIGRhZW1vbjoKPiAKPiAjIHN5c3RlbWN0bCBzdGFydCBsdHRu
Zy1zZXNzaW9uZAo+ICMgc3lzdGVtY3RsIHN0YXR1cyBsdHRuZy1zZXNzaW9uZAo+ICogbHR0bmct
c2Vzc2lvbmQuc2VydmljZSAtIExUVG5nIGNlbnRyYWwgdHJhY2luZyByZWdpc3RyeSBzZXNzaW9u
IGRhZW1vbgo+ICAgIExvYWRlZDogbG9hZGVkICgvZXRjL3N5c3RlbWQvc3lzdGVtL2x0dG5nLXNl
c3Npb25kLnNlcnZpY2U7IGVuYWJsZWQ7IHZlbmRvciBwcmVzZXQ6IGVuYWJsZWQpCj4gICAgQWN0
aXZlOiBpbmFjdGl2ZSAoZGVhZCkgc2luY2UgLi4uCj4gICBQcm9jZXNzOiA1ODY1IEV4ZWNTdGFy
dD0vdXNyL2xvY2FsL2Jpbi9sdHRuZy1zZXNzaW9uZCAtZCAoY29kZT1leGl0ZWQsIHN0YXR1cz0w
L1NVQ0NFU1MpCj4gIE1haW4gUElEOiA1ODY1IChjb2RlPWV4aXRlZCwgc3RhdHVzPTAvU1VDQ0VT
UykKPiAKPiBUaGVyZSdzIG5vdGhpbmcgaW4gZG1lc2cuCj4gCj4gVGhlIHNlcnZpY2UgaXMgc2V0
IHVwIGxpa2Ugc286Cj4gCj4gJCBzdWRvIGxuIC1zIC9ldGMvc3lzdGVtZC9zeXN0ZW0vbHR0bmct
c2Vzc2lvbmQuc2VydmljZSAvZXRjL3N5c3RlbWQvc3lzdGVtL211bHRpLXVzZXIudGFyZ2V0Lndh
bnRzL2x0dG5nLXNlc3Npb25kLnNlcnZpY2UKPiAkIGNhdCA+IH4vbHR0bmctc2Vzc2lvbmQuc2Vy
dmljZSA8PCBFTkQKPiBbVW5pdF0KPiBEZXNjcmlwdGlvbj1MVFRuZyBjZW50cmFsIHRyYWNpbmcg
cmVnaXN0cnkgc2Vzc2lvbiBkYWVtb24KPiAKPiBbU2VydmljZV0KPiBUeXBlPXNpbXBsZQo+IFVz
ZXI9cm9vdAo+IEV4ZWNTdGFydD0vdXNyL2xvY2FsL2Jpbi9sdHRuZy1zZXNzaW9uZCAtZAoKWW91
IHNob3VsZCByZW1vdmUgdGhlICItZCIsIHN5c3RlbWQgZXhwZWN0cyB0aGUgZGFlbW9uIHRvIHN0
YXkgaW4gdGhlCmZvcmVncm91bmQgc28gaXQgY2FuIG1vbml0b3IgaXQuCgo+IFJlc3RhcnQ9b24t
YWJvcnQKPiAKPiBbSW5zdGFsbF0KPiBXYW50ZWRCeT1tdWx0aS11c2VyLnRhcmdldAo+IEVORAo+
ICQgc3VkbyBtdiB+L2x0dG5nLXNlc3Npb25kLnNlcnZpY2UgL2V0Yy9zeXN0ZW1kL3N5c3RlbS9s
dHRuZy1zZXNzaW9uZC5zZXJ2aWNlCj4gCj4gV2hhdCBhbSBJIGRvaW5nIHdyb25nPwo+IAo+IERh
bmllbCBVLiBUaGliYXVsdCwgTS5TYy7Csgo+IAo+IEluZm9ybWF0aWNpZW4gc2NpZW50aWZpcXVl
LCBDTUUtUFNDLCBDZW50cmUgZGUgcmVjaGVyY2hlcyBkZSBWYWxjYXJ0aWVyCj4gUmVjaGVyY2hl
IGV0IGTDqXZlbG9wcGVtZW50IHBvdXIgbGEgZMOpZmVuc2UgQ2FuYWRhIC8gR291dmVybmVtZW50
IGR1IENhbmFkYQo+IGRhbmllbC50aGliYXVsdEBkcmRjLXJkZGMuZ2MuY2EgLyBUw6lsOiA0MTgt
ODQ0LTQwMDB4NDI0NSBUw6lsw6ljOiA0MTgtODQ0LTQ1MzgKPiBkYW5pZWwudGhpYmF1bHRAZm9y
Y2VzLmdjLmNhIC8gVMOpbDogNDE4LTg0NC00MDAweDQyNDUgVMOpbMOpYzogNDE4LTg0NC00NTM4
Cj4gCj4gQ29tcHV0ZXIgU2NpZW50aXN0LCBNQ0NTLVNQQywgVmFsY2FydGllciBSZXNlYXJjaCBD
ZW50cmUgCj4gRGVmZW5jZSBSZXNlYXJjaCBhbmQgRGV2ZWxvcG1lbnQgQ2FuYWRhIC8gR292ZXJu
bWVudCBvZiBDYW5hZGEKPiBkYW5pZWwudGhpYmF1bHRAZHJkYy1yZGRjLmdjLmNhIC8gVGVsOiA0
MTgtODQ0LTQwMDB4NDI0NSBGYXg6IDQxOC04NDQtNDUzOAo+IGRhbmllbC50aGliYXVsdEBmb3Jj
ZXMuZ2MuY2EgLyBUZWw6IDQxOC04NDQtNDAwMHg0MjQ1IEZheDogNDE4LTg0NC00NTM4Cj4gCj4g
RFJEQyBpcyBhbiBhZ2VuY3kgb2YgdGhlIERlcGFydG1lbnQgb2YgTmF0aW9uYWwgRGVmZW5jZSAv
IFJEREMgZXN0IHVuZSBhZ2VuY2UgZHUgbWluaXN0w6hyZSBkZSBsYSBEw6lmZW5zZSBuYXRpb25h
bGUKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGx0
dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4gaHR0cHM6
Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo+IAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
