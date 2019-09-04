From: =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>
Subject: Scripting for user-defined analyses in Trace Compass
Date: Wed, 4 Sep 2019 12:24:56 -0400
Message-ID: <c55cb47e-24e4-98b6-36c5-1e006265e907__32804.6218420909$1567614503$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 46Nq4S0JK8zrX0
 for <lttng-dev@lists.lttng.org>; Wed,  4 Sep 2019 12:28:07 -0400 (EDT)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.92)
 (envelope-from <gbastien@versatic.net>) id 1i5Y8b-007lVC-Oc
 for lttng-dev@lists.lttng.org; Wed, 04 Sep 2019 12:28:06 -0400
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: tracecompass developer discussions <tracecompass-dev@eclipse.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

SGkgYWxsLAoKCkR1cmluZyB0aGUgbGFzdCBmZXcgbW9udGhzLCB3ZSd2ZSBiZWVuIHdvcmtpbmcg
aGFyZCB0byBtYWtlIFNjcmlwdGluZwphdmFpbGFibGUgYXMgYSB3YXkgdG8gZGVmaW5lIHlvdXIg
b3duIHRyYWNlIGFuYWx5emVzIGFuZCB2aXN1YWxpemF0aW9ucwppbiBUcmFjZSBDb21wYXNzLiBO
byBtb3JlIFhNTCBvciBUcmFjZSBDb21wYXNzIGRldmVsb3BtZW50IHJlcXVpcmVkISBJdAp1c2Vz
IHRoZSBFY2xpcHNlIEVBU0UgcHJvamVjdCBbMV0gYW5kIHRoZSBmZWF0dXJlIGlzIGF2YWlsYWJs
ZSB0aHJvdWdoCnRoZSBUcmFjZSBDb21wYXNzIEluY3ViYXRvciAoVG9vbHMgLT4gQWRkLW9ucy4u
LikKCkhlcmUncyBhIGJsb2cgcG9zdCBpbnRyb2R1Y2luZyB0aGlzIG5ldyBmZWF0dXJlIFsyXS4g
Tm90ZSB0aGF0IGNvbnRlbnQKb2YgdGhpcyBwb3N0IHJlcXVpcmVzIFRyYWNlIENvbXBhc3MgNS4x
IChub3QgeWV0IHJlbGVhc2VkKSBvciB0aGUgbGF0ZXN0CmRldmVsb3BtZW50IHNuYXBzaG90IFsz
XS4KCkFuZCBoZXJlJ3MgdGhlIHVzZXIgZG9jdW1lbnRhdGlvbiBmb3IgaXQgWzRdLgoKRmVlbCBm
cmVlIHRvIHRyeSBpdCwgc2VuZCB1cyBmZWVkYmFjaywgcmVxdWVzdCBuZXcgZmVhdHVyZXMuIEl0
IGlzIGZhcgpmcm9tIGZlYXR1cmUgY29tcGxldGUsIHdlIGZvY3VzZWQgb24gaG93IHRvIGRvY3Vt
ZW50IHRoZSBmZXcgZmVhdHVyZXMgd2UKaGF2ZSBzbyB1c2VycyBjYW4gZWFzaWx5IGV4cGxvcmUg
dGhlIGF2YWlsYWJsZSBmZWF0dXJlcyBhbmQgZGV2ZWxvcGVycwpkb24ndCBoYXZlIHRvbyBtdWNo
IHRyb3VibGUga2VlcGluZyBkb2N1bWVudGF0aW9uIHVwIHRvIGRhdGUgOy0pIFNvIGxldAp1cyBr
bm93IHdoYXQgeW91IHdvdWxkIGxpa2UgdG8gaGF2ZSBhdmFpbGFibGUgZWFzaWx5IHRocm91Z2gg
c2NyaXB0aW5nIQoKClsxXSBodHRwczovL3d3dy5lY2xpcHNlLm9yZy9lYXNlLwoKWzJdIGh0dHA6
Ly92ZXJzYXRpYy5uZXQvdHJhY2Vjb21wYXNzL2ludHJvZHVjaW5nRWFzZS5odG1sCgpbM10gaHR0
cHM6Ly9kb3dubG9hZC5lY2xpcHNlLm9yZy90cmFjZWNvbXBhc3MvbWFzdGVyL3JjcC8KCls0XQpo
dHRwczovL2FyY2hpdmUuZWNsaXBzZS5vcmcvdHJhY2Vjb21wYXNzLmluY3ViYXRvci9kb2Mvb3Jn
LmVjbGlwc2UudHJhY2Vjb21wYXNzLmluY3ViYXRvci5zY3JpcHRpbmcuZG9jLnVzZXIvVXNlci1H
dWlkZS5odG1sCgoKQ2hlZXJzLAoKR2VuZXZpw6h2ZQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZA
bGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9s
aXN0aW5mby9sdHRuZy1kZXYK
