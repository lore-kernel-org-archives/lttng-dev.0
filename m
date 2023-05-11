Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18679C77B7C
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683823054;
	bh=iVp8cVELOCfJbFwCuKbnpObBqLVaPQ+H+Jhc19hXdDc=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=yKgR9r5jXbOZh5wRvzlNtHACrz1DoaabcDs5hz52b/7x8ractFr3U1fhce5WwfJ8R
	 phziZ7iIXCLv0LlUTC6vWWfuvgjaKF5jaLk0Iu2OtmRMUimO3MzPK9/fgD/n3/6DNY
	 doPsSL+ssB+v5zxsx5o4cptLM3iEKtBGmt/E+zi9nc0oh4eeTE2AXIBhAUHe8IFVju
	 bIGpmfWr8YunoM60Iiw0ReEZv1zSODkkpCVa9SIsbN/WfnmhK/IQprjwcilNdxKCPl
	 3Z4iAl3OVUzWOXVLRRQO9L9Q7laNTGO86XqzvVU5KJUVYItl4NlSJwJbIrGVcYIAzW
	 YvXIn5oOulNBA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHHcZ30wszSjg;
	Thu, 11 May 2023 12:37:34 -0400 (EDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by lists.lttng.org (Postfix) with ESMTPS id 4QHHcX3qvwzSjd
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 12:37:32 -0400 (EDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-50bc22805d3so13500541a12.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 09:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683822991; x=1686414991;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWivjCZfLnHtBOr+RUfYMd6AMym06cC9TLy2oSdG4To=;
 b=Mm7BOsUFIqir4Vph+uq3RlR7W03xegSohcOAFej2ezfib1z66hahJeELVc9Zsznehe
 Bnbo21cqA5KB/6ViTQIAq3q6lb0br8nGhgJ0mOwVphecqoOO7YPuzzdDSv8byWdvoqHD
 GZQ/7DSgpk1ibjbuM+EmAbo867Xe0dIxl+KIfeYcGlNPsLiHp8XCliGSwtYJ4gjh/ovD
 Tyllmt754CY6FiVE5xvkTFDr8UqzamVFVlP5E9ImpfQWg6+eKKcTu6vAixtVL6h+jO93
 IcTL7a2clQiV8j/kfP4EECn6RDJ7PVTT3RggwN/hopJMzFbmqCB0xFYf5STAWCllN6Uy
 7WNg==
X-Gm-Message-State: AC+VfDx9YhRIZy4N147WhUKHJqdwg+mL6ZIf34LCzYwBldNLWZ5nbkFi
 qbr6q7thWCpK23C+g7pqew0nc3KuFaXnGecOQlu0z81E
X-Google-Smtp-Source: ACHHUZ5F3S7Z5ZwYLZHbpLJSFU/mtx7c0+uRFvRl7OyRreuBbSgtZ1WTEHCQXIisYZlQO+zs4tFImJxp7cvRy1xWkMA=
X-Received: by 2002:a17:907:7293:b0:969:dda1:38a4 with SMTP id
 dt19-20020a170907729300b00969dda138a4mr11034663ejc.38.1683822990647; Thu, 11
 May 2023 09:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
In-Reply-To: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
Date: Thu, 11 May 2023 12:36:19 -0400
Message-ID: <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] I'm still getting empty ust traces using tracef
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

Li4uIG1vcmUgYmFja2dyb3VuZC4gIEkndmUgYWx3YXlzIHVzZWQgbHR0IGluIHRoZSBrZXJuZWwg
c28gSSBkb24ndApoYXZlIG11Y2ggZXhwZXJpZW5jZSB3aXRoIHRoZSB1c2VyIHNpZGUgb2YgaXQg
YW5kIGVzcGVjaWFsbHkKbXVsdGktdGhyZWFkZWQsIG11bHRpLWNvcmUgc28gSSdtIHByb2JhYmx5
IG1pc3Npbmcgc29tZSBmdW5kYW1lbnRhbApjb25jZXB0cyB0aGF0IEkgbmVlZCB0byB1bmRlcnN0
YW5kLgoKUmVnYXJkcywKCkJyaWFuCgpPbiBUaHUsIE1heSAxMSwgMjAyMyBhdCAxMTo1M+KAr0FN
IEJyaWFuIEh1dGNoaW5zb24gPGIuaHV0Y2htYW5AZ21haWwuY29tPiB3cm90ZToKPgo+IEhpLAo+
Cj4gSSBwb3N0ZWQgYSB3aGlsZSBhZ28gKHRocmVhZCAtIFVzaW5nIGx0dG5nIDIuMTEgYW5kIFVT
VCBkb2Vzbid0IGFwcGVhcgo+IHRvIHdvcmsgLSBnZXR0aW5nIGVtcHR5IHRyYWNlIGZpbGVzKSBh
Ym91dCB0aGlzIHByb2JsZW0gSSdtIGhhdmluZwo+IHdpdGggZ2V0dGluZyBlbXB0eSB0cmFjZSBs
b2dzLgo+Cj4gSSd2ZSBzaW5jZSB1cGdyYWRlZCB0byBsdHRuZyB2Mi4xMyBhbmQgd2hpbGUgSSBj
YW4gZG8gYSBzaW1wbGUgaGVsbG8KPiB3b3JsZCBwcm9ncmFtIHdpdGggdHJhY2VmIGFuZCBnZXQg
ZXZlbnRzIGluIHRoZSBsb2cgZmlsZXMsIG15IG1vcmUKPiBjb21wbGljYXRlZCBsYXJnZSBtdWx0
aS10aHJlYWRlZCBhcHAgSSdtIHRyeWluZyB0byBkZWJ1ZyBpcyBzdGlsbAo+IGdldHRpbmcgZW1w
dHkgbG9nIGZpbGUgdHJhY2VzLgo+Cj4gSSBjYW4gbGlzdCB0aGUgdXNlciBzcGFjZSBldmVudHMg
aW4gbXkgYXBwLgo+Cj4gTmV4dCBJIGRvOgo+Cj4gbHR0bmcgZW5hYmxlLWV2ZW50IC0tdXNlcnNw
YWNlICdsdHRuZ191c3RfdHJhY2VmOionCj4KPiAuLi4gdG8gZW5hYmxlIHRoZSBldmVudHMsIHN0
YXJ0IGx0dG5nLCBzdGFydCBteSBhcHAsIC4uLi4gYW5kIEkgZ2V0IGEKPiB0cmFjZSBkaXJlY3Rv
cnkgc3RydWN0dXJlIHRoYXQncyBlbXB0eS4KPgo+IEkgZmVlbCBsaWtlIEkndmUgcmVhZCBldmVy
eSB0aHJlYWQgaW4gdGhlIGFyY2hpdmVzIGFib3V0IHBlb3BsZSBoYXZpbmcKPiB0aGUgc2FtZSBw
cm9ibGVtLgo+Cj4gSSBkaWQgdHJ5IHVzaW5nIExEX1BSRUxPQUQgd2l0aCB2YXJpb3VzIGxpYnMg
dGhpbmtpbmcgdGhhdCB3YXMgdGhlCj4gcHJvYmxlbSBidXQgc28gZmFyIEknbSBzdGlsbCBnZXR0
aW5nIGVtcHR5IHRyYWNlcy4KPgo+IFNvIGZhciBJJ3ZlIHRyaWVkOgo+Cj4gTERfUFJFTE9BRD1s
aWJsdHRuZy11c3QtbGliYy13cmFwcGVyLnNvLjE6bGlibHR0bmctdXN0LXB0aHJlYWQtd3JhcHBl
ci5zby4xOmxpYmx0dG5nLXVzdC1kbC5zby4xOmxpYmx0dG5nLXVzdC1mb3JrLnNvLjE6bGlibHR0
bmctdXN0LWZkLnNvLjEKPiAvdXNyL2xvY2FsL2Jpbi9teV9hcHAKPgo+IEkgZ3Vlc3Mgb25lIHF1
ZXN0aW9uIEkgaGF2ZSBpcyBob3cgZG8gSSBkZXRlcm1pbmUgd2hpY2ggImhlbHBlciBsaWJzIgo+
IEkgbmVlZCB0byBwcmVsb2FkPwo+Cj4gVGhlIGFwcGxpY2F0aW9uIEknbSB3b3JraW5nIG9uIGlz
IG1hZGUgdXAgb2YgYSBidW5jaCBvZiBzbWFsbGVyIHN0YXRpYwo+IGxpYnMgbGlua2VkIHRvZ2V0
aGVyIGludG8gb25lIGJpZyBleGVjdXRhYmxlIGFuZCB0aGF0IGlzIGxpbmtlZCB3aXRoCj4gLWxs
dHRuZy11c3QgYW5kIC1sZGwuCj4KPiBJJ20gcHJldHR5IHN0dWNrIGF0IHRoZSBtb21lbnQuICBB
bnlvbmUgaGF2ZSBhbnkgd2lzZG9tIG9uIHdoYXQgSQo+IG1pZ2h0IGJlIGRvaW5nIHdyb25nIG9y
IGhvdyBJIGNhbiB0ZWxsIHdoeSBJJ20gbm90IGdldHRpbmcgZXZlbnRzIGluCj4gdGhlIGxvZ3M/
Cj4KPiBUaGFua3MsCj4KPiBCcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsdHRuZy1kZXYgbWFpbGluZyBsaXN0Cmx0dG5nLWRldkBsaXN0cy5sdHRu
Zy5vcmcKaHR0cHM6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
