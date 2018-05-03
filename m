From: Anders Wallin <wallinux@gmail.com>
Subject: lttng-tools 2.10.4 broken when auto loading session
Date: Thu, 03 May 2018 12:27:48 +0000
Message-ID: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw__49161.7388128818$1525350364$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1025047342460118694=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot0-x236.google.com (mail-ot0-x236.google.com
 [IPv6:2607:f8b0:4003:c0f::236])
 by lists.lttng.org (Postfix) with ESMTPS id 40cDv45DfKz18kg
 for <lttng-dev@lists.lttng.org>; Thu,  3 May 2018 08:28:00 -0400 (EDT)
Received: by mail-ot0-x236.google.com with SMTP id l22-v6so20395712otj.0
 for <lttng-dev@lists.lttng.org>; Thu, 03 May 2018 05:28:00 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1025047342460118694==
Content-Type: multipart/alternative; boundary="0000000000007704e9056b4c55ba"

--0000000000007704e9056b4c55ba
Content-Type: text/plain; charset="UTF-8"

Hi,

lttng-tools hangs when a session is stored /etc/lttng/session/auto/

$ head -10 /etc/lttng/sessions/auto/test.lttng
<?xml version="1.0" encoding="UTF-8"?>
<sessions>
        <session>
                <name>test</name>
                <domains>
                        <domain>
                                <type>UST</type>
                                <buffer_type>PER_UID</buffer_type>
                                <channels>
                                        <channel>
$ lttng-sessiond -d  # Hanging forever

I will continue investigate why, but I though you wanna know ASAP

Regards
Anders Wallin

--0000000000007704e9056b4c55ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5sdHRuZy10b29scyBoYW5ncyB3
aGVuIGEgc2Vzc2lvbiBpcyBzdG9yZWQgL2V0Yy9sdHRuZy9zZXNzaW9uL2F1dG8vPGJyPjxkaXY+
PGJyPjwvZGl2PjxkaXY+JCBoZWFkIC0xMCAvZXRjL2x0dG5nL3Nlc3Npb25zL2F1dG8vdGVzdC5s
dHRuZ8KgPC9kaXY+PGRpdj4mbHQ7P3htbCB2ZXJzaW9uPSZxdW90OzEuMCZxdW90OyBlbmNvZGlu
Zz0mcXVvdDtVVEYtOCZxdW90Oz8mZ3Q7PC9kaXY+PGRpdj4mbHQ7c2Vzc2lvbnMmZ3Q7PC9kaXY+
PGRpdj7CoCDCoCDCoCDCoCAmbHQ7c2Vzc2lvbiZndDs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZsdDtuYW1lJmd0O3Rlc3QmbHQ7L25hbWUmZ3Q7PC9kaXY+PGRpdj7CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmbHQ7ZG9tYWlucyZndDs8L2Rpdj48ZGl2PsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZsdDtkb21haW4mZ3Q7PC9kaXY+PGRpdj7CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7dHlwZSZndDtVU1QmbHQ7
L3R5cGUmZ3Q7PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmbHQ7YnVmZmVyX3R5cGUmZ3Q7UEVSX1VJRCZsdDsvYnVmZmVyX3R5cGUmZ3Q7
PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmbHQ7Y2hhbm5lbHMmZ3Q7PC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmbHQ7Y2hhbm5lbCZndDs8L2Rpdj48ZGl2
PiQgbHR0bmctc2Vzc2lvbmQgLWTCoCAjIEhhbmdpbmcgZm9yZXZlcjxicj48YnI+SSB3aWxsIGNv
bnRpbnVlIGludmVzdGlnYXRlIHdoeSwgYnV0IEkgdGhvdWdoIHlvdSB3YW5uYSBrbm93IEFTQVA8
YnI+PGJyPlJlZ2FyZHM8L2Rpdj48L2Rpdj48ZGl2PkFuZGVycyBXYWxsaW48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48L2Rpdj4NCg==
--0000000000007704e9056b4c55ba--

--===============1025047342460118694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1025047342460118694==--
