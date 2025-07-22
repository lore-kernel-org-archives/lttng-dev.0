Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA9C83F1A
	for <lttng-dev@archiver.kernel.org>; Tue, 22 Jul 2025 21:48:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmrVv6hhYz1dZP
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1753220919;
	b=PuMlEYITBgayt0V4aIyXaU8PNOVFkfZFBdindflCs8Wy7aPJ/WVX3FJg4uzX8HxoU8Ds
	 fGFrRKs4GqlreB4uS1JbImW1loX3wULnQ3eB8iHKwmYgA7Crfpnq8JeGrXryUcMYZ2U6z
	 EVnm8nwmlWDkypM4FXwHIROJGyJrIWAkq5C57kih8j4+ZgTbj0mOxD6Ilc7ds7HwCbbf4
	 dsmFUrP5VT+xOoav2kp/vjvgrdoq+0zRbJ9cXgfqMTha6NEOe+nr56vDnRs0Hg2SpfIgJ
	 o6PTwE51tYYH6TvGh4/EYcNSVhHy95omSlDpXvoDqtaeG7EpJGJDRtQlqHh4OyUADvA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1753220919;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=8MtBUPYU9AlNTNDzcNFOIu+nKffdgo8nbXjzg+QtPmE=;
	b=AULS3CO4J0KHKShzaW3JLg7q3FxhvW2P5P89YA6RYXX/QbVb29Nt7tlXRK8B/322wSPJ
	 qIyr6LeSr5E9YMTzTyAY0cg1n8FwPBEe7VK+Hnkj5IVXYqJNCn15QR3hOkgDAPGrTBvQ5
	 1Q+YV2ALiBB7xo0olq3FcqaZ4qqCmgg4eIhgrqIJ3mnS972SWLcSn8IyoS0KrLj5JHAlW
	 foZqgo1Jr11U45Btf5rXdjvbpUec3l6QqbmPUcbIqOW7Aw/YixG8AEy7CMl9W4POdbtz7
	 QJwjv2S7BpPfr4kgt0Kn9VRe1kkSB0SH8q0Hu5EmYJ4QR8wtVl8ViWgOiQe1sg71iIw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmrVv6hhYz1dZP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1753220919;
	bh=8MtBUPYU9AlNTNDzcNFOIu+nKffdgo8nbXjzg+QtPmE=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ZKZRiWvSeWepFSP3bAddxLybUY3+KGnGwwKgcaCY5FhKQ+/EtvLnoLhtTsBT5PalN
	 HFhcsSCNAJO/NY8oHkZKYzJkMM8pnelftLrUdlp4rBdMbyn+uYlFkvz7zFWIYhhTFf
	 wfq+70RLiND3OEBmjw2z85+R3rc2VlLuZD54DrxSufgVOsOCLbdbHsWxHuAfz6NWlC
	 O3IXDCguoULJYmDlIkkBsT51Q9cy/cbnvqYPozyPJQXr1lK3WarLsonaT7lCjU4459
	 mCcNre32Xh5Y3xhBPLgS238C2qOKAnL1I0pCE7VZgUKCpvCJyOcBhW599BNcTsFcLu
	 xTT55lFZaYGkQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bmrVv6hhYz1dZP;
	Tue, 22 Jul 2025 17:48:39 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bmRyJ63nGz1TC4
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bmRyJ63nGz1TC4
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by lists.lttng.org (Postfix) with ESMTPS id 4bmRyJ63nGz1TC4
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jul 2025 02:22:32 -0400 (EDT)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-555163cd09aso4135436e87.3
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jul 2025 23:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753165345; x=1753770145;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8MtBUPYU9AlNTNDzcNFOIu+nKffdgo8nbXjzg+QtPmE=;
 b=oLCu29TfvqGAGKeh0s7E09jvEjRa/cL5Pk+iHmmxC7gcbz+enWvqBE97f/gx1XNRuU
 hc47GFRCjvfqvGQhS35Ilm2K4hKsUKUfUa4XMQ7iS9ZlbaZQv34FqQzaTmTjvUil/5RQ
 +ZQQ+DzTM4hZT422SizZpfoltPph7OXG5+ZNWlk3CJk0SZSVaZ2Zovk1TDdOMiJO4fLw
 QThXiX3C6r7tchZykdkDPKsxoPzFy6uJm7TnHsxSjGMuPbeu2u5MK/CT5jNaXhgyCi6a
 0yNDfOheY9jGYJmk7L3vqo+2vrLnd8VWz0Qtpc8RyFKsaGyNNgqsyPa17aDXW5vZ8C5r
 T3qg==
X-Gm-Message-State: AOJu0YzjpcQJstHqrcngGfT4AdpwkXzJVtShNWIyWJzq3PY47edDuDgM
 ADco/CUgoZ6xWJaOuLrr1SI+j83zGk9KrARenoSUtFEBfhdpzpbIwieJZ2x+UOMFiwiPrDHBcQJ
 FNa1CyoaS/BWo18SP0Jq6dUP1lFMEQvQhrcOXyf44IJVTFvkv6j1z
X-Gm-Gg: ASbGncv81wqFstnK4M1gfVqIkFYci2Hjtm5YF9bK52fd5B6dp1qkB64U6WgE2JfxgCI
 8I+J06SGvEhf+DXCRkf1KMclfOhrP3CFP0a4tskCNOfTtcwujgNaTGpDvwhbzLQ67oLpmxcBhiF
 5GnUQUzjvIwFVB9cfHcUrMie73f13yqH8lshATPfqHGLZONpZRHrKu3Z+76IgUU0Tl0SQ35RikL
 lDqdA==
X-Google-Smtp-Source: AGHT+IFZtYoMj2QwADFfIcBV22ulhXIOJxEUGW8pefflHVl4AV8/bzfcNauwymG6FWq8TRh4aLu0k719oYeO49lk1as=
X-Received: by 2002:a05:6512:2391:b0:553:ac4e:c41 with SMTP id
 2adb3069b0e04-55a296fd1ebmr6271716e87.28.1753165345246; Mon, 21 Jul 2025
 23:22:25 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 21 Jul 2025 23:21:48 -0700
X-Gm-Features: Ac12FXynyA_7cqIbnlRP1y0OmrGxkxMTIFn0pJ-z9om8eH-7z30kuY44DMiXFow
Message-ID: <CAK49rV4DhdWJ8HeebmOhSMAj68anghiKMTKwxBWaSvtGcdW0bw@mail.gmail.com>
Subject: Adding new events / streams to an existing trace?
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="000000000000a2e6a4063a7e9df3"
X-Mailman-Approved-At: Tue, 22 Jul 2025 17:48:38 -0400
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
From: Alec Rivers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Alec Rivers <alec@shapertools.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000a2e6a4063a7e9df3
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to process an LTTng trace using babeltrace2's Python API. What
I want to do is add a new stream of events to an existing trace. My
approach is to create a custom source component that reads the existing
trace and forwards existing messages unchanged, but adds (interleaves, in
fact) some new events in a new stream.

So I have a custom UserMessageIterator that holds
a TraceCollectionMessageIterator that is reading from the original trace.
But if I output the unchanged events from the input iterator, that means
those events have a pre-baked trace and pre-baked trace class, to which I
am unable to add streams. (It seems that the C API may allow this, but the
Python one does not.) I could create a new trace class and a new stream for
my synthetic events, but then I'd have two parallel traces, and that's not
what I want (or is it? I'm new to all this).

For context, what I'm trying to achieve is to debug some erratic behavior
in an embedded Linux application, and I decided I'd like to see the
syscalls in the Flame Chart view in Trace Compass. So I'm my utility reads
all the syscall_entry_* and syscall_exit_* events and generates
corresponding func_entry and func_exit events. That part works fine -- but
getting the events into a trace alongside the existing events is what's
stymying me.

Thanks in advance for any help,

Alec

--000000000000a2e6a4063a7e9df3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello,<div><br></div><div>I am trying to =
process an LTTng trace using babeltrace2&#39;s Python API. What I want to d=
o is add a new stream of events to an existing trace. My approach is to cre=
ate=C2=A0a custom source component that reads the existing trace and forwar=
ds existing messages unchanged, but adds (interleaves, in fact) some new ev=
ents in a new stream.</div><div><br></div><div>So I have a custom UserMessa=
geIterator that holds a=C2=A0TraceCollectionMessageIterator that is reading=
 from the original trace. But if I output the unchanged events from the inp=
ut iterator, that means those events have a pre-baked trace and pre-baked t=
race class, to which I am unable to add streams. (It seems that the C API m=
ay allow this, but the Python one does not.) I could create a new trace cla=
ss and a new stream for my synthetic events, but then I&#39;d have two para=
llel traces, and that&#39;s not what I want (or is it? I&#39;m new to all t=
his).</div><div><br></div><div>For context, what I&#39;m trying to achieve =
is to debug some erratic behavior in an embedded Linux application, and I d=
ecided I&#39;d like to see the syscalls in the Flame Chart view in Trace Co=
mpass. So I&#39;m my utility reads all the syscall_entry_* and syscall_exit=
_* events and generates corresponding func_entry and func_exit events. That=
 part works fine -- but getting the events into a trace alongside the exist=
ing events is what&#39;s stymying me.</div><div><br></div><div>Thanks in ad=
vance for any help,</div><div><br></div><div>Alec</div></div>
</div>

--000000000000a2e6a4063a7e9df3--
