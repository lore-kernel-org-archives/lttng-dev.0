Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F4AE936ED
	for <lttng-dev@archiver.kernel.org>; Wed,  4 Oct 2023 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696461650;
	bh=aWT1fRXz6s4RpnFyd5ewLchrVnyf350mdJW3T/oqYis=;
	h=In-Reply-To:References:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=YXBgXvxfOrGtKQ22Y1OKIsz3+8xCugPcrIMs5dfpmLvt+ctagmndibHv1X1Y44XeK
	 8a+Am574Ps+1VmsDE5EAfnc1BPzUP1SvkR9KZreX4phcLp+CkK1k2emxO6mSLG3Myt
	 XusrAtTIGn36AK42QPE8xqRsQJjrZB67tsWsLO48Pd04YdpzxkdDdZVqEC6cgjK4XW
	 NvicKPhiztw/+U6PmnMTNJqwMOYV5wEfWZF8dKvWitzCT0iHci0auJEVILyQjyHlBV
	 hDsM6ywn26mFOQFnxgq3A5WYNyNX5HRg4rDSWJauTSNMwa5cs9aMB1ZTUVhyTGbaaX
	 /+zPg/yfd9cFQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S19fV0b17z2rrH;
	Wed,  4 Oct 2023 19:20:50 -0400 (EDT)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by lists.lttng.org (Postfix) with ESMTPS id 4S19fT2Q5dz2sm5
 for <lttng-dev@lists.lttng.org>; Wed,  4 Oct 2023 19:20:48 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id F3B265C0356;
 Wed,  4 Oct 2023 19:13:02 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
 by compute2.internal (MEProxy); Wed, 04 Oct 2023 19:13:02 -0400
X-ME-Sender: <xms:fvEdZUw-MkNBbbRlLDrkx0DXCFncWDtk9XzS36-gLRlXjZCrhFvHeQ>
 <xme:fvEdZYTqYl6dPOPmtVaCw9UR4jQ-e1z1gdVSYdR5jpZ-DDwAJ38nbe2LTLFABkoFc
 _-uak76GyVds6qlog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeefgddulecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhi
 shhtohhphhgvrhcujfgrrhhvvgihfdcuoegthhhrihhssegtfihhrghrvhgvhidrtggrqe
 enucggtffrrghtthgvrhhnpeeghfelleeigfehvdegveduhfduheetuefgleekhfdtveet
 leehhedttdefveevueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhprghsthgvsg
 hinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpegthhhrihhssegtfihhrghrvhgvhidrtggr
X-ME-Proxy: <xmx:fvEdZWXK4K-H2FDhLZjWs6hE3k9nN8rLwG67sGdSxPtq938EwP37yA>
 <xmx:fvEdZShXjEhSC8K4_LYurSb0wsn8lOEJpMky0EdME7NOqdrGpg6n4Q>
 <xmx:fvEdZWDQMj_TGe4Hqs5sDhxgPAoQIMlpLckO9Yz1jK8_0I8xKPnj6g>
 <xmx:fvEdZd9pQOtBTSFmB-yXiH7MKX2YaJJZ9CK6M1wmwhFP1HUqbdlRMQ>
Feedback-ID: i2d19425f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id B1FC1BC007C; Wed,  4 Oct 2023 19:13:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <db8dd95b-55ca-4259-bcc6-db145e0ad05d@app.fastmail.com>
In-Reply-To: <2795ad9b-acbd-460a-bfcb-61f0101180d4@efficios.com>
References: <0c1fcf2c-c061-4074-a20e-44b870fbeef5@app.fastmail.com>
 <2795ad9b-acbd-460a-bfcb-61f0101180d4@efficios.com>
Date: Wed, 04 Oct 2023 19:12:40 -0400
To: "Kienan Stewart" <kstewart@efficios.com>, lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] What is DEFINE_LTTNG_UST_SIGBUS_STATE for and other
 beginner questions
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
From: Christopher Harvey via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Christopher Harvey <chris@cwharvey.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Oct 4, 2023, at 3:04 PM, Kienan Stewart wrote:
> Hi Chris,
>
> On 2023-10-04 12:56, Christopher Harvey via lttng-dev wrote:
>> Hi all,
>> 
>> I'm just getting started with lttng and have a couple of questions. My target is getting userspace tracepoints to work in a c++ application I control. I don't need kernel or system tracing. The target is running in a docker container I have control over as well. Running with --privileged is possible in my setup. I could run lttng inside the target container, outside on the host, or in another container on the same host. It's all the same to me. I don't know which setup is best, or if it even matters given that I don't need system or kernel traces.
>> 
>> I am using:
>> lttng-tools-2.13.11/      and       lttng-ust-2.13.6/
>> with userspace-rcu-0.14.0/
>> 
>> There is a slight version mismatch there, I just downloaded the "-lastest" from the links in the guide.
>> 
>> Here is my tracepoint provider header:
>> -----
[SNIP]
>> --------
>> 
>> and the cpp:
>> -------
[SNIP]
>> ----
>> 
>> I'm suspicious of a couple of things in my setup.
>> 
>> First, if I omit the DEFINE_LTTNG_UST_SIGBUS_STATE(); line, my program fails to compile with the following error:
>> liblttng-ust-ctl.so: undefined reference to `lttng_ust_sigbus_state'
>> 
>
> I wasn't able to reproduce the compilation error you are seeing. Could 
> you describe in more detail how you are compiling and linking your 
> tracepoint provider and application?

I just create a .o from the tracepoint provider compilation unit. I'm not making shared libraries or anything like that. More on this below.

>> The getting started guide doesn't say anything about needing DEFINE_LTTNG_UST_SIGBUS_STATE so it makes me wonder if I have done something else wrong somewhere else. I ran a find *.so | xargs nm -D | grep lttng_ust_sigbus_state and nothing in lttng-ust provides that symbol, so it looks like the target application has to define it. Is that normal?
>> 
>
> If the application is actually using liblttng-ust-ctl, then it would be 
> normal to do the define. The header file explains that this is done to 
> avoid unnecessarily pre-allocating space in the thread-local storage.
> https://github.com/lttng/lttng-ust/blob/master/include/lttng/ust-sigbus.h#L39
>
> Traced applications typically don't link against liblttng-ust-ctl.
>

This ended up being one of the main problems. My final linking flags are
-llttng-ust -llttng-ust-common -llttng-ust-tracepoint
I didn't have a particular reason for linking against liblttng-ust-ctl before. It was a mistake.

>> If I leave DEFINE_LTTNG_UST_SIGBUS_STATE in then my program compiles. If I run lttng-sessiond in the target container, then run lttng list --userspace I see no tracepoints in the list.
>> 
>
> Is your application actively running while you run `lttng list --userspace`?

yes

I was reading some lttng-sessiond source code and discovered -vvv as well as LTTNG_UST_DEBUG.

I'm still not seeing the tracepoints show up in lttng list --userspace, but I found more hints as to why.
Here is some output from my target application:
 liblttng_ust[454/467]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1884)
liblttng_ust[454/467]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1758

These prints only happen periodically when lttng-sessiond is running. If I stop lttng-sessiond then the prints stop so there is clearly some communication happening. Apparently this gets printed when there is an ECONNREFUSED from lttng-sessiond. I haven't gotten much further than that right now. I have pasted the output from sessiond -vvv here:

https://pastebin.com/raw/ayJJ2J9p

thank you for your time,
Chris
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
