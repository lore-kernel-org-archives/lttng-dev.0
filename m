From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.10.3 - KeKriek
Date: Mon, 26 Mar 2018 14:06:45 -0400
Message-ID: <20180326180641.GB2540__17626.2279543609$1522087499$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 by lists.lttng.org (Postfix) with ESMTPS id 4092CY51xbzxZ5
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 14:06:49 -0400 (EDT)
Received: by mail-qk0-x241.google.com with SMTP id b198so21079803qkg.9
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 11:06:49 -0700 (PDT)
Received: from gmail.com (192-222-157-41.qc.cable.ebox.net. [192.222.157.41])
 by smtp.gmail.com with ESMTPSA id
 r9sm5911391qtm.75.2018.03.26.11.06.47 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 26 Mar 2018 11:06:47 -0700 (PDT)
Content-Disposition: inline
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

SGkgYWxsLAoKVGhlIHRoaXJkIGJ1Zy1maXggcmVsZWFzZSBvZiBMVFRuZy1Ub29scyAyLjEwIC0g
S2VLcmllayBoYXMganVzdCBiZWVuCnJlbGVhc2VkLiBUaGlzIHJlbGVhc2UgYWRkcmVzc2VzIGEg
bnVtYmVyIG9mIGlzc3VlcyBsaXN0ZWQgYmVsb3cuCgoyMDE4LTAzLTI2IGx0dG5nLXRvb2xzIDIu
MTAuMyAoUHVycGxlIERheSkKCSogRml4OiBzZXQgZXJybm8gd2l0aCB2YWx1ZSBmcm9tIFNPX0VS
Uk9SIG9uIGVycm9yLgoJKiBGaXg6IG1pc3NpbmcgdmFsdWUgaGFuZGxpbmcgZm9yIGx0dG5nX2V2
ZW50X2NvbnRleHRfdHlwZQoJKiBGaXg6IFVzZSBTT0xfU09DS0VUIGxldmVsIGZvciBTT19LRUVQ
QUxJVkUgb24gYWxsIHBsYXRmb3JtCgkqIEZpeDogZXJyb3Igb3V0IG9uIGxlZnRvdmVyIGFyZ3Vt
ZW50cwoJKiBGaXg6IHJlcGx5IHRvIHZlcnNpb24gY2hlY2sgZXZlbiBvbiBwcm90b2NvbCBtaXNt
YXRjaAoJKiBGaXg6IGVycm9yIGhhbmRsaW5nIG9uIHJlbGF5IHZlcnNpb24gY2hlY2sKCSogRG9j
dW1lbnQgYWRkLWNvbnRleHQgbGltaXRhdGlvbiBmb3Igc3RhcnRlZCBzZXNzaW9uCgkqIEZpeDog
YWRkLWNvbnRleHQgY2Fubm90IGJlIHBlcmZvcm1lZCBhZnRlciBhIHNlc3Npb24gaGFzIGJlZW4g
c3RhcnRlZAoJKiBGaXg6IGR1cGxpY2F0ZWQga2VybmVsIGNvbnN1bWVyIHNvY2tldCBsb2NraW5n
CgkqIEZpeDogcmVtb3ZlIHVudXNlZCBldmVudCB0eXBlcyBpbiBNSSBYTUwgc2NoZW1hCgkqIFRl
c3RzOiBjbGVhbmx5IGV4aXQgZnJvbSB0ZXN0IGFwcHMgb24gcmVjZXB0aW9uIG9mIFNJR1RFUk0K
CSogRG9jdW1lbnQgY29uc3VtZXIgc29ja2V0IGxvY2tpbmcgYXNzdW1wdGlvbnMKCSogRml4OiBj
b25zdW1lciBzb2NrZXQgbG9jayBub3QgaGVsZCBkdXJpbmcgc25hcHNob3QgcmVjb3JkCgkqIEZp
eDogc2V0X3JlbGF5ZF9mb3Jfc25hcHNob3QgZG9lcyBub3QgYWNxdWlyZSB0aGUgY29uc3VtZXIg
c29ja2V0IGxvY2sKCSogRml4OiBzZW5kX2NoYW5uZWxfbW9uaXRvcl9waXBlIGRvZXMgbm90IHRh
a2UgdGhlIGNvbnN1bWVyIHNvY2tldCBsb2NrCgkqIERvY3VtZW50IHRoZSBsb2NraW5nIGFzc3Vt
cHRpb25zIG9mIGNvbnN1bWVyZC1yZWxheWQgc29ja2V0IHBhc3NpbmcKCSogQXNzZXJ0IHRoYXQg
dGhlIGNvbnN1bWVyIGxvY2sgaXMgaGVsZCB3aGlsZSBzZW5kaW5nIEZEcyB0byBjb25zdW1lcmQK
CSogQXNzZXJ0IHRoYXQgdGhlIGNvbnN1bWVyIHNvY2tldCBsb2NrIGlzIHRha2VuIGR1cmluZyBj
b21tdW5pY2F0aW9uCgkqIFRlc3RzOiByZWZ1c2UgdG8gcnVuIHRlc3Qgc3VpdGUgaWYgbHR0bmcg
cHJvY2Vzc2VzIGFyZSBwcmVzZW50CgkqIEZpeDogbWV0YWRhdGEgY2hhbm5lbCBsZWFrIHdoZW4g
dXNpbmcgdGhlIHNuYXBzaG90IHRyYWNpbmcgbW9kZQoKQXMgYWx3YXlzLCBwbGVhc2UgcmVwb3J0
IGFueSBpc3N1ZSB5b3UgbWF5IGVuY291bnRlciB0byBidWdzLmx0dG5nLm9yZwpvciBvbiB0aGlz
IG1haWxpbmcgbGlzdC4KClByb2plY3Qgd2Vic2l0ZTogaHR0cHM6Ly9sdHRuZy5vcmcKCkRvd25s
b2FkIGxpbms6Cmh0dHBzOi8vbHR0bmcub3JnL2ZpbGVzL2x0dG5nLXRvb2xzL2x0dG5nLXRvb2xz
LTIuMTAuMy50YXIuYnoyCgpHUEcgc2lnOgpodHRwczovL2x0dG5nLm9yZy9maWxlcy9sdHRuZy10
b29scy9sdHRuZy10b29scy0yLjEwLjMudGFyLmJ6Mi5hc2MKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1k
ZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYK
