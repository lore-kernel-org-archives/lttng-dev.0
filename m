Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9BFC7EE25
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 19:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684436399;
	bh=DKiyZ2oZpllU7zN+NSsSYv8ayZ2zTbncHPt9e8+9Rvs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uOwmomCo/hbO6+BvZJPR4X4XV16G+Zir4qHy0KO3CQk91ue2GHf2qHWvwcInogbbY
	 bfhvc30OC+yX6tjin1GCib8IUl5LjQDFNUx/OLrNXyGp0N+GzZk7I+GB0YuJXf+BOy
	 J8n/3T6FB6wSJekhV3sVq4PYgcw8vJKzQMua/oWYSe61zOPhxVUVqz3dYW0J6B6sD7
	 +KuKoM5lZv6NMkrsbK+1UmIk5lFx9C/h327bHh0+G9KSCbeBM2llmfy71TxZ0XPX5i
	 U+LPb8oxKhiraMG01xepigsz+wXl0Kj5tPQaZzUx4cGQ+x/STN+PcI8e8LWuThBYjq
	 oZOCbzVHlwwww==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMfRf5R2dz1GLL;
	Thu, 18 May 2023 14:59:58 -0400 (EDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMfRd0ppnz1GHy
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 14:59:56 -0400 (EDT)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-510db954476so2614728a12.0
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 11:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684436336; x=1687028336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5bZz/r+zzcbNtBaH+bdqEFfrRmojIMLQv7uvwB35Dk=;
 b=euXNvz+IFjRBBYyEcKHZ48sSKB+9Pn8Dxr+PlxAhRdreNQmhgntQmFd4lXntFyLWZl
 I1rLp1WqbF/bkplsSPm3t8To+aInGkMajgNfLqe6ayeNYZUu8/o3jCGbMYoYjWB5EepQ
 EOyjhOxq3FnW4u8n/YRZyP7CK2F+YAq6kVqGGjTcJe/dRNVtyVyXogXeBJ6EVg5sLCSx
 zBIFzWZHGKFyg3g4OoVW3vhNYWazkK69WoNrwcTG7pXNUa2bn2xw195tYDidb6JmI26S
 GaQbR13d+QD2jVB7lKAwPNSA8S3GetYlGKlbnWqimkrbEFWDqfDjHa4Gc6/Hq7+gMOcZ
 rMOw==
X-Gm-Message-State: AC+VfDz0Ilwyg1+gt0sAkbbs+iLi65OeaiALlvTziP7n02i82+zXwj8O
 xNMIpdlCD9t0H1zrioYBHL5ZgtW//AqbgSMZdKiMBRpYgzc=
X-Google-Smtp-Source: ACHHUZ6MhUh9pRR7HZdJ6YmBB+sJ6raB6S525jWzQsUh7CwmWixDt2PNP7+f1mpx5AZ9KVS54ADtkPSh1KNiC1ovL6c=
X-Received: by 2002:aa7:d892:0:b0:50b:d57c:2a7c with SMTP id
 u18-20020aa7d892000000b0050bd57c2a7cmr6255759edq.18.1684436335503; Thu, 18
 May 2023 11:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
 <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
 <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
 <CAFZh4h8rZU7Nd-6FptvsibgMXURu0EHKXeouRzNg0mLbTr9t+Q@mail.gmail.com>
In-Reply-To: <CAFZh4h8rZU7Nd-6FptvsibgMXURu0EHKXeouRzNg0mLbTr9t+Q@mail.gmail.com>
Date: Thu, 18 May 2023 14:58:44 -0400
Message-ID: <CAFZh4h_Z6ZrYLV+F7rD_yvr70L_Ryp9GS0Sv12bj0k5QASTXHA@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCBNYXkgMTgsIDIwMjMgYXQgMTE6MDDigK9BTSBCcmlhbiBIdXRjaGluc29uIDxiLmh1
dGNobWFuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCAxMDo0
NeKAr0FNIE1hdGhpZXUgRGVzbm95ZXJzCj4gPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNv
bT4gd3JvdGU6Cj4gPgo+ID4gT24gMjAyMy0wNS0xOCAxMDoxMCwgQnJpYW4gSHV0Y2hpbnNvbiB3
cm90ZToKPiA+IFsuLi5dCj4gPiA+IEkgdXBkYXRlZCBteSBoZWxsbyB3b3JsZCB0byBoYXZlIGEg
ZnVuY3Rpb24gSSdkIGxpa2UgdG8gdXNlIHRoZQo+ID4gPiAtLXVzZXJzcGFjZS1wcm9iZSBtZXRo
b2Qgb24gd2l0aCB0aGUgdmVyeSBvcmlnaW5hbCBuYW1lIG9mCj4gPiA+ICdwcm9iZV9mdW5jdGlv
bic6Cj4gPiA+Cj4gPiA+ICNpbmNsdWRlIDxzdGRpby5oPgo+ID4gPiAjaW5jbHVkZSA8bHR0bmcv
dHJhY2VmLmg+Cj4gPiA+Cj4gPiA+IHZvaWQgcHJvYmVfZnVuY3Rpb24oaW50IGkpOwo+ID4gPgo+
ID4gPiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+ID4gPiB7Cj4gPiA+ICAgICB1
bnNpZ25lZCBpbnQgaTsKPiA+ID4gICAgIHB1dHMoIkhlbGxvLCBXb3JsZCFcblByZXNzIEVudGVy
IHRvIGNvbnRpbnVlLi4uIik7Cj4gPiA+ICAgICAvKgo+ID4gPiAgICAgICogVGhlIGZvbGxvd2lu
ZyBnZXRjaGFyKCkgY2FsbCBvbmx5IGV4aXN0cyBmb3IgdGhlIHB1cnBvc2Ugb2YgdGhpcwo+ID4g
PiAgICAgICogZGVtb25zdHJhdGlvbiwgdG8gcGF1c2UgdGhlIGFwcGxpY2F0aW9uIGluIG9yZGVy
IGZvciB5b3UgdG8gaGF2ZQo+ID4gPiAgICAgICogdGltZSB0byBsaXN0IGl0cyB0cmFjZXBvaW50
cy4gWW91IGRvbid0IG5lZWQgaXQgb3RoZXJ3aXNlLgo+ID4gPiAgICAgICovCj4gPiA+ICAgICBn
ZXRjaGFyKCk7Cj4gPiA+Cj4gPiA+ICAgICBsdHRuZ191c3RfdHJhY2VmKCJOdW1iZXIgJWQsIHN0
cmluZyAlcyIsIDIzLCAiaGkgdGhlcmUhIik7Cj4gPiA+ICAgICBwcmludGYoIk51bWJlciAlZCwg
c3RyaW5nICVzIiwgMjMsICJoaSB0aGVyZSEiKTsKPiA+ID4KPiA+ID4gICAgIGZvciAoaSA9IDA7
IGkgPCBhcmdjOyBpKyspIHsKPiA+ID4gICAgICAgICBsdHRuZ191c3RfdHJhY2VmKCJOdW1iZXIg
JWQsIGFyZ3YgJXMiLCBpLCBhcmd2W2ldKTsKPiA+ID4gICAgICAgICBwcmludGYoIk51bWJlciAl
ZCwgYXJndiAlcyIsIGksIGFyZ3ZbaV0pOwo+ID4gPiAgICAgfQo+ID4gPgo+ID4gPiAgICAgcHV0
cygiUXVpdHRpbmcgbm93ISIpOwo+ID4gPgo+ID4gPiAgICAgcHJvYmVfZnVuY3Rpb24oaSk7Cj4g
PiA+Cj4gPiA+ICAgICByZXR1cm4gMDsKPiA+ID4gfQo+ID4gPgo+ID4gPiB2b2lkIHByb2JlX2Z1
bmN0aW9uKGludCBpKSB7Cj4gPiA+Cj4gPiA+ICAgICBsdHRuZ191c3RfdHJhY2VmKCJOdW1iZXIg
JWQsIHN0cmluZyAlcyIsIGkgKiBpLCAiaV4yIik7Cj4gPiA+ICAgICBwcmludGYoIk51bWJlciAl
ZCwgc3RyaW5nICVzIiwgaSAqIGksICJpXjIiKTsKPiA+ID4KPiA+ID4gfQo+ID4gPgo+ID4gPiAu
Li4gYW5kIEkgZ2V0IHRoZSBzYW1lIGVycm9yIGFzIGJlZm9yZSB3aGVuIEkgdHJ5IHRvIGVuYWJs
ZSB0aGUgcHJvYmU6Cj4gPiA+ICMgbHR0bmcgZW5hYmxlLWV2ZW50IC0ta2VybmVsCj4gPiA+IC0t
dXNlcnNwYWNlLXByb2JlPS91c3IvbG9jYWwvYmluL2hlbGxvOnByb2JlX2Z1bmN0aW9uCj4gPiA+
IEVycm9yOiBNaXNzaW5nIGV2ZW50IG5hbWUocykuCj4gPgo+ID4gQXMgdGhlIGVycm9yIHN0YXRl
cywgeW91IGFyZSBtaXNzaW5nIHRoZSBldmVudCBuYW1lLiBTZWUKPiA+Cj4gPiBtYW4gMSBsdHRu
Zy1lbmFibGUtZXZlbnQKPiA+Cj4gPiAgICAgICAgIGx0dG5nIFtHRU5FUkFMIE9QVElPTlNdIGVu
YWJsZS1ldmVudCAtLWtlcm5lbAo+ID4gICAgICAgICAgICAgICBbLS1wcm9iZT1TT1VSQ0UgfCAt
LWZ1bmN0aW9uPVNPVVJDRSB8IC0tc3lzY2FsbCB8Cj4gPiAgICAgICAgICAgICAgICAtLXVzZXJz
cGFjZS1wcm9iZT1TT1VSQ0VdCj4gPiAgICAgICAgICAgICAgIFstLWZpbHRlcj1FWFBSXSBbLS1z
ZXNzaW9uPVNFU1NJT05dCj4gPiAgICAgICAgICAgICAgIFstLWNoYW5uZWw9Q0hBTk5FTF0gRVZF
TlRbLEVWRU5UXS4uLgo+ID4KPiA+Cj4gPiBZb3Ugd2lsbCB3YW50IHNvbWV0aGluZyBsaWtlOgo+
ID4KPiA+IGx0dG5nIGVuYWJsZS1ldmVudCAtLWtlcm5lbCAtLXVzZXJzcGFjZS1wcm9iZT0vdXNy
L2xvY2FsL2Jpbi9oZWxsbzpwcm9iZV9mdW5jdGlvbiBteV9wcm9iZV9mdW5jdGlvbgo+ID4KPiA+
IFdoZXJlICJteV9wcm9iZV9mdW5jdGlvbiIgaXMgdGhlIGV2ZW50IG5hbWUgdGhhdCB3aWxsIGFw
cGVhciBpbiB0aGUgY29sbGVjdGVkIHRyYWNlcy4KPgo+IFdvdyEgIEkgbXVzdCBub3QgaGF2ZSB3
b2tlbiB1cCB0aGlzIG1vcm5pbmcgaGEsIGhhLiAgVGhhbmtzIGZvciB0aGF0IQo+IFRoZSBldmVu
dCBpcyBlbmFibGVkIG5vdy4gIEhvcGUgdG8gYWN0dWFsbHkgZ2V0IHRyYWNpbmcgZGF0YSBub3cu
CgpXZWxsLCBJIGd1ZXNzIHdlIGp1c3QgaGF2ZSB0aGUgYXBwIHRoYXQgdGh3YXJ0cyBhbGwgYXR0
ZW1wdHMgYXQgdHJhY2luZy4KCkkgZGlkIGEgZHluYW1pYyBwcm9iZSBvbiBzZXZlcmFsIGZ1bmN0
aW9ucyB0aGF0IHNob3VsZCBiZSBnZXR0aW5nCmNhbGxlZCBsaWtlIGNyYXp5IGFuZCBhZ2FpbiBJ
IGdldCBubyB0cmFjaW5nIGRhdGEuCgpUcmllZCBpdCB3aXRoIG15IGhlbGxvIHdvcmxkIGV4YW1w
bGUgYWJvdmUgYWZ0ZXIgTWF0aGlldSBzZXQgbWUKc3RyYWlnaHQgb24gdGhlIGV2ZW50IHN5bnRh
eCBhbmQgaXQgd29ya3MuCgpJIHNhdyB0aGlzIGNvbW1lbnQgaW4gdGhlIGRvY3VtZW50YXRpb24g
IkFzIG9mIHRoaXMgdmVyc2lvbiwgb25seSBVU0RUCnByb2JlcyB0aGF0IGFyZSBub3Qgc3Vycm91
bmRlZCBieSBhIHJlZmVyZW5jZSBjb3VudGVyIChzZW1hcGhvcmUpIGFyZQpzdXBwb3J0ZWQuIgoK
SSBkb24ndCBrbm93IHRoYXQgSSBjYW4gc2F5IHRoYXQgdGhpcyBmdW5jdGlvbiBJJ20gcHJvYmlu
ZyBpc24ndAoic3Vycm91bmRlZCIgYnkgYSByZWZlcmVuY2UgY291bnRlciwgaXQncyBpbiBhIGxh
cmdlIG11bHRpLXRocmVhZGVkCmFwcGxpY2F0aW9uIHNvIEkgZ3Vlc3MgaXQncyBwb3NzaWJsZS4K
ClNpZ2gsIEknbSBzdHJpa2luZyBvdXQgZXZlcnkgd2hpY2ggd2F5LgoKTm8gb2ZmZW5zZSAoc2lu
Y2UgdGhpcyBpcyBsdHRuZyBsaXN0IC0gcGxlYXNlIGRvbid0IGZsYW1lIG1lIC4uLiBJCndhbnQv
bmVlZCBsdHRuZyksIGJ1dCBJIHRoaW5rIEknbSBnb2luZyB0byB0cnkganVzdCBzdHJhaWdodCBr
cHJvYmVzCmFuZCB1cHJvYmVzIGFuZCBzZWUgaWYgdHJhY2UgY29tcGFzcyBjYW4gc2hvdyB0aG9z
ZSB0cmFjZXMgaW4gYW4KYXR0ZW1wdCB0byBnZXQgInNvbWV0aGluZy9hbnl0aGluZyIgd29ya2lu
Zy4KClJlZ2FyZHMsCgpCcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRuZy5v
cmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5n
LWRldgo=
