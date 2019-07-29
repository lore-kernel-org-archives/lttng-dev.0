From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: What is _prev_state in sched_switch?
Date: Mon, 29 Jul 2019 11:08:22 -0400
Message-ID: <aa931b19-0a14-8659-aa9a-13e7f6523465__26100.6085945823$1564412925$gmane$org@gydle.com>
References: <CAEWVvOS48D3Jfp4==qrrODzdSSjo+-UOuvZyya1O_f2t9B9Z1A@mail.gmail.com>
 <0e850b02-3fec-a335-3f37-8579ad1b704d@gydle.com>
 <CAEWVvOSu4vbiDpMCCTHdP59xNaMsAJ74orA52amRaFfoN7jfXQ@mail.gmail.com>
 <18d63d8c-da2d-54c3-3a9a-1d77a5a3a675@gydle.com>
 <CAEWVvORgCQW8ScJZctu7dzT3QaO0PY50qmR-Aov9YHV1GkB+JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45y33g0fV1z18Tc
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 11:08:30 -0400 (EDT)
In-Reply-To: <CAEWVvORgCQW8ScJZctu7dzT3QaO0PY50qmR-Aov9YHV1GkB+JQ@mail.gmail.com>
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
To: Ravindra Kumar Meena <rmeena840@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CgpPbiAyMDE5LTA3LTI5IDU6MDcgYS5tLiwgUmF2aW5kcmEgS3VtYXIgTWVlbmEgd3JvdGU6Cj4g
T2theS4gVGhlIGFib3ZlIGxpbmsgd2FzIHNvbWV3aGF0IGhlbHBmdWwgYnV0IEkgc3RpbGwgZGlk
bid0IGdldCB3aGF0IGlzIHRoZSBtZWFuaW5nIG9mIHswLCAxLCAxMDI2LCA0MDk2fSB2YWx1ZXMg
aW4gX3ByZXZfc3RhdGUuwqAKPiAKCkNocmlzdG9waGUgZXhwbGFpbmVkLCB0aGUgdmFsdWVzIG9m
IF9wcmV2X3N0YXRlLgoKSW4gYWRkaXRpb24sIEkgc3VnZ2VzdCB5b3UgcmVhZCB0aG9zZSBsaW5r
cyAoZnJvbSBnZW5lcmFsIHRvIHNwZWNpZmljKToKCi0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3Jn
L3dpa2kvRmluaXRlLXN0YXRlX21hY2hpbmUKLSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lr
aS9TY2hlZHVsaW5nXyhjb21wdXRpbmcpCi0gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9j
dW1lbnRhdGlvbi9zY2hlZHVsZXIvc2NoZWQtZGVzaWduLUNGUy50eHQKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
