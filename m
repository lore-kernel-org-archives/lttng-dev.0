Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7C2C6FD18
	for <lttng-dev@archiver.kernel.org>; Tue, 25 Apr 2023 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1682425888;
	bh=6EzfFMgVea4aZRTgt3GY8pk+IX87JxUD0tdO6UcFNqQ=;
	h=References:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=n9NGO6rcKMqBLhwqd/qIHOEECFRsKaCfq3SOs88S3nPxkuk1gmG7XxRGPwgHt6dVC
	 rYJD+AkqDE9q6OE0MxPGOsZIQBPBgb1TH+IAdm8KqHkqE/CaMhv8mpQ1OEUHtJ/Yjv
	 r2cDbr7p7LplQx3TYXjDXLyRC6bhdeV7jD2SdgBLzOU4Sk3FHYw6UKFkqijC8keiWx
	 jXDXaQXtUTEhZ+gUfE7NSlTkVmNixMk7OODPgwVLF18Py0tYEezb8cOgZwkGCDMFux
	 ggGGZIF3hM7uIXeoIMJK9/nm7m6n9p+vZ3kQ9EshiIFI0YlRE6stD79pepW8mMKLYW
	 We72L2LlU/o1Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Q5Lw00VRkzGpL;
	Tue, 25 Apr 2023 08:31:28 -0400 (EDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by lists.lttng.org (Postfix) with ESMTPS id 4Q5Lvz22fXzGpJ
 for <lttng-dev@lists.lttng.org>; Tue, 25 Apr 2023 08:31:27 -0400 (EDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-504efe702d5so8451627a12.3
 for <lttng-dev@lists.lttng.org>; Tue, 25 Apr 2023 05:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682425825; x=1685017825;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TsN1XXtsUnGh+G55Vc8bmKND4jG9B0P/6zUBJbLj480=;
 b=MVfe4NbPWiI0zHIa+jF1APJg2/pwEYpWIgmAX/ss32m7oO9OE32Aa6CqaucVcs31IK
 3JTIW0oZpHzuDIaHYztmt2JYe1gztfQQDJRp4vjyxrpjFZsWTBoODjXM5M1AgGRQkpnM
 v5M2ev7+2Ck/12tNtUad6z3vQ1+yIM1ynCq6nRwZf5mytR9ioIVm87M5IHaTBzlIhxd6
 RRyx8x/GM6yp9BufZVEPbGz2if8IY7Plcq9WZmzfgl/j4woMlLdTvU1ItYLduRJ8uKBI
 E/Oevm6cRfhc/AzYYbT6kDoWeJCgRql6wtDzorA4dCaHC7W4vvMs6zoAEcqpbTx9cnGq
 C9qA==
X-Gm-Message-State: AAQBX9fyffcDSaQ2rOVQ4s82FQSjBBhe3Sb098Y7Xbe672W9fUHQ3r4e
 ipZzg5GeAW+Mw0WoUy1jsL4kmE84qU2tJv9Sbc/N07MFJS4=
X-Google-Smtp-Source: AKy350aOCUDfr9JbjQT0vgbd8S40NRmfKwRi13n/xC6ENQQP3Q2iEuVXdiCxigscM0KFKuR/bQUXhRVXv16qBCUaMfk=
X-Received: by 2002:aa7:ce06:0:b0:507:4612:12df with SMTP id
 d6-20020aa7ce06000000b00507461212dfmr15783519edv.14.1682425825333; Tue, 25
 Apr 2023 05:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <9b162e6a547c41b284327034a9749027@amazon.com>
 <CAFZh4h_6zdF7uMF7EE6YgbEvvWWvc_4=uTderkwcUJVV8_mzvw@mail.gmail.com>
In-Reply-To: <CAFZh4h_6zdF7uMF7EE6YgbEvvWWvc_4=uTderkwcUJVV8_mzvw@mail.gmail.com>
Date: Tue, 25 Apr 2023 08:30:14 -0400
Message-ID: <CAFZh4h9JX91sK4H72OKqKzqUKn+GBgiC24NxyhLQOdBn61jVEw@mail.gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Using lttng 2.11 and UST doesn't appear to work -
 getting empty trace files
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
Content-Type: multipart/mixed; boundary="===============7013215603572134866=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7013215603572134866==
Content-Type: multipart/alternative; boundary="000000000000ae172d05fa284932"

--000000000000ae172d05fa284932
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So looking at my lttng-sessiond log I found some concerning issues of
things being "not found":

DEBUG1 - 10:53:52.130237000 [9674/9735]: Enable event command for event
'lttng_ust_tracef:*' (in _cmd_enable_event() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/cmd.c:2036)

DEBUG2 - 10:53:52.130399500 [9674/9735]: Trace UST channel channel0 not
found by name (in trace_ust_find_channel_by_name() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:197)

DEBUG1 - 10:53:52.130450125 [9674/9735]: Enabling channel  for session
auto-20210324-105310 (in cmd_enable_channel() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/cmd.c:1510)
DEBUG2 - 10:53:52.130496375 [9674/9735]: Trace UST channel channel0 not
found by name (in trace_ust_find_channel_by_name() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:197)

DEBUG3 - 10:53:52.130572000 [9674/9735]: Created hashtable size 4 at
0xffff90017170 of type 0 (in lttng_ht_new() at
../../../../lttng-tools-2.11.5/src/common/hashtable/hashtable.c:145)

DEBUG3 - 10:53:52.130619625 [9674/9735]: Created hashtable size 4 at
0xffff900175b0 of type 1 (in lttng_ht_new() at
../../../../lttng-tools-2.11.5/src/common/hashtable/hashtable.c:145)

DEBUG2 - 10:53:52.130666000 [9674/9735]: Trace UST channel channel0 created
(in trace_ust_create_channel() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:396)

DEBUG2 - 10:53:52.130713625 [9674/9735]: Channel channel0 is being created
for UST with buffer 1 and id 0 (in channel_ust_create() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/channel.c:461)

DEBUG2 - 10:53:52.130762250 [9674/9735]: Channel channel0 created
successfully (in channel_ust_create() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/channel.c:500)

DEBUG2 - 10:53:52.130807500 [9674/9735]: Trace UST channel channel0 found
by name (in trace_ust_find_channel_by_name() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:192)

DEBUG2 - 10:53:52.130851750 [9674/9735]: Trace UST event lttng_ust_tracef:*
NOT found (in trace_ust_find_event() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:235)

DEBUG2 - 10:53:52.130896500 [9674/9735]: Trace UST event
lttng_ust_tracef:*, loglevel (0,-1) created (in trace_ust_create_event() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:517)

DEBUG1 - 10:53:52.130968375 [9674/9735]: Sending response (size: 20,
retcode: Success (10)) (in thread_manage_clients() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/client.c:2236)
DEBUG1 - 10:53:52.134962250 [9674/9735]: Clean command context structure
(in clean_command_ctx() at
../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/client.c:659)

Not quite sure what to do about that.

Regards,

Brian

On Tue, Apr 25, 2023 at 12:56=E2=80=AFAM Brian Hutchinson <b.hutchman@gmail=
.com>
wrote:

> So instructions for tracef just say to link in lttng-ust, not dl, I didn'=
t
> use liblttng-ust.a so maybe I misspoke.
>
> https://lttng.org/docs/v2.11/#doc-tracef
>
> ... so that's what I did.
>
> When I compile in a tracepoint with trace provider, I link in lttng-ust
> and dl.  I'm assuming you can mix both tracef and tracepoint calls?
>
> I included a lttng-sessiond -vvv log in original post.  Are attachments
> allowed or should I have posted the context as a plain text post?  It's
> quite big.
>
> When I do lttng start, my app is already running via systemd at startup.
> Do I need to disable that and start the executable manually after enablin=
g
> the lttng ust events?
>
> Like I said, kernel trace is working fine, it's UST that appears to not b=
e
> working for some reason.  I have less experience with UST but I've been
> researching and searching archives and I see others complaining about wha=
t
> looks to be my problem but either don't see a solution or maybe I just
> don't understand it.
>
> Thanks,
>
> Brian
>
> On Tue, Apr 25, 2023 at 12:13=E2=80=AFAM Yitschak, Yehuda <yehuday@amazon=
.com>
> wrote:
>
>> It might be related to the static linking of lttng-ust
>> https://lists.lttng.org/pipermail/lttng-dev/2018-January/027705.html
>>
>> I also went down that path just to figure it=E2=80=99s not supported.
>>
>> Perhaps lttng documentation should be updated to make a clear note stati=
c
>> linking is not supported (or maybe I missed it)
>>
>> Yehuda
>>
>> Hi,
>>
>>
>>
>> I'm on an embedded platform, i.MX8 using Lttng 2.11 with 5.6.69 kernel.
>>
>>
>>
>> Tracing kernel events with lttng works fine but userspace (tracef and
>> trace provider type tracing) appears to have an issue I can't figure out=
.
>>
>>
>>
>> systemd is starting up my application ( a bunch of processes and threads
>> on multiple cpu's) on boot.
>>
>>
>>
>> I'm statically compiling and linking in lttng-ust.  If I use just tracef
>> type tracing, when I do lttng list --userspace I get nothing.  If I add =
in
>> a trace provider and a tracepoint, then I see my trace provider tracepoi=
nt
>> and:
>>
>>
>>
>>      lttng_ust_tracelog:TRACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type:
>> tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel: TRACE_DEBUG_LINE
>> (13)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (loglevel:
>> TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel: TRACE_DEBUG_UNIT
>> (11)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglevel: TRACE_DEBUG_MODULE
>> (10)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_PROCESS (loglevel:
>> TRACE_DEBUG_PROCESS (9)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (loglevel:
>> TRACE_DEBUG_PROGRAM (8)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglevel: TRACE_DEBUG_SYSTEM
>> (7)) (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_INFO (loglevel: TRACE_INFO (6)) (type:
>> tracepoint)
>>      lttng_ust_tracelog:TRACE_NOTICE (loglevel: TRACE_NOTICE (5)) (type:
>> tracepoint)
>>      lttng_ust_tracelog:TRACE_WARNING (loglevel: TRACE_WARNING (4))
>> (type: tracepoint)
>>      lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE_ERR (3)) (type:
>> tracepoint)
>>      lttng_ust_tracelog:TRACE_CRIT (loglevel: TRACE_CRIT (2)) (type:
>> tracepoint)
>>      lttng_ust_tracelog:TRACE_ALERT (loglevel: TRACE_ALERT (1)) (type:
>> tracepoint)
>>      lttng_ust_tracelog:TRACE_EMERG (loglevel: TRACE_EMERG (0)) (type:
>> tracepoint)
>>      lttng_ust_tracef:event (loglevel: TRACE_DEBUG (14)) (type:
>> tracepoint)
>>      lttng_ust_lib:unload (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>      lttng_ust_lib:debug_link (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>      lttng_ust_lib:build_id (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>      lttng_ust_lib:load (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>      lttng_ust_statedump:end (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>      lttng_ust_statedump:debug_link (loglevel: TRACE_DEBUG_LINE (13))
>> (type: tracepoint)
>>      lttng_ust_statedump:build_id (loglevel: TRACE_DEBUG_LINE (13))
>> (type: tracepoint)
>>      lttng_ust_statedump:bin_info (loglevel: TRACE_DEBUG_LINE (13))
>> (type: tracepoint)
>>      lttng_ust_statedump:start (loglevel: TRACE_DEBUG_LINE (13)) (type:
>> tracepoint)
>>
>>
>>
>> When I do lttng start, I get a directory structure in the trace director=
y
>> but the file sizes do not ever increase.  It's just a directory structur=
e
>> with files created and then that's it, no events being written to the
>> files.  At first I thought things just weren't linked in right and not
>> working but then discovered how to run lttng-sessiond in -vvv mode and t=
hen
>> could see lots of things are going on, tracing appears to be trying to w=
ork
>> as there is tons of activity being output by lttng-sessiond, but like I
>> said the trace files aren't being added to.
>>
>>
>>
>> I looked at the lttng-sessiond log I captured and can't quite make out
>> the problem so attaching it.
>>
>>
>>
>> I'm probably not doing something right but can't figure out what that is
>> so any pointers appreciated.
>>
>>
>>
>> Regards,
>>
>>
>>
>> Brian
>>
>>
>>
>

--000000000000ae172d05fa284932
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So looking at my lttng-sessiond log I found some conc=
erning issues of things being &quot;not found&quot;:</div><div><br></div><d=
iv><span style=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0);ba=
ckground-color:rgb(255,255,255)">DEBUG1 - 10:53:52.130237000 [9674/9735]: E=
nable event command for event &#39;lttng_ust_tracef:*&#39; (in _cmd_enable_=
event() at ../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/cmd.c:2036=
) =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>=
<br>DEBUG2 - 10:53:52.130399500 [9674/9735]: Trace UST channel channel0 not=
 found by name (in trace_ust_find_channel_by_name() at ../../../../lttng-to=
ols-2.11.5/src/bin/lttng-sessiond/trace-ust.c:197) =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<br>DEBUG1 - 10:53:52.130450125 [9674/9735]: Enabling cha=
nnel =C2=A0for session auto-20210324-105310 (in cmd_enable_channel() at ../=
../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/cmd.c:1510) =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG2 - 10:53:52.130496375 [9674/9735]: =
Trace UST channel channel0 not found by name (in trace_ust_find_channel_by_=
name() at ../../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c=
:197) =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG3 - 10:53:52.13057200=
0 [9674/9735]: Created hashtable size 4 at 0xffff90017170 of type 0 (in ltt=
ng_ht_new() at ../../../../lttng-tools-2.11.5/src/common/hashtable/hashtabl=
e.c:145) =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG3 - 10:53:52=
.130619625 [9674/9735]: Created hashtable size 4 at 0xffff900175b0 of type =
1 (in lttng_ht_new() at ../../../../lttng-tools-2.11.5/src/common/hashtable=
/hashtable.c:145) =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG2 - 10=
:53:52.130666000 [9674/9735]: Trace UST channel channel0 created (in trace_=
ust_create_channel() at ../../../../lttng-tools-2.11.5/src/bin/lttng-sessio=
nd/trace-ust.c:396) =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG=
2 - 10:53:52.130713625 [9674/9735]: Channel channel0 is being created for U=
ST with buffer 1 and id 0 (in channel_ust_create() at ../../../../lttng-too=
ls-2.11.5/src/bin/lttng-sessiond/channel.c:461) =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG2 - 10:53:52.130762250 [9674/9735=
]: Channel channel0 created successfully (in channel_ust_create() at ../../=
../../lttng-tools-2.11.5/src/bin/lttng-sessiond/channel.c:500) =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>DEBUG2 - 10=
:53:52.130807500 [9674/9735]: Trace UST channel channel0 found by name (in =
trace_ust_find_channel_by_name() at ../../../../lttng-tools-2.11.5/src/bin/=
lttng-sessiond/trace-ust.c:192) =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<br>DEBUG2 - 10:53:52.130851750 [9674/9735]: Trace UST event lt=
tng_ust_tracef:* NOT found (in trace_ust_find_event() at ../../../../lttng-=
tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:235) =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0<br>DEBUG2 - 10:53:52.130896500 [9674/9735]: Trace UST event lt=
tng_ust_tracef:*, loglevel (0,-1) created (in trace_ust_create_event() at .=
./../../../lttng-tools-2.11.5/src/bin/lttng-sessiond/trace-ust.c:517) =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0<br>DEBUG1 - 10:53:52.130968375 [9674/9735]: Sending response (size: 20,=
 retcode: Success (10)) (in thread_manage_clients() at ../../../../lttng-to=
ols-2.11.5/src/bin/lttng-sessiond/client.c:2236) =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0<br>DEBUG1 - 10:53:52.134962250 [9674/9735]: Clean comman=
d context structure (in clean_command_ctx() at ../../../../lttng-tools-2.11=
.5/src/bin/lttng-sessiond/client.c:659)<br></span></div><div><span style=3D=
"font-family:monospace"><br></span></div><div><span style=3D"font-family:mo=
nospace">Not quite sure what to do about that.</span></div><div><span style=
=3D"font-family:monospace"><br></span></div><div><span style=3D"font-family=
:monospace">Regards,</span></div><div><span style=3D"font-family:monospace"=
><br></span></div><div><span style=3D"font-family:monospace">Brian<br></spa=
n></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, Apr 25, 2023 at 12:56=E2=80=AFAM Brian Hutchinson &lt;<a hr=
ef=3D"mailto:b.hutchman@gmail.com">b.hutchman@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div>So instructions for tracef just say to link in lttng-ust=
, not dl, I didn&#39;t use liblttng-ust.a so maybe I misspoke.</div><div><b=
r></div><div><a href=3D"https://lttng.org/docs/v2.11/#doc-tracef" target=3D=
"_blank">https://lttng.org/docs/v2.11/#doc-tracef</a></div><div><br></div><=
div>... so that&#39;s what I did.</div><div><br></div><div>When I compile i=
n a tracepoint with trace provider, I link in lttng-ust and dl.=C2=A0 I&#39=
;m assuming you can mix both tracef and tracepoint calls?</div><div><br></d=
iv><div>I included a lttng-sessiond -vvv log in original post.=C2=A0 Are at=
tachments allowed or should I have posted the context as a plain text post?=
=C2=A0 It&#39;s quite big.</div><div><br></div><div>When I do lttng start, =
my app is already running via systemd at startup.=C2=A0 Do I need to disabl=
e that and start the executable manually after enabling the lttng ust event=
s?</div><div><br></div><div>Like I said, kernel trace is working fine, it&#=
39;s UST that appears to not be working for some reason.=C2=A0 I have less =
experience with UST but I&#39;ve been researching and searching archives an=
d I see others complaining about what looks to be my problem but either don=
&#39;t see a solution or maybe I just don&#39;t understand it.<br></div><di=
v><br></div><div>Thanks,</div><div><br></div><div>Brian<br></div></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Ap=
r 25, 2023 at 12:13=E2=80=AFAM Yitschak, Yehuda &lt;<a href=3D"mailto:yehud=
ay@amazon.com" target=3D"_blank">yehuday@amazon.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div>





<div lang=3D"EN-US">
<div>
<p class=3D"MsoNormal">It might be related to the static linking of lttng-u=
st<br>
<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/2018-January/027705.=
html" target=3D"_blank">https://lists.lttng.org/pipermail/lttng-dev/2018-Ja=
nuary/027705.html</a><br>
<br>
<u></u><u></u></p>
<p class=3D"MsoNormal">I also went down that path just to figure it=E2=80=
=99s not supported.<u></u><u></u></p>
<p class=3D"MsoNormal">Perhaps lttng documentation should be updated to mak=
e a clear note static linking is not supported (or maybe I missed it)<br>
<br>
<u></u><u></u></p>
<p class=3D"MsoNormal">Yehuda <br>
<br>
<u></u><u></u></p>
<div style=3D"border-color:currentcolor currentcolor currentcolor blue;bord=
er-style:none none none solid;border-width:medium medium medium 1.5pt;paddi=
ng:0cm 0cm 0cm 4pt">
<div>
<div>
<div>
<p class=3D"MsoNormal">Hi,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;m on an embedded platform, i.MX8 using Lttng 2=
.11 with 5.6.69 kernel.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Tracing kernel events with lttng works fine but user=
space (tracef and trace provider type tracing) appears to have an issue I c=
an&#39;t figure out.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">systemd is starting up my application ( a bunch of p=
rocesses and threads on multiple cpu&#39;s) on boot.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;m statically compiling and linking in lttng-us=
t.=C2=A0 If I use just tracef type tracing, when I do lttng list --userspac=
e I get nothing.=C2=A0 If I add in a trace provider and a tracepoint, then =
I see my trace provider tracepoint and:<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;c=
olor:black;background:white">=C2=A0=C2=A0=C2=A0=C2=A0 lttng_ust_tracelog:TR=
ACE_DEBUG (loglevel: TRACE_DEBUG (14)) (type: tracepoint)
</span><span style=3D"font-family:&quot;Courier New&quot;"><br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_LINE (loglevel=
: TRACE_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (logl=
evel: TRACE_DEBUG_FUNCTION (12)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_UNIT (loglevel=
: TRACE_DEBUG_UNIT (11)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_MODULE (loglev=
el: TRACE_DEBUG_MODULE (10)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_PROCESS (logle=
vel: TRACE_DEBUG_PROCESS (9)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (logle=
vel: TRACE_DEBUG_PROGRAM (8)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (loglev=
el: TRACE_DEBUG_SYSTEM (7)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_INFO (loglevel: TRAC=
E_INFO (6)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_NOTICE (loglevel: TR=
ACE_NOTICE (5)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_WARNING (loglevel: T=
RACE_WARNING (4)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_ERR (loglevel: TRACE=
_ERR (3)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_CRIT (loglevel: TRAC=
E_CRIT (2)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_ALERT (loglevel: TRA=
CE_ALERT (1)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracelog:TRACE_EMERG (loglevel: TRA=
CE_EMERG (0)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_tracef:event (loglevel: TRACE_DEBUG=
 (14)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:unload (loglevel: TRACE_DEBUG_L=
INE (13)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:debug_link (loglevel: TRACE_DEB=
UG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:build_id (loglevel: TRACE_DEBUG=
_LINE (13)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_lib:load (loglevel: TRACE_DEBUG_LIN=
E (13)) (type: tracepoint) <br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:end (loglevel: TRACE_DEBU=
G_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:debug_link (loglevel: TRA=
CE_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:build_id (loglevel: TRACE=
_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:bin_info (loglevel: TRACE=
_DEBUG_LINE (13)) (type: tracepoint)
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lttng_ust_statedump:start (loglevel: TRACE_DE=
BUG_LINE (13)) (type: tracepoint)</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
When I do lttng start, I get a directory structure in the trace directory b=
ut the file sizes do not ever increase.=C2=A0 It&#39;s just a directory str=
ucture with files created and then that&#39;s it, no events
 being written to the files.=C2=A0 At first I thought things just weren&#39=
;t linked in right and not working but then discovered how to run lttng-ses=
siond in -vvv mode and then could see lots of things are going on, tracing =
appears to be trying to work as there is
 tons of activity being output by lttng-sessiond, but like I said the trace=
 files aren&#39;t being added to.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
I looked at the lttng-sessiond log I captured and can&#39;t quite make out =
the problem so attaching it.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
I&#39;m probably not doing something right but can&#39;t figure out what th=
at is so any pointers appreciated.</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Regards,</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Brian</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>

</div></blockquote></div></div>
</blockquote></div>

--000000000000ae172d05fa284932--

--===============7013215603572134866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7013215603572134866==--
