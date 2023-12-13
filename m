Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ACAC4332F
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Dec 2023 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1702500162;
	bh=9m3/rxwHScbq7/0+2DHfpQWSLouA9vJB1uF6WDPvrBE=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=usx6atmmQrd+2wVLblM5xlIg3lN7RzfTQ1N7PBO51DQ7x0+a2HI5civEzPMQmPRtY
	 arnJ4LfyRlo+OwOZPBq7axtwgRDFLJHf189PQptybkmhkf8Mn3G5mDkMDIsWn47Ek0
	 mbllVTn0HG1cqr1GUC+yYvl9+9XRL0WoXpmkX6x1FnVrXYkCTLvCs3juzocJ/fef4B
	 MkuervfhcIMdLvu8+cE0Slqr9fDTWY7Lu76aQgh4NMt2a0wyJWhWFnC/EQMpN314xx
	 p47Te3/dVr2rMZ6aFQuulKQzSNzPePc6rERWbK5D/nj76P7CgIvRsJNlwQ2+KFgHD5
	 cKuCfzHKyoeMQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Sr6qj4nzwz14tD;
	Wed, 13 Dec 2023 15:42:41 -0500 (EST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by lists.lttng.org (Postfix) with ESMTPS id 4Sr6qh1C5Jz14cZ
 for <lttng-dev@lists.lttng.org>; Wed, 13 Dec 2023 15:42:39 -0500 (EST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bf8843a6fso7264654e87.0
 for <lttng-dev@lists.lttng.org>; Wed, 13 Dec 2023 12:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500158; x=1703104958;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=98cOndrU9DwKPYq0QxTEIN+rHrz4bfBUaSeaJdL/NA8=;
 b=OtB6WcFj2/MN9t2+pot2h0tl/PExxc/I3fZa1wH3+5Fsm52b334/nuos9qtbx9CyzS
 P/igqywTQCUaHn4VDdWdR5F4OqvuzmoYJkheCk/7VhHEowWpUO+/OyfZpmyjXQag10Qg
 cMcd9x9eZOgSEsU8DEJAkiDomxZE7EtKC6PEicBXuOS85f8L6ecHMdYX0p1dc8O7jlOt
 kAwSgkq9jBMVcUPVMggpzK9KfH+0WL6v0U7wJBomzBhDGJ/AM5EI+tgetyBVicuflpeV
 kAwK3YaCX7G0xPRwmSzs6PS35DF5rS5TFZug/EifjVxerVbt1W+/nooaRpG26DQqkqhh
 5r1w==
X-Gm-Message-State: AOJu0YyBRzlThUGaIXZrBVb5nt7bYP7stnOh3MQ++AdGpl0s0lxU/7OH
 /D8fR05na86cQER2IrYtuwt5nOfzJN5N3m9FGwOncSBfzn+EBw==
X-Google-Smtp-Source: AGHT+IFjRXisrplofiv2hE/sKFtB06qwUL5jWHBX9r2iqISqMfLMm0hoEiADSOSnRDEoG8lSoEkltIMY9O/nwFjSBWY=
X-Received: by 2002:a05:6512:23a2:b0:50b:c60b:25ce with SMTP id
 c34-20020a05651223a200b0050bc60b25cemr5986095lfv.7.1702500157865; Wed, 13 Dec
 2023 12:42:37 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 13 Dec 2023 15:42:11 -0500
Message-ID: <CAB4xu_2nfjYArxyhvKB0_cHzRXoBLzcfAvJTXku5LfOdruQJdw@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: vfialko@marvell.com
Subject: [lttng-dev] Access specific fields from metadata file
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Replying to an email from Volodymyr Fialko which was mistakenly erased.

> Hello all,
>
> I'm trying to parse metadata file only, to get information about all
> possible trace points. I'm using "Inspect event classes" example:
> https://babeltrace.org/docs/v2.0/python/bt2/examples.html#inspect-event-classes
> It mainly does all what I need, but there still some fields, that I
> could not figure out how to access:
>
> 1. How to access event.header struct from stream?
>        stream definition:
>        stream {
>            packet.context := struct {
>                uint8_t core_id;
>            };
>             event.header := struct {
>                uint8_t id;
>            };
>        };
>
>    It's possible to access packet.context via
>    stream_class.packet_context_field_class, but I dot not see similar
>    property for event.header. (event_common_context_field_class -
>    returns None)

You can't: headers, and some fields of the packet context, are specific
to CTF itself, therefore a `src.ctf.*` component uses them, but they
don't reach the downstream components. The libbabeltrace2 API itself
doesn't offer packet and event header access.

Why do you need them?

> 2. How to obtain string length?

>    Event definition:
>    typealias integer {size = 8; base = x;}:= uint8_t;
>    typealias integer {size = 8; signed = false; encoding = ASCII; } := string_bounded_t;
>        event {
>            id = 0x00;
>            name = "trace_point_1";
>            fields := struct {
>                uint8_t arr[32];
>                string_bounded_t str[32];
>            };
>        };
>    Fields are parsed into following Classes:
>        arr: `bt2._StaticArrayFieldClassConst`: has length property
>        str: `bt2._StringFieldClassConst`:      no length property
>    Is there some other way to get str length?

There's no way currently. A `src.ctf.*` component recognizes an array of
integer fields having an encoding as a string, and translates this to a
libbabeltrace2 string field (that's what the intention is after all).

Again, what would be the use case here?

Please note that the upcoming major revision of CTF, CTF 2, features a
JSON metadata stream, meaning you'll be able to get that information
much more easily than with the metadata DSL (TSDL) of CTF 1.8.

The latest specification RC is available here:
<https://diamon.org/ctf/files/>.

Babeltrace 2.1 and LTTng 2.15 will support CTF 2.

BR,

Philippe Proulx
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
